---

copyright:
  years: 2015, 2019
lastupdated: "2019-03-18"

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

在與 {{site.data.keyword.cloudantfull}} 之間來回的大部分要求及回應，都會使用 [JavaScript 物件表示法 (JSON) ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://en.wikipedia.org/wiki/JSON){: new_window}，來格式化資料及回應的內容和結構。
{: shortdesc}

在 {{site.data.keyword.cloudant_short_notm}} 資料庫中，會使用 JSON 物件來代表各種結構（包括資料庫中的所有文件）。

透過 JavaScript 中的 `JSON.parse()` 函數，或透過執行將內容剖析為 JavaScript 物件的各種[程式庫](/docs/services/Cloudant?topic=cloudant-client-libraries#client-libraries)，支援將 JSON 剖析成 JavaScript 物件。許多主要程式設計語言都可以使用用來剖析及產生 JSON 的程式庫。

使用 JSON 的原因是它是使用 Web 瀏覽器處理資料的最簡單且最輕鬆的解決方案。原因是 JSON 結構可以評估及用作 Web 瀏覽器環境內的 JavaScript 物件。JSON 也會整合 {{site.data.keyword.cloudant_short_notm}} 內使用的伺服器端 JavaScript。
JSON 文件一律是 UTF-8 編碼。

請小心確定：
-   您的 JSON 結構有效。
-   您正規化擷取自 {{site.data.keyword.cloudant_short_notm}} 的 JSON 文件中的字串。

JSON 支援與 JavaScript 所支援相同的基本類型：

-   [數字](#numbers)
-   [字串](#strings)
-   [布林](#booleans)
-   [陣列](#arrays)
-   [物件](#objects)

## 數字
{: #numbers}

數字可以是整數或浮點數值。

_JSON 格式的數字範例：_

```json
123
```
{: codeblock}

## 字串
{: #strings}

字串應該用雙引號括住。字串支援 Unicode 字元及反斜線跳出。

_JSON 格式的字串範例：_

```json
"A String"
```
{: codeblock}

## 布林
{: #booleans}

`true` 或 `false` 值。

_JSON 格式的布林範例：_

```json
{
  "value": true
}
```
{: codeblock}

## 陣列
{: #arrays}

以方括弧括住的值清單。括住的值可以是任何有效的 JSON。

_JSON 格式的陣列範例：_

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

_JSON 格式（線性）的陣列範例：_

```json
[ "one", 2, "three", [], true, { "foo": "bar" } ]
```
{: codeblock}

## 物件
{: #objects}

一組鍵值組（例如關聯式陣列）或雜湊。索引鍵必須是字串，但值可以是任何支援的 JSON 值。

_JSON 物件的範例：_

```json
{
    "servings" : 4,
    "subtitle" : "Easy to make in advance, and then cook when ready",
    "cooktime" : 60,
    "title" : "Chicken Coriander"
}
```
{: codeblock}
