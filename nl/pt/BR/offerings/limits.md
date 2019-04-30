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

# Limites
{: #limits}

Os bancos de dados do {{site.data.keyword.cloudant_short_notm}} estão sujeitos aos limites a seguir que pertencem a seu uso:

## Banco de dados
{: #databases-overview}

|Descrição|Limite|
|--|--|
|tamanho do banco de dados|sem limite|
|tamanho da partição|10 GB|


## Índices
{: #indexes-overview}

|Descrição|Limite|
|--|--|
|# índices globais|sem limite|
|# índices de partição|10|

## Solicitar carga útil
{: #request-payload-overview}

|Descrição|Limite|
|--|--|
|tamanho total da solicitação|10 MB|
|tamanho do documento|1 MB|
|tamanho do anexo|10 MB|

## Tempos limite da solicitação
{: #request-timeouts}

|Descrição|Limite|
|--|--|
|Padrão|60 segundos|
|`_partição/ *` |5 segundos|


## Query
{: #query-results}

|Descrição|Limite|
|--|--|
|Padrão|sem limite|
|`_partition/*` padrão|2000|
|`_search`|200|
|`_find` usando o índice `text`|200|
