---

copyright:
  years: 2017
lastupdated: "2017-07-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-05-04 -->

# Cloudant의 새로운 기능

Cloudant의 최신 변경사항 및 업데이트를 알아보십시오.
{:shortdesc}

## 데디케이티드 하드웨어

새 [데디케이티드 서비스 인스턴스](bluemix.html#dedicated-plan)가 사용 가능합니다. 

## 빌드 6233

- 새 복제 스케줄러가 도입되었습니다.
  이 스케줄러는 성능 이점 및 추가 엔드포인트를 제공할 뿐만 아니라,
  복제 상태가 모니터되고 보고되는 방식을 변경합니다.
  특히, 복제 문서에 상태 업데이트를 기록하는 것은 더 이상 지원되지 않습니다.
  이 중요 변경사항에 대한 자세한 정보를 얻으려면
  [복제 스케줄러](../api/advanced_replication.html#the_replication_scheduler)에 대한 세부사항을 참조하십시오.
  질문이나 의견이 있는 경우에는 Cloudant 대시보드를 사용해 티켓을 작성하여 Cloudant 지원에 문의하십시오. 

## 빌드 6069

- 이전에는, 어떤 이유로 인해 비정상 종료된 복제 작업이 새 복제를 시작하려는 시도 후에
  복제 문서를 업데이트했습니다. 일부 상황에서는 이 동작이 무한정 반복되어 동일한 오류 메시지의
  많은 복제본이 생성되었습니다. 이에 대한 수정사항이 적용되어, 이제 오류의 이유가 변경되지 않은 한 복제 문서가 업데이트되지 않습니다. 
- 지리공간 인덱스를 지정하도록 의도된 디자인 문서가 올바르지 않은 경우,
  [`_geo_info` 엔드포인트](../api/cloudant-geo.html#obtaining-information-about-a-cloudant-geo-index)를
  사용하여 인덱스의 정보를 검색하려는 시도가 [HTTP `404`](http.html#404) 응답을 발생시킵니다. 
- [`$allmatch`](../api/cloudant_query.html#the-allmatch-operator) 연산자에 대한 지원이 추가되었습니다. 

## 빌드 5834

- 문서 `id`의 최대 길이가 7168자로 변경되었습니다. 

## 빌드 5728

- `_users` 데이터베이스에 저장된 잘못된 양식의 사용자 문서에 대한 Cloudant의 오류 내성이 개선되었습니다.
  사용자 문서는 [Apache Software Foundation CouchDB 요구사항 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](http://docs.couchdb.org/en/2.0.0/intro/security.html#users-documents){:new_window}을
  준수하도록 구조화되고 채워져야 합니다. 

## 빌드 5638

-   보기에 대해 새 "stable" 및 "update" 조회 매개변수가 도입되었습니다. 
-   복제자는 소스 데이터베이스에 체크포인트를 작성할 수 없는 경우 이를 더 이상 무한정 재시도하지 않습니다. 

## 빌드 5421

-	변경사항 피드가 보기 기반 필터를 지원합니다. 
-	변경사항 피드가 `_doc_ids` 필터를 지원합니다. 
-	`POST` 요청이 `_changes`에 대해 지원됩니다. 
-	`_all_docs` 및 `_changes`가 `attachments=true` 매개변수를 지원합니다. 
-	문서가 `_users` 데이터베이스에서 작성된 경우의 서버 측 비밀번호 해싱을 포함한 CouchDB 1.6 `_users` 데이터베이스 기능을 지원합니다. 
-	모바일 클라이언트로의 복제에 사용되는 요청의 수를 줄이기 위해 `/_bulk_get` 엔드포인트가 사용됩니다. 
-	디자인 문서 메타데이터가 `update pending` 필드를 포함합니다. 
-	이제 유효한 인덱스가 없어도 Cloudant Query가 오류를 리턴하지 않습니다. 

### 주요/작동 변경사항

활성 태스크

-   `_active_tasks` 응답의 인덱서 항목이 더 이상 `user` 필드를 보고하지 않습니다. 
-   `_active_tasks` 응답의 검색 인덱서 항목이 더 이상 `user` 필드를 보고하지 않습니다. 

보기

-   키 값의 유니코드 표준화가 감소되거나 감소되지 않은 보기 결과 사이에 일치합니다. 디자인 문서에 원시 대조가 지정된 경우에는 이 수정사항의 결과로 인해 결과 순서가 변경될 수 있습니다. 
-   보기 또는 `_all_docs` 데이터베이스를 조회할 때 `keys` 매개변수와 `key`, `startkey` 및 `endkey` 매개변수를 함께 지정하는 것은 오류입니다. 
-   행 일치가 불가능한 경우 보기에 `startkey` 및 `endkey` 매개변수를 전달하는 것은 오류입니다. 예를 들면, `descending=false`인 상태에서 `startkey` 매개변수가 `endkey`보다 크거나, `descending=true`인 상태에서 `startkey` 매개변수가 `endkey` 매개변수보다 작은 경우 Cloudant는 `400 Bad Request` 오류를 리턴합니다. 
-   보기 문서에 `dbcopy`가 구성된 경우 이는 디자인 문서에서 자동으로 `options` 필드로 변환됩니다.  

디자인 문서

-   디자인 문서가 더 엄격하게 유효성 검증됩니다. 이 유효성 검증은 기존 디자인 문서에 문제점을 발생시키지 않을 것으로 예상되지만, 잘못된 디자인 문서는 저장되지 않습니다. 
-   지원되지 않는 언어로 작성된 보기는 모두 `unknown_query_language`의 `error`로 응답합니다. 이전에는 응답이 `reason` of `unknown_query_language`였습니다. 
-   데이터베이스 디자인 문서를 삽입하기 위해 널 reduce 함수가 사용된 경우, 시스템이 이전에는 `((new String("null")))`을 리턴했으나 이제는 `'(null)'`로 응답합니다. 
-   디자인 문서에 `updates`가 지정된 경우 여기에는 널값이 없어야 합니다. 

인증

-   `_session` 메타데이터 `authentication_handlers`가 더 이상 `["delegated", "local"]`을 포함하지 않습니다. 

사용자 문서

-   `_users` 데이터베이스에서 작성된 사용자 문서의 구조를 유효성 검증합니다. DBNext 업그레이드 후, 사용자 문서는 ASF CouchdDB 요구사항을 준수해야 합니다. 이전에는 Cloudant가 사용자 문서의 구조를 유효성 검증하지 않았습니다.  

복제 

-   복제 문서는 마지막 오류 메시지는 `_replication_state_reason` JSON 필드에 보존합니다. 이 필드는 복제가 다시 시작된 후에도 `triggered` 상태로 유지됩니다. 이 변경사항은 복제자 코드가 동일한 오류를 발견하여 문서에 반복 기록하는 것을 방지하는 데 도움을 줍니다. 
-   오류의 이유가 변경되지 않는 한 복제 중 오류가 복제 문서를 업데이트하지 않습니다. 이전에는 복제 중에 오류가 발생하면 상당한 크기의 샤드를 생성하는 무한 루프가 시작되었습니다.   

결과 세트

-   `_db_updates` 엔드포인트가 `db_name`이라는 키를 포함하는 결과 세트를 리턴합니다. 이전에는 `dbname`이라는 키가 있는 결과 세트를 리턴했습니다. 
-   문서 ID의 최대 길이를 설정합니다. 이전에는 최대 문서 ID 길이를 정의할 수 없었습니다. 

`dbcopy`

- `dbcopy` 기능은 일부 상황에서 문제점을 발생시킬 수 있습니다.
  이 기능에 대한 정보는 이 문서에서 제거되었습니다. `dbcopy`는 사용하지 않는 것이 좋습니다. 
