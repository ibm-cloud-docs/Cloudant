---

copyright:
  years: 2017, 2018
lastupdated: "2018-06-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-01-10 -->

# Creazione di una semplice applicazione {{site.data.keyword.Bluemix_notm}} per accedere a un database {{site.data.keyword.cloudant_short_notm}}

Questa esercitazione illustra come creare un'applicazione {{site.data.keyword.Bluemix}} che utilizza
[Python programming language ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://www.python.org/){:new_window}
per accedere a un database {{site.data.keyword.cloudantfull}},
ospitato nella tua istanza del servizio {{site.data.keyword.Bluemix_notm}}.
{:shortdesc}

## Contesto

Un vantaggio significativo di {{site.data.keyword.Bluemix_notm}} è che puoi creare e distribuire le applicazioni nello stesso
{{site.data.keyword.Bluemix_notm}}.
Non devi trovare e gestire un server per eseguire le tue applicazioni.

Se stai già utilizzando un'istanza del database {{site.data.keyword.cloudant_short_notm}}
in {{site.data.keyword.Bluemix_notm}},
ha senso che anche le tue applicazioni si trovino nello stesso posto.

Le applicazioni {{site.data.keyword.Bluemix_notm}} vengono normalmente create utilizzando la tecnologia
[Cloud Foundry ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://en.wikipedia.org/wiki/Cloud_Foundry){:new_window}.
Cloud Foundry offre una funzionalità PaaS (platform-as-a-service)
che semplifica il processo di creazione delle applicazioni e che può essere distribuita ed eseguita
in un ambiente cloud.

[Un'esercitazione separata](create_database.html) ti ha illustrato come creare un'applicazione Python autonoma
che utilizza un'istanza del database {{site.data.keyword.cloudant_short_notm}}
in {{site.data.keyword.Bluemix_notm}}.
In questa esercitazione,
hai creato e configurato una piccola applicazione Python ospitata in {{site.data.keyword.Bluemix_notm}}.
L'applicazione si connette alla tua istanza del database {{site.data.keyword.cloudant_short_notm}}
e crea un solo documento semplice.

Il codice Python specifico per ogni attività viene fornito come parte di questa esercitazione.
Un programma Python completo,
sufficiente a dimostrare i concetti,
viene fornito nell'esercitazione,
[qui](create_bmxapp_createapp.html#complete-listing).

Non è stato effettuato un tentativo di creare del codice Python _efficiente_ per questa esercitazione;
l'intenzione è di mostrare un codice funzionante semplice e di facile comprensione
che puoi utilizzare e applicare alle tue proprie applicazioni.

Inoltre,
non è stato effettuato un tentativo di affrontare tutti i controlli possibili o le condizioni di errore.
Alcuni controlli di esempio sono inclusi per illustrare alcune tecniche,
ma dovresti utilizzare le procedure consigliate normali per il controllo e la gestione di tutte
le avvertenze e le condizioni di errore riscontrate dalle tue proprie applicazioni.

## Panoramica dell'attività

Per creare un'applicazione Python funzionante in {{site.data.keyword.Bluemix_notm}}
che può accedere a un'istanza del database {{site.data.keyword.cloudant_short_notm}} ,
devi eseguire le seguenti attività:

-   [Crea un ambiente dell'applicazione Python in {{site.data.keyword.Bluemix_notm}}.](create_bmxapp_appenv.html#creating)
-   [Assicurati che l'ambiente dell'applicazione Python disponga di una 'connessione' a un'istanza del database {{site.data.keyword.cloudant_short_notm}}.](create_bmxapp_appenv.html#connecting)
-   [(Attività singola) Scarica e installa i toolkit a riga di comando Cloud Foundry e {{site.data.keyword.Bluemix_notm}}.](create_bmxapp_appenv.html#toolkits)
-   [Scarica l'applicazione 'starter'.](create_bmxapp_appenv.html#starter)
-   [Personalizza l'applicazione starter per creare la tua propria applicazione per accedere all'istanza del database {{site.data.keyword.cloudant_short_notm}}.](create_bmxapp_createapp.html#theApp)
-   [Carica la tua applicazione e verifica che funzioni.](create_bmxapp_upload.html#uploading)
-   [Esegui le attività di manutenzione dell'applicazione di base.](create_bmxapp_maintain.html#maintenance)
-   [Diagnostica e risolvi i problemi (risoluzione dei problemi).](create_bmxapp_maintain.html#troubleshooting)

## Struttura dell'esercitazione

L'esercitazione è formata da cinque sezioni:

1.  [Prerequisiti](create_bmxapp_prereq.html)
2.  [L'ambiente dell'applicazione](create_bmxapp_appenv.html)
3.  [Creazione della tua applicazione](create_bmxapp_createapp.html)
4.  [Caricamento ed esecuzione della tua applicazione](create_bmxapp_upload.html)
5.  [Manutenzione e risoluzione dei problemi della tua applicazione](create_bmxapp_maintain.html)

## Passo successivo

Per avviare l'esercitazione,
inizia [controllando i prerequisiti](create_bmxapp_prereq.html).
