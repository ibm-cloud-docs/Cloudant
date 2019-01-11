---

copyright:
  years: 2015, 2018
lastupdated: "2018-10-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:tip: .tip}

<!-- Acrolinx: 2017-05-10 -->

# {{site.data.keyword.cloud_notm}} pubblico
{: #ibm-cloud-public}

{{site.data.keyword.cloudantfull}} pubblico è l'offerta più ricca di funzionalità di {{site.data.keyword.cloudant_short_notm}},
che riceve per prima gli aggiornamenti e le nuove funzioni. Il prezzo si basa
sui tuoi requisiti di capacità produttiva e di archiviazione, rendendolo adatto a qualsiasi
carico richiesto. 

Il [piano Lite](#lite-plan) gratuito include una quantità fissa di
capacità produttiva e dati per scopi di sviluppo e di valutazione. Il [piano Standard](#standard-plan) a pagamento offre capacità produttiva fornita e archiviazione
dati configurabili a un prezzo che si adatta al variare dei requisiti della tua
applicazione.  È inoltre disponibile un [piano Hardware dedicato](#dedicated-hardware-plan) per
una tariffa mensile aggiuntiva per l'esecuzione di una o più delle tue istanze del piano Standard
in un ambiente Hardware dedicato. Se viene eseguito il provisioning
di un'istanza del piano dedicato in un'Ubicazione US, puoi facoltativamente selezionare una configurazione conforme a [HIPAA ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){:new_window}.

La seguente tabella riepiloga la configurazione della capacità
produttiva fornita e dello spazio su
disco per il piano Lite ed alcuni esempi per il piano Standard:

<div id="maxtable"></div>

<table>

<tr>
<th id="capacity-config-plan">Piano</th><th id="lite">Lite</th><th id="standard" colspan='4'>Standard</th>
</tr>
<tr>
<th id="base-priceperhour" headers="capacity-config-plan">Prezzo di base (per ora)</td>
<td headers="lite base-priceperhour">$0,00</td>
<td headers="standard base-priceperhour" colspan='4'>Consulta <a href="../offerings/pricing.html#pricing" target="_blank">Dettagli dei prezzi <img src="../images/launch-glyph.svg" alt="Icona link esterno" title="Icona link esterno"></a>.</td>
</tr>
<tr>
<th id="provisionedthroughputcapacity-lookupspersecond" headers="capacity-config-plan">Capacità produttiva fornita (ricerche al secondo)</td>
<td headers="lite provisionedthroughputcapacity-lookupspersecond-lite">20</td>
<td headers="standard provisionedthroughputcapacity-lookupspersecond">100</td>
<td headers="standard provisionedthroughputcapacity-lookupspersecond">1.000</td>
<td headers="standard provisionedthroughputcapacity-lookupspersecond">5.000</td>
<td headers="standard provisionedthroughputcapacity-lookupspersecond">20.000</td>
</tr>
<tr>
<th id="provisionedthroughputcapacity-writespersecond" headers="capacity-config-plan">Capacità produttiva fornita (scritture al secondo)</td>
<td headers="lite provisionedthroughputcapacity-writespersecond">10</td>
<td headers="standard provisionedthroughputcapacity-writespersecond">50</td>
<td headers="standard provisionedthroughputcapacity-writespersecond">500</td>
<td headers="standard provisionedthroughputcapacity-writespersecond">2.500</td>
<td headers="standard provisionedthroughputcapacity-writespersecond">10.000</td>
</tr>
<tr>
<th id="provisionedthroughputcapacity-queriespersecond" headers="capacity-config-plan">Capacità produttiva fornita (query al secondo)</td>
<td headers="lite provisionedthroughputcapacity-queriespersecond">5</td>
<td headers="standard provisionedthroughputcapacity-queriespersecond">5</td>
<td headers="standard provisionedthroughputcapacity-queriespersecond">50</td>
<td headers="standard provisionedthroughputcapacity-queriespersecond">250</td>
<td headers="standard provisionedthroughputcapacity-queriespersecond">1.000</td>
</tr>
<tr>
<th id="diskspaceincluded" headers="capacity-config-plan">Spazio disco incluso</td>
<td headers="lite diskspaceincluded">1 GB</td>
<td headers="standard diskspaceincluded" colspan='4'>20 GB</td>
</tr>
<tr>
<th id="diskoveragepergbhour" headers="capacity-config-plan">Eccedenza disco (per GB/ora)</td>
<td headers="lite diskoveragepergbhour">Non disponibile</td>
<td headers="standard diskoveragepergbhour" colspan='4'>Consulta <a href="../offerings/pricing.html#pricing" target="_blank">Dettagli dei prezzi <img src="../images/launch-glyph.svg" alt="Icona link esterno" title="Icona link esterno"></a>.</td>
</tr>

</table>

## Piani
{: #plans}

Puoi selezionare quale piano utilizzare quando
[esegui il provisioning della tua istanza del servizio {{site.data.keyword.cloudant_short_notm}}](#provisioning-a-cloudant-nosql-db-instance-on-ibm-cloud).
Per impostazione predefinita,
è selezionato il [piano Lite](#lite-plan).

![{{site.data.keyword.cloudant_short_notm}} - Selezione del piano per l'istanza del servizio](../images/lite_pricing_plan.png)

### Piano Lite
{: #lite-plan}

Il piano Lite è gratuito ed è progettato per scopi di sviluppo e valutazione. Viene inclusa la funzionalità completa di {{site.data.keyword.cloudant_short_notm}} ma le istanze del piano Lite vengono fornite con una quantità fissa di archiviazione di dati e di capacità produttiva. La capacità produttiva fornita è fissa a 20 ricerche/secondo, 10 scritture/secondo e 5 query/secondo e l'archiviazione dei dati ha un limite massimo di 1 GB. 

L'utilizzo dell'archiviazione viene controllato giornalmente. Se superi il limite di archiviazione di 1 GB, le richieste all'istanza {{site.data.keyword.cloudant_short_notm}} ricevono
un codice di stato 402 con il messaggio di errore, "Account has exceeded its data usage quota. An upgrade to a paid plan is required".
Viene anche visualizzato un banner nel dashboard {{site.data.keyword.cloudant_short_notm}}. Puoi ancora leggere e eliminare i dati. Tuttavia, per scrivere nuovi dati, hai due opzioni. Puoi, come prima cosa, eseguire un upgrade a un [piano Standard](#standard-plan) a pagamento che rimuove la limitazione di scrittura immediatamente. In alternativa, puoi eliminare i dati in modo che la tua archiviazione totale scenda sotto il limite di 1 GB e attendere fino all'esecuzione del successivo controllo dell'archiviazione giornaliero perché la tua istanza consenta nuovamente le scritture. 

Se vuoi archiviare più di 1 GB di dati o poter ridimensionare la capacità produttiva fornita, passa al [piano Standard](#standard-plan).

Sei limitato a una singola istanza del piano {{site.data.keyword.cloudant_short_notm}} Lite per ogni account {{site.data.keyword.cloud_notm}}. Se già hai un'istanza del piano Lite, qualsiasi tentativo di creare una nuova istanza del piano Lite o di modificare un'istanza del piano Standard in un piano Lite restituisce il messaggio "You can only have one instance of a Lite plan per service. To create a new instance, either delete your existing Lite plan instance or select a paid plan".
{: tip}

### Piano Standard
{: #standard-plan}

Il piano {{site.data.keyword.cloudant_short_notm}} Standard è disponibile per tutti gli account {{site.data.keyword.cloud}} a pagamento, come pagamento a consumo o sottoscrizione, ed esegue il ridimensionamento per soddisfare le esigenze della tua applicazione. Il prezzo del piano Standard è basato su due fattori: la capacità produttiva fornita che viene assegnata e la quantità di dati archiviata nell'istanza. 

Il prezzo è su base oraria proporzionale con una capacità produttiva iniziale fornita di 100 ricerche/secondo, 50 scritture/secondo e 5 query/secondo equivalenti a un costo iniziale di USD $0,105/ora. Puoi commutare la capacità produttiva fornita a crescere o a decrescere in incrementi di 100 ricerche/secondo, 50 scritture/secondo e 5 query/secondo nel dashboard {{site.data.keyword.cloudant_short_notm}}. I costi sono calcolati per la capacità produttiva fornita assegnata e non sul volume di richieste misurato. Il piano Standard include 20 GB di archiviazione dati. Se archivi più di 20 GB,
ti viene addebitato un costo definito per GB per ora. 

Vedi il calcolatore del prezzo {{site.data.keyword.cloud_notm}} per il prezzo a diverse capacità e valute e le informazioni sui [prezzi](../offerings/pricing.html#pricing){:new_window} per degli esempi per la stima dei costi.

### Piano Hardware dedicato
{: #dedicated-hardware-plan}

Un'istanza del piano {{site.data.keyword.cloudant_short_notm}} Hardware dedicato è un ambiente {{site.data.keyword.cloudant_short_notm}} bare metal fornito per l'utilizzo esclusivo delle tue istanze del piano {{site.data.keyword.cloudant_short_notm}} Standard. Il provisioning di un ambiente del piano {{site.data.keyword.cloudant_short_notm}} Hardware dedicato può essere eseguito in qualsiasi [data center {{site.data.keyword.IBM}} ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/cloud-computing/bluemix/data-centers). Questo piano è necessario per
la conformità HIPAA e deve essere selezionato al momento del provisioning. Inoltre, gli utenti di un ambiente del piano {{site.data.keyword.cloudant_short_notm}} Hardware dedicato possono utilizzare l'inserimento in whitelist degli IP e le chiavi di crittografia gestite dai clienti BYOK (bring-your-own-key) con IBM Key Protect. 

Puoi eseguire il provisioning di una o più istanze del piano Standard e l'ambiente Hardware dedicato viene espanso o contratto come necessario in base alla capacità e ai dati utilizzati dalle istanze del piano Standard. Si tratta di un'opzione aggiuntiva al prezzo di consumo delle istanze del piano {{site.data.keyword.cloudant_short_notm}} Standard. La fatturazione è ripartita proporzionalmente quotidianamente e c'è una durata minima di 1 mese da addebitare per l'ambiente. Il provisioning di un piano {{site.data.keyword.cloudant_short_notm}} Hardware dedicato è asincrono e può impiegare 5-7 giorni lavorativi. Per creare un'istanza del piano {{site.data.keyword.cloudant_short_notm}} Hardware dedicato ed eseguire il provisioning di un'istanza del piano Standard su di essa, attieniti all'esercitazione [Creazione e utilizzo di un'istanza del piano {{site.data.keyword.cloudant_short_notm}} Hardware dedicato su {{site.data.keyword.cloud_notm}} ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](../tutorials/create_dedicated_hardware_plan.html#creating-and-leveraging-a-cloudant-dedicated-hardware-plan-instance-on-bluemix){:new_window}. 

Il piano Hardware dedicato non è disponibile per i clienti {{site.data.keyword.cloud_notm}} Dedicato. Il piano Hardware dedicato è disponibile solo per i clienti {{site.data.keyword.cloud_notm}} Pubblico.
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
Puoi selezionare il livello di provisioning che desideri utilizzare tramite la scheda Account del tuo dashboard dell'account {{site.data.keyword.cloudant_short_notm}}.

![Dashboard dell'account](../images/cloudant_capacity.png)

Per passare a una capacità produttiva differente, seleziona il provisioning che desideri e fai quindi clic su `Aggiorna`. Ti verrà richiesto di confermare la modifica e ti verrà ricordato che la modifica di
provisioning necessità di 24 per essere completata.

![Dashboard dell'account](../images/cloudant_capacity_change.png)

La dimensione dell'aumento di capacità è limitata a 10 unità (1000 ricerche/secondo, 500 scritture/secondo e 50 query/secondo) per ogni modifica. Le diminuzioni non sono limitate dal numero di unità. Qualsiasi variazione della capacità, sia nel caso di un aumento che in quello di una diminuzione, è limitata a una volta all'ora. Se hai bisogno di più capacità di quella disponibile nel dashboard {{site.data.keyword.cloudant_short_notm}}, contatta il [supporto {{site.data.keyword.cloudant_short_notm}} ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](mailto:support@cloudant.com){:new_window}.
{: tip}

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
puoi procedere a modificare il provisioning tramite il [Pannello del servizio](#servicetier) nella scheda Account del dashboard.

## Utilizzo dei dati
{: #data-usage}

### Spazio su disco incluso
{: #disk-space-included}

Questo valore è la capacità di archiviazione inclusa nel piano.
Viene utilizzato sia per l'archiviazione degli indici che dei dati.

### Eccedenza disco
{: #disk-overage}

Tutti i piani Standard e Lite includono lo spazio su disco, che viene utilizzato per i dati JSON, gli allegati e gli indici. Tutti i piani Standard e Lite sono monitorati per lo spazio su disco utilizzato. Quando utilizzi una quantità di dati superiore a quella assegnata dal piano, puoi prevedere che si applichino le condizioni descritte nella seguente tabella:

<table>

<tr>
<th id="disk-overage-plan">Piano</th><th id="description">Descrizione</th>
</tr>
<tr>
<th headers="standard-plan">Standard</td>
<td headers="description"><p>
<ul><li>Se l'account utilizza più della quantità di archiviazione assegnata nella tua configurazione del piano, viene considerato in 'overflow'.
L'overflow comporta che l'account viene addebitato al prezzo indicato per ogni ulteriore GB utilizzato oltre l'assegnazione del piano.</li>
<li>L'importo supplementare che devi pagare per utilizzare più spazio su disco di quanto ne venga fornito nel piano è detto 'eccedenza'. Un'eccedenza viene calcolata su una base oraria.</li></ul></p></td>
</tr>
<tr>
<th headers="lite-plan">Lite</td>
<td headers="description"><p>
<ul><li>L'utilizzo del disco ha un limite nel piano Lite. Una volta raggiunto il limite, non puoi scrivere nuovi dati. Per scrivere nuovi dati,
devi eseguire l'upgrade al piano Standard o eliminare i dati e attendere fino all'esecuzione del successivo controllo perché il tuo account venga riattivato.</p>
</li></ul></td>
</tr>
</table>

Ad esempio, presupponi che il tuo piano Standard aumenti l'utilizzo del disco di 107 GB per mezza giornata (12 ore). Questa modifica significa che la tua istanza ha causato un overflow di 87 GB in più rispetto all'assegnazione piano di 20 GB,
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
puoi scegliere tra le seguenti regioni di {{site.data.keyword.cloud_notm}} pubblico:

-   Stati Uniti Est
-   Stati Uniti Sud
-   Regno Unito
-   Sydney
-   Germania&Dagger;
-   Asia Pacifico Nord (Tokyo)

Le istanze del piano Hardware dedicato possono essere distribuite nella maggior parte delle
[ubicazioni di data center {{site.data.keyword.IBM_notm}} ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/cloud-computing/bluemix/data-centers).
Vedi il menu a discesa nel catalogo {{site.data.keyword.cloud_notm}} per un elenco aggiornato di ubicazioni disponibili.

&Dagger;Tutte le istanze {{site.data.keyword.cloudant_short_notm}} distribuite dalla regione Germania {{site.data.keyword.cloud_notm}} pubblica vengono distribuite in ambienti gestiti dall'UE. Agli account {{site.data.keyword.cloudant_short_notm}}
o alle chiavi API generati fuori da un ambiente gestito dall'UE non può essere concesso l'accesso a un'istanza {{site.data.keyword.cloudant_short_notm}} gestita dall'UE.

## Metodi di autenticazione
{: #authentication-methods}

 Si accede a {{site.data.keyword.cloudant_short_notm}} utilizzando un'API HTTPS. Dove l'endpoint API lo richiede, l'utente viene autenticato per ogni richiesta HTTPS che
{{site.data.keyword.cloudant_short_notm}} riceve. Durante il provisioning, i metodi di autenticazione disponibili includono 'Use both legacy credentials and IAM' o 'Use only IAM'. Per ulteriori informazioni, consulta la [guida IAM](../guides/iam.html){:new_window} oppure il [documento dell'API di autenticazione ](../api/authentication.html){:new_window} legacy.

Dopo il provisioning di un'istanza {{site.data.keyword.cloudant_short_notm}}, i dettagli dell'URL di connessione e dell'autorizzazione IAM sono disponibili quando si generano nuove credenziali nella scheda Credenziali del servizio del dashboard {{site.data.keyword.cloud_notm}}. Se hai scelto questa opzione durante il provisioning, sono inclusi anche il nome utente e la password {{site.data.keyword.cloudant_short_notm}} legacy.


## Alta disponibilità, ripristino di emergenza e backup
{: #high-availability-disaster-recovery-and-backup}

Per fornire alta disponibilità (HA) e ripristino di emergenza (DR) all'interno di un data center, tutti i dati
vengono archiviati in triplice copia in tre server fisici separati in un cluster. Puoi eseguire il provisioning degli account in più data center,
quindi utilizzare la replica dei dati continua per fornire HA/DR ai data center. Il backup dei dati {{site.data.keyword.cloudant_short_notm}} non viene eseguito automaticamente ma vengono forniti strumenti supportati per gestire i backup. Consulta la
[guida Ripristino di emergenza e backup ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://console.bluemix.net/docs/services/Cloudant/guides/disaster-recovery-and-backup.html#disaster-recovery-and-backup)
per esplorare tutte le considerazioni su HA, DR e backup per soddisfare i requisiti dell'applicazione. 

## Supporto
{: #support}

Il supporto per le istanze del servizio standard e dedicata è facoltativo.
Viene fornito acquistando il supporto standard *{{site.data.keyword.cloud_notm}}*. Il supporto non è disponibile per il piano Lite.

Per ulteriori informazioni sui piani di supporto, vedi i [piani di supporto standard {{site.data.keyword.cloud_notm}} ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/cloud/support#944376){:new_window}. Per ulteriori informazioni sul supporto, vedi la [guida di supporto {{site.data.keyword.IBM_notm}} ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/support/home/pages/support-guide/){:new_window}.

I sistemi di supporto utilizzati per {{site.data.keyword.cloudant_short_notm}} non offrono funzioni per la protezione del contenuto che contiene informazioni sanitarie, dati sanitari, informazioni sanitarie protette (in inglese PHI, Protected Health Information) o dati soggetti a ulteriori requisiti normativi. Pertanto, il cliente non deve immettere o fornire tali dati.
{: tip}

## Provisioning di un'istanza {{site.data.keyword.cloudant_short_notm}} su {{site.data.keyword.cloud_notm}}
{: #provisioning-a-cloudant-nosql-db-instance-on-ibm-cloud}

Puoi eseguire il provisioning di un'istanza del piano Lite o Standard {{site.data.keyword.cloudant_short_notm}} su {{site.data.keyword.cloud_notm}} in due modi:

- Utilizzando il dashboard. Un'esercitazione che descrive il processo è disponibile [qui ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://console.bluemix.net/docs/services/Cloudant/tutorials/create_service.html#creating-a-cloudant-instance-on-bluemix){:new_window}.
- Utilizzando lo strumento di comando Cloud Foundry. Un'esercitazione che descrive il processo è disponibile [qui ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://console.bluemix.net/docs/services/Cloudant/tutorials/create_service_cli.html#creating-a-cloudant-instance-on-bluemix-using-the-cloud-foundry-tools){:new_window}.
 
Per creare, e avvalerti di, un'istanza del piano hardware {{site.data.keyword.cloudant_short_notm}} dedicato, segui l'esercitazione che descrive il processo [qui ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://console.bluemix.net/docs/services/Cloudant/tutorials/create_dedicated_hardware_plan.html#creating-and-leveraging-a-cloudant-dedicated-hardware-plan-instance-on-bluemix){:new_window}.




