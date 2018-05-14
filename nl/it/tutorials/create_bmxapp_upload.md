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

# Creazione di un'applicazione Bluemix di esempio per accedere a un database Cloudant: caricamento dell'applicazione

Questa sezione dell'esercitazione illustra come caricare
un'applicazione {{site.data.keyword.Bluemix}}.
{:shortdesc}

<div id="uploading"></div>

## Connessione a Bluemix

La prima attività è di collegarsi a {{site.data.keyword.Bluemix_notm}}.

Il toolkit [{{site.data.keyword.Bluemix_notm}}](create_bmxapp_appenv.html#toolkits) ti aiuta ad effettuare il collegamento.

Cloud Foundry deve conoscere l'URL da utilizzare per effettuare le chiamate API,
ad esempio quando carichi un'applicazione.
Il toolkit {{site.data.keyword.Bluemix_notm}} utilizza il comando '`cf api`' per gestire l'endpoint API.
Ulteriori informazioni sul comando '`cf api`' sono
[disponibili
![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://console.ng.bluemix.net/docs/cli/reference/cfcommands/index.html#cf_api){:new_window}.

Utilizza il seguente comando per fornire a Cloud Foundry l'URL da utilizzare:

```sh
bluemix api https://api.ng.bluemix.net
```
{:pre}

È previsto un risultato simile al seguente output:

```
Invoking 'cf api https://api.ng.bluemix.net'...

Setting api endpoint to https://api.ng.bluemix.net...
OK

API endpoint:   https://api.ng.bluemix.net
API version:    2.54.0
Not logged in. Use 'bluemix login' to log in.
```
{:codeblock}

Cloud Foundry ora conosce dove inviare le chiamate API per la gestione delle applicazioni.

Il passo successivo è di accedere al tuo ambiente dell'applicazione {{site.data.keyword.Bluemix_notm}}.
Devi fornire i seguenti dettagli dell'account:

-   Il tuo nome utente, specificato come il parametro '`-u`'.
-   Il tuo nome dell'organizzazione, specificato come il parametro '`-o`'.
-   Il tuo spazio, specificato come il parametro '`-s`'.

>   **Nota**: i dettagli dell'account sono disponibili nel tuo dashboard {{site.data.keyword.Bluemix_notm}},
    quando accedi tramite un browser web,
    come mostrato nel seguente esempio:<br/>
    ![Ricerca dei tuoi dettagli dell'account {{site.data.keyword.Bluemix_notm}} ](images/img0035.png)

Utilizza un comando simile al seguente esempio per accedere al tuo ambiente dell'applicazione
{{site.data.keyword.Bluemix_notm}}.
Tieni presente che ti viene richiesto di immettere la tua password dell'account.

```sh
bluemix login -u Adrian.Warman@uk.ibm.com -o Adrian.Warman@uk.ibm.com -s dev
```
{:pre}

È previsto un risultato simile al seguente output:

```
Invoking 'cf login -u Adrian.Warman@uk.ibm.com -o Adrian.Warman@uk.ibm.com -s dev'...

API endpoint: https://api.ng.bluemix.net

Password> 
Authenticating...
OK

Targeted org Adrian.Warman@uk.ibm.com

Targeted space dev
                
API endpoint:   https://api.ng.bluemix.net (API version: 2.54.0)
User:           adrian.warman@uk.ibm.com
Org:            Adrian.Warman@uk.ibm.com
Space:          dev
```
{:codeblock}

## Caricamento dell'applicazione

Il toolkit Cloudant Foundry ora conosce come collegarsi all'ambiente {{site.data.keyword.Bluemix_notm}}.

Il passo successivo è di caricare l'applicazione stessa.
I dettagli di un'applicazione {{site.data.keyword.Bluemix_notm}}
sono forniti nel [file manifest](create_bmxapp_appenv.html#manifest).

Il file manifest per questa applicazione dell'esercitazione è stato aggiornato come descritto
[qui](create_bmxapp_createapp.html#essential-files)

Utilizza un comando simile al seguente esempio per accedere e per caricare la tua applicazione
{{site.data.keyword.Bluemix_notm}}.

```sh
cf push "Cloudant Python"
```
{:pre}

Viene visualizzata una sequenza di messaggi del risultato.

```
Using manifest file /..../BMXDemo/manifest.yml

Updating app Cloudant Python in org Adrian.Warman@uk.ibm.com / space dev as Adrian.Warman@uk.ibm.com...
OK
```
{:codeblock}

Il toolkit Cloud Foundry viene posizionato nel file manifest
e inizia a preparare il caricamento dell'applicazione utilizzando i dettagli di collegamento
e identificazione che hai fornito [precedentemente](#uploading).

```
Using route Cloudant-Python.mybluemix.net
Uploading Cloudant Python...
Uploading app files from: /..../BMXDemo
Uploading 1.5K, 3 files
Done uploading               
OK
Binding service Cloudant Service 2017 to app Cloudant Python in org Adrian.Warman@uk.ibm.com / space dev as Adrian.Warman@uk.ibm.com...
OK
```
{:codeblock}

L'applicazione è stata caricata correttamente
ed è stata effettuata una connessione all'istanza del database {{site.data.keyword.cloudant_short_notm}}.

```
Starting app Cloudant Python in org Adrian.Warman@uk.ibm.com / space dev as Adrian.Warman@uk.ibm.com...
-----> Downloaded app package (4.0K)
-----> Downloaded app buildpack cache (29M)
-------> Buildpack version 1.5.5
     $ pip install -r requirements.txt
DEPRECATION: --allow-all-external has been deprecated and will be removed in the future. Due to changes in the repository protocol, it no longer has any effect.
       Collecting cloudant==2.3.1 (from -r requirements.txt (line 1))
         Downloading cloudant-2.3.1-py2-none-any.whl (63kB)
       Collecting requests<3.0.0,>=2.7.0 (from cloudant==2.3.1->-r requirements.txt (line 1))
         Downloading requests-2.12.4-py2.py3-none-any.whl (576kB)
       Installing collected packages: requests, cloudant
       Successfully installed cloudant-2.3.1 requests-2.12.4
You are using pip version 8.1.1, however version 9.0.1 is available.
You should consider upgrading via the 'pip install --upgrade pip' command.
You are using pip version 8.1.1, however version 9.0.1 is available.
You should consider upgrading via the 'pip install --upgrade pip' command.
-----> Uploading droplet (30M)

0 of 1 instances running, 1 starting
1 of 1 instances running

App started


OK

App Cloudant Python was started using this command `python server.py`
```
{:codeblock}

L'applicazione viene avviata automaticamente. Come parte dell'avvio,
viene eseguito un controllo per garantire che siano stati soddisfatti tutti i requisiti,
valutando il contenuto del [file requirements.txt](create_bmxapp_appenv.html#requirements).
L'applicazione richiede l'accesso alla libreria {{site.data.keyword.cloudant_short_notm}},
che è stata [specificata](create_bmxapp_createapp.html#essential-files) quando è stata creata l'applicazione.

Dopo aver caricato e avviato l'applicazione,
vengono eseguiti alcuni piccoli controlli di sistema per confermare che l'applicazione sia correttamente in esecuzione
per quanto riguarda {{site.data.keyword.Bluemix_notm}}.

```
Showing health and status for app Cloudant Python in org Adrian.Warman@uk.ibm.com / space dev as Adrian.Warman@uk.ibm.com...
OK

requested state: started
instances: 1/1
usage: 128M x 1 instances
urls: Cloudant-Python.mybluemix.net
last uploaded: Thu Dec 22 15:58:18 UTC 2016
stack: cflinuxfs2
buildpack: python 1.5.5

     state     since                    cpu    memory          disk           details
#0   running   2016-12-22 03:59:21 PM   0.0%   49.9M of 128M   110.6M of 1G
```
{:codeblock}

## Verifica dell'applicazione di esempio 

Quando l'ambiente dell'applicazione {{site.data.keyword.Bluemix_notm}} è stato creato per la prima volta,
in dashboard ha incluso un link nella colonna `Route` dell'applicazione:<br/>
![Screenshot che mostra il dashboard dell'applicazione](images/img0017.png)

Facendo clic sul link viene aperta una nuova finestra,
che richiede alcuni dati dall'applicazione elencata nella porta corrispondente.
L'applicazione risponde restituendo i contenuti del file di log
che era stato generato all'avvio dell'applicazione:<br/>
![File di log generato quando l'applicazione dell'esercitazione ha iniziato l'esecuzione](images/img0030.png)

I contenuti di questo file di log sono interessanti.
L'ora di avvio e di fine sono chiaramente visualizzate.
Nel mezzo,
il log registra ogni dettaglio come informazioni sul collegamento
a {{site.data.keyword.cloudant_short_notm}} che è stato richiamato.
I valori effettivi del collegamento non sono importanti.
Il log visualizza che l'applicazione dell'esercitazione è stata in grado di individuare,
richiamare e utilizzare questi valori per creare un nuovo documento nel database
{{site.data.keyword.cloudant_short_notm}}.

### Conferma dei dettagli del database

Inizia aprendo il dashboard {{site.data.keyword.cloudant_short_notm}}.
Fai clic sull'icona `Launch` nella scheda `Manage` della pagina del servizio
{{site.data.keyword.cloudant_short_notm}}:<br/>
![Icona Launch nella pagina del servizio {{site.data.keyword.cloudant_short_notm}} ](images/img0036.png)

> **Nota**: per trovare la tua pagina del servizio {{site.data.keyword.cloudant_short_notm}},
  fai riferimento ai dettagli nell'esercitazione
  ['Creazione di un'istanza {{site.data.keyword.cloudant_short_notm}}'](create_service.html#locating-your-service-credentials).

Quando si apre la pagina del dashboard,
puoi visualizzare che l'applicazione ha creato il database
'`databasedemo`':<br/>
![Il dashboard {{site.data.keyword.cloudant_short_notm}} che mostra il nuovo database](images/img0031.png)

Il database contiene un solo documento,
creato dall'applicazione.
Per verificare la presenza del documento
fai clic sul nome del database nel dashboard.
Viene visualizzato un elenco di opzioni del database.
Quando selezioni la scheda `All documents`,
vengono visualizzati i dettagli di un solo documento:<br/>
![Un solo documento nel nuovo database](images/img0032.png)

Per visualizzare i dettagli del documento,
fai clic sull'icona `Edit`,
che viene visualizzata con un'immagine di una matita:<br/>
![Dettagli del documento](images/img0033.png)

Quando vengono visualizzati i dettagli del documento,
puoi visualizzare ogni campo creato dall'applicazione dell'esercitazione.<br/>
![I campi nel documento](images/img0034.png)<br/>
In particolare,
il campo `rightNow` dispone della data e ora di creazione del documento.
Questo valore corrisponde all'ora registrata nel
[file di log dell'applicazione](#testing-the-sample-application).

## Passo successivo

Il passo successivo nell'esercitazione è di [gestire e mantenere l'applicazione](create_bmxapp_maintain.html),
ad esempio quando avvii, arresti ed esegui il debug dell'applicazione.  
