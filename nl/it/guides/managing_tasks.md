---

copyright:
  years: 2015, 2017
lastupdated: "2017-01-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# Gestione di attività

La creazione di nuovi indici su grandi quantità di dati o la replica di un database di grandi dimensioni può richiedere molto tempo.
{:shortdesc}

Quindi come puoi determinare se le tue attività stanno avanzando o
se sono state completate?
L'[endpoint `_active_tasks` ](../api/active_tasks.html) fornisce informazioni su tutte le attività in corso.
Tuttavia,
se avvii molte attività,
è possibile pianificare alcune di queste per l'esecuzione in un secondo momento e non essere visualizzate in `_active_tasks`
finché non saranno state avviate.

Questa guida ti illustra come utilizzare l'endpoint `_active_tasks` per monitorare le attività a lunga esecuzione.
Il comando `curl` viene utilizzato per accedere all'endpoint.
Il processore JSON della riga di comando `jq` viene utilizzato per elaborare la risposta JSON.

Poiché questa è un'esercitazione incentrata sull'attività,
descrive solo le operazioni fondamentali per completare questa attività.
Consulta la [Guida di riferimento API](../api/index.html) per una guida completa alle opzioni disponibili.

## Principi di base di curl e jq

Per ottenere tutte le attività in corso e formattare bene l'output,
richiama il tuo account utilizzando `curl`
e passa l'output a `jq`.

`jq` ti consente di filtrare un elenco di documenti in base ai loro valori di campo.
Questo semplifica il richiamo di tutti i documenti di replica
o dei dettagli di una particolare attività di indicizzazione delle viste.
La [Guida di riferimento API](../api/index.html) contiene ulteriori informazioni sulle opzioni.

_Esempio di acquisizione e formattazione di un elenco di attività in corso:_

```sh
curl 'https://username:password@username.cloudant.com/_active_tasks' | jq '.'
```
{:codeblock}

## Monitoraggio delle creazioni delle viste e degli indici di ricerca

Gli indici delle viste vengono ricreati quando un documento di progettazione viene aggiornato.
Un aggiornamento a una qualsiasi delle viste provoca la ricostruzione di tutte le viste nel documento.

Gli indici di ricerca vengono ricreati solo quando la loro funzione di indice corrispondente viene modificata.
Per ogni indice di ricerca creato e per ogni documento di progettazione con le viste modificate,
viene creata una nuova attività per ogni replica di ciascun frammento in un cluster.

Ad esempio,
se ci sono 24 frammenti,
con tre repliche ognuno,
e aggiorni due indici di ricerca,
verranno eseguite 24 x 3 x 2 = 144 attività.

Per trovare tutte le attività di indicizzazione delle viste,
passa l'output `curl` a `jq`
e quindi filtra i documenti nell'array in base al campo del tipo.
Un comando corrispondente funziona per le attività di indicizzazione della ricerca.

In ogni caso,
il risultato della ricerca di un elenco di attività di indicizzazione è un elenco di oggetti JSON:
uno per ciascuna delle attività in corso rilevate.

_Esempio di ricerca di tutte le attività di indicizzazione delle viste, filtrandole per il tipo `indexer`:_

```sh
curl -s 'https://username:password@username.cloudant.com/_active_tasks' | jq '.[] | select(.type=="indexer")'
```
{:codeblock}

_Esempio di ricerca di tutte le attività di indicizzazione della ricerca, filtrandole per il tipo `search_indexer`:_

```sh
curl -s 'https://username:password@username.cloudant.com/_active_tasks' | jq '.[] | select(.type=="search_indexer")'
```
{:codeblock}

_Risultati di esempio dopo la ricerca delle attività di indicizzazione delle viste:_

```json
{
    "total_changes": 6435,
    "started_on": 1371118332,
    "user": "username",
    "updated_on": 1371118334,
    "type": "indexer",
    "node": "dbcore@db6.meritage.cloudant.net",
    "pid": "<0.16366.6103>",
    "changes_done": 364,
    "database": "shards/40000000-7fffffff/username/database",
    "design_document": "_design/ngrams"
}
```
{:codeblock}

## Stima del tempo per completare un'attività

Per stimare il tempo necessario per completare l'attività di indicizzazione,
monitora il numero di `changes_done` e confronta questo valore con `total_changes`.
Ad esempio,
se `changes_done` avanza di 250 al secondo
e `total_changes` è 1.000.000,
si prevede che il completamento dell'attività richiederà 1.000.000 / 250 = 4.000 secondi,
o all'incirca 66 minuti.

>   **Nota**: le stime del tempo per completare un'attività di indicizzazione non possono essere esatte al 100% .
    Il tempo effettivo per completare l'attività dipende da diversi fattori,
    tra cui:

-   Il tempo impiegato per elaborare ogni documento.
    Ad esempio,
    una vista potrebbe controllare prima il tipo di documento
    ed emettere nuove voci di indice solo per un tipo.
-   La dimensione dei documenti.
-   Il carico di lavoro corrente sul cluster.

>   Tieni presente che questi fattori potrebbero combinarsi e produrre una notevole imprecisione sulla tua stima.

_Esempio di estrazione del campo `changes_done` utilizzando `jq`:_

```sh
curl ... | jq '.[] | select(.type=="search_indexer") | .changes_done'
```
{:codeblock}

## Monitoraggio della replica

Per trovare tutte le attività di replica,
passa l'output `curl` a `jq`
e filtra i documenti nell'array in base al campo del tipo.

Per semplificare la selezione delle informazioni relative a un processo di replica dall'elenco di attività in corso,
avvia il processo di replica creando un documento nel database `_replicator`
e imposta i suo campo `_id` su un valore noto.

_Esempio di ricerca di tutte le attività di replica, filtrandole per il tipo `replication`:_

```sh
curl -s 'https://username:password@username.cloudant.com/_active_tasks' | jq '.[] | select(.type=="replication")'
```
{:codeblock}

_Esempio di ricerca di una specifica attività di replica, filtrando per un'identità di documento nota:_

```sh
curl ... | jq '.[] | select(.doc_id=="ID")'
```
{:codeblock}

_Esempio di ricerca di una specifica attività di replica, filtrando per un `replication_id` noto:_

```sh
curl ... | jq '.[] | select(.replication_id=="ID")'
```
{:codeblock}

_Risultato di esempio dopo la ricerca di un'attività di replica:_

```json
{
    "started_on": 1371094220,
    "source_seq": "62960-sakdjflksdfjsdlkafjalskdfjlsakfjlasdkjksald",
    "source": "",
    "revisions_checked": 12,
    "continuous": true,
    "doc_id": null,
    "doc_write_failures": 0,
    "docs_read": 12,
    "target": "",
    "type": "replication",
    "updated_on": 1371118477,
    "user": "username",
    "checkpointed_source_seq": "61764-dskfjalsfjsalkfjssadjfhasdfkjhsdkfhsdkf",
    "changes_pending": 1196,
    "pid": "<0.9955.4120>",
    "node": "dbcore@db7.meritage.cloudant.net",
    "docs_written": 12,
    "missing_revisions_found": 12,
    "replication_id": "asfksdlfkjsadkfjsdalkfjas+continuous+create_target"
}
```
{:codeblock}

## Risoluzione dei problemi

### Un'attività è bloccata?

Per una replica unica e
non continua,
in cui il database di origine non viene aggiornato in modo significativo durante la replica,
il valore `changes_pending` ti indica quanti documenti rimangono da elaborare.
Questo significa che il valore `changes_pending` è un buon indicatore di quando è probabile che la replica venga terminata.

Per una replica continua,
sei più interessato a come il numero di documenti elaborati cambia nel tempo
e se il valore di `changes_pending` aumenta.
Se `changes_pending` aumenta,
ma `revisions_checked` rimane constante per un po',
è probabile che la replica sia bloccata.
Se `changes_pending` aumenta
e aumenta anche `revisions_checked`,
ciò potrebbe indicare che la replica non riesce a tenere il passo con il volume di dati aggiunti
o aggiornati nel
database.

### Cosa fare con un'attività bloccata?

Per risolvere una replica bloccata,
potresti dover [annullare il processo di replica](../api/replication.html#cancelling-a-replication) e avviarlo di nuovo.

Se ciò non aiuta,
la replica potrebbe essere bloccata perché l'utente che accede ai database di origine o di destinazione
non dispone delle autorizzazioni di scrittura.

>   **Nota**: la replica utilizza i [checkpoint](replication_guide.html#checkpoints).
    Ciò significa che il contenuto già replicato e invariato
    non deve essere replicato nuovamente se la replica viene riavviata.

Se hai iniziato il processo di replica creando un documento nel database `_replicator`,
puoi anche controllare lo stato della replica da lì.
