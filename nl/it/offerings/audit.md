---

copyright:
  years: 2015, 2018
lastupdated: "2018-04-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2018-00-00 -->

# Registrazione di controllo


La registrazione di controllo registra i principal {{site.data.keyword.cloudantfull}} che hanno eseguito l'accesso ai dati archiviati in {{site.data.keyword.cloudant_short_notm}}. Per tutto l'accesso API HTTP a {{site.data.keyword.cloudant_short_notm}}, la funzione di registrazione di controllo registra le seguenti informazioni su ciascuna richiesta HTTP:

Informazioni | Descrizione
------------|------------
`Principal` | Credenziali dell'account, chiave API o credenziali IAM IBM Cloud.
`Azione` | L'azione eseguita (ad esempio, documento letto).
`Risorsa` | Dettagli su account, database e documento a cui è stato eseguito l'accesso oppure oggetto della query.
`Data/ora` | Un record di ora e data dell'evento. 

I log di controllo {{site.data.keyword.cloudant_short_notm}} possono essere utilizzati per comprendere:

- A quali database e documenti è stato eseguito l'accesso in un account, quando e da chi.
- Quali query sono state eseguite, quando e da chi.
- Quale specifico principal o utente ha eseguito l'accesso, l'aggiornamento o l'eliminazione e quando.
- Quali documenti di replica sono stati creati o eliminati e quando.
{:shortdesc}

## Come accedere ai log di controllo per il tuo account

Per richiedere l'accesso ai log di controllo per il tuo account, contatta il supporto {{site.data.keyword.cloudant_short_notm}}. Il supporto fornirà l'accesso ai log di controllo di interesse.

Quando contatti il supporto, assicurati di includere:

- l'account {{site.data.keyword.cloudant_short_notm}} a cui è correlata la richiesta.
- Il lasso di tempo per i log di controllo (non deve essere superiore a un mese per ogni richiesta di supporto).
- Qualsiasi database, documento o principal specifico di interesse.
