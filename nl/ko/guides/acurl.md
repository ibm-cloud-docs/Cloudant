---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: encode user name, encode password, create alias, activate alias, test acurl

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

# 권한 부여된 curl: `acurl`
{: #authorized-curl-acurl-}

_(이 안내서는 2013년 11월 27일에 공개된 Samantha Scharr의 블로그 글: [
"Authorized curl, a.k.a. acurl", originally published November 27, 2013.)_

`acurl`은 모든 요청에 대해 사용자 이름 및 비밀번호를 입력할 필요 없이
{{site.data.keyword.cloudantfull}} 명령을 URL에 `curl`로 전송할 수 있게 해 주는 편리한 별명입니다.
이는 데이터베이스에 대한 단순 `GET` 요청을 더 이상 `https://$ACCOUNT:$PASSWORD@$ACCOUNT.cloudant.com/foo`라 입력할 필요없이
`https://$ACCOUNT.cloudant.com/foo`만 사용하면 됨을 의미합니다.

`acurl` 별명은 불편하게 긴 URL의 길이를 줄일 뿐만 아니라 더 안전합니다.
이는 비밀번호 입력 시에 다른 사용자가 이를 훔쳐보는 것을 방지하며, 더 중요한 점은
HTTPS를 강제함으로써 비밀번호가 네트워크를 통해 일반 텍스트로 전송되지 않도록 한다는 것입니다.

이를 위해서는 간단한 세 단계만 수행하면 됩니다.

1.	[사용자 이름 및 비밀번호 인코딩](#encode-user-name-and-password)
2.	[별명 작성](#create-an-alias).
3.	[별명 활성화](#activate-the-alias)

Windows 컴퓨터를 사용하고 있는 경우에는 명령행에서 사용자 이름 및 비밀번호를 지정할 수 있습니다.
{: tip}

## 사용자 이름 및 비밀번호 인코딩
{: #encode-user-name-and-password}

먼저 사용자의 {{site.data.keyword.cloudant_short_notm}} 사용자 이름 및 비밀번호를 Base-64로 인코딩합니다.
이렇게 하면 Base-64 문자 시퀀스를 출력으로 얻을 수 있습니다.

특정 데이터를 Base-64 인코딩하는 명령은 다음 예와 유사합니다.

```python
python -c 'import base64; print base64.urlsafe_b64encode("$ACCOUNT:$PASSWORD")'
```
{: codeblock}

여기서는 출력의 이름을 `<OUTPUT-OF-BASE64>`로 가정합니다. 

예를 들어, 다음 명령을 사용하는 경우에는,

```python
python -c 'import base64; print base64.urlsafe_b64encode("$ACCOUNT:$PASSWORD")'
```
{: codeblock}

다음 출력을 얻게 됩니다.

```
bXl1c2VybmFtZTpteXBhc3N3b3Jk
```
{: codeblock}

비밀번호는 여전히 컴퓨터에 일반 텍스트로 저장되어 있다는 점을 기억하십시오.	Base64 인코딩은 암호화가 _아닙니다_. 동일한 문자 시퀀스의 Base-64 인코딩을 사용하면
	항상 동일한 해당 문자 출력 시퀀스를 얻게 됩니다.
{: note}

## 별명 작성
{: #create-an-alias}

이제 `curl` 명령을 작성할 때마다 인증 정보를 입력할 필요가 없도록 이러한 인증 정보를 포함하는 `curl`의 별명을 작성합니다.

`~/.bashrc` 또는 `~/.bash_profile`에 다음 행을 추가하십시오.

```sh
alias acurl="curl -s --proto '=https' -g -H 'Authorization: Basic <OUTPUT-OF-BASE64>'"
```
{: codeblock}

이 별명은 사용자가 명령행에 입력하는 URL에 권한 부여 인증 정보를 포함시키는 대신 권한 부여 헤더를 추가합니다.
또한 HTTPS 사용이 자동 설정되며, 이는 전송 중에 사용자의 데이터 및 인증 정보를 암호화하고
사용자가 {{site.data.keyword.cloudant_short_notm}} 시스템에 연결하고 있는지 확인하는 데 도움을 주므로 일반 HTTP를 사용하는 것보다 훨씬 바람직합니다.

## 별명 활성화
{: #activate-the-alias}

이제 새 쉘을 시작하거나 `source ~/.bash_profile`(또는 `~/.bashrc`를 사용하던 경우에는 이것)을 실행하여 별명이 작동하도록 설정합니다.

## `acurl` 테스트
{: #testing-acurl-}

이제 모든 것이 올바르게 설정되었는지 확인합니다.
다음을 실행합니다.

```sh
acurl https://$ACCOUNT.cloudant.com/_all_dbs
```
{: codeblock}

사용자의 데이터베이스 목록이 리턴되면 성공한 것입니다.
`acurl`이 설정되어 사용할 준비가 되었습니다.

즐거운 코딩하세요!
