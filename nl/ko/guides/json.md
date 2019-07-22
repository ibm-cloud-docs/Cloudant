---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: numbers, strings, booleans, arrays, objects

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

# JSON
{: #json}

{{site.data.keyword.cloudantfull}}에 전송하고 이로부터 수신하는 요청 및 응답의 대부분은 데이터 및 응답의 컨텐츠 및 구조 형식화에
[JSON(JavaScript Object Notation) ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://en.wikipedia.org/wiki/JSON){: new_window}을 사용합니다.
{: shortdesc}

{{site.data.keyword.cloudant_short_notm}} 데이터베이스에서 JSON 오브젝트는 데이터베이스 내의 모든 문서를 포함하여 다양한 구조를 나타내는 데 사용됩니다.

JSON에서 JavaScript 오브젝트로의 구문 분석은 Javascript의 `JSON.parse()` 함수를 통해서, 또는
컨텐츠를 JavaScript 오브젝트로 구문 분석하는 다양한 [라이브러리](/docs/services/Cloudant?topic=cloudant-client-libraries#client-libraries)를 통해서 지원됩니다. JSON 구문 분석 및 생성을 위한 라이브러리는 많은 주요 프로그래밍 언어에서 사용 가능합니다.

JSON이 사용되는 이유는 웹 브라우저를 사용한 데이터 관련 작업에 대한 가장 간단하고 쉬운 솔루션이기 때문입니다.
이는 JSON이 평가 가능하며 웹 브라우저 환경에서 JavaScript 오브젝트로 사용할 수 있기 때문입니다.
JSON은 또한 {{site.data.keyword.cloudant_short_notm}} 내에서 사용되는 서버 측 JavaScript와 통합됩니다.
JSON 문서는 항상 UTF-8로 인코딩됩니다.

다음 사항을 확인하기 위해 주의하십시오.
-   JSON 구조가 유효한지 확인하십시오.
-   {{site.data.keyword.cloudant_short_notm}}에서 검색한 JSON 문서의 문자열을 표준화하는지 확인하십시오.

JSON에서는 JavaScript와 동일한 기본 유형을 지원합니다.

-   [숫자](#numbers)
-   [문자열](#strings)
-   [부울](#booleans)
-   [배열](#arrays)
-   [오브젝트](#objects)

## 숫자
{: #numbers}

숫자는 정수 또는 부동 소수점 값일 수 있습니다.

_JSON 형식의 숫자 예:_

```json
123
```
{: codeblock}

## 문자열
{: #strings}

문자열은 큰 따옴표로 묶어야 합니다. 문자열은 유니코드 문자 및 백슬래시 이스케이프를 지원합니다.

_JSON 형식의 문자열 예:_

```json
"A String"
```
{: codeblock}

## 부울
{: #booleans}

`true` 또는 `false` 값입니다.

_JSON 형식의 부울 예:_

```json
{
  "value": true
}
```
{: codeblock}

## 배열
{: #arrays}

대괄호로 묶인 값의 목록입니다. 묶이는 값은 모두 유효한 JSON일 수 있습니다.

_JSON 형식의 배열 예:_

```json
[
    "one",
    2,
    "three",
    [],
    true,
    {
        "foo":
        "bar"
    }
]
```
{: codeblock}

_JSON 형식의 배열 예(선형):_

```json
[ "one", 2, "three", [], true, { "foo": "bar" } ]
```
{: codeblock}

## 오브젝트
{: #objects}

연관 배열 또는 해시와 같은 키/값 쌍의 세트입니다.
키는 문자열이어야 하지만, 값은 지원되는 모든 JSON 값일 수 있습니다.

_JSON 오브젝트의 예:_

```json
{
    "servings" : 4,
    "subtitle" : "Easy to make in advance, and then cook when ready",
    "cooktime" : 60,
    "title" : "Chicken Coriander"
}
```
{: codeblock}
