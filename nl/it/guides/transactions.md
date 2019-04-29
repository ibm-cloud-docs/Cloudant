---

copyright:
  years: 2015, 2019
lastupdated: "2019-03-15"

keywords: generate uuid, record payments, add additional documents, advantages

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

# Raggruppamento di documenti correlati in {{site.data.keyword.cloudant_short_notm}}
{: grouping-related-documents-together-in-ibm-cloudant}

Tradizionalmente,
i sistemi di e-commerce vengono creati con i database relazionali.
Questi database utilizzano di solito un certo numero di tabelle unite insieme per registrare le vendite,
i dettagli dei clienti,
i prodotti acquistati
e informazioni sul monitoraggio delle consegne.
I database relazionali offrono un elevata consistenza,
il che significa che gli sviluppatori possono creare le proprie applicazioni sui punti di forza di un database,
incluso l'utilizzo di unioni tra le raccolte,
le enumerazioni per registrare lo stato di un oggetto
le transazioni del database per garantire operazioni atomiche.

{{site.data.keyword.cloudantfull}} favorisce la disponibilità oltre alla consistenza.
È un database ad alta disponibilità,
tollerante agli errori
e distribuito con consistenza eventuale.
Questo offre il vantaggio che il servizio di acquisto del cliente è sempre disponibile e abbastanza
scalabile per far fronte a più utenti che effettuano acquisti nello stesso tempo.
Ciò significa che l'applicazione può utilizzare i punti di forza di {{site.data.keyword.cloudant_short_notm}} e non trattarlo come un database relazionale.

La discussione in questo argomento delinea alcuni dei fattori
coinvolti nella creazione di un sistema di e-commerce che sfrutta i punti di forza di {{site.data.keyword.cloudant_short_notm}}
utilizzando concetti applicabili a molti altri domini,
ad esempio:

-   Utilizzo di più documenti per rappresentare lo stato di un acquisto,
    invece di aggiornare frequentemente un singolo documento.
-   Memorizzazione delle copie di oggetti correlati in ordine anziché l'unione a un'altra raccolta.
-   Creazione di viste per il confronto dei documenti con `order_id` per riflettere lo stato attuale di un acquisto.

Ad esempio,
potresti creare un documento `purchase` che contiene dettagli come gli articoli ordinati,
le informazioni sul cliente,
i costi
e le informazioni sulla consegna.

_Documento di esempio che descrive un acquisto:_

```json
{
    "_id": "023f7a21dbe8a4177a2816e4ad1ea27e",
    "type": "purchase",
    "order_id": "320afa89017426b994162ab004ce3383",
    "basket": [
        {
            "product_id": "A56",
            "title": "Adele - 25",
            "category": "Audio CD",
            "price": 8.33,
            "tax": 0.2,
            "quantity": 2
        },
        {
            "product_id": "B32",
            "title": "The Lady In The Van - Alan Bennett",
            "category": "Paperback book",
            "price": 3.49,
            "tax": 0,
            "quantity": 2
        }
    ],
    "account_id": "985522332",
    "delivery": {
        "option": "Next Day",
        "price": 2.99,
        "address": {
            "street": "17 Front Street",
            "town": "Middlemarch",
            "postcode": "W1A 1AA"
        }
    },
    "pretax" : 20.15,
    "tax" : 3.32,
    "total": 26.46
}
```
{: codeblock}

Questo documento fornisce dati sufficienti affinché un record di acquisto rappresenti un riepilogo di un ordine su una pagina web,
o una e-mail,
senza recuperare ulteriori record.
Nota i dettagli chiave dell'ordine,
in particolare:

-   Il carrello contiene ID di riferimento (`product_id`) per un database di prodotti memorizzati altrove.
-   Il carrello duplica alcuni dei dati del prodotto in questo record,
    sufficienti per registrare lo stato degli articoli acquistati nel punto vendita.
-   Il documento non contiene campi che contrassegnano lo stato dell'ordine.
    Ulteriori documenti saranno aggiunti successivamente per registrare i pagamenti e la consegna.
-   Il database genera automaticamente un documento `_id` quando inserisce il documento nel database.
-   Viene fornito un identificativo univoco (`order_id`) con ogni record di acquisto per fare riferimento all'ordine successivo. 
 
Quando il cliente effettua un ordine,
generalmente nel momento in cui passa alla fase di "checkout" sul sito web,
viene creato un record di ordine di acquisto simile all'esempio precedente. 

## Generazione dei tuoi identificativi univoci (UUID)
{: #generating-your-own-unique-identifiers-uuids-}

In un database relazionale,
spesso vengono utilizzati i numeri sequenziali con "incremento automatico",
ma nei database distribuiti,
dove i dati vengono estesi al cluster di server,
vengono utilizzati UUID più lunghi per garantire che i documenti vengano memorizzati con il proprio ID univoco.

Per creare un identificativo univoco da utilizzare nella tua applicazione,
ad esempio un `order_id`,
richiama l'[endpoint `GET _uuids`](/docs/services/Cloudant?topic=cloudant-advanced-api#-get-_uuids-) sull'API {{site.data.keyword.cloudant_short_notm}}.
Il database genera un identificativo per te.
È possibile utilizzare lo stesso endpoint per generare più ID aggiungendo un parametro `count`,
ad esempio, `/_uuids?count=10`.

## Registrazione dei pagamenti
{: #recording-payments}

Quando il cliente paga correttamente i propri articoli
al database vengono aggiunti ulteriori record per registrare l'ordine.

_Esempio di record di pagamento:_

```json
{
    "_id": "bf70c30ea5d8c3cd088fef98ad678e9e",
    "type": "payment",
    "account_id": "985522332",
    "order_id": "320afa89017426b994162ab004ce3383",
    "value": 6.46,
    "method": "credit card",
    "payment_reference": "AB9977G244FF2F667"
}
...
{
    "_id": "12c0ea6cd3d2c6e3b1d34442aea6a2d9",
    "type": "payment",
    "account_id": "985522332",
    "order_id": "320afa89017426b994162ab004ce3383",
    "value": 20.00,
    "method": "voucher",
    "payment_reference": "Q88775662377224"
}
```
{: codeblock}

Nell'esempio precedente,
il cliente ha pagato fornendo una carta di credito e riscattando un buono prepagato.
Il totale dei due pagamenti è stato aggiunto all'importo dell'ordine.
Ogni pagamento è stato scritto in {{site.data.keyword.cloudant_short_notm}} come documento separato.

Potresti vedere lo stato di un ordine creando una vista di tutto ciò che sai in merito a un `order_id`.
La vista abiliterà un registro contenente le seguenti informazioni: 

-   I totali degli acquisti come numeri positivi.
-   Pagamenti a fronte dell'account come numeri negativi.

È possibile utilizzare una funzione di mappa per identificare i valori richiesti.

_Funzione di mappa di esempio per trovare i valori del totale di acquisto e di pagamento:_ 

```javascript
function (doc) {
    if (doc.type === 'purchase') {
        emit(doc.order_id, doc.total);
    } else {
        if (doc.type === 'payment') {
            emit(doc.order_id, -doc.value);
        }
    }
}
```
{: codeblock}

L'utilizzo del [riduttore `_sum`](/docs/services/Cloudant?topic=cloudant-views-mapreduce#built-in-reduce-functions) integrato
ti consente di produrre l'output in forma di registro degli eventi di pagamento.

_Esempio di utilizzo del riduttore `_sum` integrato, con la query `?reduce=false`:_

```json
{
    "total_rows":3,"offset":0,"rows":[
        {
            "id":"320afa89017426b994162ab004ce3383",
            "key":"985522332",
            "value":26.46
        },
        {
            "id":"320afa89017426b994162ab004ce3383",
            "key":"985522332",
            "value":-20
        },
        {
            "id":"320afa89017426b994162ab004ce3383",
            "key":"985522332",
            "value":-6.46
        }
    ]
}
```
{: codeblock}

In alternativa,
puoi produrre i totali raggruppati per `order_id`.

_Esempio di totali raggruppati per `order_id`, con `?group_level=1`:_

```json
{
    "rows":[
        {
            "key":"320afa89017426b994162ab004ce3383",
            "value":0
        }
    ]
}
```
{: codeblock}

Poiché la vista nell'esempio precedente restituisce 0 per il valore dell'ordine,
il risultato indica che l'ordine è interamente pagato.
Il motivo è che il totale positivo dell'ordine di acquisto annulla gli importi di pagamento negativi.
La registrazione di eventi come documenti separati,
ossia uno per l'ordine e uno per ogni pagamento,
è una buona procedura in {{site.data.keyword.cloudant_short_notm}},
in quanto evita la possibilità di creare conflitti quando più processi modificano contemporaneamente lo stesso documento.

## Aggiunta di altri documenti
{: #adding-additional-documents}

Puoi aggiungere altri
documenti separati al database per registrare le seguenti modifiche dello stato quando l'ordine viene fornito e spedito:

-   Notifiche di spedizione.
-   Ricevute di consegna.
-   Record di rimborso.

All'arrivo dei dati,
{{site.data.keyword.cloudant_short_notm}} scrive separatamente su ciascun documento.
Pertanto,
non è necessario modificare il documento di acquisto principale.

## Vantaggi di memorizzare gli ordini di acquisto in {{site.data.keyword.cloudant_short_notm}}
{: #advantages-of-storing-purchase-orders-in-ibm-cloudant}

L'utilizzo di {{site.data.keyword.cloudant_short_notm}} per memorizzare le informazioni sugli ordini di acquisto consente a un sistema di gestione degli ordini di essere altamente disponibile e scalabile,
il che ti permette di gestire grandi volumi di dati ed elevati livelli di accesso simultaneo.
Modellando i dati in documenti separati che vengono scritti solo una volta,
possiamo garantire che i documenti non vadano mai in conflitto,
ad esempio durante l'accesso simultaneo allo stesso documento da parte di processi separati.

Inoltre,
i documenti possono contenere copie di dati esistenti in altre raccolte
per rappresentare l'unione di dati, piuttosto che basarsi su di essa, con una chiave esterna.
Ad esempio,
quando si registra lo stato di un carrello al momento dell'acquisto.
Ciò consente di recuperare lo stato di un ordine mediante una singola chiamata
a una vista di {{site.data.keyword.cloudant_short_notm}} che raggruppa i documenti correlati da `order_id`.
