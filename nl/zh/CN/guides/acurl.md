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

# 授权 curl：`acurl`

_（本指南基于 Samantha Scharr 的博客文章：[“授权 curl，又名 acurl”![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://cloudant.com/blog/authorized-curl-a-k-a-acurl/){:new_window}，最初发布于 2013 年 11 月 27 日。）_

`acurl` 是一种很有用的别名，允许您对 URL 执行 `curl` {{site.data.keyword.cloudantfull}} 命令，而不必为每个请求输入用户名和密码。这意味着对数据库执行的简单 `GET` 操作不再需要编写为 `https://$ACCOUNT:$PASSWORD@$ACCOUNT.cloudant.com/foo`，而可以改为只使用 `https://$ACCOUNT.cloudant.com/foo`。

这不仅使长得烦人的 URL 变短，而且 `acurl` 别名也更安全。它能防止有人在您输入密码时，在您背后偷看，而且很重要的一点是，它通过强制使用 HTTPS 来确保密码不会在网络上以明文形式发送。

实现所有这些目标只需要三个简单的步骤：

1.	[对用户名和密码编码](#encode-username-and-password)。
2.	[创建别名](#create-an-alias)。
3.	[激活别名](#activate-the-alias)。

如果使用的是 Windows 计算机，那么可以通过命令行指定您的用户名和密码。
{:tip}

## 对用户名和密码编码

首先，我们会对 {{site.data.keyword.cloudant_short_notm}} 用户名和密码进行基本 64 位编码。这将提供一个基本 64 位编码的字符序列作为输出。

用于对某些数据进行基本 64 位编码的命令类似于以下示例：

```python
python -c 'import base64; print base64.urlsafe_b64encode("$ACCOUNT:$PASSWORD")'
```
{:codeblock}

我们假定输出名为 `<OUTPUT-OF-BASE64>`.

例如，如果使用以下命令：

```python
python -c 'import base64; print base64.urlsafe_b64encode("$ACCOUNT:$PASSWORD")'
```
{:codeblock}

那么，会获得以下输出：

```
bXl1c2VybmFtZTpteXBhc3N3b3Jk
```
{:codeblock}

>	**注**：请记住，您的密码仍以明文形式存储在计算机上；基本 64 位编码并_不是_加密。如果对同一字符序列使用基本 64 位编码，那么始终会获得相同的对应字符输出序列。

## 创建别名

现在，为包含这些凭证的 `curl` 创建别名，这样就不必在每次编写 `curl` 命令时都输入这些凭证。

将以下行添加到 `~/.bashrc` 或 `~/.bash_profile`：

```sh
alias acurl="curl -s --proto '=https' -g -H 'Authorization: Basic <OUTPUT-OF-BASE64>'"
```
{:codeblock}

此别名会添加 Authorization 头，而不是在命令行上所输入的 URL 中包含授权凭证。它还会强制使用 HTTPS（我们强烈建议使用 HTTPS，而不要使用明文 HTTP），因为 HTTPS 会对传输中的数据和凭证进行加密，并帮助您确保连接到的是 {{site.data.keyword.cloudant_short_notm}} 系统。

## 激活别名

现在，启动新的 shell 或运行 `source ~/.bash_profile`（或 `~/.bashrc`，如果使用的是这个），以使别名正常运行。

## 测试 `acurl`

现在，让我们确保所有内容都已正确设置。请继续运行：

```sh
acurl https://$ACCOUNT.cloudant.com/_all_dbs
```
{:codeblock}

如果返回了数据库列表，太棒了！这说明 `acurl` 已设置好并随时可用。

祝您编码愉快！
