---

copyright:
  years: 2015, 2019
lastupdated: "2019-03-15"

keywords: find conflicts, resolve conflicts, merge changes, upload new revision, delete revision

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

<!-- Acrolinx: 2018-05-07 -->

# Conflitti
{: #conflicts}

Nei database distribuiti,
in cui le copie dei dati potrebbero essere archiviate in più di una posizione,
le caratteristiche naturali della rete e del sistema potrebbero indicare che le modifiche apportate
a un documento memorizzato in una posizione non possono essere immediatamente aggiornate o replicate in altre parti del database.

In altre parole,
se vengono effettuati aggiornamenti indipendenti su diverse copie di documenti,
l'effetto potrebbe essere quello di introdurre disaccordo o "conflitti" su quale sia il
contenuto corretto e definitivo per il documento.

{{site.data.keyword.cloudantfull}} cerca di aiutarti ad evitare i conflitti avvertendoti di potenziali problemi.
Ti avvisa restituendo una [risposta `409`](/docs/services/Cloudant?topic=cloudant-http#http-status-codes) a una richiesta di aggiornamento problematica.
Tuttavia,
una risposta `409` potrebbe non essere ricevuta se l'aggiornamento del database è
richiesto su un sistema che non è attualmente connesso alla rete.
Ad esempio,
il database potrebbe essere su un dispositivo mobile che è temporaneamente disconnesso
da Internet,
rendendo impossibile in quel momento verificare se sono stati effettuati altri
aggiornamenti potenzialmente in conflitto.

Se richiedi un documento che si trova in una situazione di conflitto,
{{site.data.keyword.cloudant_short_notm}} restituisce il documento come previsto.
Tuttavia,
la versione restituita è determinata da un algoritmo interno che considera
una serie di fattori;
ad esempio, non devi presumere che il documento restituito sia sempre la versione
più recente.

Se non controlli i conflitti o
non riesci a risolverli,
il tuo database {{site.data.keyword.cloudant_short_notm}} inizia a mostrare diversi comportamenti:

* Aumento delle incoerenze nel contenuto del documento, perché ci sono sempre più documenti in conflitto.
* Aumento delle dimensioni del database, perché tutti i documenti in conflitto devono essere conservati fino alla risoluzione del conflitto.
* Diminuzione delle prestazioni, perché {{site.data.keyword.cloudant_short_notm}} deve lavorare di più in risposta a ogni singola richiesta mentre cerca di identificare la versione "migliore possibile" di un documento in conflitto.

Le seguenti procedure consigliate potrebbero aiutarti a decidere quando controllare
e risolvere i
conflitti:

<table>
<tr>
<th>Caratteristica dell'applicazione</th>
<th>Frequenza di aggiornamento del documento</th>
<th>Controllo dei conflitti durante il recupero</th>
<th>Controllo dei conflitti durante l'aggiornamento</th>
</tr>
<tr>
<td>Sempre connesso alla rete, ad esempio un server.</td>
<td>Spesso</td>
<td>S</td>
<td>-</td>
</tr>
<tr>
<td>Sempre connesso alla rete.</td>
<td>Occasionalmente</td>
<td>-</td>
<td>S</td>
</tr>
<tr>
<td>Spesso ma non sempre connesso alla rete, ad esempio un laptop.</td>
<td>Spesso</td>
<td>-</td>
<td>S</td>
</tr>
<tr>
<td>Spesso ma non sempre connesso alla rete.</td>
<td>Occasionalmente</td>
<td>-</td>
<td>S</td>
</tr>
<tr>
<td>Occasionalmente connesso alla rete, ad esempio un tablet.</td>
<td>Spesso</td>
<td>-</td>
<td>S</td>
</tr>
</table>

## Ricerca di conflitti
{: #finding-conflicts}

Per trovare eventuali conflitti che potrebbero influenzare un documento,
aggiungi il parametro di query `conflicts=true` durante il recupero di un documento.
Quando viene restituito,
il documento risultante contiene un array `_conflicts`
che include un elenco di tutte le revisioni in conflitto.

> Funzione di mappa di esempio per trovare conflitti del documento:

```
function (doc) {
  if (doc._conflicts) {
    emit(null, [doc._rev].concat(doc._conflicts));
    }
}
```

Per trovare conflitti per più documenti in un database,
scrivi una [vista](/docs/services/Cloudant?topic=cloudant-views-mapreduce#views-mapreduce).
Utilizzando una funzione di mappa come nell'esempio fornito,
puoi trovare tutte le revisioni per ogni documento con un conflitto.

Quando hai tale vista,
puoi usarla per trovare e risolvere i conflitti secondo necessità.
In alternativa,
puoi eseguire una query nella vista dopo ogni replica per identificare e risolvere immediatamente i conflitti.

## Come risolvere i conflitti
{: #how-to-resolve-conflicts}

Una volta che hai trovato un conflitto, puoi risolverlo seguendo 4 passi:

1.	[Ottieni](#get-conflicting-revisions) le revisioni in conflitto.
2.	[Unisci](#merge-the-changes) le revisioni nella tua applicazione o chiedi all'utente cosa vuole fare.
3.	[Carica](#upload-the-new-revision) la nuova revisione.
4.	[Elimina](#delete-old-revisions) le vecchie revisioni.

> Documento di esempio: la prima versione.

```json
{
  "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "1-7438df87b632b312c53a08361a7c3299",
    "name": "Samsung Galaxy S4",
    "description": "",
    "price": 650
}
```

Facciamo un esempio di come effettuare queste operazioni.
Supponi di avere un database di prodotti per un negozio online.
La prima versione di un documento potrebbe essere simile all'esempio fornito.

> Seconda versione (prima revisione) del documento, che aggiunge una descrizione.

```json
{
  "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "2-61ae00e029d4f5edd2981841243ded13",
    "name": "Samsung Galaxy S4",
    "description": "Latest smartphone from Samsung",
    "price": 650
}
```

Il documento non ha ancora una descrizione,
pertanto qualcuno potrebbe aggiungerne una.

> Seconda versione _alternativa_, che introduce una modifica dei dati di riduzione del prezzo alla prima versione del documento.

```json
{
  "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "2-f796915a291b37254f6df8f6f3389121",
    "name": "Samsung Galaxy S4",
    "description": "",
    "price": 600
}
```

Allo stesso tempo, qualcun altro - lavorando con un database replicato - riduce il prezzo.
Questa modifica viene apportata alla prima versione del documento.
Pertanto,
la modifica della riduzione del prezzo non "sa nulla" circa la modifica della descrizione.

Successivamente,
quando i due database vengono replicati,
potrebbe non essere chiaro quale delle due versioni alternative del documento sia corretta.
Questo è uno scenario di conflitto.

## Ottieni le revisioni in conflitto
{: #get-conflicting-revisions}

Per trovare eventuali revisioni in conflitto per un documento
recupera tale documento come al solito,
ma includi il parametro `conflicts=true`
come nel seguente esempio:

`http://ACCOUNT.cloudant.com/products/$_ID?conflicts=true`


> Risposta di esempio al recupero del documento, che mostra revisioni in conflitto

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

Se il documento presenta dei conflitti,
potresti ottenere una risposta simile all'esempio fornito,
che si basa sul problema della descrizione modificata o del prezzo modificato.

La versione con il prezzo modificato è stata scelta _arbitrariamente_ come ultima versione del documento.
Non devi presumere che l'ultima versione aggiornata del documento sia considerata la versione più recente ai fini della risoluzione dei conflitti.

In questo esempio,
viene considerato un conflitto tra il documento recuperato che ha il valore `_rev` `2-f796915a291b37254f6df8f6f3389121`
e un altro documento che ha il valore `_rev` `2-61ae00e029d4f5edd2981841243ded13`.
I dettagli del documento in conflitto sono indicati nell'array `_conflicts`.

Spesso,
potresti notare che l'array ha un solo elemento,
ma è possibile che ci siano molte revisioni in conflitto,
ognuna delle quali è elencata nell'array.

## Unisci le modifiche
{: #merge-the-changes}

La tua applicazione deve identificare tutte le potenziali modifiche
e riconciliarle,
unendo in modo efficace gli aggiornamenti corretti e validi per produrre una
versione singola e non in conflitto del documento.

Per confrontare le revisioni e identificare cosa è stato modificato,
la tua applicazione deve recuperare tutte le versioni dal database.
Come descritto in precedenza,
iniziamo recuperando un documento e i dettagli di eventuali versioni in conflitto.
Per farlo, utilizziamo un comando simile al seguente,
che richiede anche l'array `_conflicts`:

`http://$ACCOUNT.cloudant.com/products/$_ID?conflicts=true
`

Questo recupero ci fornisce una versione corrente del documento che memorizziamo
_e _ un elenco di tutti gli altri documenti in conflitto che devono essere recuperati,
ad esempio `...rev=2-61ae00e029d4f5edd2981841243ded13` e `...rev=1-7438df87b632b312c53a08361a7c3299`.
Ognuna di queste altre versioni in conflitto viene anche recuperata e memorizzata,
ad esempio:

  `http://$ACCOUNT.cloudant.com/products/$_ID?rev=2-61ae00e029d4f5edd2981841243ded13`
  `http://$ACCOUNT.cloudant.com/products/$_ID?rev=1-7438df87b632b312c53a08361a7c3299`

Una volta disponibili tutte le revisioni in conflitto di un documento,
puoi procedere alla risoluzione dei conflitti.

Nel nostro scenario precedente,
le differenze tra le versioni del documento riguardavano campi diversi all'interno del documento,
rendendo più facile unirle.

È probabile che i conflitti più complicati richiedano di conseguenza più analisi.
Per aiutare,
potresti scegliere tra una varietà di diverse strategie di risoluzione dei conflitti,
come ad esempio:

*	In base al tempo: utilizzando un semplice test della prima modifica o di quella più recente.
*	Valutazione degli utenti: i conflitti vengono segnalati agli utenti, che decidono in merito alla migliore risoluzione.
*	Algoritmi di unione sofisticati: questi sono spesso utilizzati nei [sistemi di controllo delle versioni](https://en.wikipedia.org/wiki/Merge_%28version_control%29). Un esempio è l'[unione a tre fasi](https://en.wikipedia.org/wiki/Merge_%28version_control%29#Three-way_merge).

Per un esempio pratico di come implementare queste modifiche, vedi [questo progetto con il codice di esempio](https://github.com/glynnbird/deconflict).

## Carica la nuova revisione
{: #upload-the-new-revision}

> Revisione finale, dopo aver risolto e unito le modifiche delle precedenti revisioni in conflitto.

```json
{
  "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "3-daaecd7213301a1ad5493186d6916755",
    "name": "Samsung Galaxy S4",
    "description": "Latest smartphone from Samsung",
    "price": 600
}
```

Dopo aver valutato e risolto i conflitti,
creerai un documento contenente i dati correnti e definitivi.
Questo nuovo documento viene caricato nel database.

## Elimina le vecchie revisioni
{: #delete-old-revisions}

> Richieste di esempio per eliminare le vecchie revisioni.

```http
DELETE http://$ACCOUNT.cloudant.com/products/$_ID?rev=2-61ae00e029d4f5edd2981841243ded13

DELETE http://$ACCOUNT.cloudant.com/products/$_ID?rev=2-f796915a291b37254f6df8f6f3389121
```

Il passo finale è quello di eliminare le vecchie revisioni.
Per farlo, invia una richiesta `DELETE`
specificando le revisioni da eliminare.

Quando le versioni precedenti di un documento vengono eliminate,
i conflitti associati a quel documento vengono contrassegnati come risolti.
Puoi verificare che non rimangano conflitti richiedendo nuovamente il documento,
con il parametro `conflicts` impostato su true, utilizza la
[ricerca dei conflitti](#finding-conflicts) come in precedenza.
