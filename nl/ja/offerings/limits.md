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

# 制限
{: #limits}

{{site.data.keyword.cloudant_short_notm}} データベースは、その使用法に関する以下の制限が適用されます。

## データベース
{: #databases-overview}

|説明|制限|
|--|--|
|データベース・サイズ|制限なし|
|パーティション・サイズ|10 GB|


## 索引
{: #indexes-overview}

|説明|制限|
|--|--|
|# グローバル索引|制限なし|
|# パーティション化索引|10|

## 要求ペイロード
{: #request-payload-overview}

|説明|制限|
|--|--|
|合計要求サイズ|10 MB|
|文書のサイズ|1 MB|
|添付ファイルのサイズ|10 MB|

## 要求のタイムアウト
{: #request-timeouts}

|説明|制限|
|--|--|
|デフォルト|60 秒|
|`_partition/*` |5 秒|


## 照会
{: #query-results}

|説明|制限|
|--|--|
|デフォルト|制限なし|
|`_partition/*` デフォルト|2000|
|`_search`|200|
|`_find` (`text` 索引を使用)|200|
