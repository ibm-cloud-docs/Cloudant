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

# Principi di base di Cloudant

Se è la prima volta che ti trovi qui,
esamina questa sezione prima di scorrere ulteriormente.
{:shortdesc}

Le sezioni relative a [Librerie client](../libraries/index.html#-client-libraries),
[Guida di riferimento API](../api/index.html#-api-reference) e
[Guide](../guides/index.html#-guides) presuppongono che tu conosca già alcune nozioni di base su Cloudant.

## Connessione a Cloudant

Per accedere a {{site.data.keyword.cloudant_short_notm}},
devi disporre di un [account {{site.data.keyword.cloudant}}](../api/account.html)
o di un [account {{site.data.keyword.Bluemix}}](../offerings/bluemix.html).

## API HTTP

Tutte le richieste a Cloudant passano attraverso il web.
Ciò significa che se un sistema può parlare con il web potrà parlare con Cloudant.
Tutte le librerie specifiche del linguaggio per Cloudant sono dei veri e propri wrapper che forniscono
praticità e sottigliezze linguistiche che ti aiutano a lavorare con una semplice API.
Molti utenti scelgono di utilizzare le librerie HTTP raw per lavorare con Cloudant.

I dettagli specifici sul modo in cui Cloudant utilizza HTTP sono forniti
nell'[argomento HTTP della Guida di riferimento API](../api/http.html).

Cloudant supporta i seguenti metodi di richiesta HTTP:

-   `GET`

    Consente di richiedere l'elemento specificato.
    Come con le normali richieste HTTP,
    il formato dell'URL definisce ciò che viene restituito.
    Con Cloudant questo può includere elementi statici,
    documenti del database
    e informazioni statistiche e di configurazione.
    Nella maggior parte dei casi, le informazioni vengono restituite sotto forma di documento JSON.

-   `HEAD`

    Il metodo `HEAD` viene utilizzato per ottenere l'intestazione HTTP di una richiesta `GET` senza il corpo della risposta.

-   `POST`

    Carica i dati.
    All'interno dell'API Cloudant,
    il metodo `POST` è utilizzato per impostare valori,
    caricare documenti,
    impostare valori dei documenti
    e avviare alcuni comandi di amministrazione.

-   `PUT`

    Utilizzato per "memorizzare" una specifica risorsa.
    Nell'API Cloudant,
    `PUT` è utilizzato per creare nuovi oggetti,
    tra cui database,
    documenti,
    viste,
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

Se utilizzi un tipo di richiesta HTTP non supportata con un URL che non supporta il tipo specificato,
viene restituito un errore [405](../api/http.html#405)
che elenca i metodi HTTP supportati, come mostrato nel seguente esempio.

_Esempio di messaggio di errore in risposta a una richiesta non supportata:_

```json
{
    "error":"method_not_allowed",
    "reason":"Only GET,HEAD allowed"
}
```
{:codeblock}

## JSON

Cloudant memorizza i documenti utilizzando la codifica JSON (JavaScript Object Notation),
pertanto tutto ciò che è codificato in JSON può essere memorizzato come documento.
I file che contengono dei supporti multimediali,
come immagini,
video
e audio,
sono chiamati BLOB (Binary Large OBject)
e possono essere memorizzati come allegati associati ai documenti.

Ulteriori informazioni su JSON sono disponibili nella [Guida JSON](../guides/json.html).

<div id="distributed"></div>

## Sistemi distribuiti

L'API Cloudant ti consente di interagire con una collaborazione di numerose macchine,
chiamate cluster.
Le macchine in un cluster devono essere nello stesso data center
ma possono trovarsi in diversi "pod" di quel data center.
L'utilizzo di pod diversi aiuta a migliorare le caratteristiche di alta disponibilità di Cloudant.

Un vantaggio del clustering è che quando hai bisogno di più capacità di elaborazione,
basta aggiungere altre macchine.
Questo è spesso più efficace in termini di costi e di tolleranza agli errori rispetto al ridimensionamento o miglioramento di una singola macchina esistente.

Per ulteriori informazioni sui concetti di Cloudant e dei sistemi distribuiti,
consulta la guida [Teorema CAP](../guides/cap_theorem.html).

## Replica

La [Replica](../api/replication.html) è una procedura seguita da Cloudant,
[CouchDB ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://couchdb.apache.org/){:new_window},
[PouchDB ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://pouchdb.com/){:new_window}
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

>   **Nota**: la replica continua può comportare un gran numero di chiamate interne.
    Ciò potrebbe influire sui costi per gli utenti a più tenant dei sistemi Cloudant.
    La replica continua è disabilitata per impostazione predefinita.
