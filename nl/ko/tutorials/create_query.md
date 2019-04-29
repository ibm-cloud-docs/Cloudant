---

copyright:
  years: 2017, 2019
lastupdated: "2019-03-19"

keywords: create database, create documents, create index, create query, run query, fields, operators

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

# {{site.data.keyword.cloudant_short_notm}} 조회 작성
{: #creating-an-ibm-cloudant-query}

이 튜토리얼에서는 데이터베이스를 작성하고, 이를 문서로 채우고, 인덱스를 작성하고, 인덱스를 사용하여 데이터베이스를 조회하는 방법을 보여줍니다.
{: shortdesc}

![명령행 아이콘](../images/CommandLineIcon.png) _명령행_과 ![대시보드 아이콘](../images/DashboardIcon.png) _{{site.data.keyword.cloud}} 대시보드_를
사용하는 실습이 모두 제공됩니다. {{site.data.keyword.cloud_notm}} 대시보드 실습은 사용자에게 각 태스크에 대한 시각적 예를 제공합니다. 자세한 정보를 얻으려는 경우에는 튜토리얼 전체에 제공된 링크를 따라 이동할 수 있습니다.

먼저, 사용자는 `query-demo` 데이터베이스와 이러한 실습에 필요한 데이터를 포함하는 몇 가지 문서를 작성합니다.

## 가정
{: ##assumptions}

시작하기 전에 다음 단계에 따라 튜토리얼을 진행할 준비를 하십시오.

1.  [{{site.data.keyword.cloud_notm}} 계정을 작성하십시오. ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://cloud.ibm.com/registration){: new_window}
2.  [{{site.data.keyword.cloud_notm}} 대시보드 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://cloud.ibm.com/catalog/services/cloudant){: new_window}에 로그인하십시오.
3.  [{{site.data.keyword.cloud_notm}}에서 {{site.data.keyword.cloudant_short_notm}} 인스턴스를 작성하십시오](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-a-service-instance).
4.  (선택사항) 명령행에서 더 쉽고 빠르게 명령을 실행할 수 있도록 [acurl 별명을 작성하십시오](/docs/services/Cloudant?topic=cloudant-authorized-curl-acurl-#authorized-curl-acurl-).
5.  실습에 포함된 명령의 `$ACCOUNT` 변수를 {{site.data.keyword.cloudant_short_notm}} 대시보드에 로그인할 때 사용하는 사용자 이름으로 대체하십시오.
  `acurl`을 설정하지 않기로 결정하는 경우에는 실습에 제공된 URL 대신 다음 URL을 사용하십시오.
  ``` sh
  curl https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com/query-demo
  ```
  {: codeblock}

## `query-demo` 데이터베이스 작성
{: #creating-the-query-demo-database}

이 섹션에서는 이 튜토리얼에서 사용하는 `query-demo` [데이터베이스](/docs/services/Cloudant?topic=cloudant-databases#create-database)를 작성합니다.

이 튜토리얼에서는 `curl` 명령이 아니라 `acurl` 별명을 사용합니다. `acurl` 별명은 [여기](docs/services/Cloudant?topic=cloudant-authorized-curl-acurl-#authorized-curl-acurl-)에 설명된 단계를 사용하여 작성됩니다. `curl` 명령 또는 다른 API 엔드포인트 호출 방법을 사용하려는 경우에는 이 튜토리얼의 명령과 명령에 필요한 매개변수(사용자 이름 및 비밀번호 등)를 대체하십시오.
{: tip}

![명령행 아이콘](../images/CommandLineIcon.png) _명령행_

1.  다음 명령을 실행하여 데이터베이스를 작성하십시오.
  ``` sh
  acurl https://$ACCOUNT.cloudant.com/query-demo -X PUT
  ```
  {: codeblock}
2.  결과를 검토하십시오.
  ```json
  {
    "ok": true
  }
  ```
  {: codeblock}

![대시보드 아이콘](../images/DashboardIcon.png) _{{site.data.keyword.cloud_notm}} 대시보드_

1.  작성한 {{site.data.keyword.cloudant_short_notm}} 서비스 인스턴스를 여십시오.
2.  {{site.data.keyword.cloudant_short_notm}} 서비스 페이지에서 **시작**을 클릭하십시오.
    데이터베이스 탭이 열립니다.
    
  ![데이터베이스 탭](../images/tabs.png)
4.  **데이터베이스 작성**을 클릭하십시오.
5.  `query-demo`를 입력하고 **작성**을 클릭하십시오.

  `query-demo` 데이터베이스가 자동으로 열립니다.

## 데이터베이스에 문서 작성
{: #creating-documents-in-the-database}

이 실습에서 작성하는 [문서](/docs/services/Cloudant?topic=cloudant-documents#documents)는 이후의 실습에서 `query-demo` 데이터베이스를 조회하는 데 사용하는 데이터를 포함합니다.

![명령행 아이콘](../images/CommandLineIcon.png) _명령행_

1.  샘플 텍스트를 `bulkcreate.dat`라는 데이터 파일에 복사하여 다섯 개의 문서를 작성하십시오.
  ```json
  {
    "docs":
    [
      {
        "_id": "doc1",
        "firstname": "Sally",
        "lastname": "Brown",
        "age": 16,
        "location": "New York City, NY"
      },
      {
        "_id": "doc2",
        "firstname": "John",
        "lastname": "Brown",
        "age": 21,
        "location": "New York City, NY"
      },
      {
        "_id": "doc3",
        "firstname": "Greg",
        "lastname": "Greene",
        "age": 35,
        "location": "San Diego, CA"
      },
      {
        "_id": "doc4",
        "firstname": "Anna",
        "lastname": "Greene",
        "age": 44,
        "location": "Baton Rouge, LA"
      },
      {
        "_id": "doc5",
        "firstname": "Lois",
        "lastname": "Brown",
        "age": 33,
        "location": "Syracuse, NY"
      }
    ]
  }
  ```
  {: codeblock}

2.  다음 명령을 실행하여 문서를 작성하십시오.
  ```sh
  acurl https://$ACCOUNT.cloudant.com/query-demo/_bulk_docs -X POST -H "Content-Type: application/json" -d \@bulkcreate.dat
  ```
  {: codeblock}

파일에 데이터가 포함되어 있음을 표시하는 데 사용되는 '`@`' 기호가 제공된 이름으로 식별된다는 점에 주목하십시오.
{: tip}

3.  결과를 검토하십시오.
  ```json
  [
    {
      "ok":true,
      "id":"doc1",
      "rev":"1-57a08e644ca8c1bb8d8931240427162e"
    },
    {
      "ok":true,
      "id":"doc2",
      "rev":"1-bf51eef712165a9999a52a97e2209ac0"
    },
    {
      "ok":true,
      "id":"doc3",
      "rev":"1-9c9f9b893fcdd1cbe09420bc4e62cc71"
    },
    {
      "ok":true,
      "id":"doc4",
      "rev":"1-6aa4873443ddce569b27ab35d7bf78a2"
    },
    {
      "ok":true,
      "id":"doc5",
      "rev":"1-d881d863052cd9681650773206c0d65a"
    }
  ]
  ```
  {: codeblock}

![대시보드 아이콘](../images/DashboardIcon.png) _{{site.data.keyword.cloud_notm}} 대시보드_

1.  **`+`**를 클릭하고 **새 문서**를 선택하십시오. '새 문서' 창이 열립니다.
2.  문서를 작성하려면 다음 샘플 텍스트를 복사하여 새 문서의 기존 텍스트를 대체하십시오.

  _첫 번째 샘플 문서_:
  ```json
  {
    "firstname": "Sally",
    "lastname": "Brown",
    "age": 16,
    "location": "New York City, NY",
    "_id": "doc1"
  }
  ```
  {: codeblock}

3.  2단계를 반복하여 나머지 문서를 데이터베이스에 추가하십시오.

  _두 번째 샘플 문서_:
  ```json
  {
    "firstname": "John",
    "lastname": "Brown",
    "age": 21,
    "location": "New York City, NY",
    "_id": "doc2"
  }
  ```
  {: codeblock}

  _세 번째 샘플 문서_:
  ```json
  {
    "firstname": "Greg",
    "lastname": "Greene",
    "age": 35,
    "location": "San Diego, CA",
    "_id": "doc3"
  }
  ```
  {: codeblock}

  _네 번째 샘플 문서_:
  ```json
  {
    "firstname": "Anna",
    "lastname": "Greene",
    "age": 44,
    "location": "Baton Rouge, LA",
    "_id": "doc4"
  }
  ```
  {: codeblock}

  _다섯 번째 샘플 문서_:
  ```json
  {
    "firstname": "Lois",
    "lastname": "Brown",
    "age": 33,
    "location": "New York City, NY",
    "_id": "doc5"
  }
  ```
  {: codeblock}

  `query-demo` 데이터베이스가 다섯 개의 레코드로 채워져 있습니다. 다음 화면 캡처의 테이블 보기에서 레코드를 볼 수 있습니다.

  ![샘플 문서](../images/docs1.png)     

## 데이터베이스를 조회하기 위한 인덱스 작성
{: #creating-an-index-to-query-the-database}

{{site.data.keyword.cloudant_short_notm}}에서는 데이터베이스를 조회하는 데 사용할 수 있는 보기 및 인덱스를 제공합니다. 보기는 데이터베이스에 저장된 조회를 실행하며, 그 결과를 결과 세트라고 합니다. 보기에 조회를 제출하면 조회가 결과 세트를 검색합니다. 인덱스는 데이터를 구조화하는 방법이며 이는 검색 시간을 단축시킵니다.

이 튜토리얼의 {{site.data.keyword.cloudant_short_notm}} 조회를 사용하며, 논리 연산자를 사용하여 문서를 검색하기 위해 Mongo 스타일 조회 구문을 사용합니다. {{site.data.keyword.cloudant_short_notm}} 조회는 보기 및 검색 인덱스의 조합입니다.

{{site.data.keyword.cloudant_short_notm}} 조회를 사용하면 조회 플래너가 선택기(조회)를 확인하여 선택할 올바른 인덱스를 판별합니다. 적합한 인덱스가 없는 경우 ID로 문서를 검색하는 `_all_docs` 특수 인덱스를 사용합니다. 최악의 시나리오에는 ID별로 모든 문서가 리턴됩니다(전체 테이블 스캔). 메모리에서 선택기로 문서를 필터링하며, 이는 인덱스 없이도 다양한 필드로 조회할 수 있는 이유입니다. 전체 테이블 스캔은 비용이 많이 들며, 인덱스를 작성하는 것이 좋습니다. 다음 목록에서 여러 유형의 인덱스에 대한 설명을 참조하십시오.

*	1차 인덱스 - ID를 사용하여 문서 또는 문서의 목록을 검색합니다.  
*	[보기](/docs/services/Cloudant?topic=cloudant-views-mapreduce#views-mapreduce) – 계수, 합계, 평균 및 기타 수학 함수로서 지정하는 검색 기준에 일치하는 데이터베이스 내의 정보를 검색합니다. 검색할 수 있는 기준은 보기의 정의에 지정됩니다. 보기는 MapReduce 패러다임을 사용합니다.
*	[검색 인덱스](/docs/services/Cloudant?topic=cloudant-search#search) – 하나 이상의 필드, 대량의 텍스트를 검색하거나, [Lucene 조회 구문 분석기 구문 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](http://lucene.apache.org/core/4_3_0/queryparser/org/apache/lucene/queryparser/classic/package-summary.html#Overview){: new_window}에 와일드카드, 퍼지 검색 또는 패싯을 사용합니다.

지정된 조회와 일치하는 사용 가능한 정의된 인덱스가 없는 경우 {{site.data.keyword.cloudant_short_notm}}는 `_all_docs` 인덱스를 사용합니다.
{: tip}


![명령행 아이콘](../images/CommandLineIcon.png) _명령행_

1.  다음 샘플 JSON 데이터를 `query-index.dat` 파일에 복사하십시오.
  ```json
{
	"index": {
		"fields": [
			"age",
			"lastname"
		],
		"partial_filter_selector": {
			"age": {
				"$gte": 30
			},
			"lastname": {
				"$eq": "Greene"
			}
		}
	},
  		"ddoc": "partial-index",
		"type": "json"
}
  ```
  {: codeblock}

2.  다음 명령을 실행하여 인덱스를 작성하십시오.
  ```sh
  acurl https://$ACCOUNT.cloudant.com/query-demo/_index -X POST -H "Content-Type: application/json" -d \@query-index.dat
  ```
  {: codeblock}

3.  결과를 검토하십시오.
  ```json
  {
    "result":"created",
    "id":"_design/752c7031f3eaee0f907d18e1424ad387459bfc1d",
    "name":"query-index"
  }
  ```
  {: codeblock}



![대시보드 아이콘](../images/DashboardIcon.png) _{{site.data.keyword.cloud_notm}} 대시보드_

1.  **모든 문서** 또는 **디자인 문서** 탭에서 **`+` > 조회 인덱스**를 클릭하십시오.
2.  다음 샘플 JSON 데이터를 **인덱스** 필드에 붙여넣으십시오.
  ```json
  {
	"index": {
		"fields": [
			"age",
			"lastname"
		],
		"partial_filter_selector": {
			"age": {
				"$gte": 30
			},
			"lastname": {
				"$eq": "Greene"
			}
		}
	},
  		"ddoc": "partial-index",
		"type": "json"
  }
  ```
  {: codeblock}

  인덱스가 작성되었습니다. 다음 화면 캡처에서 인덱스를 확인할 수 있습니다.

  ![조회 인덱스](../images/query-index1.png)



## 조회 작성
{: #creating-a-query}

조회를 통해 {{site.data.keyword.cloudant_short_notm}}에서 데이터를 추출할 수 있습니다. 잘 작성된 [조회](/docs/services/Cloudant?topic=cloudant-query#query)는 검색 범위를 좁히며 결과에 사용자가 원하는 결과만 포함됩니다.

이 실습에서는 간단한 조회를 작성하고 실행하는 방법, 두 개의 필드를 사용하여 조회하는 방법 및 두 개의
[연산자](/docs/services/Cloudant?topic=cloudant-query#operators)를 사용하여 조회하는 방법을 보여줍니다.
사용자는 하나 이상의 필드와 해당 값을 지정함으로써 연산자를 사용하여 조회할 수 있습니다.
조회는 그 후 이 값을 사용하여 데이터베이스에서 일치 항목을 검색합니다.

가장 간단한 조회를 위해서는 JSON을 데이터 파일에 추가하고 이를 명령행에서 실행하십시오.

### 간단한 조회 실행
{: #running-a-simple-query}

이 예에서는 {{site.data.keyword.cloudant_short_notm}} 조회가 `query-index`를 사용하여 `lastname`을 찾고
메모리 내의 결과를 필터링하여 `firstname`을 찾는 방법을 보여줍니다.   

![명령행 아이콘](../images/CommandLineIcon.png) _명령행_

1.  다음 샘플 JSON을 `query1.dat`라는 데이터 파일에 복사하십시오.
  ```json
    {
      "selector": {
            "lastname" : "Greene",
            "firstname" : "Anna"            
         }        
    }       
  ```    
  {: codeblock}

2.  다음 명령을 실행하여 데이터베이스를 조회하십시오.
  ```sh
  acurl https://$ACCOUNT.cloudant.com/query-demo/_find -X POST -H "Content-Type: application/json" -d \@query1.dat
  ```
  {: codeblock}

3.  조회 결과를 검토하십시오.
  ```json
  {
    "docs": [
      {
        "_id":"doc4",
        "_rev":"3-751ab049e8b5dd1ba045cea010a33a72",
            "firstname":"Anna",
            "lastname":"Greene",
            "age":44,
            "location":"Baton Rouge, LA"
      }
    ]
  }
  ```
  {: codeblock}

![대시보드 아이콘](../images/DashboardIcon.png) _{{site.data.keyword.cloud_notm}} 대시보드_

1.  **조회** 탭을 클릭하십시오.
2.  다음 샘플 JSON을 복사하여 {{site.data.keyword.cloudant_short_notm}} 조회 창에 붙여넣으십시오.
  ```json
   {
      "selector": {
            "lastname" : "Greene",
            "firstname" : "Anna"            
         }        
   }
  ```
  {: codeblock}

3.  **조회 실행**을 클릭하십시오.

  조회 결과가 표시됩니다. 다음 화면 캡처의 테이블 보기에서 볼 수 있습니다.

  ![조회 1 결과](../images/dashboard_query1_results.png)

### 두 개의 필드를 사용하여 조회 실행
{: #running-a-query-with-two-fields}

이 예에서는 두 개의 필드를 사용하여 `New York City, NY`에 살며 이름이 `Brown`인 모든 사람을 찾습니다.

이 검색은 다음 예와 같은 ['selector' 표현식](/docs/services/Cloudant?topic=cloudant-query#selector-syntax)을 사용하여 표현합니다.
```json
  {
    "selector": {
      "lastname": "Brown",
      "location": "New York City, NY"
    }
  }
```
{: codeblock}

selector 표현식에 세부사항을 추가하여 필요에 맞게 결과를 사용자 조정할 수 있습니다.
`fields` 매개변수는 결과에 포함시킬 필드를 지정합니다. 이 예에서 결과는
이름, 성 및 위치를 포함합니다. 결과는 `sort` 매개변수의 값에 따라
이름을 사용하여 오름차순으로 정렬됩니다.
추가 세부사항은 다음 예와 같습니다.
```json
{
  ...
  "fields" : [
    "firstname",
      "lastname",
      "location"
  ]
}
```  
{: codeblock}

![명령행 아이콘](../images/CommandLineIcon.png) _명령행_

1.  샘플 JSON을 `query2.dat`라는 데이터 파일에 복사하십시오.
  ```json
  {
    "selector": {
      "lastname": "Brown",
      "location": "New York City, NY"
    },
    "fields" : [
     "firstname",
     "lastname",
     "location"
  ]
  }
  ```
  {: codeblock}

2.  다음 명령을 실행하여 데이터베이스를 조회하십시오.
  ```sh
  acurl https://$ACCOUNT.cloudant.com/query-demo/_find -X POST -H "Content-Type: application/json" -d \@query2.dat
  ```
  {: codeblock}

3.  조회 결과를 검토하십시오.
  ```json
  {
    "docs": [
      {
        "firstname": "Sally",
        "lastname": "Brown",
        "location": "New York City, NY"
      },
      {
        "firstname": "John",
        "lastname": "Brown",
        "location": "New York City, NY"
      },
      {
        "firstname": "Lois",
        "lastname": "Brown",
        "location": "New York City, NY"
      }
    ]
  }
  ```
  {: codeblock}

![대시보드 아이콘](../images/DashboardIcon.png) _{{site.data.keyword.cloud_notm}} 대시보드_

1.  **조회** 탭을 클릭하십시오.
2.  다음 샘플 JSON을 복사하여 {{site.data.keyword.cloudant_short_notm}} 조회 창에 붙여넣으십시오.
  ```json
  {
    "selector": {
      "lastname": "Brown",
      "location": "New York City, NY"
    },
    "fields": [
      "firstname",
      "lastname",
      "location"
    ] 
  }
  ```
  {: codeblock}

3.  **조회 실행**을 클릭하십시오.

  조회 결과가 표시됩니다. 다음 화면 캡처의 테이블 보기에서 볼 수 있습니다.

  ![조회 2 결과](../images/dashboard_query2_results.png)

### 연산자를 사용하여 조회 실행
{: #running-a-query-with-operators}

이 예에서는 `Greene`이라는 성과 `30`보다 높은 연령을 포함하는 문서를 검색하기 위해 `$eq`(같음) 및 `$gt`(보다 큼) 연산자를 사용합니다.

다음 예와 같은 selector 표현식을 사용합니다.
```json
{
  "selector": {
    "age": {
      "$gt": 30
    },
    "lastname": {
      "$eq": "Greene"
    }
  }
}
``` 
{: codeblock}

결과는 `sort` 매개변수에서 지정된 값에 따라 연령 기준으로 오름차순으로 정렬됩니다.

```json
    "sort": [
      {
        "age": "asc"   
      }
    ] 
```  
{: codeblock}

![명령행 아이콘](../images/CommandLineIcon.png) _명령행_

1.  다음 샘플 JSON을 `query3.dat` 파일에 복사하십시오.
  ```json
  {
   "selector": {
      "age": {
         "$gt": 30
      },
      "lastname": {
         "$eq": "Greene"
      }
   },
    "fields": [
      "age",
      "firstname"
   ],
    "sort": [
      {
         "age": "asc"   
      }
   ],
   "use_index": "_design/partial-index"
  }
  ```
  {: codeblock}

2. 다음 조회를 실행하십시오.
  ```sh
  acurl https://$ACCOUNT.cloudant.com/query-demo/_find -X POST -H "Content-Type: application/json" -d \@query3.dat
  ```
  {: codeblock}

3.  조회 결과를 검토하십시오.
  ```json
{"docs":[
     {"age":35,"firstname":"Greg"},
     {"age":44,"firstname":"Anna"}
   ],
  "bookmark": "g1AAAABCeJzLYWBgYMpgSmHgKy5JLCrJTq2MT8lPzkzJBYqzAFkmIDkOmFwOSHWiDkiSzb0oNTUvNSsLAEsmEeQ"
  }
  ```
  {: codeblock}

![대시보드 아이콘](../images/DashboardIcon.png) _{{site.data.keyword.cloud_notm}} 대시보드_

1.  **조회** 탭을 클릭하십시오.
2.  다음 샘플 JSON을 복사하여 {{site.data.keyword.cloudant_short_notm}} 조회 창에 붙여넣으십시오.
  ```json
  {
   "selector": {
      "age": {
         "$gt": 30
      },
      "lastname": {
         "$eq": "Greene"
      }
   },
    "fields": [
      "age",
      "firstname"
   ],
    "sort": [
      {
         "age": "asc"   
      }
   ],
   "use_index": "_design/partial-index"
  }
  ```
  {: codeblock}

3.  **조회 실행**을 클릭하십시오.

  조회 결과가 표시됩니다. 다음 화면 캡처의 테이블 보기에서 볼 수 있습니다.

  ![조회 3 결과](../images/dashboard_query3_results.png)

{{site.data.keyword.cloudant_short_notm}}에 대한 자세한 정보는 [{{site.data.keyword.cloudant_short_notm}} 문서](/docs/services/Cloudant?topic=cloudant-overview#overview)를 참조하십시오.
