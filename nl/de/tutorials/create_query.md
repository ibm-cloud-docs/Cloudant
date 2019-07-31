---

copyright:
  years: 2017, 2019
lastupdated: "2019-06-12"

keywords: create database, create documents, create index, create query, run query, fields, operators

subcollection: cloudant

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:tip: .tip}
{:note: .note}
{:important: .important}
{:deprecated: .deprecated}

<!-- Acrolinx: 2017-05-10 -->

# {{site.data.keyword.cloudant_short_notm}}-Abfrage erstellen
{: #creating-an-ibm-cloudant-query}

In diesem Lernprogramm erfahren Sie, wie Sie eine Datenbank erstellen, mit Dokumenten
füllen, einen Index erstellen und mit diesem die Datenbank abfragen.
{: shortdesc}

Es werden Übungen für die ![Symbol für Befehlszeile](../images/CommandLineIcon.png) _Befehlszeile_
und für das ![Symbol für Dashboard](../images/DashboardIcon.png) _{{site.data.keyword.cloud}}-Dashboard_ zur Verfügung gestellt. Die
Übungen für das {{site.data.keyword.cloud_notm}}-Dashboard liefern Ihnen ein visuelles Beispiel für jede Task. Im gesamten Lernprogramm können Sie auf die Links klicken, um
weitere Informationen zu erhalten.

Sie beginnen, indem Sie die Datenbank `query-demo` erstellen, sowie ein paar Dokumente, die
die Daten für diese Übungen enthalten.

## Voraussetzungen
{: ##assumptions}

Führen Sie zunächst die folgenden Schritte aus, um sich auf das Lernprogramm vorzubereiten:

1.  [Erstellen Sie ein {{site.data.keyword.cloud_notm}}-Konto ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://cloud.ibm.com/registration){: new_window}.
2.  Melden Sie sich beim
  [{{site.data.keyword.cloud_notm}}-Dashboard ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://cloud.ibm.com/catalog/services/cloudant){: new_window} an.
3.  [Erstellen Sie eine {{site.data.keyword.cloudant_short_notm}}-Instanz unter {{site.data.keyword.cloud_notm}}](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-a-service-instance).
4.  (Optional) [Erstellen Sie einen Alias 'acurl'](/docs/services/Cloudant?topic=cloudant-authorized-curl-acurl-#authorized-curl-acurl-), um einfacher und schneller Befehle über die Befehlszeile ausführen zu können.
5.  Ersetzen Sie die Variable `$ACCOUNT` in den Befehlen, die in den Übungen enthalten sind, durch den Benutzernamen, den Sie verwenden, um sich beim {{site.data.keyword.cloudant_short_notm}}-Dashboard anzumelden.
  Wenn Sie sich entscheiden, `acurl` nicht einzurichten,
  verwenden Sie die folgende URL statt eine der in den Übungen angegebenen:
  ``` sh
  curl https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com/query-demo
  ```
  {: codeblock}

## Datenbank `query-demo` erstellen
{: #creating-the-query-demo-database}

In diesem Abschnitt erstellen Sie die [Datenbank](/docs/services/Cloudant?topic=cloudant-databases#create-database) `query-demo`.
Dies ist die Datenbank, die im vorliegenden Lernprogramm verwendet wird.

Im vorliegenden Lernprogramm wird der Alias `acurl` anstelle des Befehls `curl` verwendet. Der Alias `acurl` wird mithilfe der unter [Authorized curl: `acurl`](/docs/services/Cloudant?topic=cloudant-authorized-curl-acurl-#authorized-curl-acurl-) beschriebenen Schritte erstellt. Wenn Sie lieber den Befehl `curl`
  oder eine andere Methode zum Aufrufen von API-Endpunkten verwenden möchten,
  geben Sie Ihren Befehl im Lernprogramm an,
  ebenso wie die für Ihren Befehl erforderlichen Parameter
  wie Benutzername und Kennwort.
{: tip}

![Symbol für Befehlszeile](../images/CommandLineIcon.png) _Befehlszeile_

1.  Erstellen Sie eine Datenbank, indem Sie diesen Befehl ausführen:
  ``` sh
  acurl https://$ACCOUNT.cloudant.com/query-demo -X PUT
  ```
  {: codeblock}
2.  Überprüfen Sie die Ergebnisse:
  ```json
  {
    "ok": true
  }
  ```
  {: codeblock}

![Symbol für Dashboard](../images/DashboardIcon.png) _{{site.data.keyword.cloud_notm}}-Dashboard_

1.  Öffnen Sie die {{site.data.keyword.cloudant_short_notm}}-Serviceinstanz, die Sie erstellt haben.
2.  Klicken Sie auf der {{site.data.keyword.cloudant_short_notm}}-Serviceseite auf **Starten**.
    Die Registerkarte mit den Datenbanken wird geöffnet.
    
  ![Registerkarte 'Datenbanken'](../images/tabs.png)
4.  Klicken Sie auf **Datenbank erstellen**.
5.  Geben Sie `query-demo` ein und klicken Sie auf **Erstellen**.

  Die Datenbank `query-demo` wird automatisch geöffnet.

## Dokumente in der Datenbank erstellen
{: #creating-documents-in-the-database}

Die [Dokumente](/docs/services/Cloudant?topic=cloudant-documents#documents),
die Sie in dieser Übung erstellen, enthalten die Daten, mit denen Sie die Datenbank `query-demo` in späteren Übungen abfragen.

![Symbol für Befehlszeile](../images/CommandLineIcon.png) _Befehlszeile_

1.  Kopieren Sie den Beispieltext in eine Datendatei namens `bulkcreate.dat`, um fünf Dokumente zu erstellen:
  ```json
  {
    "docs":
    [
      {
        "_id": "doc1",
        "firstname": "Sally",
        "lastname": "Brown",
        "age": 16,
        "location": "New York City, NY"
      },
      {
        "_id": "doc2",
        "firstname": "John",
        "lastname": "Brown",
        "age": 21,
        "location": "New York City, NY"
      },
      {
        "_id": "doc3",
        "firstname": "Greg",
        "lastname": "Greene",
        "age": 35,
        "location": "San Diego, CA"
      },
      {
        "_id": "doc4",
        "firstname": "Anna",
        "lastname": "Greene",
        "age": 44,
        "location": "Baton Rouge, LA"
      },
      {
        "_id": "doc5",
        "firstname": "Lois",
        "lastname": "Brown",
        "age": 33,
        "location": "Syracuse, NY"
      }
    ]
  }
  ```
  {: codeblock}

2.  Führen Sie diesen Befehl aus, um die Dokumente zu erstellen:
  ```sh
  acurl https://$ACCOUNT.cloudant.com/query-demo/_bulk_docs -X POST -H "Content-Type: application/json" -d \@bulkcreate.dat
  ```
  {: codeblock}

Beachten Sie, dass das Symbol '`@`', das angibt, dass die Daten in einer Datei enthalten sind, durch den bereitgestellten Namen identifiziert wird.
{: tip}

3.  Überprüfen Sie die Ergebnisse:
  ```json
  [
    {
      "ok":true,
      "id":"doc1",
      "rev":"1-57a08e644ca8c1bb8d8931240427162e"
    },
    {
      "ok":true,
      "id":"doc2",
      "rev":"1-bf51eef712165a9999a52a97e2209ac0"
    },
    {
      "ok":true,
      "id":"doc3",
      "rev":"1-9c9f9b893fcdd1cbe09420bc4e62cc71"
    },
    {
      "ok":true,
      "id":"doc4",
      "rev":"1-6aa4873443ddce569b27ab35d7bf78a2"
    },
    {
      "ok":true,
      "id":"doc5",
      "rev":"1-d881d863052cd9681650773206c0d65a"
    }
  ]
  ```
  {: codeblock}

![Symbol für Dashboard](../images/DashboardIcon.png) _{{site.data.keyword.cloud_notm}}-Dashboard_

1.  Klicken Sie auf **`+`** und wählen Sie **Neues Dokument** aus. Das Fenster 'Neues Dokument' wird geöffnet.
2.  Um ein Dokument zu erstellen, kopieren Sie den folgenden Beispieltext und ersetzen den vorhandenen Text in dem neuen Dokument.

  _Erstes Beispieldokument_:
  ```json
  {
    "firstname": "Sally",
    "lastname": "Brown",
    "age": 16,
    "location": "New York City, NY",
    "_id": "doc1"
  }
  ```
  {: codeblock}

3.  Wiederholen Sie Schritt 2, um die restlichen Dokumente zur Datenbank hinzuzufügen.

  _Zweites Beispieldokument_:
  ```json
  {
    "firstname": "John",
    "lastname": "Brown",
    "age": 21,
    "location": "New York City, NY",
    "_id": "doc2"
  }
  ```
  {: codeblock}

  _Drittes Beispieldokument_:
  ```json
  {
    "firstname": "Greg",
    "lastname": "Greene",
    "age": 35,
    "location": "San Diego, CA",
    "_id": "doc3"
  }
  ```
  {: codeblock}

  _Viertes Beispieldokument_:
  ```json
  {
    "firstname": "Anna",
    "lastname": "Greene",
    "age": 44,
    "location": "Baton Rouge, LA",
    "_id": "doc4"
  }
  ```
  {: codeblock}

  _Fünftes Beispieldokument_:
  ```json
  {
    "firstname": "Lois",
    "lastname": "Brown",
    "age": 33,
    "location": "New York City, NY",
    "_id": "doc5"
  }
  ```
  {: codeblock}

  Die Datenbank `query-demo` wurde mit fünf Datensätzen gefüllt. Diese Datensätze werden in der Tabellenansicht im folgenden Screenshot angezeigt:

  ![Beispieldokumente](../images/docs1.png)     

## Index zum Abfragen der Datenbank erstellen
{: #creating-an-index-to-query-the-database}

{{site.data.keyword.cloudant_short_notm}} stellt Ansichten und Indizes zum Abfragen der Datenbank bereit. Eine Ansicht führt eine Abfrage aus, die in der Datenbank gespeichert ist, und das Ergebnis wird Ergebnismenge genannt. Wenn Sie eine Abfrage an die Ansicht übergeben, durchsucht Ihre Abfrage die Ergebnismenge. Ein Index ist eine Möglichkeit, Daten zu strukturieren, um die Abrufzeit zu verbessern.

In diesem Lernprogramm wird {{site.data.keyword.cloudant_short_notm}} Query verwendet, das eine Abfragesyntax im Mongo-Stil für die Suche nach Dokumenten mithilfe logischer Operatoren verwendet. {{site.data.keyword.cloudant_short_notm}} Query ist eine Kombination aus einer Ansicht und einem Suchindex.

Wenn Sie {{site.data.keyword.cloudant_short_notm}} Query verwenden, durchsucht der Abfrageplanner den Selektor (Ihre Abfrage), um den richtigen Index für die Auswahl zu ermitteln. Wenn kein passender Index gefunden wird, wird der Sonderindex `_all_docs` verwendet, der anhand der ID nach Dokumenten sucht. Im ungünstigsten Fall werden alle Dokumente nach ID zurückgegeben (vollständige Tabellensuche). Im Speicher werden die Dokumente mithilfe des Selektors herausgefiltert (d. h. Sie können auch ohne Index nach verschiedenen Feldern abfragen). Vollständige Tabellensuchen sind kostenintensiv, daher empfehlen wir, einen Index zu erstellen. Eine Beschreibung der verschiedenen Indextypen finden Sie in der folgenden Liste:

*	Primärindex – Suche nach einem Dokument oder einer Liste von Dokumenten nach ID.  
*	[Ansicht](/docs/services/Cloudant?topic=cloudant-views-mapreduce#views-mapreduce) – Suche nach Informationen in der Datenbank, die den angegebenen Suchkriterien entsprechen, z. B. Anzahlen, Summen, Durchschnitte und andere mathematische Funktionen. Die Kriterien, nach den Sie suchen können, sind in der Definition der Ansicht angegeben. Ansichten verwenden das MapReduce-Konzept.
*	[Suchindex](/docs/services/Cloudant?topic=cloudant-search#search) – Suche nach mindestens einem Feld bzw. nach großen Mengen von Text oder Verwendung von Platzhaltern, unscharfer Suche oder Facetten mit [Lucene QueryParsers-Syntax ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://lucene.apache.org/core/4_3_0/queryparser/org/apache/lucene/queryparser/classic/package-summary.html#Overview){: new_window}.

Wenn kein definierter Index verfügbar ist, der mit der angegebenen Abfrage übereinstimmt, verwendet {{site.data.keyword.cloudant_short_notm}} den Index `_all_docs`.
{: tip}


![Symbol für Befehlszeile](../images/CommandLineIcon.png) _Befehlszeile_

1.  Kopieren Sie die folgenden JSON-Beispieldaten in eine Datei namens `query-index.dat`.
  ```json
{
	"index": {
		"fields": [
			"age",
			"lastname"
		],
		"partial_filter_selector": {
			"age": {
				"$gte": 30
			},
			"lastname": {
				"$eq": "Greene"
			}
		}
	},
  		"ddoc": "partial-index",
		"type": "json"
}
  ```
  {: codeblock}

2.  Führen Sie den folgenden Befehl aus, um einen Index zu erstellen:
  ```sh
  acurl https://$ACCOUNT.cloudant.com/query-demo/_index -X POST -H "Content-Type: application/json" -d \@query-index.dat
  ```
  {: codeblock}

3.  Überprüfen Sie die Ergebnisse:
  ```json
  {
    "result":"created",
    "id":"_design/752c7031f3eaee0f907d18e1424ad387459bfc1d",
    "name":"query-index"
  }
  ```
  {: codeblock}



![Symbol für Dashboard](../images/DashboardIcon.png) _{{site.data.keyword.cloud_notm}}-Dashboard_

1.  Klicken Sie auf **`+` > Abfrageindizes** auf der Registerkarte **Alle Dokumente** oder auf der Registerkarte **Entwurfsdokumente**.
2.  Fügen Sie die folgenden JSON-Beispieldaten in das Feld **Index** ein:
  ```json
  {
	"index": {
		"fields": [
			"age",
			"lastname"
		],
		"partial_filter_selector": {
			"age": {
				"$gte": 30
			},
			"lastname": {
				"$eq": "Greene"
			}
		}
	},
  		"ddoc": "partial-index",
		"type": "json"
  }
  ```
  {: codeblock}

  Der Index wurde erstellt. Der Index wird im folgenden Screenshot angezeigt:

  ![Abfrageindex](../images/query-index1.png)



## Abfrage erstellen
{: #creating-a-query}

Mithilfe von Abfragen können Sie Ihre Daten aus {{site.data.keyword.cloudant_short_notm}} extrahieren. Eine gut formulierte
[Abfrage](/docs/services/Cloudant?topic=cloudant-query#query) kann Ihre Suche und die zurückgegebenen Ergebnisse eingrenzen,
damit nur die gewünschten Daten enthalten sind.

In dieser Übung wird gezeigt, wie Sie eine einfache Abfrage, eine Abfrage mit zwei Feldern und eine Abfrage mit zwei [Operatoren](/docs/services/Cloudant?topic=cloudant-query#operators) schreiben und ausführen können.
Sie führen eine Abfrage mit einem Operator aus, indem Sie mindestens ein Feld und den zugehörigen Wert angeben.
Die Abfrage führt dann diesen Wert aus, um in der Datenbank nach Übereinstimmungen zu suchen.

Bei allen außer den einfachsten Abfragen fügen Sie die JSON zu einer Datendatei hinzu und führen sie über die Befehlszeile aus.

### Einfache Abfrage ausführen
{: #running-a-simple-query}

In diesem Beispiel wird veranschaulicht, wie {{site.data.keyword.cloudant_short_notm}} Query `query-index` verwendet,
um das Element `lastname` zu finden, und die Ergebnisse im Speicher filtert, um das Element `firstname` zu finden.   

![Symbol für Befehlszeile](../images/CommandLineIcon.png) _Befehlszeile_

1.  Kopieren Sie die folgende Beispiel-JSON in eine Datendatei namens `query1.dat`.
  ```json
    {
      "selector": {
            "lastname" : "Greene",
            "firstname" : "Anna"            
         }        
    }       
  ```    
  {: codeblock}

2.  Führen Sie den folgenden Befehl aus, um die Datenbank abzufragen:
  ```sh
  acurl https://$ACCOUNT.cloudant.com/query-demo/_find -X POST -H "Content-Type: application/json" -d \@query1.dat
  ```
  {: codeblock}

3.  Überprüfen Sie die Abfrageergebnisse:
  ```json
  {
    "docs": [
      {
        "_id":"doc4",
        "_rev":"3-751ab049e8b5dd1ba045cea010a33a72",
            "firstname":"Anna",
            "lastname":"Greene",
            "age":44,
            "location":"Baton Rouge, LA"
      }
    ]
  }
  ```
  {: codeblock}

![Symbol für Dashboard](../images/DashboardIcon.png) _{{site.data.keyword.cloud_notm}}-Dashboard_

1.  Klicken Sie auf die Registerkarte **Abfrage**.
2.  Kopieren Sie die folgenden JSON-Beispieldaten und fügen Sie sie in das {{site.data.keyword.cloudant_short_notm}} Query-Fenster ein:
  ```json
   {
      "selector": {
            "lastname" : "Greene",
            "firstname" : "Anna"            
         }        
   }
  ```
  {: codeblock}

3.  Klicken Sie auf **Abfrage ausführen**.

  Die Abfrageergebnisse werden angezeigt. Diese werden in der Tabellenansicht im folgenden Screenshot angezeigt:

  ![Ergebnisse von Abfrage 1](../images/dashboard_query1_results.png)

### Abfrage mit zwei Feldern ausführen
{: #running-a-query-with-two-fields}

In diesem Beispiel werden zwei Felder verwendet, um alle Personen namens `Brown` zu finden, die in `New York City, NY` leben.

Wir beschreiben die Suche anhand eines [Selektorausdrucks](/docs/services/Cloudant?topic=cloudant-query#selector-syntax) ähnlich dem folgenden Beispiel:
```json
  {
    "selector": {
      "lastname": "Brown",
      "location": "New York City, NY"
    }
  }
```
{: codeblock}

Wir können die Ergebnisse so anpassen, dass sie unsere Anforderungen erfüllen, indem wir weitere Details im Selektorausdruck angeben.
Der Parameter `fields` gibt die Felder an, die in die Ergebnisse eingeschlossen werden sollen. In unserem Beispiel enthalten die
Ergebnisse den Vornamen, den Nachnamen und den Standort. Die Ergebnisse werden in aufsteigender Reihenfolge nach Vorname sortiert, basierend auf den Werten im Parameter `sort`.
Die zusätzlichen Details entsprechen dem folgenden Beispiel:
```json
{
  ...
  "fields" : [
    "firstname",
      "lastname",
      "location"
  ]
}
```  
{: codeblock}

![Symbol für Befehlszeile](../images/CommandLineIcon.png) _Befehlszeile_

1.  Kopieren Sie die Beispiel-JSON in eine Datendatei namens `query2.dat`.
  ```json
  {
    "selector": {
      "lastname": "Brown",
      "location": "New York City, NY"
    },
    "fields": [
     "firstname",
     "lastname",
     "location"
  ]
  }
  ```
  {: codeblock}

2.  Führen Sie den folgenden Befehl aus, um die Datenbank abzufragen:
  ```sh
  acurl https://$ACCOUNT.cloudant.com/query-demo/_find -X POST -H "Content-Type: application/json" -d \@query2.dat
  ```
  {: codeblock}

3.  Überprüfen Sie die Abfrageergebnisse:
  ```json
  {
    "docs": [
      {
        "firstname": "Sally",
        "lastname": "Brown",
        "location": "New York City, NY"
      },
      {
        "firstname": "John",
        "lastname": "Brown",
        "location": "New York City, NY"
      },
      {
        "firstname": "Lois",
        "lastname": "Brown",
        "location": "New York City, NY"
      }
    ]
  }
  ```
  {: codeblock}

![Symbol für Dashboard](../images/DashboardIcon.png) _{{site.data.keyword.cloud_notm}}-Dashboard_

1.  Klicken Sie auf die Registerkarte **Abfrage**.
2.  Kopieren Sie die folgenden JSON-Beispieldaten und fügen Sie sie in das {{site.data.keyword.cloudant_short_notm}} Query-Fenster ein:
  ```json
  {
    "selector": {
      "lastname": "Brown",
      "location": "New York City, NY"
    },
    "fields": [
      "firstname",
      "lastname",
      "location"
    ] 
  }
  ```
  {: codeblock}

3.  Klicken Sie auf **Abfrage ausführen**.

  Die Abfrageergebnisse werden angezeigt. Diese werden in der Tabellenansicht im folgenden Screenshot angezeigt:

  ![Ergebnisse von Abfrage 2](../images/dashboard_query2_results.png)

### Abfrage mit Operatoren ausführen
{: #running-a-query-with-operators}

In diesem Beispiel werden die Operatoren `$eq` (gleich) und `$gt` (größer als) verwendet, um nach
Dokumenten zu suchen, die den Nachnamen `Greene` und eine Altersangabe größer als `30` enthalten.

Wir verwenden einen Selektorausdruck wie im folgenden Beispiel:
```json
{
  "selector": {
    "age": {
      "$gt": 30
    },
    "lastname": {
      "$eq": "Greene"
    }
  }
}
``` 
{: codeblock}

Die Ergebnisse werden in aufsteigender Reihenfolge nach Alter sortiert, basierend auf den Werten im Parameter `sort`.

```json
    "sort": [
      {
        "age": "asc"
      }
    ] 
```  
{: codeblock}

![Symbol für Befehlszeile](../images/CommandLineIcon.png) _Befehlszeile_

1.  Kopieren Sie die folgende Beispiel-JSON in eine Datei namens `query3.dat`.
  ```json
  {
   "selector": {
      "age": {
         "$gt": 30
      },
      "lastname": {
         "$eq": "Greene"
      }
   },
    "fields": [
      "age",
      "firstname"
   ],
    "sort": [
      {
         "age": "asc"
      }
   ],
   "use_index": "_design/partial-index"
  }
  ```
  {: codeblock}

2. Führen Sie diese Abfrage aus:
  ```sh
  acurl https://$ACCOUNT.cloudant.com/query-demo/_find -X POST -H "Content-Type: application/json" -d \@query3.dat
  ```
  {: codeblock}

3.  Überprüfen Sie die Abfrageergebnisse:
  ```json
  {"docs":[
     {"age":35,"firstname":"Greg"},
     {"age":44,"firstname":"Anna"}
   ],
  "bookmark": "g1AAAABCeJzLYWBgYMpgSmHgKy5JLCrJTq2MT8lPzkzJBYqzAFkmIDkOmFwOSHWiDkiSzb0oNTUvNSsLAEsmEeQ"
  }
  ```
  {: codeblock}

![Symbol für Dashboard](../images/DashboardIcon.png) _{{site.data.keyword.cloud_notm}}-Dashboard_

1.  Klicken Sie auf die Registerkarte **Abfrage**.
2.  Kopieren Sie die folgenden JSON-Beispieldaten und fügen Sie sie in das {{site.data.keyword.cloudant_short_notm}} Query-Fenster ein:
  ```json
  {
   "selector": {
      "age": {
         "$gt": 30
      },
      "lastname": {
         "$eq": "Greene"
      }
   },
    "fields": [
      "age",
      "firstname"
   ],
    "sort": [
      {
         "age": "asc"
      }
   ],
   "use_index": "_design/partial-index"
  }
  ```
  {: codeblock}

3.  Klicken Sie auf **Abfrage ausführen**.

  Die Abfrageergebnisse werden angezeigt. Diese werden in der Tabellenansicht im folgenden Screenshot angezeigt:

  ![Ergebnisse von Abfrage 3](../images/dashboard_query3_results.png)

Weitere Informationen zu {{site.data.keyword.cloudant_short_notm}} finden Sie in der [{{site.data.keyword.cloudant_short_notm}}-Dokumentation](/docs/services/Cloudant?topic=cloudant-overview#overview).
