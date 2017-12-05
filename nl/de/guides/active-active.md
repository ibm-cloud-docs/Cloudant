---

copyright:
  years: 2017
lastupdated: "2017-05-22"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-05-22 -->

# Cloudant für regionsübergreifende Disaster-Recovery konfigurieren

Im [{{site.data.keyword.cloudant_short_notm}}-Leitfaden zur Disaster-Recovery](disaster-recovery-and-backup.html)
wird erläutert, dass eine Möglichkeit, die Disaster-Recovery zu aktivieren, darin besteht,
mithilfe von {{site.data.keyword.cloudantfull}}-Replikation regionsübergreifende Redundanz zu erzeugen. 

Sie können Replikation in {{site.data.keyword.cloudant_short_notm}} mithilfe einer rechenzentrumsübergreifenden Aktiv/Aktiv-
oder Aktiv/Passiv-Topologie konfigurieren. 

Das folgende Diagramm zeigt eine typische Konfiguration, die zwei {{site.data.keyword.cloudant_short_notm}}-Kontos verwendet - eines in jeder Region: 

![Beispiel einer Aktiv/Aktiv-Architektur](../images/active-active.png)

Denken Sie daran:

* In jedem Rechenzentrum stellt
  {{site.data.keyword.cloudant_short_notm}} bereits Hochverfügbarkeit
  durch das dreifache Speichern von Daten auf drei Servern bereit. 
* Replikation erfolgt auf Datenbank- statt Kontoebene
  und muss explizit konfiguriert werden. 
* {{site.data.keyword.cloudant_short_notm}} bietet keine Service-Level-Agreements (SLAs)
  oder Gewissheiten zur Replikationslatenz. 
* {{site.data.keyword.cloudant_short_notm}} überwacht nicht einzelne Replikationen.
  Es wird empfohlen, eine eigene Strategie zur Erkennung fehlgeschlagener Replikationen und deren Neustart zu entwickeln und umzusetzen. 

## Vorbereitende Schritte

> **Hinweis**: Bei einer Aktiv/Aktiv-Bereitstellung
  muss eine Strategie zur Verwaltung von Konflikten implementiert sein.
  Stellen Sie deshalb sicher, dass Sie verstehen, wie [Replikation](../api/replication.html) und
  [Konflikte](mvcc.html#distributed-databases-and-conflicts) funktionieren, bevor Sie
  diese Architektur in Betracht ziehen. 

Wenden Sie sich an den [{{site.data.keyword.cloudant_short_notm}}-Support ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](mailto:support@cloudant.com){:new_window},
wenn Sie Hilfe beim Modellieren von Daten zum effektiven Lösen von Problemen brauchen. 

## Übersicht

Im Folgenden wird eine bidirektionale Replikation erstellt.
Diese Konfiguration lässt zu, dass zwei Datenbanken in einer Aktiv/Aktiv-Topologie arbeiten. 

Die Konfiguration setzt zwei Konten in verschiedenen Regionen voraus: 

* `myaccount-dc1.cloudant.com`
* `myaccount-dc2.cloudant.com`

Sind diese Konten eingerichtet,
sind die grundlegenden Schritte wie folgt: 

1. [Erstellen](#step-1-create-your-databases) eines Paars von gleichgeordneten Datenbanken innerhalb der Konten. 
2. [Einrichten](#step-2-create-an-api-key-for-your-replications) von API-Schlüsseln für die Replikation zwischen diesen Datenbanken. 
3. Erteilen entsprechender Berechtigungen. 
4. Einrichten von Replikationen. 
5. Testen von Replikationen auf ordnungsgemäße Funktionsweise. 
6. Konfigurieren von Anwendung und Infrastruktur für Aktiv/Aktiv- oder Aktiv/Passiv-Verwendung der Datenbanken. 

## Schritt 1: Erstellen Sie Ihre Datenbanken. 

[Erstellen Sie die Datenbanken](../api/database.html#create), die Sie zwischen den einzelnen Konten replizieren möchten. 

In diesem Beispiel wird eine Datenbank namens `mydb` erstellt. 

Die Namen, die für die Datenbanken in diesem Beispiel verwendet werden, sind nicht wichtig. Aber es macht die kommenden Dinge einfacher, wenn Sie denselben Namen verwenden. 

```sh
curl https://myaccount-dc1.cloudant.com/mydb -XPUT -u myaccount-dc1
curl https://myaccount-dc2.cloudant.com/mydb -XPUT -u myaccount-dc2
```
{:codeblock}

## Schritt 2: Erstellen Sie einen API-Schlüssel für Ihre Replikationen. 

Es ist eine gute Idee, einen [API-Schlüssel](../api/authorization.html#api-keys) für fortlaufende Replikationen zu verwenden.
Der Vorteil ist, wenn sich Ihre primären Kontodetails ändern, z. B. nach dem Zurücksetzen des Kennworts, können Ihre Replikationen unverändert fortgeführt werden. 

API-Schlüssel sind nicht an ein einziges Konto gebunden. Dies bedeutet, dass ein einzelner API-Schlüssel erstellt werden kann und dass ihm dann passende Datenbankberechtigungen für beide Konten zugewiesen werden können. 

Der folgende Befehl fordert beispielsweise einen API-Schlüssel für das Konto `myaccount-dc1` an: 

```sh
$ curl -XPOST https://myaccount-dc1.cloudant.com/_api/v2/api_keys -u myaccount-dc1
```
{:codeblock}

Eine erfolgreiche Antwort entspricht dem folgenden abgekürzten Beispiel: 

```json
{
  "password": "YPN...Tfi",
  "ok": true,
  "key": "ble...igl"
}
```
{:codeblock}

> **Hinweis**: Notieren Sie sich das Kennwort.
  Es ist nicht möglich, das Kennwort zu einem späteren Zeitpunkt abzurufen. 

### Schritt 3: Erteilen Sie Zugriffsberechtigungen. 

[Weisen Sie dem API-Schlüssel](../api/authorization.html#modifying-permissions)
Lese- und Schreibberechtigungen für beide Datenbanken zu. 

Wenn Sie auch Indizes replizieren möchten, weisen Sie Administratorberechtigungen zu. 

Verwenden Sie das {{site.data.keyword.cloudant_short_notm}}-Dashboard oder lesen Sie
alternativ in den [Berechtigungsinformationen](../api/authorization.html) nach, wie
Berechtigungen programmgesteuert erteilt werden. 

### Schritt 4: Richten Sie Replikationen ein. 

Replikationen in {{site.data.keyword.cloudant_short_notm}} sind immer unidirektional:
von einer Datenbank in eine andere.
Um bidirektional zwischen Datenbanken zu replizieren,
sind deshalb zwei Replikationen erforderlich. Eine für jede Richtung. 

In jedem Konto, das den [zuvor](#step-2-create-an-api-key-for-your-replications) erstellten API-Schlüssel verwendet, wird eine Replikation erstellt. 

Erstellen Sie zunächst eine Replikation von der Datenbank `myaccount-dc1.cloudant.com/mydb` in die Datenbank `myaccount-dc2.cloudant.com/mydb`. 

```sh
curl -XPOST 'https://myaccount-dc1.cloudant.com/_replicator'
	-u myaccount-dc1
	-H 'Content-type: application/json'
	-d '{ "_id": "mydb-myaccount-dc1-to-myaccount-dc2",
	"source": "https://ble...igl:YPN...Tfi@myaccount-dc1.cloudant.com/mydb",
	"target": "https://ble...igl:YPN...Tfi@myaccount-dc2.cloudant.com/mydb",
	"continuous": true
}'
```
{:codeblock}

Erstellen Sie anschließend eine Replikation von der Datenbank `myaccount-dc2.cloudant.com/mydb` in die Datenbank `myaccount-dc1.cloudant.com/mydb`. 

```sh
curl -XPOST 'https://myaccount-dc2.cloudant.com/_replicator'
	-u myaccount-dc2
	-H 'Content-type: application/json'
	-d '{ "_id": "mydb-myaccount-dc2-to-myaccount-dc1",
	"source": "https://ble...igl:YPN...Tfi@myaccount-dc2.cloudant.com/mydb",
	"target": "https://ble...igl:YPN...Tfi@myaccount-dc1.cloudant.com/mydb",
	"continuous": true
}'
```
{:codeblock}

> **Hinweis:** Schlägt dieser Schritt fehl, weil die Datenbank `_replicator` nicht vorhanden ist, erstellen Sie sie. 

### Schritt 5: Testen Sie Ihre Replikation. 

Testen Sie die Replikationsprozesse, indem Sie Dokumente in beiden Datenbanken erstellen, ändern oder löschen. 

Prüfen Sie nach jeder Änderung in einer Datenbank, dass Sie die Änderung auch in der anderen Datenbank widergespiegelt sehen. 

### Schritt 6: Konfigurieren Sie Ihre Anwendung. 

An diesem Punkt werden die Datenbanken so konfiguriert, dass sie synchronisiert bleiben. 

Die nächste Entscheidung betrifft, ob die Datenbanken in einer
[Aktiv/Aktiv](#active-active)- oder [Aktiv/Passiv](#active-passive)-Weise verwendet werden sollen. 

#### Aktiv/Aktiv

In einer Aktiv/Aktiv-Konfiguration können
unterschiedliche Anwendungsinstanzen in verschiedene Datenbanken schreiben. 

Beispiel: Anwendung 'A' schreibt möglicherweise in die Datenbank `myaccount-dc1.cloudant.com/mydb`,
während die Anwendung 'B' in die Datenbank `myaccount-dc2.cloudant.com/mydb` schreibt. 

Diese Konfiguration bietet mehrere Vorteile: 

- Die Arbeitslast kann über mehrere Konten verteilt werden. 
- Anwendungen können für den Zugriff auf ein Konto mit
  einer geringeren Latenz (nicht immer das geografisch nächste Konto) konfiguriert werden. 

Eine Anwendung kann für die Kommunikation mit dem nächstgelegenen
Cloudant-Konto konfiguriert werden.
Für Anwendungen, die in DC1 gehostet sind, sollten Sie die {{site.data.keyword.cloudant_short_notm}}-URL auf `"https://myaccount-dc1.cloudant.com/mydb"` festlegen.
Entsprechend sollten Sie für Anwendungen, die in DC2 gehostet sind, die Cloudant-URL auf `"https://myaccount-dc2.cloudant.com/mydb"` festlegen. 

#### Aktiv/Passiv

In einer Aktiv/Passiv-Konfiguration werden alle Instanzen einer Anwendung für die Verwendung einer primären Datenbank konfiguriert.
Die Anwendung kann jedoch einen Failover zur anderen Sicherungsdatenbank durchführen, falls die Umstände es erforderlich machen.
Die Failoverfunktionalität kann unter anderem in der Anwendungslogik selbst oder mithilfe einer Lastausgleichsfunktion implementiert werden. 

Ein einfacher Test, ob ein Failover erforderlich ist, wäre die Verwendung des Hauptdatenbankendpunkts als eine Art Überwachungssignal.
Zum Beispiel gibt eine einfache `GET`-Anforderung, die an den Hauptdatenbankendpunkt gesendet wird, normalerweise
[Details über die Datenbank](../api/database.html#getting-database-details) zurück.
Wird keine Antwort empfangen, kann dies ein Hinweis darauf sein, dass ein Failover erforderlich ist. 

#### Andere Konfigurationen

Sie können auch andere Hybridansätze für Ihre Konfiguration in Betracht ziehen. 

In einer 'Write-Primary, Read-Replica'-Konfiguration werden alle Schreiboperationen in einer Datenbank ausgeführt,
aber die Lesearbeitslast wird über die Replikate verteilt. 

### Schritt 7: Nächste Schritte. 

* Ziehen Sie die Überwachung der [Replikationen](../api/advanced_replication.html) zwischen den Datenbanken in Betracht.
  Verwenden Sie die Daten, um festzustellen, ob Ihre Konfiguration weiter optimiert werden kann. 
*	Bedenken Sie, wie Ihre Entwurfsdokumente und Indizes implementiert und aktualisiert werden.
  Möglicherweise wäre eine Automatisierung dieser Tasks sinnvoll. 

## Failover zwischen Cloudant-Regionen

Typischerweise wird der Prozess der Verwaltung eines Failovers zwischen Regionen oder Rechenzentren weiter oben in Ihrem Anwendungsstack ausgeführt,
z. B. durch die Konfiguration von Änderungen des Anwendungsserver-Failovers oder durch einen Lastausgleich. 

{{site.data.keyword.cloudant_short_notm}} stellt keine Funktionalität für die explizite Verwaltung eines Failovers oder für das Weiterleiten von Anforderungen zwischen Regionen bereit.
Diese Einschränkung existiert teils aus technischen Gründen, teils weil die Bedingungen, unter denen ein Failover auftritt, üblicherweise anwendungsspezifisch sind.
Beispielsweise könnten Sie einen Failover in Antwort auf eine angepasste Leistungsmetrik erzwingen. 

Wenn Sie sich jedoch für eine Funktionalität zum Verwalten von Failover entscheiden,
haben Sie unter anderem folgende Optionen: 

* Schalten Sie Ihren eigenen [HTTP-Proxy vor {{site.data.keyword.cloudant_short_notm}} ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://cloudant.com/blog/green-man-gaming-cross-cloud-nginx-config/){:new_window}.
  Konfigurieren Sie Ihre Anwendung für die Kommunikation mit dem Proxy anstelle der {{site.data.keyword.cloudant_short_notm}}-Instanz.
  Dies bedeutet, dass das Ändern der {{site.data.keyword.cloudant_short_notm}}-Instanzen,
  die von Anwendungen verwendet werden, über eine Änderung der Proxykonfiguration statt über eine Änderung der Anwendungseinstellungen
  erfolgen kann.
  Viele Proxys bieten einen Lastausgleich auf der Grundlage von benutzerdefinierten Statusprüfungen. 
* Verwenden Sie eine globale Lastausgleichsfunktion wie [Traffic Director ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://dyn.com/traffic-director/){:new_window}, um zu {{site.data.keyword.cloudant_short_notm}} weiterzuleiten.
  Diese Option erfordert eine `CNAME`-Definition, die auf Basis einer Statusprüfung oder einer Latenzregel an verschiedene {{site.data.keyword.cloudant_short_notm}}-Konten weiterleitet. 

## Wiederherstellung nach Failover

Wenn eine einzelne {{site.data.keyword.cloudant_short_notm}}-Instanz nicht erreicht werden kann,
vermeiden Sie das Weiterleiten von Datenverkehr zurück zu dieser Instanz, sobald sie wieder verfügbar ist.
Der Grund dafür ist, dass intensive Tasks wie das Synchronisieren des Datenbankstatus von Peers und das Sicherstellen, dass Indizes aktuell sind, einige Zeit in Anspruch nehmen. 

Es ist hilfreich, einen Mechanismus für die Überwachung dieser Tasks einzusetzen, der Sie dabei unterstützt, zu entscheiden, wann eine Datenbank wieder in der Lage ist, Ihren Produktionsdatenverkehr zu verarbeiten. 

Zu den typischen Prüfungen gehören unter anderem die folgenden: 

* [Replikationen](#replications)
* [Indizes](#indexes)

> **Hinweis:** Wenn Sie ein Weiterleiten von Anforderungen oder einen Failover auf der Grundlage einer Statusprüfung implementieren,
  können Sie entsprechende Prüfungen einbauen, um ein verfrühtes Weiterleiten zurück an eine Serviceinstanz, die noch in Wiederherstellung begriffen ist, zu vermeiden. 

### Replikationen

* Haben Replikationen einen Fehlerstatus?
* Müssen Replikationen erneut gestartet werden?
* Wie viele anstehende Änderungen müssen noch in die Datenbank repliziert werden?

Weitere Informationen zur [Überwachung des Replikationsstatus](../api/advanced_replication.html#replication-status)
sind verfügbar. 

> **Hinweis:** Wenn eine Datenbank kontinuierlich geändert wird,
  ist der Replikationsstatus mit hoher Wahrscheinlichkeit ungleich 0.
  Sie müssen entscheiden, welcher Statusschwellenwert akzeptabel ist und welcher einen Fehlerstatus darstellt. 

### Indizes

* Sind die Indizes ausreichend aktuell?
  Überprüfen Sie dies mithilfe des Endpunkts für [aktive Tasks](../api/active_tasks.html). 
* Testen Sie das Maß der "Indexbereitschaft", indem Sie eine Abfrage an den Index senden und entscheiden,
  ob sie innerhalb einer zulässigen Zeit zurückgegeben wird. 
