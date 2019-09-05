---

copyright:
  years: 2015, 2019
lastupdated: "2019-08-26"

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
{:external: target="_blank" .external}

<!-- Acrolinx: 2017-05-10 -->

# Authorized curl: `acurl`
{: #authorized-curl-acurl-}

*(This guide is based on a blog article by Samantha Scharr: [
<q>Authorized curl, a.k.a. acurl</q>, originally published November 27, 2013.)*

`acurl` is a handy alias that allows you to `curl` {{site.data.keyword.cloudantfull}} commands to URLs
without having to enter your user name and password for every request.
That means a simple `GET` request to a database no longer needs to be written as
`https://$ACCOUNT:$PASSWORD@$ACCOUNT.cloudant.com/foo`. Instead, you can use, `https://$ACCOUNT.cloudant.com/foo`.

Not only does this cut down on annoyingly long URLs,
but the `acurl` alias is also more secure.
It prevents someone from reading your password over your shoulder as you type,
and it also makes sure your password isn’t sent in plain text over the network by enforcing HTTPS.

All it takes is three steps:

1.	[Encode user name and password](#encode-user-name-and-password).
2.	[Create an alias](#create-an-alias).
3.	[Activate the alias](#activate-the-alias).

If you are using a Windows computer, you can specify your user name and password from the command line.
{: tip}

## Encode user name and password
{: #encode-user-name-and-password}

First we base64-encode your {{site.data.keyword.cloudant_short_notm}} user name and password.
This gives us a base64 character sequence as output.

`$ACCOUNT` is the `username` field in your service credentials. For more information, see [Locating your service credentials](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#locating-your-service-credentials).
{: note}

The command to base64-encode some data is similar to the following example:

```python
python -c 'import base64; print base64.urlsafe_b64encode("$ACCOUNT:$PASSWORD")'
```
{: codeblock}

We assume that the output is called `<OUTPUT-OF-BASE64>`.

For example,
if you use the command:

```python
python -c 'import base64; print base64.urlsafe_b64encode("$ACCOUNT:$PASSWORD")'
```
{: codeblock}

You then get the following output:

```
bXl1c2VybmFtZTpteXBhc3N3b3Jk
```
{: codeblock}

Remember that your password is still stored in plain text on your computer; base64-encoding is *not* encryption. If you use base64-encode on the same character sequence, you always get the same corresponding character output sequence.
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
It also forces the use of HTTPS, which we strongly recommend over plain HTTP, as it encrypts your data and credentials in transit and helps you be sure you’re connecting to {{site.data.keyword.cloudant_short_notm}} systems.

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