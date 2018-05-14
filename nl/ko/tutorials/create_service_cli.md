---

copyright:
  years: 2017
lastupdated: "2017-05-22"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# Cloud Foundry 도구를 사용하여 Bluemix에 Cloudant 인스턴스 작성

이 튜토리얼에서는 Cloud Foundry 도구를 사용하여 {{site.data.keyword.Bluemix_notm}}에 {{site.data.keyword.cloudantfull}} 서비스 인스턴스를 작성하는 방법을 보여줍니다. {:shortdesc}

## 전제조건

이 튜토리얼을 수행하려면 먼저 {{site.data.keyword.Bluemix_notm}} Cloud Foundry 도구를 설치해야 합니다. 이 도구를 설치하는 데 대한 세부사항은
[별도의 튜토리얼](create_bmxapp_appenv.html#the-cloud-foundry-and-bluemix-command-toolkits)에 있습니다. 

> **참고**: Cloud Foundry 및 {{site.data.keyword.Bluemix_notm}} 툴킷을 _둘 다_ 설치했는지 확인하십시오. 

## Bluemix API 엔드포인트 식별

Cloud Foundry 명령의 대상 API 엔드포인트를 지정하십시오. 

```sh
bx api https://api.ng.bluemix.net
```
{:codeblock}

결과는 사용자가 올바르게 엔드포인트를 식별했음을 확인합니다. 

```sh
Setting api endpoint to https://api.ng.bluemix.net...
OK

API endpoint: https://api.ng.bluemix.net (API version: 2.54.0)
Not logged in. Use 'bx login' to log in.
```
{:pre}

## Bluemix 계정에 로그인

1.  다음 명령을 사용하여 {{site.data.keyword.Bluemix_notm}} 계정의 로그인 프로세스를 시작하십시오. 
  
  ```sh
  bx login
  ```
  {:codeblock}
  
  {{site.data.keyword.Bluemix_notm}}는 사용자에게 응답하면서 현재 API 엔드포인트를 알려준 후, 계정의 이메일 주소를 묻습니다. 
  
  ```sh
  API endpoint: https://api.ng.bluemix.net
  
  Email>
  ```
  {:pre}

2.  사용자 계정의 이메일 주소를 입력하십시오.
  그 후 {{site.data.keyword.Bluemix_notm}}는 계정의 비밀번호를 묻습니다. 
  ```sh
  API endpoint: https://api.ng.bluemix.net
  
  Email> J.Doe@email.com
  
  Password>
  ```
  {:pre}
  
  {{site.data.keyword.Bluemix_notm}}가 세부사항을 유효성 검증한 후 로그인 세션에 대한 정보를 요약합니다. 
  ```sh
  API endpoint: https://api.ng.bluemix.net
  
  Email> J.Doe@email.com
  
  Password> 
  Authenticating...
  OK
  
  Targeted account J DOE's Account (707...a32)
  
  Targeted org J.Doe@email.com
  
  Targeted space dev
  
  API endpoint:   https://api.ng.bluemix.net (API version: 2.54.0)
  Region:         us-south
  User:           j.doe@email.com
  Account:        J DOE's Account (707...a32)
  Org:            J.Doe@email.com
  Space:          dev
  ```
  {:pre}

3.  이제 {{site.data.keyword.Bluemix_notm}} 계정에 로그인했습니다. 

## 서비스에 대한 Cloudant 플랜 선택

모든 사용 가능한 오퍼링의 목록을 얻으십시오. {{site.data.keyword.cloudant_short_notm}} 서비스에만 일치하도록 목록을 필터링하십시오. 

```sh
bx service offerings | grep -i Cloudant
```
{:codeblock}

결과는 선택할 수 있는 특정 플랜을 포함한, 계정에서 사용 가능한 {{site.data.keyword.cloudant_short_notm}} 서비스의 목록입니다. 

```sh
cloudantNoSQLDB   Lite, Standard*
```
{:pre}

**선택사항**: 플랜의 세부사항을 보려면 다음 명령을 사용하십시오. 

```sh
bx cf marketplace -s cloudantNoSQLDB
```
{:codeblock}

결과는 응답 예의 다음 섹션과 유사한, 사용 가능한 플랜의 요약입니다(세부사항은 2017년 5월의 것임). 

```
Lite
The Lite plan provides access to the full functionality of Cloudant for development and evaluation.
The plan has a set amount of provisioned throughput capacity as shown
and includes a max of 1GB of encrypted data storage.   free
```
{:pre}

## Cloudant 서비스 작성

{{site.data.keyword.Bluemix_notm}} 내에 서비스 인스턴스를 작성하는 기본 명령 형식은 다음과 같습니다. 

```sh
bx service create <service> <plan> <instance name>
```
{:pre}

`Lite` 플랜을 사용하여 {{site.data.keyword.cloudant_short_notm}} 서비스의 인스턴스를 작성하려 하며, 인스턴스 이름은 `cs20170517a`인 경우를 가정해 보십시오. 

다음 예와 유사한 명령을 사용하여 이를 수행하십시오. 

```sh
bx service create cloudantNoSQLDB Lite cs20170517a
```
{:codeblock}

서비스 인스턴스를 작성하고 나면 다음 예와 유사한 메시지가 응답합니다. 

```sh
Invoking 'cf create-service cloudantNoSQLDB Lite cs20170517a'...

Creating service instance cs20170517a in org J.Doe@email.com / space dev as J.Doe@email.com...
OK

```
{:pre}

## Cloudant 서비스의 신임 정보 작성

{{site.data.keyword.cloudant_short_notm}} 서비스에 액세스해야 하는 애플리케이션에는 필요한 신임 정보가 있어야 합니다. 

>   **참고**: 서비스 신임 정보는 중요한 정보입니다. 
    신임 정보에 대한 액세스 권한이 있는 모든 사용자 또는 애플리케이션은
    가짜 데이터를 작성하거나 중요 정보를 삭제하는 등, 서비스 인스턴스에 대해
    사실상 모든 작업을 수행할 수 있습니다. 이러한 신임 정보는 주의하여 보호하십시오.

서비스 신임 정보는 다섯 개의 필드로 구성됩니다. 

필드       | 용도
-----------|--------
`host`     | 애플리케이션이 서비스 인스턴스를 찾는 데 사용하는 호스트 이름입니다. 
`username` | 애플리케이션이 서비스 인스턴스에 액세스하는 데 필요한 사용자 이름입니다. 
`password` | 애플리케이션이 서비스 인스턴스에 액세스하는 데 필요한 비밀번호입니다. 
`port`     | 호스트의 서비스 인스턴스에 액세스하는 데 필요한 HTTP 포트 번호입니다. 보통 HTTPS 액세스를 강제하려는 경우에는 443이 사용됩니다. 
`url`      | 애플리케이션에서 사용하기에 적합하도록 기타 신임 정보를 하나의 URL로 통합하는 문자열입니다. 

{{site.data.keyword.Bluemix_notm}} 내의 서비스 인스턴스에 대한 신임 정보를 작성하는 기본 명령 형식은 다음과 같습니다. 

```sh
bx cf create-service-key <instance name> <credentials name>
```
{:pre}

{{site.data.keyword.cloudant_short_notm}} 서비스의 `cs20170517a` 인스턴스에 대한 신임 정보를 작성하려 하며, 신임 정보의 이름이 `creds20170517a`인 경우를 가정해 보십시오. 

다음 예와 유사한 명령을 사용하여 이를 수행하십시오. 

```sh
bx cf create-service-key cs20170517a creds20170517a
```
{:codeblock}

서비스 인스턴스에 대한 신임 정보 작성 요청을 수신하고 나면 {{site.data.keyword.Bluemix_notm}}는 다음 예와 유사한 메시지로 응답합니다. 

```sh
Invoking 'cf create-service-key cs20170517a creds20170517a'...

Creating service key creds20170517a for service instance cs20170517a as J.Doe@email.com...
OK
```
{:pre}

## Cloudant 서비스에 대한 신임 정보 나열

{{site.data.keyword.Bluemix_notm}} 내의 서비스 인스턴스에 대한 신임 정보를 검색하는 기본 명령 형식은 다음과 같습니다. 

```sh
bx cf service-key <instance name> <credentials name>
```
{:pre}

{{site.data.keyword.cloudant_short_notm}} 서비스의 `cs20170517a` 인스턴스에 대한 신임 정보를 검색하려 하며, 신임 정보의 이름이 `creds20170517a`인 경우를 가정해 보십시오. 

다음 예와 유사한 명령을 사용하여 이를 수행하십시오. 

```sh
bx cf service-key cs20170517a creds20170517a
```
{:codeblock}

서비스 인스턴스에 대한 신임 정보 검색 요청을 수신하고 나면 {{site.data.keyword.Bluemix_notm}}는 다음 예(축약됨)와 유사한 메시지로 응답합니다. 

```sh
Invoking 'cf service-key cs20170517a creds20170517a'...

Getting key creds20170517a for service instance cs20170517a as J.Doe@email.com...

{
 "host": "946...46f-bluemix.cloudant.com",
 "password": "4eb...eb5",
 "port": 443,
 "url": "https://946...46f-bluemix:4eb...eb5@946...46f-bluemix.cloudant.com",
 "username": "946...46f-bluemix"
}
```
{:pre}

## Cloudant 서비스 인스턴스 사용

이 시점에서 사용자가 수행한 작업은 다음과 같습니다. 

1.  {{site.data.keyword.Bluemix_notm}} 내에 {{site.data.keyword.cloudant_short_notm}} 서비스 인스턴스를 작성했습니다. 
2.  {{site.data.keyword.cloudant_short_notm}} 서비스 인스턴스에 대한 신임 정보를 작성했습니다. 
3.  애플리케이션에서 사용할 수 있도록 이 서비스 인스턴스를 검색했습니다. 

{{site.data.keyword.cloudant_short_notm}} 서비스 인스턴스를 사용하는 방법을 보여주는 튜토리얼은 [여기](create_database.html#context)에 있습니다.
이 튜토리얼에서 작성한 신임 정보를 대체해야 한다는 점을 기억하십시오. 

## (선택사항) 사후 정리 작업

다음의 간단한 명령 목록은 개발 환경을 정리하는 데 유용합니다. 

### 서비스 신임 정보 삭제

서비스 신임 정보 세트를 삭제하려면 다음과 유사한 명령을 사용하십시오. 

```sh
bx cf delete-service-key <instance name> <credentials name>
```
{:pre}

예를 들어, {{site.data.keyword.cloudant_short_notm}} 서비스의 `cs20170517a` 인스턴스에서 `creds20170517a`라는 신임 정보를 삭제하려면 다음과 같은 명령을 사용하십시오. 

```sh
bx cf delete-service-key cs20170517a creds20170517a
```
{:pre}

### 서비스 인스턴스 삭제

서비스 인스턴스를 삭제하려면 다음과 유사한 명령을 사용하십시오. 

```sh
bx service delete <instance name>
```
{:pre}

예를 들어, {{site.data.keyword.cloudant_short_notm}} 서비스의 `cs20170517a` 인스턴스를 삭제하려면 다음과 같은 명령을 사용하십시오. 

```sh
bx service delete cs20170517a
```
{:pre}

