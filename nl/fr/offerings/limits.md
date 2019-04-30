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

Les limites d'utilisation ci-après s'appliquent aux bases de données {{site.data.keyword.cloudant_short_notm}} :

## Bases de données
{: #databases-overview}

|Description|Limite|
|--|--|
|taille de base de données|illimité|
|taille de partition|10 Go|


## Index
{: #indexes-overview}

|Description|Limite|
|--|--|
|Nb d'index globaux|illimité|
|Nb d'index de partition|10|

## Contenu de la demande
{: #request-payload-overview}

|Description|Limite|
|--|--|
|taille de demande totale|10 Mo|
|taille de document|1 Mo|
|taille de pièce jointe|10 Mo|

## Délai d'attente de la demande
{: #request-timeouts}

|Description|Limite|
|--|--|
|défaut|60 secondes|
|`_partition/*` |5 secondes|


## Requête
{: #query-results}

|Description|Limite|
|--|--|
|défaut|illimité|
|`_partition/*` défaut|2000|
|`_search`|200|
|`_find` en utilisant l'index de `texte`|200|
