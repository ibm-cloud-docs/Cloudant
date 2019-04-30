---

copyright:
  years: 2015, 2019
lastupdated: "2019-03-18"

keywords: couchapp, 3-tier application

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

<!-- Acrolinx: 2018-05-07 -->

# CouchApps
{: #couchapps}

{{site.data.keyword.cloudantfull}}에서는 이미지와 같은 원시 파일 데이터를 호스팅하고 HTTP를 통해 제공할 수 있으며, 이는 웹 사이트를 운영하는 데 필요한 모든 정적 파일을 웹 서버처럼 호스팅할 수 있음을 의미합니다.
{: shortdesc}

이러한 파일이 {{site.data.keyword.cloudant_short_notm}}에서 호스팅되므로,
클라이언트 측 JavaScript가 {{site.data.keyword.cloudant_short_notm}} 데이터베이스에 액세스할 수 있습니다.
이 방식으로 빌드된 애플리케이션을 가리켜 클라이언트(일반적으로 브라우저)와
데이터베이스로 구성된 2계층 아키텍처를 갖추었다고 합니다.
CouchDB 커뮤니티에서는 이를 CouchApp이라고 합니다.

대부분의 웹 앱에는 세 개의 계층(클라이언트, 서버, 데이터베이스)이 있습니다.
클라이언트와 데이터베이스 사이에 서버를 배치하면 인증, 권한 부여, 자산 관리, 서드파티 웹 API 이용, 정교한 엔드포인트 제공 등에 도움이 됩니다.
이러한 구분은 각자의 관심사가 합쳐지지 않도록 하면서 복잡도를 더할 수 있도록 하여, 클라이언트는 데이터 프리젠테이션에 대해서만 우려하는 한편
데이터베이스는 데이터 저장 및 서비스에만 집중하도록 할 수 있습니다.

CouchApps는 단순함이 장점이지만, 웹 앱에서 3계층 아키텍처의 성능을 필요로 하는 경우도 종종 발생합니다.
각각 적절한 경우를 알아보겠습니다.

## CouchApp이 적절한 경우
{: #a-couchapp-is-appropriate-if-}

-   서버가 {{site.data.keyword.cloudant_short_notm}}에만 API를 제공합니다.
-   {{site.data.keyword.cloudant_short_notm}}의 [쿠키 기반 인증](/docs/services/Cloudant?topic=cloudant-authentication#cookie-authentication)을 사용해도 괜찮습니다.
-   사용자 및 권한을 관리하는 데 {{site.data.keyword.cloudant_short_notm}}의 [`_users` 및 `_security`](/docs/services/Cloudant?topic=cloudant-authorization#using-the-_users-database-with-cloudant-nosql-db) 데이터베이스를 사용해도 괜찮습니다.
-   cronjob 또는 기타 정기적 태스크를 스케줄할 필요가 없습니다.

CouchApps를 시작하려면
[{{site.data.keyword.cloudant_short_notm}}에서 애플리케이션 관리 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://cloudant.com/blog/app-management/){: new_window}를 참조하십시오.

## 3계층 애플리케이션이 적절한 경우
{: #a-3-tier-application-is-appropriate-if-}

-   `_security` 데이터베이스가 허용하는 것보다 더 세분화된 권한이 필요합니다.
-   Oauth 또는 서드파티 로그인 시스템과 같은, 기본 인증 또는 쿠키 인증 외의 인증 방법이 필요합니다.
-   클라이언트 외부에서 정기적으로 실행되도록 태스크를 스케줄해야 합니다.

사용자는 자신에게 가장 적합한 기술을 사용하여 서버 계층에 대한 쓰기를 수행할 수 있습니다.
{{site.data.keyword.cloudant_short_notm}} 관련 작업에 필요한 라이브러리 목록은 [{{site.data.keyword.cloudant_short_notm}} 기본 사항](/docs/services/Cloudant?topic=cloudant-client-libraries#client-libraries) 페이지에 있습니다.
