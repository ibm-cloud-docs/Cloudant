---

copyright:
  years: 2017
lastupdated: "2017-07-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-07-12 -->

# Modifiche interruzione e comportamento

Questo documento riepiloga le modifiche nel comportamento per le release Cloudant.
{:shortdesc}

## Incompatibilità tra CouchDB versione 1.6 e Cloudant versione 2.0.0

-   Esiste un'incompatibilità tra la versione più recente di Cloudant e il codice di base basato su CouchDB 1.6. Nella  
    vecchia versione di Cloudant, se aggiungi un parametro di query ("reduce=false") al corpo della richiesta, questo parametro
    viene ignorato mentre quello nell'URL della richiesta viene rispettato. Nelle versioni recenti di
    Cloudant, il parametro di query ("reduce=false") nel corpo della richiesta non viene ignorato.

## Messaggio di errore riveduto

- Il messaggio di errore che si verifica quando tenti di inserire un allegato del documento con una revisione non esistente è stato modificato in un errore 409 con le seguenti informazioni:

	```
	{"error":"not_found","reason":"missing_rev"}
	```

## X-Frame-Options

L'impostazione `X-Frame-Options` è un'intestazione della risposta che controlla se una risposta HTTP può essere integrata in `<frame>`, `<iframe>` o `<object>`. Questa funzione di sicurezza aiuta a prevenire il clickjacking.

Puoi configurare questa opzione in base alle tue impostazioni CORS. Se CORS è abilitato, `X-Frame-Options` viene automaticamente abilitata e inviata all'intestazione della risposta, `X-Frame-Options: DENY`, per impostazione predefinita. Se un'intestazione HOST della richiesta corrisponde all'URL elencato nella sezione delle origini di CORS, viene restituita un'intestazione della risposta `X-Frame-Options: ALLOW-FROM URL`.
 
Questa modifica potrebbe influire sui clienti che accedono al database direttamente dal browser. Se visualizzi un messaggio di errore, "X-Frame-Options: DENY"
e che sta interrompendo il tuo servizio, devi abilitare CORS,
[Impostazione della configurazione CORS](../api/cors.html#setting-the-cors-configuration). Dopo aver abilitato CORS,
aggiungi il valore dell'intestazione HOST che invii nella richiesta
per l'elenco delle `origini` consentite.

## Attività attive

-   Le voci di indicizzazione nella risposta `_active_tasks` non riportano più il campo `user`.
-   La ricerca delle voci di indicizzazione nella risposta `_active_tasks` non riportano più il campo `user`.

## Viste 

-   La normalizzazione Unicode dei valori chiave è coerente tra i risultati della vista ridotti e non ridotti. Se l'ordinamento non elaborato viene specificato in un documento di progettazione, l'ordine dei risultati potrebbe venire modificato dal risultato di questa correzione.
-   Quando esegui la query di una vista o di un database `_all_docs`, è presente un errore quando si specifica il parametro `keys` e i parametri `key`, `startkey` e `endkey`.
-   È presente un errore nel passare i parametri `startkey` e `endkey` a una vista se non esiste alcuna corrispondenza della riga. Ad esempio, il parametro `startkey` è superiore al parametro `endkey` per `descending=false` o quando il parametro `startkey` è inferiore al parametro `endkey` per `descending=true`, Cloudant restituisce l'errore `400 Bad Request`.
-   Quando `dbcopy` è configurato in un documento di visualizzazione, viene automaticamente trasformato nel campo `options` in un documento di progettazione. 

## Documenti di progettazione

-   Convalida più severa dei documenti di progettazione. Questa convalida non dovrebbe creare dei problemi quando si esce dai documenti di progettazione, ma quelli non formati correttamente non possono venire salvati.
-   Le viste che sono scritte in un linguaggio non supportato rispondono tutte con un `errore` di `unknown_query_language`. In precedenza, la risposta era un `reason` di `unknown_query_language`.
-   Quando viene utilizzato un riduttore null per inserire un documento di progettazione del database, il sistema risponde con un motivo di errore di `'(null)'`, precedentemente veniva restituito `((new String("null")))`.
-   Se viene specificato `updates` in un documento di progettazione, non deve avere un valore null.

## Autenticazione

-   I metadati `_session` e `authentication_handlers` non contengono più `["delegated", "local"]`.

## Documenti utente

-   Convalida la struttura dei documenti utente creati nel database `_users`. Dopo l'aggiornamento DBNext, i documenti utente devono rispettare i requisiti ASF CouchdDB. In precedenza, Cloudant non convalidava la struttura dei documenti utente. 

## Replica 

-   I documenti replicati conservano l'ultimo messaggio di errore nel campo JSON `_replication_state_reason`. Il campo rimane anche se viene riavviata la replica ed è nello stato `triggered`. Questa modifica aiuta il codice di replica a individuare ed evitare la scrittura dello stesso errore nel documento ripetutamente.
-   Un errore durante la replica non aggiorna il documento replicato a meno che venga modificato il motivo dell'errore. In precedenza, quando si verificava un errore durante la replica, si avviava un loop infinito che generava partizioni dimensionabili.  

## Serie di risultati

-   L'endpoint `_db_updates` restituisce una serie di risultati che contiene una chiave denominata `db_name`. In precedenza, veniva restituita una serie di risultati con una chiave denominata `dbname`.
-   Configura la lunghezza massima dell'ID del documento. In precedenza, non era possibile definire una lunghezza dell'ID del documento massima.

## `dbcopy`

- La funzione `dbcopy` può creare dei problemi in alcune circostanze.
  Le informazioni sulla funzione sono state rimosse dalla documentazione.
  L'utilizzo di `dbcopy` è fortemente sconsigliato.
