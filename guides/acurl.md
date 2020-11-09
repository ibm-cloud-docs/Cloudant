---

copyright:
  years: 2015, 2020
lastupdated: "2020-11-09"

keywords: encode username, encode password, create alias, activate alias, test acurl

subcollection: Cloudant

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
{:external: target="_blank" .external}

<!-- Acrolinx: 2020-03-17 -->

# Authorized curl - `acurl`
{: #authorized-curl-acurl-}

*(The following guide is based on a blog article by Samantha Scharr: [
"Authorized curl, also known as `acurl`," originally published 27 November 2013.)*

`acurl` is a handy alias that you can use to run `curl` {{site.data.keyword.cloudantfull}} commands to URLs
without having to enter your username and password for every request.
That means a simple `GET` request to a database no longer needs to be written as
`https://$ACCOUNT:$PASSWORD@$ACCOUNT.cloudant.com/foo`. Instead, you can use, `https://$ACCOUNT.cloudant.com/foo`.
{: shortdesc}

Not only does this cut down on annoyingly long URLs,
but the `acurl` alias is also more secure.
It prevents someone from reading your password over your shoulder as you type.
It also makes sure that your password isn’t sent in plain text over the network by enforcing HTTPS.

It takes the following three steps:

1.	[Encode username and password](#encode-user-name-and-password).
2.	[Create an alias](#create-an-alias).
3.	[Activate the alias](#activate-the-alias).

If you're using a Windows&trade; computer, you can specify your username and password from the command line.
{: tip}

## Encode username and password
{: #encode-user-name-and-password}

First, we base64-encode your {{site.data.keyword.cloudant_short_notm}} username and password.
This encoding gives us a base64 character sequence as output.

`$ACCOUNT` is the `username` field in your service credentials. For more information, see [Locating your service credentials](/docs/Cloudant?topic=Cloudant-locating-your-service-credentials).
{: note}

The command to base64-encode some data is similar to the following example:

```python
python3 -c 'import base64; print(base64.urlsafe_b64encode("$ACCOUNT:$PASSWORD".encode("utf-8")).decode("utf-8"))'
```
{: codeblock}

We assume that the output is called `<OUTPUT-OF-BASE64>`.

For example,
if you use the command:

```python
python3 -c 'import base64; print(base64.urlsafe_b64encode("$ACCOUNT:$PASSWORD".encode("utf-8")).decode("utf-8"))'
```
{: codeblock}

You then get the following output:

```
NTFkZGM5YTAtZmE2MC00M2Q1LTgyNmJeKGNmYjBhNTVkMzFiLWJsdWVtaXguY2xvdWRhbnQuY29tOjY4ODIyZGQ5YTU5YzNhZjA1NDY5YzRhMGRjODUzZjVhYjQzMmQxMDI0NTFiNTQ0ZTUxZjA5MjkwODU2NDcxNWM=
```
{: codeblock}

Remember your password is still stored in plain text on your computer. Base64-encoding isn't encryption. If you use base64-encode on the same character sequence, you always get the same corresponding character output sequence.
{: note}

## Create an alias
{: #create-an-alias}

Now, we create an alias for `curl` that includes these credentials, so we don’t have to enter them every time we write a `curl` command.

Add the following line to your `~/.bashrc` or `~/.bash_profile`:

```sh
alias acurl="curl -s --proto '=https' -g -H 'Authorization: Basic <OUTPUT-OF-BASE64>'"
```
{: codeblock}

This alias adds an authorization header instead of including the
authorization credentials in the URL you enter on the command line.
It also forces the use of HTTPS, which we strongly recommend over plain HTTP. HTTPS encrypts your data and credentials in transit and helps you be sure you’re connecting to {{site.data.keyword.cloudant_short_notm}} systems.

## Activate the alias
{: #activate-the-alias}

Now, start a new shell, or run `source ~/.bash_profile` (or `~/.bashrc` if you used that), to make the alias functional.

## Testing `acurl`
{: #testing-acurl-}

Now, let's make sure everything is set up correctly.
Go ahead and run:

```sh
acurl "https://$ACCOUNT.cloudant.com/_all_dbs"
```
{: codeblock}

If you get the list of your databases back,
awesome!
`acurl` is set up and ready to go.

Happy coding!