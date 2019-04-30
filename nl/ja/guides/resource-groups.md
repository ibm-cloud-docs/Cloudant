---

copyright:
  years: 2015, 2019
lastupdated: "2019-02-27"

keywords: migrate to a resource group, downtime, migrate existing instance, organization and space, standard plan, dedicated hardware instance, how to migrate

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

# {{site.data.keyword.cloudant_short_notm}} は {{site.data.keyword.cloud_notm}} リソース・グループをどのように処理しますか?
{: #how-does-ibm-cloudant-work-with-ibm-cloud-resource-groups-}

2018 年 7 月 16 日以降、新しい {{site.data.keyword.cloudantfull}} リソース・インスタンスは、Cloud Foundry スペースではなく、リソース・グループにプロビジョンされるようになりました。 この資料には、この移行に関して {{site.data.keyword.cloudant_short_notm}} サポートが受け取った一般的な質問が掲載されています。

## 既存のインスタンスをリソース・グループにマイグレーションするにはどのようにしますか?
{: #how-do-i-migrate-an-existing-instance-to-a-resource-group-}

{{site.data.keyword.cloudant_short_notm}} インスタンスを Cloud Foundry スペースからリソース・グループにマイグレーションする方法については、[リソース・グループへの Cloud Foundry サービス・インスタンスおよびアプリのマイグレーション](https://cloud.ibm.com/docs/resources/instance_migration.html#migrate){: new_window}を参照してください。

次のプランで {{site.data.keyword.cloudant_short_notm}} インスタンスをマイグレーションできます。

- ライト
- 標準
- 専用ハードウェア

## インスタンスをリソース・グループにマイグレーションするとき、どの程度のダウン時間が発生しますか?
{: #how-much-downtime-occurs-when-you-migrate-an-instance-to-a-resource-group-}

マイグレーション・プロセス中にダウン時間は発生しません。

## なぜ組織とスペースがあるインスタンスと組織とスペースがないインスタンスがあるのですか?
{: #why-do-some-instances-have-an-organisation-and-space-and-others-do-not-}

2018 年 7 月 16 日以降、新しいインスタンスは Cloud Foundry スペースではなく
リソース・グループにプロビジョンされるようになりました。 この日付の前にプロビジョンされた
リソース・インスタンスには、関連する Cloud Foundry 組織およびスペースがあります。 この日付の後に
プロビジョンされたインスタンスは、代わりにリソース・グループに関連付けられます。

## なぜ専用ハードウェア・インスタンスで新しい標準プラン・インスタンスを作成できないのですか?
{: #why-can-t-i-create-new-standard-plan-instances-on-my-dedicated-hardware-instances-}

新しい標準プラン・インスタンスはリソース・グループにプロビジョンされます。 これらのインスタンスを
専用ハードウェア・インスタンスにプロビジョンするには、最初に専用ハードウェア・インスタンスを
リソース・グループにマイグレーションする必要があります。

この方法について詳しくは、[リソース・グループへの Cloud Foundry サービス・インスタンスおよびアプリのマイグレーション](https://cloud.ibm.com/docs/resources/instance_migration.html#migrate){: new_window}を参照してください。

専用ハードウェア・インスタンスがリソース・グループにマイグレーションされた後、
このインスタンスは、標準プランのプロビジョン時に「ロケーション」ドロップダウン・メニューに表示されます。

## 専用ハードウェア・インスタンスとそれらのインスタンスでホストされている標準プラン・インスタンスはどのようにマイグレーションしますか?
{: #how-should-i-migrate-my-dedicated-hardware-instances-and-the-standard-plan-instances-hosted-on-them-}

理論的には、インスタンスは任意の順番でリソース・グループにマイグレーションできます。 実際には、次のように
専用ハードウェア・インスタンス、それらのインスタンスでホストされている標準プラン・インスタンスという順番で
マイグレーションすることをお勧めします。

1. 専用ハードウェア・インスタンスをリソース・グループにマイグレーションします。 これにより、専用ハードウェアで新しい標準プラン・インスタンスを作成できます。
2. 標準インスタンスをマイグレーションします。

専用ハードウェアでホストされていないライト・プラン・インスタンスおよび標準プラン・インスタンスは
いつでもマイグレーションできます。
{: tip}
