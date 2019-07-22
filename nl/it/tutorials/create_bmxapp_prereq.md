---

copyright:
  years: 2017, 2019
lastupdated: "2019-06-12"

keywords: python, create service instance, create stand-alone python application

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

# Creazione di una semplice applicazione {{site.data.keyword.cloud_notm}} per accedere a un database {{site.data.keyword.cloudant_short_notm}}: Prerequisiti
{: #creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites}

Questa sezione dell'esercitazione illustra i prerequisiti per la creazione di un'applicazione {{site.data.keyword.cloud}}.
{: shortdesc}

## Prerequisiti
{: #prerequisites-create_bmxapp_prereq}

Assicurati di avere le seguenti risorse o informazioni pronte
prima di iniziare ad utilizzare l'esercitazione.

### Python
{: #python-create-bmxapp-prereq}

Per tutto il lavoro di sviluppo ma nel modo più semplice possibile,
è più facile se disponi di un'installazione corrente del
[linguaggio di programmazione Python
![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://www.python.org/){: new_window}
nel tuo sistema.

Per verificare,
esegui il seguente comando quando richiesto:

```sh
python --version
```
{: pre}

È previsto un risultato simile al seguente output:

```
Python 2.7.12
```
{: codeblock}

### Un'istanza del servizio {{site.data.keyword.cloudant_short_notm}} su {{site.data.keyword.cloud_notm}}
{: #an-ibm-cloudant-service-instance-on-ibm-cloud}

Un'esercitazione separata per la [creazione di un'istanza del servizio {{site.data.keyword.cloudantfull}} su {{site.data.keyword.cloud_notm}}](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-an-ibm-cloudant-instance-on-ibm-cloud) crea un'istanza del servizio denominata
'`Cloudant-o7`'. 

Questa esercitazione presuppone che hai già creato un'istanza del servizio denominata
'`Cloudant-o7`'.

### Un'applicazione database {{site.data.keyword.cloudant_short_notm}}
{: #an-ibm-cloudant-database-application}

È inoltre disponibile un'esercitazione separata per la [creazione di un'applicazione Python autonoma
da utilizzare con un'istanza del servizio
{{site.data.keyword.cloudant_short_notm}}] (/docs/services/Cloudant?topic=cloudant-creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud#creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud). Introduce diversi concetti utili per comprendere come creare e popolare un database {{site.data.keyword.cloudant_short_notm}}.

Questa esercitazione presuppone che tu abbia familiarità con questi concetti.

Il passo successivo nell'esercitazione è di [creare l'ambiente dell'applicazione](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment).
