---

copyright:
  years: 2017, 2018
lastupdated: "2018-10-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:tip: .tip}

<!-- Acrolinx: 2017-05-10 -->

# Einfache {{site.data.keyword.cloud_notm}}-Anwendung für den Zugriff auf eine {{site.data.keyword.cloudant_short_notm}}-Datenbank erstellen: Code

In diesem Abschnitt des Lernprogramms wird der Code
für eine {{site.data.keyword.cloud}}-Anwendung beschrieben.
{:shortdesc}

<div id="theApp"></div>

## Anwendung erstellen

Die folgenden Komponenten sind jetzt installiert,
die Anwendung kann erstellt werden:

-   [Die Python-Programmiersprache](create_bmxapp_prereq.html#python).
-   [Eine {{site.data.keyword.cloudant_short_notm}}-Datenbankinstanz](create_bmxapp_prereq.html#csi).
-   [Eine {{site.data.keyword.cloud_notm}}-Anwendungsumgebung](create_bmxapp_appenv.html#creating).
-   Eine [Verbindung](create_bmxapp_appenv.html#connecting) zwischen der {{site.data.keyword.cloudant_short_notm}}-Datenbankinstanz
    und der {{site.data.keyword.cloud_notm}}-Anwendungsumgebung.
-   Die [Toolkits](create_bmxapp_appenv.html#toolkits) für die Verwaltung Cloud Foundry-basierter {{site.data.keyword.cloud_notm}}-Anwendungen.
-   Ein [Starter-Anwendungspaket](create_bmxapp_appenv.html#starter), das die anfänglichen Konfigurations- und Codevorlagendateien enthält.

>   **Hinweis**: Es wurde nicht versucht, einen _effizienten_ Python-Code für dieses Lernprogramm zu schreiben.
    Unsere Absicht ist, Ihnen einfachen und leicht verständlichen Code zu zeigen,
den Sie anschließend für Ihre eigenen Anwendungen verwenden können.
    Es war auch nicht unser Anliegen, alle möglichen Prüfungen oder Fehlerbedingungen zu besprechen.
    Wir haben lediglich einige Beispielprüfungen eingeschlossen, um bestimmte Techniken zu erläutern.
    Prüfen Sie Ihre Anwendungen auf Warnungen oder Fehlerbedingungen
    und lösen Sie diese.

### Wichtige Dateien

Ihre Anwendung benötigt drei Konfigurationsdateien und eine Quellendatei, die alle im [Starter-Anwendungspaket](create_bmxapp_appenv.html#starter) verfügbar sind:
 
-   ['`Procfile`'](create_bmxapp_appenv.html#procfile)
-   ['`manifest.yml`'](create_bmxapp_appenv.html#manifest)
-   ['`requirements.txt`'](create_bmxapp_appenv.html#requirements)
-   Die Anwendungsquellendatei, die in diesem Abschnitt des Lernprogramms beschrieben ist.

Ändern Sie Ihre Konfigurationsdateien wie folgt:

1.  Bearbeiten Sie die Datei `Procfile` so, dass sie den folgenden Text enthält:
    ```
    web: python server.py
    ```
    {:codeblock}

2.  Bearbeiten Sie die Datei `manifest.yml` so, dass sie den folgenden Text enthält:
    ```
    applications:
    - path: .
      memory: 128M
      instances: 1
      domain: <Ihre Domäne>
      name: <Ihr Anwendungsname>
      host: <Ihr Anwendungshost>
      disk_quota: 1024M
      services:
      - <Ihre Datenbankinstanz>
    ```
    {:codeblock}
    >   **Hinweis**: Stellen Sie sicher, dass Sie die Werte '`domain`', '`name`', '`host`' und '`services' ändern. Das sind die Werte, die eingegeben wurden, als Sie Ihre [{{site.data.keyword.cloud_notm}}-Anwendungsumgebung](create_bmxapp_appenv.html#creating) und Ihre [{{site.data.keyword.cloudant_short_notm}}-Datenbankinstanz](create_bmxapp_prereq.html#csi) erstellt haben.

3.  Bearbeiten Sie die Datei `requirements.txt` so, dass sie den folgenden Text enthält:
    ```
    cloudant==2.3.1
    ```
    {:codeblock}

### Anwendungscode

Der nächste Schritt besteht darin, am Anwendungscode zu arbeiten.
Jeder Abschnitt wird beschrieben und der Code wird dargestellt.
Eine [vollständige Liste](#complete-listing) der Anwendungscodes
befindet sich am Ende dieses Abschnitts des Lernprogramms.

#### Einführung

Damit die Python-Anwendung funktioniert, müssen einige grundlegende Komponenten vorhanden sein.
Sie werden wie folgt importiert:

```python
# Machen Sie Python-Module verfügbar.
import os
import json

# Es ist nützlich, auf Tools zum Formatieren
# von Datums- und Zeitwerten Zugriff zu haben.
from time import gmtime, strftime
```
{:codeblock}

Die Anwendung funktioniert wie ein einfacher Web-Server,
der nur eine Seite anzeigt:
ein Protokoll der Ergebnisse des Verbindungsversuchs mit der {{site.data.keyword.cloudant_short_notm}}-Datenbankinstanz
und der Erstellung einer Datenbank.

Die Anwendung setzt bestimmte Komponenten zum Verwalten einer Webseite voraus:

```python
# Vereinfachen Sie den Zugriff auf grundlegende Python-Web-Server-Tools.
try:
    from SimpleHTTPServer import SimpleHTTPRequestHandler as Handler
    from SocketServer import TCPServer as Server
except ImportError:
    from http.server import SimpleHTTPRequestHandler as Handler
    from http.server import HTTPServer as Server
```
{:codeblock}

>   **Hinweis**: Dieses Codesegment wird als Teil des [Starter-Anwendungspakets](create_bmxapp_appenv.html#starter) bereitgestellt.

Die Anwendung stellt eine Verbindung mit der {{site.data.keyword.cloudant_short_notm}}-Datenbankinstanz her,
deshalb muss sie die {{site.data.keyword.cloudant_short_notm}}-Bibliothekskomponenten importieren:

```python
# Aktivieren Sie erforderliche Python-Bibliotheken für die Arbeit mit {{site.data.keyword.cloudant_short_notm}}.
from cloudant.client import Cloudant
from cloudant.error import CloudantException
from cloudant.result import Result, ResultByKey
```
{:codeblock}

Die Anwendung erstellt eine Datenbank in der {{site.data.keyword.cloudant_short_notm}}-Datenbankinstanz.
Für die Datenbank muss ein Name angegeben werden:

```python
# Dies ist der Name der Datenbank, die wir erstellen möchten.
databaseName = "databasedemo"
```
{:codeblock}

Die Anwendung zeichnet den Fortschritt bei der Verbindung mit der
{{site.data.keyword.cloudant_short_notm}}-Datenbankinstanz auf
und erstellt die Datenbank.
Der Datensatz hat die Form einer Protokolldatei,
die in einem Ordner gespeichert ist, auf den der Python-Web-Server Zugriff hat.

Erstellen Sie einen Ordner (namens `static` in der Anwendung)
und bereiten Sie sich darauf vor, darin eine Datei zu speichern:

```python
# Ändern Sie das aktuelle Verzeichnis, damit Steuerdateien nicht öffentlich werden.
try:
    os.mkdir('static')
except OSError:
    # Das Verzeichnis ist bereits vorhanden,
    # es muss nicht erstellt werden.
    pass
os.chdir('static')
```
{:codeblock}

Erstellen Sie als nächstes eine einfache HTML-Datei.
Die Datei wird das Protokoll aller Aktivitäten enthalten, die während der Erstellung der Datenbank durch die Anwendung ausgeführt wurden:

```python
# Erstellen Sie eine sehr einfache Webseite.
filename = "index.html"
target = open(filename, 'w')
target.truncate()
target.write("<html><head><title>{{site.data.keyword.cloudant_short_notm}} Python-Demo</title></head><body><p>Protokoll der Cloudant Python-Schritte...</p><pre>")
```
{:codeblock}

Der erste Teil des Protokolls ist ein Datensatz mit dem aktuellen Datum und der aktuellen Uhrzeit.
Dieser Datensatz beweist, dass die Datenbank wirklich neu erstellt wird:

```python
# Geben Sie oben auf der Seite einen eindeutigen Hinweis auf das aktuelle Datum und die aktuelle Uhrzeit.
target.write("====\n")
target.write(strftime("%Y-%m-%d %H:%M:%S", gmtime()))
target.write("\n====\n\n")
```
{:codeblock}

#### Mit der {{site.data.keyword.cloudant_short_notm}}-Datenbankinstanz arbeiten

Die Python-Anwendung wird in einer {{site.data.keyword.cloud_notm}}-Anwendungsumgebung ausgeführt.
Die Umgebung stellt alle erforderlichen Informationen bereit, damit die Anwendung auf verbundene Services zugreifen kann.
Die Informationen sind in einer Umgebungsvariablen namens `VCAP_SERVICES` enthalten.
Diese Variable kann aus der Anwendung geöffnet und zum Bestimmen der Verbindungsdetails verwendet werden.

Die erste Task ist, sicherzustellen, dass die Anwendung in einer {{site.data.keyword.cloud_notm}}-Anwendungsumgebung ausgeführt wird.
Prüfen Sie dies, indem Sie nach der Umgebungsvariablen `VCAP_SERVICES` suchen:

```python
# Prüfen Sie, dass eine {{site.data.keyword.cloud_notm}}-Anwendungsumgebung ausgeführt wird.
if 'VCAP_SERVICES' in os.environ:
```
{:codeblock}

>   **Hinweis**: Die folgenden Codeabschnitte werden nur ausgeführt, wenn die Umgebungsvariable gefunden wurde.
    In Python soll dieser Code angeben, dass es sich um den Hauptteil des Tests handelt.
    In diesem Lernprogramm werden die Einrückungen in Codesegmenten weggelassen, um Platz zu sparen.
    In der [vollständigen Liste](#complete-listing) sind die Einrückungen korrekt dargestellt.

Wurde die Variable gefunden, fahren Sie mit den darin enthaltenen Informationen fort.
Beginnen Sie, indem Sie die JSON-Daten laden, die in der Variablen gespeichert sind,
und das Ereignis in der neuen Protokolldatei aufzeichnen:

```python
# Ja, tun wir. Rufen Sie also die Serviceinformationen ab.
vcap_servicesData = json.loads(os.environ['VCAP_SERVICES'])
# Protokollieren Sie die Tatsache, dass erfolgreich Serviceinformationen ausfindig gemacht wurden.
target.write("Got vcap_servicesData\n")
```
{:codeblock}

Such Sie im nächsten Schritt nach Informationen zur verbundenen {{site.data.keyword.cloudant_short_notm}}-Datenbankinstanz.
Zeichnen Sie das Ereignis erneut in der Protokolldatei auf:

```python
# Suchen Sie nach der {{site.data.keyword.cloudant_short_notm}}-Serviceinstanz.
cloudantNoSQLDBData = vcap_servicesData['cloudantNoSQLDB']
# Protokollieren Sie die Tatsache, dass erfolgreich {{site.data.keyword.cloudant_short_notm}}-Serviceinformationen ausfindig gemacht wurden.
target.write("Got cloudantNoSQLDBData\n")
```
{:codeblock}

Es können diverse {{site.data.keyword.cloud_notm}}-Services mit der Anwendungsumgebung verbunden sein.
Die Berechtigungsnachweise für die einzelnen Services werden in Form von Array-Elementen aufgelistet.
In diesem Lernprogramm wurde nur eine [Serviceverbindung erstellt](create_bmxapp_appenv.html#connecting).
Deshalb greift die Anwendung auf das erste Element (Element null) zu.
Jedes Serviceelement enthält die Berechtigungsnachweise für diesen Service,
in Form einer Liste, indexiert anhand der unerlässlichen Feldnamen, die für den Zugriff auf den Service erforderlich sind.
Weitere Informationen zu den Feldnamen werden in dem [Lernprogramm](create_database.html#pre-requisites) bereitgestellt, das eine einfache Datenbankerstellung behandelt.

```python
# Rufen Sie eine Liste der {{site.data.keyword.cloudant_short_notm}}-Verbindungsinformationen ab.
credentials = cloudantNoSQLDBData[0]
# Rufen Sie die Werte ab, die für die Kommunikation der Anwendung mit dem Service unerlässlich sind.
credentialsData = credentials['credentials']
# Protokollieren Sie die Tatsache, dass die {{site.data.keyword.cloudant_short_notm}}-Werte erfolgreich ausfindig gemacht wurden.
target.write("Got credentialsData\n\n")
```
{:codeblock}

Untersuchen Sie anschließend die Liste und rufen Sie die wichtige Werte ab:

```python
# Rufen Sie den Benutzernamen ab...
serviceUsername = credentialsData['username']
target.write("Got username: ")
target.write(serviceUsername)
target.write("\n")
# ... das Kennwort...
servicePassword = credentialsData['password']
target.write("Got password: ")
target.write(servicePassword)
target.write("\n")
# ... und die URL des Service in {{site.data.keyword.cloud_notm}}.
serviceURL = credentialsData['url']
target.write("Got URL: ")
target.write(serviceURL)
target.write("\n")
```
{:codeblock}

Die Anwendung verfügt jetzt über alle erforderlichen Informationen zum Erstellen einer Datenbank in der
{{site.data.keyword.cloudant_short_notm}}-Datenbankinstanz.
Diese Task wird detaillierter in dem
[Lernprogramm](create_database.html#creating-a-database-within-the-service-instance) beschrieben, das eine einfache Datenbankerstellung behandelt.

Die Anwendung muss die folgenden Tasks ausführen:

1.  Verbindung mit der Datenbankinstanz einrichten.
2.  Datenbank mit dem [zuvor](#getting-started) angegebenen Namen erstellen.
3.  JSON-Dokument, das das aktuelle Datum und die aktuelle Uhrzeit enthält erstellen.
4.  JSON-Dokument in der Datenbank speichern.
5.  Bestätigen, dass das Dokument sicher gespeichert wurde.
6.  Verbindung mit der Datenbankinstanz schließen.

Der Code für diese Tasks lautet wie folgt:

```python
# Jetzt sind alle Informationen für die Arbeit mit der {{site.data.keyword.cloudant_short_notm}}-Serviceinstanz verfügbar.
# Stellen Sie eine Verbindung mit der Serviceinstanz her.
client = Cloudant(serviceUsername, servicePassword, url=serviceURL)
client.connect()
# Erstellen Sie eine Datenbank in der Instanz.
myDatabaseDemo = client.create_database(databaseName)
if myDatabaseDemo.exists():
    target.write("'{0}' successfully created.\n".format(databaseName))
    # Erstellen Sie ein einfaches JSON-Dokument mit dem aktuellen Datum und der aktuellen Uhrzeit.
    jsonDocument = {
        "rightNow": strftime("%Y-%m-%d %H:%M:%S", gmtime())
    }
    # Speichern Sie das JSON-Dokument in der Datenbank.
    newDocument = myDatabaseDemo.create_document(jsonDocument)
    if newDocument.exists():
        target.write("Document successfully created.\n")
# Alles erledigt. Trennen Sie die Verbindung zur Serviceinstanz.
client.disconnect()
```
{:codeblock}

#### Protokolldatei schließen

Der nächste Schritt besteht darin, die Protokolldatei fertigzustellen
und sie mithilfe eines einfachen Python-Web-Servers in der Anwendung bereitzustellen:

```python
# Geben Sie unten auf der Seite einen weiteren eindeutigen Hinweis auf das aktuelle Datum und die aktuelle Uhrzeit.
target.write("\n====\n")
target.write(strftime("%Y-%m-%d %H:%M:%S", gmtime()))
target.write("\n====\n")
# Schließen die die Erstellung der Webseite ab.
target.write("</pre></body></html>")
target.close()
```
{:codeblock}

#### Protokolldatei bereitstellen

Die Abschlusstask besteht im Starten des Web-Servers in der Python-Anwendung.
Der einzige Zweck des Servers ist, die Protokolldatei bei Bedarf zurückzugeben.
Diese Protokolldatei beweist, dass die Python-Anwendung die folgenden Tasks erfolgreich abgeschlossen hat:

1.  Sie wurde erfolgreich in der {{site.data.keyword.cloud_notm}}-Anwendungsumgebung ausgeführt.
2.  Sie hat die Details für Serviceverbindungen festgelegt.
3.  Sie hat eine Verbindung mit einer {{site.data.keyword.cloudant_short_notm}}-Datenbankinstanz hergestellt.
4.  Sie hat eine Datenbank erstellt.
5.  Sie hat ein Dokument in der Datenbank erstellt.
6.  Sie hat bei Bedarf ein Protokoll der Ereignisse zurückgegeben.

Der Code zum Starten des Python-Web-Servers ist im
[Starter-Anwendungspaket](create_bmxapp_appenv.html#starter) enthalten:

```python
# Starten Sie die einfache Python-Web-Server-Anwendung,
# damit sie unsere neu erstellte Webseite bereitstellen kann.
PORT = int(os.getenv('PORT', 8000))
httpd = Server(("", PORT), Handler)
try:
  print("Start serving at port %i" % PORT)
  httpd.serve_forever()
except KeyboardInterrupt:
  pass
httpd.server_close()
```
{:codeblock}

## Der nächste Schritt

Der nächste Schritt im Lernprogramm besteht darin, [die Anwendung zu Testzwecken hochzuladen](create_bmxapp_upload.html).

## Vollständige Liste

Der folgende Code ist das vollständige Python-Programm für den Zugriff auf eine {{site.data.keyword.cloudant_short_notm}}-Serviceinstanz unter {{site.data.keyword.cloud_notm}}:

```python
# Machen Sie Python-Module verfügbar.
import os
import json

# Es ist nützlich, auf Tools zum Formatieren
# von Datums- und Zeitwerten Zugriff zu haben.
from time import gmtime, strftime

# Vereinfachen Sie den Zugriff auf grundlegende Python-Web-Server-Tools.
try:
    from SimpleHTTPServer import SimpleHTTPRequestHandler as Handler
    from SocketServer import TCPServer as Server
except ImportError:
    from http.server import SimpleHTTPRequestHandler as Handler
    from http.server import HTTPServer as Server

# Aktivieren Sie erforderliche Python-Bibliotheken für die Arbeit mit {{site.data.keyword.cloudant_short_notm}}.
from cloudant.client import Cloudant
from cloudant.error import CloudantException
from cloudant.result import Result, ResultByKey

# Dies ist der Name der Datenbank, die wir erstellen möchten.
databaseName = "databasedemo"

# Ändern Sie das aktuelle Verzeichnis, damit Steuerdateien nicht öffentlich werden.
try:
    os.mkdir('static')
except OSError:
    # Das Verzeichnis ist bereits vorhanden,
    # es muss nicht erstellt werden.
    pass
os.chdir('static')

# Erstellen Sie eine sehr einfache Webseite.
filename = "index.html"
target = open(filename, 'w')
target.truncate()
target.write("<html><head><title>Cloudant Python-Demo</title></head><body><p>Protokoll der {{site.data.keyword.cloudant_short_notm}} Python-Schritte...</p><pre>")

# Geben Sie oben auf der Seite einen eindeutigen Hinweis auf das aktuelle Datum und die aktuelle Uhrzeit.
target.write("====\n")
target.write(strftime("%Y-%m-%d %H:%M:%S", gmtime()))
target.write("\n====\n\n")

# Beginnen Sie, die {{site.data.keyword.cloudant_short_notm}}-Serviceinstanz zu verwenden.

# Prüfen Sie, dass eine {{site.data.keyword.cloud_notm}}-Anwendungsumgebung ausgeführt wird.
if 'VCAP_SERVICES' in os.environ:
    # Ja, wird es. Rufen Sie also die Serviceinformationen ab.
    vcap_servicesData = json.loads(os.environ['VCAP_SERVICES'])
    # Protokollieren Sie die Tatsache, dass erfolgreich Serviceinformationen ausfindig gemacht wurden.
    target.write("Got vcap_servicesData\n")
    # Suchen Sie nach der {{site.data.keyword.cloudant_short_notm}}-Serviceinstanz.
    cloudantNoSQLDBData = vcap_servicesData['cloudantNoSQLDB']
    # Protokollieren Sie die Tatsache, dass erfolgreich {{site.data.keyword.cloudant_short_notm}}-Serviceinformationen ausfindig gemacht wurden.
    target.write("Got cloudantNoSQLDBData\n")
    # Rufen Sie eine Liste der {{site.data.keyword.cloudant_short_notm}}-Verbindungsinformationen ab.
    credentials = cloudantNoSQLDBData[0]
    # Rufen Sie die Werte ab, die für die Kommunikation der Anwendung mit dem Service unerlässlich sind.
    credentialsData = credentials['credentials']
    # Protokollieren Sie die Tatsache, dass die {{site.data.keyword.cloudant_short_notm}}-Werte erfolgreich ausfindig gemacht wurden.
    target.write("Got credentialsData\n\n")
    # Rufen Sie den Benutzernamen ab...
    serviceUsername = credentialsData['username']
    target.write("Got username: ")
    target.write(serviceUsername)
    target.write("\n")
    # ...das Kennwort...
    servicePassword = credentialsData['password']
    target.write("Got password: ")
    target.write(servicePassword)
    target.write("\n")
    # ...und die URL des Service in {{site.data.keyword.cloud_notm}}.
    serviceURL = credentialsData['url']
    target.write("Got URL: ")
    target.write(serviceURL)
    target.write("\n")

    # Jetzt sind alle Informationen für die Arbeit mit der {{site.data.keyword.cloudant_short_notm}}-Serviceinstanz verfügbar.
    # Stellen Sie eine Verbindung mit der Serviceinstanz her.
    client = Cloudant(serviceUsername, servicePassword, url=serviceURL)
    client.connect()
    # Erstellen Sie eine Datenbank in der Instanz.
    myDatabaseDemo = client.create_database(databaseName)
    if myDatabaseDemo.exists():
        target.write("'{0}' successfully created.\n".format(databaseName))
        # Erstellen Sie ein sehr einfaches JSON-Dokument mit dem aktuellen Datum und der aktuellen Uhrzeit.
        jsonDocument = {
            "rightNow": strftime("%Y-%m-%d %H:%M:%S", gmtime())
        }
        # Speichern Sie das JSON-Dokument in der Datenbank.
        newDocument = myDatabaseDemo.create_document(jsonDocument)
        if newDocument.exists():
            target.write("Document successfully created.\n")
    # Alles erledigt. Trennen Sie die Verbindung zur Serviceinstanz.
    client.disconnect()

# Geben Sie unten auf der Seite einen weiteren eindeutigen Hinweis auf das aktuelle Datum und die aktuelle Uhrzeit.
target.write("\n====\n")
target.write(strftime("%Y-%m-%d %H:%M:%S", gmtime()))
target.write("\n====\n")
# Schließen die die Erstellung der Webseite ab.
target.write("</pre></body></html>")
target.close()

# Starten Sie die einfache Python-Web-Server-Anwendung,
# damit sie unsere neu erstellte Webseite bereitstellen kann.
PORT = int(os.getenv('PORT', 8000))
httpd = Server(("", PORT), Handler)
try:
  print("Start serving at port %i" % PORT)
  httpd.serve_forever()
except KeyboardInterrupt:
  pass
httpd.server_close()
```
{:codeblock}
