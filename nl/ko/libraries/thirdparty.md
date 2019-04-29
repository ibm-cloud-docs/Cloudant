---

copyright:
  years: 2015, 2019
lastupdated: "2019-04-02"

keywords: client, mobile, c#, .net, libraries, frameworks, examples, tutorials, php, javascript, ruby, meteor, apache spark, 

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

# 서드파티 클라이언트 라이브러리
{: #third-party-client-libraries}

서드파티 클라이언트 라이브러리는 {{site.data.keyword.cloudantfull}}에서 유지보수되거나 지원되지 않습니다.
{: shortdesc}

## C# / .NET
{: #c-net}

[MyCouch ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://github.com/danielwertheim/mycouch){: new_window}는 .Net용 비동기 CouchDB 및 {{site.data.keyword.cloudant_short_notm}} 클라이언트입니다.

라이브러리를 설치하려면 패키지 관리자 콘솔을 열고 다음을 호출하십시오.

```
install-package mycouch.cloudant
```
{: codeblock}

### C# / .NET용 라이브러리 및 프레임워크
{: #libraries-and-frameworks-for-c-net}

-   [MyCouch ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://github.com/danielwertheim/mycouch){: new_window}
-   [LoveSeat ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://github.com/soitgoes/LoveSeat){: new_window}
-   [Divan ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://github.com/foretagsplatsen/Divan){: new_window}
-   [Relax ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://github.com/arobson/Relax){: new_window}
-   [Hammock ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](http://code.google.com/p/relax-net/){: new_window}
-   [EasyCouchDB ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://github.com/hhariri/EasyCouchDB){: new_window}
-   [Kanapes IDE ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](http://kanapeside.com/){: new_window}의 `WDK.API.CouchDB`

### C# / .NET용 예제 및 튜토리얼
{: #examples-and-tutorials-for-c-net}

-   [CRUD ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://github.com/cloudant/haengematte/tree/master/c%23){: new_window}

## Java
{: #java}

### 지원되지 않는 Java용 라이브러리
{: #unsupported-for-libraries-for-java}

-   [ektorp ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://helun.github.io/Ektorp/reference_documentation.html){: new_window}
-   [jcouchdb ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](http://code.google.com/p/jcouchdb/){: new_window}
-   [jrelax ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://github.com/isterin/jrelax){: new_window}
-   [LightCouch ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](http://www.lightcouch.org/){: new_window}

## JavaScript
{: #javascript}

### JavaScript용 라이브러리 및 프레임워크
{: #libraries-and-frameworks-for-javascript}

-   [Backbone.cloudant ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://github.com/cloudant-labs/backbone.cloudant){: new_window}.
    자세한 정보는 [블로그 포스트 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://cloudant.com/blog/backbone-and-cloudant/){: new_window}를 참조하십시오.
-   [sag.js ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://github.com/sbisbee/sag-js){: new_window}

### JavaScript용 예제 및 튜토리얼
{: #examples-and-tutorials-for-javascript}

-   jQuery를 사용한 [CRUD ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://github.com/cloudant/haengematte/tree/master/javascript-jquery){: new_window}
-   [CSVtoCloudant ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://github.com/michellephung/CSVtoCloudant){: new_window} -
    `.csv` 파일을 {{site.data.keyword.cloudant_short_notm}}로 가져오는 데 사용되는 UI입니다.
    이 앱은 [여기 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://michellephung.github.io/CSVtoCloudant/){: new_window}서도 액세스할 수 있습니다.
-   [csv2couchdb ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://github.com/Mango-information-systems/csv2couchdb){: new_window} -
    `.csv` 파일을 CouchDB/{{site.data.keyword.cloudant_short_notm}}로 가져오는 데 사용되는 Mango Systems의 UI입니다.
-   [songblog ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://github.com/millayr/songblog){: new_window} - JQuery를 사용한 예제 앱
    
## PouchDB(JavaScript)
{: #pouchdb}

[PouchDB ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](http://pouchdb.com/){: new_window}는 {{site.data.keyword.cloudant_short_notm}}와 동기화할 수 있는 JavaScript 데이터베이스이며,
이는 PouchDB만 사용하여 앱을 오프라인에서 사용할 수 있도록 준비할 수 있음을 의미합니다.
자세한 정보는 PouchDB의
[블로그 포스트 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://cloudant.com/blog/pouchdb){: new_window}를 참조하십시오.

PouchDB를 다운로드하고 설정 세부사항을 알아보려면 [PouchDB ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](http://pouchdb.com/){: new_window}에 방문하십시오.

PouchDB는 Node.js에서도 사용 가능합니다. `npm install pouchdb`.
{: note}

PouchDB는 Bower를 사용하여 설치할 수도 있습니다. `bower install pouchdb`.
{: note}

### PouchDB용 라이브러리 및 프레임워크
{: #libraries-and-frameworks-for-pouchdb}

-   [PouchDB ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](http://pouchdb.com/){: new_window} - 오프라인 동기화 기능이 있는, 브라우저용 JavaScript 데이터베이스입니다.

### PouchDB의 예제 및 튜토리얼
{: #examples-and-tutorials-for-pouchdb}

-   [PouchDB 시작하기 안내서 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](http://pouchdb.com/getting-started.html){: new_window} -
    브라우저에서 {{site.data.keyword.cloudant_short_notm}} 또는 CouchDB로 동기화하는 예제 수행할 작업 앱
-   [locationtracker ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://github.com/rajrsingh/locationtracker){: new_window} -
    PouchDB, CouchApp 및 {{site.data.keyword.cloudant_short_notm}}를 사용하여 위치를 기록하고 맵핑하는 예제 앱

## Node.js
{: #node-js}

### 지원되지 않는 node.js용 라이브러리 및 프레임워크
{: #unsupported-libraries-and-frameworks-for-node-js-thirdparty}

-   브라우저에서도 작동하는 [sag-js ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://github.com/sbisbee/sag-js){: new_window}.
    세부사항은 [saggingcouch ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://github.com/sbisbee/saggingcouch.com){: new_window}를 참조하십시오.
-   [nano ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://github.com/dscape/nano){: new_window}는 최소한의 구현입니다.
-   [restler ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://github.com/danwrong/restler){: new_window}는 성능이 가장 좋지만 핵심 기능만을 포함하고 있습니다.
-   [cradle ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://github.com/flatiron/cradle){: new_window}은
    성능 저하를 감수하더라도 사용 용이성을 높여야 하는 경우에도 사용할 수 있는 상위 레벨 클라이언트입니다.
-   [cane_passport ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://github.com/ddemichele/cane_passport){: new_window} - 부트스트랩을 사용하는 {{site.data.keyword.cloudant_short_notm}} Angular Node Express
-   [express-cloudant ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://github.com/cloudant-labs/express-cloudant){: new_window} - PouchDB 및 Grunt 또한 사용하는, Node.js Express 프레임워크의 템플리트

## PHP
{: #php}

[Sag ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://github.com/sbisbee/sag){: new_window}는 PHP의 CouchDB 및 {{site.data.keyword.cloudant_short_notm}} 클라이언트입니다.
[Sag.js ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://github.com/sbisbee/sag-js){: new_window}는 JavaScript를 사용하는 Sag입니다.

설치하려면 `sag`를 [https://github.com/sbisbee/sag ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://github.com/sbisbee/sag){: new_window}에서
다운로드한 후 이 라이브러리를 애플리케이션에 포함시키십시오.

```
require_once('./src/Sag.php');
```
{: codeblock}

### PHP용 라이브러리 및 프레임워크
{: #libraries-and-frameworks-for-php}

-   [sag ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://github.com/sbisbee/sag){: new_window}
-   [Doctrine CouchDB Client ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://github.com/doctrine/couchdb-client){: new_window}
-   [PHP-on-Couch ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://github.com/dready92/PHP-on-Couch){: new_window}

### PHP용 예제 및 튜토리얼
{: #examples-and-tutorials-for-php}

-   [CRUD ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://github.com/cloudant/haengematte/tree/master/php){: new_window}

## Python
{: #python}

### 지원되지 않는 Python용 라이브러리 및 프레임워크
{: #unsupported-libraries-and-frameworks-for-python}

-   [요청 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](http://docs.python-requests.org/en/master/){: new_window}.

## Ruby
{: #ruby}

[CouchRest ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://github.com/couchrest/couchrest){: new_window}는 [CouchRest 모델 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://github.com/couchrest/couchrest_model){: new_window}을 사용하여
Rails 관련 작업을 수행할 수 있는 확장기능이 포함된 {{site.data.keyword.cloudant_short_notm}} 클라이언트 및 CouchDB입니다.

CouchRest를 설치하려면 다음 명령을 실행하십시오.

```sh
gem install couchrest
```
{: codeblock}

### Ruby용 라이브러리 및 프레임워크
{: #libraries-and-frameworks-for-ruby}

[Ruby Toolbox ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://www.ruby-toolbox.com/categories/couchdb_clients){: new_window}에는
다양한 CouchDB 클라이언트가 나열되어 있습니다.

### Ruby용 예제 및 튜토리얼
{: #examples-and-tutorials-for-ruby}

-   [CRUD ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://github.com/cloudant/haengematte/tree/master/ruby){: new_window}

## Meteor
{: #meteor}

[cloudant:couchdb ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://atmospherejs.com/cloudant/couchdb){: new_window}는
`couchdb-meteor` 패키지용 {{site.data.keyword.cloudant_short_notm}} 라이브러리입니다.
Apache CouchDB가 Meteor 또는 CouchDB 패키지에 포함되지 않으므로,
Meteor를 설치하기 전에 Meteor가 실행 중인 CouchDB 또는 {{site.data.keyword.cloudant_short_notm}} 서버 인스턴스에
연결하는 데 사용할 수 있는 URL을 제공해야 합니다.
이
패키지를 사용자의 Meteor 애플리케이션에 추가하십시오.

```sh
meteor add cloudant:couchdb
```
{: codeblock}

couchdb-meteor 패키지에서는 다음을 제공합니다.

-   Livequery 구현 및 CouchDB `_changes` 피드를 사용한 데이터베이스로부터의 실시간 업데이트
-   로컬 연결된 클라이언트로부터 데이터를 업데이트하는 분산 데이터 프로토콜(DDP) RPC 엔드포인트
-   업데이트의 DDP 형식 직렬화 및 직렬화 해제

{{site.data.keyword.cloudant_short_notm}} 조회에 사용되고 처음에 {{site.data.keyword.cloudant_short_notm}}에서 개발된 JSON 조회 구문은 다시 Apache CouchDB 버전 2.0에 사용되었습니다. Apache CouchDB 버전 2.0에 대한 사전 빌드 2진은 아직 사용 가능하지 않습니다. 사전 빌드 2진이 사용 가능하게 될 때까지 이 모듈을 {{site.data.keyword.cloudant_short_notm}} DBaaS 또는 Cloudant Local과 함께 사용할 수 있습니다.
{: note}

Apache CouchDB 또는 {{site.data.keyword.cloudant_short_notm}} 서버 연결 정보를 구성하려면 Meteor 서버 프로세스에 해당 URL을 `COUCHDB_URL` 환경 변수로 전달하십시오.

```sh
$ export COUCHDB_URL=https://username:password@username.cloudant.com
```
{: codeblock}

meteor-couchdb API에 대한 자세한 정보는 [API 참조](/docs/services/Cloudant/api/index.html#api-reference-overview)를 참조하십시오. 
