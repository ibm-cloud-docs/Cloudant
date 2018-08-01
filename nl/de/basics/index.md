---

copyright:
  years: 2015, 2018
lastupdated: "2018-02-15"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# {{site.data.keyword.cloudant_short_notm}}-Grundlagen

Wenn Sie zum ersten Mal hier sind, lesen Sie diesen Abschnitt, bevor Sie weiter blättern.
{:shortdesc}

Die Abschnitte [Clientbibliotheken](../libraries/index.html#-client-libraries),
[API-Referenz](../api/index.html#-api-reference) und
[Leitfäden](../guides/acurl.html#authorized-curl-acurl-) setzen grundlegende Kenntnisse zu {{site.data.keyword.cloudantfull}} voraus.

## Verbindung zu {{site.data.keyword.cloudant_short_notm}} herstellen

Für den Zugriff auf {{site.data.keyword.cloudant_short_notm}} müssen Sie entweder über ein [{{site.data.keyword.cloudant_short_notm}}-Konto](../api/account.html) oder ein [{{site.data.keyword.Bluemix}}-Konto](../offerings/bluemix.html) verfügen.

## HTTP-API

Alle Anforderungen an {{site.data.keyword.cloudant_short_notm}} werden über das Web übermittelt.
Dies bedeutet, dass alle Systeme, die über das Web kommunizieren, auch {{site.data.keyword.cloudant_short_notm}} verwenden können.
Alle sprachspezifischen Bibliotheken für {{site.data.keyword.cloudant_short_notm}} sind letztlich nur Wrapper,
die Ihre Arbeit mit einer simplen API komfortabler und sprachlich einfacher gestalten.
Viele Benutzer möchten unformatierte HTTP-Bibliotheken für die Arbeit mit {{site.data.keyword.cloudant_short_notm}} verwenden.

Genaue Details zur Verwendung von HTTP in {{site.data.keyword.cloudant_short_notm}} finden Sie im
Thema [HTTP](../api/http.html) der API-Referenz.

{{site.data.keyword.cloudant_short_notm}} unterstützt die folgenden HTTP-Anforderungsmethoden:

-   `GET`

    Anfordern des angegebenen Elements.
    Wie bei normalen HTTP-Anforderungen definiert das Format der URL, was zurückgegeben wird.
    Bei {{site.data.keyword.cloudant_short_notm}} kann dies statische Elemente,
    Datenbankdokumente und
    Konfigurations- sowie statistische Informationen einschließen.
    In den meisten Fällen werden die Informationen in Form eines JSON-Dokuments zurückgegeben.

-   `HEAD`

    Die Methode `HEAD` wird verwendet, um den HTTP-Header einer `GET`-Anforderung ohne den Hauptteil der Antwort abzurufen.

-   `POST`

    Hochladen von Daten.
    In der API von {{site.data.keyword.cloudant_short_notm}} wird die
    Methode `POST` verwendet, um Werte festzulegen,
    Dokumente hochzuladen,
    Dokumentwerte festzulegen
    und einige Verwaltungsbefehle zu starten.

-   `PUT`

    Speichern einer bestimmten Ressource.
    In der API von {{site.data.keyword.cloudant_short_notm}}
    wird `PUT` verwendet, um neue Objekte zu erstellen,
    darunter Datenbanken,
    Dokumente,
    Ansichten
    und Entwurfsdokumente.

-   `DELETE`

    Löscht die angegebene Ressource, z. B. Dokumente, Ansichten und Entwurfsdokumente.

-   `COPY`

    Eine spezielle Methode zum Kopieren von Dokumenten und Objekten.

Wenn der Client (z. B. einige Web-Browser) diese HTTP-Methoden nicht unterstützen,
kann `POST` stattdessen mit dem Anforderungsheader `X-HTTP-Method-Override` verwendet werden, der auf die tatsächliche HTTP-Methode festgelegt ist.

### Fehler aufgrund unzulässiger Methode

Wenn Sie einen nicht unterstützten HTTP-Anforderungstyp mit einer URL verwenden,
wird der Fehler [405](../api/http.html#405) zurückgegeben, der die unterstützten HTTP-Methoden wie im folgenden
Beispiel gezeigt auflistet.

_Beispiel einer Fehlernachricht als Antwort auf eine nicht unterstützte Anforderung:_

```json
{
    "error":"method_not_allowed",
    "reason":"Only GET,HEAD allowed"
}
```
{:codeblock}

## JSON
{: #json}

{{site.data.keyword.cloudant_short_notm}} speichert Dokumente mithilfe von JSON-Codierung (JavaScript Object Notation),
deshalb können alle in JSON codierten Elemente als Dokument gespeichert werden.
Dateien, die Medien wie Bilder,
Videos und Audios enthalten,
werden als BLOBs (Binary Large OBjects) bezeichnet
und können als diesen Dokumenten zugeordnete Anhänge gespeichert werden.

Weitere Informationen zu JSON finden Sie im [JSON-Leitfaden](../guides/json.html).

<div id="distributed"></div>

## Verteilte Systeme

Mithilfe der API von {{site.data.keyword.cloudant_short_notm}} können Sie mit einem Zusammenschluss zahlreicher Systeme,
auch Cluster genannt, interagieren.
Die Systeme in einem Cluster müssen sich zwar im selben Rechenzentrum befinden, können aber in unterschiedlichen Pods in diesem Rechenzentrum untergebracht sein.
Der Einsatz unterschiedlicher Pods verbessert die Hochverfügbarkeitsmerkmale von {{site.data.keyword.cloudant_short_notm}}.

Ein Vorteil des Clustering: Wenn Sie mehr Rechenleistung benötigen, fügen Sie einfach mehr Systeme hinzu.
Dies ist oft kostengünstiger und fehlertoleranter als die Skalierung nach oben oder die Erweiterung eines einzelnen vorhandenen Systems.

Weitere Informationen zu {{site.data.keyword.cloudant_short_notm}} und verteilten Systemkonzepten
finden Sie im Leitfaden [CAP-Theorem](../guides/cap_theorem.html).

## Replikation

[Replikation](../api/replication.html) ist ein Verfahren, das in {{site.data.keyword.cloudant_short_notm}},
[CouchDB ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://couchdb.apache.org/){:new_window},
[PouchDB ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://pouchdb.com/){:new_window}
und anderen verteilten Datenbanken eingesetzt wird.
Die Replikation synchronisiert den Status zweier Datenbanken, damit ihre Inhalte identisch sind.

Sie können fortlaufend replizieren.
Das bedeutet, dass eine Zieldatenbank jedes Mal aktualisiert wird, wenn sich die Quellendatenbank ändert.
Eine fortlaufende Replikation kann zum Sichern von Daten,
wobei Daten datenbankübergreifend aggregiert werden, und zum Teilen von Daten verwendet werden.

Allerdings bedeutet eine fortlaufende Replikation, dass kontinuierlich auf Änderungen der Quellendatenbank geprüft wird.
Diese Prüfung erfordert wiederholte interne Aufrufe, die sich auf die Leistung oder die Kosten für die Verwendung der Datenbank negativ auswirken können.

>   **Hinweis**: Eine fortlaufende Replikation kann zu einer hohen Anzahl interner Aufrufe führen.
    Dies kann sich negativ auf die Kosten für Multi-Tenant-Benutzer von {{site.data.keyword.cloudant_short_notm}}-Systemen auswirken.
    Eine fortlaufende Replikation ist standardmäßig inaktiviert.
