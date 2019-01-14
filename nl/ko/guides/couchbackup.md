---

copyright:
  years: 2017, 2018
lastupdated: "2018-10-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-05-02 -->

# CouchBackup을 사용하여 데이터 백업

{{site.data.keyword.cloudant}}의 분산 특성은 내재된 형태의 데이터 백업을 제공합니다.
CouchBackup은 데이터를 백업하는 데 있어서 더 강력하고 유연한 방법을 제공하는 명령행 도구입니다.
{:shortdesc}

## 개요

{{site.data.keyword.cloudant_short_notm}}에서 제공하는 분산 특성의 이점은 클러스터를 사용하여 얻게 됩니다.
클러스터에서, 데이터베이스 내의 데이터는 여러 복사본으로 저장됩니다.
이들 사본은 최소 세 개의 개별 서버에 분산됩니다.
{{site.data.keyword.cloudant_short_notm}}는 클러스터를 데이터 스토리지로 사용함으로써
내재된 고가용성(HA) 및 재해 복구(DR) 특성을 갖게 됩니다.
{{site.data.keyword.cloudant_short_notm}}는 클러스터를
사용함으로써 데이터 손실 없이 클러스터 내 노드 손실을 견딜 수 있습니다.

그러나 이러한 HA 및 DR 특성을 갖춘 경우에도 개선된 데이터 백업이 필요한 다른 유스 케이스가 여럿 있습니다.

<div id="activepassive"></div>

### 데이터 센터 정전 및 재해 복구

클러스터 간의 [연속 복제](../api/replication.html#continuous-replication)는 {{site.data.keyword.cloudant_short_notm}} 클러스터가
완전히 사용 불가능한 상태가 아닌 경우에는 문제점에 대한 좋은 해결책입니다.
연속 복제는 '활성-수동' 모델입니다.
모델의 '활성' 부분이 연속 복제입니다.
모델의 '수동' 부분은 일반적으로 복제본이 애플리케이션의 요청에 응답하지 않도록 되어 있음을 나타냅니다.
대신, 이 복제본은 주로 원래 데이터베이스의 복제본으로 사용됩니다.
필요한 경우에는 이 복제본을 통해 데이터에 액세스할 수 있습니다.
또는, [복제](../api/replication.html)를 사용하여
복제본의 데이터를 다른 위치에 복원할 수도 있습니다.

>	**참고:** 복제본으로부터의 복제를 통해 큰 데이터베이스를 복원하는 데는 오랜 시간이 소요될 수 있습니다.

### 고가용성, 자동 장애 복구 및 지역 기반 로드 밸런싱

['활성-수동'](#activepassive) 접근법의 대안은 '활성-활성' 모델을 사용하기 위해 두 데이터 센터를 구성하는 것입니다.

이 모델에서는 클러스터 A에 있는 데이터베이스에 대한 변경사항이 클러스터 B에 있는 데이터베이스에 복제됩니다.
마찬가지로, 클러스터 B에 있는 데이터베이스에 대한 변경사항은 클러스터 A에 있는 데이터베이스에 복제됩니다.

>	**참고:** 이 모델은 {{site.data.keyword.cloudant_short_notm}} 대시보드를 사용하여 설정할 수 있습니다.
이는 {{site.data.keyword.cloudant_short_notm}} 지원의 조치를 필요로 하지 않습니다.

이 모델을 사용하면 특정 가용성 기준을 만족하는 경우 클러스터 중 하나로 '장애 복구'하도록 데이터베이스 애플리케이션을 디자인할 수 있습니다.
애플리케이션 디자인의 일부로서 이 가용성 기준을 정의할 수 있습니다.

애플리케이션 디자인에 지역 기반 '로드 밸런싱'을 포함시킬 수도 있습니다.
예를 들어,
특정 지리적 위치에서 사용되는 클라이언트 애플리케이션은 일반적으로 '가까운' 지역의 클러스터에
저장된 데이터에 액세스하는 경우 더 좋은 성능을 발휘합니다.
'가장 가까운' 클러스터를 식별하고
데이터베이스 조회 시 여기에 연결하도록 클라이언트 애플리케이션을 디자인하면 애플리케이션 성능에
도움이 됩니다.

다중 지역 애플리케이션 환경을 설정하는 방법을 설명하는 튜토리얼은
[여기 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](http://www.ibm.com/developerworks/cloud/library/cl-multi-region-bluemix-apps-with-cloudant-and-dyn-trs/index.html){:new_window}에 있습니다.

### 우발적 또는 악의적 데이터 수정

{{site.data.keyword.cloudant_short_notm}}에서는 데이터베이스의 스냅샷을 작성하는 메커니즘을 제공하지 않습니다.
이러한 유형의 기능을 필요로 하는 경우(이전 알려진 상태로의 문서 레벨 롤백을 가능하게 하게 위해 등)에는 다음 두 방법 중 하나로 동일한 효과를 얻을 수 있습니다.

1.	복제를 사용합니다. 이는 데이터베이스를 복제하여 수행합니다. 사용자는 최종 시퀀스 ID를 기록해 두어야 합니다. 그 후 원하는 스케줄에서 해당 데이터베이스를 새 데이터베이스로 복제하십시오. 마지막으로 기록된 시퀀스 ID부터 복제를 시작하십시오. 복제의 시퀀스 ID를 기록해 두면 롤업 메커니즘의 효과를 재현할 수 있습니다. 이 작업의 결과는 '일별' 스냅샷으로부터 정기적 '주별' 스냅샷을 작성하는 것과 유사합니다. 이 접근법의 한계는 삭제된 문서 개정판('삭제 표식') 및 해결되지 않은 충돌 또한 복제된다는 점입니다.

2.	데이터베이스 컨텐츠를 파일에 덤프합니다. 데이터베이스 컨텐츠를 파일에 덤프하는 데 사용할 수 있는 도구는 다양합니다. 결과 덤프 파일은 더 저렴한 블록 중심 디바이스 또는 서비스에 저장될 수 있습니다. 이 접근법의 한계는 이것이 일반적으로 현재 문서 개정판만 덤프한다는 점입니다. 이 한계는 해결되지 않은 충돌이 포함되지 않음을 의미합니다.

데이터베이스 덤프를 작성하는 것은 다양한 백업 솔루션을 가능하게 하는 효율적인 방법입니다.
따라서 내용의 나머지 부분에서는 이 접근법에 초점을 맞추고 있습니다.

<!--
https://developer.ibm.com/clouddataservices/2016/03/22/simple-couchdb-and-cloudant-backup/

A useful approach is to have couchbackup's snapshots placed on the {{site.data.keyword.cloud}} Object Storage service, as described here:

https://developer.ibm.com/recipes/tutorials/object-storage-cloudant-backup/
-->
