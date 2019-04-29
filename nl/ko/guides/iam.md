---

copyright:
  years: 2017, 2019
lastupdated: "2019-03-06"

keywords: legacy access controls, api keys, enable iam, provisioning, how to choose between iam and legacy credentials, making requests, required client libraries, actions, endpoints, map actions to iam roles

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

# {{site.data.keyword.cloud_notm}} Identity and Access Management(IAM)
{: #ibm-cloud-identity-and-access-management-iam-}

{{site.data.keyword.cloud}} Identity and Access Management는 사용자 ID, 서비스 및 액세스 제어를 관리하는 통합된 접근 방식을 제공합니다.
{: shortdesc}

## 소개
{: #introduction}

이 문서는 {{site.data.keyword.cloudantfull}}와 {{site.data.keyword.cloud_notm}} Identity and Access Management의 통합에 대해 설명합니다. 여기서는 {{site.data.keyword.cloudant_short_notm}}의 레거시 액세스 제어와
{{site.data.keyword.cloud_notm}} IAM의 액세스 제어에 대해 다룹니다. 그 다음에는 각각의 장점 및 단점을 살펴보며 사용자가 어느 쪽을 사용할지 결정하는 데 도움을 줍니다. 그 후에는 {{site.data.keyword.cloudant_short_notm}}의
클라이언트 라이브러리 내에서 IAM을 사용하는 방법과 HTTP 호출을 통해 IAM을 사용하는 방법을 알아봅니다. 마지막으로는 {{site.data.keyword.cloudant_short_notm}} 내에서
사용 가능한 모든 IAM 조치 및 역할이 설명되어 있는 참조 섹션이 제공됩니다.

다음 작업을 수행하는 방법을 포함, [IAM ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://cloud.ibm.com/docs/iam/index.html#iamoverview){: new_window}에 대한 개요를 참조하십시오.

- 사용자 및 서비스 ID를 관리합니다.
- 사용 가능한 인증 정보를 관리합니다.
- {{site.data.keyword.cloudant_short_notm}} 서비스 인스턴스에 대한 액세스를 허용하거나 취소하는 IAM 액세스 정책을 사용합니다.

## {{site.data.keyword.cloudant_short_notm}} 레거시 액세스 제어와 IAM 액세스 제어의 차이점
{: #differences-between-ibm-cloudant-legacy-and-iam-access-controls}

다음 섹션은 {{site.data.keyword.cloudant_short_notm}} 레거시 액세스 제어 메커니즘과 {{site.data.keyword.cloud_notm}} IAM의 액세스 제어 메커니즘 간의 차이점에 대한 간략한 개요를 제공합니다.

### {{site.data.keyword.cloud_notm}} Identity and Access Management
{: #ibm-cloud-identity-and-access-management}

- {{site.data.keyword.cloud_notm}} 전체에서 중앙 집중식으로 액세스를 관리합니다.
- 사용자 또는 서비스가 동일한 인증 정보 세트(예: 동일한 사용자 이름/비밀번호 또는 IAM API 키)를
  사용하여 다양한 리소스에 액세스할 수 있도록 허용합니다.
- IAM API 키에는 새 데이터베이스 작성과 같은 계정 관리 기능에 대한 액세스 권한이
  부여될 수 있습니다.

### {{site.data.keyword.cloudant_short_notm}} 레거시
{: #ibm-cloudant-legacy}

- {{site.data.keyword.cloudant_short_notm}}에 고유합니다.
- 각 서비스 인스턴스에 대한 액세스에는 해당 인증 정보 세트가 필요합니다.
- 개별 사용자 또는 서비스에 바인드되지 않은 인증 정보로 HTTP 기본 인증을
  사용합니다.
- {{site.data.keyword.cloudant_short_notm}} API 키는 데이터베이스 레벨에서만 권한 부여될 수 있습니다.

### API 키 참고
{: #api-key-notes}

이 문서에서 API 키가 언급되는 모든 경우 이는 IAM API 키를 가리킵니다.
{{site.data.keyword.cloudant_short_notm}} 레거시에도 API 키 개념이 있으며, {{site.data.keyword.cloudant_short_notm}} 레거시 인증 정보 또는 사용자 이름/비밀번호 조합에 대한 모든 내용 또한 {{site.data.keyword.cloudant_short_notm}} API 키를 포함합니다. 

## {{site.data.keyword.cloudant_short_notm}}에서의 IAM 사용 설정
{: #enabling-iam-with-ibm-cloudant}

2018년 7월 말부터, 새 {{site.data.keyword.cloudant_short_notm}} 서비스 인스턴스만 {{site.data.keyword.cloud_notm}} IAM과 함께 사용할 수 있습니다.

모든 새 {{site.data.keyword.cloudant_short_notm}} 서비스 인스턴스는 프로비저닝될 때 IAM을 사용하도록 설정됩니다. 선택적으로 레거시 인증 메커니즘을 사용하도록 설정할 수도 있습니다.  {{site.data.keyword.cloud_notm}} 카탈로그에서 새 {{site.data.keyword.cloudant_short_notm}} 인스턴스를 프로비저닝할 때는 사용 가능한 인증 메소드 중에서 하나를 선택하십시오.

1. **레거시 인증 정보와 IAM을 둘 다 사용**: 이 모드는 계정에 액세스하는 데 IAM 및 레거시 인증 정보를 둘 다 사용할 수 있음을 의미합니다. 구체적으로 말하면, 계정에 바인드된 모든 애플리케이션에는 IAM 및 레거시 인증 정보 세트가 제공되며 서비스 인증 정보가 생성됩니다.
2. **IAM만 사용**: 이 모드는 IAM 인증 정보만 서비스 바인딩 및 인증 정보 생성을 통해 제공됨을
    의미합니다.

### {{site.data.keyword.cloudant_short_notm}} API 키 및 _IAM만 사용_
{: #ibm-cloudant-api-keys-and-_use-only-iam_}

IAM과 함께 {{site.data.keyword.cloudant_short_notm}} API 키를 사용하는 것은 가능하지만 **권장되지 않습니다**. 그 이유는,
IAM 정책 인터페이스를 통해 {{site.data.keyword.cloudant_short_notm}} API 키 및 권한을 보거나 관리할 수 없어
포괄적인 액세스 관리가 불가능해지기 때문입니다.

_IAM만 사용_ 또는 _레거시 인증 정보와 IAM을 둘 다 사용_ 중 하나를 선택하는 것은 다음 항목에 영향을 줍니다.

1. 레거시 {{site.data.keyword.cloudant_short_notm}} 계정 레벨 인증 정보의 데이터베이스 및 기타 계정 레벨 조치
    관리 가능 여부.
2. 서비스 인증 정보 생성 중에 전달되는 인증 정보의 스타일.

특히, {{site.data.keyword.cloudant_short_notm}} API 키는 여전히 데이터베이스 액세스를 관리하는 데 사용할 수 있습니다. 이러한 인증 정보는
HTTP API를 사용하여 생성하고 구성해야 합니다.

### 명령행을 사용한 프로비저닝
{: #provisioning-by-using-the-command-line}

명령행에서 새 {{site.data.keyword.cloudant_short_notm}} 인스턴스를 프로비저닝하는 경우에는 계정에 대해 레거시 인증 정보를 사용 또는 사용 안함으로
설정하기 위해 `-p` 매개변수를 사용하여 `ic` 도구에 옵션을 제공하십시오. 이 옵션은
JSON 형식으로 전달되며 이름은 `legacyCredentials`입니다.

_IAM만 사용_으로 인스턴스를 프로비저닝하려면(권장됨) 다음 명령을 실행하십시오.

```sh
ic resource service-instance-create  "Instance Name" \
    cloudantnosqldb Standard us-south \
    -p {"legacyCredentials": false}
```

_레거시 인증 정보와 IAM을 둘 다 사용_으로 인스턴스를 프로비저닝하려면 다음 명령을 실행하십시오.

```sh
ic resource service-instance-create  "Instance Name" \
    cloudantnosqldb Standard us-south \
    -p {"legacyCredentials": true}
```

### 각 옵션에 대한 서비스 인증 정보 JSON 예
{: #service-credential-json-examples-for-each-option}

_IAM만 사용_ 및 _레거시 인증 정보와 IAM을 둘 다 사용_ 액세스 제어 중
하나를 선택하는 것은 서비스 인증 정보를 바인드하고 생성할 때 애플리케이션에 인증 정보가
전달되는 방식에 영향을 줍니다. 기본 {{site.data.keyword.cloud_notm}} IAM 인터페이스 내에서
인증 정보를 생성하는 경우, API 키는 생성되면 해당 인터페이스에 표시됩니다.

서비스 인스턴스의 서비스 인증 정보 섹션에서 인증 정보를 생성할 수도
있습니다. 이 방식으로 서비스 인증 정보를 생성하면 서비스 인스턴스에 액세스하는 데 필요한 모든 세부사항을 포함하는, 애플리케이션에 붙여 넣을 수 있는 서비스 인증 정보 JSON BLOB이 작성됩니다.

이 섹션은 서비스 인증 정보 JSON의 양식과
각 값의 의미를 보여줍니다.

_IAM만 사용_을 선택하는 경우 생성되는 서비스 인증 정보는 IAM 값만 포함하며
다음 예와 같은 양식을 보입니다.

```json
{
  "apikey": "MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz",
  "iam_apikey_description": "Auto generated apikey during resource-key [...]",
  "iam_apikey_name": "auto-generated-apikey-050d21b5-5f[...]",
  "iam_role_crn": "crn:v1:bluemix:public:iam::::serviceRole:Manager",
  "iam_serviceid_crn": "crn:v1:staging:public:iam-identity::[...]",
  "url": "https://76838001-b883-444d-90d0-46f89e942a15-bluemix.cloudant.com",
  "username": "76838001-b883-444d-90d0-46f89e942a15-bluemix"
}
```

이전 JSON 예의 각 값은 다음과 같이 해석해야 합니다.

- `apikey`: IAM API 키입니다.
- `iam_apikey_description`: IAM API 키에 대한 설명입니다.
- `iam_apikey_name`: IAM API 키의 ID입니다.
- `iam_role_crn`: IAM API 키가 가진 IAM 역할입니다.
- `iam_serviceid_crn`: 서비스 ID의 CRN입니다.
- `url`: {{site.data.keyword.cloudant_short_notm}} 서비스 URL입니다.
- `username`: 내부 {{site.data.keyword.cloudant_short_notm}} 계정 이름입니다.

_레거시 인증 정보와 IAM을 둘 다 사용_을 선택하는 경우에는 생성되는 서비스 인증 정보가 IAM 및 레거시 인증 정보를 둘 다 포함하며 다음 예와 같은 양식을 보입니다.

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

이전 JSON 예의 각 값은 다음과 같이 해석해야 합니다.

- `apikey`: IAM API 키입니다.
- `host`: {{site.data.keyword.cloudant_short_notm}} 서비스 호스트 이름입니다.
- `iam_apikey_description`: IAM API 키에 대한 설명입니다.
- `iam_apikey_name`: IAM API 키의 ID입니다.
- `iam_role_crn`: IAM API 키가 가진 IAM 역할입니다.
- `iam_serviceid_crn`: 서비스 ID의 CRN입니다.
- `password`: {{site.data.keyword.cloudant_short_notm}} 레거시 인증 정보 비밀번호입니다.
- `port`: {{site.data.keyword.cloudant_short_notm}} 서비스 포트입니다.
- `url`: {{site.data.keyword.cloudant_short_notm}} 서비스 URL입니다(임베드된 {{site.data.keyword.cloudant_short_notm}} 레거시 인증 정보 포함).
- `username`: {{site.data.keyword.cloudant_short_notm}} 레거시 인증 정보 사용자 이름입니다.

## _IAM만 사용_ 또는 _레거시 인증 정보와 IAM을 둘 다 사용_ 중 어떤 것을 선택하여 사용해야 합니까?
{: #should-i-use-_use-only-iam_-or-_use-both-legacy-credentials-and-iam_-}

가능한 경우에는 _IAM만 사용_을 사용하는 것이 좋습니다. {{site.data.keyword.cloud_notm}} IAM 사용의
주요 장점은 다음과 같습니다.

- {{site.data.keyword.cloud_notm}} 및 {{site.data.keyword.cloudant_short_notm}} 고유 인증 정보 관리 기능의 결합이 아닌,
  {{site.data.keyword.cloud_notm}}의 표준 도구를 사용하여 {{site.data.keyword.cloudant_short_notm}}에 대한 액세스를 관리합니다.
- {{site.data.keyword.cloud_notm}} IAM을 사용하면 인증 정보를 손쉽게 취소하거나 순환시킬 수 있습니다.

각 접근 방식의 장점 및 단점에 대한 자세한 설명은 다음과 같습니다.

### 두 액세스 제어 메커니즘의 장점 및 단점
{: #advantages-and-disadvantages-of-the-two-access-control-mechanisms}

전반적으로는 {{site.data.keyword.cloud_notm}} IAM이 권장되는 인증 모델입니다. 그러나
기존 애플리케이션이 있거나 {{site.data.keyword.cloudant_short_notm}} 지원 클라이언트 라이브러리를
사용할 수 없는 경우 등에는 이 접근 방식에 단점이 있습니다.

<table>

<tr>
<th id="mode">모드</th>
<th id="advantages">장점</th>
<th id="disadvantages">단점</th>
</tr>

<tr>
<td headers="mode">IAM</td>
<td headers="advantages" valign="top"><ul><li>하나의 인터페이스를 사용하여 다양한 서비스에 대한 액세스를 관리합니다. 사용자의 액세스 권한을 글로벌 범위에서 취소합니다.</li>
<li>서비스 ID를 통한 계정 레벨 API 키.</li>
<li>순환이 용이한 인증 정보.</li>
<li>Activity Tracker 로그는 개별 사용자 및 서비스를 캡처합니다.</li>
<li>IAM은 엔터프라이즈 LDAP 저장소 등의 다른 ID 시스템과 연합될 수 있습니다.</li></ul>
</td>
<td headers="disadvantages"><ul><li>{{site.data.keyword.cloudant_short_notm}} 지원 라이브러리를 사용하고 있지 않은 경우에는 IAM의 API 키 및 액세스 토큰을 사용하기 위해 애플리케이션을 변경해야 할 가능성이 높습니다.</li>
<li>아직 데이터베이스 레벨 권한이 없습니다.</li>
<li>아직 세분화된 권한(예: 독자)이 없습니다.</li>
<li>일부 엔드포인트를 사용할 수 없습니다. [사용 불가능한 엔드포인트](#unavailable-endpoints)를 참조하십시오.</li>
<li>액세스하는 데 권한 부여된 사용자를 필요로 하지 않는 "공용"으로 데이터베이스를 지정하는 방법이 없습니다.</li></ul>
</td>
</tr>

<tr>
<td headers="mode">레거시</td>
<td headers="advantages">
<ul><li>기존 애플리케이션 또는 클라이언트 라이브러리 종속 항목을 변경할 필요가 없습니다.</li>
<li>데이터베이스 레벨 권한이 있습니다.</li>
<li>세분화된 역할(독자, 작성자)이 있습니다.</li>
</ul>
</td>
<td headers="disadvantages">
<ul><li>계정 레벨 API 키가 없습니다. 데이터베이스를 관리하려면 `root` 인증 정보를 사용해야 합니다.</li>
<li>{{site.data.keyword.cloudant_short_notm}} 인증 정보를 별도로 관리하므로 중앙 집중식 인터페이스에서 모든 액세스에 대한 전체 개요를 얻을 수 없습니다.</li>
<li>인증 정보 순환을 구현하기 어렵습니다.</li>
</ul>
</td>
</tr>
</table>

## IAM 인증 정보를 사용하여 인스턴스에 대한 요청 수행
{: #making-requests-to-instances-by-using-iam-credentials}

이 섹션은 IAM 인증 및 액세스 제어를 사용하여 {{site.data.keyword.cloudant_short_notm}}를
서비스 인스턴스와 함께 사용하는 방법을 다룹니다. 여기서는 이전에 언급된 서비스 인증 정보 JSON 예의
세부사항을 사용합니다.

{{site.data.keyword.cloud_notm}} IAM은 리소스 또는 서비스에 대해 요청하기 전에 시간 제한 액세스 토큰을 위해 IAM API 키를 교환할 것을 요구합니다. 그 후 이 액세스 토큰은 서비스에 대한 `Authorization` HTTP 헤더에 포함됩니다. 이 액세스 토큰이 만료되는 경우 이용 애플리케이션이 IAM 토큰 서비스로부터 새 토큰을 가져오는 작업을 처리해야 합니다. 자세한 정보는 [Getting an {{site.data.keyword.cloud_notm}} IAM token by using an API key ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://cloud.ibm.com/docs/iam/apikey_iamtoken.html#iamtoken_from_apikey) 문서를 참조하십시오.

{{site.data.keyword.cloudant_short_notm}}의 공식 클라이언트 라이브러리는 사용자 대신 API 키에서 토큰을 획득하는 작업을 처리합니다. {{site.data.keyword.cloudant_short_notm}} 클라이언트 라이브러리가 아니라 HTTP 클라이언트를 사용하여 {{site.data.keyword.cloudant_short_notm}}에 직접 액세스하는 경우에는 사용자가 IAM API 키를 IAM 토큰 서비스와 함께 사용하여 시간 제한 액세스 토큰의 교환 및 새로 고치기 작업을 처리해야 합니다. 토큰이 만료되면 {{site.data.keyword.cloudant_short_notm}}는 HTTP `401` 상태 코드를 리턴합니다.

### 필수 클라이언트 라이브러리 버전
{: #required-client-library-versions}

IAM 사용 {{site.data.keyword.cloudant_short_notm}} 서비스 인스턴스에는
최소한 다음 클라이언트 라이브러리 버전을 사용하십시오.

| 라이브러리 | 권장 |
| --- | --- |
| [java-cloudant](https://github.com/cloudant/java-cloudant) | 2.13.0+ |
| [nodejs-cloudant](https://github.com/cloudant/nodejs-cloudant) | 2.3.0+ |
| [python-cloudant](https://github.com/cloudant/python-cloudant) | 2.9.0+ |
| [couchbackup](https://github.com/cloudant/couchbackup/) | 2.3.1+ |
| [CDTDatastore](https://github.com/cloudant/cdtdatastore/) | 2.0.3+ |
| [sync-android](https://github.com/cloudant/sync-android/) | 2.2.0+ |

다음 코드 스니펫은 이러한 버전을 필요로 합니다.

### Java
{: #java}

[java-cloudant](https://github.com/cloudant/java-cloudant) 2.13.0+를 필요로 합니다.

IAM API 키를 사용하여 데이터베이스 클라이언트를 작성하려면 `iamApiKey()` 메소드를 사용하십시오.

```java
package com.mycompany.app;

import com.cloudant.client.api.ClientBuilder;
import com.cloudant.client.api.CloudantClient;


public class App
{
    public static void main( String[] args )
    {
        CloudantClient client = ClientBuilder
                .account("76838001-b883-444d-90d0-46f89e942a15-bluemix")
                .iamApiKey("MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz")
                .build();

        for (String db : client.getAllDbs()) {
            System.out.println(db);
        }
    }
}
```

### Node.js
{: #node.js}

[nodejs-cloudant](https://github.com/cloudant/nodejs-cloudant) 2.3.0+를 필요로 합니다.

IAM API 키를 사용하여 데이터베이스 클라이언트를 작성하려면 `iamauth()` 플러그인을 사용하십시오.

```js
var Cloudant = require('@cloudant/cloudant');

var cloudant = new Cloudant({
  account: '76838001-b883-444d-90d0-46f89e942a15-bluemix',
  plugins: {
    iamauth: {
      iamApiKey: 'MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz'
    }
  }
});
cloudant.db.list(function(err, body) {
  body.forEach(function(db) {
    console.log(db);
  });
});
```

### Python
{: #python}

[python-cloudant](https://github.com/cloudant/python-cloudant) 2.9.0+를 필요로 합니다.

IAM API 키를 사용하여 데이터베이스 클라이언트를 작성하려면 `Cloudant.iam(account_name, api_key, **kwargs)` 메소드를 사용하십시오.

```python
from cloudant.client import Cloudant

client = Cloudant.iam(
    "76838001-b883-444d-90d0-46f89e942a15-bluemix",
    "MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz",
    connect=True
)
print client.all_dbs()
```

### HTTP 클라이언트를 사용한 액세스
{: #access-by-using-http-client}

{{site.data.keyword.cloud_notm}} IAM은 리소스 또는 서비스에 대해 요청하기 전에 시간 제한 액세스 토큰을 위해
IAM API 키를 교환할 것을 요구합니다. 그 후 이 액세스 토큰은 서비스에 대한
`Authorization` HTTP 헤더에 포함됩니다. 이 액세스 토큰이
만료되는 경우 클라이언트는 IAM 토큰 서비스로부터 새 토큰을 가져오는 작업을
처리해야 합니다.

이전에 언급된 바와 같이, {{site.data.keyword.cloud_notm}} IAM을 사용하려면 먼저 시간 제한 토큰을 위해 {{site.data.keyword.IBM_notm}} API 키를 교환한 후 이 토큰을 사용하여 {{site.data.keyword.cloudant_short_notm}} API에 인증해야 합니다.

Python에서 이 예의 양식은 다음과 같을 수 있습니다.

```python
import time

import requests

API_KEY = "MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz"
ACCOUNT = "76838001-b883-444d-90d0-46f89e942a15-bluemix"

def get_access_token(api_key):
    """Retrieve an access token from the IAM token service."""
    token_response = requests.post(
        "https://iam.cloud.ibm.com/identity/token",
        data={
            "grant_type": "urn:ibm:params:oauth:grant-type:apikey",
            "response_type": "cloud_iam",
            "apikey": api_key
        },
        headers={
            "Accept": "application/json"
        }
    )
    if token_response.status_code == 200:
        print "Got access token from IAM"
        return token_response.json()['access_token']
    else:
        print token_response.status_code, token_response.json()
        return None

def main(api_key, account):
    access_token = None
    while True:
        if not access_token:
            access_token = get_access_token(api_key)

        if access_token:
            response = requests.get(
                "https://{0}.cloudant.com/_all_dbs".format(account),
                headers={
                    "Accept": "application/json",
                    "Authorization": "Bearer {0}".format(access_token)
                }
            )
            print "Got Cloudant response, status code", response.status_code
            if response.status_code == 401:
                print "Token has expired."
                access_token = None

        time.sleep(1)

if __name__ == "__main__":
    main(API_KEY, ACCOUNT)
```

## 참조
{: #reference}

이 섹션에는 {{site.data.keyword.cloudant_short_notm}}의 IAM 조치와 각 IAM 시스템 역할에
허용되는 조치에 대한 전체 목록이 포함되어 있습니다.

### {{site.data.keyword.cloudant_short_notm}} 조치
{: #ibm-cloudant-actions}

조치 |설명
-------|------------
`cloudant.db.any` | 모든 데이터베이스 엔드포인트(경로가 `/_api`로 시작하지 않는 것)에 액세스합니다.
`cloudantnosqldb.sapi.dbsecurity` | `/_api/v2/db/<path:db>/_security`에 액세스합니다.
`cloudantnosqldb.sapi.usercors` | `/_api/v2/user/config/cors/`에 액세스합니다.
`cloudantnosqldb.sapi.apikeys` | `/_api/v2/api_keys`에 액세스합니다.
`cloudantnosqldb.sapi.userinfo` | `/_api/v2/user`에 액세스합니다.

#### 사용 불가능한 엔드포인트
{: #unavailable-endpoints}

다음 엔드포인트는 IAM으로 권한 부여되는 요청에 사용할 수 없습니다.

- HTTP 재작성 핸들러: `/db/_design/design-doc/_rewrite/path`. <br>
디자인 문서가 재작성 핸들러를 포함할 수 있으나 사용자가 이를 호출할 수는 없습니다.
- 업데이트 핸들러: `POST /{db}/_design/{ddoc}/_update/{func}`. <br>
디자인 문서가 업데이트 함수를 포함할 수 있으나 사용자가 이를 호출할 수는 없습니다.

### {{site.data.keyword.cloudant_short_notm}} 조치 대 IAM 역할 맵핑
{: #mapping-of-ibm-cloudant-actions-to-iam-roles}

관리자 역할 사용자 및 서비스만 {{site.data.keyword.cloudant_short_notm}} 데이터에 액세스할 수 있습니다.

역할 | 허용된 조치
-----|----------------
관리자 | 기록된 모든 조치.
독자 |없음.
작성자 |없음.

## 문제점 해결
{: #troubleshooting}
{{site.data.keyword.cloudant_short_notm}} 서비스 인스턴스에 대한 요청을 수행할 때 IAM을 사용하여 인증하는 데 문제가 있는 경우에는 다음 섹션에 표시된 대로 계정을 확인하십시오.

### 계정에서 IAM이 사용으로 설정되어 있는지 확인
{: #ensure-your-account-is-iam-enabled}

서비스 인스턴스에서 IAM이 사용으로 설정되어 있는지 확인하려면 지원 티켓을 열어야 합니다.
