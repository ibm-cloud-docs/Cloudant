---

copyright:
  years: 2015, 2018
lastupdated: "2018-06-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2018-06-05 -->

# {{site.data.keyword.Bluemix_notm}} pubblico
{: #ibm-cloud-public}

{{site.data.keyword.cloudantfull}} pubblico è l'offerta più ricca di funzionalità di {{site.data.keyword.cloudant_short_notm}},
che riceve per prima gli aggiornamenti e le nuove funzioni. Il prezzo si basa
sui tuoi requisiti di capacità produttiva e di archiviazione, rendendolo adatto a qualsiasi
carico richiesto. 

Il [piano Lite](#lite-plan) gratuito include una quantità fissa di
capacità produttiva e dati per scopi di sviluppo e di valutazione. Il [piano Standard](#standard-plan) a pagamento offre capacità produttiva fornita e archiviazione
dati configurabili a un prezzo che si adatta al variare dei requisiti della tua
applicazione. È inoltre disponibile un [piano hardware dedicato](#dedicated-hardware-plan) con
una tariffa mensile aggiuntiva per l'esecuzione di una o più delle tue istanze del piano Standard
in un ambiente hardware dedicato. Se viene eseguito il provisioning
di un'istanza del piano dedicato in un'Ubicazione US, puoi facoltativamente selezionare una configurazione conforme a [HIPAA ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){:new_window}.

La seguente tabella riepiloga la configurazione della capacità
produttiva fornita e dello spazio su
disco per il piano Lite ed alcuni esempi per il piano Standard:

<div id="maxtable"></div>

<table border='1'>

<tr>
<th id="plans">Piani</th><th id="lite">Lite</th><th id="standard" colspan='4'>Standard</th>
</tr>
<tr>
<th id="base-priceperhour" headers="plans">Prezzo di base (per ora)</td>
<td headers="lite base-priceperhour">$0,00</td>
<td headers="standard base-priceperhour" colspan='4'>Consulta <a href="../offerings/pricing.html#pricing" target="_blank">Dettagli dei prezzi <img src="../images/launch-glyph.svg" alt="Icona link esterno" title="Icona link esterno"></a>.</td>
</tr>
<tr>
<th id="provisionedthroughputcapacity-lookupspersecond" headers="plans">Capacità produttiva fornita (ricerche al secondo)</td>
<td headers="lite provisionedthroughputcapacity-lookupspersecond-lite">20</td>
<td headers="standard provisionedthroughputcapacity-lookupspersecond">100</td>
<td headers="standard provisionedthroughputcapacity-lookupspersecond">1.000</td>
<td headers="standard provisionedthroughputcapacity-lookupspersecond">5.000</td>
<td headers="standard provisionedthroughputcapacity-lookupspersecond">20.000</td>
</tr>
<tr>
<th id="provisionedthroughputcapacity-writespersecond" headers="plans">Capacità produttiva fornita (scritture al secondo)</td>
<td headers="lite provisionedthroughputcapacity-writespersecond">10</td>
<td headers="standard provisionedthroughputcapacity-writespersecond">50</td>
<td headers="standard provisionedthroughputcapacity-writespersecond">500</td>
<td headers="standard provisionedthroughputcapacity-writespersecond">2.500</td>
<td headers="standard provisionedthroughputcapacity-writespersecond">10.000</td>
</tr>
<tr>
<th id="provisionedthroughputcapacity-queriespersecond" headers="plans">Capacità produttiva fornita (query al secondo)</td>
<td headers="lite provisionedthroughputcapacity-queriespersecond">5</td>
<td headers="standard provisionedthroughputcapacity-queriespersecond">5</td>
<td headers="standard provisionedthroughputcapacity-queriespersecond">50</td>
<td headers="standard provisionedthroughputcapacity-queriespersecond">250</td>
<td headers="standard provisionedthroughputcapacity-queriespersecond">1.000</td>
</tr>
<tr>
<th headers="diskspaceincluded" headers="plans">Spazio disco incluso</td>
<td headers="lite diskspaceincluded">1 GB</td>
<td headers="standard diskspaceincluded" colspan='4'>20 GB</td>
</tr>
<tr>
<th headers="diskoveragepergbhour" headers="plans">Eccedenza disco (per GB/ora)</td>
<td headers="lite diskoveragepergbhour">Non disponibile</td>
<td headers="standard diskoveragepergbhour" colspan='4'>Consulta <a href="../offerings/pricing.html#pricing" target="_blank">Dettagli dei prezzi <img src="../images/launch-glyph.svg" alt="Icona link esterno" title="Icona link esterno"></a>.</td>
</tr>

</table>

## Piani
{: #plans}

Puoi selezionare quale piano utilizzare quando
[esegui il provisioning della tua istanza del servizio {{site.data.keyword.cloudant_short_notm}}](#provisioning-a-cloudant-instance-on-bluemix).
Per impostazione predefinita,
è selezionato il [piano Lite](#lite-plan).

![{{site.data.keyword.cloudant_short_notm}} - Selezione del piano per l'istanza del servizio](../images/fb87416a.png)

### Piano Lite
{: #lite-plan}

Il piano Lite è gratuito
ma ti limita a 1 GB di archiviazione dati.
Sono inoltre applicati dei limiti alla capacità produttiva fornita per le ricerche,
le scritture e le query. 

L'utilizzo dell'archiviazione viene controllato giornalmente. Se superi il tuo limite di archiviazione, le richieste HTTP all'account ricevono
un codice di stato 402 con il messaggio di errore, "L'account ha superato la propria quota di utilizzo dati. È necessario un aggiornamento a un piano a pagamento."
Per informarti, viene inoltre visualizzato un banner nel dashboard {{site.data.keyword.cloudant_short_notm}}. Puoi ancora leggere e eliminare i dati. Tuttavia, per scrivere nuovi dati,
devi eseguire l'aggiornamento a un piano a pagamento o eliminare i dati e attendere fino al successivo controllo sul tuo account per essere riattivato. 

Se desideri archiviare più di un GB di dati o
hai una capacità produttiva maggiore,
passa al [piano Standard](#standard-plan).

### Piano Standard
{: #standard-plan}

Il piano Standard include 20 GB di archiviazione dati.
Se archivi più di 20 GB,
ti viene addebitato un costo definito per GB per ora.
Consulta le informazioni sui [prezzi](../offerings/pricing.html#pricing){:new_window} per il costo attuale.
Nel piano Standard,
puoi anche modificare la capacità produttiva fornita per le ricerche,
le scritture e le query.

### Piano hardware dedicato
{: #dedicated-hardware-plan}

In alternativa, puoi eseguire le tue istanze del piano Standard su un ambiente hardware dedicato in
qualsiasi [data center {{site.data.keyword.IBM}} ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/cloud-computing/bluemix/data-centers)
a una tariffa mensile. Acquisti un unico piano hardware dedicato per una specifica ubicazione
in cui eseguire il provisioning di una o più istanze del piano Standard. Questo piano è necessario per
la conformità HIPAA e deve essere selezionato al momento del provisioning. 

Il piano hardware dedicato non è disponibile per gli utenti di {{site.data.keyword.Bluemix_notm}} dedicato, ma è disponibile solo per gli utenti di {{site.data.keyword.Bluemix_notm}} pubblico.
{: tip}

## Capacità produttiva fornita
{: #provisioned-throughput-capacity}

Il provisioning di capacità produttiva viene identificato e misurato come uno dei seguenti tipi di eventi:

1.	Una ricerca,
    che consiste di una lettura di un documento specifico,
    in base a `_id` del documento.
2.	Una scrittura,
    che consiste di una creazione,
    una modifica o
    un'eliminazione di un documento individuale
    o di una qualsiasi modifica a causa di una creazione dell'indice.
3.	Una query,
    che consiste in una richiesta effettuata a uno degli endpoint di query {{site.data.keyword.cloudant_short_notm}},
    inclusi i seguenti tipi:
	-	Indice primario ([`_all_docs`](../api/database.html#get-documents))
	-	Vista MapReduce ([`_view`](../api/creating_views.html#using-views))
	-	Indice di ricerca ([`_search`](../api/search.html#queries))
	-	Indice geospaziale ([`_geo`](../api/cloudant-geo.html#querying-a-cloudant-geo-index))
	-	Query {{site.data.keyword.cloudant_short_notm}} ([`_find`](../api/cloudant_query.html#finding-documents-using-an-index))

La misurazione della capacità produttiva è un conteggio semplice del numero di eventi di ogni tipo,
al secondo,
in cui il secondo è una finestra _temporale scorrevole_.
Se il tuo account supera il numero di eventi di capacità produttiva di cui è stato eseguito il provisioning per il piano,
le richieste vengono rifiutate finché il numero di eventi nella finestra temporale scorrevole
non supererà più il numero di provisioning.
Potrebbe essere utile pensare alla finestra temporale scorrevole di 1 secondo come a un periodo consecutivo di 1.000 millisecondi.

Ad esempio, il piano Standard ha un provisioning per 200 ricerche al secondo. Il tuo account può eseguire un massimo di 200 richieste di ricerca durante un periodo consecutivo di 1.000 millisecondi (1 secondo). Le seguenti richieste di ricerca effettuate durante il periodo di 1.000 secondi della finestra temporale di scorrimento,
vengono rifiutate finché il numero di richieste di ricerca scende nuovamente a meno di 200.

Quando una richiesta viene rifiutata perché il numero di eventi viene superato,
le applicazioni ricevono una risposta [`429` Too Many
Requests](../api/http.html#429)

Le versioni recenti delle librerie client supportate (per linguaggi [Java](../libraries/supported.html#java),
[Node.js](../libraries/supported.html#node-js),
e [Python](../libraries/supported.html#python)) ti aiutano a gestire una risposta `429`.
Ad esempio, la libreria Java genera una risposta [`TooManyRequestsException` ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://static.javadoc.io/com.cloudant/cloudant-client/2.5.1/com/cloudant/client/org/lightcouch/TooManyRequestsException.html){:new_window}.

Per impostazione predefinita,
le librerie client supportate non tentano automaticamente di ritentare una richiesta
quando viene ricevuta una risposta `429`.

Sarebbe meglio assicurarsi che la tua applicazione gestisca la risposta `429` correttamente.
Il motivo è che il numero di richiami è limitato;
superare regolarmente il numero di richieste è un forte segnale di passare
a una configurazione del piano diversa.

Se stai trasferendo un'applicazione esistente, potrebbe non essere in grado di gestire una risposta `429`. Come parte della verifica della migrazione,
    controlla che la tua applicazione gestisca la risposta `429` correttamente.
{: tip}

In sintesi,devi assicurarti che la tua applicazione possa gestire una risposta [`429`](../api/http.html#429) correttamente.

<div id="servicetier"></div>

### Visualizzazione e modifica della capacità
{: #viewing-and-changing-capacity}

Puoi visualizzare i dettagli della capacità produttiva nei piani disponibili per il tuo account.
Puoi selezionare il livello di provisioning che desideri utilizzare,
tramite la scheda Account del tuo dashboard dell'account {{site.data.keyword.cloudant_short_notm}}.

![Dashboard account](../images/cloudant_capacity.png)

Per passare a una capacità produttiva differente, seleziona il provisioning che desideri e fai quindi clic su `Aggiorna`. Ti verrà richiesto di confermare la modifica e ti verrà ricordato che la modifica di
provisioning necessità di 24 per essere completata.

![Dashboard account](../images/cloudant_capacity_change.png)

<div id="throughput"></div>

### Monitoraggio dell'utilizzo 
{: #monitoring-usage}

Le informazioni sul tuo utilizzo sono disponibili nel riquadro Operazioni correnti della scheda Monitoraggio nel tuo dashboard {{site.data.keyword.cloudant_short_notm}}. 

![Monitoraggio dell'utilizzo nel dashboard](../images/cloudant_usage.png)

I dettagli sono qui forniti,
e illustrano la tua [capacità produttiva](#provisioned-throughput-capacity) corrente
e la quantità di [dati archiviati](#disk-space-included).

Il monitoraggio ti aiuta a riconoscere se una modifica al provisioning nel tuo piano potrebbe essere consigliabile.
Ad esempio,
se raggiungi frequentemente il numero massimo di ricerche database,
puoi quindi modificare il provisioning tramite il [Pannello del servizio](#servicetier) nella scheda Account del dashboard.

## Utilizzo dei dati
{: #data-usage}

### Spazio su disco incluso
{: #disk-space-included}

Questo valore è la capacità di archiviazione inclusa nel piano.
Viene utilizzato sia per l'archiviazione degli indici che dei dati.

### Eccedenza disco
{: #disk-overage}

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

### Esempio di eccedenza del disco
{: #disk-overage-example}

Supponi di iniziare un mese di 30 giorni con un'istanza del servizio del piano Standard che utilizza 9 GB di archiviazione.
Successivamente,
la tua archiviazione aumenta a 21.5 GB per 15 minuti durante l'ora a partire dalle 02:00 del giorno 3.
L'istanza scende a 9.5 GB per i successivi 10 minuti dell'ora 02:00,
quindi aumenta a 108 GB per i successivi 25 minuti dell'ora 02:00.
Infine,
la tua istanza termina l'ora e il resto del mese scendendo a 28 GB.

Questo modello significa che il numero massimo di ulteriori GB rispetto all'assegnazione del piano è stato 88 GB durante l'ora 2 del giorno 3.
Per l'ora 03:00 del giorno 3
e per il resto del mese,
la tua istanza ha utilizzato ulteriori 8 GB rispetto all'assegnazione del piano.

Pertanto,
per l'ora 02:00 del giorno 3,
la tua fattura include un'eccedenza basata su 88 GB x 1 ora = 88 GB ore.

Per l'ora 03:00 del giorno 3 fino alla fine del giorno 3,
la tua fattura include un'eccedenza basata su 8 GB x 21 ore = 168 GB ore.

Per l'ora 00:00 del giorno 4 fino alla fine del mese (di 30 giorni),
la tua fattura include un'eccedenza basata su 8 GB x 24 ore x 27 giorni = 5184 GB ore.

La fattura dell'eccedenza totale del mese è basata su un totale di 88 + 168 + 5184 = 5440 GB ore.

## Limiti di dimensione di richieste e documenti
{: #request-and-document-size-limits}

Le richieste e i documenti JSON {{site.data.keyword.cloudant_short_notm}} hanno i seguenti limiti di dimensione massima: 

Limite | Dimensione massima
------|-------------
Dimensione documento singolo | 1 MB
Dimensione allegato singolo | 10 MB
Dimensione corpo della richiesta | 11 MB

Superare uno di questi limiti determina una [risposta 413](../api/http.html#413).

Si consiglia di archiviare gli allegati binari, o blob JSON di grandi dimensioni, nell'archivio oggetti e di salvare un link all'ubicazione in un documento JSON {{site.data.keyword.cloudant_short_notm}}.   

Quando esegui una replica, dei documenti o degli allegati di dimensioni superiori a questi limiti non viene eseguita la replica nel database di destinazione. Ulteriori informazioni su come rilevare errori di replica sono disponibili [qui](../api/replication.html#replication-errors).

## Ubicazioni e locazione
{: #locations-and-tenancy}

Per impostazione predefinita, tutti i piani Lite e Standard vengono distribuiti in ambienti a
più tenant. Come parte della tua selezione del piano,
puoi scegliere tra le seguenti regioni di {{site.data.keyword.Bluemix_notm}} pubblico:

-   Stati Uniti Est
-   Stati Uniti Sud
-   Regno Unito
-   Sydney
-   Germania&Dagger;

Le istanze del piano hardware dedicato possono essere distribuite nella maggior parte delle
[ubicazioni di data center {{site.data.keyword.IBM_notm}} ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/cloud-computing/bluemix/data-centers). 
Vedi il menu a discesa nel catalogo {{site.data.keyword.Bluemix_notm}} per un elenco aggiornato di ubicazioni disponibili.

&Dagger;Tutte le istanze {{site.data.keyword.cloudant_short_notm}} distribuite dalla regione Germania {{site.data.keyword.Bluemix_notm}} pubblica vengono distribuite in ambienti gestiti dall'UE. Agli account {{site.data.keyword.cloudant_short_notm}}
o alle chiavi API generati fuori da un ambiente gestito dall'UE non può essere concesso l'accesso a un'istanza {{site.data.keyword.cloudant_short_notm}} gestita dall'UE.

## Sicurezza, crittografia e conformità
{: #security-encryption-and-compliance}

Tutti i piani vengono forniti sui server con la crittografia del disco
[a riposo
![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://en.wikipedia.org/wiki/Data_at_rest){:new_window}.
L'accesso viene crittografato su una connessione di rete utilizzando HTTPS.
Per ulteriori dettagli,
vedi [Sicurezza {{site.data.keyword.Bluemix_notm}} ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://console.bluemix.net/docs/services/Cloudant/offerings/security.html#security){:new_window}.

I piani inoltre offrono
[Security Compliance Certification ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://cloudant.com/product/cloudant-features/cloudant-compliance/){:new_window}.
La conformità [HIPAA ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){:new_window}
richiede un [ambiente dedicato](#dedicated-hardware-plan),
per cui richiedere questo ambiente come parte del [processo di provisioning](#provisioning-a-cloudant-instance-on-bluemix).

<div id="byok"></div>

Se hai bisogno di BYOK (bring-your-own-key) per la crittografia dei dati inattivi, questa crittografia viene abilitata tramite {{site.data.keyword.cloud}} Key
Protect. {{site.data.keyword.cloudant_short_notm}} supporta questa funzione per le nuove istanze {{site.data.keyword.cloudant_short_notm}}
[Piano hardware dedicato](https://console.bluemix.net/docs/services/Cloudant/offerings/bluemix.html#ibm-cloud-public)
distribuite in tutte le regioni. Innanzitutto, crea un'istanza del piano hardware dedicato tramite il [catalogo {{site.data.keyword.cloud_notm}}](https://console.bluemix.net/catalog/). Inoltra quindi un ticket di supporto; il nostro team di supporto coordina l'ottenimento delle chiavi di crittografia dei dati inattivi della tua istanza di hardware dedicato che sono gestite tramite la tua istanza Key Protect.

## Alta disponibilità, ripristino di emergenza e backup
{: #high-availability-disaster-recovery-and-backup}

Per fornire alta disponibilità (HA) e ripristino di emergenza (DR) all'interno di un data center, tutti i dati
vengono archiviati in triplice copia in tre server fisici separati in un cluster. Puoi eseguire il provisioning degli account in più data center,
quindi utilizzare la replica dei dati continua per fornire HA/DR ai data center. Non viene eseguito automaticamente il backup dei dati {{site.data.keyword.cloudant_short_notm}}, ma sono forniti degli strumenti supportati  
per gestire i backup. Consulta la
[guida Ripristino di emergenza e backup ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://console.bluemix.net/docs/services/Cloudant/guides/disaster-recovery-and-backup.html#disaster-recovery-and-backup)
per esplorare tutte le considerazioni su HA, DR e backup per soddisfare i requisiti dell'applicazione. 

## Supporto
{: #support}

Il supporto per le istanze del servizio standard e dedicata è facoltativo.
Viene fornito acquistando "Supporto {{site.data.keyword.Bluemix}} Standard".
Il supporto non è disponibile per il piano Lite.

È disponibile un calcolatore dei prezzi per il supporto {{site.data.keyword.Bluemix_notm}}
[qui
![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://console.ng.bluemix.net/?direct=classic/#/pricing/cloudOEPaneId=pricing&paneId=pricingSheet){:new_window}.
Le informazioni sui dettagli del supporto SLA (Service Level Agreement) sono disponibili
[qui
![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://www-03.ibm.com/software/sla/sladb.nsf/pdf/6606-08/$file/i126-6606-08_05-2016_en_US.pdf){:new_window}.

## Provisioning di un'istanza {{site.data.keyword.cloudant_short_notm}} su {{site.data.keyword.Bluemix_notm}}
{: #provisioning-a-cloudant-nosql-db-instance-on-ibm-cloud}

Puoi eseguire il provisioning di un'istanza del piano Lite o Standard {{site.data.keyword.cloudant_short_notm}} su {{site.data.keyword.Bluemix}} in due modi:

- Utilizzando il dashboard. Un'esercitazione che descrive il processo è disponibile [qui ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://console.bluemix.net/docs/services/Cloudant/tutorials/create_service.html#creating-a-cloudant-instance-on-bluemix){:new_window}.
- Utilizzando lo strumento di comando Cloud Foundry. Un'esercitazione che descrive il processo è disponibile [qui ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://console.bluemix.net/docs/services/Cloudant/tutorials/create_service_cli.html#creating-a-cloudant-instance-on-bluemix-using-the-cloud-foundry-tools){:new_window}.
 
Per creare, e avvalerti di, un'istanza del piano hardware {{site.data.keyword.cloudant_short_notm}} dedicato, segui l'esercitazione che descrive il processo [qui ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://console.bluemix.net/docs/services/Cloudant/tutorials/create_dedicated_hardware_plan.html#creating-and-leveraging-a-cloudant-dedicated-hardware-plan-instance-on-bluemix){:new_window}.




