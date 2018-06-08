---

copyright:
  years: 2017, 2018
lastupdated: "2017-11-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-01-10 -->

# {{site.data.keyword.cloudant_short_notm}} 데이터베이스에 액세스하기 위한 간단한 {{site.data.keyword.Bluemix_notm}} 애플리케이션 작성: 전제조건

이 튜토리얼 섹션에서는 {{site.data.keyword.Bluemix}} 애플리케이션 작성을 위한 전제조건을 설명합니다.
{:shortdesc}

## 전제조건

이 튜토리얼을 시작하기 전에 다음 리소스 또는 정보가 준비되어 있는지 확인하십시오.

### Python

가능한 한 간단한 개발 작업을 위해, 시스템에 [Python 프로그래밍 언어 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://www.python.org/){:new_window}의
현재 버전이 있어야 합니다.

이를 확인하려면 프롬프트에서 다음 명령을 실행하십시오.

```sh
python --version
```
{:pre}

다음 출력과 유사한 결과가 표시됩니다.

```
Python 2.7.12
```
{:codeblock}

<div id="csi"></div>

### {{site.data.keyword.Bluemix_notm}}의 {{site.data.keyword.cloudant_short_notm}} 서비스 인스턴스

'`Cloudant Service 2017`'이라는 {{site.data.keyword.cloudantfull}} 서비스 인스턴스를 작성하는
별도의 튜토리얼은 [여기](create_service.html)에 있습니다.

이 튜토리얼에서는 사용자가 이미 '`Cloudant Service 2017`'이라는 서비스 인스턴스를 작성했다고 가정합니다.

### {{site.data.keyword.cloudant_short_notm}} 데이터베이스 애플리케이션

{{site.data.keyword.cloudant_short_notm}} 서비스 인스턴스 관련 작업을 수행하기 위한 독립형 Python 애플리케이션을 작성하는
별도의 튜토리얼은 [여기](create_database.html)에 있습니다.
이 튜토리얼에서는 {{site.data.keyword.cloudant_short_notm}} 데이터베이스를
작성하고 채우는 방법을 이해하는 데 도움이 되는 몇 가지 개념을 소개합니다.

이 튜토리얼에서는 사용자가 이러한 개념을 잘 알고 있다고 가정합니다.

## 다음 단계

튜토리얼의 다음 단계는 [애플리케이션 환경 작성](create_bmxapp_appenv.html)입니다.
