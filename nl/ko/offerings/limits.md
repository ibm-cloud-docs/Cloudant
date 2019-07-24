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

# 한계
{: #limits}

{{site.data.keyword.cloudant_short_notm}} 데이터베이스에는 사용량과 관련된 다음 한계가 적용됩니다.

## 데이터베이스
{: #databases-overview}

|설명|한계|
|--|--|
|데이터베이스 크기|무제한|
|파티션 크기|10GB|


## 인덱스
{: #indexes-overview}

|설명|한계|
|--|--|
|# 글로벌 인덱스|무제한|
|# 파티션 인덱스|10|

## 요청 페이로드
{: #request-payload-overview}

|설명|한계|
|--|--|
|총 요청 크기| 10MB|
|문서 크기|1MB|
|첨부 파일 크기| 10MB|

## 요청 제한시간
{: #request-timeouts}

|설명|한계|
|--|--|
|기본값|60초|
|`_partition/*` |5초|


## 조회
{: #query-results}

|설명|한계|
|--|--|
|기본값|무제한|
|`_partition/*` 기본값|2000|
|`_search`|200|
|`text` 인덱스를 사용하는 `_find`|200|
