---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: immutable data, pre-calculate results, de-normalise data, avoid conflicts, conflict resolution

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

# Cinque suggerimenti per modellare i tuoi dati in scala
{: #five-tips-for-modeling-your-data-to-scale}

Questo articolo considera i punti più importanti
per la modellazione dei dati della tua applicazione per lavorare in modo efficiente su larga scala.
{: shortdesc}

*(Questa guida si basa su un articolo del blog di Mike Rhodes: ["My top 5 tips for modeling your data to scale" ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://cloudant.com/blog/my-top-5-tips-for-modeling-your-data-to-scale/), originariamente pubblicato il 17 dicembre 2013.)*

Il modo in cui modelli i tuoi dati in {{site.data.keyword.cloudantfull}} influirà in modo significativo sul modo in cui la tua applicazione è in
grado di eseguire il ridimensionamento. Il nostro modello di dati sottostante differisce sostanzialmente da un modello relazionale
e ignorare questa distinzione può essere la causa di problemi di prestazioni in futuro.

Come sempre, una modellazione corretta comporta il raggiungimento di un equilibrio tra la facilità d'uso
e le caratteristiche delle prestazioni che speri di raggiungere.

Senza ulteriori indugi, andiamo avanti.

## Considera i dati immutabili
{: #consider-immutable-data}

Se modifichi la stessa parte di stato con una frequenza di una volta al secondo o di più, potresti scegliere di rendere i
tuoi documenti immutabili. Ciò riduce in modo significativo la possibilità di creare
documenti in conflitto.

Al contrario, se aggiorni un dato documento meno di una volta ogni dieci secondi,
un modello di dati con aggiornamento sul posto - ossia, l'aggiornamento di documenti esistenti-
semplificherà notevolmente il codice applicativo.

In genere, i modelli di dati basati su dati immutabili richiedono l'uso di viste per riepilogare
i documenti che compongono lo stato attuale. Poiché le viste sono precalcolate,
ciò non dovrebbe influire negativamente sulle prestazioni dell'applicazione.

## Perché ti aiuta considerare dati immutabili 
{: #why-this-helps-you-consider-immutable-data}

Dietro la nostra interfaccia `https://$ACCOUNT.cloudant.com/` è presente un database distribuito. 
All'interno del cluster, i documenti vengono suddivisi in una serie di frammenti che, collettivamente, formano
il database. Questi frammenti vengono quindi distribuiti tra i nodi nel cluster. Questo è ciò che
ci permette di supportare i database di molti terabyte di dimensioni.

Per impostazione predefinita, oltre alla suddivisione di un database in frammenti, tutti i frammenti hanno tre
copie, o repliche di frammento, ognuna delle quali risiede su un nodo diverso del cluster di database. 
Ciò consente al database di continuare a fornire richieste se un nodo dovesse non funzionare. Pertanto,
il salvataggio di un documento comporta la scrittura in tre nodi. Ciò significa che se vengono effettuati contemporaneamente due
aggiornamenti allo stesso documento, è possibile che un sottoinsieme di nodi accetti il primo
aggiornamento e che un altro sottoinsieme accetti il secondo aggiornamento. Quando il cluster rileva questa
discrepanza, combinerà i documenti nello stesso modo in cui lo fa la replica normale per gli
aggiornamenti simultanei creando un conflitto.

I documenti in conflitto riducono le prestazioni; vedi il seguente testo per maggiori dettagli sul motivo per cui questo accade.
Un modello di aggiornamento sul posto estremamente simultaneo aumenta anche la probabilità che le scritture
vengano rifiutate perché il parametro `_rev` non è quello previsto, il che forzerà la tua
applicazione a ritentare e quindi a ritardare l'elaborazione.

Abbiamo scoperto che questo scenario di documenti in conflitto è molto più probabile per
gli aggiornamenti eseguiti con una frequenza maggiore di una volta al secondo, ma consigliamo i documenti immutabili per gli aggiornamenti
eseguiti più di una volta ogni dieci secondi per stare al sicuro.

## Utilizza le viste per precalcolare i risultati anziché come indici di ricerca
{: #use-views-to-pre-calculate-results-rather-than-as-search-indexes}

Piuttosto che utilizzare le viste come indici di ricerca glorificati - "dammi tutti i documenti di `person`" - fai in modo
che il database faccia il lavoro per te. Ad esempio, invece di recuperare tutti i documenti di diecimila persone per
calcolare le loro ore di lavoro combinate, utilizza una vista con una chiave composita per
precalcolare questo valore per anno, mese, giorno, mezza giornata e ora utilizzando la funzione di riduzione integrata `_sum`. 
Salverai il lavoro nella tua applicazione e consentirai al database di concentrarsi sul servizio di molte
piccole richieste invece che sulla lettura di enormi quantità di dati dal disco per servire una sola grande
richiesta.

## Perché ti aiuta utilizzare le viste per precalcolare i risultati
{: #why-this-helps-you-use-views-to-pre-calculate-results}

È abbastanza semplice. Per prima cosa, nota che le mappe e le riduzioni sono precalcolate. Questo significa
che chiedere il risultato di una funzione di riduzione è un'operazione economica, in particolare se
confrontata con le quantità significative di IO necessarie per trasmettere centinaia o addirittura migliaia
di documenti dall'archiviazione su disco.

A un livello più basso, quando un nodo riceve una richiesta di visualizzazione, chiede ai nodi che contengono le
repliche dei frammenti per il database della vista, i risultati della richiesta di visualizzazione per i documenti in ogni
frammento. Quando riceve le risposte - prendendo la prima per ogni replica di frammento - il nodo
che serve la richiesta di visualizzazione combina i risultati e trasmette il risultato finale al client. 
Più documenti sono coinvolti, più tempo richiederà ogni replica per trasmettere i risultati dal
disco e attraverso la rete. Inoltre, il nodo che serve la richiesta ha molto più lavoro da fare
per combinare i risultati dai ogni frammento di database.

Nel complesso, l'obiettivo è che una richiesta di visualizzazione richieda la quantità minima di dati da ogni frammento,
riducendo il tempo in cui i dati sono in transito e vengono combinati per formare il risultato finale. L'utilizzo della
potenza delle viste per precalcolare i dati aggregati è un modo per raggiungere questo obiettivo. Ciò ovviamente
diminuisce il tempo trascorso dall'applicazione in attesa di completare la richiesta.

## Denormalizza i tuoi dati
{: #de-normalise-your-data}

Nei database relazionali, la normalizzazione dei dati è spesso il modo più efficace per memorizzare i dati. 
Ciò ha molto senso quando puoi utilizzare JOIN per combinare facilmente i dati da più tabelle. 
In {{site.data.keyword.cloudant_short_notm}}, è più probabile che tu abbia bisogno di una richiesta HTTP GET per ogni parte dei dati, pertanto la riduzione del
numero di richieste necessarie per creare un'immagine completa di un'entità modellata ti consentirà
di presentare più rapidamente le informazioni ai tuoi utenti.

L'utilizzo delle viste consente di ottenere molti dei vantaggi dei dati normalizzati
mantenendo inalterata la versione de-normalizzata per l'efficienza.

Ad esempio, in uno schema relazionale normalmente rappresenti le tag in un tabella separata e utilizzi
una tabella di connessione per unire le tag con i relativi documenti associati, consentendo una rapida ricerca
di tutti i documenti con una determinata tag.

In {{site.data.keyword.cloudant_short_notm}}, memorizzi le tag in un elenco all'interno di ciascun documento. Utilizzi quindi una vista per ottenere i documenti
con una determinata tag
[emettendo ogni tag come chiave nella funzione di mappa della tua vista](/docs/services/Cloudant?topic=cloudant-views-mapreduce#views-mapreduce). 
Eseguendo una query nella vista per una determinata chiave verranno forniti tutti i documenti con quella tag.

## Perché ti aiuta denormalizzare i tuoi dati
{: #why-this-helps-you-de-normalize-your-data}

Tutto si riduce al numero di richieste HTTP effettuate dalla tua applicazione. C'è un costo
per aprire le connessioni HTTP - in particolare HTTPS - e, mentre il riutilizzo delle connessioni può aiutare, effettuare
meno richieste in generale aumenterà la frequenza con cui l'applicazione può elaborare i dati.

Come vantaggio secondario, i documenti denormalizzati e le viste precalcolate spesso ti consentono di
generare il valore richiesto dalla tua applicazione in anticipo, invece di essere costruito
in tempo reale durante la query.

## Evita conflitti utilizzando documenti più dettagliati
{: #avoid-conflicts-by-using-finer-grained-documents}

In tensione con il consiglio di denormalizzare i tuoi dati c'è questo altro consiglio: utilizza
documenti dettagliati per ridurre la possibilità di modifiche simultanee che creano conflitti. 
Questo è un po' come normalizzare i tuoi dati. Bisogna ricercare un equilibrio tra la riduzione del numero
di richieste HTTP e l'evitare i conflitti.

Ad esempio, prendi un record medico che contiene un elenco di operazioni:

```json
{
    "_id": "Joe McIllness",
    "operations": [
        { "surgery": "heart bypass" },
        { "surgery": "lumbar puncture" }
    ]
}
```
{: codeblock}

Se Joe è abbastanza sfortunato da avere un sacco di operazioni contemporaneamente, i molti
aggiornamenti simultanei a un documento possono creare documenti in conflitto, come descritto in precedenza.
È meglio suddividere le operazioni in documenti separati che fanno riferimento al documento personale di Joe
e utilizzare una vista per connettere insieme le cose. Per rappresentare ogni operazione, devi caricare i documenti come
nei due seguenti esempi:

```json
{
    "type": "operation",
    "patient": "Joe McIllness",
    "surgery": "heart bypass"
}
```
{: codeblock}

```json
{
    "type": "operation",
    "patient": "Joe McIllness",
    "surgery": "lumbar puncture"
}
```
{: codeblock}

L'emissione del campo `"patient"` come chiave nella tua vista consentirà di eseguire query per tutte le
operazioni di un determinato paziente. Di nuovo, le viste vengono utilizzate per aiutare a costruire un'immagine completa
di una determinata entità da documenti separati, contribuendo a mantenere basso il numero di richieste HTTP
anche se abbiamo suddiviso i dati per una singola entità modellata.

## Perché ti aiuta evitare conflitti
{: #why-this-helps-you-avoid-conflicts}

Evitare i documenti in conflitto aiuta a velocizzare molte operazioni nei tuoi database {{site.data.keyword.cloudant_short_notm}}. 
Ciò è dovuto al fatto che esiste un processo che esegue l'attuale revisione vincente
utilizzata ogni volta che il documento viene letto: recuperi singoli di documenti, chiamate con `include_docs=true`, creazione di viste
e così via.

La revisione vincente è una revisione particolare dalla generale struttura ad albero del documento. Ricorda che
i documenti su {{site.data.keyword.cloudant_short_notm}} sono in effetti delle strutture ad albero di revisioni. Un algoritmo arbitrario ma al contempo deterministico
seleziona una delle foglie non eliminate di questa struttura ad albero da restituire quando viene effettuata una richiesta
per il documento. Le strutture ad albero più grandi con un fattore di diramazione superiore richiedono più tempo per l'elaborazione rispetto
a una struttura ad albero di documenti senza o con pochi rami: ogni ramo deve essere seguito per vedere se è un candidato per
la revisione vincente. I potenziali vincitori devono quindi essere confrontati l'uno con l'altro per fare la
scelta finale.

{{site.data.keyword.cloudant_short_notm}} ovviamente gestisce bene un piccolo numero di rami - dopotutto, la replica si basa
sul fatto che i documenti possono diramarsi per evitare di eliminare i dati - ma quando si raggiungono livelli
patologici, in particolare se i conflitti non vengono risolti, è richiesto un laborioso procedimento e
un uso intensivo della memoria per percorrere la struttura ad albero dei documenti.

## Integra la risoluzione dei conflitti
{: #build-in-conflict-resolution}

In un sistema con consistenza eventuale come {{site.data.keyword.cloudant_short_notm}}, i conflitti alla fine accadono. Come
descritto in precedenza, questo è il prezzo della scalabilità e della resilienza dei dati.

Strutturare i dati in modo tale che la risoluzione dei conflitti sia rapida e non richieda
l'assistenza di un operare aiuterà a mantenere funzionanti i database. La capacità di
risolvere automaticamente i conflitti senza la necessità di coinvolgere i tuoi utenti migliorerà
significativamente la loro esperienza e, si spera, ridurrà l'onere di supporto per la tua organizzazione.

Questa operazione è molto specifica dell'applicazione, ma ecco alcuni suggerimenti:

-   Evita invarianti nei campi documento laddove possibile. Questo rende più probabile che una semplice
    operazione di unione, prendendo il campo modificato da ogni revisione del documento in conflitto, sia
    adatta. Questo rende più semplice e più robusto il codice applicativo.
-   Consenti l'autonomia dei documenti. La necessità di recuperare altri documenti per eseguire
    la risoluzione corretta aumenterà la latenza nella risoluzione dei conflitti. C'è anche una possibilità di ottenere una
    versione di altri documenti che non sono coerenti con il documento che stai risolvendo,
    rendendo difficile la risoluzione corretta. E se gli altri documenti sono in conflitto?

## Perché ti aiuta integrare la risoluzione dei conflitti 
{: #why-this-helps-you-build-in-conflict-resolution}

Come descritto in precedenza, i documenti fortemente in conflitto incidono pesantemente sul database. La creazione
della funzionalità per risolvere i conflitti dall'inizio è un grande aiuto per evitare
documenti patologicamente in conflitto.

## Riepilogo
{: #summary}

Questi suggerimenti illustrano alcuni modi in cui i dati di modellazione influenzano le prestazioni della tua
applicazione. L'archivio dati di {{site.data.keyword.cloudant_short_notm}} presenta alcune caratteristiche specifiche,
sia da tenere d'occhio sia da sfruttare, per assicurare che le prestazioni del database vengano scalate quando l'applicazione
cresce. Comprendiamo che il cambiamento può essere confuso, quindi siamo sempre a disposizione per dare consigli.

Per ulteriori letture, consulta questa discussione sul
[modello di dati per Foundbite ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://cloudant.com/blog/foundbites-data-model-relational-db-vs-nosql-on-cloudant/){: new_window}
o questo [esempio dai nostri amici di Twilio ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://www.twilio.com/blog/2013/01/building-a-real-time-sms-voting-app-part-3-scaling-node-js-and-couchdb.html){: new_window}.

