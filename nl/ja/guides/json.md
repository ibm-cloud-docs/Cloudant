---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: numbers, strings, booleans, arrays, objects

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

# JSON
{: #json}

{{site.data.keyword.cloudantfull}} への要求および
{{site.data.keyword.cloudantfull}} からの応答の多くは、データおよび応答の内容と構造をフォーマット設定するために [JavaScript Object Notation (JSON) ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://en.wikipedia.org/wiki/JSON){: new_window}
を使用しています。
{: shortdesc}

{{site.data.keyword.cloudant_short_notm}} データベースでは、データベース内のすべての文書を含め、さまざまな構造を表すために JSON オブジェクトが使用されます。

JSON を構文解析して JavaScript オブジェクトを作成することは、JavaScript の `JSON.parse()` 関数を介して、またはユーザーのために内容を構文解析して JavaScript オブジェクトへの変換を実行するさまざまな [ライブラリー](/docs/services/Cloudant?topic=cloudant-client-libraries#client-libraries)を介してサポートされます。 JSON を構文解析および生成するためのライブラリーは、多くの主要プログラミング言語で使用可能です。

JSON が使用される理由は、JSON が、Web ブラウザーを使用してデータを処理するための最もシンプルで容易なソリューションだからです。
なぜなら、JSON 構造は、Web ブラウザー環境内で JavaScript オブジェクトとして評価および使用できるからです。
また、JSON は、{{site.data.keyword.cloudant_short_notm}} 内で使用されるサーバー・サイド JavaScript とも統合されます。
JSON 文書は、常に UTF-8 エンコードです。

以下のことを確認するよう注意してください。
-   JSON 構造が有効である。
-   {{site.data.keyword.cloudant_short_notm}} から取得した JSON 文書内のストリングを正規化する。

JSON は、以下に示す、JavaScript でサポートされている基本タイプと同じ基本タイプをサポートします。

-   [数値](#numbers)
-   [ストリング](#strings)
-   [ブール値](#booleans)
-   [配列](#arrays)
-   [オブジェクト](#objects)

## 数値
{: #numbers}

数値は、整数値または浮動小数点値にすることができます。

_JSON フォーマットでの数値の例:_

```json
123
```
{: codeblock}

## ストリング
{: #strings}

ストリングは、二重引用符で囲みます。 ストリングは、Unicode 文字と円記号 (&#xa5;) のエスケープをサポートします。

_JSON フォーマットでのストリングの例:_

```json
"A String"
```
{: codeblock}

## ブール値
{: #booleans}

`true` または `false` の値。

_JSON フォーマットでのブール値の例:_

```json
{
  "value": true
}
```
{: codeblock}

## 配列
{: #arrays}

大括弧で囲まれた値のリスト。 囲む値は、任意の有効な JSON にすることができます。

_JSON フォーマットでの配列の例:_

```json
[
    "one",
    2,
    "three",
    [],
    true,
    {
        "foo":
        "bar"
    }
]
```
{: codeblock}

_JSON フォーマットでの配列の例 (線形):_

```json
[ "one", 2, "three", [], true, { "foo": "bar" } ]
```
{: codeblock}

## オブジェクト
{: #objects}

キー/値ペアのセット。例えば、連想配列やハッシュなど。
このキーはストリングでなければなりませんが、値には、サポートされる任意の JSON 値を使用できます。

_JSON オブジェクトの例:_

```json
{
    "servings" : 4,
    "subtitle" : "Easy to make in advance, and then cook when ready",
    "cooktime" : 60,
    "title" : "Chicken Coriander"
}
```
{: codeblock}
