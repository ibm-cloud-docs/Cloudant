---

copyright:
  years: 2015, 2018
lastupdated: "2018-10-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:tip: .tip}

<!-- Acrolinx: 2017-05-10 -->

# 監査ロギング


監査ロギングは、
{{site.data.keyword.cloudant_short_notm}} に保管されたデータにアクセスした {{site.data.keyword.cloudantfull}} プリンシパルを記録します。 {{site.data.keyword.cloudant_short_notm}} への
すべての HTTP API アクセスについて、
監査ロギング機能は、各 HTTP 要求に関する以下の情報を記録します。

情報 | 説明
------------|------------
`プリンシパル` | アカウント資格情報、 API キー、または IBM Cloud IAM 資格情報。
`アクション` | 実行されたアクション (例えば、文書の読み取り)。
`リソース` | アクセスまたは照会を行ったアカウント、データベース、および文書に関する詳細。
`タイム・スタンプ` | イベントの時刻とデータのレコード。 

{{site.data.keyword.cloudant_short_notm}} 監査ログを使用して、以下を理解することができます。

- アカウント内でどのデータベースおよび文書がいつ誰によってアクセスされたか。
- どの照会がいつ誰によって実行されたか。
- どの特定のプリンシパルまたはユーザーがいつアクセス、更新、または削除したか。
- どの複製文書がいつ作成または削除されたか。
{:shortdesc}

## アカウントの監査ログへのアクセス方法

アカウントの監査ログへのアクセスを要求するには、
{{site.data.keyword.cloudant_short_notm}} サポートにお問い合わせください。 サポートは、ユーザーにとって重要な監査ログのコピーを提供します。

サポートに連絡する場合は、必ず以下を含めてください。

- 要求が関連する {{site.data.keyword.cloudant_short_notm}} アカウント。
- 監査ログの時間フレーム (サポート要求ごとに 1 カ月以内でなければなりません)。
- 対象の特定のデータベース、文書、またはプリンシパル。
