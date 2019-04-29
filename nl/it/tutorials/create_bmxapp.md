---

copyright:
  years: 2017, 2019
lastupdated: "2019-03-19"

keywords: create applications, deploy applications, create simple application

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

# Creazione di una semplice applicazione {{site.data.keyword.cloud_notm}} per accedere a un database {{site.data.keyword.cloudant_short_notm}}
{: #creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database}

Questa esercitazione illustra come creare un'applicazione {{site.data.keyword.cloud}} che utilizza il
[linguaggio di programmazione Python ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://www.python.org/){: new_window}
per accedere a un database {{site.data.keyword.cloudantfull}},
ospitato nella tua istanza del servizio {{site.data.keyword.cloud_notm}}.
{: shortdesc}

## Vantaggi di {{site.data.keyword.cloud_notm}}
{: #advantages-of-ibm-cloud}

Un vantaggio significativo di {{site.data.keyword.cloud}} è che puoi creare e distribuire le applicazioni nello stesso
{{site.data.keyword.cloud_notm}}.
Non devi trovare e gestire un server per eseguire le tue applicazioni.

Se stai già utilizzando un'istanza del database {{site.data.keyword.cloudant_short_notm}}
in {{site.data.keyword.cloud_notm}},
ha senso che anche le tue applicazioni si trovino nello stesso posto.

Le applicazioni {{site.data.keyword.cloud_notm}} vengono normalmente create utilizzando la tecnologia
[Cloud Foundry ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://en.wikipedia.org/wiki/Cloud_Foundry){: new_window}.
Cloud Foundry offre una funzionalità PaaS (platform-as-a-service)
che semplifica il processo di creazione delle applicazioni e che può essere distribuita ed eseguita
in un ambiente cloud.

[Un'esercitazione separata](/docs/services/Cloudant?topic=cloudant-creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud#creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud) ti ha illustrato come creare un'applicazione Python autonoma
che utilizza un'istanza del database {{site.data.keyword.cloudant_short_notm}}
in {{site.data.keyword.cloud_notm}}.
In questa esercitazione,
hai creato e configurato una piccola applicazione Python ospitata in {{site.data.keyword.cloud_notm}}.
L'applicazione si connette alla tua istanza del database {{site.data.keyword.cloudant_short_notm}}
e crea un solo documento semplice.

Il codice Python specifico per ogni attività viene fornito come parte di questa esercitazione.
Un programma Python completo,
sufficiente a dimostrare i concetti,
viene fornito nell'esercitazione,
[qui](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-code#complete-python-program).

Non è stato effettuato un tentativo di creare del codice Python _efficiente_ per questa esercitazione;
l'intenzione è di mostrare un codice funzionante semplice e di facile comprensione
che puoi utilizzare e applicare alle tue proprie applicazioni.

Inoltre,
non è stato effettuato un tentativo di affrontare tutti i controlli possibili o le condizioni di errore.
Alcuni controlli di esempio sono inclusi per illustrare alcune tecniche,
ma dovresti utilizzare le procedure consigliate normali per il controllo e la gestione di tutte
le avvertenze e le condizioni di errore riscontrate dalle tue proprie applicazioni.

## Panoramica dell'attività
{: #task-overview}

Per creare un'applicazione Python funzionante in {{site.data.keyword.cloud_notm}}
che può accedere a un'istanza del database {{site.data.keyword.cloudant_short_notm}} ,
devi eseguire le seguenti attività:

-   [Crea un ambiente dell'applicazione Python in {{site.data.keyword.cloud_notm}}.](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#creating-an-ibm-cloud-application-environment)
-   [Assicurati che l'ambiente dell'applicazione Python disponga di una 'connessione' a un'istanza del database {{site.data.keyword.cloudant_short_notm}}.](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#connecting-ibm-cloud-applications-and-services)
-   [(Attività singola) Scarica e installa i toolkit a riga di comando Cloud Foundry e {{site.data.keyword.cloud_notm}}.](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#the-cloud-foundry-and-ibm-cloud-command-toolkits)
-   [Scarica l'applicazione 'starter'.](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#the-starter-application)
-   [Personalizza l'applicazione starter per creare la tua propria applicazione per accedere all'istanza del database {{site.data.keyword.cloudant_short_notm}}.](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-code#the-application-code)
-   [Carica la tua applicazione e verifica che funzioni.](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-uploading-the-application#uploading-the-application)
-   [Esegui le attività di manutenzione dell'applicazione di base.](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting)
-   [Diagnostica e risolvi i problemi (risoluzione dei problemi).](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting#diagnosing-and-resolving-problems)

## Struttura dell'esercitazione
{: #tutorial-structure}

L'esercitazione è formata da cinque sezioni:

1.  [Prerequisiti](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites)
2.  [L'ambiente dell'applicazione](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment)
3.  [Creazione della tua applicazione](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-code#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-code)
4.  [Caricamento ed esecuzione della tua applicazione](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-uploading-the-application#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-uploading-the-application)
5.  [Manutenzione e risoluzione dei problemi della tua applicazione](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting)

Per iniziare l'esercitazione, parti dal
[controllo dei prerequisiti](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites).
