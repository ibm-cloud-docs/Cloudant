---

copyright:
  years: 2017
lastupdated: "2017-07-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-05-04 -->

# Novità in Cloudant

Rimani aggiornato con le modifiche e gli aggiornamenti di Cloudant.
{:shortdesc}

## Hardware dedicato

È disponibile una nuova [istanza del servizio dedicata](bluemix.html#dedicated-plan).

## Build 6233

- Introduce un nuovo programma di pianificazione della replica.
  In aggiunta ai vantaggi nelle prestazioni e ad ulteriori endpoint,
  il programma di pianificazione modifica il modo in cui lo stato della replica viene monitorato e riportato.
  In particolare,
  la registrazione degli aggiornamenti dello stato in un documento di replica non è più supportata.
  Per ulteriori informazioni su questa importante modifica,
  consulta i dettagli sul [programma di pianificazione della replica](../api/advanced_replication.html#the_replication_scheduler).
  Contatta il supporto Cloudant aprendo un ticket utilizzando il tuo dashboard Cloudant se hai domande o preoccupazioni.

## Build 6069

- In precedenza, un lavoro di replica che si arrestava in modo anomalo per alcuni motivi provocava un aggiornamento del documento di replica,
  seguito da un nuovo tentativo di avviare una nuova replica.
  In alcune circostanze,
  questo comportamento potrebbe continuare all'infinito: molti duplicati dello stesso messaggio di errore.
  È stata introdotta una correzione in modo che il documento di replica non venga aggiornato a meno che il motivo per l'errore non cambi.
- Se il documento di progettazione considerato per specificare un indice geospaziale non è valido,
  un tentativo di richiamare le informazioni sull'indice utilizzando l'endpoint
  [`_geo_info` ](../api/cloudant-geo.html#obtaining-information-about-a-cloudant-geo-index)
  causa una risposta [HTTP `404`](http.html#404).
- Aggiunto supporto per l'operatore [`$allmatch`](../api/cloudant_query.html#the-allmatch-operator).

## Build 5834

- La lunghezza massima di un'`id` del documento è ora 7168 caratteri (7k).

## Build 5728

- Cloudant è più tollerante con i documenti utente non correttamente formati archiviati nel database `_users`.
  I documenti utente dovrebbero essere strutturati e popolati per rispettare i
  [Apache Software Foundation CouchDB requirements
![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://docs.couchdb.org/en/2.0.0/intro/security.html#users-documents){:new_window}.

## Build 5638

-   Introduce nuovi parametri di query "stabili" e "aggiornati" per le viste.
-   Il replicatore non effettua tentativi infiniti se non può scrivere i punti di controllo nel database di origine.

## Build 5421

-	Modifiche ai feed che supportano i filtri basati sulla vista.
-	Modifiche ai feed che supportano il filtro `_doc_ids`.
-	Le richieste `POST` sono supportate per `_changes`.
-	`_all_docs` e `_changes` supportano il parametro `attachments=true`.
-	Supporto per le funzioni del database CouchDB 1.6 `_users`, incluso l'hashing delle password lato server quando i documenti sono creati nel database `_users`.
-	Endpoint `/_bulk_get` per ridurre il numero di richieste utilizzate nella replica dei client mobili.
-	I metadati del documento di progettazione contengono un campo `update pending`.
-	La query Cloudant non restituisce più un errore se non esiste un indice valido.

### Modifiche interruzione/comportamento

Attività attive

-   Le voci di indicizzazione nella risposta `_active_tasks` non riportano più il campo `user`.
-   La ricerca delle voci di indicizzazione nella risposta `_active_tasks` non riportano più il campo `user`.

Viste

-   La normalizzazione Unicode dei valori chiave è coerente tra i risultati della vista ridotti e non ridotti. Se l'ordinamento non elaborato viene specificato in un documento di progettazione, l'ordine dei risultati potrebbe venire modificato dal risultato di questa correzione.
-   Quando esegui la query di una vista o di un database `_all_docs`, è presente un errore quando si specifica il parametro `keys` e i parametri `key`, `startkey` e `endkey`.
-   È presente un errore nel passare i parametri `startkey` e `endkey` a una vista se non esiste alcuna corrispondenza della riga. Ad esempio, il parametro `startkey` è superiore al parametro `endkey` per `descending=false` o quando il parametro `startkey` è inferiore al parametro `endkey` per `descending=true`, Cloudant restituisce l'errore `400 Bad Request`.
-   Quando `dbcopy` è configurato in un documento di visualizzazione, viene automaticamente trasformato nel campo `options` in un documento di progettazione. 

Documenti di progettazione

-   Convalida più severa dei documenti di progettazione. Questa convalida non dovrebbe creare dei problemi quando si esce dai documenti di progettazione, ma quelli non formati correttamente non possono venire salvati.
-   Le viste che sono scritte in un linguaggio non supportato rispondono tutte con un `errore` di `unknown_query_language`. In precedenza, la risposta era un `reason` di `unknown_query_language`.
-   Quando viene utilizzato un riduttore null per inserire un documento di progettazione del database, il sistema risponde con un motivo di errore di `'(null)'`, precedentemente veniva restituito `((new String("null")))`.
-   Se viene specificato `updates` in un documento di progettazione, non deve avere un valore null.

Autenticazione

-   I metadati `_session` e `authentication_handlers` non contengono più `["delegated", "local"]`.

Documenti utente

-   Convalida la struttura dei documenti utente creati nel database `_users`. Dopo l'aggiornamento DBNext, i documenti utente devono rispettare i requisiti ASF CouchdDB. In precedenza, Cloudant non convalidava la struttura dei documenti utente. 

Replica 

-   I documenti replicati conservano l'ultimo messaggio di errore nel campo JSON `_replication_state_reason`. Il campo rimane anche se viene riavviata la replica ed è nello stato `triggered`. Questa modifica aiuta il codice di replica a individuare ed evitare la scrittura dello stesso errore nel documento ripetutamente.
-   Un errore durante la replica non aggiorna il documento replicato a meno che venga modificato il motivo dell'errore. In precedenza, quando si verificava un errore durante la replica, si avviava un loop infinito che generava partizioni dimensionabili.  

Serie di risultati

-   L'endpoint `_db_updates` restituisce una serie di risultati che contiene una chiave denominata `db_name`. In precedenza, veniva restituita una serie di risultati con una chiave denominata `dbname`.
-   Configura la lunghezza massima dell'ID del documento. In precedenza, non era possibile definire una lunghezza dell'ID del documento massima.

`dbcopy`

- La funzione `dbcopy` può creare dei problemi in alcune circostanze.
  Le informazioni sulla funzione sono state rimosse dalla documentazione.
  L'utilizzo di `dbcopy` è fortemente sconsigliato.
