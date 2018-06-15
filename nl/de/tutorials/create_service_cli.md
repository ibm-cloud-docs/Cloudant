---

copyright:
  years: 2017, 2018
lastupdated: "2018-03-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# {{site.data.keyword.cloudant_short_notm}}-Instanz unter {{site.data.keyword.Bluemix_notm}} mithilfe der Cloud Foundry-Tools erstellen

In diesem Lernprogramm erfahren Sie, wie Sie eine {{site.data.keyword.cloudantfull}}-Serviceinstanz unter {{site.data.keyword.Bluemix}} mithilfe der Cloud Foundry-Tools erstellen.
{:shortdesc}

## Voraussetzungen

Bevor Sie dieses Lernprogramm starten,
müssen Sie die {{site.data.keyword.Bluemix_notm}} Cloud Foundry-Tools installieren.
Details zur Installation der Tools finden Sie in
[diesem separaten Lernprogramm](create_bmxapp_appenv.html#the-cloud-foundry-and-bluemix-command-toolkits).

> **Hinweis**: Stellen Sie sicher, dass Sie sowohl die Cloud Foundry-, _als auch_
  die {{site.data.keyword.Bluemix_notm}}-Toolkits installieren.

## {{site.data.keyword.Bluemix_notm}}-API-Endpunkt angeben

Geben Sie den Ziel-API-Endpunkt für Ihre Cloud-Foundry-Befehle an:

```sh
bx api https://api.ng.bluemix.net
```
{:codeblock}

Das Ergebnis bestätigt, dass Sie den Endpunkt korrekt angegeben haben:

```sh
Setting api endpoint to https://api.ng.bluemix.net...
OK

API endpoint: https://api.ng.bluemix.net (API version: 2.54.0)
Not logged in. Use 'bx login' to log in.
```
{:pre}

## Bei Ihrem {{site.data.keyword.Bluemix_notm}}-Konto anmelden

1.  Verwenden Sie den folgenden Befehl, um den Anmeldeprozess für
  Ihr {{site.data.keyword.Bluemix_notm}}-Konto zu starten:
  
  ```sh
  bx login
  ```
  {:codeblock}
  
  {{site.data.keyword.Bluemix_notm}} antwortet mit einer Erinnerung an den aktuellen
  API-Endpunkt und fragt dann nach der E-Mail-Adresse für Ihr Konto:
  
  ```sh
  API endpoint: https://api.ng.bluemix.net
  
  Email>
  ```
  {:pre}

2.  Geben Sie die E-Mail-Adresse Ihres Kontos ein.
  Dann fordert {{site.data.keyword.Bluemix_notm}} Sie zur Eingabe des Kennworts für Ihr Konto auf:
  ```sh
  API endpoint: https://api.ng.bluemix.net
  
  Email> J.Doe@email.com
  
  Password>
  ```
  {:pre}
  
  {{site.data.keyword.Bluemix_notm}} validiert Ihre Details
  und fasst dann die Informationen zu Ihrer Anmeldesitzung zusammen:
  ```sh
  API endpoint: https://api.ng.bluemix.net
  
  Email> J.Doe@email.com
  
  Password> 
  Authenticating...
  OK
  
  Targeted account J DOE's Account (707...a32)
  
  Targeted org J.Doe@email.com
  
  Targeted space dev
  
  API endpoint:   https://api.ng.bluemix.net (API version: 2.54.0)
  Region:         us-south
  User:           j.doe@email.com
  Account:        J DOE's Account (707...a32)
  Org:            J.Doe@email.com
  Space:          dev
  ```
  {:pre}

3.  Sie sind jetzt bei Ihrem {{site.data.keyword.Bluemix_notm}}-Konto angemeldet.

## {{site.data.keyword.cloudant_short_notm}}-Plan für Ihren Service auswählen

Rufen Sie eine Liste aller verfügbaren Serviceangebote ab.
Filtern Sie die Liste nach {{site.data.keyword.cloudant_short_notm}}-Services:

```sh
bx service offerings | grep -i Cloudant
```
{:codeblock}

Das Ergebnis ist eine Liste der {{site.data.keyword.cloudant_short_notm}}-Services, die
in Ihrem Konto zur Verfügung stehen, einschließlich der spezifischen Pläne, die Sie auswählen
können:

```sh
cloudantNoSQLDB   Lite, Standard*
```
{:pre}

**Optional**: Setzen Sie den folgenden Befehl ab,
um weitere Details zu den Plänen anzuzeigen:

```sh
bx cf marketplace -s cloudantNoSQLDB
```
{:codeblock}

Das Ergebnis ist eine Zusammenfassung der verfügbaren Pläne,
ähnlich dem folgenden Abschnitt einer Beispielantwort (Details haben den Stand Mai 2017):

```
Lite
Der Lite-Plan bietet Zugriff auf die vollständige Funktionalität von {{site.data.keyword.cloudant_short_notm}} für Entwicklung und Evaluierung.
Der Plan verfügt über eine festen Betrag an Durchsatzkapazität
und enthält maximal 1 GB kostenlosen verschlüsselten   Datenspeichers.
```
{:pre}

## {{site.data.keyword.cloudant_short_notm}}-Service erstellen

Das grundlegende Format des Befehls zum Erstellen einer Serviceinstanz in {{site.data.keyword.Bluemix_notm}} lautet wie folgt:

```sh
bx service create <service> <plan> <instanzname>
```
{:pre}

Angenommen, wir möchten eine Instanz eines
{{site.data.keyword.cloudant_short_notm}}-Service mit dem `Lite`-Plan erstellen,
wobei der Instanzname `cs20170517a` lautet.

Führen Sie dazu einen Befehl ähnlich dem folgenden Beispiel aus:

```sh
bx service create cloudantNoSQLDB Lite cs20170517a
```
{:codeblock}

Die Serviceinstanz antwortet mit einer Nachricht ähnlich dem folgenden Beispiel:

```sh
Invoking 'cf create-service cloudantNoSQLDB Lite cs20170517a'...

Creating service instance cs20170517a in org J.Doe@email.com / space dev as J.Doe@email.com...
OK

```
{:pre}

## Berechtigungsnachweise für Ihren {{site.data.keyword.cloudant_short_notm}}-Service erstellen

Anwendungen, die Zugriff auf Ihren {{site.data.keyword.cloudant_short_notm}}-Service erfordern,
müssen über die erforderlichen Berechtigungsnachweise verfügen.

>   **Hinweis**: Serviceberechtigungsnachweise sind wertvoll.
    Wenn ein Benutzer oder eine Anwendung Zugriff auf die Berechtigungsnachweise hat,
    kann er oder sie letztlich alles mit der Serviceinstanz tun, was ihm bzw. ihr einfällt, z. B. unechte Daten erstellen oder wertvolle Informationen löschen.
    Schützen Sie diese Berechtigungsnachweise sorgfältig.

Die Serviceberechtigungsnachweise bestehen aus fünf Feldern:

Feld      | Zweck
-----------|--------
`host`     | Von Anwendungen verwendeter Hostname zum Suchen der Serviceinstanz.
`username` | Für Anwendungen erforderlicher Benutzername zum Zugreifen auf die Serviceinstanz.
`password` | Für Anwendungen erforderliches Kennwort zum Zugreifen auf die Serviceinstanz.
`port`     | HTTP-Portnummer für den Zugriff auf die Serviceinstanz auf dem Host. In der Regel '443' zum Erzwingen von HTTPS-Zugriff.
`url`      | Zeichenfolge, die die anderen Berechtigungsnachweise in einer einzigen URL zusammenfasst, bereit für die Verwendung durch Anwendungen.

Das grundlegende Format des Befehls zum Erstellen von Berechtigungsnachweisen für eine Serviceinstanz in {{site.data.keyword.Bluemix_notm}} lautet wie folgt:

```sh
bx cf create-service-key <instanzname> <name_der_berechtigungsnachweise>
```
{:pre}

Angenommen, wir möchten Berechtigungsnachweise für die `cs20170517a`-Instanz eines
{{site.data.keyword.cloudant_short_notm}}-Service erstellen,
wobei der Name für die Berechtigungsnachweise `creds20170517a` lautet.

Führen Sie dazu einen Befehl ähnlich dem folgenden Beispiel aus:

```sh
bx cf create-service-key cs20170517a creds20170517a
```
{:codeblock}

Nachdem Sie die Anforderung zum Erstellen von Berechtigungsnachweisen für die Serviceinstanz empfangen haben,
antwortet {{site.data.keyword.Bluemix_notm}} mit einer Nachricht ähnlich dem folgenden Beispiel:

```sh
Invoking 'cf create-service-key cs20170517a creds20170517a'...

Creating service key creds20170517a for service instance cs20170517a as J.Doe@email.com...
OK
```
{:pre}

## Serviceberechtigungsnachweise für Ihren {{site.data.keyword.cloudant_short_notm}}-Service auflisten

Das grundlegende Format zum Abrufen der Berechtigungsnachweise für eine Serviceinstanz
in {{site.data.keyword.Bluemix_notm}} ist das folgende:

```sh
bx cf service-key <instanzname> <name_der_berechtigungsnachweise>
```
{:pre}

Angenommen, wir möchten Berechtigungsnachweise für die `cs20170517a`-Instanz eines
{{site.data.keyword.cloudant_short_notm}}-Service abrufen,
wobei der Name für die Berechtigungsnachweise `creds20170517a` lautet.

Führen Sie dazu einen Befehl ähnlich dem folgenden Beispiel aus:

```sh
bx cf service-key cs20170517a creds20170517a
```
{:codeblock}

Nachdem Sie die Anforderung zum Abrufen von Berechtigungsnachweisen für die Serviceinstanz empfangen haben,
antwortet {{site.data.keyword.Bluemix_notm}} mit einer Nachricht ähnlich dem folgenden (abgekürzten) Beispiel:

```sh
Invoking 'cf service-key cs20170517a creds20170517a'...

Getting key creds20170517a for service instance cs20170517a as J.Doe@email.com...

{
 "host": "946...46f-bluemix.cloudant.com",
 "password": "4eb...eb5",
 "port": 443,
 "url": "https://946...46f-bluemix:4eb...eb5@946...46f-bluemix.cloudant.com",
 "username": "946...46f-bluemix"
}
```
{:pre}

## {{site.data.keyword.cloudant_short_notm}}-Serviceinstanz verwenden

An diesem Punkt haben Sie...

1.  ...eine {{site.data.keyword.cloudant_short_notm}}-Serviceinstanz in {{site.data.keyword.Bluemix_notm}} erstellt.
2.  ...Berechtigungsnachweise für die {{site.data.keyword.cloudant_short_notm}}-Serviceinstanz erstellt.
3.  ...die Serviceinstanzberechtigungsnachweise abgerufen, damit diese für Ihre Anwendung verwendet werden können.

Ein Lernprogramm, das Ihnen zeigt, wie Sie eine {{site.data.keyword.cloudant_short_notm}}-Serviceinstanz verwenden können,
ist [hier](create_database.html#context) verfügbar.
Denken Sie daran, die Berechtigungsnachweise zu ersetzen, die Sie in diesem Lernprogramm erstellt haben.

## (Optional) Abschließendes Aufräumen

Die folgende kurze Liste mit Befehlen kann hilfreich sein, wenn Sie Ihre Entwicklungsumgebung aufräumen möchten.

### Serviceberechtigungsnachweise löschen

Verwenden Sie einen Befehl ähnlich dem folgenden, um einen Satz Serviceberechtigungsnachweise zu löschen:

```sh
bx cf delete-service-key <instanzname> <name_der_berechtigungsnachweise>
```
{:pre}

Um beispielsweise die Berechtigungsnachweise namens `creds20170517a`
aus der Instanz `cs20170517a` eines {{site.data.keyword.cloudant_short_notm}}-Service zu löschen,
können Sie einen Befehl wie diesen absetzen:

```sh
bx cf delete-service-key cs20170517a creds20170517a
```
{:pre}

### Serviceinstanz löschen

Setzen Sie einen Befehl ähnlich dem folgenden ab,
um eine Serviceinstanz zu löschen:

```sh
bx service delete <instanzname>
```
{:pre}

Um beispielsweise die Instanz `cs20170517a` eines {{site.data.keyword.cloudant_short_notm}}-Service zu löschen,
können Sie einen Befehl wie diesen absetzen:

```sh
bx service delete cs20170517a
```
{:pre}

