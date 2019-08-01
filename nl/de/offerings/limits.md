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

# Grenzwerte
{: #limits}

Für die Nutzung von {{site.data.keyword.cloudant_short_notm}}-Datenbanken gelten die folgenden Grenzwerte:

## Datenbanken
{: #databases-overview}

|Beschreibung|Grenzwert|
|--|--|
|Datenbankgröße|unbegrenzt|
|Partitionsgröße|10 GB|


## Indizes
{: #indexes-overview}

|Beschreibung|Grenzwert|
|--|--|
|Anzahl globaler Indizes|unbegrenzt|
|Anzahl Partitionsindizes|10|

## Anforderungsnutzdaten
{: #request-payload-overview}

|Beschreibung|Grenzwert|
|--|--|
|Gesamtanforderungsgröße|10 MB|
|Dokumentgröße|1 MB|
|Anhangsgröße|10 MB|

## Anforderungszeitlimits
{: #request-timeouts}

|Beschreibung|Grenzwert|
|--|--|
|default|60 Sekunden|
|`_partition/*` |5 Sekunden|


## Abfrage
{: #query-results}

|Beschreibung|Grenzwert|
|--|--|
|default|unbegrenzt|
|`_partition/*` default|2000|
|`_search`|200|
|`_find` using `text` index|200|
