---

copyright:
  years: 2015, 2018
lastupdated: "2017-11-02"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:tip: .tip}

# Lernprogramm 'Einführung'
{: #getting-started-with-cloudant}

In diesem {{site.data.keyword.cloudantfull}}-Lernprogramm 'Einführung'
verwenden wir Python, um eine {{site.data.keyword.cloudant}}-Datenbank zu erstellen und
diese Datenbank mit einer einfachen Datensammlung zu befüllen.
{:shortdesc}

<div id="prerequisites"></div>

## Vorbereitende Schritte
{: #prereqs}

Sie müssen ein [Bluemix-Konto ![Symbol für externen Link](images/launch-glyph.svg "Symbol für externen Link")](https://console.ng.bluemix.net/registration/){:new_window},
eine Instanz des {{site.data.keyword.cloudant}}-Service und die folgenden Python-Anforderungen aufweisen:

*	Installieren Sie die aktuelle Version der
	[Python-Programmiersprache ![Symbol für externen Link](images/launch-glyph.svg "Symbol für externen Link")](https://www.python.org/){:new_window} auf Ihrem System.
	
	Führen Sie den folgenden Befehl an einer Eingabeaufforderung aus, um dies zu prüfen:
	```sh
	python --version
	```
	{:pre}
	
	Ihr Ergebnis sollte ungefähr wie folgt aussehen:

	```
	Python 2.7.12
	```
	{:screen}

*	Installieren Sie die [Python-Bibliothek](libraries/supported.html#python),
	um Ihre Python-Anwendungen für die Arbeit mit
	{{site.data.keyword.cloudant_short_notm}} unter {{site.data.keyword.Bluemix_notm}} zu aktivieren.
	
	Um sicherzustellen, dass Sie die Clientbibliothek erfolgreich installiert haben, führen Sie den folgenden Befehl an einer Eingabeaufforderung aus:
	```sh
	pip freeze
	```
	{:pre}
	
	Sie sollten eine Liste aller Python-Module erhalten, die auf Ihrem System installiert sind. Suchen Sie in der Liste nach einem {{site.data.keyword.cloudant_short_notm}}-Eintrag ähnlich dem folgenden:

	```
	cloudant==2.3.1
	```
	{:screen}
	
	Falls das Modul `cloudant` nicht installiert ist, installieren Sie es, indem Sie einen Befehl ähnlich dem folgenden ausführen:
	
	```
	pip install cloudant==2.3.1
	```
	{:pre}

## Schritt 1: Stellen Sie eine Verbindung mit Ihrer {{site.data.keyword.cloudant_short_notm}}-Serviceinstanz unter {{site.data.keyword.Bluemix_notm}} her.

1.	Führen Sie die folgenden `import`-Anweisungen der {{site.data.keyword.cloudant_short_notm}}-Clientbibliothekskomponenten
	aus, damit Ihre Python-Anwendung eine Verbindung mit der {{site.data.keyword.cloudant_short_notm}}-Serviceinstanz herstellen kann.
	```python
	from cloudant.client import Cloudant
	from cloudant.error import CloudantException
	from cloudant.result import Result, ResultByKey
	```
	{: codeblock}

2. Ermitteln Sie die {{site.data.keyword.cloudant_short_notm}}-Serviceberechtigungsnachweise:
  1. Öffnen Sie in der {{site.data.keyword.Bluemix_notm}}-Konsole das Dashboard für Ihre Serviceinstanz.
  2. Klicken Sie in der linken Navigation auf **`Serviceberechtigungsnachweise`**.
  3. Klicken Sie unter **`AKTIONEN`** auf **`Berechtigungsnachweise anzeigen`**.

3.	Richten Sie eine Verbindung mit der Serviceinstanz ein, indem Sie den folgenden Befehl ausführen.
	Ersetzen Sie die Serviceberechtigungsnachweise aus dem vorherigen Schritt:
	```python
	client = Cloudant("<username>", "<password>", url="<url>")
	client.connect()
	```
	{: codeblock}


## Schritt 2: Erstellen Sie eine Datenbank.

1. Definieren Sie eine Variable in der Python-Anwendung:
  ```python
  databaseName = "<yourDatabaseName>"
  ```
  {: codeblock}
  Dabei ist `<yourDatabaseName>` der Name, den Sie Ihrer Datenbank geben möchten. 

  > **Hinweis:** Der Datenbankname muss mit einem Buchstaben beginnen und kann nur Kleinbuchstaben (a-z), Zahlen (0-9) und alle folgenden Zeichen enthalten: `_`, `$`, `(`, `)`, `+`, `-` und `/`.

2. Erstellen Sie die Datenbank:
  ```python
  myDatabase = client.create_database(databaseName)
  ```
  {: codeblock}

3. Bestätigen Sie, dass die Datenbank erfolgreich erstellt wurde:
  ```python
  if myDatabase.exists():
      print "'{0}' successfully created.\n".format(databaseName)
  ```
  {: codeblock}

## Schritt 3: Speichern Sie eine kleine Datensammlung in Form von Dokumenten in der Datenbank.

1. Definieren Sie eine Datensammlung:
  ```python
  sampleData = [
      [1, "one", "boiling", 100],
      [2, "two", "hot", 40],
      [3, "three", "warm", 20],
      [4, "four", "cold", 10],
      [5, "five", "freezing", 0]
    ]
  ```
  {: codeblock}

2. Verwenden Sie Python-Code, um durch die Daten zu gehen und sie in JSON-Dokumente zu konvertieren.
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
    newDocument = myDatabase.create_document(jsonDocument)

    # Prüfen Sie, dass das Dokument in der Datenbank vorhanden ist.
    if newDocument.exists():
        print "Document '{0}' successfully created.".format(number)
  ```
  {: codeblock}

Sie sollten wissen, dass wir jedes Dokument prüfen, das erfolgreich erstellt wurde.
{: tip}

## Schritt 4: Rufen Sie Daten über Abfragen ab.

Zu diesem Zeitpunkt wurde eine kleine Datensammlung in Form von Dokumenten in der Datenbank gespeichert.
Sie können einen minimalen oder einen vollständigen Abruf dieser Daten aus der Datenbank ausführen.
Ein minimaler Abruf ruft die grundlegenden Daten _über_ ein Dokument ab.
Ein vollständiger Abruf schließt auch die Daten _in_ einem Dokument ein.

* Gehen Sie wie folgt vor, um einen minimalen Abruf auszuführen:
  1. Fordern Sie zunächst eine Liste aller Dokumente in der Datenbank an.
    ```python
    result_collection = Result(myDatabase.all_docs)
    ```      
    {: codeblock}

    Diese Liste wird als Array zurückgegeben.

  2. Zeigen Sie den Inhalt eines Elements im Array an.
    ```python
    print "Retrieved minimal document:\n{0}\n".format(result_collection[0])
    ```
    {: codeblock}

    Das Ergebnis entspricht dem folgenden Beispiel:
    
    ```
    [{u'value': {u'rev': u'1-106e76a2612ea13468b2f243ea75c9b1'}, u'id': u'14be111aac74534cf8d390eaa57db888', u'key': u'14be111aac74534cf8d390eaa57db888'}]
    ```
    {:screen}
    
    > **Hinweis:** Das Präfix `u'` ist lediglich ein Hinweis darauf, dass Python eine Unicode-Zeichenfolge anzeigt. 
    
    Wenn man die weniger wichtigen Informationen außer Acht lässt, lauten die zurückgegebenen minimalen Dokumentdetails wie folgt:
    
    ```json
    [
        {
            "value": {
                "rev": "1-106e76a2612ea13468b2f243ea75c9b1"
            },
            "id": "14be111aac74534cf8d390eaa57db888",
            "key": "14be111aac74534cf8d390eaa57db888"
        }
    ]
    ```
    {:screen}

  > **Hinweis:** Das Wesen von NoSQL-Datenbanken
  wie {{site.data.keyword.cloudant_short_notm}} bedeutet, dass einfache
  Grundsätze - wie "das erste in der Datenbank gespeicherte Dokument ist immer das
  erste zurückgegebene Dokument in einer Ergebnisliste" - nicht zwangsläufig zutreffen.

* Um einen vollständigen Abruf auszuführen,
  fordern Sie eine Liste aller Dokumente in der Datenbank an
  und geben dabei mithilfe der Option `include_docs` an, dass der Dokumentinhalt ebenfalls zurückgegeben
  werden soll.
  ```python
  result_collection = Result(myDatabase.all_docs, include_docs=True)
  print "Retrieved full document:\n{0}\n".format(result_collection[0])
  ```
  {: codeblock}
  
  Das Ergebnis entspricht dem folgenden Beispiel:
  ```
  [{u'value': {u'rev': u'1-7130413a8c7c5f1de5528fe4d373045c'}, u'id': u'0cfc7d902f613d5fdb7b7818e262353b', u'key': u'0cfc7d902f613d5fdb7b7818e262353b', u'doc': {u'temperatureField': 40, u'descriptionField': u'hot', u'numberField': 2, u'nameField': u'two', u'_id': u'0cfc7d902f613d5fdb7b7818e262353b', u'_rev': u'1-7130413a8c7c5f1de5528fe4d373045c'}}]
  ```
  {: screen}
  
  Wenn man die weniger wichtigen Informationen außer Acht lässt, lauten die zurückgegebenen vollständigen Dokumentdetails wie folgt:
  
  ```json
  [
    {
      "value": {
        "rev": "1-7130413a8c7c5f1de5528fe4d373045c
      },
      "id": "0cfc7d902f613d5fdb7b7818e262353b",
      "key": "0cfc7d902f613d5fdb7b7818e262353b",
      "doc": {
        "temperatureField": 40,
        "descriptionField": "hot",
        "numberField": 2,
        "nameField": "two",
        "_id": "0cfc7d902f613d5fdb7b7818e262353b",
        "_rev": "1-7130413a8c7c5f1de5528fe4d373045c"
      }
    }
  ]
  ```
  {:screen}

## Schritt 5: Rufen Sie Daten über den {{site.data.keyword.cloudant_short_notm}}-API-Endpunkt ab.

Sie können auch eine Liste aller Dokumente und deren Inhalt anfordern, indem Sie den
{{site.data.keyword.cloudant_short_notm}}-Endpunkt [`/_all_docs`](api/database.html#get-documents) aufrufen.

1. Geben Sie den Endpunkt an, der kontaktiert werden soll, und alle Parameter, die bei diesem Aufruf bereitgestellt werden müssen:
  ```python
  end_point = '{0}/{1}'.format("<url>", databaseName + "/_all_docs")
  params = {'include_docs': 'true'}
  ```
  {: codeblock}
  Dabei ist `<url>` der URL-Wert, den Sie in den Serviceberechtigungsnachweisen in Schritt 1 gefunden haben.

2. Senden Sie die Anforderung an die Serviceinstanz
  und zeigen Sie dann die Ergebnisse an:
  ```python
  response = client.r_session.get(end_point, params=params)
  print "{0}\n".format(response.json())
  ```
  {: codeblock}

  Das Ergebnis entspricht dem folgenden _abgekürzten_ Beispiel:
  
  ```
  {u'rows': [{u'value': {u'rev': u'1-6d8cb5905316bf3dbe4075f30daa9f59'}, u'id': u'0532feb6fd6180d79b842d871316c444', u'key': u'0532feb6fd6180d79b842d871316c444', u'doc': {u'temperatureField': 20, u'descriptionField': u'warm', u'numberField': 3, u'nameField': u'three', u'_id': u'0532feb6fd6180d79b842d871316c444', u'_rev': u'1-6d8cb5905316bf3dbe4075f30daa9f59'}}, ... , {u'value': {u'rev': u'1-3f61736fa96473d358365ce1665e3d97'}, u'id': u'db396f77bbe12a567b09177b4accbdbc', u'key': u'db396f77bbe12a567b09177b4accbdbc', u'doc': {u'temperatureField': 0, u'descriptionField': u'freezing', u'numberField': 5, u'nameField': u'five', u'_id': u'db396f77bbe12a567b09177b4accbdbc', u'_rev': u'1-3f61736fa96473d358365ce1665e3d97'}}], u'total_rows': 5, u'offset': 0}
  ```
  {:screen}
  
  Wenn man die weniger wichtigen Informationen außer Acht lässt, lauten die _abgekürzten_ Details wie folgt:
  
  ```json
  {
      "rows": [
          {
              "value": {
                "rev": "1-6d8cb5905316bf3dbe4075f30daa9f59"
              },
              "id": "0532feb6fd6180d79b842d871316c444",
              "key": "0532feb6fd6180d79b842d871316c444",
              "doc": {
                  "temperatureField": 20,
                  "descriptionField": "warm",
                  "numberField": 3,
                  "nameField": "three",
                  "_id": "0532feb6fd6180d79b842d871316c444",
                  "_rev": "1-6d8cb5905316bf3dbe4075f30daa9f59"
              }
          },
          ...
          {
              "value":
              {
                "rev": "1-6d8cb5905316bf3dbe4075f30daa9f59"
              },
              "id": "db396f77bbe12a567b09177b4accbdbc",
              "key": "db396f77bbe12a567b09177b4accbdbc",
              "doc": {
                  "temperatureField": 0,
                  "descriptionField": "freezing",
                  "numberField": 5,
                  "nameField": "five",
                  "_id": "db396f77bbe12a567b09177b4accbdbc",
                  "_rev": "1-6d8cb5905316bf3dbe4075f30daa9f59"
              }
          }
      ],
      "total_rows": 5,
      "offset": 0
  }
  ```
  {:screen}

## Schritt 6: Löschen Sie die Datenbank.

Wenn Sie die Arbeit an der Datenbank abgeschlossen haben, kann sie gelöscht werden.

```python
try :
    client.delete_database(databaseName)
except CloudantException:
    print "There was a problem deleting '{0}'.\n".format(databaseName)
else:
    print "'{0}' successfully deleted.\n".format(databaseName)
```
{: codeblock}

Wir haben einige grundlegende Fehlerbehandlungsschritte eingeschlossen,
um zu veranschaulichen, wie Probleme entstehen und gelöst werden können.

## Schritt 7: Trennen Sie die Verbindung zur Serviceinstanz.

Der letzte Schritt ist das Trennen der Verbindung zwischen der Python-Clientanwendung und der Serviceinstanz.

```python
client.disconnect()
```
{: codeblock}

## Nächste Schritte

Weitere Informationen zu allen {{site.data.keyword.cloudant_short_notm}}-Angeboten finden Sie
auf der [{{site.data.keyword.cloudant_short_notm}}-Homepage ![Symbol für externen Link](images/launch-glyph.svg "Symbol für externen Link")](http://www.ibm.com/analytics/us/en/technology/cloud-data-services/cloudant/){:new_window}.

Weitere Details und Lernprogramme zu {{site.data.keyword.cloudant_short_notm}}-Konzepten,
-Tasks und -Techniken finden Sie in der [{{site.data.keyword.cloudant_short_notm}}-Dokumentation](cloudant.html).

## Anhang: Vollständige Liste von Python-Code

Die vollständige Liste von Python-Code lautet wie folgt.
Denken Sie daran, die Werte `<username>`,
`<password>`
und `<url>` durch Ihre Serviceberechtigungsnachweise zu ersetzen.
Ersetzen Sie auch den Wert `<yourDatabaseName>` durch den Namen Ihrer Datenbank.

```python
from cloudant.client import Cloudant
from cloudant.error import CloudantException
from cloudant.result import Result, ResultByKey

client = Cloudant("<username>", "<password>", url="<url>")
	client.connect()

databaseName = "<yourDatabaseName>"

myDatabase = client.create_database(databaseName)

if myDatabase.exists():
    print "'{0}' successfully created.\n".format(databaseName)

sampleData = [
    [1, "one", "boiling", 100],
    [2, "two", "hot", 40],
    [3, "three", "warm", 20],
    [4, "four", "cold", 10],
    [5, "five", "freezing", 0]
]

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
    newDocument = myDatabase.create_document(jsonDocument)

    # Prüfen Sie, dass das Dokument in der Datenbank vorhanden ist.
    if newDocument.exists():
        print "Document '{0}' successfully created.".format(number)

result_collection = Result(myDatabase.all_docs)

print "Retrieved minimal document:\n{0}\n".format(result_collection[0])

result_collection = Result(myDatabase.all_docs, include_docs=True)
print "Retrieved full document:\n{0}\n".format(result_collection[0])

end_point = '{0}/{1}'.format("<url>", databaseName + "/_all_docs")
params = {'include_docs': 'true'}
response = client.r_session.get(end_point, params=params)
print "{0}\n".format(response.json())


try :
    client.delete_database(databaseName)
except CloudantException:
    print "There was a problem deleting '{0}'.\n".format(databaseName)
else:
    print "'{0}' successfully deleted.\n".format(databaseName)

client.disconnect()

```
{: codeblock}
