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

# {{site.data.keyword.cloudant_local_notm}}

[{{site.data.keyword.cloudantfull}} Data Layer Local Edition ({{site.data.keyword.cloudant_local_notm}}) ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/support/knowledgecenter/SSTPQH_1.1.0/com.ibm.cloudant.local.doc/SSTPQH_1.1.0_welcome.html){:new_window}
è una versione installata localmente dell'offerta DBaaS (Database-as-a-Service) {{site.data.keyword.cloudant_short_notm}}.

{{site.data.keyword.cloudant_local_notm}} ti fornisce le stesse funzionalità di base dell'offerta completa a singolo tenant {{site.data.keyword.cloudant_short_notm}},
ma è ospitato nel tuo data center.

Una panoramica più dettagliata di {{site.data.keyword.cloudant_local_notm}} è
[disponibile qui ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/support/knowledgecenter/en/SSTPQH_1.1.0/com.ibm.cloudant.local.install.doc/topics/clinstall_cloudant_local_overview.html){:new_window}.
[IBM Knowledge Center ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/support/knowledgecenter/en/SSTPQH_1.1.0/com.ibm.cloudant.local.doc/SSTPQH_1.1.0_welcome.html){:new_window}
fornisce informazioni su molti aspetti di {{site.data.keyword.cloudant_local_notm}},
tra cui:

-   [Installation and Configuration ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/support/knowledgecenter/en/SSTPQH_1.1.0/com.ibm.cloudant.local.install.doc/topics/clinstall_installing.html){:new_window}.
-   [Maintenance Tasks ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/support/knowledgecenter/en/SSTPQH_1.1.0/com.ibm.cloudant.local.install.doc/topics/clinstall_maintenance_tasks_overview.html){:new_window}.
-   [Tuning replication parameters ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/support/knowledgecenter/en/SSTPQH_1.1.0/com.ibm.cloudant.local.install.doc/topics/clinstall_tuning_parameters_replication_cases.html){:new_window}.

## Supporto

Il supporto {{site.data.keyword.cloudant_short_notm}} può fornire assistenza con l'installazione, la configurazione e il corretto utilizzo di {{site.data.keyword.cloudant_local_notm}}. In caso di un problema di prestazioni o di incongruenza, il supporto è in grado di aiutare a risolvere il problema. In caso di interruzione, il supporto può aiutare a diagnosticare il problema ma la responsabilità di risolverlo spetta al team del cliente, dato che non abbiamo accesso ai sistemi del cliente.

Sono necessari dei log adeguati per fornire una corretta assistenza con qualsiasi problema. Per aiutare a risolvere i problemi il più rapidamente possibile, devi includere l'output del programma di utilità Weatherreport oltre a qualsiasi log, richiesta e codice di stato pertinenti quando informi il supporto di un problema. Per ulteriori informazioni, vedi [Weatherreport utility ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/support/knowledgecenter/SSTPQH_1.1.0/com.ibm.cloudant.local.install.doc/topics/clinstall_checking_health_cluster_with_weatherreport.html){:new_window}.

Un'assistenza con problemi e interruzioni comuni può essere offerta solo se il problema sottostante rientra nell'ambito del supporto. Il seguente testo descrive il supporto disponibile: 

Il supporto {{site.data.keyword.cloudant_short_notm}} copre i seguenti problemi:
- Una corretta installazione
- La configurazione
- Qualsiasi cosa sia correlata all'API che restituisce errori oppure risultati o prestazioni imprevisti

Il supporto {{site.data.keyword.cloudant_short_notm}} non copre i seguenti problemi:
- Flusso di lavoro o strumentazione lato cliente proprietari
- Problemi di rete 
- Crittografia sul disco 
- Strumentazione o funzionalità personalizzate

Ad esempio, se la causa radice è un server di proprietà del cliente che sta riscontrando dei problemi hardware, il supporto non può essere di aiuto. Tuttavia, se l'interruzione è dovuta al software {{site.data.keyword.cloudant_short_notm}} stesso, ad esempio se i rallentamenti delle richieste si verificano a causa di conflitti di documenti, il supporto può aiutare il cliente a risolvere il problema.

Contatta il tuo Customer Success o Account Manager per ulteriore assistenza con le seguenti richieste:
- Ottimizzazione delle prestazioni
- Ottimizzazione dei progetti
- Pianificazione della capacità

Se hai domande relative alla nostra politica di supporto, contatta il team di supporto [ {{site.data.keyword.cloudant_short_notm}} ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno") ](mailto:support@cloudant.com){:new_window}.

### Come aprire un ticket di supporto
Per ottenere supporto con un problema {{site.data.keyword.cloudant_local_notm}}, apri un ticket con il supporto {{site.data.keyword.cloudant_short_notm}} e includi le seguenti informazioni:

1. Crea una email per aprire una [richiesta di supporto {{site.data.keyword.cloudant_short_notm}}](mailto:support@cloudant.com).
2. Nella riga dell'oggetto dell'email, fornisci una singola frase relativa al problema.
3. L'email deve contenere i seguenti dettagli per aiutarci a diagnosticare il tuo problema:
    - Nome
    - L'indirizzo e-mail di contatto
    - Il nome dell'organizzazione
    - La versione di {{site.data.keyword.cloudant_local_notm}} che stai utilizzando
    - La distribuzione e la versione di Linux che stai utilizzando per eseguire {{site.data.keyword.cloudant_local_notm}}
    - Il livello di severità del problema
    - Una descrizione dettagliata del problema, comprese le condizioni quando si verifica e le informazioni sulle eventuali modifiche recenti
    - Se disponibili, allega i log o l'output che potrebbero aiutare a diagnosticare, riprodurre o indagare il problema.
4. Quando il supporto riceve l'email, un membro del team di supporto ti contatterà.

