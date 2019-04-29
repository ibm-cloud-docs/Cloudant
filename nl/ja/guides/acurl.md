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

# 許可済み curl: `acurl`
{: #authorized-curl-acurl-}

_(このガイドは、Samantha Scharr によるブログ記事『Authorized curl, a.k.a. acurl』(2013 年 11 月 27 日に初公開) に基づいています。)_

`acurl` は、要求ごとにユーザー名とパスワードを入力することなく、{{site.data.keyword.cloudantfull}} コマンドを URL に `curl` できるようにする便利な別名です。
つまり、データベースに対するシンプルな `GET` を `https://$ACCOUNT:$PASSWORD@$ACCOUNT.cloudant.com/foo` と記述する必要がなくなり、単に `https://$ACCOUNT.cloudant.com/foo` を使用できます。

これにより、面倒な長い URL が短くなるだけでなく、`acurl` の別名ではセキュリティーも向上します。
入力しているパスワードを後ろから盗み見されることがなくなり、何より、HTTPS を適用することで、ネットワークを介してパスワードが平文で送信されなくなります。

必要なのは、以下のシンプルな 3 つのステップのみです。

1.	[ユーザー名とパスワードをエンコードする](#encode-user-name-and-password)
2.	[別名を作成する](#create-an-alias)
3.	[別名をアクティブ化する](#activate-the-alias)

Windows コンピューターを使用している場合、コマンド・ラインからユーザー名とパスワードを指定できます。
{: tip}

## ユーザー名とパスワードをエンコードする
{: #encode-user-name-and-password}

まず、{{site.data.keyword.cloudant_short_notm}} ユーザー名とパスワードを base64 でエンコードします。
これにより、base64 文字シーケンスが出力として得られます。

データを base64 でエンコードするコマンドは、以下の例のようになります。

```python
python -c 'import base64; print base64.urlsafe_b64encode("$ACCOUNT:$PASSWORD")'
```
{: codeblock}

ここでは、出力を `<OUTPUT-OF-BASE64>` と呼びます。

例えば、以下のコマンドを使用した場合を考えます。

```python
python -c 'import base64; print base64.urlsafe_b64encode("$ACCOUNT:$PASSWORD")'
```
{: codeblock}

この場合、以下の出力が得られます。

```
bXl1c2VybmFtZTpteXBhc3N3b3Jk
```
{: codeblock}

パスワードはこの場合でもコンピューター上に平文で保管されるので注意してください。base64 エンコードは、暗号化_ではありません_。 同じ文字シーケンスに対して base64 エンコードを使用すると、常に対応する同じ出力文字シーケンスが得られます。
{: note}

## 別名を作成する
{: #create-an-alias}

次に、`curl` コマンドを記述するたびに該当する資格情報を入力しなくても済むように、資格情報が含まれた `curl` の別名を作成します。

以下の行を `~/.bashrc` または `~/.bash_profile` に追加します。

```sh
alias acurl="curl -s --proto '=https' -g -H 'Authorization: Basic <OUTPUT-OF-BASE64>'"
```
{: codeblock}

この別名では、コマンド・ラインで入力する URL に許可資格情報を含めるのではなく、Authorization ヘッダーを追加します。
また、HTTPS の使用が強制されます。HTTPS では、転送中のデータおよび資格情報が暗号化され、また確実に {{site.data.keyword.cloudant_short_notm}} システムに接続できるため、平文の HTTP よりも強く推奨されます。

## 別名をアクティブ化する
{: #activate-the-alias}

次に、新しいシェルを開始するか、`source ~/.bash_profile` (または `~/.bashrc` (これを使用した場合)) を実行して、別名を使用できるようにします。

## `acurl` をテストする
{: #testing-acurl-}

では、すべてが正しくセットアップしたかを確認します。
以下を実行します。

```sh
acurl https://$ACCOUNT.cloudant.com/_all_dbs
```
{: codeblock}

データベースのリストが返された場合、成功です。
`acurl` がセットアップされ、使用する準備ができました。

これで完了です。
