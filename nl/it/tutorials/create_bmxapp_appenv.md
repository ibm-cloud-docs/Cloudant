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

# Creazione di una semplice applicazione {{site.data.keyword.cloud_notm}} per accedere a un database {{site.data.keyword.cloudant_short_notm}}: l'ambiente dell'applicazione

Questa sezione dell'esercitazione descrive come configurare l'ambiente dell'applicazione di cui devi disporre
per creare un'applicazione {{site.data.keyword.cloud}}.
{:shortdesc}

<div id="creating"></div>

## Creazione di un ambiente dell'applicazione {{site.data.keyword.cloud_notm}}

1.  Accedi al tuo account {{site.data.keyword.cloud_notm}}.
    Il dashboard {{site.data.keyword.cloud_notm}} può essere trovato all'indirizzo:
    [http://bluemix.net ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://bluemix.net){:new_window}.
    Dopo l'autenticazione con i tuoi nome utente e password,
    viene visualizzato il dashboard {{site.data.keyword.cloud_notm}}:</br>
    ![{{site.data.keyword.cloud_notm}} dashboard](images/img0001.png)
2.  Fai clic sul pulsante `Crea risorsa`:<br/>
    ![{{site.data.keyword.cloud_notm}} - pulsante Crea risorsa](images/img0002.png)<br/>
    Viene visualizzato un elenco dei servizi disponibili in {{site.data.keyword.cloud_notm}}.

3.  Fai clic sulla categoria `Calcola`:<br/>
    ![{{site.data.keyword.cloud_notm}} Applicazioni Cloud Foundry](images/img0012.png)<br/>
    Viene visualizzato un elenco dei diversi servizi e delle diverse applicazioni disponibili su {{site.data.keyword.cloud_notm}}.

4.  Scorri verso il basso alla sezione `Cloud Foundry` e fai clic sulla voce `Python`:<br/>
    ![{{site.data.keyword.cloud_notm}} - applicazione Python](images/img0013.png)<br/>
    Viene visualizzato un modulo `Crea un'applicazione Cloud Foundry`.

5.  Utilizza il modulo `Crea un'applicazione Cloud Foundry` per specificare e creare l'ambiente per la tua applicazione Python Cloud Foundry. Immetti un nome per la tua applicazione, ad esempio `Applicazione Cloudant CF`. Il nome host viene generato automaticamente,
    sebbene tu possa personalizzarlo:</br>
    ![{{site.data.keyword.cloud_notm}} Nomi applicazione Python Cloud Foundry](images/img0014.png)
    
    Il nome host deve essere univoco all'interno del dominio {{site.data.keyword.cloud_notm}}. In questo esempio, il dominio è `mybluemix.net`, fornendo un nome host completo di `Cloudant-CF-app.mybluemix.net`.
    {: tip}

6.  Fai clic su `Crea` per creare l'ambiente dell'applicazione:</br>
    ![Crea l'applicazione {{site.data.keyword.cloud_notm}} Python Cloud Foundry](images/img0015.png)

7.  Dopo una breve pausa,
    viene visualizzata la finestra `Introduzione` del tuo nuovo ambiente dell'applicazione.
    Viene automaticamente creata un'applicazione di test nell'ambiente.
    L'applicazione viene avviata automaticamente,
    come mostrato dall'icona verde e dallo stato `In esecuzione`.
    L'applicazione è un programma 'heartbeat',
    sufficiente a mostrare che il nuovo ambiente dell'applicazione è pronto per l'utilizzo.
    Fai clic sul link `Applicazioni Cloud Foundry` per ritornare al tuo dashboard {{site.data.keyword.cloud_notm}}.<br/>
    ![La nuova applicazione {{site.data.keyword.cloud_notm}} Python Cloud Foundry in esecuzione per la prima volta](images/img0016.png)

8.  Il tuo dashboard ora include l'ambiente dell'applicazione appena creato:<br/>
    ![L'applicazione {{site.data.keyword.cloud_notm}} Python Cloud Foundry di base che viene visualizzata nel dashboard](images/img0017.png)

Ora disponi di un ambiente dell'applicazione {{site.data.keyword.cloud_notm}} Python, pronto per l'utilizzo.

Per utilizzare un'istanza del servizio {{site.data.keyword.cloudant_short_notm}},
il passo successivo consiste nel creare una 'connessione' tra l'ambiente dell'applicazione e l'istanza del database.

<div id="connecting"></div>

## Connessione dei servizi e delle applicazioni {{site.data.keyword.cloud_notm}}

Questa sezione dell'esercitazione illustra come connettere i servizi e gli ambienti dell'applicazione
{{site.data.keyword.cloud_notm}} utilizzando
l'area di gestione e configurazione della tua applicazione.

1.  Dal tuo dashboard {{site.data.keyword.cloud_notm}},
    fai clic sulla voce della tua applicazione.<br/>
    ![Selezione della tua applicazione nel dashboard {{site.data.keyword.cloud_notm}}](images/img0018.png)</br>
    Viene visualizzata l'area della panoramica di gestione e configurazione della tua applicazione.

2.  Per connettere l'ambiente dell'applicazione a un altro servizio,
    fai clic sul link `Connessioni`:<br/>
    ![Selezione della configurazione della connessione per la tua applicazione {{site.data.keyword.cloud_notm}}](images/img0019.png)<br/>
    Viene visualizzata un'area per la configurazione di una connessione tra la tua applicazione e qualsiasi altro servizio disponibile nel tuo account.

3.  Un [prerequisito](create_bmxapp_prereq.html#prerequisites) per questa esercitazione è un'istanza del database
    {{site.data.keyword.cloudant_short_notm}} esistente.
    Fai clic su `Crea connessione` per stabilire una connessione tra tale istanza del servizio e la tua applicazione:<br/>
    ![Connessione a un'istanza del database esistente](images/img0020.png)<br/>
    Viene visualizzato un elenco di istanze del servizio esistenti nel tuo account.

4.  Fai clic sull'istanza del servizio {{site.data.keyword.cloudant_short_notm}} che vuoi utilizzare.
    Questa esercitazione utilizza l'istanza `Cloudant-service`:<br/>
    ![Scegli l'istanza del database di esempio dell'esercitazione](images/img0021.png)

5.  Ti viene richiesto di confermare che realmente vuoi connettere l'istanza del database alla tua applicazione.
    Fai clic su `Connetti` per confermare la connessione:<br>
    ![Conferma la connessione all'istanza del database](images/img0022.png)

6.  Prima di procedere, ti viene richiesto di personalizzare l'ID servizio e il ruolo di accesso. Fai clic su `Connetti` per continuare:
    ![Conferma la ripreparazione dell'applicazione](images/img0022b.png)

6.  Modificando i collegamenti del servizio di un'applicazione se ne influenza la configurazione generale. La modifica richiede una 'ripreparazione' dell'applicazione,
    che inoltre forza l'arresto di un'applicazione in esecuzione. Viene visualizzata una finestra in cui confermare che sei pronto a procedere con la 'ripreparazione'.
    Fai clic su `Riprepara` per continuare:<br/>
    ![Conferma ripreparazione dell'applicazione](images/img0023.png)

7.  Viene nuovamente visualizzata la pagina dei collegamenti del servizio.
    Ora include l'istanza del database appena collegata:<br/>
    ![L'istanza del database appena collegata](images/img0024.png)

L'ambiente dell'applicazione e l'istanza del database sono ora collegati.
Il passo successivo consiste nell'assicurarti che gli strumenti necessari sano installati
per utilizzare le applicazioni {{site.data.keyword.cloud_notm}}.

<div id="toolkits"></div>

## Toolkit dei comandi Cloud Foundry e {{site.data.keyword.cloud_notm}}

Questa sezione dell'esercitazione illustra i toolkit che devono essere installati per utilizzare
i tuoi ambienti, applicazioni e servizi {{site.data.keyword.cloud_notm}}.

Il toolkit [Cloud Foundry ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://en.wikipedia.org/wiki/Cloud_Foundry){:new_window}
è una raccolta di strumenti per utilizzare le applicazioni distribuite
in un ambiente compatibile con Cloud Foundry.
Utilizza questi strumenti per attività come l'aggiornamento di un'applicazione distribuita
o per avviare o arrestare un'applicazione in esecuzione.

Il toolkit {{site.data.keyword.cloud_notm}} fornisce ulteriori funzionalità,
necessarie per utilizzare le applicazioni ospitate e in esecuzione in un ambiente {{site.data.keyword.cloud_notm}}.

Assicurati di installare sia Cloud Foundry _che_ i toolkit {{site.data.keyword.cloud_notm}}.
{: tip}

Scaricare e installare i toolkit è una sola azione.
Se i toolkit sono già installati e funzionanti nel tuo sistema,
non hai bisogno di scaricarli nuovamente,
a meno che non siano stati aggiornati.

Le informazioni generali sui toolkit sono disponibili
[qui ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](../getting-started.html#getting-started-with-cloudant){:new_window}.

### Installazione del toolkit Cloud Foundry

Alcune distribuzioni del sistema operativo hanno già una versione del toolkit Cloud Foundry disponibile.
Se la versione supportata è 6.11 o meglio,
è compatibile con {{site.data.keyword.cloud_notm}} e può essere utilizzata.
Puoi verificare quale versione è installata eseguendo [questo test](#checkCFversion).

In alternativa,
utilizza i seguenti passi per scaricare e installare il toolkit Cloud Foundry nel tuo sistema: 

1.  Fai clic su `Introduzione` per visualizzare le informazioni sul download del toolkit Cloud Foundry.

2.  Fai clic su `CLI`.Il link ti porta alla documentazione di {{site.data.keyword.cloud_notm}} Developer Tools (CLI e Dev Tools).

3.  Fai clic su `Plug-in CLI Cloud Foundry` e fai quindi clic su `CLI gestione {{site.data.keyword.cloud_notm}}`. 

4.  Attieniti alle istruzioni nella pagina per scaricare ed eseguire la versione più recente del programma di installazione per il tuo sistema.

5.  <div id='checkCFversion'></div>Per verificare che disponi di un toolkit Cloud Foundry funzionante,
    esegui il seguente comando quando richiesto:

    ```sh
    cf --version
    ```
    {:pre}
    
    È previsto un risultato simile al seguente output:
    
    ```
    cf version 6.20.0+25b1961-2016-06-29
    ```
    {:codeblock}
    
    La versione del toolkit Cloud Foundry deve essere 6.11 o più recente per la compatibilità con {{site.data.keyword.cloud_notm}}.
    {: tip}

### Installazione del toolkit {{site.data.keyword.cloud_notm}}

Utilizza i seguenti passi per scaricare e installare il toolkit {{site.data.keyword.cloud_notm}} sul tuo sistema.

1.  Fai clic su `Introduzione` per visualizzare le informazioni sul download del toolkit della CLI di gestione {{site.data.keyword.cloud_notm}}.

2.  Fai clic su `CLI` per aprire il documento [Getting started with {{site.data.keyword.cloud_notm}} developer tools ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://console.bluemix.net/docs/cli/reference/bluemix_cli/get_started.html#getting-started){:new_window}.

3.  Attieniti alle istruzioni nella pagina per scaricare ed eseguire il programma di installazione appropriato per il tuo sistema.

    Il programma di installazione esegue una verifica per garantire che disponi di una versione appropriata del toolkit Cloud Foundry installata.
    Se tutto è corretto,
    il toolkit {{site.data.keyword.cloud_notm}} viene installato nel tuo sistema.

4.  Per verificare che disponi di un toolkit {{site.data.keyword.cloud_notm}} funzionante,
    esegui il seguente comando quando richiesto:
    
    ```sh
    bluemix --version
    ```
    {:pre}
    
    È previsto un risultato simile al seguente output:
    
    ```
    bluemix version 0.4.5+03c29de-2016-12-08T07:01:01+00:00
    ```
    {:codeblock}
    
Gli strumenti per utilizzare le applicazioni {{site.data.keyword.cloud_notm}} sono ora disponibili.
Il passo successivo consiste nell'ottenere i materiali dello 'starter' per aiutarti nella creazione
di un'applicazione {{site.data.keyword.cloud_notm}}.

Dopo che hai installato la CLI (command line interface), torna alla scheda `Introduzione` nel dashboard per scaricare, modificare e ridsitribuire le tue istanze del servizio e le tue applicazioni Cloud Foundry con la CLI (command line interface).
{: tip}

<div id="starter"></div>

## L'applicazione 'starter'

Questa sezione dell'esercitazione descrive un'applicazione starter {{site.data.keyword.cloud_notm}}
e spiega come puoi personalizzarla per accedere a un'istanza del database {{site.data.keyword.cloudant_short_notm}}.

Un'applicazione starter {{site.data.keyword.cloud_notm}} è la raccolta minima possibile di file
di configurazione e origine necessaria per creare un'applicazione {{site.data.keyword.cloud_notm}} funzionante.
Per alcuni motivi,
è simile a un'[applicazione 'Hello World'![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://en.wikipedia.org/wiki/%22Hello,_World!%22_program){:new_window};
sufficiente solo a mostrare che la configurazione e il sistema di base stiano funzionando correttamente.

Un'applicazione starter {{site.data.keyword.cloud_notm}} è un archivio di file di esempio che devi
modificare o estendere quando sviluppi la tua applicazione {{site.data.keyword.cloud_notm}}.

Tre file in particolare sono essenziali:

-   [`Procfile`](#procfile)
-   [`manifest.yml`](#manifest)
-   [`requirements.txt`](#requirements)

<div id="procfile"></div>

### Il file `Procfile`

Il `Procfile` contiene i dettagli di cui {{site.data.keyword.cloud_notm}} ha bisogno per eseguire la tua applicazione.

Più specificamente,
un `Procfile` è una risorsa Cloud Foundry
che definisce un tipo di processo dell'applicazione
e il comando per eseguire l'applicazione.
Ulteriori informazioni sul `Procfile` sono disponibili
[qui ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://docs.cloudfoundry.org/buildpacks/prod-server.html#procfile){:new_window}.

Il `Procfile` per un'applicazione starter {{site.data.keyword.cloud_notm}} Python
è simile al seguente esempio:

```
web: python server.py
```
{:codeblock}

Questo esempio indica che l'applicazione è un'applicazione web Python
e che viene avviata eseguendo il comando:

```sh
python server.py
```
{:codeblock}

Un file di origine `server.py` Python è incluso nell'archivio dell'applicazione starter.
Il file `server.py` viene modificato per la tua applicazione.
In alternativa,
crea un file di origine Python completamente nuovo.
Quindi, aggiorna il `Procfile` in modo che venga utilizzato il nuovo file quando viene avviata la tua applicazione.

<div id="manifest"></div>

### Il file `manifest.yml`

Il file `manifest.yml` è una descrizione completa dell'applicazione
e dell'ambiente di cui ha bisogno per l'esecuzione.

Il file per un'applicazione starter {{site.data.keyword.cloud_notm}} Python è simile al seguente esempio:

```
applications:
- path: .
  memory: 128M
  instances: 1
  domain: mybluemix.net
  name: Cloudant Python
  host: Cloudant-Python
  disk_quota: 1024M
  services:
  - Cloudant Service 2017
```
{:codeblock}

Tre punti sono degni di nota:

-   I valori `domain`,
    `name`,
    e `host` corrispondono ai valori immessi
    quando la tua applicazione {{site.data.keyword.cloud_notm}} è stata [creata](#creating).
-   Il valore `name` viene utilizzato dal toolkit Cloud Foundry per identificare l'applicazione che stai gestendo.
-   Il valore `services` conferma che l'istanza del database `Cloudant Service 2017`
    {{site.data.keyword.cloudant_short_notm}} è connessa all'ambiente dell'applicazione.

Normalmente non hai bisogno di modificare il file `manifest.yml`,
tuttavia è utile comprendere perché deve essere presente per far funzionare la tua applicazione.

<div id="requirements"></div>

### Il file `requirements.txt`

Il file `requirements.txt` specifica tutti i componenti aggiuntivi necessari al funzionamento della tua applicazione.

Nell'applicazione starter,
il file `requirements.txt` è vuoto.

Tuttavia, in questa esercitazione l'applicazione Python accede a un'istanza del database {{site.data.keyword.cloudant_short_notm}}.
Pertanto,
l'applicazione deve essere in grado di utilizzare la libreria client
[{{site.data.keyword.cloudant_short_notm}} per le applicazioni Python](../libraries/supported.html#python).

Per abilitare la libreria client Python,
modifica il file `requirements.txt` in modo che contenga il seguente testo:
```
cloudant==2.3.1
```
{:codeblock}

## Passo successivo

Il passo successivo nell'esercitazione è di [creare l'applicazione](create_bmxapp_createapp.html).
