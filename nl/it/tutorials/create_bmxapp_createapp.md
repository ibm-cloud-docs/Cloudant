---

copyright:
  years: 2017
lastupdated: "2017-01-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-01-11 -->

# Creazione di un'applicazione Bluemix di esempio per accedere a un database Cloudant: il codice

Questa sezione dell'esercitazione illustra il codice
per un'applicazione {{site.data.keyword.Bluemix}}.
{:shortdesc}

<div id="theApp"></div>

## Creazione della tua applicazione

I seguenti componenti sono ora disponibili,
pronti per iniziare a creare l'applicazione:

-   [Il linguaggio di programmazione Python](create_bmxapp_prereq.html#python).
-   [Un'istanza del database {{site.data.keyword.cloudant_short_notm}}](create_bmxapp_prereq.html#csi).
-   [Un ambiente dell'applicazione {{site.data.keyword.Bluemix_notm}}](create_bmxapp_appenv.html#creating).
-   Un [collegamento](create_bmxapp_appenv.html#connecting) tra l'istanza del database {{site.data.keyword.cloudant_short_notm}}
    e l'ambiente dell'applicazione {{site.data.keyword.Bluemix_notm}}.
-   I [toolkit](create_bmxapp_appenv.html#toolkits) per le applicazioni {{site.data.keyword.Bluemix_notm}} basate su Cloud Foundry.
-   Un [pacchetto applicazione 'starter'](create_bmxapp_appenv.html#starter), che contiene i file del modello di codice e la configurazione iniziale.

>   **Nota**: non è stato effettuato un tentativo di creare del codice Python _efficiente_ per questa esercitazione.
    L'intenzione è di mostrare un codice funzionante semplice e di facile comprensione
che puoi utilizzare e applicare alle tue proprie applicazioni.
    Inoltre,
non è stato effettuato un tentativo di affrontare tutti i controlli possibili o le condizioni di errore.
    Alcuni controlli di esempio sono inclusi per illustrare alcune tecniche.
    Nelle tue applicazioni,
    verifica
    e gestisci tutte le condizioni
    di errore e avvertenza.

### File essenziali

La tua applicazione necessita di tre file di configurazione e un file di origine,
tutti disponibili nel [pacchetto applicazione 'starter'](create_bmxapp_appenv.html#starter):
 
-   ['`Procfile`'](create_bmxapp_appenv.html#procfile)
-   ['`manifest.yml`'](create_bmxapp_appenv.html#manifest)
-   ['`requirements.txt`'](create_bmxapp_appenv.html#requirements)
-   Il file di origine dell'applicazione, che viene descritto in questo sezione dell'esercitazione.

Modifica i tuoi file di configurazione nel seguente modo:

1.  Modifica il file '`Procfile`' in modo che contenga il seguente testo:
    ```
    web: python server.py
    ```
    {:codeblock}

2.  Modifica il file '`manifest.yml`' in modo che contenga il seguente testo:
    ```
    applications:
- path: .
      memory: 128M
      instances: 1
      domain: <your domain>
      name: <your application name>
      host: <your application host>
      disk_quota: 1024M
      services:
      - <your database instance>
    ```
    {:codeblock}
    >   **Nota**: assicurati di modificare i valori '`domain`', '`name`', '`host`' e '`services`'. Questi sono i valori che sono stati immessi quando hai creato il tuo [ambiente dell'applicazione {{site.data.keyword.Bluemix_notm}}](create_bmxapp_appenv.html#creating) e la tua [istanza del database {{site.data.keyword.cloudant_short_notm}}](create_bmxapp_prereq.html#csi).

3.  Modifica il file '`requirements.txt`' in modo che contenga il seguente testo:
    ```
    cloudant==2.3.1
    ```
    {:codeblock}

### Il codice dell'applicazione

Il passo successivo è di lavorare sul codice dell'applicazione.
Ogni sezione viene descritta e viene presentato il codice.
Un [elenco completo](#complete-listing) del codice dell'applicazione
si trova alla fine dell'esercitazione.

#### Introduzione

L'applicazione Python necessita di alcuni componenti di base per funzionare.
Vengono importati nel seguente modo:

```python
# Rendi i moduli Python disponibili.
import os
import json

# È utile avere accesso agli strumenti
# per la formattazione dei valori ora e data.
from time import gmtime, strftime
```
{:codeblock}

L'applicazione funziona come un server web semplice,
visualizzando solo una pagina:
un log contenente i risultati del collegamento all'istanza del database {{site.data.keyword.cloudant_short_notm}}
e la creazione di un database.

L'applicazione richiede i componente per servire come una pagina web:

```python
# Accesso semplificato agli strumenti del server web Python di base.
try:
    from SimpleHTTPServer import SimpleHTTPRequestHandler as Handler
    from SocketServer import TCPServer as Server
except ImportError:
    from http.server import SimpleHTTPRequestHandler as Handler
    from http.server import HTTPServer as Server
```
{:codeblock}

>   **Nota**: questo segmento di codice viene fornito come parte del [pacchetto applicazione 'starter'](create_bmxapp_appenv.html#starter).

L'applicazione si collega all'istanza del database {{site.data.keyword.cloudant_short_notm}},
per cui deve importare i componenti della libreria {{site.data.keyword.cloudant_short_notm}}:

```python
# Abilita le librerie Python obbligatorie da utilizzare con Cloudant.
from cloudant.client import Cloudant
from cloudant.error import CloudantException
from cloudant.result import Result, ResultByKey
```
{:codeblock}

L'applicazione crea un database nell'istanza del database {{site.data.keyword.cloudant_short_notm}}.
Un nome è obbligatorio per il database:

```python
# Questo è il nome del database che intendiamo creare.
databaseName = "databasedemo"
```
{:codeblock}

L'applicazione registra l'avanzamento come si collega all'istanza del database
{{site.data.keyword.cloudant_short_notm}}
e crea il database.
Il record prende la forma di un file di log,
che viene archiviato in una cartella dal server web Python.

Crea una cartella (denominata '`static`' nell'applicazione)
e stai pronto ad archiviare il file in essa:

```python
# Modifica la directory corrente per evitare l'esposizione dei file del controllo
try:
    os.mkdir('static')
except OSError:
    # La directory già esiste,
    # non è necessario crearla.
    pass
os.chdir('static')
```
{:codeblock}

Successivamente,
crea un file HTML semplice.
Il file contiene il log di ogni attività come l'applicazione crea il database:

```python
# Inizia creando una pagina web molto semplice.
filename = "index.html"
target = open(filename, 'w')
target.truncate()
target.write("<html><head><title>Demo Cloudant Python</title></head><body><p>Log dei passi Cloudant Python...</p><pre>")
```
{:codeblock}

La prima parte del log è un record della data e ora correnti.
Questo record aiuta a confermare che il database è stato realmente appena creato:

```python
# Inserisci un'indicazione chiara della data e ora correnti all'inizio della pagina.
target.write("====\n")
target.write(strftime("%Y-%m-%d %H:%M:%S", gmtime()))
target.write("\n====\n\n")
```
{:codeblock}

#### Utilizzo dell'istanza del database Cloudant

L'applicazione Python viene eseguita in un ambiente dell'applicazione {{site.data.keyword.Bluemix_notm}}.
L'ambiente fornisce tutte le informazioni necessarie sull'applicazione per accedere ai servizi collegati.
Le informazioni vengono fornite in una variabile di ambiente,
denominata '`VCAP_SERVICES`'.
È possibile accedere a questa variabile dall'applicazione
e utilizzarla per determinare i dettagli della connessione.

La prima attività è di assicurarti che l'applicazione sia in esecuzione in un
ambiente dell'applicazione {{site.data.keyword.Bluemix_notm}}.
Verifica che sia presente la variabile di ambiente '`VCAP_SERVICES`' nel test:

```python
# Verifica che siamo in esecuzione in un ambiente dell'applicazione Bluemix.
if 'VCAP_SERVICES' in os.environ:
```
{:codeblock}

>   **Nota**: le prossime sezioni di codice vengono eseguite solo se viene trovata la variabile di ambiente.
    In Python,
    questo codice viene rientrato per indicare che è il corpo del testo.
    In questa esercitazione,
    il rientro viene omesso dai segmenti del codice per salvare spazio.
    Tuttavia,
    l'[elenco completo](#complete-listing) visualizza il rientro correttamente.

Supponendo che viene trovata la variabile,
procedi ad utilizzare le informazioni.
Inizia caricando i dati JSON archiviati nella variabile
e registrando l'evento nel nuovo 'file di log':

```python
# Sì, così puoi ottenere le informazioni sul servizio.
vcap_servicesData = json.loads(os.environ['VCAP_SERVICES'])
# Tieni presente che abbiamo correttamente trovato alcune informazioni sul servizio.
target.write("Got vcap_servicesData\n")
```
{:codeblock}

Successivamente,
ricerca le informazioni sull'istanza del database {{site.data.keyword.cloudant_short_notm}} collegata.
Inoltre,
registra l'evento nel 'file di log':

```python
# Ricerca l'istanza del servizio Cloudant.
cloudantNoSQLDBData = vcap_servicesData['cloudantNoSQLDB']
# Tieni presente che abbiamo correttamente trovato alcune informazioni sul servizio Cloudant.
target.write("Got cloudantNoSQLDBData\n")
```
{:codeblock}

Molti servizi {{site.data.keyword.Bluemix_notm}} potrebbe venire collegati all'ambiente dell'applicazione.
Le credenziali per ogni servizio, sono elencate come elementi array.
In questa esercitazione,
[è stato creato solo un collegamento al servizio](create_bmxapp_appenv.html#connecting).
Pertanto,
l'applicazione accede al primo elemento (elemento 'zero').
Ogni elemento del servizio contiene le credenziali per tale servizio,
espresse come un elenco indicizzato dai nome di campo essenziali necessari per accedere al servizio.
Ulteriori informazioni sui nomi dei campi vengono fornite
nell'[esercitazione](create_database.html#a-cloudant-service-instance-on-bluemix) che descrive un'attività di creazione del database semplice.

```python
# Ottieni un elenco contenente le informazioni sul collegamento Cloudant.
credentials = cloudantNoSQLDBData[0]
# Ottieni i valori essenziali per la nostra applicazione per comunicare con il servizio.
credentialsData = credentials['credentials']
# Tieni presente che abbiamo correttamente trovato i valori Cloudant.
target.write("Got credentialsData\n\n")
```
{:codeblock}

Successivamente,
controlla l'elenco e richiama i valori essenziali:

```python
# Ottieni il nome utente ...
serviceUsername = credentialsData['username']
target.write("Got username: ")
target.write(serviceUsername)
target.write("\n")
# ... la password ...
servicePassword = credentialsData['password']
target.write("Got password: ")
target.write(servicePassword)
target.write("\n")
# ... e l'URL del servizio in Bluemix.
serviceURL = credentialsData['url']
target.write("Got URL: ")
target.write(serviceURL)
target.write("\n")
```
{:codeblock}

L'applicazione dispone ora di tutti i dettagli necessari per creare un database nell'istanza del database
{{site.data.keyword.cloudant_short_notm}}.
Questa attività viene descritta più dettagliatamente
nell'[esercitazione](create_database.html#a-cloudant-service-instance-on-bluemix) che descrive la creazione del database semplice.

L'applicazione deve eseguire queste attività:

1.  Stabilisce un collegamento all'istanza del database.
2.  Crea un database con il nome fornito [precedentemente](#getting-started).
3.  Crea un documento JSON che contiene la data e l'ora correnti.
4.  Archivia il documento JSON nel database.
5.  Conferma che il documento sia stato archiviato in modo sicuro.
6.  Chiude il collegamento all'istanza del database.

Il codice per queste attività è il seguente:

```python
# Disponiamo ora di tutti i dettagli necessari per utilizzare l'istanza del servizio Cloudant.
# Collegati all'istanza del servizio.
client = Cloudant(serviceUsername, servicePassword, url=serviceURL)
client.connect()
# Crea un database nell'istanza.
myDatabaseDemo = client.create_database(databaseName)
if myDatabaseDemo.exists():
    target.write("'{0}' successfully created.\n".format(databaseName))
    # Crea un documento JSON molto semplice con la data e l'ora correnti.
    jsonDocument = {
        "rightNow": strftime("%Y-%m-%d %H:%M:%S", gmtime())
    }
    # Archivia il documento JSON nel database.
    newDocument = myDatabaseDemo.create_document(jsonDocument)
    if newDocument.exists():
        target.write("Document successfully created.\n")
# Tutto eseguito - scollegati dall'istanza del servizio.
client.disconnect()
```
{:codeblock}

#### Chiusura del file di log

Il passo successivo è di chiudere il file di log,
pronto per utilizzare un server web Python semplice nell'applicazione.

```python
# Inserisci un'altra indicazione chiara della data e ora correnti alla fine della pagina.
target.write("\n====\n")
target.write(strftime("%Y-%m-%d %H:%M:%S", gmtime()))
target.write("\n====\n")
# Termina la creazione della pagina web.
target.write("</pre></body></html>")
target.close()
```
{:codeblock}

#### Utilizzare il file di log

L'attività finale è di avviare il server web nell'applicazione Python.
L'unico scopo del server è di restituire il file di log su richiesta.
Questo file di log conferma che l'applicazione Python ha completato correttamente le seguenti attività:

1.  È sta eseguita correttamente nell'ambiente dell'applicazione {{site.data.keyword.Bluemix_notm}}.
2.  Determinato i dettagli dei collegamenti al servizio.
3.  Collegata all'istanza del database {{site.data.keyword.cloudant_short_notm}}.
4.  Creato un database.
5.  Creato un documento nel database.
6.  Risposto con il log degli eventi quando richiesto.

Il codice per avviare il server web Python viene incluso come parte del
[pacchetto applicazione 'starter'](create_bmxapp_appenv.html#starter):

```python
# Avvia l'applicazione server web Python semplice,
# in modo che possa 'servire' la nostra pagina web appena creata.
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

## Passo successivo

Il passo successivo nell'esercitazione è di [caricare l'applicazione](create_bmxapp_upload.html) per scopi di test.

## Elenco completo

Il seguente codice è il programma Python completo per accedere all'istanza del servizio
{{site.data.keyword.cloudant_short_notm}} in {{site.data.keyword.Bluemix_notm}}:

```python
# Rendi i moduli Python disponibili.
import os
import json

# È utile avere accesso agli strumenti
# per la formattazione dei valori ora e data.
from time import gmtime, strftime

# Accesso semplificato agli strumenti del server web Python di base.
try:
    from SimpleHTTPServer import SimpleHTTPRequestHandler as Handler
    from SocketServer import TCPServer as Server
except ImportError:
    from http.server import SimpleHTTPRequestHandler as Handler
    from http.server import HTTPServer as Server

# Abilita le librerie Python obbligatorie da utilizzare con Cloudant.
from cloudant.client import Cloudant
from cloudant.error import CloudantException
from cloudant.result import Result, ResultByKey

# Questo è il nome del database che intendiamo creare.
databaseName = "databasedemo"

# Modifica la directory corrente per evitare l'esposizione dei file del controllo
try:
    os.mkdir('static')
except OSError:
    # La directory già esiste,
    # non è necessario crearla.
    pass
os.chdir('static')

# Inizia creando una pagina web molto semplice.
filename = "index.html"
target = open(filename, 'w')
target.truncate()
target.write("<html><head><title>Demo Cloudant Python</title></head><body><p>Log dei passi Cloudant Python...</p><pre>")

# Inserisci un'indicazione chiara della data e ora correnti all'inizio della pagina.
target.write("====\n")
target.write(strftime("%Y-%m-%d %H:%M:%S", gmtime()))
target.write("\n====\n\n")

# Inizia ad utilizzare l'istanza del servizio Cloudant.

# Verifica che siamo in esecuzione in un ambiente dell'applicazione Bluemix.
if 'VCAP_SERVICES' in os.environ:
    # Sì, così puoi ottenere le informazioni sul servizio.
    vcap_servicesData = json.loads(os.environ['VCAP_SERVICES'])
    # Tieni presente che abbiamo correttamente trovato alcune informazioni sul servizio.
    target.write("Got vcap_servicesData\n")
    # Ricerca l'istanza del servizio Cloudant.
    cloudantNoSQLDBData = vcap_servicesData['cloudantNoSQLDB']
    # Tieni presente che abbiamo correttamente trovato alcune informazioni sul servizio Cloudant.
    target.write("Got cloudantNoSQLDBData\n")
    # Ottieni un elenco contenente le informazioni sul collegamento Cloudant.
    credentials = cloudantNoSQLDBData[0]
    # Ottieni i valori essenziali per la nostra applicazione per comunicare con il servizio.
    credentialsData = credentials['credentials']
    # Tieni presente che abbiamo correttamente trovato i valori Cloudant.
    target.write("Got credentialsData\n\n")
    # Ottieni il nome utente ...
serviceUsername = credentialsData['username']
target.write("Got username: ")
    target.write(serviceUsername)
target.write("\n")
    # ... la password ...
    servicePassword = credentialsData['password']
    target.write("Got password: ")
    target.write(servicePassword)
target.write("\n")
    # ... e l'URL del servizio in Bluemix.
    serviceURL = credentialsData['url']
target.write("Got URL: ")
    target.write(serviceURL)
target.write("\n")

    # Disponiamo ora di tutti i dettagli necessari per utilizzare l'istanza del servizio Cloudant.
    # Collegati all'istanza del servizio.
    client = Cloudant(serviceUsername, servicePassword, url=serviceURL)
client.connect()
    # Crea un database nell'istanza.
    myDatabaseDemo = client.create_database(databaseName)
if myDatabaseDemo.exists():
    target.write("'{0}' successfully created.\n".format(databaseName))
    # Crea un documento JSON molto semplice con la data e l'ora correnti.
        jsonDocument = {
            "rightNow": strftime("%Y-%m-%d %H:%M:%S", gmtime())
    }
        # Archivia il documento JSON nel database.
        newDocument = myDatabaseDemo.create_document(jsonDocument)
    if newDocument.exists():
        target.write("Document successfully created.\n")
    # Tutto eseguito - scollegati dall'istanza del servizio.
    client.disconnect()

# Inserisci un'altra indicazione chiara della data e ora correnti alla fine della pagina.
target.write("\n====\n")
target.write(strftime("%Y-%m-%d %H:%M:%S", gmtime()))
target.write("\n====\n")
# Termina la creazione della pagina web.
target.write("</pre></body></html>")
target.close()

# Avvia l'applicazione server web Python semplice,
# in modo che possa 'servire' la nostra pagina web appena creata.
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
