---

copyright:
  years: 2015, 2019
lastupdated: "2019-03-15"

keywords: generate uuid, record payments, add additional documents, advantages

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

# {{site.data.keyword.cloudant_short_notm}}에서 관련 문서 그룹화
{: grouping-related-documents-together-in-ibm-cloudant}

전통적으로 전자상거래 시스템은 관계형 데이터베이스를 사용하여 빌드되어 왔습니다.
이러한 데이터베이스는 일반적으로 결합된 몇 가지 테이블을 사용하여
판매액, 고객 세부사항, 구매된 제품 및 배송 추적 정보를 기록합니다.
관계형 데이터베이스는 높은 일관성을 제공하며, 이는 애플리케이션 개발자가 콜렉션 간에 결합을 사용하거나,
오브젝트 상태 기록에 열거를 사용하거나, 원자적 오퍼레이션 보장을 위해 데이터베이스 트랜잭션을 사용하는 등과 같이 데이터베이스의 강점에 맞춰 애플리케이션을 개발할 수 있음을 의미합니다.

{{site.data.keyword.cloudantfull}}는 일관성보다 가용성을 중시합니다.
이는 결과적으로 일관된, 결함 내성이 강한 고가용성 분산 데이터베이스입니다.
이 데이터베이스는 고객의 쇼핑 서비스가 항상 사용 가능하며, 동시에 구매를 수행하는 여러 사용자를 수용할 수 있도록 충분히 확장 가능하다는 장점을 제공합니다.
이는 애플리케이션이 {{site.data.keyword.cloudant_short_notm}}를 관계형 데이터베이스로 취급하지 않고 이의 강점을 이용할 수 있음을 의미합니다.

이 주제의 내용은 다른 많은 영역에도 적용할 수 있는 개념을 사용하여 {{site.data.keyword.cloudant_short_notm}}의 강점을 이용하는 전자상거래 시스템을
빌드하는 데 관련된 몇 가지 요소를 간략히 설명하고 있으며, 예를 들면 다음과 같은 항목이 있습니다.

-   하나의 문서를 빈번히 업데이트하는 대신, 여러 문서를 사용하여 구매의 상태를 나타냅니다.
-   다른 콜렉션을 결합하는 대신 관련 오브젝트의 사본을 순서대로 저장합니다.
-   현재 구매 상태를 반영하기 위해 `order_id`로 문서를 비교하기 위한 보기를 작성합니다.

예를 들면, 주문된 품목, 고객 정보, 비용, 배송 정보 등의 세부사항을 포함하는 `purchase` 문서를 작성할 수 있습니다.

_특정 구매를 나타내는 문서 예:_

```json
{
    "_id": "023f7a21dbe8a4177a2816e4ad1ea27e",
    "type": "purchase",
    "order_id": "320afa89017426b994162ab004ce3383",
    "basket": [
        {
            "product_id": "A56",
            "title": "Adele - 25",
            "category": "Audio CD",
            "price": 8.33,
            "tax": 0.2,
            "quantity": 2
        },
        {
            "product_id": "B32",
            "title": "The Lady In The Van - Alan Bennett",
            "category": "Paperback book",
            "price": 3.49,
            "tax": 0,
            "quantity": 2
        }
    ],
    "account_id": "985522332",
    "delivery": {
        "option": "Next Day",
        "price": 2.99,
        "address": {
            "street": "17 Front Street",
            "town": "Middlemarch",
            "postcode": "W1A 1AA"
        }
    },
    "pretax" : 20.15,
    "tax" : 3.32,
    "total": 26.46
}
```
{: codeblock}

이 문서는 추가 레코드를 가져오지 않고 주문에 대한 요약을 웹 페이지 또는 이메일에 렌더링하는 데 필요한 구매 레코드에 대해 충분한 데이터를 제공합니다.
다음 항목을 포함한 주문의 주요 세부사항을 확인하십시오.

-   장바구니가 다른 위치에 저장된 제품의 데이터베이스에 대한 참조 ID(`product_id`)를 포함합니다.
-   장바구니가 구매 시점에 구매된 품목의 상태를 기록할 수 있을 정도로 이 레코드에 있는 제품 데이터의 일부를 복제합니다.
-   문서는 주문의 상태를 표시하는 필드를 포함하지 않습니다.
    지불 및 배송을 기록하기 위해 추가 문서가 나중에 추가됩니다.
-   데이터베이스는 문서를 데이터베이스에 삽입할 때 문서 `_id`를 자동으로 생성합니다.
-   나중에 주문을 참조하기 위해 각 구매 레코드에 고유 ID(`order_id`)가 함께 제공됩니다. 
 
고객이 발주할 때(일반적으로 웹 사이트의 "결제" 단계에 들어가는 시점), 이전 예와 유사한 구매 주문 레코드가 작성됩니다. 

## 고유 ID(UUID) 생성
{: #generating-your-own-unique-identifiers-uuids-}

관계형 데이터베이스에서는 종종 순차적 "자동 증가" 숫자가 사용되지만, 서버 클러스터에 데이터가 분산되는 분산 데이터베이스에서는 문서가 고유 ID를 사용하여 저장되도록 하기 위해 더 긴 UUID가 사용됩니다.

`order_id`와 같이 애플리케이션에서 사용할 고유 ID를 작성하려면 {{site.data.keyword.cloudant_short_notm}} API의
[`GET _uuids` 엔드포인트](/docs/services/Cloudant?topic=cloudant-advanced-api#-get-_uuids-)를 호출하십시오.
데이터베이스가 사용자를 대신하여 ID를 생성합니다.
이 엔드포인트는 `count` 매개변수를 추가함으로써(예: `/_uuids?count=10`)
여러 ID를 생성하는 경우에도 사용할 수 있습니다.

## 지불 기록
{: #recording-payments}

고객이 품목에 대해 지불을 완료하면 주문을 기록하기 위해 추가 레코드가 데이터베이스에 추가됩니다.

_지불 레코드의 예:_

```json
{
    "_id": "bf70c30ea5d8c3cd088fef98ad678e9e",
    "type": "payment",
    "account_id": "985522332",
    "order_id": "320afa89017426b994162ab004ce3383",
    "value": 6.46,
    "method": "credit card",
    "payment_reference": "AB9977G244FF2F667"
}
...
{
    "_id": "12c0ea6cd3d2c6e3b1d34442aea6a2d9",
    "type": "payment",
    "account_id": "985522332",
    "order_id": "320afa89017426b994162ab004ce3383",
    "value": 20.00,
    "method": "voucher",
    "payment_reference": "Q88775662377224"
}
```
{: codeblock}

이전 예에서, 고객은 신용카드 및 선불 바우처를 사용하여 지불을 수행했습니다.
두 지불의 총액은 주문의 금액으로 합산됩니다.
각 지불은 {{site.data.keyword.cloudant_short_notm}}에 개별 문서로 기록됩니다.

사용자는 `order_id`에 대해 알고 있는 모든 항목에 대한 보기를 작성하여 주문의 상태를 확인할 수 있습니다.
이 보기는 다음 정보를 포함하는 원장을 사용 가능하게 합니다. 

-   구매 총액(양수)
-   계정에 대한 지불 금액(음수)

필요한 값을 식별하기 위해 map 함수를 사용할 수 있습니다.

_구매 총액 및 지불 값을 찾기 위한 map 함수 예:_ 

```javascript
function (doc) {
    if (doc.type === 'purchase') {
        emit(doc.order_id, doc.total);
    } else {
        if (doc.type === 'payment') {
            emit(doc.order_id, -doc.value);
        }
    }
}
```
{: codeblock}

기본 제공 [`_sum` reducer](/docs/services/Cloudant?topic=cloudant-views-mapreduce#built-in-reduce-functions)를 사용하면 지불 이벤트의 원장으로 출력을 생성할 수 있습니다.

_`?reduce=false`로 조회된 기본 제공 `_sum` reduce 함수의 사용에 대한 예:_

```json
{
    "total_rows":3,"offset":0,"rows":[
        {
            "id":"320afa89017426b994162ab004ce3383",
            "key":"985522332",
            "value":26.46
        },
        {
            "id":"320afa89017426b994162ab004ce3383",
            "key":"985522332",
            "value":-20
        },
        {
            "id":"320afa89017426b994162ab004ce3383",
            "key":"985522332",
            "value":-6.46
        }
    ]
}
```
{: codeblock}

또는, `order_id`로 그룹화된 총액을 생성할 수 있습니다.

_`?group_level=1`을 사용하여 `order_id`로 그룹화된 총액의 예:_

```json
{
    "rows":[
        {
            "key":"320afa89017426b994162ab004ce3383",
            "value":0
        }
    ]
}
```
{: codeblock}

이전 예의 보기가 주문 값에 대해 0을 리턴하므로, 결과는 주문이 전액 지불되었음을 표시합니다.
이는 양의 구매 주문 총액이 음의 지불 금액을 상쇄시키기 때문입니다.
주문에 대한 문서 및 각 지불에 대한 문서와 같이 이벤트를 여러 개별 문서로 기록하면 여러 프로세스가 동일한 문서를 동시에 수정할 때 충돌이 발생할 가능성이 없어지므로 {{site.data.keyword.cloudant_short_notm}}에서는 이 작업 방식을 사용하는 것이 좋습니다.

## 추가 문서 추가
{: #adding-additional-documents}

주문이 처리되어 배송됨에 따라 다음 상태 변경사항을 기록하기 위해 별도의 문서를 추가할 수 있습니다.

-   배송 알림
-   배송 영수증
-   환불 레코드

{{site.data.keyword.cloudant_short_notm}}는 데이터가 도착하면 이를 각 문서에 개별적으로 기록합니다.
따라서 주 구매 문서를 수정할 필요는 없습니다.

## {{site.data.keyword.cloudant_short_notm}}에 구매 주문을 저장하는 것의 장점
{: #advantages-of-storing-purchase-orders-in-ibm-cloudant}

{{site.data.keyword.cloudant_short_notm}}를 사용하여 구매 주문 정보를 저장하면 고가용성 및 확장성을 갖춘 주문 시스템을 구축함으로써 많은 양의 데이터와 동시 액세스를 처리할 수 있습니다.
한 번만 기록되는 별도의 문서에 데이터를 모델링함으로써, 여러 개별 프로세스가 동일한 문서에 동시 액세스하는 등과 같이 문서가 충돌하는 상황을 방지할 수 있습니다.

또한, 문서는 외부 키와 결합하는 데 의존하기 보다 표시할 다른 콜렉션에 있는 데이터의 사본을 포함할 수 있습니다.
예를 들면, 구매 시 장바구니 상태를 기록하는 경우입니다.
이를 통해 `order_id`로 관련된 문서를 그룹화하는
{{site.data.keyword.cloudant_short_notm}}의 보기에 단일 호출로 주문 상태를 페치할 수 있습니다.
