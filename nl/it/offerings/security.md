---

copyright:
  years: 2017, 2019
lastupdated: "2019-06-12"

keywords: dbaas data protection, top-tier physical platforms, secure access control, data loss, corruption

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

# Sicurezza
{: #security}


## Sicurezza e protezione dei dati DBaaS {{site.data.keyword.cloudant_short_notm}}
{: #ibm-cloudant-dbaas-data-protection-and-security}

Proteggere i dati dell'applicazione su larga scala per le applicazioni mobili e web può essere complesso,
specialmente quando distribuiti a database NoSQL.

Nello stesso modo in cui riduce lo sforzo di gestire i tuoi database
per mantenerli in esecuzione e in crescita continua,
{{site.data.keyword.cloudantfull}} garantisce anche che i tuoi dati siano sicuri e protetti.
{: shortdesc}

## Piattaforme fisiche di alto livello
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

Ulteriori dettagli sulle certificazioni sono disponibili nelle [Informazioni sulla conformità](/docs/services/Cloudant?topic=cloudant-compliance#compliance).
{: tip}

## Controllo di accesso sicuro
{: #secure-access-control}

{{site.data.keyword.cloudant_short_notm}} dispone di molte funzioni di sicurezza incorporate per consentirti di controllare l'accesso ai dati:

Funzione | Descrizione
--------|------------
Autenticazione | Si accede a {{site.data.keyword.cloudant_short_notm}} utilizzando un'API HTTPS. Dove l'endpoint API lo richiede, l'utente viene autenticato per ogni richiesta HTTPS che
{{site.data.keyword.cloudant_short_notm}} riceve. {{site.data.keyword.cloudant_short_notm}} supporta sia i controlli di accesso legacy che quelli IAM. Per ulteriori informazioni, consulta la [guida IAM](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-){: new_window} oppure il [documento dell'API di autenticazione ](/docs/services/Cloudant?topic=cloudant-authentication#authentication){: new_window} legacy.
Autorizzazione | {{site.data.keyword.cloudant_short_notm}} supporta sia i controlli di accesso legacy che quelli IAM. Il team {{site.data.keyword.cloudant_short_notm}} ti consiglia di utilizzare i controlli di accesso IAM per l'autenticazione quando possibile. Se stai utilizzando l'autenticazione legacy {{site.data.keyword.cloudant_short_notm}}, ti consigliamo di utilizzare le [chiavi API](/docs/services/Cloudant?topic=cloudant-authorization#api-keys){: new_window} invece delle credenziali a livello di account per l'accesso programmatico e i lavori di replica. Per ulteriori informazioni, vedi la [guida IAM](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-){: new_window} o il [documento API di autenticazione](/docs/services/Cloudant?topic=cloudant-authentication#authentication){: new_window} legacy e il [documento API di autorizzazione](/docs/services/Cloudant?topic=cloudant-authorization#authorization){: new_window} legacy.
Crittografia dei dati inattivi. | Tutti i dati archiviati in un'istanza {{site.data.keyword.cloudant_short_notm}} vengono archiviati quando sono inattivi. Se hai bisogno di BYOK (bring-your-own-key) per la crittografia dei dati inattivi, ne viene eseguita l'abilitazione tramite {{site.data.keyword.cloud_notm}} Key
Protect. {{site.data.keyword.cloudant_short_notm}} supporta questa funzione per le nuove istanze del piano {{site.data.keyword.cloudant_short_notm}}
Hardware dedicato distribuite in tutte le regioni. Innanzitutto, crea un'istanza del piano Hardware dedicato tramite il catalogo {{site.data.keyword.cloud_notm}}. Inoltra quindi un ticket di supporto. Il nostro team di supporto coordina l'ottenimento delle chiavi di crittografia dei dati inattivi della tua istanza Hardware dedicato che sono gestite tramite la tua istanza Key Protect.
Crittografia "in elaborazione" | Tutto l'accesso a {{site.data.keyword.cloudant_short_notm}} è crittografato utilizzando HTTPS.
TLS | Ti consigliamo di utilizzare TLS 1.2 o 1.3 per tutti gli accessi a {{site.data.keyword.cloudant_short_notm}}. (***Nel giugno 2019, il supporto {{site.data.keyword.cloudant_short_notm}} eliminerà l'uso delle versioni più vecchie (TLS 1.0 e 1.1), a quel punto sarà supportato solo TLS 1.2+.***) Il certificato {{site.data.keyword.cloudant_short_notm}} utilizzato per le connessioni HTTPS viene firmato da un'autorità di certificazione (CA, Certificate Authority) ritenuta universalmente attendibile che è stata pregarantita da tutti i browser, i sistemi operativi e altri sistemi software come Java Development Kit (JDK). Ci impegniamo a pubblicare sempre un certificato TLS valido (non scaduto) firmato da un'autorità di certificazione (CA, Certificate Authority) ritenuta universalmente attendibile. Non possiamo, tuttavia, coordinare le modifiche con i clienti e non ci impegniamo a rimanere con DigiCert. Per garantire un accesso continuo al servizio {{site.data.keyword.cloudant_short_notm}}, consigliamo vivamente ai clienti di non associare il certificato corrente, che è soggetto a scadenza e richiede una rotazione in caso di compromissione. Consigliamo loro invece di utilizzare i bundle di certificati predefiniti per i loro sistemi operativi e browser che garantiranno un servizio di protezione continuo attraverso qualsiasi modifica del certificato.
Endpoint | A tutte le istanze {{site.data.keyword.cloudant_short_notm}} vengono forniti endpoint esterni accessibili pubblicamente. Gli ambienti Hardware dedicato forniti dopo il 1° gennaio 2019 aggiungono anche endpoint interni per tutte le istanze del piano Standard distribuite su di essi. L'utilizzo di endpoint interni consente ai clienti di collegarsi a un'istanza {{site.data.keyword.cloudant_short_notm}} tramite la rete {{site.data.keyword.cloud}} interna per evitare che il traffico dell'applicazione di upstream passi attraverso la rete pubblica e comporti addebiti di larghezza di banda. Vedi la [documentazione dell'endpoint del servizio](https://cloud.ibm.com/docs/services/service-endpoint/getting-started.html#about){:new_window} per ulteriori informazioni sull'abilitazione degli endpoint del servizio per il tuo account {{site.data.keyword.cloud}}.
Inserimento in whitelist di IP | I clienti {{site.data.keyword.cloudant_short_notm}} che hanno un ambiente {{site.data.keyword.cloudant_short_notm}} dedicato possono inserire in whitelist gli indirizzi IP per limitare l'accesso solo a specifici server e utenti. L'inserimento in whitelist di IP non è disponibile per i piani Lite/Standard {{site.data.keyword.cloud_notm}} Pubblico distribuiti su ambienti a più tenant. Apri un ticket di supporto per richiedere le whitelist IP per una serie specifica di intervalli IP o IP. Nota: le whitelist di IP si applicano sia al dashboard che all'API {{site.data.keyword.cloudant_short_notm}}; premurati quindi di includere gli eventuali IP amministratore che hanno bisogno di accedere al dashboard {{site.data.keyword.cloudant_short_notm}} direttamente. 
CORS | Abilita il supporto CORS per specifici domini utilizzando l'API o il dashboard {{site.data.keyword.cloudant_short_notm}}. Per ulteriori informazioni, vedi la [documentazione dell'API CORS](/docs/services/Cloudant?topic=cloudant-cors#cors){:new_window}.

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
Replica ed esportazione di dati. | Puoi replicare i tuoi database di continuo tra i cluster in diversi data center o in un cluster {{site.data.keyword.cloudant_short_notm}} locale installato in loco o Apache CouchDB. Un'altra opzione è di esportare i dati da
  {{site.data.keyword.cloudant_short_notm}} (nel formato JSON)
  in altre ubicazioni o origini (come il tuo data center) per la ridondanza dei dati aggiunti.
