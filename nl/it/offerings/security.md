---

copyright:
  years: 2017
lastupdated: "2017-07-13"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-04-28 -->

# Sicurezza

## Sicurezza e protezione dei dati DBaaS Cloudant

Proteggere i dati dell'applicazione su larga scala per le applicazioni mobili e web può essere complesso,
specialmente quando distribuiti a database NoSQL.

Nello stesso modo in cui riduce lo sforzo di conservare i tuoi database,
per mantenerli in esecuzione e in crescita continua,
{{site.data.keyword.cloudantfull}} garantisce inoltre che i tuoi dati siano sicuri e protetti.

## Piattaforme fisiche di livello superiore

DBaaS {{site.data.keyword.cloudant_short_notm}} è
fisicamente ospitato su provider dell'infrastruttura cloud di livello 1 come
{{site.data.keyword.BluSoftlayer_full}} e Amazon.
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
  {{site.data.keyword.cloudant_short_notm}} è codificato utilizzando HTTPS.
- Crittografia a riposo: i dati archiviati sul disco in
  {{site.data.keyword.cloudant_short_notm}} possono essere codificati.
  > **Nota**: i dati archiviati in un'istanza {{site.data.keyword.Bluemix_notm}} {{site.data.keyword.cloudant_short_notm}} sono sempre codificati.
- Accesso API: è possibile accedere a {{site.data.keyword.cloudant_short_notm}} in modo programmatico
  utilizzando un'API su HTTP sicuro (HTTPS).
  Le chiavi API possono essere generate utilizzando il dashboard
  {{site.data.keyword.cloudant_short_notm}}.
- Inserimento IP nell'elenco elementi consentiti: i clienti {{site.data.keyword.cloudant_short_notm}} su ambienti dedicati
  possono inserire gli indirizzi IP nell'elenco elementi consentiti per limitare l'accesso a solo gli utenti e i server specificati.
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
  o in un cluster locale Cloudant in loco
  o in Apache CouchDB.
  Un'altra opzione è di esportare i dati da
  {{site.data.keyword.cloudant_short_notm}} (nel formato JSON)
  in altre ubicazioni o origini (come il tuo proprio data center) per la ridondanza dei dati aggiunti.
