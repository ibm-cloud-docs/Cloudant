---

copyright:
  years: 2015, 2018
lastupdated: "2017-01-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# JSON

大多数向 {{site.data.keyword.cloudantfull}} 发出的请求和从其收到的响应都使用 [JavaScript 对象表示法 (JSON) ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://en.wikipedia.org/wiki/JSON){:new_window} 来格式化数据和响应的内容和结构。
{:shortdesc}

在 {{site.data.keyword.cloudant_short_notm}} 数据库中，JSON 对象用于表示各种结构，包括数据库中的所有文档。

通过 JavaScript 中的 `JSON.parse()` 函数或通过各种用于将内容解析为 JavaScript 对象的[库](../libraries/index.html)，支持将 JSON 解析为 JavaScript 对象。用于解析和生成 JSON 的[库](../libraries/index.html)可用于许多主要编程语言。

使用 JSON 是因为它是通过 Web 浏览器处理数据的最简单、最容易的解决方案。原因在于，在 Web 浏览器环境中，JSON 结构可以作为 JavaScript 对象进行求值和使用。JSON 还与 {{site.data.keyword.cloudant_short_notm}} 中使用的服务器端 JavaScript 集成。JSON 文档始终采用 UTF-8 编码。

>   **注**：应谨慎操作，以确保：

-   JSON 结构有效。无效的结构会导致 {{site.data.keyword.cloudant_short_notm}} 返回 HTTP 状态码 [400（错误请求）](../api/http.html#400)。
-   在 {{site.data.keyword.cloudant_short_notm}} 中检索到 JSON 文档后，先对其中的字符串进行规范化，然后再对这些文档进行比较。这是因为文档可能已应用 Unicode 规范化，所以存储并随后检索到的字符串在二进制级别不是完全相同的。

JSON 支持的基本类型与 JavaScript 支持的相同：

-   [数字](#numbers)
-   [字符串](#strings)
-   [布尔值](#booleans)
-   [数组](#arrays)
-   [对象](#objects)

## 数字

数字可以是整数或浮点值。

_JSON 格式的数字示例：_

```json
123
```
{:codeblock}

## 字符串

字符串应该用双引号括起。字符串支持 Unicode 字符和反斜杠转义。

_JSON 格式的字符串示例：_

```json
"A String"
```
{:codeblock}

## 布尔值

`true` 或 `false` 值。

_JSON 格式的布尔值示例：_

```json
{
  "value": true
}
```
{:codeblock}

## 数组

用方括号括起的值的列表。括起的值可以是任何有效的 JSON。

_JSON 格式的数组示例：_

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

_JSON 格式的数组示例（线性）：_

```json
[ "one", 2, "three", [], true, { "foo": "bar" } ]
```
{:codeblock}

## 对象

一组键/值对，例如关联数组或散列。键必须是字符串，但值可以是任何支持的 JSON 值。

_JSON 对象的示例：_

```json
{
    "servings" : 4,
    "subtitle" : "Easy to make in advance, and then cook when ready",
    "cooktime" : 60,
    "title" : "Chicken Coriander"
}
```
{:codeblock}
