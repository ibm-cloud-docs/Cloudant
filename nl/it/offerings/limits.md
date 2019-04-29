---

copyright:
  years: 2019
lastupdated: "2019-02-25"

keywords: databases, indexes, request payload, request timeouts, query

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

<!-- Acrolinx: 2019-01-11 -->

# Limiti
{: #limits}

I database {{site.data.keyword.cloudant_short_notm}} sono soggetti ai seguenti limiti che si riferiscono al suo utilizzo: 

## Database
{: #databases-overview}

|Descrizione|Limite|
|--|--|
|dimensione database|illimitato|
|dimensione partizione|10 GB|


## Indici
{: #indexes-overview}

|Descrizione|Limite|
|--|--|
|N. indici globali|illimitato|
|N. indici partizione|10|

## Payload della richiesta
{: #request-payload-overview}

|Descrizione|Limite|
|--|--|
|dimensione richiesta totale|10 MB|
|dimensione documento|1 MB|
|dimensione allegato|10 MB|

## Timeout della richiesta
{: #request-timeouts}

|Descrizione|Limite|
|--|--|
|predefinito|60 secondi|
|`_partition/*` |5 secondi|


## Query
{: #query-results}

|Descrizione|Limite|
|--|--|
|predefinito|illimitato|
|`_partition/*` predefinito|2000|
|`_search`|200|
|`_find` utilizzando indice `text`|200|
