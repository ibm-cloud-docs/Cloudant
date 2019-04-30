---

copyright:
  years: 2019
lastupdated: "2019-03-18"

keywords: endpoints, service credentials, authentication, ibm cloudant dashboard, curl, client libraries

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

<!-- Acrolinx: 2018-07-02 -->

# 연결
{: #connecting}

{{site.data.keyword.cloudantfull}}는 HTTP API를 통해 액세스됩니다. 이 문서는 {{site.data.keyword.cloudant_short_notm}}에 연결하는 데 사용하는 여러 파트를 설명합니다.
- 엔드포인트
- 서비스 인증 정보
- 인증
- {{site.data.keyword.cloudant_short_notm}} 대시보드에 액세스
- [curl ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://curl.haxx.se/){: new_window} 또는 클라이언트 라이브러리를 통해 프로그래밍 방식으로 {{site.data.keyword.cloudant_short_notm}}에 액세스
{: shortdesc}

## 엔드포인트
{: #endpoints}

{{site.data.keyword.cloudant_short_notm}}는 HTTP API 엔드포인트를 통해 액세스됩니다. 인스턴스의 엔드포인트는
인스턴스에 대해 생성된 서비스 인증 정보의 URL 필드 및 {{site.data.keyword.cloudant_short_notm}} 대시보드의
**계정** > **설정** 탭에 표시됩니다.

모든 {{site.data.keyword.cloudant_short_notm}} HTTP 엔드포인트는 TLS를 통해 액세스되어야 하므로 앞에 `https://`가 와야 합니다.

공개적인 외부 엔드포인트는 다음과 같습니다.

`https://USERNAME.cloudant.com`

2019년 1월 1일 이후에 프로비저닝된 모든 인스턴스에는 appdomain.cloud 도메인 엔드포인트가 포함됩니다. 공개적인
외부 엔드포인트는 다음과 같습니다.

`https://USERNAME.cloudantnosqldb.appdomain.cloud`

내부 엔드포인트는 EU 관리 환경 외부에서 2019년 1월 1일 이후에 프로비저닝된 데디케이티드
하드웨어 환경에 배치된 모든 인스턴스에 추가됩니다. {{site.data.keyword.cloud_notm}} 내부 네트워크 엔드포인트는 다음과 같습니다.

`https://USERNAME.private.cloudantnosqldb.appdomain.cloud`

여기서 USERNAME은 URL에 있는 서비스 인스턴스 사용자의 서비스 이름입니다. 또한 이 필드는
{{site.data.keyword.cloudant_short_notm}} 레거시 인증을 사용할 때 관리자 이름으로 사용됩니다. USERNAME 예는
de810d0e-763f-46a6-ae88-50823dc85581-bluemix이며, 결과 예의 외부 엔드포인트는
de810d0e-763f-46a6-ae88-50823dc85581-bluemix.cloudantnosqldb.appdomain.cloud가 됩니다. 

## 서비스 인증 정보
{: #service-credentials}

{{site.data.keyword.cloud_notm}} 대시보드를 통해 {{site.data.keyword.cloudant_short_notm}}에 대한 서비스 인증 정보를 생성하려면
[{{site.data.keyword.cloud_notm}}에서 {{site.data.keyword.cloudant_short_notm}} 인스턴스 작성](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-an-ibm-cloudant-instance-on-ibm-cloud) 튜토리얼을 참조하십시오. {{site.data.keyword.cloud_notm}} CLI에서
서비스 인증 정보를 생성하려면 [{{site.data.keyword.cloudant_short_notm}} 서비스에 대한 인증 정보
작성](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli#creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli)을 참조하십시오. 

다음은 {{site.data.keyword.cloudant_short_notm}} 인스턴스에 대한 서비스 인증 정보 예입니다.

```json
{
  "apikey": "MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz",
  "host": "76838001-b883-444d-90d0-46f89e942a15-bluemix.cloudant.com",
  "iam_apikey_description": "Auto generated apikey during resource-key [...]",
  "iam_apikey_name": "auto-generated-apikey-050d21b5-5f[...]",
  "iam_role_crn": "crn:v1:bluemix:public:iam::::serviceRole:Manager",
  "iam_serviceid_crn": "crn:v1:staging:public:iam-identity::[...]",
  "password": "8fb6a16b48903e87b769e7f4968521e85c2394ed8f0e69b2769e56dcb27d2e76",
  "port": 443,
  "url": "https://<username>:<password>@76838001-b883-444d-90d0-46f89e942a15-bluemix.cloudant.com",
  "username": "76838001-b883-444d-90d0-46f89e942a15-bluemix"
}
```
{: codeblock}

서비스 인증 정보는 다음 필드를 포함합니다.

필드 |용도
------|--------
`username` | URL 내 서비스 인스턴스 사용자의 서비스 이름입니다. 이 필드는 관리자 이름의 역할도 수행합니다. 
`password` | 애플리케이션이 서비스 인스턴스에 액세스하는 데 필요한 레거시 인증 정보 비밀번호입니다. 이 필드는 `Use both legacy credentials and IAM` 옵션이 선택된 경우에만 표시됩니다. 
`host` |애플리케이션이 서비스 인스턴스를 찾는 데 사용하는 호스트 이름입니다. 이 필드는 `Use both legacy credentials and IAM` 옵션이 선택된 경우에만 표시됩니다. 
`port` | 호스트의 서비스 인스턴스에 액세스하는 데 필요한 HTTPS 포트 번호입니다. 이는 443으로, {{site.data.keyword.cloudant_short_notm}}에서 허용하는 유일한 HTTPS 액세스입니다. 이 필드는 `Use both legacy credentials and IAM` 옵션이 선택된 경우에만 표시됩니다. 
`url`	| {{site.data.keyword.cloudant_short_notm}} 인스턴스에 액세스하는 데 필요한 HTTPS URL입니다. `Use both legacy credentials and IAM` 옵션이 선택된 경우 이는 임베드된 레거시 사용자 이름 및 비밀번호 또한 포함합니다. 
`apikey` | IAM API 키입니다. 
`iam_apikey_description` | IAM API 키에 대한 설명입니다. 
`iam_apikey_name` | IAM API 키의 ID입니다.
`iam_role_crn` | IAM API 키가 가진 IAM 역할입니다.
`iam_serviceid_crn`	| 서비스 ID의 CRN입니다.

## 인증
{: #authentication-overview}

{{site.data.keyword.cloudant_short_notm}}에는 프로비저닝 시에 사용할 수 있는 두 가지 인증 방법(`Use only IAM` 또는 `Use both legacy credentials and IAM`)이 있습니다. `Use both legacy credentials and IAM`
인증 방법을 선택한 경우에만 서비스 인증 정보에서 레거시 인증 정보에 대한 세부사항을 볼 수 있습니다. 인증 정보는 인스턴스의 서비스 인증 정보 탭에 표시됩니다. 두 인증 스타일을 사용하는 데 대한 자세한 정보는 [IAM 안내서](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-) 및 [레거시 인증](/docs/services/Cloudant?topic=cloudant-authentication#authentication) 문서를 참조하십시오.
 
{{site.data.keyword.cloudant_short_notm}} 팀에서는 가능한 한 인증에 대한 IAM 액세스 제어를 사용할 것을 권장합니다. {{site.data.keyword.cloudant_short_notm}} 레거시 인증을 사용하는 경우 프로그래밍 방식의 액세스 및 복제 작업에 대한 계정 레벨 인증 정보가 아닌 [API 키](/docs/services/Cloudant?topic=cloudant-authorization#api-keys){: new_window}를 사용하는 것이 좋습니다.
{: important}

## {{site.data.keyword.cloudant_short_notm}} 대시보드
{: #ibm-cloudant-dashboard}

{{site.data.keyword.cloud_notm}} 대시보드 인스턴스 세부사항 페이지의 관리 탭으로 이동하여 인스턴스에 대한
{{site.data.keyword.cloudant_short_notm}} 대시보드를 열 수 있습니다. `Launch` 또는 `Launch Cloudant Dashboard` 단추를
사용하여 새 브라우저 탭에서 대시보드를 열 수 있습니다. {{site.data.keyword.cloudant_short_notm}} 대시보드에서는 다음 태스크를 수행할 수 있습니다.

- 인스턴스의 현재 이용 모니터
- {{site.data.keyword.cloudant_short_notm}} 데이터베이스, 문서 및 인덱스에 대한 작성, 읽기, 업데이트, 삭제(CRUD) 수행
- 복제 작업 설정 및 보기
- 활성 태스크 보기
- 프로비저닝된 처리량 용량, 공지사항, CORS 및 설정과 같은 계정 정보 보기 및 업데이트

## 프로그래밍 방식의 액세스
{: #programmatic-access}

### 명령행(curl)
{: #command-line-curl-}

curl 명령행 유틸리티를 활용하여 {{site.data.keyword.cloudant_short_notm}} HTTPS API에 액세스할 수 있습니다. 

{{site.data.keyword.cloudant_short_notm}} 레거시 인증을 사용하는 경우, API 참조 예에 표시된 대로
사용자 이름과 비밀번호를 제공하여 curl로 {{site.data.keyword.cloudant_short_notm}} API에 액세스하는 데 대한 세부사항은
[API 참조 개요](/docs/services/Cloudant?topic=cloudant-api-reference-overview#api-reference-overview)를 참조하십시오.

{{site.data.keyword.cloud_notm}} IAM 인증을 사용하는 경우, API 키를 사용하여 먼저 {{site.data.keyword.cloud_notm}} IAM 토큰을 가져와야 합니다. 그런 다음 인증을 위해 IAM 토큰을 {{site.data.keyword.cloudant_short_notm}} 인스턴스에 전달합니다. [{{site.data.keyword.cloud_notm}} IAM 토큰을
전달하여 서비스 API로 인증](https://cloud.ibm.com/docs/services/iam?topic=iam-iamapikeysforservices#token_auth){: new_window}
튜토리얼을 참조하십시오. 

IAM API 키를 직접 사용하여 {{site.data.keyword.cloudant_short_notm}}에 대해 인증할 수 없습니다.
{: note}

### 클라이언트 라이브러리
{: #client-libraries-overview}

{{site.data.keyword.cloudant_short_notm}}에는 Java, Node.js, Python, Swift 및 모바일을 위한 공식 클라이언트 라이브러리가 있습니다. 자세한 정보는 라이브러리 액세스를 위한
[클라이언트 라이브러리 문서](/docs/services/Cloudant?topic=cloudant-client-libraries#client-libraries) 및 각각의 {{site.data.keyword.cloudant_short_notm}} 인스턴스에 연결하는 데 대한 예제를 참조하십시오. 
