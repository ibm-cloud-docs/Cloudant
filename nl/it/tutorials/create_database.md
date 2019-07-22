---

copyright:
  years: 2017, 2019
lastupdated: "2019-06-12"

keywords: close connection, delete database, request ibm cloudant api endpoint, data retrieval, store data, create database, connect to ibm cloudant

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

# Creazione e popolamento di un semplice database {{site.data.keyword.cloudant_short_notm}} su {{site.data.keyword.cloud_notm}}
{: #creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud}

Questa esercitazione illustra come utilizzare il [linguaggio di programmazione Python
![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://www.python.org/){: new_window}
per creare un database {{site.data.keyword.cloudantfull}} nella tua istanza del servizio {{site.data.keyword.cloud_notm}}
e popolarlo con una raccolta di dati semplice.
{: shortdesc}

## Prerequisiti
{: #prerequisites-create_database}

Assicurati di avere le seguenti risorse o informazioni pronte
prima di iniziare ad utilizzare l'esercitazione.

### Python
{: #python-create-database}

Devi disporre di un'installazione corrente del
[linguaggio di programmazione Python ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://www.python.org/){: new_window}
installata nel tuo sistema.

Per verificare,
esegui il seguente comando quando richiesto:

```sh
python --version
```
{: pre}

Dovresti avere un risultato simile a:

```
Python 2.7.12
```
{: codeblock}

### Libreria client Python per {{site.data.keyword.cloudant_short_notm}}
{: #python-client-library-for-ibm-cloudant}

Esiste una [libreria supportata ufficialmente](/docs/services/Cloudant?topic=cloudant-supported-client-libraries#python-supported) per abilitare le tue applicazioni Python ad utilizzare
{{site.data.keyword.cloudant_short_notm}} in {{site.data.keyword.cloud_notm}}. Utilizza le istruzioni fornite per installarla. 

Per verificare di disporre di una libreria client installata correttamente,
esegui il seguente comando quando richiesto:

```sh
pip freeze
```
{: pre}

Dovresti ottenere un elenco di tutti i moduli Python installati nel sistema.
Esamina l'elenco e cerca una voce {{site.data.keyword.cloudant_short_notm}} simile alla seguente:

```
cloudant==2.3.1
```
{: codeblock}

### Creazione di un'istanza del servizio {{site.data.keyword.cloudant_short_notm}} su {{site.data.keyword.cloud_notm}}
{: #creating-an-ibm-cloudant-service-instance-on-ibm-cloud}

Il processo di creazione di un'istanza del servizio appropriata viene descritto in [questa esercitazione](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-an-ibm-cloudant-instance-on-ibm-cloud).

Assicurati di disporre delle seguenti credenziali del servizio per la tua istanza del servizio:

Campo      | Scopo
-----------|--------
`host`     | Il nome host utilizzato dalle applicazioni per individuare l'istanza del servizio.
`username` | Il nome utente obbligatorio alle applicazioni per accedere all'istanza del servizio.
`password` | La password obbligatoria alle applicazioni per accedere all'istanza del servizio.
`port`     | Il numero di porta HTTP per l'accesso all'istanza del servizio sull'host. Normalmente 443 per forzare l'accesso HTTPS.
`url`      | Una stringa di aggregazione delle altre informazioni sulle credenziali in un solo URL, appropriata per l'utilizzo da parte delle applicazioni.

Per ulteriori informazioni su come trovare le credenziali del servizio per la tua istanza del servizio, vedi [Individuazione delle tue credenziali del servizio](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#locating-your-service-credentials).

## Contesto
{: #context}

Questa esercitazione si basa su una serie di istruzioni del linguaggio Python,
appropriate per le seguenti attività:

1.  [Connessione a un'istanza del servizio {{site.data.keyword.cloudant_short_notm}} in {{site.data.keyword.cloud}}](#connecting-to-an-ibm-cloudant-service-instance-on-ibm-cloud).
2.  [Creazione di un database nell'istanza del servizio](#creating-a-database-within-the-service-instance).
3.  [Archiviazione di una piccola raccolta di dati come documenti nel database](#storing-a-small-collection-of-data-as-documents-within-the-database).
4.  [Richiamo dei dati](#retrieving-data).
5.  [Eliminazione del database](#deleting-the-database).
6.  [Chiusura della connessione all'istanza del servizio](#closing-the-connection-to-the-service-instance).

Il codice Python specifico per ogni attività viene fornito come parte della descrizione dell'attività in questa esercitazione.

Per informazioni sul programma Python completo per eseguire tutte le attività, vedi l'[elenco completo](#complete-listing).

Non è stato effettuato un tentativo di creare del codice Python _efficiente_ per questa esercitazione;
l'intenzione è di mostrare un codice funzionante semplice e di facile comprensione
che puoi utilizzare e applicare alle tue proprie applicazioni.

Inoltre,
non è stato effettuato un tentativo di affrontare tutti i controlli possibili o le condizioni di errore.
Alcuni controlli qui mostrati, illustrano le tecniche,
ma dovresti utilizzare le procedure consigliate normali per il controllo e la gestione di tutte
le avvertenze e le condizioni di errore riscontrate dalle tue proprie applicazioni. 

## Connessione a un'istanza del servizio {{site.data.keyword.cloudant_short_notm}} su {{site.data.keyword.cloud_notm}}
{: #connecting-to-an-ibm-cloudant-service-instance-on-ibm-cloud}

Un'applicazione Python richiede che i componenti della libreria client {{site.data.keyword.cloudant_short_notm}} siano in grado di connettersi all'istanza del servizio.
Questi componenti sono identificati come istruzioni `import` normali:

```python
from cloudant.client import Cloudant
from cloudant.error import CloudantException
from cloudant.result import Result, ResultByKey
```
{: codeblock}

L'applicazione deve disporre delle [Credenziali del servizio](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#locating-your-service-credentials) per il servizio:

```python
serviceUsername = "353466e8-47eb-45ce-b125-4a4e1b5a4f7e-bluemix"
servicePassword = "49c0c343d225623956157d94b25d574586f26d1211e8e589646b4713d5de4801"
serviceURL = "https://353466e8-47eb-45ce-b125-4a4e1b5a4f7e-bluemix.cloudant.com"
```
{: codeblock}

Le credenziali del servizio qui illustrate
    sono state definite quando è stato creato un servizio dimostrativo {{site.data.keyword.cloudant_short_notm}} su {{site.data.keyword.cloud_notm}}.
    Le credenziali vengono riprodotte qui per mostrare come dovrebbero essere utilizzate in un'applicazione Python.
    Tuttavia,
    il servizio dimostrativo {{site.data.keyword.cloudant_short_notm}} è stato ora rimosso,
    per cui queste credenziali non funzioneranno;
    _devi_ fornire e utilizzare le tue proprie credenziali del servizio.
{:  tip}

Una volta che hai abilitato la libreria client Python nella tua applicazione
e identificato le credenziali del servizio,
puoi stabilire una connessione all'istanza del servizio:

```python
client = Cloudant(serviceUsername, servicePassword, url=serviceURL)
client.connect()
```
{: codeblock}

A questo punto,
la tua applicazione Python ha accesso all'istanza del servizio in {{site.data.keyword.cloud_notm}}.

## Creazione di un database nell'istanza del servizio
{: #creating-a-database-within-the-service-instance}

Il passo successivo consiste nel creare un database nell'istanza del servizio,
denominato `databasedemo`.

Lo faremo definendo una variabile nell'applicazione Python:

```python
databaseName = "databasedemo"
```
{: codeblock}

Quindi creeremo il database:

```python
myDatabaseDemo = client.create_database(databaseName)
```
{: codeblock}

È utile verificare che il database sia stato creato correttamente:

```python
if myDatabaseDemo.exists():
    print "'{0}' successfully created.\n".format(databaseName)
```
{: codeblock}

## Archiviazione di una piccola raccolta di dati come documenti nel database
{: #storing-a-small-collection-of-data-as-documents-within-the-database}

Ora vogliamo archiviare una piccola e semplice raccolta di dati
nel database.

Iniziamo identificando alcuni dati:

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

Successivamente,
eseguiamo alcuni 'passi' nel codice Python tramite i dati,
convertendoli in documenti JSON.
Ogni documento viene archiviato nel database:

```python
# Crea i documenti utilizzando i dati di esempio.
# Passa attraverso ogni riga nell'array
  per document in sampleData:
    # Richiama i campi in ogni riga.
    number = document[0]
    name = document[1]
    description = document[2]
    temperature = document[3]

    # Crea un documento JSON che rappresenta
    # tutti i dati nella riga.
    jsonDocument = {
        "numberField": number,
        "nameField": name,
        "descriptionField": description,
        "temperatureField": temperature
    }

    # Crea un documento utilizzando l'API del database.
    newDocument = myDatabaseDemo.create_document(jsonDocument)

    # Controlla che il documento esista nel database.
    if newDocument.exists():
        print "Document '{0}' successfully created.".format(number)
```
{: codeblock}

Nota che controlliamo che ogni documento sia stato creato correttamente.

## Richiamo dei dati
{: #retrieving-data}

A questo punto,
una piccola raccolta di dati
è stata archiviata come documenti nel database.
Possiamo ora eseguire una serie di query,
che illustrano diversi modi di richiamare i dati dal database.

### Un piccolo richiamo di dati di un documento
{: #a-minimal-retrieval-of-a-document}

Per eseguire un piccolo richiamo,
dobbiamo prima richiedere un elenco di tutti i documenti nel database.
Questo elenco viene restituito come un array.
Possiamo quindi visualizzare il contenuto di un elemento nell'array.

Nel codice di esempio,
richiediamo il primo documento richiamato dal database:

```python
result_collection = Result(myDatabaseDemo.all_docs)
print "Retrieved minimal document:\n{0}\n".format(result_collection[0])
```
{: codeblock}

Il risultato è simile al seguente esempio:

```json
[
    {
        "value":
            {
            "rev": "1-b2c48b89f48f1dc172d4db3f17ff6b9a"
        },
        "id": "14746fe384c7e2f06f7295403df89187",
        "key": "14746fe384c7e2f06f7295403df89187"
    }
]
```
{: codeblock}

La natura dei database NoSQL,
    come {{site.data.keyword.cloudant_short_notm}},
    indica che le semplici nozioni del primo documento memorizzato in un database
    che è sempre il primo documento restituito in un elenco di risultati,
    non vengono necessariamente applicate.
{: tip}

### Richiamo completo di un documento
{: #full-retrieval-of-a-document}

Per eseguire un richiamo completo;
richiediamo un elenco di tutti i documenti nel database
e in aggiunta specifichiamo che anche il contenuto del documento deve essere restituito.
Lo facciamo utilizzando l'opzione `include_docs`.
Come prima,
i risultati vengono restituiti come un array.
Possiamo quindi visualizzare i dettagli di un elemento nell'array,
questa volta incluso il contenuto completo del documento. 

Come prima,
richiediamo il primo documento richiamato dal database:

```python
result_collection = Result(myDatabaseDemo.all_docs, include_docs=True)
print "Retrieved minimal document:\n{0}\n".format(result_collection[0])
```
{: codeblock}

Il risultato è simile al seguente esempio:

```json
[
    {
        "value":
            {
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
{: codeblock}

## Richiamo diretto di un endpoint API {{site.data.keyword.cloudant_short_notm}}
{: #calling-an-ibm-cloudant-api-endpoint-directly}

Possiamo anche lavorare direttamente con gli endpoint API {{site.data.keyword.cloudant_short_notm}}
all'interno di un'applicazione Python.

In questo codice di esempio,
richiediamo nuovamente un elenco di tutti i documenti,
incluso il loro contenuto.
Tuttavia,
questa volta,
lo facciamo richiamando l'[endpoint `/_all_docs`](/docs/services/Cloudant?topic=cloudant-databases#get-documents) {{site.data.keyword.cloudant_short_notm}}.

Innanzitutto,
identifichiamo l'endpoint da contattare
e tutti i parametri da fornire insieme alla chiamata:

```python
end_point = '{0}/{1}'.format(serviceURL, databaseName + "/_all_docs")
params = {'include_docs': 'true'}
```
{: codeblock}

Successivamente,
inviamo la richiesta all'istanza del servizio
e quindi visualizziamo i risultati:

```python
response = client.r_session.get(end_point, params=params)
print "{0}\n".format(response.json())
```
{: codeblock}

Il risultato è simile al seguente esempio _abbreviato_:

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
{: codeblock}

## Eliminazione del database
{: #deleting-the-database}

Quando abbiamo finito con il database,
può essere eliminato.

Questo è un passo semplice
come mostrato nel seguente codice Python di esempio:

```python
try :
    client.delete_database(databaseName)
except CloudantException:
    print "There was a problem deleting '{0}'.\n".format(databaseName)
else:
    print "'{0}' successfully deleted.\n".format(databaseName)
```
{: codeblock}

Abbiamo incluso la gestione di alcuni errori di base per illustrare
come potrebbero venire riscontrati e risolti dei problemi.

## Chiusura della connessione all'istanza del servizio
{: #closing-the-connection-to-the-service-instance}

Il passo finale consiste nel disconnettere l'applicazione client Python dall'istanza del servizio:

```python
client.disconnect()
```
{: codeblock}

## Elenco completo
{: #complete-listing}

Il seguente codice è un programma Python completo per accedere a un'istanza del servizio
{{site.data.keyword.cloudant_short_notm}} in {{site.data.keyword.cloud_notm}}
ed eseguire una serie di attività tipiche:

1.  Connessione all'istanza del servizio.
2.  Creazione di un database nell'istanza del servizio.
3.  Archiviazione di una piccola raccolta di dati come documenti nel database.
4.  Richiamo di un elenco completo dei documenti.
5.  Eliminazione del database.
6.  Chiusura della connessione all'istanza del servizio.

```python
# 1.  Connessione all'istanza del servizio.

# Abilita le librerie Python obbligatorie.

from cloudant.client import Cloudant
from cloudant.error import CloudantException
from cloudant.result import Result, ResultByKey

# Variabili utili
serviceUsername = "353466e8-47eb-45ce-b125-4a4e1b5a4f7e-bluemix"
servicePassword = "49c0c343d225623956157d94b25d574586f26d1211e8e589646b4713d5de4801"
serviceURL = "https://353466e8-47eb-45ce-b125-4a4e1b5a4f7e-bluemix.cloudant.com"

# Questo è il nome del database che stiamo utilizzando.
databaseName = "databasedemo"

# Questa è una raccolta di dati semplice,
# per l'archiviazione all'interno del database.
sampleData = [
    [1, "one", "boiling", 100],
    [2, "two", "hot", 40],
    [3, "three", "warm", 20],
    [4, "four", "cold", 10],
    [5, "five", "freezing", 0]
]

# Avvia la demo.
print "===\n"

# Utilizza la libreria {{site.data.keyword.cloudant_short_notm}} per creare un client {{site.data.keyword.cloudant_short_notm}}.
client = Cloudant(serviceUsername, servicePassword, url=serviceURL)

# Connettiti al server
client.connect()

# 2.  Creazione di un database nell'istanza del servizio.

# Crea un'istanza del database.
myDatabaseDemo = client.create_database(databaseName)

# Verifica che il database ora esista.
if myDatabaseDemo.exists():
    print "'{0}' successfully created.\n".format(databaseName)

# Distanzia i risultati.
print "----\n"

# 3.  Archiviazione di una piccola raccolta di dati come documenti nel database.

# Crea i documenti utilizzando i dati di esempio.
# Passa attraverso ogni riga nell'array
  per document in sampleData:
    # Richiama i campi in ogni riga.
    number = document[0]
    name = document[1]
    description = document[2]
    temperature = document[3]

    # Crea un documento JSON che rappresenta
    # tutti i dati nella riga.
    jsonDocument = {
        "numberField": number,
        "nameField": name,
        "descriptionField": description,
        "temperatureField": temperature
    }

    # Crea un documento utilizzando l'API del database.
    newDocument = myDatabaseDemo.create_document(jsonDocument)

    # Controlla che il documento esista nel database.
    if newDocument.exists():
        print "Document '{0}' successfully created.".format(number)

# Distanzia i risultati.
print "----\n"

# 4.  Richiamo di un elenco completo dei documenti.

# Richiamo semplice e minimo del primo
# documento nel database.
result_collection = Result(myDatabaseDemo.all_docs)
print "Retrieved minimal document:\n{0}\n".format(result_collection[0])

# Richiamo semplice e completo del primo
# documento nel database.
result_collection = Result(myDatabaseDemo.all_docs, include_docs=True)
print "Retrieved full document:\n{0}\n".format(result_collection[0])

# Distanzia i risultati.
print "----\n"

# Utilizza un endpoint API {{site.data.keyword.cloudant_short_notm}} per richiamare
# tutti i documenti nel database,
# incluso il loro contenuto.

# Definisci l'endpoint e i parametri
end_point = '{0}/{1}'.format(serviceURL, databaseName + "/_all_docs")
params = {'include_docs': 'true'}

# Emetti la richiesta
response = client.r_session.get(end_point, params=params)

# Visualizza il contenuto della risposta
print "{0}\n".format(response.json())

# Distanzia i risultati.
print "----\n"

# Tutto eseguito.
# Tempo di riordinare.

# 5.  Eliminazione del database.

# Elimina il database di test.
try :
    client.delete_database(databaseName)
except CloudantException:
    print "There was a problem deleting '{0}'.\n".format(databaseName)
else:
    print "'{0}' successfully deleted.\n".format(databaseName)

# 6.  Chiusura della connessione all'istanza del servizio.

# Disconnettiti dal server
client.disconnect()

# Termina la demo.
print "===\n"

# Arrivederci.
exit()
```
{: codeblock}
