---

copyright:
  years: 2015, 2019
lastupdated: "2019-03-15"

keywords: start replicating with dashboard, run replication across different accounts, run replication on source or destination, start replication with api, checkpoints, permissions, two-way replication, continuous replication, monitoring replication, canceling replication, filtered replication, changes feed, pitfalls, tuning replication speed

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

# Guida di replica
{: #replication-guide}

I dati possono essere copiati da un database a un altro nello stesso account {{site.data.keyword.cloudantfull}},
in più account e in più data center.
{: shortdesc}

I dati possono anche essere replicati da e verso un account {{site.data.keyword.cloudant_short_notm}} e un dispositivo mobile
utilizzando [{{site.data.keyword.cloudant_short_notm}} Sync ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://cloudant.com/product/cloudant-features/sync/){: new_window}
o [PouchDB ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://pouchdb.com/){: new_window}.
La replica può essere eseguita in una direzione o in entrambe le direzioni,
come operazione 'singola' o continua,
e può essere ottimizzata utilizzando i parametri.

Il protocollo di replica di {{site.data.keyword.cloudant_short_notm}} è compatibile con una gamma di altri database e librerie
il che lo rende particolarmente adatto per le applicazioni Internet of Things (IoT) e mobili.

Questa guida introduce le funzioni di replica di {{site.data.keyword.cloudant_short_notm}},
descrive i casi di utilizzo comuni e mostra come eseguire la replica della tua applicazione correttamente.

## Cos'è la replica?
{: #what-is-replication}

{{site.data.keyword.cloudant_short_notm}} è un archivio dati JSON distribuito con un'API HTTP.
{{site.data.keyword.cloudant_short_notm}} può essere eseguito come servizio su più cloud
o nel tuo rack di server.
I documenti vengono memorizzati nei database e possono raggiungere qualsiasi dimensione poiché {{site.data.keyword.cloudant_short_notm}} frammenta i suoi dati in molti nodi.
La replica è la copia dei dati da un database di origine a un database di destinazione.
I database di origine e di destinazione non devono essere necessariamente nello stesso account {{site.data.keyword.cloudant_short_notm}}
o nello stesso data center.

![replica](../images/replication_guide_1.png)

La replica è completa quando la versione più recente di ogni documento nell'origine viene trasferita nel database di destinazione.
I trasferimenti includono i nuovi documenti,
gli aggiornamenti ai documenti esistenti
e le eliminazioni.
Solo la versione più recente di un documento rimane dopo la replica,
le versioni più vecchie vengono omesse.

Il database di origine rimane inalterato dalla replica,
ad eccezione dei dati del checkpoint che vengono scritti in esso per consentire la ripresa delle repliche parziali dall'ultima posizione nota.
Rimane qualsiasi dato preesistente nel database di destinazione.

## Come avviare la replica utilizzando il dashboard
{: #how-to-start-replication-by-using-the-dashboard}

Il dashboard {{site.data.keyword.cloudant_short_notm}} fornisce una pratica interfaccia utente per attivare la replica.
Fai clic sulla scheda `Replication` nel dashboard {{site.data.keyword.cloudant_short_notm}} e fai clic su `Start Replication`.
Completa il modulo:

![replica2](../images/replication_guide_2.png)

Per motivi di sicurezza, il team {{site.data.keyword.cloudant_short_notm}} ti consiglia di utilizzare le chiavi API IAM o le [chiavi API ](/docs/services/Cloudant?topic=cloudant-authorization#api-keys){: new_window} dell'autenticazione legacy {{site.data.keyword.cloudant_short_notm}} invece delle credenziali a livello di account per i lavori di replica. Per ulteriori informazioni, vedi la [guida IAM](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-){: new_window} o il [documento API di autenticazione](/docs/services/Cloudant?topic=cloudant-authentication#authentication){: new_window} legacy e il [documento API di autorizzazione](/docs/services/Cloudant?topic=cloudant-authorization#authorization){: new_window} legacy.
{: important}

Utilizzando il modulo, definisci i database di origine e di destinazione, poi fai clic su
`Start Replication`.

![replica3](../images/replication_guide_3.png)

Lo stato di ogni attività di replica può essere visualizzato facendo clic sulla scheda `Replication`.
Lo stato di ogni lavoro viene modificato da `Running` a `Completed` man mano che avanza.

![replica4](../images/replication_guide_4.png)

## Come eseguire la replica in diversi account {{site.data.keyword.cloudant_short_notm}}
{: #how-to-run-replication-across-different-ibm-cloudant-accounts}

L'origine e la destinazione di una replica sono URL di database {{site.data.keyword.cloudant_short_notm}},
come mostrato nel seguente esempio.

_Esempio di definizione degli URL di origine e di destinazione per la replica:_

```json
{
    "source": "https://myfirstaccount.cloudant.com/a",
    "target": "https://mysecondaccount.cloudant.com/b"
}
```
{: codeblock}

L'origine e la destinazione non devono essere sullo stesso account.
I nomi dei database di origine e di destinazione non devono corrispondere.
Devi essere autorizzato ad accedere sia all'origine che alla destinazione
e devi essere autorizzato a scrivere sulla destinazione.

## La replica viene eseguita sull'origine o sulla destinazione?
{: #is-replication-run-on-the-source-or-the-destination}

La replica può essere avviata nell'estremità di origine o di destinazione.
Questa scelta significa che puoi decidere se l'account A inserisce i dati nell'account B
o se l'account B estrae i dati dall'account A.
In alcuni casi,
potrebbe non essere possibile eseguire la replica in alcuna configurazione,
ad esempio se un account è dietro un firewall.
La replica avviene su HTTP o HTTPS e quindi non è necessario aprire porte non standard.
La decisione su quale dispositivo avvia la replica è tua.

## Come avviare la replica utilizzando l'API {{site.data.keyword.cloudant_short_notm}}
{: #how-to-start-replication-by-using-the-ibm-cloudant-api}

Ogni account {{site.data.keyword.cloudant_short_notm}} ha un database speciale chiamato `_replicator`,
in cui è possibile inserire i lavori di replica.
Per avviare la replica, aggiungi un documento nel database `_replicator`.
Il documento descrive la replica desiderata
e contiene i seguenti campi:

Campo           | Scopo
----------------|--------
`_id`           | La specifica del campo `_id` è facoltativa, ma può essere utile per identificare le attività di replica. Se non fornisci un valore, {{site.data.keyword.cloudant_short_notm}} ne genera uno per te.
`source`        | L'URL del database {{site.data.keyword.cloudant_short_notm}} di origine, incluse le credenziali di accesso.
`target`        | L'URL del database {{site.data.keyword.cloudant_short_notm}} di destinazione, incluse le credenziali di accesso.
`create_target` | (Facoltativo) Determina se creare il database di destinazione se non esiste ancora.

_Esempio di utilizzo di HTTP per avviare un lavoro di replica:_

```http
POST /_replicator HTTP/1.1
Content-Type: application/json
Host: $ACCOUNT.cloudant.com
Authorization: ...
```
{: codeblock}

_Esempio di utilizzo della riga di comando per avviare un lavoro di replica:_

```sh
curl -X POST \
    -H 'Content-type: application/json' \
    'https://$ACCOUNT.cloudant.com/_replicator' \
    -d '@replication.json'
```
{: codeblock}

_Documento JSON di esempio che descrive la replica desiderata:_

```json
{
    "_id": "weekly_backup",
    "source": "https://$ACCOUNT:$PASSWORD@$ACCOUNT1.cloudant.com/source",
    "target": "https://$ACCOUNT:$PASSWORD@$ACCOUNT2.cloudant.com/destination",
    "create_target": true
}
```
{: codeblock}

## Come influisce la replica sull'elenco delle modifiche?
{: #how-does-replication-affect-the-list-of-changes-}

Puoi ottenere un elenco delle modifiche apportate a un documento utilizzando
l'[endpoint `_changes`](/docs/services/Cloudant?topic=cloudant-databases#get-changes).
Tuttavia,
la natura distribuita dei database {{site.data.keyword.cloudant_short_notm}}
indica che la riposta fornita dal feed `_changes`
non può essere un semplice elenco di modifiche che si sono verificate dopo una determinata data e ora.

La discussione sul [Teorema CAP](/docs/services/Cloudant?topic=cloudant-cap-theorem#cap-theorem) chiarisce
che {{site.data.keyword.cloudant_short_notm}} utilizza un modello di 'consistenza eventuale'.
Questo modello significa che se hai richiesto un documento a due diverse repliche di un database
nello stesso momento,
potresti ottenere risultati diversi se una delle copie del database è ancora in attesa di terminare la replica.
Alla fine, le copie del database completano la loro replica in modo che tutte le modifiche a un
documento siano presenti in ciascuna copia. 

Questo modello di 'consistenza eventuale' ha due caratteristiche che influiscono sull'elenco delle modifiche:

1.  Una modifica che influenza un documento avviene quasi certamente in tempi diversi in diverse copie del database.
2.  L'ordine in cui le modifiche influenzano i documenti può differire tra le diverse copie del database,
    a seconda di quando e dove è avvenuta la replica.

Una conseguenza della prima caratteristica è che,
quando un utente richiede un elenco di modifiche,
non ha senso richiedere un elenco delle modifiche dopo uno specifico punto nel tempo.
Il motivo è che l'elenco delle modifiche potrebbe essere fornito da una copia di database diversa,
che ha provocato aggiornamenti di documenti in tempi diversi.
Tuttavia,
_è_ importante chiedere un elenco delle modifiche dopo una determinata modifica,
che viene specificata utilizzando un identificativo di sequenza.

Un'ulteriore conseguenza della prima caratteristica è che
potrebbe essere necessario "guardare indietro" alle precedenti modifiche per concordare l'elenco delle modifiche.
In altre parole,
per ottenere un elenco delle modifiche,
inizi dalla modifica più recente concordata dalle copie del database.
Il punto di accordo tra le copie del database viene identificato all'interno di
{{site.data.keyword.cloudant_short_notm}} utilizzando il meccanismo di [checkpoint](#checkpoints)
che consente di sincronizzare la replica tra le copie del database.

Infine,
una conseguenza della seconda caratteristica è che le singole modifiche visualizzate
nell'elenco potrebbero essere presentate in un ordine diverso
nelle richieste successive che vengono risolte da una diversa copia del database.
In altre parole,
un elenco iniziale delle modifiche potrebbe riportare le modifiche `A`,
`B`
e `C` in tale ordine.
Ma un successivo elenco di modifiche potrebbe riportare le modifiche `C`,
`A`
e `B` in quest'ordine.
Vengono elencate tutte le modifiche,
ma in un ordine diverso.
Questa differenza è dovuta al fatto che la sequenza delle modifiche ricevute durante la replica
può variare tra due diverse copie del database.

### Cosa significa 'consistenza eventuale' per l'elenco di modifiche?
{: #what-eventual-consistency-means-for-the-list-of-changes}

Quando richiedi un elenco di modifiche,
la risposta che ottieni potrebbe variare a seconda di quale copia del database fornisce l'elenco.

Se utilizzi l'opzione `da` per ottenere un elenco di modifiche dopo un determinato identificativo della sequenza di aggiornamento,
otterrai sempre l'elenco di modifiche dopo tale aggiornamento _e_ potresti anche ottenere alcune modifiche da prima di tale aggiornamento.
Il motivo è che la copia del database che risponde alla richiesta di elenco deve garantire che questo
elenchi le modifiche,
consistenti con tutte le repliche.
Per ottenere questa consistenza,
la copia del database potrebbe dover iniziare l'elenco di modifiche dal punto di accordo
tra tutte le copie.
Questo punto viene identificato utilizzando i checkpoint.

Pertanto,
un'applicazione che utilizza il feed `_changes` deve
essere ['idempotente' ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://www.eaipatterns.com/IdempotentReceiver.html){: new_window}.
Idempotenza significa che l'applicazione deve essere in grado di ricevere in modo sicuro gli stessi dati più volte
e potenzialmente in un ordine diverso per le richieste ripetute.

## Checkpoint
{: #checkpoints}

Internamente,
il processo di replica scrive il suo stato nei documenti di "checkpoint" che vengono memorizzati
in entrambi i database di origine e di destinazione.
I checkpoint consentono di riprendere un'attività di replica da dove era stata interrotta,
senza dover ricominciare da capo.
La creazione del checkpoint può essere evitata fornendo l'opzione
[`"use_checkpoints": false`](/docs/services/Cloudant?topic=cloudant-replication-api#replication-document-format) durante la richiesta della replica.
È utile lasciare attiva la funzione se la replica deve riprendere efficacemente dall'ultima posizione nota.

## Autorizzazioni
{: #permissions}

L'accesso come amministratore è necessario per inserire un documento nel database `_replicator`.
Le credenziali di accesso fornite nei parametri di origine e di destinazione non richiedono autorizzazioni di amministratore complete.
È sufficiente che le credenziali siano in grado di:

-   Scrivere i documenti all'estremità di destinazione.
-   Scrivere i documenti di checkpoint in entrambe le estremità.

{{site.data.keyword.cloudant_short_notm}} ha una speciale autorizzazione utente `_replicator`.
Questa autorizzazione consente di creare i documenti di checkpoint,
ma non consente la creazione di documenti comuni in un database.
In generale,
[crea chiavi API](/docs/services/Cloudant?topic=cloudant-authorization#creating-api-keys) che abbiano:

-   accesso `_reader` e `_replicator` sul lato di origine.
-   accesso `_reader` e `_writer` sul lato di destinazione.

Le chiavi API possono essere create e configurate all'interno del dashboard {{site.data.keyword.cloudant_short_notm}}
in base al database.

![replica](../images/replication_guide_5.png)

Possono essere create anche [in modo programmatico](/docs/services/Cloudant?topic=cloudant-authorization#creating-api-keys) utilizzando l'API {{site.data.keyword.cloudant_short_notm}}.

Per motivi di sicurezza, il team {{site.data.keyword.cloudant_short_notm}} ti consiglia di utilizzare le chiavi API IAM o le [chiavi API ](/docs/services/Cloudant?topic=cloudant-authorization#creating-api-keys){: new_window} dell'autenticazione legacy {{site.data.keyword.cloudant_short_notm}} invece delle credenziali a livello di account per i lavori di replica. Per ulteriori informazioni, vedi la [guida IAM](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-){: new_window} o il [documento API di autenticazione](/docs/services/Cloudant?topic=cloudant-authentication#authentication){: new_window} legacy e il [documento API di autorizzazione](/docs/services/Cloudant?topic=cloudant-authorization#authorization){: new_window} legacy.
{: important}

## Replica a due vie
{: #two-way-replication}

I dati possono essere copiati in entrambe le direzioni in un processo noto come replica a due vie o sincronizzazione.
Puoi abilitare questa sincronizzazione impostando due processi di replica separati,
uno prendendo i dati da A a B
e l'altro prendendo i dati da B ad A.
Entrambi i processi di replica funzionano in modo indipendente,
con i dati spostati uniformemente in entrambe le direzioni.

![replica6](../images/replication_guide_6.png)

## Discussione sulla replica continua
{: #discussion-about-continuous-replication}

Finora,
la discussione si è occupata solo della replica singola,
che termina quando tutti i dati di origine vengono scritti nel database di destinazione.
Con la replica continua,
i dati fluiscono continuamente.
Tutte le modifiche successive apportate al database di origine vengono trasmesse al database di destinazione in tempo reale.

La replica continua viene attivata facendo clic sulla casella di spunta `Make this replication continuous` quando definisci un'attività di replica nel dashboard {{site.data.keyword.cloudant_short_notm}}
o impostando l'indicatore [`continuous`](/docs/services/Cloudant?topic=cloudant-replication-api#replication-document-format) nell'API {{site.data.keyword.cloudant_short_notm}}.

La replica a due vie può essere resa continua in una o entrambe le direzioni,
impostando l'indicatore `continuous`.

_Esempio di utilizzo di HTTP per avviare una replica continua:_

```http
POST /_replicator HTTP/1.1
Content-Type: application/json
Host: $ACCOUNT.cloudant.com
Authorization: ...
```
{: codeblock}

_Esempio di utilizzo della riga di comando per avviare una replica continua:_

```sh
curl -X POST \
    -H "Content-type: application/json" \
    https://$ACCOUNT.cloudant.com/_replicator \
    -d @continuous-replication.json
```
{: codeblock}

_Esempio di documento JSON che definisce una replica continua:_

```json
{
    "_id": "weekly_continuous_backup",
    "source": "https://$ACCOUNT:$PASSWORD@$ACCOUNT1.cloudant.com/source",
    "target": "https://$ACCOUNT:$PASSWORD@$ACCOUNT2.cloudant.com/destination",
    "continuous": true
}
```
{: codeblock}

## Monitoraggio dello stato della replica
{: #monitoring-replication-status}

Puoi controllare lo stato del database `_replicator` di {{site.data.keyword.cloudant_short_notm}} in qualsiasi momento utilizzando il dashboard oppure l'API.

Se la replica non è riuscita,
ad esempio perché le credenziali di autenticazione non erano valide,
lo stato di errore viene registrato nel documento `_replicator`.
Inoltre, l'[endpoint `/_active_tasks`](/docs/services/Cloudant?topic=cloudant-active-tasks#active-tasks)
dell'account {{site.data.keyword.cloudant_short_notm}}può essere utilizzato per vedere l'avanzamento del lavoro di replica. 

_Esempio di utilizzo di HTTP per monitorare un processo di replica:_

```http
GET /_replicator/weekly_backup HTTP/1.1
HOST: $ACCOUNT.cloudant.com
Authorization: ...
```
{: codeblock}

_Esempio di utilizzo della riga di comando per monitorare un processo di replica:_

```sh
curl 'https://$ACCOUNT.cloudant.com/_replicator/weekly_backup'
```
{: codeblock}

_Risposta di esempio alla richiesta dello stato di una replica:_

```json
{
    "_id": "weekly_backup",
    "_rev": "22-c57c18f7e761f1a76fa977caa03cd098",
    "source": "https://u:p@myaccount.cloudant.com/a",
    "create_target": false,
    "target": "https://u:p@myaccount.cloudant.com/b",
    "continuous": true,
    "_replication_state": "triggered",
    "_replication_state_time": "2014-12-01T15:19:01+00:00",
    "_replication_id": "4514b08cb4c2ded7da9ab04a87182ceb"
}
```
{: codeblock}

Quando esegui la replica, se i documenti o gli allegati superano il limite massimo nella destinazione, la replica ha esito negativo. Ogni errore di scrittura del documento aumenta il conteggio delle statistiche di replica in `doc_write_failures`. Per questo motivo, sei esortato a monitorare tale campo.

## Annullamento della replica
{: #canceling-replication}

Per arrestare un lavoro di replica in corso,
elimina il documento di replica dal database `_replicator`,
utilizzando il dashboard o l'API.

_Esempio di utilizzo di HTTP per annullare una replica:_

```http
DELETE /_replicator/weekly_backup?rev=22-c57c18f7e761f1a76fa977caa03cd098 HTTP/1.1
Host: $ACCOUNT.cloudant.com
Authorization:
```
{: codeblock}

_Esempio di utilizzo della riga di comando per annullare una replica:_

```sh
curl -X DELETE 'https://$ACCOUNT.cloudant.com/_replicator/weekly_backup?rev=22-c57c18f7e761f1a76fa977caa03cd098'
```
{: codeblock}

## Altri casi di utilizzo della replica
{: #other-replication-use-cases}

Il protocollo di replica di {{site.data.keyword.cloudant_short_notm}} è compatibile con altri database e librerie per diverse applicazioni del mondo reale.

### Apache CouchDB
{: #apache-couchdb}

[Apache CouchDB ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://couchdb.apache.org/){: new_window} è un database open source
che può comunicare con {{site.data.keyword.cloudant_short_notm}}
e richiede una configurazione minima.
Le applicazioni includono:

-   Backup: replica i tuoi dati da {{site.data.keyword.cloudant_short_notm}} ai database CouchDB
    ed esegui istantanee notturne dei tuoi dati per scopi di archiviazione.
    Invia i dati in un servizio di backup come
    [Amazon Glacier ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://aws.amazon.com/glacier/){: new_window} per un'archiviazione sicura.
-   Raccolta dati iniziale in locale: scrivi prima i tuoi dati in Apache CouchDB in locale,
    quindi replica i dati in {{site.data.keyword.cloudant_short_notm}} per l'archiviazione di lungo termine,
    l'aggregazione
    e l'analisi.

### PouchDB
{: #pouchdb}

[PouchDB ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://pouchdb.com/){: new_window} è un database open source
progettato per lavorare con i browser che consente di replicare i dati in entrambe le direzioni tra il browser e {{site.data.keyword.cloudant_short_notm}}.
La memorizzazione dei dati in un browser web sul lato client consente alle applicazioni web di funzionare
anche senza una connessione a Internet.
PouchDB può sincronizzare i dati modificati da e verso {{site.data.keyword.cloudant_short_notm}} quando è presente una connessione Internet.
L'impostazione della replica dal lato client richiede alcune righe di JavaScript.

_JavaScript di esempio che utilizza PouchDB per abilitare la replica:_

```javascript
var db = new PouchDB("myfirstdatabase");
var URL = "https://u:p@username.cloudant.com/my_database");
db.sync(URL, { live: true });
```
{: codeblock}

### CloudantSync
{: #cloudantsync}

[CloudantSync ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://cloudant.com/cloudant-sync-resources/){: new_window} è una serie di librerie
per iOS e Android che consente di memorizzare i dati localmente in un dispositivo mobile
e di sincronizzarli con  {{site.data.keyword.cloudant_short_notm}} quando la connettività mobile lo consente.
Come con [PouchDB](#pouchdb),
l'impostazione della replica richiede alcune righe di codice.

_JavaScript di esempio che utilizza CloudantSync per abilitare la replica:_

```javascript
URI uri = new URI("https://u:p@username.cloudant.com/my_database");
Datastore ds = manager.openDatastore("my_datastore");
// Replicate from the local to remote database
Replicator replicator = ReplicatorFactory.oneway(ds, uri);
// Fire-and-forget (there are easy ways to monitor the state too)
replicator.start();
```
{: codeblock}

CloudantSync è ampiamente utilizzato nelle applicazioni mobili,
come nei giochi per iPhone e Android,
dove lo stato dell'applicazione è mantenuto in {{site.data.keyword.cloudant_short_notm}} dalla replica,
ma i dati sono disponibili anche sul dispositivo per l'utilizzo non in linea.

## Repliche filtrate
{: #filtered-replications}

Quando esegui la replica da un database a un altro, è utile poter rimuovere alcuni
dati durante tale processo di replica.
Alcuni esempi comprendono:

-   Rimozione di tutte le tracce dei documenti eliminati,
    rendendo il database di destinazione più piccolo rispetto a quello di origine.
-   Segregazione dei dati in parti più piccole,
    come ad esempio la memorizzazione dei dati del Regno Unito in un database e dati degli Stati Uniti in un altro.

### Funzioni di filtro della replica
{: #replication-filter-functions}

La replica filtrata di {{site.data.keyword.cloudant_short_notm}} consente la definizione di una funzione JavaScript che utilizza il valore restituito
per determinare se ogni documento in un database deve essere filtrato o meno.
Le [funzioni di filtro](/docs/services/Cloudant?topic=cloudant-design-documents#filter-functions) sono memorizzate
nei [documenti di progettazione](/docs/services/Cloudant?topic=cloudant-design-documents#design-documents).

Il seguente esempio è una funzione di filtro che consente di replicare solo i documenti non eliminati.

_Funzione di filtro di esempio per replicare i documenti non eliminati:_

```javascript
function(doc, req) {
    if (doc._deleted) {
        return false;
    }
    return true;
}
```
{: codeblock}

Quando viene avviato un lavoro di replica,
viene specificato il nome di una funzione di filtro come combinazione del documento di progettazione in cui
è memorizzata e il nome della funzione di filtro.
Puoi anche specificare un valore `query_params`.
Questo valore è un oggetto che contiene le proprietà che vengono passate
alla funzione di filtro nel campo `query` del suo secondo argomento (`req`).

_Esempio di utilizzo di HTTP per avviare una replica filtrata:_

```http
POST /_replicator HTTP/1.1
Content-Type: application/json
Host: $ACCOUNT.cloudant.com
Authorization: ...
```
{: codeblock}

_Esempio di utilizzo della riga di comando per avviare una replica filtrata:_

```sh
curl -X POST \
    -H "Content-type: application/json" \
    https://$ACCOUNT.cloudant.com/_replicator \
    -d @filtered-replication.json
```
{: codeblock}

_Esempio di documento JSON che definisce una replica filtrata:_

```json
{
    "_id": "weekly_backup",
    "source": "https://$ACCOUNT:$PASSWORD@$ACCOUNT1.cloudant.com/source",
    "target": "https://$ACCOUNT:$PASSWORD@$ACCOUNT2.cloudant.com/destination",
    "filter": "mydesigndoc/myfilter",
    "query_params": {
        "foo": "bar",
        "baz": 5
    }
}
```
{: codeblock}

## Feed delle modifiche
{: #changes-feed}

{{site.data.keyword.cloudant_short_notm}} pubblica le aggiunte,
le modifiche
e le eliminazioni che interessano un database attraverso un singolo feed HTTP
dall'[endpoint `_changes`](/docs/services/Cloudant?topic=cloudant-databases#get-changes).
Questo feed può essere utilizzato dalla tua applicazione per attivare gli eventi.
Puoi accedere al feed utilizzando HTTP o `curl`,
come mostrato negli esempi.
L'utilizzo dell'opzione `feed=continuous` significa che il flusso ti fornisce
tutte le modifiche necessarie per ottenere la versione più recente di ogni documento presente nel database.

_Esempio di utilizzo di HTTP per eseguire una query del feed delle modifiche:_

```http
GET /$DATABASE/_changes?feed=continuous HTTP/1.1
Host: $ACCOUNT.cloudant.com
Authorization: ...
```
{: codeblock}

_Esempio di utilizzo della riga di comando per eseguire una query del feed delle modifiche:_

```sh
curl "https://$ACCOUNT.cloudant.com/$DATABASE/_changes?feed=continuous"
```
{: codeblock}

Le modifiche vengono descritte utilizzando una riga per ogni modifica.
Ciascuna modifica è composta da:

1.  Una stringa che contiene un numero di sequenza (`seq`).
2.  Una stringa che contiene l'ID del documento che è stato modificato.
3.  Un array di modifiche.

Per visualizzare il corpo del documento stesso,
aggiungi `&include_docs=true` al comando curl.

Ogni modifica viene descritta utilizzando il formato mostrato nel seguente esempio (abbreviato).

_Esempio di feed `_changes`:_

```json
{
    "seq":"11-g1A...c1Q",
    "id":"6f8ab9fa52c117eb76240daa1a55827f",
    "changes":[
        {
          "rev":"1-619d7981d7027274a4b88810d318a7b1"
        }
    ]
}
```
{: codeblock}

Per unire il feed delle modifiche da una posizione nota,
passa un [argomento `since`](/docs/services/Cloudant?topic=cloudant-databases#the-since-argument) con il numero di sequenza da cui vuoi iniziare.

_Esempio (abbreviato) di utilizzo di HTTP per fornire l'opzione `since` per unire un feed `_changes` in una posizione nota:_

```http
GET /$DATABASE/_changes?feed=continuous&include_docs=true&since=11-g1A...c1Q HTTP/1.1
HOST: $ACCOUNT.cloudant.com
Authorization: ...
```
{: codeblock}

_Esempio (abbreviato) di utilizzo della riga di comando per fornire l'opzione `since` per unire un feed `_changes` in una posizione nota:_

```sh
curl "https://$ACCOUNT.cloudant.com/$DATABASE/_changes?feed=continuous&include_docs=true&since=11-g1A...c1Q"
```
{: codeblock}

Per riunire il feed delle modifiche dal momento corrente,
imposta `since=now`.

_Esempio di utilizzo di HTTP per fornire `since=now` per unire un feed `_changes` nel momento corrente:_

```http
GET /$DATABASE/_changes?feed=continuous&include_docs=true&since=now HTTP/1.1
Host: $ACCOUNT.cloudant.com
Authorization: ...
```
{: codeblock}

_Esempio di utilizzo della riga di comando per fornire `since=now` per un unire un feed `_changes` nel momento corrente:_

```sh
curl "https://$ACCOUNT.cloudant.com/$DATABASE/_changes?feed=continuous&include_docs=true&since=now"
```
{: codeblock}

_Esempio di utilizzo di JavaScript per fornire `since=now` per unire un feed `_changes` nel momento corrente:_

```javascript
var feed = db.follow({since: "now", include_docs: true})
feed.on('change', function (change) {
    console.log("change: ", change);
})
feed.follow();
```
{: codeblock}

L'accesso ai dati `_changes` in modo programmato è semplice.
Ad esempio,
utilizza la [libreria Node.js {{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant?topic=cloudant-supported-client-libraries#node-js)
per seguire le modifiche con poche righe di codice.

Alcuni casi di utilizzo di esempio potrebbero essere:

-   Aggiunta di elementi a una coda di messaggi per attivare azioni nella tua applicazione,
    come l'invio di una e-mail del cliente.
-   Aggiornamento di un database in memoria per registrare i conteggi in diretta dell'attività.
-   Scrittura dei dati in un file di testo per inserire i dati in un database SQL.

Il feed delle modifiche può essere filtrato con una funzione di filtro,
utilizzando una tecnica simile al [filtraggi durante la replica](#filtered-replication).

_Esempio di utilizzo di HTTP per filtrare il feed delle modifiche:_

```http
GET /$DATABASE/_changes?feed=continuous&include_docs=true&since=now&filter=mydesigndoc/myfilter HTTP/1.1
Host: $ACCOUNT.cloudant.com
Authorization: ...
```
{: codeblock}

_Esempio di utilizzo della riga di comando per filtrare il feed delle modifiche:_

```sh
curl "https://$ACCOUNT.cloudant.com/$DATABASE/_changes?feed=continuous&include_docs=true&since=now&filter=mydesigndoc/myfilter"
```
{: codeblock}

L'ordine dei documenti nel feed `_changes` non è sempre lo stesso. In altre parole, le modifiche potrebbero non essere visualizzate in un rigoroso ordine di tempo. Il motivo è che i dati vengono restituiti da più nodi {{site.data.keyword.cloudant_short_notm}}
    e si applicano le regole della consistenza eventuale.
{: tip}

## Insidie della replica
{: #replication-pitfalls}

Per eseguire correttamente la replica, la somma della dimensione del documento e di quelle di tutti gli allegati deve essere inferiore alla dimensione massima della richiesta del cluster di destinazione. Ad esempio, se la dimensione massima della richiesta HTTP è 11 MB, si applicano i seguenti scenari:

Dimensione documento | Dimensione allegato | Dimensione totale | Repliche?
--------------|----------------------|------------|------------
1 MB | Cinque allegati da 2 MB | 11 MB | sì
1 MB | Un allegato da 10 MB | 11 MB | sì
0 MB | Cento allegati da 1 MB | 100 MB | no

Si applicano diverse considerazioni sull'utilizzo della replica.

### Autorizzazioni utente non corrette
{: #incorrect-user-permissions}

Affinché la replica proceda in modo ottimale quando replichi dal database "a" al database "b",
le credenziali fornite devono avere:

*   le autorizzazioni `_reader` e `_replicator` sul database "a".
*   le autorizzazioni `_writer` sul database "b".

Le chiavi API vengono generate nel dashboard {{site.data.keyword.cloudant_short_notm}} o tramite l'[API](/docs/services/Cloudant?topic=cloudant-authorization#creating-api-keys).
A ogni chiave possono essere forniti diritti individuali relativi a uno specifico database {{site.data.keyword.cloudant_short_notm}}.
{{site.data.keyword.cloudant_short_notm}} deve essere in grado di scrivere i propri documenti di checkpoint alla fine della "lettura" della replica,
altrimenti non viene salvato alcuno stato e la replica non può riprendere da dove è stata interrotta.
Se lo stato non viene salvato,
potrebbero verificarsi dei problemi di prestazione durante la ripresa della replica di grandi serie di dati.
Il motivo è che senza checkpoint,
il processo di replica riparte dall'inizio ogni volta che viene ripreso.

### Il documento di replica è in conflitto
{: #replication-document-is-conflicted}

Un'altra conseguenza dell'impostazione errata delle autorizzazioni utente è che il documento `_replicator` va in conflitto.
Il documento `_replicator` registra lo stato corrente del processo di replica.
In casi estremi,
il documento può diventare enorme perché contiene molti conflitti non risolti.
Un documento così grande utilizza gran parte dello spazio disponibile e causa un carico aggiuntivo del server.

Puoi controllare la dimensione del tuo database `_replicator` inviando una richiesta `GET` all'endpoint `/_replicator`:

```http
GET https://$ACCOUNT.cloudant.com/_replicator
```
{: codeblock}

Nel JSON restituito,
cerca il valore `disk_size`.
Se il valore indica una dimensione di oltre 1 GB,
contatta il [{{site.data.keyword.cloudant_short_notm}}team di supporto ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](mailto:support@cloudant.com){: new_window} per ulteriori suggerimenti.

Puoi controllare i conflitti di un singolo documento `_replicator`,
come mostrato nel seguente esempio:

```http
GET https://$ACCOUNT.cloudant.com/_replicator/<<docid>>?conflicts=true
```
{: codeblock}

Se vuoi annullare tutte le repliche e iniziare con una nuova,
pulisci il database `_replicator`
e quindi elimina e ricrea il database `replicator`.

_Esempio di utilizzo di HTTP per rimuovere e ricreare il database `_replicator`:_

```http
DELETE /_replicator HTTP/1.1
HOST: $ACCOUNT.cloudant.com
Authorization: ...

PUT /_replicator HTTP/1.1
HOST: $ACCOUNT.cloudant.com
Authorization: ...
```
{: codeblock}

_Esempio di utilizzo della riga di comando per rimuovere e ricreare il database `_replicator`:_

```sh
curl -X DELETE 'https://$ACCOUNT.cloudant.com/_replicator'
curl -X PUT 'https://$ACCOUNT.cloudant.com/_replicator'
```
{: codeblock}

### Molte repliche simultanee
{: #many-simultaneous-replications}

È facile dimenticare di aver precedentemente impostato la replica tra due database
e creare quindi ulteriori processi di replica per errore.
Ogni lavoro di replica è indipendente dall'altro,
pertanto {{site.data.keyword.cloudant_short_notm}} non ti impedisce di creare processi di replica aggiuntivi.
Tuttavia, ogni attività di replica consuma le risorse del sistema.

Puoi controllare le tue "repliche attive" nel dashboard {{site.data.keyword.cloudant_short_notm}} per garantire che non ci siano attività di replica indesiderate in corso.
Elimina tutti i documenti `_replicator` che non sono più necessari.

## Ottimizzazione della velocità di replica
{: #tuning-replication-speed}

Per impostazione predefinita,
la replica {{site.data.keyword.cloudant_short_notm}} viene eseguita con una frequenza appropriata per spostare i dati dall'origine alla destinazione
senza influire negativamente sulle prestazioni.
La scelta tra la frequenza di replica e le prestazioni del cluster per altre attività diventa un compromesso.
Il tuo caso di utilizzo potrebbe richiedere una replica più rapida a scapito di altri servizi {{site.data.keyword.cloudant_short_notm}}.
In alternativa,
potresti richiedere di dare la priorità alle prestazioni del cluster,
trattando la replica come processo in background.

Sono disponibili [opzioni avanzate dell'API di replica](/docs/services/Cloudant?topic=cloudant-advanced-replication#advanced-replication), che consentono un aumento o una diminuzione della quantità di potenza di calcolo utilizzata durante la replica. Ad esempio:

*   Se i tuoi documenti contengono allegati,
    potresti ridurre il valore di batch_size e aumentare il valore di worker_processes,
    per ospitare documenti più grandi in batch più piccoli.
*   Se hai tanti piccoli documenti,
    potresti aumentare i valori di
    [`worker_process`](/docs/services/Cloudant?topic=cloudant-advanced-replication#performance-related-options) e
    [`http_connections`](/docs/services/Cloudant?topic=cloudant-advanced-replication#performance-related-options).
*   Se vuoi eseguire la replica con un impatto minimo,
    l'impostazione di `worker_processes` e `http_connections` su 1 potrebbe essere appropriata.

Per ulteriore assistenza sulla configurazione migliore per il tuo caso di utilizzo,
contatta il [team di supporto {{site.data.keyword.cloudant_short_notm}} ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](mailto:support@cloudant.com){: new_window}.
