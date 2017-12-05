---

copyright:
  years: 2015, 2017
lastupdated: "2017-08-25"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-03-16 -->

# Offerta Cloudant

## DBaaS (database as a service) 

Cloudant è un DBaaS (database as a service) ospitato e completamente gestito.
È costruito interamente per una capacità di scala a livello globale, un'esecuzione
senza interruzioni e una capacità di gestione di un'ampia gamma di tipi di dati come [JSON](../basics/index.html#json),
[full-text](../api/cloudant_query.html#creating-an-index),
e [geospaziali](../api/cloudant-geo.html).
Cloudant è
un archivio dati operativo ottimizzato per gestire letture e scritture simultanee e abilitare un'elevata disponibilità e durabilità dei dati.

Fornisce un'[API HTTP](../basics/index.html#http-api) per utilizzare i tuoi dati [JSON](../basics/index.html#json)
e una manutenzione e un supporto operativo di 24 ore.
Cloudant si basa su [Apache CouchDB ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://couchdb.apache.org/){:new_window}
e viene fornito come vari servizi a più tenant,
dedicati e installati.

>   **Nota**: tutti i valori della valuta in questo documento sono in dollari americani ($).

L'offerta DBaaS di Cloudant è disponibile tramite [https://cloudant.com/ ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://cloudant.com/){:new_window}.
Viene offerto come un [Piano condiviso](#shared-plan),
o un [Piano Enterprise (dedicato)](#enterprise-plan).

Cloudant è anche disponibile come un [servizio IBM Bluemix](bluemix.html).

>	**Nota:** le offerte [piano condiviso](#shared-plan) e [piano Enterprise (dedicato)](#enterprise-plan) di Cloudant
non sono disponibili nel [servizio IBM Bluemix](bluemix.html).

### Piano condiviso

Con il piano condiviso di Cloudant,
hai accesso a tutte le funzionalità DBaaS Cloudant,
fornite tramite un cluster condiviso o a 'più tenant'.

Il prezzo viene calcolato
in base al tuo utilizzo mensile.
Non viene addebitato nulla se il tuo utilizzo mensile è inferiore a $50.00 (come ad agosto 2016).

Per ulteriori informazioni, consulta
[pricing details ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://cloudant.com/product/pricing/){:new_window}.

### Piano Enterprise

Con il piano Enterprise di Cloudant,
hai accesso a tutte le funzionalità DBaaS Cloudant,
fornite tramite un cluster dedicato a singolo tenant.

Questo piano ti fornisce tempo di funzionamento e prestazioni del database garantiti
utilizzando l'hardware o i cluster DBaaS dedicati disponibili in varie ubicazioni di hosting.

Per ulteriori informazioni, consulta
[pricing details ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://cloudant.com/product/pricing/){:new_window}.

## Cloudant Local

[IBM Cloudant Data Layer Local Edition (Cloudant Local) ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/support/knowledgecenter/SSTPQH_1.0.0/com.ibm.cloudant.local.doc/SSTPQH_1.0.0_welcome.html){:new_window}
è una versione installata locale dell'offerta DBaaS (database as a service) Cloudant.

Cloudant Local ti fornisce le stesse funzionalità di base dell'offerta a singolo tenant Cloudant completa
ma è ospitata nel tuo proprio data center.

Una panoramica più dettagliata di Cloudant Local è
[disponibile
![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://www-01.ibm.com/support/knowledgecenter/SSTPQH_1.0.0/com.ibm.cloudant.local.install.doc/topics/clinstall_cloudant_local_overview.html?lang=en-us){:new_window}.
[IBM Knowledge Center
![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://www-01.ibm.com/support/knowledgecenter/SSTPQH_1.0.0/com.ibm.cloudant.local.doc/SSTPQH_1.0.0_welcome.html?lang=en){:new_window}
fornisce informazioni su molti aspetti di Cloudant Local,
incluso:

-   [Installation and Configuration ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://www.ibm.com/support/knowledgecenter/SSTPQH_1.0.0/com.ibm.cloudant.local.install.doc/topics/clinstall_extract_install_cloudant_local.html?lang=en){:new_window}.
-   [Maintenance Tasks ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://www-01.ibm.com/support/knowledgecenter/SSTPQH_1.0.0/com.ibm.cloudant.local.install.doc/topics/clinstall_maintenance_tasks_overview.html?lang=en){:new_window}.
-   [Tuning replication parameters ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://www-01.ibm.com/support/knowledgecenter/SSTPQH_1.0.0/com.ibm.cloudant.local.install.doc/topics/clinstall_tuning_parameters_replication_cases.html?lang=en){:new_window}.

## [Sicurezza](security.html)

Le funzioni di controllo dell'accesso,
di crittografia e di
backup dei dati, consentono ai clienti nei settori dii servizi finanziari,
governativi,
di e-commerce,
delle telecomunicazioni,
di assistenza sanitaria e
altri che pensano molto alla sicurezza di avere vantaggi da {{site.data.keyword.cloudantfull}}.

## [Conformità](compliance.html)

{{site.data.keyword.cloudant_short_notm}} fornisce un sistema di database cloud affidabile e sicuro.
Il servizio è integrato con i migliori standard,
incluso ISO 27001:2013.

Ulteriori dettagli sulla governance e sulla privacy dei dati {{site.data.keyword.cloudant_short_notm}}
[sono disponibili](dataprivacygovernance.html).
