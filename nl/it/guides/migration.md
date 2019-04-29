---

copyright:
  years: 2015, 2019
lastupdated: "2019-03-18"

keywords: curl and jq basics, monitor view builds and search indexes, estimate time to complete task, monitor replication, troubleshooting

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

<!-- Acrolinx: 2018-08-14 -->

# Migrazione a {{site.data.keyword.cloudant_short_notm}} su {{site.data.keyword.cloud_notm}}
{: #migrating-to-ibm-cloudant-on-ibm-cloud}

L'offerta DaaS (database-as-a-service) di [{{site.data.keyword.cloudantfull}}](https://www.ibm.com/cloud/cloudant) è un archivio documenti JSON che viene eseguito su cluster a più tenant. Il servizio è disponibile con una scelta di ubicazioni geografiche con costi prevedibili, scalabilità e uno SLA (Service Level Agreement).

Questo documento descrive come eseguire la migrazione a un'istanza del piano {{site.data.keyword.cloudant_short_notm}} Lite o Standard su {{site.data.keyword.cloud_notm}} da uno dei seguenti piani:

Piano | Descrizione
-----|------------
{{site.data.keyword.cloudant_short_notm}} Enterprise | Cluster dedicati a singolo tenant
Piano condiviso {{site.data.keyword.cloudant_short_notm}} | Un servizio {{site.data.keyword.cloudant_short_notm}} legacy a più tenant e con pagamento a consumo. Il piano condiviso `cloudant.com` è stato ritirato nel marzo del 2018. Il piano condiviso {{site.data.keyword.cloudant_short_notm}} è stato dichiarato obsoleto per le nuove registrazioni nell'ottobre del 2016 e ne è in corso il ritiro nel quarto trimestre del 2018.
{{site.data.keyword.cloudant_localfull}} | L'installazione in pacchetto e ospitata autonomamente di {{site.data.keyword.cloudant_short_notm}}.
Apache CouchDB | Il database open-source e ospitato autonomamente su cui è basato {{site.data.keyword.cloudant_short_notm}}.

## Quali sono i vantaggi dei piani {{site.data.keyword.cloudant_short_notm}} Lite e Standard?
{: #what-are-the-benefits-of-the-ibm-cloudant-lite-and-standard-plans-}

Il piano Standard ti consente di *riservare la capacità produttiva* per il tuo servizio database, ossia di specificare di quanta velocità effettiva avrà bisogno il tuo database dell'applicazione per gestire la domanda. Il piano Standard prevede anche un addebito per la quantità di archiviazione che utilizzi. La capacità viene misurata utilizzando le seguenti metriche:

Metrica | Descrizione
-------|------------
Letture al secondo | La frequenza con la quale vengono eseguiti i recuperi di documento semplici, ad esempio il richiamo di un documento mediante il suo `_id` o le query a un database partizionato utilizzando una chiave della partizione. 
Scritture al secondo | La frequenza con cui i dati vengono scritti nel database. Le chiamate API che si occupano della creazione, dell'aggiornamento o dell'eliminazione di documenti contano come 'scritture'.
Query globali al secondo | La frequenza con cui vengono eseguite query del database utilizzando gli indici globali, di norma accedendo all'endpoint `_find` oppure utilizzando gli indici MapReduce, di ricerca o geospaziali.
Archiviazione | La quantità di spazio su disco occupata dai tuoi dati JSON, allegati e indici secondari.

Per fare un esempio, il piano Lite offre 20 letture al secondo, 10 scritture al secondo, 5 query globali al secondo e 1 GB di archiviazione gratuitamente. Questo piano è ideale quando stai eseguendo una verifica del prodotto e durante lo sviluppo del prodotto. Quando la tua applicazione entra in QA o in produzione, passa al piano Standard per scalare l'istanza. La capacità più piccola del piano Standard ha 100 letture al secondo, 50 scritture al secondo, 5 query globali al secondo e 20 GB di archiviazione (l'archiviazione supplementare viene addebitata per GB) per ~USD$76,65 al mese. 

Utilizzando il dispositivo di scorrimento nel dashboard {{site.data.keyword.cloudant_short_notm}}, puoi riservare una capacità più piccola o più grande per il tuo servizio {{site.data.keyword.cloudant_short_notm}} ogni volta che ne hai bisogno:

![dispositivo di scorrimento](../images/migrate2.gif)

La quantità di capacità produttiva che puoi modificare è limitata a un massimo di 10 unità per modifica (nota il punto 'change limit' (limite di modifica) sul dispositivo di scorrimento) con un massimo di una modifica all'ora. L'entità delle variazioni in diminuzione è illimitata ma è comunque soggetta al limite di tempo.
{: tip}

Ti viene addebitata la capacità più elevata selezionata in qualsiasi specifica finestra oraria. La velocità effettiva del tuo database può essere incrementata per gestire esigenze stagionali e ridotta nuovamente per i periodi di calma. La fatturazione mensile a tuo carico è sempre prevedibile; gli upgrade sono automatici e il tuo SLA è [99,95%](http://www-03.ibm.com/software/sla/sladb.nsf/sla/bm?OpenDocument).

Se superi la tua quota di letture, scritture e query globali in un dato secondo, l'API {{site.data.keyword.cloudant_short_notm}} risponde con una risposta `HTTP 429 too many requests`. La tua applicazione potrebbe ritentare la richiesta in un secondo momento; le nostre librerie ufficiali offrono l'opzione di ritentare tali richieste con un backoff esponenziale. 

## Quale tipo di piano {{site.data.keyword.cloudant_short_notm}} ho?
{: #which-type-of-ibm-cloudant-plan-do-i-have-}

Se stai utilizzando {{site.data.keyword.cloudant_short_notm}}, vai al dashboard {{site.data.keyword.cloud_notm}} e fai clic sull'icona **Menu** > **Elenco risorse** per vedere tutte le tue istanze del servizio.  

![dashboard cloud](../images/ibmclouddashboard.png)

Per ulteriori informazioni, puoi anche eseguire il drill-down in un'istanza specifica e consultare la scheda Piano. Le istanze {{site.data.keyword.cloudant_short_notm}} nel piano Condiviso obsoleto non hanno un piano che sia evidenziato. Un'istanza nel piano {{site.data.keyword.cloudant_short_notm}} Standard ha un aspetto simile a questo esempio: 

![dashboard standard](../images/ibmcloud_instance_standard_plan.png)

Puoi anche aprire il dashboard {{site.data.keyword.cloudant_short_notm}} e fare clic sulla scheda **Account** Un piano Lite ha un aspetto simile al seguente esempio:

![piano lite](../images/migrate1.png)

Se stai utilizzando un account `cloudant.com` legacy, puoi eseguire l'accesso al tuo dashboard {{site.data.keyword.cloudant_short_notm}} e andare alla scheda Account. Un piano `cloudant.com` Condiviso legacy ha una scheda Usage con grafici e stime della fatturazione per il mese attuale, come nel seguente esempio:

![piano condiviso](../images/cloudantcom_sharedplan_usage.png)

Un utente Enterprise `cloudant.com` su un cluster dedicato non ha la scheda Usage nella sua scheda Account. È simile all'esempio riportato di seguito:

![piano enterprise](../images/cloudantcom_enterpriseplan_account.png)

Se la tua scheda Account già indica che sei nel piano Standard, non hai bisogno di procedere con la lettura. Già sei in un servizio {{site.data.keyword.cloudant_short_notm}} a pagamento supportato da SLA. Non è richiesta alcuna azione aggiuntiva.

## Migrazione da {{site.data.keyword.cloudant_short_notm}} Lite a {{site.data.keyword.cloudant_short_notm}} Standard
{: #migrating-from-ibm-cloudant-lite-to-ibm-cloudant-standard}

Esegui la migrazione dal piano Lite gratuito al piano Standard attenendoti alla seguente procedura: 

1.  Vai al dashboard {{site.data.keyword.cloud_notm}}.
2.  Vai all'icona **Menu** > **Elenco risorse** per vedere tutte le tue istanze del servizio. 
3.  Seleziona l'istanza {{site.data.keyword.cloudant_short_notm}} di cui vuoi eseguire la migrazione. 
4.  Seleziona la scheda **Piano** nella navigazione a sinistra. 
5.  Dall'elenco di piani dei prezzi, seleziona la casella di spunta **Standard**.
![lite](../images/migrate3.png)
6.  Fai clic su **Esegui upgrade** nella parte inferiore della pagina.
Tutti i tuoi dati esistenti sono conservati per tuo conto.

Regola la tua capacità utilizzando il dispositivo di scorrimento della capacità produttiva (Throughput Capacity) per aumentare o diminuire la capacità come necessario.
{: tip} 
 
Ora sei pronto a iniziare.

## Migrazione di tutto il resto al piano {{site.data.keyword.cloudant_short_notm}} Lite o Standard
{: #migrating-everything-else-to-ibm-cloudant-lite-or-standard-plan}

La migrazione dai piani Condiviso o Enterprise ai piani {{site.data.keyword.cloudant_short_notm}} Lite o Standard include queste attività, che sono descritte nei seguenti passi. 

Non puoi modificare direttamente un'istanza del piano Condiviso in un'istanza del piano Lite o Standard. La migrazione richiede che tu crei una nuova istanza del piano Lite o Standard e che replichi i dati dall'istanza del piano Condiviso. 
{: tip}

### Passo 1: registrati per {{site.data.keyword.cloud_notm}}
{: #step-1-sign-up-for-ibm-cloud}

Se non lo hai già fatto, [registrati per un account {{site.data.keyword.cloud_notm}}](https://www.ibm.com/cloud/). 

### Passo 2: creare un'istanza {{site.data.keyword.cloudant_short_notm}}
{: #step-2-create-an-ibm-cloudant-instance}

Dopo che hai eseguito l'accesso al tuo account {{site.data.keyword.cloud_notm}}, aggiungi un servizio {{site.data.keyword.cloudant_short_notm}}. Fai clic sul pulsante `Crea risorsa` nel dashboard e fai quindi clic su `Database` e `Cloudant`. Per ulteriori informazioni, vedi la sezione su [come creare un'istanza {{site.data.keyword.cloudant_short_notm}} su {{site.data.keyword.cloud_notm}}](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-an-ibm-cloudant-instance-on-ibm-cloud). 

![aggiungi un'istanza {{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant/tutorials/images/img0003.png)

### Passo 3: determina se la tua applicazione è pronta per {{site.data.keyword.cloudant_short_notm}}
{: #step-3-find-out-whether-your-application-is-ready-for-ibm-cloudant}

Se stai passando da un servizio {{site.data.keyword.cloudant_short_notm}} Enterprise o un piano {{site.data.keyword.cloudant_short_notm}} Condiviso, devi rivisitare l'utilizzo della tua applicazione di {{site.data.keyword.cloudant_short_notm}} per assicurarti che sia pronta a gestire i limiti di capacità del piano Standard. Per ulteriori informazioni, vedi [come funziona l'API {{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant?topic=cloudant-ibm-cloud-public#provisioned-throughput-capacity). Devi soprattutto assicurarti che la tua applicazione possa gestire una risposta HTTP `429: too many requests` se superi la tua capacità produttiva fornita. 

Ritentare le richieste che ottengono una risposta `429` è accettabile per occasionali picchi di traffico che superano la capacità del tuo piano. Se il tuo traffico dell'applicazione sta generando regolarmente risposte `429`, è molto probabile che tu abbia bisogno di eseguire un upgrade a un piano di maggiori dimensioni.

Vale inoltre la pena notare che la dimensione di singolo documento massima è 1 MB su {{site.data.keyword.cloudant_short_notm}}, e riceverai un messaggio `413: request entity too large` se il limite viene superato. Per ulteriori informazioni, vedi [Limiti di dimensione di richieste e documenti](/docs/services/Cloudant?topic=cloudant-ibm-cloud-public#request-and-document-size-limits). 

### Passo 4: migra i dati dal vecchio servizio a quello nuovo 
{: #step-4-migrate-data-from-the-old-service-to-the-new-service}

Configura delle repliche continue dal tuo servizio esistente al tuo account {{site.data.keyword.cloudant_short_notm}}. Per ulteriori informazioni, consulta la [Guida di replica](/docs/services/Cloudant?topic=cloudant-replication-api#replication-api) e la [documentazione API](/docs/services/Cloudant?topic=cloudant-ibm-cloudant-basics#ibm-cloudant-basics) in merito a come configurare e monitorare le attività di replica.

In alternativa, controlla lo strumento [`couchreplicate`](https://www.npmjs.com/package/couchreplicate) che è un programma di utilità di riga di comando che ti aiuta a coordinare il trasferimento di dati da un account {{site.data.keyword.cloudant_short_notm}} a un altro. Configura più lavori di replica tra gli account di origine e di destinazione, garantendo che proceda solo uno specifico numero di lavori di replica per volta. Se devi eseguire la migrazione di centinaia di database, `couchreplicate` può aiutarti a coordinare i lavori di replica.

![`couchreplicate`](https://raw.githubusercontent.com/glynnbird/couchreplicate/HEAD/img/couchreplicate.gif)

Verifica che tutti i tuoi dati vengano replicati al nuovo servizio e che gli indici vengano creati.

### Passo 5: esecuzione di test
{: #step-5-testing}

Esegui dei test del carico e funzionali sulla tua applicazione per assicurarti che non ci siano problemi prima di eseguire la migrazione alla produzione.

### Passo 6: pronto a passare alla nuova istanza?
{: #step-6-ready-to-move-to-the-new-instance-}

Quando sei pronto a passare alla nuova istanza, aggiorna la tua applicazione per utilizzare il nuovo URL e le nuove credenziali dell'account per l'istanza {{site.data.keyword.cloudant_short_notm}}. Per ulteriori informazioni, vedi l'[esercitazione relativa al provisioning](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-an-ibm-cloudant-instance-on-ibm-cloud) in merito a come ottenere le credenziali del servizio per un'istanza {{site.data.keyword.cloudant_short_notm}}.

### Passo 7: disattiva il vecchio servizio
{: #step-7-turn-off-the-old-service}

 Dopo che la tua applicazione è stata completamente migrata all'istanza {{site.data.keyword.cloudant_short_notm}} Lite o Standard, puoi eliminare la vecchia istanza del piano {{site.data.keyword.cloudant_short_notm}} Condiviso dalla tua console {{site.data.keyword.cloud_notm}} per assicurati di evitare ulteriori addebiti per il servizio.

## Domande frequenti
{: #faq-frequently-asked-questions}

Le domande frequenti sono pubblicate dall'organizzazione {{site.data.keyword.cloudant_short_notm}} per aiutare i clienti {{site.data.keyword.IBM_notm}} a eseguire la migrazione a un'istanza del piano {{site.data.keyword.cloudant_short_notm}} Lite o Standard su {{site.data.keyword.cloud_notm}}.

## Posso eseguire il backup dei miei dati prima di eseguire qualsiasi operazione?
{: #can-i-back-up-my-data-before-doing-anything-}

{{site.data.keyword.cloudant_short_notm}} ti consiglia di utilizzare il programma di utilità [couchbackup](/docs/services/Cloudant?topic=cloudant-ibm-cloudant-backup-and-recovery#ibm-cloudant-backup-and-recovery) per esportare i dati su disco. [{{site.data.keyword.cloud_notm}} Object Storage](https://www.ibm.com/cloud/object-storage) è una soluzione scalabile e poco onerosa per archiviare i file esportati. 

## Posso conservare il mio dominio `username.cloudant.com` e reindirizzarlo al nuovo servizio su {{site.data.keyword.cloudant_short_notm}}?
{: #can-i-keep-my-username-cloudant-com-domain-and-redirect-it-to-the-new-service-on-ibm-cloudant-}

No, non puoi conservare il tuo dominio. Devi pianificare l'aggiornamento delle tue applicazioni per utilizzare i nuovi URL e credenziali dell'account generati per le istanze {{site.data.keyword.cloudant_short_notm}}.

## Chi devo contattare se ho delle domande?
{: #who-do-i-contact-if-i-have-questions-}

Contatta il [supporto {{site.data.keyword.cloudant_short_notm}}](mailto:support@cloudant.com) oppure apri un ticket dall'interno del dashboard {{site.data.keyword.cloudant_short_notm}} se hai domande relative alla migrazione. Il supporto {{site.data.keyword.cloudant_short_notm}} sarà lieto di fornire ulteriori dettagli.
