---

copyright:
  years: 2015, 2019
lastupdated: "2019-03-06"

keywords: encode user name, encode password, create alias, activate alias, test acurl

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

# 授權的 curl：`acurl`
{: #authorized-curl-acurl-}

_（本手冊是以 Samantha Scharr 所撰寫的部落格文章為基礎：[
"Authorized curl, a.k.a. acurl"，最初發佈於 2013 年 11月 27 日。） 

`acurl` 是便利的別名，容許您 `curl` {{site.data.keyword.cloudantfull}} 指令至 URL，而不需要針對每個要求輸入您的使用者名稱和密碼。
這表示資料庫的簡單 `GET` 不再需要寫入為 `https://$ACCOUNT:$PASSWORD@$ACCOUNT.cloudant.com/foo`，相反地您可以只使用 `https://$ACCOUNT.cloudant.com/foo`。

此舉不僅減少煩人的長 URL，`acurl` 別名還更加安全。它會防止有人在您鍵入時從您背後窺探您的密碼，而且重要的是，藉由強制執行 HTTPS，它可確保您的密碼不會以純文字形式在網路中傳送。

只需三個簡單的步驟即可達到此目的：

1.	[對使用者名稱和密碼進行編碼](#encode-user-name-and-password)。
2.	[建立別名](#create-an-alias)。
3.	[啟動別名](#activate-the-alias)。

如果您使用的是 Windows 電腦，則可以從指令行指定您的使用者名稱和密碼。
{: tip}

## 對使用者名稱和密碼進行編碼
{: #encode-user-name-and-password}

首先，使用 base64 對您的 {{site.data.keyword.cloudant_short_notm}} 使用者名稱和密碼進行編碼。
這提供我們 base64 字元順序作為輸出。

使用 base64 編碼部分資料的指令與下列範例類似：

```python
python -c 'import base64; print base64.urlsafe_b64encode("$ACCOUNT:$PASSWORD")'
```
{: codeblock}

假設輸出稱為 `<OUTPUT-OF-BASE64>`。

例如，如果使用指令：

```python
python -c 'import base64; print base64.urlsafe_b64encode("$ACCOUNT:$PASSWORD")'
```
{: codeblock}

則會獲得下列輸出：

```
bXl1c2VybmFtZTpteXBhc3N3b3Jk
```
{: codeblock}

記住，您的密碼仍以純文字形式儲存在電腦上；base64 編碼_並非_ 加密。如果在相同的字元順序上使用 base64 編碼，您一律會獲得相同的對應字元輸出順序。
{: note}

## 建立別名
{: #create-an-alias}

現在，會為包括這些認證的 `curl` 建立別名，因此不必在每次撰寫 `curl` 指令時輸入它們。

將下列這一行新增至您的 `~/.bashrc` 或 `~/.bash_profile`：

```sh
alias acurl="curl -s --proto '=https' -g -H 'Authorization: Basic <OUTPUT-OF-BASE64>'"
```
{: codeblock}

此別名會新增 Authorization 標頭，而不是在您於指令行上輸入的 URL 中包括授權認證。它也會強制使用強烈建議的 HTTPS 來代替純 HTTP，因為它會在傳輸時加密您的資料及認證，並協助您確定正在連接至 {{site.data.keyword.cloudant_short_notm}} 系統。

## 啟動別名
{: #activate-the-alias}

現在，啟動新的 shell 或執行 `source ~/.bash_profile`（或 `~/.bashrc`，如果已使用的話），讓別名運作。

## 測試 `acurl`
{: #testing-acurl-}

現在，讓我們確定一切都已設定正確。繼續並執行：

```sh
acurl https://$ACCOUNT.cloudant.com/_all_dbs
```
{: codeblock}

如果您獲得資料庫的清單，棒極了！`acurl` 已設定好，可以開始執行。

祝您撰寫程式碼愉快！
