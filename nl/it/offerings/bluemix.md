---

copyright:
  years: 2015, 2017
lastupdated: "2017-06-09"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-02-23 -->

# IBM Bluemix

{{site.data.keyword.cloudant}} è disponibile anche come un servizio
[{{site.data.keyword.Bluemix}}
![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://console.ng.bluemix.net/catalog/services/cloudant-nosql-db/){:new_window}.
{:shortdesc}

{{site.data.keyword.Bluemix_short}} è una piattaforma cloud a standard aperti per
la creazione, esecuzione e gestione delle
applicazioni. Scopri ulteriori informazioni su {{site.data.keyword.Bluemix_notm}}
e inizia ad utilizzarlo all'indirizzo
[home page ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://console.ng.bluemix.net/){:new_window}.

## Bluemix Pubblico

{{site.data.keyword.cloudantfull}} è disponibile come un [piano Lite](#lite-plan) gratuito e
come diverse configurazioni nel [piano Standard](#standard-plan) a pagamento.
È anche disponibile un [piano dedicato](#dedicated-plan).
Questo piano offre la stessa configurabilità del piano Standard
ma viene fornita su un hardware dedicato.
L'hardware dedicato non viene condiviso con altri account,
il che significa che sei l'unico che può utilizzarlo.
Se viene eseguito il provisioning di un'istanza del piano dedicato in un'[Ubicazione US](#locations),
puoi facoltativamente selezionare una configurazione conforme
[HIPAA ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){:new_window}.

La seguente tabella riepiloga le misurazioni delle prestazioni per ogni piano.

>   **Nota**: i dettagli nella tabella sono indicativi come a settembre 2016.
    Per i valori correnti,
    contatta il supporto [{{site.data.keyword.cloudant_short_notm}} ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](mailto:support@cloudant.com){:new_window}.

>   **Nota**: tutti i valori della valuta in questo documento sono in dollari americani ($).

<table border='1'>

<tr>
<th>Piani</th><th>Lite</th><th colspan='4'>Standard <i>e</i> Dedicated</th>
</tr>
<tr>
<td>Prezzo di base (per ora)</td>
<td>$0.00</td>
<td colspan='4'>Consulta <a href="http://cloudant.com/bluemix" target="_blank">Pricing details <img src="../images/launch-glyph.svg" alt="Icona link esterno" title="Icona link esterno"></a>.</td>
</tr>
<tr>
<td>Capacità produttiva fornita (ricerche al secondo)</td>
<td>20</td>
<td>100</td>
<td>1.000</td>
<td>5.000</td>
<td>20.000</td>
</tr>
<tr>
<td>Capacità produttiva fornita (scritture al secondo)</td>
<td>10</td>
<td>50</td>
<td>500</td>
<td>2.500</td>
<td>10.000</td>
</tr>
<tr>
<td>Capacità produttiva fornita (query al secondo)</td>
<td>5</td>
<td>5</td>
<td>50</td>
<td>250</td>
<td>1.000</td>
</tr>
<tr>
<td>Dimensione documento individuale massima </td>
<td>1 MB</td>
<td colspan='4'>1 MB</td>
</tr>
<tr>
<td>Spazio disco incluso</td>
<td>1 GB</td>
<td colspan='4'>20 GB</td>
</tr>
<tr>
<td>Eccedenza disco (per GB/ora)</td>
<td>Non disponibile </td>
<td colspan='4'>Consulta <a href="http://cloudant.com/bluemix" target="_blank">Pricing details <img src="../images/launch-glyph.svg" alt="Icona link esterno" title="Icona link esterno"></a>.</td>
</tr>

</table>

Puoi selezionare quale piano utilizzare quando
[esegui il provisioning della tua istanza del servizio {{site.data.keyword.cloudant_short_notm}}](#provisioning-a-cloudant-instance-on-bluemix).
Per impostazione predefinita,
è selezionato il [piano Lite](#lite-plan).

![Selezione piano istanza servizio Cloudant](../images/fb87416a.png)

### Piano Lite

Il piano Lite è gratuito
ma ti limita a 1 GB di archiviazione dati.
Sono inoltre applicati dei limiti alla capacità produttiva fornita per le ricerche,
le scritture e le query. 

L'utilizzo dell'archiviazione viene controllato giornalmente. Se superi il tuo limite di archiviazione, le richieste HTTP all'account ricevono
un codice di stato 402 con il messaggio di errore, "L'account ha superato la propria quota di utilizzo dati. È necessario un aggiornamento a un piano a pagamento."
Per informarti, viene inoltre visualizzato un banner nel dashboard Cloudant. Puoi ancora leggere e eliminare i dati. Tuttavia, per scrivere nuovi dati,
devi eseguire l'aggiornamento a un piano a pagamento o eliminare i dati e attendere fino al successivo controllo sul tuo account per essere riattivato. 

Se desideri archiviare più di un GB di dati o
hai una capacità produttiva maggiore,
passa al [piano Standard](#standard-plan).

### Piano Standard

Il piano Standard include 20 GB di archiviazione dati.
Se archivi più di 20 GB,
ti viene addebitato un costo definito per GB per ora.
Consulta le informazioni sul [Pricing ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://cloudant.com/bluemix){:new_window} per il costo corrente.
Nel piano Standard,
puoi anche modificare la capacità produttiva fornita per le ricerche,
le scritture e le query.

### Piano dedicato

{{site.data.keyword.cloudant_short_notm}} è disponibile su hardware dedicato a singolo tenant come parte di una configurazione di
[{{site.data.keyword.Bluemix_notm}} Dedicato
![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://www.ibm.com/cloud-computing/bluemix/dedicated/){:new_window}.

<div id="servicetier"></div>

## Livelli del servizio

Puoi visualizzare i dettagli della capacità produttiva nei piani disponibili per il tuo account.
Puoi selezionare il livello di provisioning che desideri utilizzare,
tramite la scheda Account del tuo dashboard dell'account {{site.data.keyword.cloudant_short_notm}}.

![Dashboard account](../images/cloudant_capacity.png)

Per passare a una capacità produttiva differente,
seleziona il provisioning che desideri e fai quindi clic sul pulsante di opzione
`Change Capacity`.
Ti verrà richiesto di confermare la modifica e ti verrà ricordato che la modifica di
provisioning necessità di 24 per essere completata.

![Dashboard account](../images/cloudant_capacity_change.png)

<div id="throughput"></div>

### Capacità produttiva fornita

Il provisioning effettivo viene identificato e misurato come uno di tre tipi di eventi:

1.	Una ricerca,
    che consiste di una lettura di un documento specifico,
    in base a `_id` del documento.
2.	Una scrittura,
    che consiste di una creazione,
    una modifica o
    un'eliminazione di un documento individuale
    o di una qualsiasi modifica a causa di una creazione dell'indice.
3.	Una query,
    che consiste di una richiesta effettuata a uno degli endpoint di query {{site.data.keyword.cloudant_short_notm}},
    inclusi i seguenti tipi:
	-	Indice primario ([`_all_docs`](../api/database.html#get-documents))
	-	Vista MapReduce ([`_view`](../api/creating_views.html#using-views))
	-	Indice di ricerca ([`_search`](../api/search.html#queries))
	-	Indice geospaziale ([`_geo`](../api/cloudant-geo.html#querying-a-cloudant-geo-index))
	-	Query Cloudant ([`_find`](../api/cloudant_query.html#finding-documents-using-an-index))
	-	Modifiche ([`_changes`](../api/database.html#get-changes))

La misurazione della velocità effettiva è un conteggio semplice del numero di eventi di ogni tipo,
al secondo,
in cui il secondo è una finestra _temporale scorrevole_.
Se il tuo account supera il numero di eventi di velocità effettiva di cui è stato eseguito il provisioning per il piano,
le richieste vengono rifiutate finché il numero di eventi nella finestra temporale scorrevole
non supererà più il numero di provisioning.
Potrebbe essere utile pensare alla finestra temporale scorrevole di 1 secondo come a un periodo consecutivo di 1.000 millisecondi.

Ad esempio,
se sei nel piano Standard con provisioning di 200 ricerche al secondo,
il tuo account può effettuare un massimo di 200 richieste di ricerca durante un periodo consecutivo di 1.000 millisecondi (1 secondo).
Le seguenti richieste di ricerca effettuate durante il periodo di 1.000 secondi della finestra temporale di scorrimento,
vengono rifiutate finché il numero di richieste di ricerca scende nuovamente a meno di 200.

Quando una richiesta viene rifiutata perché il numero di eventi viene superato,
le applicazioni ricevono una risposta [`429` troppe richieste](../api/http.html#429). 

Le versioni recenti delle librerie client supportate (per linguaggi [Java](../libraries/supported.html#java),
[Node.js](../libraries/supported.html#node-js),
e [Python](../libraries/supported.html#python)) ti aiutano a gestire una risposta `429`.
Ad esempio,
la libreria Java genera
[`TooManyRequestsException`
![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://static.javadoc.io/com.cloudant/cloudant-client/2.5.1/com/cloudant/client/org/lightcouch/TooManyRequestsException.html){:new_window}.

Per impostazione predefinita,
le librerie client supportate non tentano automaticamente di ritentare una richiesta
quando viene ricevuta una risposta `429`.

Sarebbe meglio assicurarsi che la tua applicazione gestisca la risposta `429` correttamente.
Il motivo è che il numero di richiami è limitato;
superare regolarmente il numero di richieste è un forte segnale di passare
a una configurazione del piano diversa.

>   **Nota**: se stati utilizzando un'applicazione esistente,
    potrebbe non essere in grado di gestire una risposta `429`.
    Come parte della verifica della migrazione,
    controlla che la tua applicazione gestisca la risposta `429` correttamente.

In sintesi,
devi assicurarti che la tua applicazione possa gestire una risposta [`429`](../api/http.html#429) correttamente.

### Dimensione documento individuale massima

I dati vengono archiviati in {{site.data.keyword.cloudant_short_notm}} come [documenti JSON](../api/document.html).
Per i documenti in un servizio {{site.data.keyword.cloudant_short_notm}} in {{site.data.keyword.Bluemix_notm}},
la dimensione massima di un documento individuale è 1 MB.
Superare questo limite genera un errore [`413`](../api/http.html#413).

### Spazio disco incluso

Questo valore è la capacità di archiviazione inclusa nel piano.
Viene utilizzato sia per l'archiviazione degli indici che dei dati.

### Eccedenza disco 

Tutte le istanze del piano Lite e Standard sono monitorate per lo spazio disco utilizzato.
Se l'account utilizza più della quantità di archiviazione di cui è stato eseguito il provisioning nella tua configurazione del piano,
viene considerata 'overflow'.
L'overflow comporta che l'account viene addebitato al prezzo indicato per ogni ulteriore GB utilizzato oltre l'assegnazione del piano.

La quantità extra di denaro che devi pagare per l'utilizzo di ulteriore spazio disco viene fornita nel piano e denominata 'eccedenza'.
L'eccedenza viene calcolata su una base oraria.
Non è possibile superare lo spazio disco disponibile nel piano Lite.

Ad esempio,
presupponi che la tua istanza del piano Standard aumenti l'utilizzo del disco di 107 GB per mezza giornata (12 ore).
Questa modifica significa che la tua istanza ha causato un overflow di 87 GB in più rispetto all'assegnazione piano di 20 GB,
per 12 ore.
Quindi,
ti sarà addebitata un'eccedenza in base a 87 GB x 12 ore = 1044 GB ore di ulteriore spazio.

L'eccedenza viene calcolata utilizzando il numero massimo di ulteriori GB rispetto all'assegnazione del piano durante un'ora in particolare nel ciclo ci fatturazione.

### Un esempio di eccedenza utilizzata

Supponi di iniziare un mese di 30 giorni con un'istanza del servizio del piano Standard che utilizza 9 GB di archiviazione.
Successivamente,
la tua archiviazione aumenta a 21.5 GB per 15 minuti durante l'ora a partire dalle 02:00 del giorno 3.
L'istanza scende a 9.5 GB per i successivi 10 minuti dell'ora 02:00,
quindi aumenta a 108 GB per i successivi 25 minuti dell'ora 02:00.
Infine,
la tua istanza termina l'ora e per il resto del mese scende a 28 GB.

Questo modello significa che il numero massimo di ulteriori GB rispetto all'assegnazione del piano è stato 88 GB durante l'ora 2 del giorno 3.
Per l'ora 03:00 del giorno 3
e per il resto del mese,
la tua istanza ha utilizzato ulteriori 8 GB rispetto all'assegnazione del piano.

Pertanto,
per l'ora 02:00 del giorno 3,
ti sarà addebitata un'eccedenza basata su 88 GB x 1 ora = 88 GB ore.

Per l'ora 03:00 del giorno 3 fino alla fine del giorno 3,
ti sarà addebitata un'eccedenza basata su 8 GB x 21 ore = 168 GB ore.

Per l'ora 00:00 del giorno 4 fino alla fine del mese (di 30 giorni),
ti sarà addebitata un'eccedenza basata su 8 GB x 24 ore x 27 giorni = 5184 GB ore.

La fattura dell'eccedenza totale del mese si baserà su un totale di 88 + 168 + 5184 = 5440 GB ore.

## Ubicazioni

Per impostazione predefinita,
tutti i piani ad eccezione del dedicato si basano su cluster a più tenant.
Come parte della tua selezione del piano,
puoi scegliere tra le seguenti regioni di {{site.data.keyword.Bluemix_notm}} pubblico:

-   Stati Uniti Sud
-   Regno Unito
-   Sydney
-   Germania

## Sicurezza, crittografia e conformità

Tutti i piani vengono forniti sui server con la crittografia del disco
[a riposo
![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://en.wikipedia.org/wiki/Data_at_rest){:new_window}.
L'accesso viene crittografato su una connessione di rete utilizzando HTTPS.
Per ulteriori dettagli, consulta
[DBaaS Security ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://cloudant.com/product/cloudant-features/dbaas-security/){:new_window}.

I piani inoltre offrono
[Security Compliance Certification ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://cloudant.com/product/cloudant-features/cloudant-compliance/){:new_window}.
La conformità [HIPAA ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){:new_window}
richiede un [ambiente dedicato](#dedicated-plan),
per cui richiedere questo ambiente come parte del [processo di provisioning](#provisioning-a-cloudant-instance-on-bluemix).

## Elevata disponibilità, ripristino di emergenza e backup

Per fornire Elevata disponibilità (HA) e Ripristino di emergenza (DR) in un data center,
tutti i dati vengono archiviati in triplice copia in tre server fisici separati in un cluster.
Puoi eseguire il provisioning degli account in più data center,
quindi utilizzare la replica dei dati continua per fornire HA/DR ai data center.

Non viene seguito automaticamente il backup dei dati {{site.data.keyword.cloudant_short_notm}}.
Puoi richiedere l'abilitazione di una [funzione di backup incrementale](../guides/backup-guide.html)
o in alternativa implementare la tua propria soluzione utilizzando una delle varie tecniche possibili descritte
[qui
![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://developer.ibm.com/clouddataservices/2016/03/22/simple-couchdb-and-cloudant-backup/){:new_window}.

## Monitoraggio dell'utilizzo

Le informazioni sul tuo utilizzo sono disponibili nel pannello di utilizzo della scheda delle attività nel tuo dashboard {{site.data.keyword.cloudant_short_notm}}.

![Monitoraggio dell'utilizzo nel dashboard](../images/cloudant_usage.png).

I dettagli sono qui forniti,
e illustrano la tua [velocità effettiva](#throughput) corrente
e la quantità di [dati archiviati](#disk-space-included).

Il monitoraggio ti aiuta a riconoscere se una modifica al provisioning nel tuo piano potrebbe essere consigliabile.
Ad esempio,
se raggiungi frequentemente il numero massimo di ricerche database,
puoi quindi modificare il provisioning tramite il [Pannello del servizio](#servicetier) nella scheda Account del dashboard.

## Specifiche hardware

Tutti i piani ad eccezione del dedicato vengono implementati su cluster a più tenant.
Tutti i dati vengono archiviati in triplice copia,
in tre nodi fisici separati per l'elevata disponibilità e per il ripristino dati.

## Supporto

Il supporto per le istanze del servizio standard e dedicata è facoltativo.
Viene fornito acquistando "Supporto {{site.data.keyword.Bluemix_notm}} Standard".
Il supporto non è disponibile per il piano Lite.

È disponibile un calcolatore dei prezzi per il supporto {{site.data.keyword.Bluemix_notm}}
[qui
![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://console.ng.bluemix.net/?direct=classic/#/pricing/cloudOEPaneId=pricing&paneId=pricingSheet){:new_window}.
Le informazioni sui dettagli del supporto SLA (Service Level Agreement) sono disponibili
[qui
![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://www-03.ibm.com/software/sla/sladb.nsf/pdf/6606-08/$file/i126-6606-08_05-2016_en_US.pdf){:new_window}.

## Provisioning di un'istanza Cloudant su Bluemix

Puoi eseguire il provisioning di un'istanza {{site.data.keyword.cloudant_short_notm}} su {{site.data.keyword.Bluemix_notm}} in due modi:

-	Utilizzando il dashboard. È disponibile un'esercitazione che descrive il processo [qui](../tutorials/create_service.html).
-	Utilizzando lo strumento di comando Cloud Foundry. È disponibile un'esercitazione che descrive il processo [qui](../tutorials/create_service_cli.html).
