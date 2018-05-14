---

copyright:
  years: 2017
lastupdated: "2017-01-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-01-10 -->

# Creazione di un'applicazione Bluemix di esempio per accedere a un database Cloudant: prerequisiti 

Questa sezione dell'esercitazione illustra i prerequisiti per la creazione di un'applicazione {{site.data.keyword.Bluemix}}.
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

### Un'istanza del servizio Cloudant su Bluemix

Un'esercitazione separata per la creazione di un'istanza del servizio {{site.data.keyword.cloudant_short_notm}} denominata
'`Cloudant Service 2017`' è disponibile [qui](create_service.html).

Questa esercitazione presuppone che hai già creato un'istanza del servizio denominata
'`Cloudant Service 2017`'.

### Un'applicazione del database Cloudant 

Un'esercitazione separata per la creazione di un'applicazione Python autonoma
da utilizzare con l'istanza del servizio {{site.data.keyword.cloudant_short_notm}}
è disponibile [qui](create_database.html).
Introduce molti concetti utili per comprendere come creare e popolare un database
{{site.data.keyword.cloudant_short_notm}}.

Questa esercitazione presuppone che tu abbia familiarità con questi concetti.

## Passo successivo

Il passo successivo nell'esercitazione è di [creare l'ambiente dell'applicazione](create_bmxapp_appenv.html).
