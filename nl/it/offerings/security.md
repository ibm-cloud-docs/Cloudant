---

copyright:
  years: 2017, 2018
lastupdated: "2018-10-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:tip: .tip}

<!-- Acrolinx: 2017-05-10 -->

# Sicurezza
{: #security}

## Sicurezza e protezione dei dati DBaaS {{site.data.keyword.cloudant_short_notm}}
{: #ibm-cloudant-dbaas-data-protection-and-security}

Proteggere i dati dell'applicazione su larga scala per le applicazioni mobili e web può essere complesso,
specialmente quando distribuiti a database NoSQL.

Nello stesso modo in cui riduce lo sforzo di gestire i tuoi database
per mantenerli in esecuzione e in crescita continua,
{{site.data.keyword.cloudantfull}} garantisce anche che i tuoi dati siano sicuri e protetti.
{:shortdesc}

## Piattaforme fisiche di livello superiore
{: #top-tier-physical-platforms}

DBaaS {{site.data.keyword.cloudant_short_notm}} è fisicamente ospitato
su provider dell'infrastruttura cloud di livello 1 come {{site.data.keyword.cloud}} e Amazon.
Pertanto,
i tuoi dati sono protetti dalle misure di sicurezza fisiche e di rete utilizzate da questi provider,
incluse (ma non limitate a):

- Certificazioni: conformi con SSAE16, SOC2 Type 1, ISAE 3402, ISO 27001, CSA e altri standard.
- Gestione identità e accesso.
- Sicurezza fisica generale dei data center e monitoraggio del centro operativo in rete.
- Protezione avanzata del server.
- {{site.data.keyword.cloudant_short_notm}} ti fornisce la flessibilità di scegliere
  o di spostarti tra i diversi provider
  come la tua modifica dei requisiti dei costi e dello SLA.

Ulteriori dettagli sulle certificazioni sono disponibili nelle [Informazioni sulla conformità](compliance.html).
{:tip}

## Controllo di accesso sicuro
{: #secure-access-control}

{{site.data.keyword.cloudant_short_notm}} dispone di molte funzioni di sicurezza incorporate per consentirti di controllare l'accesso ai dati:

Funzione | Descrizione
--------|------------
Autenticazione | Si accede a {{site.data.keyword.cloudant_short_notm}} utilizzando un'API HTTPS. Dove l'endpoint API lo richiede, l'utente viene autenticato per ogni richiesta HTTPS che
{{site.data.keyword.cloudant_short_notm}} riceve. {{site.data.keyword.cloudant_short_notm}} supporta sia i controlli di accesso legacy che quelli IAM. Per ulteriori informazioni, consulta la [guida IAM](../guides/iam.html){:new_window} oppure il [documento dell'API di autenticazione ](../api/authentication.html){:new_window} legacy.
Autorizzazione |{{site.data.keyword.cloudant_short_notm}} supporta sia i controlli di accesso legacy che quelli IAM. Per ulteriori informazioni, consulta la [guida IAM](../guides/iam.html){:new_window} e il [documento dell'API di autorizzazione](../api/authorization.html){:new_window} legacy.
Crittografia "in elaborazione" | Tutto l'accesso a {{site.data.keyword.cloudant_short_notm}} è crittografato utilizzando HTTPS.
Crittografia dei dati inattivi. | Tutti i dati archiviati in un'istanza {{site.data.keyword.cloudant_short_notm}} vengono archiviati quando sono inattivi. Se hai bisogno di BYOK (bring-your-own-key) per la crittografia dei dati inattivi, ne viene eseguita l'abilitazione tramite {{site.data.keyword.cloud_notm}} Key
Protect. {{site.data.keyword.cloudant_short_notm}} supporta questa funzione per le nuove istanze del piano {{site.data.keyword.cloudant_short_notm}}
Hardware dedicato distribuite in tutte le regioni. Innanzitutto, crea un'istanza del piano Hardware dedicato tramite il catalogo {{site.data.keyword.cloud_notm}}. Inoltra quindi un ticket di supporto. Il nostro team di supporto coordina l'ottenimento delle chiavi di crittografia dei dati inattivi della tua istanza Hardware dedicato che sono gestite tramite la tua istanza Key Protect.
Inserimento in whitelist di IP | I clienti {{site.data.keyword.cloudant_short_notm}} che hanno un ambiente {{site.data.keyword.cloudant_short_notm}} dedicato possono inserire in whitelist gli indirizzi IP per limitare l'accesso solo a specifici server e utenti. L'inserimento in whitelist di IP non è disponibile per i piani Lite/Standard {{site.data.keyword.cloud_notm}} Pubblico distribuiti su ambienti a più tenant.Apri un ticket di supporto per richiedere le whitelist IP per una serie specifica di intervalli IP o IP. Nota: le whitelist di IP si applicano sia al dashboard che all'API {{site.data.keyword.cloudant_short_notm}}; premurati quindi di includere gli eventuali IP amministratore che hanno bisogno di accedere al dashboard {{site.data.keyword.cloudant_short_notm}} direttamente. 
CORS | Abilita il supporto CORS per specifici domini utilizzando il dashboard {{site.data.keyword.cloudant_short_notm}}.

<!--
> **Note**: Your data is visible to the {{site.data.keyword.cloudant_short_notm}} 
> worldwide team. If you don’t 
> want our team to see your data, encrypt it before sending it to 
> {{site.data.keyword.IBM_notm}}, and avoid leaking 
> data into your document `_id` and any attachment file names. In addition, 
> when you send personal data, you must use HTTPS to ensure that it is sent securely. 
> HTTP is no longer supported.  

> **Warning**: You are responsible for verifying that 
> {{site.data.keyword.cloudant_short_notm}} can be used to store 
> your data. You must also make sure that your data does not violate applicable 
> data protection laws or any regulations that require security measures 
> beyond those specified in the {{site.data.keyword.cloudant_short_notm}} 
> system requirements and {{site.data.keyword.cloud_notm}} Services terms. You must 
> verify that the security requirements are appropriate for any personal data 
> that is processed. If you are unsure, or intend to store data that is 
> beyond the scope of the {{site.data.keyword.cloudant_short_notm}} terms and conditions, 
> you must get approval from {{site.data.keyword.IBM_notm}} to ensure that it is 
> appropriate for {{site.data.keyword.cloudant_short_notm}} to store your data.
-->

## Protezione contro la perdita o il danneggiamento dei dati
{: #protection-against-data-loss-or-corruption}

{{site.data.keyword.cloudant_short_notm}} dispone di numerose funzioni
per aiutarti a mantenere la disponibilità e la qualità dei dati:

Funzione | Descrizione
--------|------------
Archiviazione dati ridondante e durevole | Per impostazione predefinita, {{site.data.keyword.cloudant_short_notm}} salva su disco tre copie di ogni documento su tre nodi differenti in un cluster. Il salvataggio dei dati garantisce che una copia di failover funzionante dei tuoi dati
  sia sempre disponibile, indipendentemente dagli errori.
Replica ed esportazione di dati. |Puoi replicare i tuoi database di continuo tra i cluster in diversi data center o in un cluster {{site.data.keyword.cloudant_short_notm}} locale installato in loco o Apache CouchDB. Un'altra opzione è di esportare i dati da
  {{site.data.keyword.cloudant_short_notm}} (nel formato JSON)
  in altre ubicazioni o origini (come il tuo data center) per la ridondanza dei dati aggiunti.
