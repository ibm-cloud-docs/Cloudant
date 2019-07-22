---

copyright:
  years: 2019
lastupdated: "2019-06-12"

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

# Límites
{: #limits}

Las bases de datos de {{site.data.keyword.cloudant_short_notm}} están sujetas a los límites siguientes en relación con su uso:

## Bases de datos
{: #databases-overview}

|Descripción|Límite|
|--|--|
|Tamaño de base de datos|Ilimitado|
|Tamaño de partición|10 GB|


## Índices
{: #indexes-overview}

|Descripción|Límite|
|--|--|
|Número de índices globales|Ilimitado|
|Número de índices de partición|10|

## Carga útil de solicitud
{: #request-payload-overview}

|Descripción|Límite|
|--|--|
|Tamaño total de solicitud|10 MB|
|Tamaño de documento|1 MB|
|Tamaño de archivo adjunto|10 MB|

## Tiempos de espera de solicitud
{: #request-timeouts}

|Descripción|Límite|
|--|--|
|Predeterminado|60 segundos|
|`_partition/*` |5 segundos|


## Consulta
{: #query-results}

|Descripción|Límite|
|--|--|
|Predeterminado|Ilimitado|
|`_partition/*` predeterminada|2000|
|`_search`|200|
|`_find` utilizando índice de `text`|200|
