---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: revisions, distributed databases, conflicts, resolve conflicts, find conflicting revisions, merge changes, upload new revisions, delete old revisions

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

# Controllo della versione del documento e MVCC
{: #document-versioning-and-mvcc}

Il [Controllo della concorrenza multiversione (in inglese: Multiversion concurrency control o MVCC) ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://en.wikipedia.org/wiki/Multiversion_concurrency_control){: new_window}
è un metodo usato dai database {{site.data.keyword.cloudantfull}} per garantire che tutti i nodi in un cluster del database contengano solo
la [versione più recente](/docs/services/Cloudant?topic=cloudant-documents#documents) di un documento.
{: shortdesc}

Poiché i database {{site.data.keyword.cloudant_short_notm}} hanno una [consistenza eventuale](/docs/services/Cloudant?topic=cloudant-cap-theorem#cap-theorem),
questo è necessario per evitare inconsistenze che si verificano tra i nodi
in seguito alla sincronizzazione tra documenti obsoleti.

Il controllo della concorrenza multiversione (MVCC, Multi-Version Concurrency Control) consente l'accesso simultaneo in lettura e scrittura a un database {{site.data.keyword.cloudant_short_notm}}.
MVCC è una forma di [concorrenza ottimistica![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://en.wikipedia.org/wiki/Optimistic_concurrency_control){: new_window}.
Rende più veloci le operazioni di lettura e scrittura nei database {{site.data.keyword.cloudant_short_notm}}
perché non è necessario bloccare il database in operazioni di lettura o scrittura.
MVCC abilita inoltre la sincronizzazione tra i nodi di database {{site.data.keyword.cloudant_short_notm}}.

## Revisioni
{: #revisions}

Ogni documento in un database {{site.data.keyword.cloudant_short_notm}} ha un campo `_rev` che indica il suo numero di revisione.

Quando inserisci o modifichi i documenti, il server aggiunge a questi un numero di revisione.
Il numero viene incluso nella risposta del server quando apporti modifiche o leggi un documento.
Il valore `_rev` viene costruito utilizzando una combinazione di un semplice contatore e di un hash del documento.

I due utilizzi principali del numero di revisione sono:

1.  Determinare i documenti da replicare tra i server.
2.  Confermare che un client sta tentando di modificare la versione più recente di un documento.

Devi specificare il valore `_rev` precedente durante l'[aggiornamento di un documento](/docs/services/Cloudant?topic=cloudant-documents#update)
altrimenti la tua richiesta non riesce e restituisce un [errore 409](/docs/services/Cloudant?topic=cloudant-http#http-status-codes).

`_rev` non deve essere utilizzato per creare un sistema di controllo della versione. Il motivo è che questo è un valore interno utilizzato dal server. Inoltre,
    le revisioni più vecchie di un documento sono temporanee
    e quindi vengono rimosse regolarmente.
{: note}

Puoi eseguire una query di una particolare revisione utilizzando il suo `_rev`,
tuttavia,
le revisioni più vecchie vengono eliminate regolarmente da un processo chiamato
[compressione ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://en.wikipedia.org/wiki/Data_compaction){: new_window}.
Una conseguenza della compressione è che non puoi
fare affidamento su una risposta positiva quando esegui la query di una particolare revisione del documento
utilizzando il suo `_rev` per ottenere una cronologia di revisioni del tuo documento.
Se hai bisogno di una cronologia delle versione dei tuoi documenti,
una soluzione è quella di [creare un nuovo documento](/docs/services/Cloudant?topic=cloudant-documents#create-document) per ogni revisione.

## Database distribuiti e conflitti
{: #distributed-databases-and-conflicts}

I database distribuiti funzionano senza una connessione costante al database principale su {{site.data.keyword.cloudant_short_notm}},
che è a sua volta distribuito,
pertanto gli aggiornamenti basati sulla stessa versione precedente possono ancora essere in conflitto.

Per trovare i conflitti,
aggiungi il parametro della query [`conflicts=true`](/docs/services/Cloudant?topic=cloudant-databases#get-changes) durante il recupero di un documento.
La risposta contiene un array `_conflicts` con tutte le revisioni in conflitto.

Per trovare conflitti per più documenti in un database,
scrivi una vista.

La seguente funzione di mappa è un esempio che emette tutte le revisioni in conflitto per ogni documento che ha un conflitto.

_Esempio di una funzione di mappa per trovare i documenti con un conflitto:_

```javascript
function (doc) {
    if (doc._conflicts) {
        emit(null, [doc._rev].concat(doc._conflicts));
    }
}
```
{: codeblock}

Potresti eseguire regolarmente una query di questa vista e risolvere gli eventuali conflitti
o eseguire una query della vista dopo ogni replica.

## Passi per risolvere i conflitti
{: #steps-to-resolve-conflicts}

Una volta che hai trovato un conflitto,
puoi risolverlo in 4 passi.

1.  [Ottieni](#get-conflicting-revisions) le revisioni in conflitto.
2.  [Uniscile](#merge-the-changes) nella tua applicazione o chiedi all'utente cosa vuole fare.
3.  [Carica](#upload-the-new-revision) la nuova revisione.
4.  [Elimina](#delete-old-revisions) le vecchie revisioni.

Facciamo un esempio di come effettuare queste operazioni.
Supponi di avere un database di prodotti per un negozio online.
La prima versione di un documento potrebbe essere simile al seguente esempio:

```json
{
    "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "1-7438df87b632b312c53a08361a7c3299",
    "name": "Samsung Galaxy S4",
    "description": "",
    "price": 650
}
```
{: codeblock}

Poiché il documento non ha ancora una descrizione,
qualcuno potrebbe aggiungerne una:

_Seconda versione del documento, creata aggiungendo una descrizione:_

```json
{
    "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "2-61ae00e029d4f5edd2981841243ded13",
    "name": "Samsung Galaxy S4",
    "description": "Latest smartphone from Samsung",
    "price": 650
}
```
{: codeblock}

Allo stesso tempo, qualcun altro - che lavora con un database replicato - riduce il prezzo:

_Una revisione diversa, in conflitto con quella precedente, a causa di un valore `price` differente:_

```json
{
    "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "2-f796915a291b37254f6df8f6f3389121",
    "name": "Samsung Galaxy S4",
    "description": "",
    "price": 600
}
```
{: codeblock}

I due database vengono poi replicati.
La differenza nelle versioni del documento provoca un conflitto.

### Ottieni le revisioni in conflitto
{: #get-conflicting-revisions}

Puoi identificare i documenti con i conflitti utilizzando l'opzione `conflicts=true`.

_Esempio di ricerca di documenti con conflitti:_

```http
http://$ACCOUNT.cloudant.com/products/$_ID?conflicts=true
```
{: codeblock}

_Risposta di esempio che mostra le revisioni in conflitto che interessano i documenti:_

```json
{
    "_id":"74b2be56045bed0c8c9d24b939000dbe",
    "_rev":"2-f796915a291b37254f6df8f6f3389121",
    "name":"Samsung Galaxy S4",
    "description":"",
    "price":600,
    "_conflicts":["2-61ae00e029d4f5edd2981841243ded13"]
}
```
{: codeblock}

La versione con il prezzo modificato è stata scelta arbitrariamente poiché
l'ultima versione del documento e il conflitto con un'altra versione viene notato fornendo l'ID di tale altra versione nell'array `_conflicts`.
Nella maggior parte dei casi questo array ha solo un elemento,
ma potrebbero esserci molte revisioni in conflitto.

### Unisci le modifiche
{: #merge-the-changes}

Per confrontare le revisioni per vedere cosa è stato modificato,
la tua applicazione riceve tutte le versioni dal database.

_Comandi di esempio per recuperare tutte le versioni di un documento dal database:_

```http
http://$ACCOUNT.cloudant.com/products/$_ID
http://$ACCOUNT.cloudant.com/products/$_ID?rev=2-61ae00e029d4f5edd2981841243ded13
http://$ACCOUNT.cloudant.com/products/$_ID?rev=1-7438df87b632b312c53a08361a7c3299
```
{: codeblock}

Poiché le modifiche in conflitto riguardano i diversi campi del documento,
è facile unirle.

Per i conflitti più complessi,
potrebbero essere necessarie altre strategie di risoluzione:

*   In base al tempo: usa la prima o l'ultima modifica.
*   Intervento dell'utente: segnala i conflitti agli utenti e lasciali decidere sulla risoluzione migliore.
*   Algoritmi sofisticati: ad esempio, unioni a tre fasi dei campi di testo.

Per un esempio pratico su come implementare un'unione delle modifiche, vedi questo progetto con il
[codice di esempio ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/glynnbird/deconflict){: new_window}.

### Carica la nuova revisione
{: #upload-the-new-revision}

Il passo successivo è quello di creare un documento che risolva i conflitti
e di aggiornare il database con tale documento.

_Un documento di esempio che unisce le modifiche dalle due revisioni in conflitto:_

```json
{
    "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "3-daaecd7213301a1ad5493186d6916755",
    "name": "Samsung Galaxy S4",
    "description": "Latest smartphone from Samsung",
    "price": 600
}
```
{: codeblock}

### Elimina le vecchie revisioni
{: #delete-old-revisions}

Infine,
puoi eliminare le vecchie revisioni inviando una richiesta `DELETE` agli URL con la revisioni da eliminare.

_Richiesta di esempio per eliminare una vecchia revisione del documento, utilizzando HTTP:_

```http
DELETE https://$ACCOUNT.cloudant.com/products/$_ID?rev=2-61ae00e029d4f5edd2981841243ded13
```
{: codeblock}

_Richiesta di esempio per eliminare una vecchia revisione del documento, utilizzando la riga di comando:_

```sh
curl "https://$ACCOUNT.cloudant.com/products/$_ID?rev=2-f796915a291b37254f6df8f6f3389121" -X DELETE
```
{: codeblock}

A questo punto,
i conflitti che interessano il documento sono risolti.
Puoi verificarlo, ottenendo di nuovo il documento utilizzando `GET` con il parametro `conflicts` impostato su `true`.
