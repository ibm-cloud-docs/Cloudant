---

copyright:
  years: 2015, 2017
lastupdated: "2017-01-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# JSON

Cloudant への要求および Cloudant からの応答の多くは、データおよび応答の内容と構造をフォーマット設定するために [JavaScript Object Notation (JSON) ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://en.wikipedia.org/wiki/JSON){:new_window} を使用しています。
{:shortdesc}

Cloudant データベースでは、データベース内のすべての文書を含め、さまざまな構造を表すために JSON オブジェクトが使用されます。

JSON を構文解析して JavaScript オブジェクトを作成することは、JavaScript の `JSON.parse()` 関数を介して、またはユーザーのために内容を構文解析して JavaScript オブジェクトへの変換を実行するさまざまな [ライブラリー](../libraries/index.html)を介してサポートされます。
JSON を構文解析および生成するための[ライブラリー](../libraries/index.html)は、多くの主要プログラミング言語で使用可能です。

JSON が使用される理由は、JSON が、Web ブラウザーを使用してデータを処理するための最もシンプルで容易なソリューションだからです。なぜなら、JSON 構造は、Web ブラウザー環境内で JavaScript オブジェクトとして評価および使用できるからです。また、JSON は、Cloudant 内で使用されるサーバー・サイド JavaScript とも統合されます。JSON 文書は、常に UTF-8 エンコードです。

>   **注**: 以下のことを確実にする必要があります。

-   JSON 構造が有効である。構造が無効な場合、Cloudant は HTTP 状況コード [400 (間違った要求)](../api/http.html#400) を返します。
-   Cloudant から取得した JSON 文書内のストリングを比較する前に正規化する。この理由は、Unicode の正規化が適用されている可能性があるため、保管されて取得されたストリングが、バイナリー・レベルで同一でない可能性があるためです。

JSON は、以下に示す、JavaScript でサポートされている基本タイプと同じ基本タイプをサポートします。

-   [数値](#numbers)
-   [ストリング](#strings)
-   [ブール値](#booleans)
-   [配列](#arrays)
-   [オブジェクト](#objects)

## 数値

数値は、整数値または浮動小数点値にすることができます。

_JSON フォーマットでの数値の例:_

```json
123
```
{:codeblock}

## ストリング

ストリングは、二重引用符で囲みます。ストリングは、Unicode 文字と円記号 (&#xa5;) のエスケープをサポートします。

_JSON フォーマットでのストリングの例:_

```json
"A String"
```
{:codeblock}

## ブール値

`true` または `false` の値。

_JSON フォーマットでのブール値の例:_

```json
{
  "value": true
}
```
{:codeblock}

## 配列

大括弧で囲まれた値のリスト。囲む値は、任意の有効な JSON にすることができます。

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
{:codeblock}

_JSON フォーマットでの配列の例 (線形):_

```json
[ "one", 2, "three", [], true, { "foo": "bar" } ]
```
{:codeblock}

## オブジェクト

キー/値ペアのセット。例えば、連想配列やハッシュなど。このキーはストリングでなければなりませんが、値には、サポートされる任意の JSON 値を使用できます。

_JSON オブジェクトの例:_

```json
{
    "servings" : 4,
    "subtitle" : "Easy to make in advance, and then cook when ready",
    "cooktime" : 60,
    "title" : "Chicken Coriander"
}
```
{:codeblock}
