---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: connect to ibm cloudant, http api, json, distributed systems, replication

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

# Principi di base di {{site.data.keyword.cloudant_short_notm}}
{: #ibm-cloudant-basics}

Se è la prima volta che ti trovi qui,
esamina questa sezione prima di scorrere ulteriormente.
{: shortdesc}

Per comprendere le informazioni presenti nei seguenti argomenti, presupponiamo che tu conosca le nozioni di base su {{site.data.keyword.cloudantfull}}: 

- [Librerie client](/docs/services/Cloudant?topic=cloudant-client-libraries#client-libraries)
- [Guida di riferimento alle API](/docs/services/Cloudant?topic=cloudant-api-reference-overview#api-reference-overview)
- [Guide](/docs/services/Cloudant?topic=cloudant-authorized-curl-acurl-#authorized-curl-acurl-)

## Connessione a {{site.data.keyword.cloudant_short_notm}}
{: #connecting-to-ibm-cloudant}

Per accedere a {{site.data.keyword.cloudant_short_notm}},
devi disporre di un [account {{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant?topic=cloudant-ibm-cloudant.com#enterprise-plan)
o di un [account {{site.data.keyword.cloud}}](https://cloud.ibm.com/login).

## API HTTP
{: #http-api}

Tutte le richieste a {{site.data.keyword.cloudant_short_notm}} passano attraverso il web.
Ciò significa che se un sistema può parlare con il web potrà parlare con {{site.data.keyword.cloudant_short_notm}}.
Tutte le librerie specifiche del linguaggio per {{site.data.keyword.cloudant_short_notm}} sono dei veri e propri wrapper che forniscono
praticità e sottigliezze linguistiche che ti aiutano a lavorare con una semplice API.
Molti utenti scelgono di utilizzare le librerie HTTP raw per lavorare con {{site.data.keyword.cloudant_short_notm}}.

Per ulteriori informazioni su come {{site.data.keyword.cloudant_short_notm}} utilizza HTTP, vedi [HTTP ](/docs/services/Cloudant?topic=cloudant-http#http) nel riferimento API.

{{site.data.keyword.cloudant_short_notm}} supporta i seguenti metodi di richiesta HTTP:

-   `GET`

    Consente di richiedere l'elemento specificato.
    Come con le normali richieste HTTP,
    il formato dell'URL definisce ciò che viene restituito.
    Con {{site.data.keyword.cloudant_short_notm}} questo può includere elementi statici,
    documenti del database
    e informazioni statistiche e di configurazione.
    Nella maggior parte dei casi, le informazioni vengono restituite sotto forma di documento JSON.

-   `HEAD`

    Il metodo `HEAD` viene utilizzato per ottenere l'intestazione HTTP di una richiesta `GET` senza il corpo della risposta.

-   `POST`

    Carica i dati.
    All'interno dell'API {{site.data.keyword.cloudant_short_notm}},
    il metodo `POST` è utilizzato per impostare valori,
    caricare documenti,
    impostare valori dei documenti
    e avviare alcuni comandi di amministrazione.

-   `PUT`

    Utilizzato per "memorizzare" una specifica risorsa.
    Nell'API {{site.data.keyword.cloudant_short_notm}},
    `PUT` è utilizzato per creare nuovi oggetti,
    tra cui database,
    documenti,
    viste
    e documenti di progettazione.

-   `DELETE`

    Elimina la risorsa specificata,
    inclusi i documenti,
    le viste
    e i documenti di progettazione.

-   `COPY`

    Un metodo speciale che può essere utilizzato per copiare documenti e oggetti.

Se il client (come alcuni browser web) non supporta l'utilizzo di questi metodi HTTP,
è possibile utilizzare invece `POST` con l'intestazione della richiesta `X-HTTP-Method-Override` impostata sul metodo HTTP effettivo.

### Errore di metodo non consentito
{: #method-not-allowed-error}

Se utilizzi un tipo di richiesta HTTP non supportata con un URL che non supporta il tipo specificato,
viene restituito un errore [405](/docs/services/Cloudant?topic=cloudant-http#http-status-codes)
che elenca i metodi HTTP supportati, come mostrato nel seguente esempio.

_Esempio di messaggio di errore in risposta a una richiesta non supportata:_

```json
{
    "error":"method_not_allowed",
    "reason":"Only GET,HEAD allowed"
}
```
{: codeblock}

## JSON
{: #json-overview}

{{site.data.keyword.cloudant_short_notm}} memorizza i documenti utilizzando la codifica JSON (JavaScript Object Notation),
pertanto tutto ciò che è codificato in JSON può essere memorizzato come documento.
I file che contengono dei supporti multimediali,
come immagini,
video
e audio,
sono chiamati BLOB (Binary Large OBject)
e possono essere memorizzati come allegati associati ai documenti.

Ulteriori informazioni su JSON sono disponibili nella [Guida JSON](/docs/services/Cloudant?topic=cloudant-json#json).

## Sistemi distribuiti
{: #distributed-systems}

L'API {{site.data.keyword.cloudant_short_notm}} ti consente di interagire con una collaborazione di numerose macchine,
chiamate cluster.
Le macchine in un cluster devono essere nello stesso data center
ma possono trovarsi in diversi "pod" di quel data center.
L'utilizzo di pod diversi aiuta a migliorare le caratteristiche di alta disponibilità di {{site.data.keyword.cloudant_short_notm}}.

Un vantaggio del clustering è che quando hai bisogno di più capacità di elaborazione,
basta aggiungere altre macchine.
Questo è spesso più efficace in termini di costi e di tolleranza agli errori rispetto al ridimensionamento o miglioramento di una singola macchina esistente.

Per ulteriori informazioni sui concetti di {{site.data.keyword.cloudant_short_notm}} e dei sistemi distribuiti,
consulta la guida [Teorema CAP](/docs/services/Cloudant?topic=cloudant-cap-theorem#cap-theorem).

## Replica
{: #replication-basics}

La [Replica](/docs/services/Cloudant?topic=cloudant-replication-api#replication-api) è una procedura seguita da {{site.data.keyword.cloudant_short_notm}},
[CouchDB ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://couchdb.apache.org/){: new_window},
[PouchDB ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://pouchdb.com/){: new_window}
e da altri database distribuiti.
La replica sincronizza lo stato di due database in modo che i loro contenuti siano identici.

Puoi replicare in modo continuo.
Ciò significa che un database di destinazione viene aggiornato ogni volta che il database di origine cambia.
La replica continua può essere utilizzata per il backup dei dati,
aggregando i dati tra più database,
o per la condivisione dei dati.

Tuttavia,
la replica continua significa anche esecuzione di test in modo continuo per ogni modifica del database di origine.
Questa esecuzione di test richiede continue chiamate interne, che potrebbero
influire sulle prestazioni o sul costo di utilizzo del database.

La replica continua può comportare molte chiamate interne. Queste chiamate potrebbero influire sui costi per gli utenti a più tenant dei sistemi {{site.data.keyword.cloudant_short_notm}}. La replica continua è disabilitata per impostazione predefinita.
{: note}

