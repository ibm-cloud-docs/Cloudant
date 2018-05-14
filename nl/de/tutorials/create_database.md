---

copyright:
  years: 2017
lastupdated: "2017-01-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# Einfache Cloudant-Datenbank unter Bluemix erstellen und befüllen

In diesem Lernprogramm erfahren Sie, wie Sie die [Python-Programmiersprache ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://www.python.org/){:new_window} verwenden, um
eine {{site.data.keyword.cloudantfull}}-Datenbank in Ihrer {{site.data.keyword.Bluemix_notm}}-Serviceinstanz zu erstellen und die Datenbank mit einer einfachen Sammlung von Daten zu befüllen.
{:shortdesc}

## Voraussetzungen

Stellen Sie sicher, dass Sie die folgenden Ressourcen oder Informationen zur Hand haben, bevor Sie das Lernprogramm durcharbeiten. 

### Python

Sie müssen über eine aktuelle Installation der [Python-Programmiersprache ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://www.python.org/){:new_window}
auf Ihrem System verfügen. 

Führen Sie den folgenden Befehl an einer Eingabeaufforderung aus, um dies zu prüfen: 

```sh
python --version
```
{:pre}

Ihr Ergebnis sollte ungefähr wie folgt aussehen: 

```
Python 2.7.12
```
{:codeblock}

### Python-Clientbibliothek für Cloudant

Es gibt eine [offiziell unterstützte Bibliothek](../libraries/supported.html#python), um Ihre Python-Anwendungen darin zu unterstützen, mit
{{site.data.keyword.cloudant_short_notm}} unter {{site.data.keyword.Bluemix_notm}} zu arbeiten. 

Sie sollten diese Bibliothek mit den [hier](../libraries/supported.html#python) bereitgestellten Anweisungen installieren. 

Um sicherzustellen, dass Sie die Clientbibliothek erfolgreich installiert haben, führen Sie den folgenden Befehl an einer Eingabeaufforderung ein:

```sh
pip freeze
```
{:pre}

Sie sollten eine Liste aller Python-Module erhalten, die auf Ihrem System installiert sind. Suchen Sie in der Liste nach einem {{site.data.keyword.cloudant_short_notm}}-Eintrag ähnlich dem folgenden: 

```
cloudant==2.3.1
```
{:codeblock}

### Cloudant-Serviceinstanz unter Bluemix

Der Prozess der Erstellung einer passenden Serviceinstanz wird in [diesem Lernprogramm](create_service.html) beschrieben. 

Stellen Sie sicher, dass Sie die folgenden Serviceberechtigungsnachweise für Ihre Serviceinstanz zur Hand haben: 

Feld           | Zweck
-----------|--------
`host`     | Von Anwendungen verwendeter Hostname zum Suchen der Serviceinstanz. 
`username` | Für Anwendungen erforderlicher Benutzername zum Zugreifen auf die Serviceinstanz. 
`password` | Für Anwendungen erforderliches Kennwort zum Zugreifen auf die Serviceinstanz. 
`port`     | HTTP-Portnummer für den Zugriff auf die Serviceinstanz auf dem Host. In der Regel '443' zum Erzwingen von HTTPS-Zugriff. 
`url`      | Zeichenfolge, die die anderen Berechtigungsnachweise in einer einzigen URL zusammenfasst, bereit für die Verwendung durch Anwendungen.

Informationen zum Suchen nach den Berechtigungsnachweisen für Ihre Serviceinstanz sind
[hier](create_service.html#locating-your-service-credentials) verfügbar. 

## Kontext

In diesem Lernprogramm wird eine Serie von Python-Sprachanweisungen erstellt, passend für die folgenden Tasks: 

1.  [Verbindung mit einer {{site.data.keyword.cloudant_short_notm}}-Serviceinstanz unter {{site.data.keyword.Bluemix_notm}}](#connecting-to-a-cloudant-service-instance-on-bluemix) herstellen. 
2.  [Datenbank in der Serviceinstanz erstellen](#creating-a-database-within-the-service-instance).
3.  [Kleine Sammlung von Daten in Form von Dokumenten in der Datenbank speichern](#storing-a-small-collection-of-data-as-documents-within-the-database). 
4.  [Vollständige Liste der Dokumente abrufen](#retrieving-a-complete-list-of-the-documents).
5.  [Datenbank löschen](#deleting-the-database).
6.  [Verbindung mit der Serviceinstanz trennen](#closing-the-connection-to-the-service-instance).

Als Teil der Taskbeschreibung in diesem Lernprogramm wird spezifisch für jede Task Python-Code bereitgestellt. 

Ein vollständiges Python-Programm zum Ausführen aller Tasks wird am Ende des Lernprogramms bereitgestellt, nämlich
[hier](#complete-listing). 

Es wurde nicht versucht, einen _effizienten_ Python-Code für dieses Lernprogramm zu schreiben.
Unsere Absicht ist, Ihnen einfachen und leicht verständlichen Code zu zeigen,
den Sie anschließend für Ihre eigenen Anwendungen verwenden können. 

Es war auch nicht unser Anliegen, alle möglichen Prüfungen oder Fehlerbedingungen zu besprechen.
Wir zeigen hier zwar einige Beispielprüfungen, um bestimmte Techniken zu erläutern,
aber Sie sollten Ihre üblichen Best Practices einsetzen, um Warnungen oder Fehlerbedingungen zu prüfen
und zu verarbeiten, die in Ihren Anwendungen auftreten.  

## Verbindung mit einer Cloudant-Serviceinstanz unter Bluemix herstellen

Eine Python-Anwendung setzt voraus, dass die Cloudant-Clientbibliothekskomponenten eine Verbindung zur Serviceinstanz herstellen können.
Diese Komponenten sind normale `import`-Anweisungen: 

```python
from cloudant.client import Cloudant
from cloudant.error import CloudantException
from cloudant.result import Result, ResultByKey
```
{:codeblock}

Die Anwendung muss über die [Serviceberechtigungsnachweise](create_service.html#locating-your-service-credentials) für den Service verfügen: 

```python
serviceUsername = "353466e8-47eb-45ce-b125-4a4e1b5a4f7e-bluemix"
servicePassword = "49c0c343d225623956157d94b25d574586f26d1211e8e589646b4713d5de4801"
serviceURL = "https://353466e8-47eb-45ce-b125-4a4e1b5a4f7e-bluemix.cloudant.com"
```
{:codeblock}

>   **Hinweis**: Die hier dargestellten Serviceberechtigungsnachweise
    wurden definiert, als ein Cloudant-Service zu Demonstrationszwecken unter Bluemix erstellt wurde.
    Die Berechtigungsnachweise werden hier reproduziert, um zu zeigen, wie sie in einer Python-Anwendung verwendet würden. Der
    Cloudant-Service zu Demonstrationszwecken wurde inzwischen entfernt,
    deshalb werden diese Berechtigungsnachweise nicht funktionieren.
    Sie _müssen_ Ihre eigenen Serviceberechtigungsnachweise angeben und verwenden.

Sobald Sie die Python-Clientbibliothek in Ihrer Anwendung aktiviert
und die Serviceberechtigungsnachweise angegeben haben, können Sie eine Verbindung mit der Serviceinstanz einrichten: 

```python
client = Cloudant(serviceUsername, servicePassword, url=serviceURL)
client.connect()
```
{:codeblock}

Zu diesem Zeitpunkt hat Ihre Python-Anwendung Zugriff auf die Serviceinstanz unter Bluemix. 

## Datenbank in der Serviceinstanz erstellen

Der nächste Schritt besteht darin, eine Datenbank in der Serviceinstanz namens `databasedemo` zu erstellen. 

Dafür definieren Sie eine Variable in der Python-Anwendung: 

```python
databaseName = "databasedemo"
```
{:codeblock}

Dann erstellen Sie die Datenbank: 

```python
myDatabaseDemo = client.create_database(databaseName)
```
{:codeblock}

Es ist nützlich, zu prüfen, dass die Datenbank erfolgreich erstellt wurde: 

```python
if myDatabaseDemo.exists():
    print "'{0}' successfully created.\n".format(databaseName)
```
{:codeblock}

## Kleine Datensammlung als Dokumente in der Datenbank speichern

Jetzt speichern Sie eine kleine, einfache
Datensammlung in der Datenbank. 

Beginnen Sie mit der Angabe einiger Daten: 

```python
sampleData = [
    [1, "one", "boiling", 100],
    [2, "two", "hot", 40],
    [3, "three", "warm", 20],
    [4, "four", "cold", 10],
    [5, "five", "freezing", 0]
]
```
{:codeblock}

Als nächstes folgen ein paar gängige Python-Code-Schritte für die Daten,
um diese in JSON-Dokumente umzuwandeln.
Alle Dokumente werden in der Datenbank gespeichert: 

```python
  # Erstellen Sie Dokumente mithilfe von Beispieldaten.
  # Gehen Sie jede Zeile im Array
  nach dem Stichwort 'document' in sampleData durch:
    # Rufen Sie die Felder in jeder Zeile ab.
    number = document[0]
    name = document[1]
    description = document[2]
    temperature = document[3]

    # Erstellen Sie ein JSON-Dokument, das alle
    # Daten in der Zeile darstellt.
    jsonDocument = {
        "numberField": number,
        "nameField": name,
        "descriptionField": description,
        "temperatureField": temperature
    }

    # Erstellen Sie ein Dokument mithilfe der Datenbank-API.
    newDocument = myDatabaseDemo.create_document(jsonDocument)

    # Prüfen Sie, dass das Dokument in der Datenbank vorhanden ist.
    if newDocument.exists():
        print "Document '{0}' successfully created.".format(number)
```
{:codeblock}

Sie sollten wissen, dass wir jedes Dokument prüfen, das erfolgreich erstellt wurde.


## Daten überprüfen

Zu diesem Zeitpunkt wurde eine kleine Datensammlung in Form von Dokumenten in der Datenbank gespeichert.
Jetzt können Sie eine Reihe von Abfragen ausführen, die alle unterschiedliche Wege darstellen,
Daten aus der Datenbank abzurufen. 

### Minimaler Abruf eines Dokuments

Um einen minimalen Abruf auszuführen,
fordern Sie zunächst eine Liste aller Dokumente in der Datenbank an.
Diese Liste wird als Array zurückgegeben. Anschließend können Sie den Inhalt eines Elements im Array sehen. 

Im Beispielcode fordern wir das erste aus der Datenbank abgerufene Dokument an:

```python
result_collection = Result(myDatabaseDemo.all_docs)
print "Retrieved minimal document:\n{0}\n".format(result_collection[0])
```
{:codeblock}

Das Ergebnis entspricht dem folgenden Beispiel: 

```json
[
    {
        "value": {
            "rev": "1-b2c48b89f48f1dc172d4db3f17ff6b9a"
        },
        "id": "14746fe384c7e2f06f7295403df89187",
        "key": "14746fe384c7e2f06f7295403df89187"
    }
]
```
{:codeblock}

>   **Hinweis**: Das Wesen von NoSQL-Datenbanken
    wie Cloudant bedeutet, dass einfache Grundsätze  - wie "das erste in der Datenbank gespeicherte Dokument ist immer das   erste zurückgegebene Dokument in einer Ergebnisliste" - nicht zwangsläufig zutreffen.

### Vollständiger Abruf eines Dokuments

Um einen vollständigen Abruf auszuführen,
  fordern Sie eine Liste aller Dokumente in der Datenbank an
  und geben zusätzlich an, dass der Dokumentinhalt ebenfalls zurückgegeben
  werden muss. Dazu geben Sie die Option `include_docs` an.
Wie zuvor werden die Ergebnisse als Array zurückgegeben.
Dann können wir die Details eines Elements im Array anzeigen,
dieses Mal einschließlich des vollständigen Inhalts des Dokuments.  

Wie zuvor fordern wir das erste aus der Datenbank abgerufene
Dokument an: 

```python
result_collection = Result(myDatabaseDemo.all_docs, include_docs=True)
print "Retrieved minimal document:\n{0}\n".format(result_collection[0])
```
{:codeblock}

Das Ergebnis entspricht dem folgenden Beispiel: 

```json
[
    {
        "value": {
          "rev": "1-b2c48b89f48f1dc172d4db3f17ff6b9a"
        },
        "id": "14746fe384c7e2f06f7295403df89187",
        "key": "14746fe384c7e2f06f7295403df89187",
        "doc": {
            "temperatureField": 10,
            "descriptionField": "cold",
            "numberField": 4,
            "nameField": "four",
            "_id": "14746fe384c7e2f06f7295403df89187",
            "_rev": "1-b2c48b89f48f1dc172d4db3f17ff6b9a"
        }
    }
]
```
{:codeblock}

## Cloudant-API-Endpunkt direkt aufrufen

Wir können auch mit den Cloudant-API-Endpunkten direkt in einer Python-Anwendung arbeiten. 

In diesem Beispielcode wird erneut eine Liste
aller Dokumente, einschließlich ihrer Inhalte, angefordert.
Dieses Mal jedoch, indem Sie den Cloudant-[Endpunkt `/_all_docs`](../api/database.html#get-documents) aufrufen. 

Zunächst geben Sie den Endpunkt an, der kontaktiert werden soll, und alle Parameter, die bei diesem Aufruf bereitgestellt werden müssen: 

```python
end_point = '{0}/{1}'.format(serviceURL, databaseName + "/_all_docs")
params = {'include_docs': 'true'}
```
{:codeblock}

Dann senden Sie die Anforderung an die Serviceinstanz
  und zeigen die Ergebnisse an: 

```python
response = client.r_session.get(end_point, params=params)
print "{0}\n".format(response.json())
```
{:codeblock}

Das Ergebnis entspricht dem folgenden _abgekürzten_ Beispiel: 

```json
{
    "rows": [
        {
            "value": {
              "rev": "1-b2c48b89f48f1dc172d4db3f17ff6b9a"
            },
            "id": "14746fe384c7e2f06f7295403df89187",
            "key": "14746fe384c7e2f06f7295403df89187",
            "doc": {
                "temperatureField": 10,
                "descriptionField": "cold",
                "numberField": 4,
                "nameField": "four",
                "_id": "14746fe384c7e2f06f7295403df89187",
                "_rev": "1-b2c48b89f48f1dc172d4db3f17ff6b9a"
            }
        },
        ...
        {
            "value":
            {
              "rev": "1-7130413a8c7c5f1de5528fe4d373045c"
            },
            "id": "49baa66cc66b4dda86ffb2852ae78eb8",
            "key": "49baa66cc66b4dda86ffb2852ae78eb8",
            "doc": {
                "temperatureField": 40,
                "descriptionField": "hot",
                "numberField": 2,
                "nameField": "two",
                "_id": "49baa66cc66b4dda86ffb2852ae78eb8",
                "_rev": "1-7130413a8c7c5f1de5528fe4d373045c"
            }
        }
    ],
    "total_rows": 5,
    "offset": 0
}
```
{:codeblock}

## Datenbank löschen

Wenn Sie die Arbeit an der Datenbank abgeschlossen haben, kann sie gelöscht werden. 

Dies ist ein einfacher Schritt. Sehen Sie sich dazu den folgenden Python-Beispielcode an: 

```python
try :
    client.delete_database(databaseName)
except CloudantException:
    print "There was a problem deleting '{0}'.\n".format(databaseName)
else:
    print "'{0}' successfully deleted.\n".format(databaseName)
```
{:codeblock}

Wir haben einige grundlegende Fehlerbehandlungsschritte eingeschlossen,
um zu veranschaulichen, wie Probleme entstehen und gelöst werden können. 

## Verbindung mit der Serviceinstanz trennen

Der letzte Schritt ist das Trennen der Verbindung zwischen der Python-Clientanwendung und der Serviceinstanz. 

```python
client.disconnect()
```
{:codeblock}

## Vollständige Liste

Der folgende Code ist ein vollständiges Python-Programm für den Zugriff auf eine
{{site.data.keyword.cloudant_short_notm}}-Serviceinstanz unter {{site.data.keyword.Bluemix_notm}} und
für das Ausführen einer typischen Serie von Tasks: 

1.  Verbindung mit der Serviceinstanz herstellen. 
2.  Datenbank in der Serviceinstanz erstellen. 
3.  Kleine Datensammlung als Dokumente in der Datenbank speichern. 
4.  Vollständige Liste der Dokumente abrufen. 
5.  Datenbank löschen. 
6.  Verbindung mit der Serviceinstanz trennen. 

```python
# 1.  Verbindung mit der Serviceinstanz herstellen.
# Aktivieren Sie die erforderlichen Python-Bibliotheken.

from cloudant.client import Cloudant
from cloudant.error import CloudantException
from cloudant.result import Result, ResultByKey

# Hilfreiche Variablen
serviceUsername = "353466e8-47eb-45ce-b125-4a4e1b5a4f7e-bluemix"
servicePassword = "49c0c343d225623956157d94b25d574586f26d1211e8e589646b4713d5de4801"
serviceURL = "https://353466e8-47eb-45ce-b125-4a4e1b5a4f7e-bluemix.cloudant.com"

# Dies ist der Name der Datenbank, mit der wir arbeiten.
databaseName = "databasedemo"

# Dies ist eine einfache Datensammlung,
# die in der Datenbank gespeichert werden soll.
sampleData = [
    [1, "one", "boiling", 100],
    [2, "two", "hot", 40],
    [3, "three", "warm", 20],
    [4, "four", "cold", 10],
    [5, "five", "freezing", 0]
]

# Starten Sie die Demo.
print "===\n"

# Verwenden Sie die Cloudant-Bibliothek, um einen Cloudant-Client zu erstellen.
client = Cloudant(serviceUsername, servicePassword, url=serviceURL)

# Stellen Sie eine Verbindung zum Server her.
client.connect()

# 2.  Datenbank in der Serviceinstanz erstellen.
# Erstellen Sie eine Instanz der Datenbank
. myDatabaseDemo = client.create_database(databaseName)

# Prüfen Sie, dass die Datenbank jetzt vorhanden ist.
if myDatabaseDemo.exists():
    print "'{0}' successfully created.\n".format(databaseName)

# Setzen Sie die Ergebnisse in Leerzeichen.
print "----\n"

# 3.  Kleine Datensammlung als Dokumente in der Datenbank speichern.
  # Erstellen Sie Dokumente mithilfe von Beispieldaten.
  # Gehen Sie jede Zeile im Array
  nach dem Stichwort 'document' in sampleData durch:
    # Rufen Sie die Felder in jeder Zeile ab.
    number = document[0]
    name = document[1]
    description = document[2]
    temperature = document[3]

    # Erstellen Sie ein JSON-Dokument, das alle
    # Daten in der Zeile darstellt.
    jsonDocument = {
        "numberField": number,
        "nameField": name,
        "descriptionField": description,
        "temperatureField": temperature
    }

    # Erstellen Sie ein Dokument mithilfe der Datenbank-API.
    newDocument = myDatabaseDemo.create_document(jsonDocument)

    # Prüfen Sie, dass das Dokument in der Datenbank vorhanden ist.
    if newDocument.exists():
        print "Document '{0}' successfully created.".format(number)

# Setzen Sie die Ergebnisse in Leerzeichen.
print "----\n"

# 4.  Vollständige Liste der Dokumente abrufen.
# Einfacher und minimaler Abruf des ersten
# Dokuments in der Datenbank.
result_collection = Result(myDatabaseDemo.all_docs)
print "Retrieved minimal document:\n{0}\n".format(result_collection[0])

# Einfacher und vollständiger Abruf des ersten
# Dokuments in der Datenbank.
result_collection = Result(myDatabaseDemo.all_docs, include_docs=True)
print "Retrieved full document:\n{0}\n".format(result_collection[0])

# Setzen Sie die Ergebnisse in Leerzeichen.
print "----\n"

# Verwenden Sie einen Cloudant-API-Endpunkt, um alle
# Dokumente in der Datenbank,
# einschließlich ihrer Inhalte, abzurufen.

# Definieren Sie die Endpunkte und Parameter.
end_point = '{0}/{1}'.format(serviceURL, databaseName + "/_all_docs")
params = {'include_docs': 'true'}

# Geben Sie die Anforderung aus.
response = client.r_session.get(end_point, params=params)

# Zeigen Sie den Inhalt der Antwort an.
print "{0}\n".format(response.json())

# Setzen Sie die Ergebnisse in Leerzeichen.
print "----\n"

# Alles erledigt.
# Zeit zum Aufräumen.

# 5.  Datenbank löschen.
# Löschen Sie die Testdatenbank.
try :
    client.delete_database(databaseName)
except CloudantException:
    print "There was a problem deleting '{0}'.\n".format(databaseName)
else:
    print "'{0}' successfully deleted.\n".format(databaseName)

# 6.  Verbindung mit der Serviceinstanz trennen.
# Trennen Sie die Verbindung zum Server.
client.disconnect()

# Beenden Sie die Demo.
print "===\n"

# Verabschieden Sie sich.
exit()
```
{:codeblock}
