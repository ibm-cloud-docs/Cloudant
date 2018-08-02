---

copyright:
  years: 2017, 2018
lastupdated: "2018-06-08"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:tip: .tip}

<!-- Acrolinx: 2017-04-28 -->

# Sicurezza

## Sicurezza e protezione dei dati DBaaS {{site.data.keyword.cloudant_short_notm}}

Proteggere i dati dell'applicazione su larga scala per le applicazioni mobili e web può essere complesso,
specialmente quando distribuiti a database NoSQL.

Nello stesso modo in cui riduce lo sforzo di conservare i tuoi database,
per mantenerli in esecuzione e in crescita continua,
{{site.data.keyword.cloudantfull}} garantisce inoltre che i tuoi dati siano sicuri e protetti.

## Piattaforme fisiche di livello superiore

DBaaS {{site.data.keyword.cloudant_short_notm}} è
fisicamente ospitato su provider dell'infrastruttura cloud di livello 1 come
{{site.data.keyword.Bluemix}} e Amazon.
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

> **Nota:** ulteriori dettagli sulle certificazioni sono disponibili nelle [Informazioni sulla conformità](compliance.html).

## Controllo di accesso sicuro

È stata creata una moltitudine di funzioni in
{{site.data.keyword.cloudant_short_notm}},
per il controllo dell'accesso ai dati:

- Autenticazione: è possibile accedere a {{site.data.keyword.cloudant_short_notm}}
  utilizzando un'API HTTP.
  Dove l'endpoint API lo richiede,
  l'utente viene autenticato per ogni richiesta HTTPS o HTTP che
  {{site.data.keyword.cloudant_short_notm}} riceve.
- Autorizzazione: concedi le autorizzazioni di lettura,
  scrittura,
  ammin a database specifici.
- Crittografia "In elaborazione": tutto l'accesso a
  {{site.data.keyword.cloudant_short_notm}} è crittografato utilizzando HTTPS.
- Crittografia a riposo: i dati archiviati sul disco in
  {{site.data.keyword.cloudant_short_notm}} possono essere crittografati.
  I dati archiviati in un'istanza {{site.data.keyword.cloudant_short_notm}} sono sempre crittografati.
  {: tip}
  
- Accesso API: è possibile accedere a {{site.data.keyword.cloudant_short_notm}} in modo programmatico
  utilizzando un'API su HTTP sicuro (HTTPS).
  Le chiavi API possono essere generate utilizzando il dashboard
  {{site.data.keyword.cloudant_short_notm}}.
- Whitelist IP: i clienti {{site.data.keyword.cloudant_short_notm}} negli ambienti dedicati
  per {{site.data.keyword.cloudant_short_notm}} Enterprise o
  {{site.data.keyword.Bluemix_notm}} dedicato possono inserire gli indirizzi IP nella whitelist per limitare l'accesso ai soli utenti e server
  specificati. Nota che la whitelist di IP non è disponibile per tutti i piani {{site.data.keyword.cloudant_short_notm}}
  in {{site.data.keyword.Bluemix_notm}} pubblico. 
- CORS: abilita il supporto CORS per domini specifici utilizzando il dashboard
  {{site.data.keyword.cloudant_short_notm}}.

## Protezione contro la perdita o il danneggiamento dei dati

{{site.data.keyword.cloudant_short_notm}} dispone di numerose funzioni
per aiutarti a mantenere la disponibilità e la qualità dei dati:

- Archivio dei dati durevole e ridondante: per impostazione predefinita,
  {{site.data.keyword.cloudant_short_notm}} salva sul disco tre copie
  di ogni documento in tre diversi nodi in un cluster.
  Il salvataggio dei dati garantisce che una copia di failover funzionante dei tuoi dati
  sia sempre disponibile, indipendentemente dagli errori.
- Esportazione e replica dei dati: puoi replicare i tuoi database di continuo
  tra i cluster in diversi data center
  o in un cluster {{site.data.keyword.cloudant_short_notm}} locale installato in loco
  o Apache CouchDB.
  Un'altra opzione è di esportare i dati da
  {{site.data.keyword.cloudant_short_notm}} (nel formato JSON)
  in altre ubicazioni o origini (come il tuo data center) per la ridondanza dei dati aggiunti.
