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

# Authorized curl: `acurl`

_(Dieser Leitfaden basiert auf einem Blogartikel von Samantha Scharr: [
"Authorized curl, a.k.a. acurl" ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://cloudant.com/blog/authorized-curl-a-k-a-acurl/){:new_window},
ursprünglich veröffentlicht am 27. November 2013.)_

`acurl` ist ein praktischer Alias, mit dem Sie {{site.data.keyword.cloudantfull}}-Befehle an URLs
übertragen (`curl`) können, ohne für jede Anforderung Ihren Benutzernamen und Ihr Kennwort eingeben zu müssen.
Das bedeutet, dass eine simple `GET`-Anforderung an eine Datenbank nicht länger als
`https://$ACCOUNT:$PASSWORD@$ACCOUNT.cloudant.com/foo` geschrieben werden muss,
sondern einfach `https://$ACCOUNT.cloudant.com/foo` verwendet werden kann.

Dies kürzt nicht nur nervtötend lange URLs, auch ist der Alias `acurl` sicherer.
Es wird verhindert, dass jemand während Ihrer Eingabe Ihr Kennwort mitliest, und vor allem ist dank HTTPS sichergestellt, dass Ihr Kennwort nicht in Klartext über das Netz gesendet wird.

Es müssen nur drei einfache Schritte ausgeführt werden:

1.	[Benutzernamen und Kennwort verschlüsseln](#encode-username-and-password).
2.	[Alias erstellen](#create-an-alias)
3.	[Alias aktivieren](#activate-the-alias).

Wenn Sie einen Windows-Computer verwenden, können Sie Ihren Benutzernamen und Ihr Kennwort in der Befehlszeile angeben.
{:tip}

## Benutzernamen und Kennwort verschlüsseln

Zunächst werden Ihr {{site.data.keyword.cloudant_short_notm}}-Benutzername und Ihr zugehöriges Kennwort mit der Base64-Codierung verschlüsselt.
Dies liefert uns eine Base64-Zeichenfolge als Ausgabe.

Der Befehl zum Verschlüsseln mancher Daten mit Base64-Codierung entspricht dem folgenden Beispiel:

```python
python -c 'import base64; print base64.urlsafe_b64encode("$ACCOUNT:$PASSWORD")'
```
{:codeblock}

Wir nehmen an, dass die Ausgabe `<OUTPUT-OF-BASE64>`.

Wenn Sie beispielsweise den folgenden Befehl verwenden:

```python
python -c 'import base64; print base64.urlsafe_b64encode("$ACCOUNT:$PASSWORD")'
```
{:codeblock}

Dann erhalten Sie die folgende Ausgabe:

```
bXl1c2VybmFtZTpteXBhc3N3b3Jk
```
{:codeblock}

>	**Hinweis**: Denken Sie daran, dass Ihr Kennwort noch immer in Klartext auf Ihrem Computer gespeichert ist;
	die Base64-Codierung ist _keine_ Verschlüsselung.
	Wenn Sie dieselbe Zeichenfolge mit Base64-Codierung verarbeiten,
	erhalten Sie immer dieselbe entsprechende Zeichenfolgeausgabe.

## Alias erstellen

Jetzt erstellen wir einen Alias für `curl`, der diese Berechtigungsnachweise enthält, damit wir sie nicht jedes Mal wieder eingeben müssen,
wenn wir einen `curl`-Befehl schreiben.

Fügen Sie die folgende Zeile zu `~/.bashrc` oder `~/.bash_profile` hinzu:

```sh
alias acurl="curl -s --proto '=https' -g -H 'Authorization: Basic <OUTPUT-OF-BASE64>'"
```
{:codeblock}

Dieser Alias fügt einen Berechtigungsheader hinzu, statt die Berechtigungsnachweise in die URL einzuschließen, die Sie in der Befehlszeile eingeben.
Er erzwingt auch die Verwendung von HTTPS, was wir gegenüber einfachem HTTP dringend empfehlen, da es Ihre in Übertragung
befindlichen Daten und Berechtigungsnachweise verschlüsselt und sicherstellt, dass Sie tatsächlich eine Verbindung mit
{{site.data.keyword.cloudant_short_notm}}-Systemen herstellen.

## Alias aktivieren

Starten Sie jetzt eine neue Shell oder führen Sie `source ~/.bash_profile` (bzw. `~/.bashrc`) aus, damit der Alias funktioniert.

## `acurl` testen

Nun müssen wir sicherstellen, dass alles korrekt eingerichtet wurde.
Führen Sie Folgendes aus:

```sh
acurl https://$ACCOUNT.cloudant.com/_all_dbs
```
{:codeblock}

Sie bekommen die Liste Ihrer Datenbanken zurück? Gutes Zeichen!
`acurl` wurde eingerichtet und kann verwendet werden.

Viel Spaß beim Codieren!
