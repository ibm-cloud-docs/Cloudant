---

copyright:
  years: 2019
lastupdated: "2019-03-27"

keywords: database shards, non-partitioned databases, partition key, global query, partition query, create partition database, create partition query index

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

<!-- Acrolinx: 2018-08-17 -->

# Partizionamento del database
{: #database-partitioning}

La funzione di database partizionato di {{site.data.keyword.cloudant_short_notm}} è attualmente in modalità beta. Il partizionamento dei database non deve essere usato per l'utilizzo dell'applicazione nella produzione. Questa funzione è in fase di distribuzione in tutti gli ambienti {{site.data.keyword.cloudant_short_notm}} e sarà ampiamente disponibile nelle prossime settimane.
{: important}

{{site.data.keyword.cloudantfull}} supporta due tipi di database:

- Partizionato
- Non partizionato

Un database _partizionato_ offre prestazioni significative e vantaggi in termini di costi ma ti
richiede di specificare un partizionamento logico dei tuoi dati. Questo argomento viene descritto
più avanti.

In alternativa, puoi creare un database _non partizionato_. Questo tipo di database può risultare
più semplice da utilizzare perché non devi definire schemi di partizionamento, ma puoi creare solo indici globali secondari. 

{{site.data.keyword.cloudant_short_notm}} ti consiglia vivamente di utilizzare un database partizionato per migliori prestazioni
database a lungo termine in cui è consentito il modello di dati per il partizionamento logico dei documenti.

Il tipo di partizionamento di un database è impostato al momento della sua reazione. Quando crei un
database, utilizza il parametro della stringa di query `partitioned` per impostare se il
database è partizionato. L'impostazione predefinita per `partitioned` è `false`,
mantenendo una compatibilità con le versioni precedenti.

Il tipo di partizionamento non può essere modificato per un database esistente. 

## Frammenti del database
{: #database-shards}

Prima di leggere questo documento, devi comprendere il
[concetto di frammentazione](/docs/services/Cloudant?topic=cloudant-how-is-data-stored-in-ibm-cloudant-#how-is-data-stored-in-ibm-cloudant-) all'interno di {{site.data.keyword.cloudant_short_notm}}.

## Database non partizionati
{: #non-partitioned-databases}

Un database non partizionato è il tipo più vecchio di database {{site.data.keyword.cloudant_short_notm}} ed è quello che ti
sarà familiare se in precedenza hai utilizzato CouchDB o {{site.data.keyword.cloudant_short_notm}}.

All'interno di un database non partizionato, i documenti sono distribuiti in frammenti in
modo arbitrario in base a una trasformazione dei loro ID documento. Quindi, non esiste una relazione
reale tra l'ID di un documento e il frammento in cui finirà. È improbabile che i documenti con ID
documento molto simili vengano inseriti nello stesso frammento. 

Un database non partizionato offre solo una query globale, descritta in
modo più dettagliato in seguito.

## Database partizionati
{: #partitioned-databases}

Un database partizionato è il tipo più recente di database {{site.data.keyword.cloudant_short_notm}}. All'interno di un
database partizionato, i documenti vengono formati in partizioni logiche utilizzando una
_chiave della partizione_, che fa parte degli ID documento per i documenti
all'interno dei database partizionati. Tutti i documenti vengono assegnati a una partizione e,
di norma, a molti documenti viene assegnata la stessa chiave della partizione. I dati JSON primari di
una partizione e i relativi indici finiscono co-ubicati, ossia il database è in grado di
eseguire la query dei dati all'interno di una partizione in modo più efficiente. 

Un database partizionato offre sia la query partizionata che quella globale. La query partizionata
sfrutta il layout dei dati all'interno del cluster di database per offrire prestazioni query
migliorate e più scalabili. Inoltre, le query di partizione sono spesso più economiche
di quelle globali. 

Poiché i database partizionati offrono i vantaggi sia della query globale che di quella partizionata,
{{site.data.keyword.cloudant_short_notm}} consiglia di sfruttarli per le nuove applicazioni. 

## Cosa rende buona una chiave della partizione?
{: #what-makes-a-good-partition-key-}

Se stai pensando di utilizzare la nuova funzione di *database partizionato* di {{site.data.keyword.cloudant_short_notm}},
la scelta di una chiave della partizione è molto importante. Una chiave della partizione deve avere:

- Molti valori - è meglio avere molte partizioni piccole che poche grandi. 
- Nessun hotspot - evita di progettare un sistema in cui una partizione gestisca una
  parte elevata del carico di lavoro. Se il lavoro viene distribuito uniformemente tra le
  partizioni, il database funzionerà meglio. 
- Ripetizione - Se ciascuna chiave della partizione è univoca, ci sarà un documento per
  partizione. Per ottenere il massimo dai database partizionati, devono esserci più
  documenti per partizione - documenti che devono appartenersi logicamente. 

Vediamo alcuni casi di utilizzo e alcune scelte corrette ed errate per una chiave della partizione. 

| Caso di utilizzo           | Descrizione                 | Chiave partizione | Efficacia                                                                                                  |
|----------------------------|-----------------------------|---------------|------------------------------------------------------------------------------------------------------------------|
| Sistema e-commerce - ordini| Un documento per ordine     | order_id      | Neutrale - un documento per partizione va bene, ma non offre i vantaggi delle query di partizione. |
| Sistema e-commerce - ordini| Un documento per ordine     | user_id       | Corretto - tutti gli ordini di un utente verranno tenuti insieme. |
| Sistema e-commerce - ordini| Un documento per ordine     | status        | Errato - il raggruppamento degli ordini tramite alcuni valori di stato (provvisorio, a pagamento, rimborsato, annullato) creerà troppo poche partizioni sovradimensionate. |
| Piattaforma di blogging    | Un documento per post blog  | author_id     | Corretto - fino a quando ci sono molti autori. È facile eseguire la query dei post di ciascun autore. |
| IOT - letture del sensore  | Un documento per lettura    | device_id     | Corretto - Se ci sono molti dispositivi. Assicurati che un dispositivo non stia producendo molte più letture degli altri. |
| IOT - letture del sensore  | Un documento per lettura    | date          | Errato - le letture correnti causeranno un "hotspot" nella partizione della data corrente. |

Ci sono alcuni casi di utilizzo in cui non c'è una scelta valida per una chiave della partizione.
In queste situazioni, è probabile che un database non partizionato costituisca la scelta migliore, ad esempio,
un database di utenti che memorizza indirizzi email, hash di password e date dell'ultimo accesso. Nessuno di
questi campi genera una chiave della partizione adatta, quindi deve essere utilizzato un normale
database non partizionato. 

## Query
{: #querying}

Questa sezione descrive quali tipi di query di {{site.data.keyword.cloudant_short_notm}} sono disponibili
per le query globali e di partizione, insieme a una breve panoramica del meccanismo di query sottostante per consentirti di
selezionare il meccanismo di query migliore per ogni query che deve essere eseguita dalla tua applicazione.

### Query globale
{: #global-querying}

Puoi eseguire query globali per i seguenti tipi di indice: 

- {{site.data.keyword.cloudant_short_notm}} Query
- Viste
- Ricerca
- Geografico

Quando esegui una query globale, il database deve eseguire un'operazione "scatter-gather"
tra tutti i dati nel database. Ciò significa effettuare richieste di molti singoli server
di database. Il nodo di coordinamento API riceve le risposte da tutti questi server e le
combina per formare una singola risposta per il client. Questa operazione potrebbe
implicare il buffering dei dati e il ritardo della risposta al client se, ad
esempio, i dati devono essere ordinati. 

### Query di partizione
{: #partition-querying}

Puoi eseguire query di partizione per i seguenti tipi di indice: 

- {{site.data.keyword.cloudant_short_notm}} Query
- Viste
- Ricerca

Quando esegui una query di partizione, il database può eseguire la query solamente dei
dati all'interno di una singola partizione. Poiché i dati della partizione risiedono in un
solo frammento (con tre repliche), il nodo di coordinamento API può eseguire una richiesta
direttamente ai server che ospitano i dati invece di dover combinare le risposte
provenienti da molti server. Elimina anche il buffering della risposta in quanto non ci
sono passi di combinazione da eseguire. Pertanto, i dati arrivano al client più
velocemente.

Inoltre, se aumenta la dimensione di un database, è necessario aumentare
anche il numero di frammenti. Ciò aumenta direttamente il numero delle query che il nodo
di coordinamento API deve eseguire ai server che ospitano i dati quando si utilizzano le
query globali. Quando si utilizzano le query di partizione, tuttavia, il numero di frammenti
non influisce sul numero di server che il nodo di coordinamento API deve contattare. Poiché
questo numero rimane piccolo, l'aumento della dimensione dei dati non influisce sulla latenza
della query, a differenza delle query globali. 

## Esempio: partizionamento dei dati di lettura IoT
{: #example-partitioning-iot-reading-data}

Questa discussione è abbastanza astratta; concretizziamola con un esempio. Prendiamo il dominio
Internet of Things (IoT) ed esaminiamolo utilizzando {{site.data.keyword.cloudant_short_notm}} come
cronologia per le letture del dispositivo. Diciamo che i dispositivi stanno fornendo delle letture del
sensore su parti dell'infrastruttura come instradamenti o bridge.

Supporremo che:

- Centinaia o migliaia di dispositivi stanno riportando letture. 
- Ogni dispositivo ha un ID univoco.
- Ogni parte dell'infrastruttura ha un ID univoco. 
- I dispositivi non vengono spostati tra le parti dell'infrastruttura. 
- Ciascun dispositivo scrive una lettura in {{site.data.keyword.cloudant_short_notm}} ogni 10 secondi. Probabilmente tale
    operazione viene effettuata tramite un bus messaggi a {{site.data.keyword.cloudant_short_notm}}.

In un database non partizionato, potresti consentire a {{site.data.keyword.cloudant_short_notm}} di generare gli ID
documento. Un'altra alternativa consiste nel denominare i documenti in base all'ID dispositivo e alla data/ora del record.

Utilizzando il secondo approccio, finiremmo con l'ottenere ID documento come il seguente: 

```
device-123456:20181211T11:13:24.123456Z
```

La data/ora può essere anche una data/ora epoch.

Questo approccio consentirebbe di eseguire la query dei dati per ciascun dispositivo
in modo efficiente utilizzando gli indici partizionati, ma potrebbe essere necessario utilizzare
gli indici globali per creare viste su più dispositivi (diciamo che tutti i dispositivi si trovano
su uno specifico componente dell'infrastruttura).

A scopo illustrativo, rendiamo lo scenario un po' più complicato supponendo
che l'applicazione abbia principalmente bisogno di leggere tutti i dati del sensore
per uno specifico componente dell'infrastruttura piuttosto che per i singoli
dispositivi. 

In questa applicazione, vogliamo che la query in base all'infrastruttura sia più
efficiente, quindi il partizionamento dei dati in base al componente dell'infrastruttura ha
molto più senso rispetto a quello in base all'ID. Ciò consentirà di eseguire la query come un gruppo
di tutti i dispositivi di un determinato componente dell'infrastruttura in modo più efficiente. 

Per le rare query in base al dispositivo, esistono due approcci: 

1. Crea un indice globale con chiave in base al dispositivo ed eseguine la query. È molto più efficace
    se le query a singoli dispositivi sono rare e non ripetute. 
2. Crea un indice globale che associa il dispositivo all'infrastruttura, quindi immetti query di
    partizione alla partizione dell'infrastruttura. Questa operazione ha senso se le query ripetute a
    determinati dispositivi vengono utilizzate mentre l'associazione può essere memorizzata nella cache;
    supporremo che sia questo il caso della nostra applicazione. 

Diamo un'occhiata a come funziona. Esamineremo quattro query:

1. Letture per tutto il tempo per un componente dell'infrastruttura. 
1. Letture per oggi per un componente dell'infrastruttura. 
1. Letture per tutto il tempo per uno specifico dispositivo. 
1. Letture per oggi per uno specifico dispositivo. 

### Creazione del database
{: #creating-the-database}

Utilizzeremo un database denominato `readings` e un account denominato
`acme`. Per crearlo come un database partizionato, passa `true` per l'argomento
`partitioned` alla richiesta di creazione del database:

```
curl -XPUT 'https://acme.cloudant.com/readings?partitioned=true'
```

### Struttura del documento
{: #document-struture}

Innanzitutto, definiamo un formato di documento semplice da utilizzare: 

```json
{
    "deviceID": "device-123456",
    "infrastructureID": "bridge-9876",
    "ts": "20181211T11:13:24.123456Z",
    "reading": {
        "temperature": {"value": 12, "unit": "c"}
    }
}
```

Per questo documento, utilizzando lo schema di partizionamento basato sul componente
dell'infrastruttura, l'ID documento potrebbe includere l'ID infrastruttura come chiave della
partizione e includere sia il dispositivo che la data/ora come chiave del documento: 

```
bridge-9876:device-123456-20181211T11:13:24.123456Z
```

### Creazione degli indici
{: #creating-indexes}

Per le query sopra riportate, avremo bisogno di due indici: 

1. Un indice globale che associa l'ID dispositivo all'ID infrastruttura. 
2. Un indice partizionato che associa gli ID dispositivo alle letture. 

#### Creazione di un indice della vista globale
{: #creating-a-global-view-index}

Un indice della vista costituisce il modo più efficiente per eseguire la semplice associazione
dell'ID dispositivo all'ID infrastruttura. Per definirlo, carica un documento di progettazione con
`options.partitioned` impostato su `false` poiché questo indice è globale. Sebbene
in una funzione `map` effettiva sarebbe opportuno che esercitassi maggiore cautela per quanto
riguarda l'esistenza dei campi, questa operazione sarà simile a quanto di seguito indicato:

```json
{
    "_id": "_design/infrastructure-mapping",
    "options": {"partitioned": false},
    "views": {
        "by-device": {
            "map": "function(doc) { emit(doc.deviceID, doc.infrastructureID) }"
        }
    }
}
```

Supponendo che il documento di cui sopra si trovi in `./view.json`, viene caricato nel database
utilizzando:

```
curl -XPOST https://acme.cloudant.com/readings -d @view.json
```

#### Creazione di un indice {{site.data.keyword.cloudant_short_notm}} Query partizionato
{: #creating-a-paritioned-ibm-cloudant-query-index}

Per restituire le letture relative a un determinato dispositivo provenienti da una partizione, possiamo utilizzare un
indice {{site.data.keyword.cloudant_short_notm}} Query. Per eseguire tale operazione, eseguiamo il `POST` a
`_index` con una definizione di indice che include il campo
`partitioned` impostato su `true`. 

Per le definizioni dell'indice query, il campo `partitioned` non è nidificato in un oggetto
`options`.
{: note}

Per le nostre query, abbiamo bisogno di due indici partizionati: 

1. Per data/ora
2. Per ID dispositivo e data/ora

La definizione di Per data/ora è la seguente: 

```json
{
   "index": {
      "fields": [
         "ts"
      ]
   },
   "name": "timestamped-readings",
   "type": "json",
   "partitioned:" true
}
```

Supponendo che il documento di cui sopra sia `./query-index1.json`, carica l'indice nel
database utilizzando questo comando:

```
curl -XPOST https://acme.cloudant.com/readings/_index -d @query-index1.json
```

La definizione di Per ID dispositivo e data/ora è la seguente: 

```json
{
   "index": {
      "fields": [
         "deviceID",
         "ts"
      ]
   },
   "name": "deviceID-readings",
   "type": "json",
   "partitioned:" true
}
```

Supponendo che il documento di cui sopra sia `./query-index2.json`, carica l'indice nel
database utilizzando questo comando:

```
curl -XPOST https://acme.cloudant.com/readings/_index -d @query-index2.json
```

### Esecuzione delle query
{: #making-queries}

Complessivamente, vogliamo eseguire quattro query:

1. Letture per tutto il tempo per un componente dell'infrastruttura. 
1. Letture per oggi per un componente dell'infrastruttura. 
1. Letture per tutto il tempo per uno specifico dispositivo. 
1. Letture per oggi per uno specifico dispositivo. 

#### Ricerca di tutte le letture per un componente dell'infrastruttura
{: #finding-all-readings-for-a-piece-of-infrastructure}

Poiché le nostre partizioni sono basate sull'infrastruttura, possiamo utilizzare `_all_docs` per una
partizione. Ad esempio, per eseguire la query di tutte le letture relative al componente dell'infrastruttura
`bridge-1234`:

```
curl -XGET \
    'https://acme.cloudant.com/readings/_partition/bridge-1234/_all_docs?include_docs=true'
```

#### Ricerca delle letture recenti per un componente dell'infrastruttura
{: #finding-recent-readings-for-a piece-of-infrastructure}

Questa query deve utilizzare l'indice `timestamped-readings` partizionato. Possiamo immettere
una query alla partizione per ottenere le letture di oggi: 

_query.json, assuming today is 13th Dec 2018:_

```json
{
    "selector": {
        "ts": { "$gte": "20181213"}
    }
}
```

La partizione è incorporata nel percorso HTTP quando immetti la richiesta a {{site.data.keyword.cloudant_short_notm}}:

```
curl -XPOST \
    'https://acme.cloudant.com/readings/_partition/bridge-1234/_find' \
    -d @query.json
```

#### Ricerca dell'ID infrastruttura per un dispositivo
{: #finding-the-infrastructure-id-for-a-device}

Le due query che dobbiamo ancora eseguire sono: 

1. Letture per tutto il tempo per uno specifico dispositivo. 
2. Letture per oggi per uno specifico dispositivo. 

Per queste due query, dobbiamo trovare la partizione relativa ai dispositivi utilizzando
l'indice `by-device` globale. Poi possiamo eseguire la query delle letture per
la singola partizione. Mentre avremmo potuto utilizzare un indice globale per eseguire la query delle letture per
i singoli dispositivi, l'associazione dal dispositivo all'ID infrastruttura è altamente
memorizzabile -- non cambia mai! -- quindi questo approccio ci consente di utilizzare per lo più la query
partizionata più economica e più efficiente per la maggior parte delle richieste. 

L'utilizzo di un indice globale per eseguire direttamente la query delle letture del dispositivo potrebbe risultare più efficiente se
la memorizzazione dell'associazione del dispositivo all'infrastruttura non funziona correttamente per una determinata applicazione. 

Per trovare la partizione pertinente per un dispositivo, eseguiamo la query della vista `by-device`,
inviando l'ID dispositivo come la chiave: 

```
curl -XGET \
  'https://acme.cloudant.com/readings/_design/infrastructure-mapping/_view/by-device?keys=["device-123456"]&limit=1'
```

Questa restituisce:

```json
{"total_rows":5,"offset":0,"rows":[
{
    "id":"bridge-9876:device-123456-20181211T11:13:24.123456Z",
    "key":"device-123456",
    "value":"bridge-9876"
}
]}
```

Abbiamo la nostra chiave della partizione nel campo `value` della riga inclusa:
`bridge-9876`.

#### Query di tutti i risultati per un dispositivo
{: #querying-for-all-results-for-a-device}

Per ottenere i risultati relativi a un dispositivo, immettiamo una query di partizione per il dispositivo all'interno
della partizione `bridge-9876`. Viene utilizzato un selettore {{site.data.keyword.cloudant_short_notm}} Query standard,
come se stessi immettendo una query globale.

_query.json:_

```json
{
   "selector": {
      "deviceID": {
         "$eq": "device-123456"
      }
   }
}
```

La partizione è incorporata nel percorso HTTP quando immetti la richiesta a {{site.data.keyword.cloudant_short_notm}}:

```
curl -XPOST \
    'https://acme.cloudant.com/readings/_partition/bridge-1234/_find' \
    -d @query.json
```

#### Query dei risultati recenti per un dispositivo
{: #querying-for-recent-results-for-a-device}

Per ottenere i risultati relativi a un dispositivo, immettiamo una query di partizione per il dispositivo all'interno
della partizione `bridge-9876`. Il selettore è solo leggermente più complicato, ma è ancora lo stesso
di una query globale equivalente. 

_query.json, assuming today is 13th Dec 2018:_

```json
{
   "selector": {
      "deviceID": {
         "$eq": "device-123456"
      },
      "ts": {
         "$gte": "20181213"
      }
   }
}
```

La partizione è incorporata nel percorso HTTP quando immetti la richiesta a {{site.data.keyword.cloudant_short_notm}}:

```
curl -XPOST \
    'https://acme.cloudant.com/readings/_partition/bridge-1234/_find' \
    -d @query.json
```
