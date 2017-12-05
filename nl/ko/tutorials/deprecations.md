---

copyright:
  years: 2017
lastupdated: "2017-07-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-07-12 -->

# 주요 변경사항 및 작동 변경사항

이 문서에는 Cloudant 릴리스의 작동 변경사항이 요약되어 있습니다.
{:shortdesc}

## CouchDB 버전 1.6과 Cloudant 버전 2.0.0 간의 비호환성

-   최신 Cloudant 버전과 CouchDB 1.6 기반 코드 베이스 간에는 비호환성이 존재합니다. 이전  
    Cloudant 버전에서는, 요청 본문에 조회 매개변수("reduce=false")를 추가한 경우 요청 URL에서는
    적용되는 반면 요청 본문에서는 무시되었습니다. 최신 Cloudant 버전에서는 요청 본문의
    조회 매개변수("reduce=false")가 무시되지 않습니다. 

## 개정된 오류 메시지

- 개정판이 없는 문서 첨부를 삽입하려 시도하는 경우 발생하는 오류 메시지가 다음 정보를 포함하는 409 오류로 변경되었습니다. 

	```
	{"error":"not_found","reason":"missing_rev"}
	```

## X-Frame-Options

`X-Frame-Options` 설정은 HTTP 응답을 `<frame>`, `<iframe>` 또는 `<object>`에 임베드할 수 있는지 제어하는 응답 헤더입니다. 이 보안 기능은 클릭재킹을 방지하는 데 도움을 줍니다. 

사용자는 이 옵션을 자신의 CORS 설정에 따라 구성할 수 있습니다. CORS가 사용으로 설정된 경우 `X-Frame-Options`는 자동으로 사용 설정되며 기본적으로 응답 헤더 `X-Frame-Options: DENY`를 전송합니다. 요청 HOST 헤더가 CORS의 origins 섹션에 나열된 URL과 일치하는 경우에는 `X-Frame-Options: ALLOW-FROM URL` 응답 헤더가 리턴됩니다. 
 
이 변경사항은 브라우저에서 직접 데이터베이스에 액세스하고 있는 고객에게 영향을 줄 수 있습니다. 오류 메시지 "X-Frame-Options: DENY"가 표시되며 이 메시지가
서비스를 중단시키고 있는 경우에는 [CORS 구성 설정](../api/cors.html#setting-the-cors-configuration)에 따라 CORS를 사용으로 설정해야 합니다.
CORS를 사용으로 설정한 후에는 허용된 `origins`의 목록에 요청에서 전송하는 HOST 헤더의 값을 추가하십시오. 

## 활성 태스크

-   `_active_tasks` 응답의 인덱서 항목이 더 이상 `user` 필드를 보고하지 않습니다. 
-   `_active_tasks` 응답의 검색 인덱서 항목이 더 이상 `user` 필드를 보고하지 않습니다. 

## 보기

-   키 값의 유니코드 표준화가 감소되거나 감소되지 않은 보기 결과 사이에 일치합니다. 디자인 문서에 원시 대조가 지정된 경우에는 이 수정사항의 결과로 인해 결과 순서가 변경될 수 있습니다. 
-   보기 또는 `_all_docs` 데이터베이스를 조회할 때 `keys` 매개변수와 `key`, `startkey` 및 `endkey` 매개변수를 함께 지정하는 것은 오류입니다. 
-   행 일치가 불가능한 경우 보기에 `startkey` 및 `endkey` 매개변수를 보기에 전달하는 것은 오류입니다. 예를 들면, `descending=false`인 상태에서 `startkey` 매개변수가 `endkey`보다 크거나, `descending=true`인 상태에서 `startkey` 매개변수가 `endkey` 매개변수보다 작은 경우 Cloudant는 `400 Bad Request` 오류를 리턴합니다. 
-   보기 문서에 `dbcopy`가 구성된 경우 이는 디자인 문서에서 자동으로 `options` 필드로 변환됩니다.  

## 디자인 문서

-   디자인 문서가 더 엄격하게 유효성 검증됩니다. 이 유효성 검증은 기존 디자인 문서에 문제점을 발생시키지 않을 것으로 예상되지만, 잘못된 디자인 문서는 저장되지 않습니다. 
-   지원되지 않는 언어로 작성된 보기는 모두 `unknown_query_language`의 `error`로 응답합니다. 이전에는 응답이 `reason` of `unknown_query_language`였습니다. 
-   데이터베이스 디자인 문서를 삽입하기 위해 널 reduce 함수가 사용된 경우, 시스템이 이전에는 `((new String("null")))`을 리턴했으나 이제는 `'(null)'`로 응답합니다. 
-   디자인 문서에 `updates`가 지정된 경우 여기에는 널값이 없어야 합니다. 

## 인증

-   `_session` 메타데이터 `authentication_handlers`가 더 이상 `["delegated", "local"]`을 포함하지 않습니다. 

## 사용자 문서

-   `_users` 데이터베이스에서 작성된 사용자 문서의 구조를 유효성 검증합니다. DBNext 업그레이드 후, 사용자 문서는 ASF CouchdDB 요구사항을 준수해야 합니다. 이전에는 Cloudant가 사용자 문서의 구조를 유효성 검증하지 않았습니다.  

## 복제 

-   복제 문서는 마지막 오류 메시지는 `_replication_state_reason` JSON 필드에 보존합니다. 이 필드는 복제가 다시 시작된 후에도 `triggered` 상태로 유지됩니다. 이 변경사항은 복제자 코드가 동일한 오류를 발견하여 문서에 반복 기록하는 것을 방지하는 데 도움을 줍니다. 
-   오류의 이유가 변경되지 않는 한 복제 중 오류가 복제 문서를 업데이트하지 않습니다. 이전에는 복제 중에 오류가 발생하면 상당한 크기의 샤드를 생성하는 무한 루프가 시작되었습니다.   

## 결과 세트

-   `_db_updates` 엔드포인트가 `db_name`이라는 키를 포함하는 결과 세트를 리턴합니다. 이전에는 `dbname`이라는 키가 있는 결과 세트를 리턴했습니다. 
-   문서 ID의 최대 길이를 설정합니다. 이전에는 최대 문서 ID 길이를 정의할 수 없었습니다. 

## `dbcopy`

- `dbcopy` 기능은 일부 상황에서 문제점을 발생시킬 수 있습니다.
  이 기능에 대한 정보는 이 문서에서 제거되었습니다. `dbcopy`는 사용하지 않는 것이 좋습니다. 
