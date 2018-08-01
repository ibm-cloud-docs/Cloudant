---

copyright:
  years: 2017, 2018
lastupdated: "2018-06-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# Creazione di un'istanza {{site.data.keyword.cloudant_short_notm}} su {{site.data.keyword.Bluemix_notm}} utilizzando gli strumenti Cloud Foundry

Questa esercitazione illustra come creare un'istanza del servizio {{site.data.keyword.cloudantfull}}
in {{site.data.keyword.Bluemix}}
utilizzando gli strumenti Cloud Foundry.
{:shortdesc}

## Prerequisiti

Per seguire questa esercitazione,
devi prima installare gli strumenti {{site.data.keyword.Bluemix_notm}} Cloud Foundry.
I dettagli per l'installazione degli strumenti sono disponibili in
[questa esercitazione separata](create_bmxapp_appenv.html#the-cloud-foundry-and-ibm-cloud-command-toolkits).

> **Nota**: assicurati di installare entrambi i toolkit Cloud Foundry _e_
  {{site.data.keyword.Bluemix_notm}}.

## Identificazione dell'endpoint API {{site.data.keyword.Bluemix_notm}}

Specifica l'endpoint API di destinazione per i tuoi comandi Cloud Foundry;

```sh
bx api https://api.ng.bluemix.net
```
{:codeblock}

Il risultato conferma che hai correttamente identificato l'endpoint:

```sh
Setting api endpoint to https://api.ng.bluemix.net...
OK

API endpoint:   https://api.ng.bluemix.net (API version: 2.54.0)
Not logged in. Use 'bx login' to log in.
```
{:pre}

## Accesso al tuo account {{site.data.keyword.Bluemix_notm}}

1.  Utilizza il seguente comando per avviare il processo di accesso per il tuo account
  {{site.data.keyword.Bluemix_notm}}:
  
  ```sh
  bx login
  ```
  {:codeblock}
  
  {{site.data.keyword.Bluemix_notm}} risponde ricordandoti l'endpoint API corrente,
  quindi chiede l'indirizzo email del tuo account:
  
  ```sh
  API endpoint: https://api.ng.bluemix.net
  
  Email>
  ```
  {:pre}

2.  Immetti l'indirizzo email del tuo account.
  {{site.data.keyword.Bluemix_notm}} quindi chiede la password del tuo account:
  ```sh
  API endpoint: https://api.ng.bluemix.net
  
  Email> J.Doe@email.com
  
  Password>
  ```
  {:pre}
  
  {{site.data.keyword.Bluemix_notm}} convalida i tuoi dettagli,
  quindi riepiloga le informazioni sulla tua sessione di accesso:
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

3.  Hai ora eseguito l'accesso al tuo account {{site.data.keyword.Bluemix_notm}}.

## Scelta del piano {{site.data.keyword.cloudant_short_notm}} per il tuo servizio

Ottieni un elenco di tutte le offerte del servizio disponibili.
Filtra l'elenco in modo che corrisponda solo ai servizi {{site.data.keyword.cloudant_short_notm}}:

```sh
bx service offerings | grep -i Cloudant
```
{:codeblock}

Il risultato è un elenco dei servizi {{site.data.keyword.cloudant_short_notm}}
disponibili nel tuo account,
inclusi i piani specifici che puoi selezionare:

```sh
cloudantNoSQLDB   Lite, Standard*
```
{:pre}

**Facoltativo**: per visualizzare ulteriori dettagli sui piani,
utilizza il seguente comando:

```sh
bx cf marketplace -s cloudantNoSQLDB
```
{:codeblock}

Il risultato è un riepilogo dei piani disponibili,
simile alla seguente sezione di una risposta di esempio (dettagli corretti a maggio 2017):

```
Lite
The Lite plan provides access to the full functionality of {{site.data.keyword.cloudant_short_notm}} for development and evaluation.
The plan has a set amount of provisioned throughput capacity as shown
and includes a max of 1GB of encrypted data storage.   free
```
{:pre}

## Creazione del servizio {{site.data.keyword.cloudant_short_notm}}

Il formato del comando di base per creare un'istanza del servizio in
{{site.data.keyword.Bluemix_notm}} è il seguente:

```sh
bx service create <service> <plan> <instance name>
```
{:pre}

Supponi che vogliamo creare un'istanza di un servizio
{{site.data.keyword.cloudant_short_notm}} utilizzando il piano `Lite`,
in cui il nome dell'istanza è `cs20170517a`.

Fai ciò utilizzando un comando simile al seguente esempio:

```sh
bx service create cloudantNoSQLDB Lite cs20170517a
```
{:codeblock}

Dopo aver creato l'istanza del servizio,
risponde con un messaggio simile al seguente esempio:

```sh
Invoking 'cf create-service cloudantNoSQLDB Lite cs20170517a'...

Creating service instance cs20170517a in org J.Doe@email.com / space dev as J.Doe@email.com...
OK

```
{:pre}

## Creazione delle credenziali per il tuo servizio {{site.data.keyword.cloudant_short_notm}}

Le applicazioni che devono accedere al tuo servizio {{site.data.keyword.cloudant_short_notm}}
devono disporre delle credenziali necessarie.

>   **Nota**: e credenziali del servizio sono importanti.
    Chiunque o qualsiasi applicazione abbia accesso alle credenziali,
    può effettivamente fare qualsiasi cosa voglia con l'istanza del servizio
    ad esempio potrebbe creare dati fasulli
    o eliminare informazioni importanti.
    Proteggi queste credenziali attentamente.

Le credenziali del servizio sono composte da cinque campi:

Campo      | Scopo
-----------|--------
`host`     | Il nome host utilizzato dalle applicazioni per individuare l'istanza del servizio.
`username` | Il nome utente obbligatorio alle applicazioni per accedere all'istanza del servizio.
`password` | La password obbligatoria alle applicazioni per accedere all'istanza del servizio.
`port`     | Il numero di porta HTTP per l'accesso all'istanza del servizio sull'host. Normalmente 443 per forzare l'accesso HTTPS.
`url`      | Una stringa di aggregazione delle altre informazioni sulle credenziali in un solo URL, appropriata per l'utilizzo da parte delle applicazioni.

Il formato del comando di base per creare le credenziali per un'istanza del servizio in
{{site.data.keyword.Bluemix_notm}} è il seguente:

```sh
bx cf create-service-key <instance name> <credentials name>
```
{:pre}

Supponi che vogliamo creare le credenziali per l'istanza `cs20170517a` di un servizio
{{site.data.keyword.cloudant_short_notm}},
in cui il nome per le credenziali è `creds20170517a`.

Fai ciò utilizzando un comando simile al seguente esempio:

```sh
bx cf create-service-key cs20170517a creds20170517a
```
{:codeblock}

Dopo aver ricevuto la richiesta per creare le credenziali per l'istanza del servizio,
{{site.data.keyword.Bluemix_notm}} risponde con un messaggio simile al seguente esempio:

```sh
Invoking 'cf create-service-key cs20170517a creds20170517a'...

Creating service key creds20170517a for service instance cs20170517a as J.Doe@email.com...
OK
```
{:pre}

## Elenco delle credenziali per il tuo servizio {{site.data.keyword.cloudant_short_notm}}

Il formato del comando di base per richiamare le credenziali per un'istanza del servizio in
{{site.data.keyword.Bluemix_notm}} è il seguente:

```sh
bx cf service-key <instance name> <credentials name>
```
{:pre}

Supponi che vogliamo richiamare le credenziali per l'istanza `cs20170517a` di un servizio
{{site.data.keyword.cloudant_short_notm}},
in cui il nome per le credenziali è `creds20170517a`.

Fai ciò utilizzando un comando simile al seguente esempio:

```sh
bx cf service-key cs20170517a creds20170517a
```
{:codeblock}

Dopo aver ricevuto la richiesta per richiamare le credenziali per l'istanza del servizio,
{{site.data.keyword.Bluemix_notm}} risponde con un messaggio simile al seguente esempio (abbreviato):

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

## Utilizzo della tua istanza del servizio {{site.data.keyword.cloudant_short_notm}}

A questo punto,
hai:

1.  Creato un'istanza del servizio {{site.data.keyword.cloudant_short_notm}} in
  {{site.data.keyword.Bluemix_notm}}.
2.  Creato le credenziali per l'istanza del servizio {{site.data.keyword.cloudant_short_notm}}.
3.  Richiamato le credenziali dell'istanza del servizio, in modo che possano essere utilizzate dalla tua applicazione.

Un'esercitazione che mostra come utilizzare un'istanza del servizio {{site.data.keyword.cloudant_short_notm}}
è disponibile [qui](create_database.html#context).
Ricorda di sostituire le credenziali che hai creato in questa esercitazione.

## (Facoltativo) Riordinare alla fine

Il seguente breve elenco di comandi potrebbe essere utile per riordinare il tuo ambiente di sviluppo.

### Eliminazione delle credenziali del servizio

Per eliminare una serie di credenziali del servizio,
utilizza un comando simile al seguente:

```sh
bx cf delete-service-key <instance name> <credentials name>
```
{:pre}

Ad esempio,
per eliminare le credenziali denominate `creds20170517a`
dall'istanza `cs20170517a` di un servizio
{{site.data.keyword.cloudant_short_notm}},
potresti utilizzare un comando simile al seguente:

```sh
bx cf delete-service-key cs20170517a creds20170517a
```
{:pre}

### Eliminazione di un'istanza del servizio

Per eliminare un'istanza del servizio,
utilizza un comando simile al seguente:

```sh
bx service delete <instance name>
```
{:pre}

Ad esempio,
per eliminare l'istanza `cs20170517a` del servizio
{{site.data.keyword.cloudant_short_notm}},
potresti utilizzare un comando simile al seguente:

```sh
bx service delete cs20170517a
```
{:pre}

