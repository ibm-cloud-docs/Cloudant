---

copyright:
  years: 2015, 2018
lastupdated: "2018-03-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# Data Warehousing

## Deprecazione della funzione {{site.data.keyword.dashdbshort_notm}} di {{site.data.keyword.cloudant_short_notm}} (7 febbraio 2018)
{: #deprecating-cloudant-nosql-db-s-db2-warehouse-on-cloud-feature-february-7-2018-}

La funzione {{site.data.keyword.dashdblong}} di {{site.data.keyword.cloudantfull}} è obsoleta e verrà ritirata in base al calendario riportato di seguito. I dati
non verranno rimossi dai sistemi, ma la sincronizzazione verrà interrotta. 

Data di deprecazione | Elementi obsoleti
-----------------|--------------------------
16 gennaio 2018 | La scheda Warehouse è disponibile solo per le istanze del servizio {{site.data.keyword.cloudant_short_notm}} che hanno già creato dei lavori {{site.data.keyword.dashdbshort_notm}} nella scheda Warehouse.  Se non hai creato un lavoro {{site.data.keyword.dashdbshort_notm}}, non sarai in grado di accedere a questa funzione.
31 marzo 2018   | I clienti che hanno iniziato a utilizzare la funzionalità di {{site.data.keyword.dashdbshort_notm}} prima del 16 gennaio, non potranno creare nuovi lavori {{site.data.keyword.dashdbshort_notm}}.
5 maggio 2018   | I lavori {{site.data.keyword.dashdbshort_notm}} esistenti verranno interrotti. Lo stato finale può ancora essere visualizzato sul dashboard.
31 maggio 2018  | Rimozione dell'interfaccia utente per la funzione {{site.data.keyword.dashdbshort_notm}}. Lo stato dei lavori {{site.data.keyword.dashdbshort_notm}} non sarà più disponibile.
 
I dati trasferiti a {{site.data.keyword.dashdbshort_notm}} entro il 30 aprile 2018 rimarranno in {{site.data.keyword.dashdbshort_notm}} e anche i dati di {{site.data.keyword.cloudant_short_notm}} non saranno interessati.

### Alternative alla funzione {{site.data.keyword.dashdbshort_notm}}

Vedi il
[repository data-flow-examples ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant-labs/data-flow-examples){:new_window}
per esercitazioni su come estrarre
documenti {{site.data.keyword.cloudant_short_notm}} e scrivere i dati in una
tabella {{site.data.keyword.dashdbshort_notm}}.


## Panoramica del data warehousing

Un database è essenziale per la memorizzazione dei dati.
Ma ciò che rende valido un database è la capacità di applicare tali dati per finalità commerciali:
la capacità di recuperare dati rilevanti,
in modo rapido e semplice,
e di rendere i dati funzionali all'interno delle tue applicazioni.
{:shortdesc}

Ma molte delle attività di archiviazione,
elaborazione e
analisi che esegui con i dati vengono utilizzate ripetutamente nelle tue applicazioni.
Oppure potrebbero essere dei buoni esempi di procedure ottimali del settore.

Pertanto,
è opportuno estendere le funzionalità del database standard con funzioni aggiuntive,
supportando attività come il reporting
o l'analisi.

Per circa 30 anni,
i 'Data Warehouse' sono stati lo standard di settore per l'archiviazione dei dati,
il reporting e
l'analisi,
basati sulla tecnologia del database relazionale.
In generale,
un [data warehouse è ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://en.wikipedia.org/wiki/Data_warehouse){:new_window}:
"... un repository centrale di dati integrati da una o più origini.
Memorizza dati attuali e cronologici.
Può essere utilizzato per eseguire l'analisi e creare i report per i lavoratori della conoscenza all'interno dell'azienda.

Le tecnologie che consentono l'archiviazione dei dati,
il reporting
e l'analisi sono emerse negli ultimi anni come risposta alla necessità di
elaborare i [Big Data ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://en.wikipedia.org/wiki/Big_data){:new_window}':
"Big data è un termine per indicare una raccolta di insiemi di dati così grande e complessa
da non poter essere elaborata con le tradizionali applicazioni di analisi dei dati".

Allo stesso tempo,
le proprietà e le caratteristiche dei data warehouse e dei prodotti correlati
indicano che l'utilizzo della tecnologia del database relazionale per abilitare i data warehouse è una scelta popolare,
anche per le attività dei big data.

Esistono molti casi di utilizzo che illustrano bene i vantaggi
dell'integrazione delle funzionalità di {{site.data.keyword.cloudant_short_notm}} con un data warehouse relazionale,
come i seguenti esempi.

## Questa integrazione è adatta al mio caso di utilizzo?

L'integrazione di warehousing di {{site.data.keyword.cloudant_short_notm}} è un processo semplificato che rileva
automaticamente gli schemi dei tuoi documenti e importa i dati in modo
intelligente in {{site.data.keyword.dashdbshort_notm}} o {{site.data.keyword.Db2_on_Cloud_short}}. Quando crei
un warehouse su {{site.data.keyword.cloudant_short_notm}}, lo schema viene prima rilevato automaticamente, quindi i dati
vengono importati nel database {{site.data.keyword.dashdbshort_notm}} connesso. 

L'integrazione è adatta quando i tuoi dati hanno le seguenti caratteristiche:

* Hanno un insieme di schemi prevalentemente statici. Uno schema modificato richiede il
    riavvio del warehouse, che reimporta i tuoi dati da zero.
* Gli schemi possono essere rilevati eseguendo la scansione di alcuni documenti, fino a
    poche decine di migliaia. Una volta che gli schemi sono stati rilevati, milioni
    di documenti possono sicuramente essere importati nel tuo warehouse.
* Il warehousing non deve essere rigorosamente in tempo reale. I documenti aggiornati
    vengono in genere visualizzati in un warehouse in pochi secondi, ma questo non è
    garantito e varierà in base al carico del tuo database.
* {{site.data.keyword.Db2_on_Cloud_short}} limita gli schemi a 1.012 campi. I documenti JSON con un numero elevato
    di campi, inclusi oggetti nidificati e array di grandi dimensioni, possono superare questo limite.

## Unione dei dati

L'unione dei dati da più archivi dati per l'analisi in più domini
è un'attività che può essere eseguita in modo semplice ed efficiente utilizzando un data warehouse relazionale.

I dati provenienti da diverse origini vengono preparati e trasformati in un formato comune durante il caricamento di un data warehouse.
I record vengono memorizzati in tabelle
e sono disponibili operazioni per unire queste tabelle e consentire quindi l'analisi combinata.

L'esecuzione dell'unione in un data warehouse relazionale è particolarmente utile
se alcuni dei dati sono già disponibili nella rappresentazione relazionale,
come i dati master o i dati di riferimento.

## Flessibilità

I database {{site.data.keyword.cloudant_short_notm}} sono flessibili nella rappresentazione dei dati.
Ad esempio,
non impongono uno schema durante la lettura o la scrittura.

Al contrario,
è richiesto un modello ben definito e rigorosamente applicato per le attività di reporting e analisi.

Con i tuoi documenti disponibili nel warehouse relazionale puoi basare il tuo modello su un insieme fisso di definizioni della tabella.
Possono essere caricati solo i documenti che si adattano allo schema della tabella, mentre le violazioni vengono rifiutate.
Puoi preparare i tuoi modelli con dati consistenti utilizzando uno schema relazionale fisso.

## Asserzione di integrità dei dati

I Data Warehouse possono utilizzare dei vincoli per asserire l'integrità dei dati.
Ad esempio:

-   Due record non possono avere la stessa chiave primaria.
-   Le chiavi esterne garantiscono che i record siano completi.
-   Sono disponibili funzioni per convalidare i record con le regole di business.

Unicità,
correttezza
e completezza sono requisiti essenziali per qualsiasi servizio aziendale.
Il caricamento dei documenti {{site.data.keyword.cloudant_short_notm}} in un data warehouse ti consente di soddisfare questi requisiti.

## {{site.data.keyword.cloudant_short_notm}} e Data Warehousing

I Data Warehouse rappresentano una tecnologia evoluta e importante.
{{site.data.keyword.cloudant_short_notm}} fornisce una solida integrazione con i data warehouse relazionali,
offrendoti il vantaggio di questa tecnologia.

{{site.data.keyword.cloudant_short_notm}} ha una funzionalità di warehousing di base integrata,
sotto forma di [viste MapReduce](../api/using_views.html)
che ti consentono di eseguire una serie di attività analitiche di base.

Per attività di warehousing più avanzate,
puoi sfruttare tutte le funzionalità fornite dal
servizio di warehousing basato sul cloud di IBM [{{site.data.keyword.IBM}} {{site.data.keyword.dashdbshort_notm}} ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/analytics/us/en/data-management/data-warehouse/){:new_window}.

Quando utilizzi {{site.data.keyword.cloudant_short_notm}},
hai un accesso facile e integrato alle funzionalità di warehousing avanzate,
come ad esempio:

-   Visualizzazione dei tuoi dati JSON in un formato di database relazionale.
-   Esecuzione di query basate su SQL sui tuoi dati.
-   Creazione di analisi dai tuoi dati.

Queste funzionalità di warehousing avanzate sono abilitate attraverso servizi come {{site.data.keyword.dashdbshort_notm}},
che è un naturale complemento di {{site.data.keyword.cloudant_short_notm}}.

In alternativa,
se hai bisogno solo di un archivio dati relazionale per i tuoi documenti,
senza le funzionalità di warehousing,
puoi caricare i tuoi documenti {{site.data.keyword.cloudant_short_notm}} nel servizio [{{site.data.keyword.Db2_on_Cloud_short}}](#ibm-db2-on-cloud).

## {{site.data.keyword.dashdblong_notm}}

{{site.data.keyword.dashdbshort_notm}} è un servizio di data warehouse basato sul cloud,
progettato appositamente per il lavoro analitico.
Sebbene sia particolarmente adatto per i dati JSON {{site.data.keyword.cloudant_short_notm}},
{{site.data.keyword.dashdbshort_notm}} può accettare dati provenienti da una varietà di origini,
esaminando la struttura dei dati quando vengono caricati.

Per ulteriori informazioni,
consulta la [documentazione di {{site.data.keyword.dashdblong_notm}} ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/support/knowledgecenter/SS6NHC/com.ibm.swg.im.dashdb.kc.doc/welcome.html){:new_window}.

## {{site.data.keyword.Db2Hosted_notm}}

[{{site.data.keyword.Db2Hosted_full}} ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://console.ng.bluemix.net/catalog/services/ibm-db2-on-cloud){:new_window}
ti fornisce un database sull'infrastruttura cloud globale di IBM SoftLayer®.
Ti offre le piene funzionalità di una distribuzione Db2 in loco,
ma senza i costi,
la complessità
e i rischi di gestione della tua propria infrastruttura.

Per ulteriori informazioni, consulta la [documentazione di {{site.data.keyword.Db2Hosted_short}} ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://console.ng.bluemix.net/docs/services/DB2OnCloud/index.html#DB2OnCloud){:new_window}.

## Creazione di un warehouse

Puoi creare un warehouse in due modi:

1.  [Utilizza {{site.data.keyword.cloudant_short_notm}} per creare un warehouse {{site.data.keyword.dashdbshort_notm}}](#use-cloudant-to-create-a-db2-warehouse-on-cloud-warehouse)
2.  [Connetti {{site.data.keyword.cloudant_short_notm}} a un warehouse esistente](#connect-cloudant-to-an-existing-warehouse)

### Utilizza {{site.data.keyword.cloudant_short_notm}} per creare un warehouse {{site.data.keyword.dashdbshort_notm}}

Il metodo più semplice per creare un warehouse è che {{site.data.keyword.cloudant_short_notm}} crei un'istanza del warehouse {{site.data.keyword.dashdbshort_notm}} all'interno di {{site.data.keyword.Bluemix}}
per tuo conto.
A tale scopo, fai clic sul pulsante `Crea warehouse` sull'attività `Warehouse`
all'interno della scheda `Integrazioni` del tuo dashboard {{site.data.keyword.cloudant_short_notm}}.

![Schermata dell'attività "Crea un warehouse {{site.data.keyword.dashdbshort_notm}} " all'interno del dashboard {{site.data.keyword.cloudant_short_notm}}  ](../images/createDashDBWH.png)

Se non sei già connesso a {{site.data.keyword.Bluemix_notm}},
ti verrà chiesto di farlo.

>   **Nota**: per impostazione predefinita, {{site.data.keyword.cloudant_short_notm}} crea un'istanza di {{site.data.keyword.dashdbshort_notm}} su {{site.data.keyword.Bluemix_notm}} per il tuo warehouse.

![Schermata dell'attività "Autenticazione su {{site.data.keyword.Bluemix_notm}}" all'interno del dashboard {{site.data.keyword.cloudant_short_notm}}  ](../images/authenticateToBluemix.png)

Una volta autenticato,
puoi richiedere che venga creata una nuova istanza di {{site.data.keyword.dashdbshort_notm}} utilizzando il tuo account {{site.data.keyword.Bluemix_notm}}.

Per effettuare questa operazione:

1.  Fornisci il nome che vuoi utilizzare per il Warehouse nel campo `Nome Warehouse`.
2.  Fornisci il nome del tuo database esistente in {{site.data.keyword.cloudant_short_notm}}, nel campo `Origini dati`.
3.  Assicurati che l'opzione `Crea nuova istanza {{site.data.keyword.dashdbshort_notm}} ` sia selezionata nel modulo.
4.  Fai clic sul pulsante `Crea warehouse`.

![Schermata dell'attività "Crea warehouse" all'interno del dashboard {{site.data.keyword.cloudant_short_notm}}  ](../images/createWarehouse.png)

### Connetti {{site.data.keyword.cloudant_short_notm}} a un warehouse esistente

Invece di utilizzare {{site.data.keyword.cloudant_short_notm}} per creare il database warehouse {{site.data.keyword.dashdbshort_notm}},
puoi connetterti a un'istanza {{site.data.keyword.dashdbshort_notm}} esistente.

Il processo è simile all'[utilizzo di {{site.data.keyword.cloudant_short_notm}} per creare un warehouse {{site.data.keyword.dashdbshort_notm}} ](#use-cloudant-to-create-a-db2-warehouse-on-cloud-warehouse),
ma invece di selezionare l'opzione `Crea nuova istanza {{site.data.keyword.dashdbshort_notm}}`,
seleziona `Istanza del servizio {{site.data.keyword.dashdbshort_notm}} ` e scegli il warehouse {{site.data.keyword.dashdbshort_notm}} già esistente in {{site.data.keyword.Bluemix_notm}}.

![Schermata dell'attività "Connetti a un'istanza {{site.data.keyword.dashdbshort_notm}} esistente" all'interno del dashboard {{site.data.keyword.cloudant_short_notm}} ](../images/existingDashDBInstance.png)

### Utilizzo di un'istanza del warehouse {{site.data.keyword.Db2_on_Cloud_short}}

Se preferisci,
puoi connetterti a un'istanza esistente del warehouse {{site.data.keyword.Db2_on_Cloud_short}} invece di {{site.data.keyword.dashdbshort_notm}}.
Per eseguire questa operazione, seleziona l'opzione `DB2` nel tuo dashboard {{site.data.keyword.cloudant_short_notm}} per connetterti a un'istanza {{site.data.keyword.Db2_on_Cloud_short}} esistente.

![Schermata dell'attività Crea un warehouse {{site.data.keyword.Db2_on_Cloud_short}} " all'interno del dashboard {{site.data.keyword.cloudant_short_notm}} ](../images/createDB2WH.png)

Se vuoi connetterti a un'istanza {{site.data.keyword.Db2_on_Cloud_short}},
devi fornire i seguenti dettagli:

-   Indirizzo host
-   Numero porta
-   Nome database
-   ID utente per il database
-   Password per l'ID utente

>   **Nota**: il resto di questo argomento fa riferimento a {{site.data.keyword.dashdbshort_notm}} come istanza del warehouse.
    Tuttavia,
    l'argomento vale anche se utilizzi un'istanza di {{site.data.keyword.Db2_on_Cloud_short}}.
    È disponibile anche un'esercitazione che descrive come
    [caricare i dati JSON da {{site.data.keyword.cloudant_short_notm}} in {{site.data.keyword.dashdbshort_notm}} ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://developer.ibm.com/clouddataservices../dashdb/get/load-json-from-cloudant-database-in-to-dashdb/){:new_window}
    e include esempi di utilizzo di {{site.data.keyword.Db2_on_Cloud_short}} come database warehouse.

## Schema del warehouse

Quando crei per la prima volta un warehouse da {{site.data.keyword.cloudant_short_notm}},
{{site.data.keyword.dashdbshort_notm}} crea il miglior schema possibile per i dati presenti nel database
in modo da garantire che ciascuno dei campi contenuti nei tuoi documenti JSON abbia una voce corrispondente all'interno del nuovo schema.
Facoltativamente,
durante la creazione del warehouse,
puoi scegliere di [personalizzare lo schema](#customizing-the-warehouse-schema) manualmente.

Una volta creato lo schema,
il warehouse è in grado di mantenere i tuoi dati in un formato relazionale.
{{site.data.keyword.cloudant_short_notm}} quindi [replica](../api/replication.html) per eseguire
un 'carico iniziale' dei documenti del database nel warehouse,
fornendoti una raccolta operativa dei tuoi dati nel database relazionale {{site.data.keyword.dashdbshort_notm}}.

Con il tempo,
il contenuto del tuo database {{site.data.keyword.cloudant_short_notm}} potrebbe cambiare.
Puoi modificare lo schema di un warehouse esistente.

>   **Nota**: se modifichi lo schema di un warehouse esistente,
    i dati del tuo database {{site.data.keyword.cloudant_short_notm}} devono essere di nuovo replicati nel database warehouse.
    In effetti,
    la modifica dello schema provoca un nuovo 'carico iniziale' nel warehouse.

## Gestione del tuo warehouse

Con il warehousing di {{site.data.keyword.cloudant_short_notm}},
puoi eseguire query SQL 'tradizionali'
e visualizzare i risultati
dalla console {{site.data.keyword.dashdbshort_notm}}.


![Schermata di "{{site.data.keyword.dashdbshort_notm}} dashboard" in {{site.data.keyword.Bluemix_notm}}](../images/useDashDBdashboard.png)

Le applicazioni esterne possono interagire con i dati allo stesso modo di qualsiasi altro database relazionale.
Il vantaggio di {{site.data.keyword.dashdbshort_notm}} è che puoi eseguire altre attività di warehousing,
come caricare più dati da altre origini
e analizzare i dati mediante gli strumenti di analisi integrati.
{{site.data.keyword.dashdbshort_notm}} supporta il
[linguaggio di programmazione `'R'`![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://en.wikipedia.org/wiki/R_%28programming_language%29){:new_window}
e l'ambiente software per il calcolo statistico e la grafica.
Questo significa che hai accesso ad algoritmi che ti consentono di eseguire attività analitiche del database come la regressione lineare,
il clustering 'k-means'
e l'analisi geospaziale.

Lo strumento `RStudio` ti consente di creare script `'R'` che vengono caricati in {{site.data.keyword.dashdbshort_notm}}
e quindi eseguiti utilizzando i tuoi dati.

Per ulteriori informazioni sull'utilizzo di {{site.data.keyword.dashdbshort_notm}},
consulta la [documentazione di {{site.data.keyword.dashdblong_notm}} ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/support/knowledgecenter/SS6NHC/com.ibm.swg.im.dashdb.kc.doc/welcome.html){:new_window}.

## Aggiornamento costante dei dati e della struttura

I dati vengono caricati da {{site.data.keyword.cloudant_short_notm}} in {{site.data.keyword.dashdbshort_notm}} utilizzando un processo di [replica](../api/replication.html).
Ciò significa che se i tuoi dati {{site.data.keyword.cloudant_short_notm}} vengono aggiornati o modificati in qualche modo,
è necessario effettuare di nuovo la replica dei documenti in {{site.data.keyword.dashdbshort_notm}}
per garantire che le tue attività analitiche continuino a funzionare utilizzando le informazioni più aggiornate.

Come con la normale replica di {{site.data.keyword.cloudant_short_notm}},
i dati vengono trasferiti in modo unidirezionale:
per un warehouse il trasferimento è da {{site.data.keyword.cloudant_short_notm}} a {{site.data.keyword.dashdbshort_notm}}.
Dopo il carico iniziale dei dati,
il warehouse sottoscrive le modifiche del contenuto dei dati nel database {{site.data.keyword.cloudant_short_notm}}.
Tutte le modifiche vengono replicate dall'origine {{site.data.keyword.cloudant_short_notm}} alla destinazione {{site.data.keyword.dashdbshort_notm}}.
Ciò significa che il warehousing è una forma di replica continua da {{site.data.keyword.cloudant_short_notm}} a {{site.data.keyword.dashdbshort_notm}}.

Con il tempo,
il tuo database {{site.data.keyword.cloudant_short_notm}} potrebbe avere anche delle modifiche strutturali.
Queste includono l'aggiunta o la rimozione di campi dai documenti JSON.
Se questo accade,
lo schema utilizzato dal warehouse potrebbe non essere più valido,
causando errori segnalati quando i nuovi dati vengono replicati da {{site.data.keyword.cloudant_short_notm}} a {{site.data.keyword.dashdbshort_notm}}.

Per risolvere questo problema,
il warehousing di {{site.data.keyword.cloudant_short_notm}} ha una funzione di 'ripetizione della scansione'.
Questa funzione esegue di nuovo la scansione della struttura del database {{site.data.keyword.cloudant_short_notm}}
e determina il nuovo schema richiesto in {{site.data.keyword.dashdbshort_notm}}.
Le vecchie tabelle all'interno di {{site.data.keyword.dashdbshort_notm}} che erano state create durante la scansione precedente vengono quindi eliminate,
vengono create nuove tabelle utilizzando il nuovo schema
e infine i dati {{site.data.keyword.cloudant_short_notm}} correnti vengono caricati come nuovo 'carico iniziale'.

Per utilizzare la funzione di ripetizione della scansione,
per prima cosa assicurati che il tuo warehouse non sia in esecuzione.
Segui questa procedura:

1.  Seleziona la scheda `Integrazioni` all'interno del dashboard {{site.data.keyword.cloudant_short_notm}}.
2.  Individua il nome del Warehouse in cui ripetere la scansione nell'attività `Warehouse`:<br/>![Schermata della scheda "warehouse" all'interno del dashboard {{site.data.keyword.cloudant_short_notm}} ](../images/selectWarehouse.png)
3.  Fai clic sul nome del Warehouse.
    Questo è un link che,
    quando selezionato, apre la vista dei dettagli del warehouse:<br/>![Schermata della vista dei dettagli del warehouse all'interno del dashboard {{site.data.keyword.cloudant_short_notm}} ](../images/viewWarehouseDetail.png)
4.  Controlla lo stato corrente del warehouse.
    Un cerchio verde rotante indica che il warehouse è in esecuzione.
    Per arrestare il warehouse,
    fai clic sull'icona `Arresta database` nella colonna Azioni:<br/>![Schermata dell'icona "Arresta database warehouse" all'interno del dashboard {{site.data.keyword.cloudant_short_notm}} ](../images/stopWarehouseDatabase.png)
5.  Quando il database warehouse non è in esecuzione,
    l'icona `Ripeti scansione` nella colonna Azioni è abilitata:<br/>![Schermata dell'icona Ripeti scansione all'interno del dashboard {{site.data.keyword.cloudant_short_notm}} ](../images/rescanIcon.png)

### Ripetizione della scansione del database di origine

![Schermata della finestra che ti consente di ripetere la scansione del database di origine del warehouse.](../images/rescanSource.png)

Quando fai clic sull'icona `Ripeti scansione`,
hai due scelte:

-   Una scansione immediata del tuo database.
    Questa è l'azione predefinita
    ed è molto simile alla scansione iniziale del tuo database eseguita quando il warehouse è stato creato per la prima volta.
-   Personalizzare lo schema del warehouse.

Se scegli l'azione predefinita di ripetere una semplice scansione,
il tuo database di origine viene analizzato e viene generato un nuovo schema del database warehouse.
Una volta terminata la nuova scansione,
il warehouse viene avviato.

Se vuoi personalizzare lo schema del warehouse,
abilita la casella di spunta `Personalizza schema`
prima di fare clic sul pulsante `Ripeti scansione`.

![Schermata del pannello 'Ripeti scansione origine', che mostra l'opzione 'Personalizza schema' abilitata.](../images/rescanSource2.png)

La casella di spunta `Personalizza schema` abilita due opzioni.

1.  L'algoritmo di rilevamento utilizzato.
2.  La dimensione campione.

### Algoritmo di rilevamento

L'opzione predefinita per la ripetizione della scansione è l'algoritmo `Union`.
Questo utilizza tutti gli attributi in tutti i documenti del database {{site.data.keyword.cloudant_short_notm}} campionati
per creare un singolo insieme di tabelle nel database warehouse.
Il risultato è che tutti i documenti del database {{site.data.keyword.cloudant_short_notm}} possono essere memorizzati nel database warehouse,
ma alcune righe nel database potrebbero non avere contenuti in alcuni campi.

L'opzione alternativa per la ripetizione della scansione è l'algoritmo `Cluster`.
Questo identifica i documenti all'interno del database {{site.data.keyword.cloudant_short_notm}} che hanno lo stesso insieme di attributi,
quindi crea schemi di tabella del database warehouse corrispondenti.

### Dimensione campione

Questa opzione determina quanti documenti del database {{site.data.keyword.cloudant_short_notm}}
vengono analizzati come parte della determinazione dello schema.

Il valore predefinito è 10.000 documenti.

L'impostazione di un valore troppo basso introduce il rischio che alcuni documenti {{site.data.keyword.cloudant_short_notm}} abbiano degli attributi che non vengono rilevati
e vengono quindi omessi dalla struttura del database warehouse.

L'impostazione di un valore troppo alto indica che il completamento del processo di scansione
per determinare la struttura del database warehouse richiederà più tempo.

### Dopo la nuova scansione

Una volta terminata la ripetizione della scansione del database {{site.data.keyword.cloudant_short_notm}},
il warehouse non viene avviato automaticamente.
Al contrario,
rimane in stato di arresto,
in modo che il database warehouse possa essere personalizzato.

## Personalizzazione dello schema del warehouse

È possibile modificare lo schema del database che viene determinato automaticamente
durante il processo di creazione iniziale del warehouse
o dopo la ripetizione della scansione.
Per farlo,
assicurati di selezionare l'opzione `Personalizza schema` durante il processo di creazione:

![Schermata del pannello di creazione del warehouse, che mostra l'opzione 'Personalizza schema' abilitata.](../images/customizeSchema01.png)

Il warehouse viene creato in {{site.data.keyword.dashdbshort_notm}} come al solito,
tuttavia non viene avviato immediatamente.
Hai invece
la possibilità di personalizzare lo schema prima di procedere.

Per farlo,
fai clic sul link per il tuo warehouse:

![Schermata del pulsante 'Apri in {{site.data.keyword.dashdbshort_notm}}'.](../images/openInDashDB.png)

La visualizzazione risultante ti fornisce un pulsante per personalizzare lo schema utilizzato per il tuo database di origine.
Il passaggio del mouse sull'indicatore di stato conferma che lo schema è pronto per la personalizzazione:

![Schermata del pulsante  `Personalizza <source database name>`.](../images/customizeSchema02.png)

Facendo clic sul pulsante 'Personalizza' viene visualizzato un pannello in cui puoi modificare i campi dello schema del database:

![Schermata del pannello Personalizza schema.](../images/customizeSchema03.png)

Per reimpostare lo schema sull'impostazione predefinita,
fai clic sul pulsante `Ripeti scansione`:

![Schermata del pulsante `Ripeti scansione`.](../images/customizeSchema04.png)

Quando hai terminato di personalizzare lo schema del database per il warehouse,
fai clic sul pulsante `Esegui`:

![Schermata del pulsante `Esegui`.](../images/customizeSchema05.png)

Lo schema viene salvato
e il warehouse avviato.

### Personalizzazione di uno schema del warehouse esistente

Se lo schema del database per il tuo warehouse esiste già,
hai la [possibilità di personalizzarlo](#keeping-the-data-and-structure-fresh).

## Risoluzione dei problemi

Ogni tanto,
potresti riscontrare dei problemi quando utilizzi la funzione di warehousing.
Informazioni su alcuni di questi problemi sono fornite in seguito in questo argomento.

Inoltre,
una discussione su alcuni errori o problemi comuni,
oltre ai dettagli su come risolverli,
è disponibile in [Stack Overflow ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://stackoverflow.com/questions/tagged/cloudant+dashdb){:new_window}.

Se hai bisogno di ulteriore assistenza
e non riesci a trovare soluzioni in Stack Overflow,
contatta il [supporto {{site.data.keyword.cloudant_short_notm}} ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](mailto:support@cloudant.com){:new_window}.

### Eccezioni visibili nel dashboard

A volte,
il warehouse rileva una condizione di errore.
Ad esempio,
se provi a creare un warehouse utilizzando un database {{site.data.keyword.Db2_on_Cloud_short}} esistente,
ma non immetti i dettagli corretti per il database,
il warehouse non potrà essere creato correttamente.

Se esiste una condizione di errore,
lo stato del warehouse cambia e viene contrassegnato con un cerchio rosso,
che indica che c'è un problema che richiede la tua attenzione.

![Schermata dell'indicatore dello stato di errore.](../images/errorIndicator1.png)

Se 'passi con il mouse' sull'indicatore,
viene fornita qualche altra informazione:

![Schermata che mostra il riepilogo a comparsa dello stato di errore.](../images/errorIndicator2.png)

Quando fai clic sull'indicatore,
viene visualizzata una finestra che ti fornisce ulteriori dettagli sulla causa del problema.
In questo esempio,
i dettagli dell'host immessi per la connessione {{site.data.keyword.Db2_on_Cloud_short}} non erano validi:

![Schermata che mostra il riepilogo a comparsa dello stato di errore.](../images/errorIndicator3.png)

### Avvertenze ed errori

Le modifiche nel database {{site.data.keyword.cloudant_short_notm}} vengono replicate nel database warehouse.
È possibile che una modifica non sia adatta per il warehouse o per il suo schema.
I problemi di questo tipo vengono rilevati e registrati nella tabella `OVERFLOW` del database warehouse.

Ad esempio,
se lo schema del warehouse ha un campo `Movie_earnings_rank` di tipo `VARCHAR`
e può contenere un massimo di 32 caratteri,
ma una modifica nel database {{site.data.keyword.cloudant_short_notm}} richiede l'archiviazione di 40 caratteri,
il campo verrà 'sovraccaricato'.
Questo provoca una condizione di 'avvertenza'
che viene indicata nell'icona di stato del dashboard warehouse:

![Schermata che mostra il messaggio di avvertenza nell'icona di stato.](../images/overflowWarning.png)

Guardando nella tabella di overflow indicata nel database warehouse,
puoi visualizzare ulteriori dettagli sull'avvertenza:

![Schermata che mostra i dettagli del messaggio di avvertenza nella tabella Overflow del database warehouse.](../images/overflowWarningDetail.png)

In questo esempio,
l'avvertenza chiarisce che si è verificato un troncamento,
che interessa il campo `Movie_earnings_rank` del documento {{site.data.keyword.cloudant_short_notm}} che ha un `_ID` di  `70f6284d2a395396dbb3a60b4cf1cac2`.

Ci sono due possibili opzioni di soluzione:

-   Correggere il campo sovraccaricato all'interno del documento {{site.data.keyword.cloudant_short_notm}}.
-   [Aggiornare lo schema del warehouse](#customizing-the-warehouse-schema).

L'opzione che scegli dipende se l'aggiunta del contenuto nel campo è intenzionale o meno.
Se ti serve del contenuto aggiuntivo per la tua applicazione,
è necessario
[aggiornare lo schema del warehouse](#customizing-the-warehouse-schema) per rimuovere la condizione di avvertenza.

Il problema è più significativo se un campo completamente nuovo viene introdotto in un documento nel database {{site.data.keyword.cloudant_short_notm}},
ma il campo non ha una controparte nello schema del database warehouse.
Questo provoca una condizione di 'errore'.

Ad esempio,
un documento nel database {{site.data.keyword.cloudant_short_notm}} potrebbe 'acquisire' un campo aggiuntivo chiamato `my key`
che non esiste nello schema del database warehouse:

![Schermata che mostra il campo aggiuntivo 'my key' in un documento.](../images/extraField.png)

Il risultato è una condizione di errore,
che viene indicata nell'icona di stato del dashboard warehouse:

![Schermata che mostra il messaggio di errore nell'icona di stato.](../images/overflowError.png)

Guardando nella tabella di overflow indicata nel database warehouse,
puoi visualizzare ulteriori dettagli sull'errore:

![Schermata che mostra i dettagli del messaggio di errore nella tabella Overflow del database warehouse.](../images/overflowErrorDetail.png)

In questo esempio,
l'errore chiarisce che è stato rilevato un campo
che non era presente quando è stato creato lo schema del database warehouse.
Il campo stesso è stato rilevato nel documento {{site.data.keyword.cloudant_short_notm}} che ha un `_ID` di  `70f6284d2a395396dbb3a60b4cf1cac2`.

Ci sono due possibili opzioni di soluzione:

-   Rimuovere il campo aggiuntivo dal documento {{site.data.keyword.cloudant_short_notm}}.
-   [Aggiornare lo schema del warehouse](#customizing-the-warehouse-schema).

L'opzione che scegli dipende se l'aggiunta del campo è intenzionale o meno.
Se ti serve un campo aggiuntivo per la tua applicazione,
è necessario [aggiornare lo schema del warehouse](#customizing-the-warehouse-schema) per rimuovere la condizione di errore.
