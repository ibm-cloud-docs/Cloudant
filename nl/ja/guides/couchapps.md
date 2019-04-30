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

# CouchApp
{: #couchapps}

{{site.data.keyword.cloudantfull}} は、イメージのような RAW ファイル・データをホストし、それらを HTTP で提供することができます。つまり、{{site.data.keyword.cloudantfull}} は、Web サイトを実行するために必要なすべての静的ファイルをホストし、それらを Web サーバーのようにホストすることができます。
{: shortdesc}

これらのファイルは {{site.data.keyword.cloudant_short_notm}} 上でホストされるため、クライアント・サイドの JavaScript は {{site.data.keyword.cloudant_short_notm}} データベースにアクセスすることができます。
このようにして構築されたアプリケーションは、クライアント (通常、ブラウザー) とデータベースから成る 2 層アーキテクチャーを持っていると言われます。
CouchDB コミュニティーでは、これは CouchApp と呼ばれます。

多くの Web アプリは、クライアント、サーバー、およびデータベースの 3 層を持っています。
クライアントとデータベースの間にサーバーを配置すると、認証、許可、資産管理、サード・パーティー Web API の活用、特に洗練されたエンドポイントの提供などに役立ちます。この分離により、懸念を融合することなく複雑さを追加することが可能になるため、クライアントは全体を通じてデータの表示のみに専念し、データベースはデータの保管と提供のみに集中することができます。

CouchApp は単純さにおいて秀でていますが、Web アプリには 3 層アーキテクチャーの能力が必要になることがよくあります。
CouchApp と 3 層アプリケーションは、それぞれどのような場合に適切なのでしょうか。

## CouchApp が適切な場合
{: #a-couchapp-is-appropriate-if-}

-   いずれにせよサーバーが {{site.data.keyword.cloudant_short_notm}} の API しか提供していない。
-   {{site.data.keyword.cloudant_short_notm}} の [Cookie を基にした認証](/docs/services/Cloudant?topic=cloudant-authentication#cookie-authentication)を使用することに問題はない。
-   {{site.data.keyword.cloudant_short_notm}} の [`_users` データベースおよび `_security`](/docs/services/Cloudant?topic=cloudant-authorization#using-the-_users-database-with-cloudant-nosql-db) データベースを使用してユーザーとアクセス権を管理することは OK である。
-   cronjob またはその他の通常タスクをスケジュールに入れる必要がない。

CouchApp を開始するには、
[Managing applications on {{site.data.keyword.cloudant_short_notm}} ({{site.data.keyword.cloudant_short_notm}} でのアプリケーションの管理) ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://cloudant.com/blog/app-management/){: new_window} をお読みください。

## 3 層アプリケーションが適切な場合
{: #a-3-tier-application-is-appropriate-if-}

-   `_security` データベースで可能なアクセス権よりも、さらに細分化されたアクセス権が必要である。
-   Oauth やサード・パーティー・ログイン・システムなど、基本認証または Cookie 認証以外の認証方式が必要である。
-   クライアントの外でタスクのスケジュールを設定して定期的に実行する必要がある。

ユーザーは、自分にとって最適なテクノロジーを使用してサーバー層を作成することができます。
{{site.data.keyword.cloudant_short_notm}} で作業するためのライブラリーのリストは、『[{{site.data.keyword.cloudant_short_notm}} の基本](/docs/services/Cloudant?topic=cloudant-client-libraries#client-libraries)』ページにあります。
