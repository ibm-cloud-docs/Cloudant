---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: incremental backups, create an incremental backup, restore a database, how to back up example, how to restore example

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

# Incrementi di replica
{: #replication-incrementals}

Questa guida contiene istruzioni vecchie o 'obsolete' sul backup {{site.data.keyword.cloudantfull}}. Per le istruzioni di backup aggiornate,
    consulta la guida [Ripristino di emergenza e backup](/docs/services/Cloudant?topic=cloudant-disaster-recovery-and-backup#disaster-recovery-and-backup).
{: deprecated}

I backup del database proteggono i tuoi dati da eventuali perdite o danneggiamenti.
{: shortdesc}

Puoi utilizzare la funzione di replica {{site.data.keyword.cloudant_short_notm}} per creare un backup del database
e memorizzarlo su un cluster {{site.data.keyword.cloudant_short_notm}}.
Puoi quindi ripristinare dati,
interi database
o specifici documenti JSON,
da questi backup al tuo cluster di produzione.

Utilizzando la replica {{site.data.keyword.cloudant_short_notm}},
un backup del database memorizza i contenuti del tuo database in un checkpoint.
È possibile eseguire il 'rollback' a uno specifico checkpoint.
Il checkpoint non è specifico di un tempo preciso.
È, invece,
un record del database così come era dopo specifiche modifiche apportate durante il periodo di backup.
In questo modo,
un backup può conservare lo stato del tuo database in un momento selezionato.

## Backup incrementali
{: #incremental-backups}

Se sei un cliente aziendale,
è disponibile una funzionalità di backup incrementale giornaliera. Per ulteriori informazioni, vedi [Ripristino di emergenza e backup](/docs/services/Cloudant?topic=cloudant-disaster-recovery-and-backup#disaster-recovery-and-backup).

Se non sei un cliente aziendale,
o se preferisci creare i tuoi propri backup,
puoi utilizzare la funzione di replica {{site.data.keyword.cloudant_short_notm}} per creare un backup del database.

Un approccio semplice è quello di replicare l'intero database in un database di backup datato.
Questo metodo funziona ed è facile da usare.
Ma se hai bisogno di backup per più punti nel tempo,
ad esempio sette backup giornalieri e quattro settimanali,
devi memorizzare una copia completa del database in ogni nuovo database di backup.
Una copia completa potrebbe richiedere un utilizzo significativo del disco,
soprattutto se il tuo database è grande.

Come alternativa,
i backup incrementali sono una buona soluzione per memorizzare
solo i documenti che sono stati modificati dall'ultimo backup.

Il processo è semplice.
Inizialmente,
crei un backup dell'intero database.
Dopo il primo backup,
esegui dei backup 'incrementali' giornalieri,
copiando _solo _ ciò che è stato modificato nel database dall'ultimo backup.
Questa replica diventa un backup giornaliero.

Puoi configurare un backup da attivare a intervalli regolari.
Tuttavia,
    ogni intervallo deve essere di almeno 24 ore. In altre parole,
    puoi eseguire backup giornalieri ma non backup orari.
{: note}

## Creazione di un backup incrementale
{: #creating-an-incremental-backup}

I backup incrementali salvano solo le differenze o 'delta' tra i backup.
Ogni 24 ore,
il database di origine viene replicato in un database di destinazione.

La replica utilizza i valori di sequenza per identificare i documenti che sono stati modificati durante il periodo di 24 ore.
L'operazione di backup funziona utilizzando la replica per ottenere e memorizzare un checkpoint.
Un checkpoint è un altro documento con un nome interno.
L'operazione di backup crea il nome da una combinazione della data e del nome dell'attività di backup.
Questo nome rende più facile identificare i checkpoint durante il processo di ripristino o di rollup.

Per creare un backup incrementale,
completa la seguente procedura:

1.  Trova l'ID del documento di checkpoint per l'ultima replica.
    Questo valore è memorizzato nel campo `_replication_id` del documento di replica,
    presente nel database `_replicator`.
2.  Apri il documento di checkpoint in `/$DATABASE/_local/$REPLICATION_ID`,
    dove `$REPLICATION_ID` è l'ID che hai trovato nel passo precedente
    e `$DATABASE` è il nome del database di origine o di destinazione.
    Il documento di solito si trova in entrambi i database,
    ma potrebbe trovarsi solo in uno.
3.  Cerca il campo `recorded_seq` del primo elemento
    nell'array di cronologia che si trova nel documento di checkpoint.
4.  Esegui la replica nel nuovo database di backup incrementale,
    impostando il [campo `since_seq`](/docs/services/Cloudant?topic=cloudant-replication-api#the-since_seq-field)
    nel documento di replica sul valore del campo `recorded_seq` trovato nel passo precedente.

Per definizione, l'utilizzo dell'opzione `since_seq` ignora la normale funzione di checkpoint. Utilizza `since_seq` con cautela. 
{: note}

## Ripristino di un database
{: #restoring-a-database}

Per ripristinare un database dai backup incrementali,
dovrai replicare ogni backup incrementale in un nuovo database,
a partire dall'incremento più recente.

Potresti iniziare con il backup più vecchio
e quindi applicare i successivi backup in ordine.
Tuttavia,
la replica dal primo backup incrementale più recente è più veloce perché i
documenti aggiornati vengono scritti solo una volta nel database di destinazione.
Tutti i documenti più vecchi di una copia già presente nel nuovo database vengono ignorati.


## Un esempio
{: #an-example}

Questo esempio mostra come:

1.  Impostare i database per utilizzare il backup incrementale.
2.  Eseguire un backup completo.
3.  Impostare ed eseguire un backup incrementale.
4.  Ripristinare un backup.

### Costanti utilizzate qui
{: #constants-that-are-used-here}

```sh
# save base URL and the content type in shell variables
$ url='https://$ACCOUNT:$PASSWORD@$ACCOUNT.cloudant.com'
$ ct='Content-Type: application-json'
```
{: codeblock}

Supponiamo che tu debba eseguire il backup di un database.
Vuoi creare un backup completo il lunedì
e un backup incrementale il martedì.

Puoi utilizzare i comandi `curl` e [`jq` ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://stedolan.github.io/jq/){: new_window}
per effettuare queste operazioni.
In pratica,
potresti utilizzare qualsiasi client HTTP.

### Passo 1: controlla di avere tre database
{: #step-1-check-that-you-have-three-databases}

Per questo esempio,
hai bisogno di tre database:

-   Il database originale,
    che contiene i dati di cui vuoi eseguire il backup-
-   Due database incrementali,
    per lunedì (`backup-monday`) e per martedì (`backup-tuesday`).

_Esempio che mostra come controllare di avere tre database da utilizzare in questo esempio, utilizzando HTTP:_

```http
PUT /original HTTP/1.1
PUT /backup-monday HTTP/1.1
PUT /backup-tuesday HTTP/1.1
```
{: codeblock}

_Esempio che mostra come controllare di avere tre database da utilizzare in questo esempio,
utilizzando la riga di comando:_

```sh
$ curl -X PUT "${url}/original"
$ curl -X PUT "${url}/backup-monday"
$ curl -X PUT "${url}/backup-tuesday"
```
{: codeblock}

### Passo 2: crea il database `_replicator`
{: #step-2-create-the-_replicator-database}

Se non esiste, crea il database `_replicator`.

*Creazione del database `_replicator` utilizzando HTTP:*

```http
PUT /_replicator HTTP/1.1
```
{: codeblock}

*Creazione del database `_replicator` utilizzando la riga di comando:*

```sh
curl -X PUT "${url}/_replicator"
```
{: pre}

### Passo 3: backup dell'intero database (originale)
{: #step-3-back-up-the-entire-original-database}

Il lunedì
vuoi eseguire il backup di tutti i tuoi dati per la prima volta.
Crea questo backup replicando tutti i dati da `original` a `backup-monday`.

_Esecuzione di un backup completo di lunedì utilizzando HTTP:_

```http
PUT /_replicator/full-backup-monday HTTP/1.1
Content-Type: application/json
```
{: codeblock}

_Esecuzione di un backup completo di lunedì utilizzando la riga di comando:_

```sh
$ curl -X PUT "${url}/_replicator/full-backup-monday" -H "$ct" -d @backup-monday.json
# where backup-monday.json describes the backup.
```
{: codeblock}

_Documento JSON che descrive il backup completo:_
 
```json
{
    "_id": "full-backup-monday",
    "source": "${url}/original",
    "target": "${url}/backup-monday"
}
```
{: codeblock}

### Passo 4: preparazione del backup incrementale parte 1 - Ottieni l'ID checkpoint
{: #step-4-prepare-incremental-backup-part-1-get-checkpoint-id}

Il martedì,
vuoi effettuare un backup incrementale
anziché un altro backup completo.

Per avviare il backup incrementale,
hai bisogno di due valori:

-   L'ID checkpoint.
-   [Il valore `recorded_seq`](#step-5-prepare-incremental-backup-part-2-get-recorded_seq-value).

Questi valori identificano dove è terminato l'ultimo backup
e determinano dove iniziare il successivo backup incrementale.
Dopo aver ottenuto questi valori, puoi eseguire il backup incrementale.

Inizia ricercando il valore del'ID checkpoint.
Questo valore è memorizzato nel campo `_replication_id` del documento di replica,
all'interno del database `_replicator`.

*Acquisizione dell'ID checkpoint per aiutare a trovare il valore `recorded_seq`, utilizzando HTTP:*

```http
GET /_replicator/full-backup-monday HTTP/1.1
# Search for the value of _replication_id
```
{: codeblock}

*Acquisizione dell'ID checkpoint per aiutare a trovare il valore `recorded_seq`, utilizzando la riga di comando:*

```sh
replication_id=$(curl "${url}/_replicator/full-backup-monday" | jq -r '._replication_id')
```
{: pre}

### Passo 5: preparazione del backup incrementale parte 2 - Ottieni il valore `recorded_seq`
{: #step-5-prepare-incremental-backup-part-2-get-recorded_seq-value}

Dopo aver ottenuto l'ID checkpoint,
utilizzalo per acquisire il valore `recorded_seq`.
Questo valore si trova nel primo elemento dell'array di cronologia nel documento `/_local/${replication_id}`,
all'interno del database originale.

Adesso disponi del valore `recorded_seq`.
Questo valore identifica l'ultimo documento che è stato replicato dal database originale.

*Acquisizione di `recorded_seq` dal database originale utilizzando HTTP:*

```http
GET /original/_local/${replication_id} HTTP/1.1
# Search for the first value of recorded_seq in the history array
```
{: codeblock}

*Acquisizione di `recorded_seq` dal database originale utilizzando la riga di comando:*

```sh
recorded_seq=$(curl "${url}/original/_local/${replication_id}" | jq -r '.history[0].recorded_seq')
```
{: pre}

### Passo 6: esegui un backup incrementale
{: #step-6-run-an-incremental-backup}

Ora che hai l'ID checkpoint e il valore `recorded_seq`,
puoi avviare il backup incrementale del martedì.
Questo backup replica tutte le modifiche apportate al documento _dall'ultima_ replica.

Al termine della replica,
avrai un backup incrementale completo.
Il backup è costituito da tutti i documenti contenuti nel database originale
e può essere ripristinato recuperando il contenuto dei database `backup-monday` _e _ `backup-tuesday`.

_Esecuzione del backup incrementale di martedì utilizzando HTTP:_

```http
PUT /_replicator/incr-backup-tuesday HTTP/1.1
Content-Type: application/json
```
{: codeblock}

_Esecuzione del backup incrementale di martedì utilizzando la riga di comando:_

```sh
curl -X PUT "${url}/_replicator/incr-backup-tuesday" -H "${ct}" -d @backup-tuesday.json
```
{: pre}

_Documento JSON che descrive il backup incrementale di martedì:_
 
```json
{
    "_id": "incr-backup-tuesday",
    "source": "${url}/original",
    "target": "${url}/backup-tuesday",
    "since_seq": "${recorded_seq}"
}
```
{: codeblock}

### Passo 7: ripristina il backup di lunedì
{: #step-7-restore-the-monday-backup}

Per eseguire il ripristino da un backup,
replica il backup completo iniziale
e qualsiasi backup incrementale,
in un nuovo database.

Ad esempio,
per ripristinare lo stato di lunedì,
devi eseguire la replica dal database `backup-monday`.

_Ripristino dal database `backup-monday` utilizzando HTTP:_

```sh
PUT /_replicator/restore-monday HTTP/1.1
Content-Type: application/json
```
{: codeblock}

_Ripristino dal database `backup-monday` utilizzando la riga di comando:_

```sh
curl -X PUT "${url}/_replicator/restore-monday" -H "$ct" -d @restore-monday.json
```
{: pre}

_Documento JSON che descrive il ripristino:_
 
```json
{
    "_id": "restore-monday",
    "source": "${url}/backup-monday",
    "target": "${url}/restore",
    "create_target": true  
}
```
{: codeblock}

### Passo 8: ripristina il backup di martedì
{: #step-8-restore-the-tuesday-backup}

Per ripristinare il database di martedì,
devi prima eseguire la replica da `backup-tuesday` e poi da `backup-monday`.

L'ordine non è un errore tipografico; l'intenzione _è_ davvero quella di ripristinare da martedì e _poi_ da lunedì.
{: tip}

Potresti ripristinare in sequenza cronologica,
ma utilizzando l'ordine inverso,
i documenti che sono stati aggiornati martedì devono essere scritti nel database di destinazione solo una volta.
Le versioni più vecchie del documento che sono memorizzate nel database di lunedì vengono ignorate.

_Ripristino del backup di martedì, ottenendo per prime le modifiche più recenti, utilizzando HTTP:_

```http
PUT /_replicator/restore-tuesday HTTP/1.1
Content-Type: application/json
```
{: codeblock}

_Ripristino del backup di martedì, ottenendo per prime le modifiche più recenti, utilizzando la riga di comando:_

```sh
curl -X PUT "${url}/_replicator/restore-tuesday" -H "$ct" -d @restore-tuesday.json
```
{: pre}

_Documento JSON che richiede il ripristino del backup di martedì:_
 
```json
{
    "_id": "restore-tuesday",
    "source": "${url}/backup-tuesday",
    "target": "${url}/restore",
    "create_target": true  
}
```
{: codeblock}

_Completa il recupero ripristinando il backup di lunedì utilizzando HTTP:_

```http
PUT /_replicator/restore-monday HTTP/1.1
Content-Type: application/json
```
{: codeblock}

_Completa il recupero ripristinando il backup di lunedì utilizzando la riga di comando:_

```http
curl -X PUT "${url}/_replicator/restore-monday" -H "$ct" -d @restore-monday.json
```
{: pre}

_Documento JSON che richiede il ripristino del backup di lunedì:_
 
```json
{
    "_id": "restore-monday",
    "source": "${url}/backup-monday",
    "target": "${url}/restore"
}
```
{: codeblock}

## Suggerimenti
{: #suggestions}

Mentre le informazioni precedenti descrivono il processo di backup di base,
ogni applicazione ha bisogno di propri requisiti e strategie per i backup.
I seguenti suggerimenti potrebbero essere utili.

### Pianificazione dei backup
{: #scheduling-backups}

I lavori di replica possono aumentare significativamente il carico su un cluster.
Se devi eseguire il backup di più database,
è meglio suddividere i lavori di replica in momenti diversi
o in un momento in cui il cluster è meno occupato.

#### Modifica della priorità IO di un backup
{: #changing-the-io-priority-of-a-backup}

Puoi modificare la priorità dei lavori di backup
cambiando il valore del campo `x-cloudant-io-priority` all'interno del documento di replica.

1.  Nei campi di origine e di destinazione, modifica l'oggetto `headers`.
2.  Nell'oggetto di intestazioni
    modifica il valore del campo `x-cloudant-io-priority` in `"low"`.

_Esempio di documento JSON che imposta la priorità IO:_

```json
{
    "source": {
        "url": "https://user:pass@example.com/db",
        "headers": {
            "x-cloudant-io-priority": "low"
        }
    },
    "target": {
        "url": "https://user:pass@example.net/db",
        "headers": {
            "x-cloudant-io-priority": "low"
        }
    }
}
```
{: codeblock}

### Backup dei documenti di progettazione
{: #backing-up-design-documents}

Se includi i documenti di progettazione nel tuo backup,
gli indici vengono creati sulla destinazione del backup.
Questa procedura rallenta il processo di backup e utilizza quantità inutili di spazio su disco.
Se non richiedi gli indici sul tuo sistema di backup,
utilizza una funzione di filtro con le tue repliche per filtrare i documenti di progettazione.
Puoi anche utilizzare questa funzione di filtro per escludere altri documenti non desiderati.

### Backup di più database
{: #backing-up-multiple-databases}

Se la tua applicazione utilizza un database per utente
o consente a ciascun utente di creare diversi database,
dovrai creare un lavoro di backup per ogni nuovo database.
Assicurati che i tuoi lavori di replica non inizino nello stesso momento.

## Ti serve aiuto?
{: #need-help-}

La replica e i backup possono essere complicati.
Se non sai come procedere,
consulta la [guida della replica](/docs/services/Cloudant?topic=cloudant-replication-guide#replication-guide)
o contatta il
[team di supporto {{site.data.keyword.cloudant_short_notm}} ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](mailto:support@cloudant.com){: new_window}.
