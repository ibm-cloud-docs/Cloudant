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

# Creazione di una semplice applicazione {{site.data.keyword.cloud_notm}} per accedere a un database {{site.data.keyword.cloudant_short_notm}}: Prerequisiti

Questa sezione dell'esercitazione illustra i prerequisiti per la creazione di un'applicazione {{site.data.keyword.cloud}}.
{:shortdesc}

## Prerequisiti

Assicurati di avere le seguenti risorse o informazioni pronte
prima di iniziare ad utilizzare l'esercitazione.

### Python

Per tutto il lavoro di sviluppo ma nel modo più semplice possibile,
è più facile se disponi di un'installazione corrente del
[linguaggio di programmazione Python
![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://www.python.org/){:new_window}
nel tuo sistema.

Per verificare,
esegui il seguente comando quando richiesto:

```sh
python --version
```
{:pre}

È previsto un risultato simile al seguente output:

```
Python 2.7.12
```
{:codeblock}

<div id="csi"></div>

### Un'istanza del servizio {{site.data.keyword.cloudant_short_notm}} su {{site.data.keyword.cloud_notm}}

Un'esercitazione separata per la creazione di un'istanza del servizio {{site.data.keyword.cloudantfull}} denominata
'`Cloudant Service 2017`' è disponibile [qui](create_service.html).

Questa esercitazione presuppone che hai già creato un'istanza del servizio denominata
'`Cloudant Service 2017`'.

### Un'applicazione database {{site.data.keyword.cloudant_short_notm}}

Un'esercitazione separata per la creazione di un'applicazione Python autonoma
da utilizzare con un'istanza del servizio {{site.data.keyword.cloudant_short_notm}}
è disponibile [qui](create_database.html).
Introduce diversi concetti utili per comprendere come creare e popolare un database {{site.data.keyword.cloudant_short_notm}}.

Questa esercitazione presuppone che tu abbia familiarità con questi concetti.

## Passo successivo

Il passo successivo nell'esercitazione è di [creare l'ambiente dell'applicazione](create_bmxapp_appenv.html).
