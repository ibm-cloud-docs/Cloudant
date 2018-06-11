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

# Curl autorizzato: `acurl`

_(Questa guida si basa su un articolo del blog di Samantha Scharr: [
"Curl autorizzato, anche noto come acurl" ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://cloudant.com/blog/authorized-curl-a-k-a-acurl/){:new_window},
originariamente pubblicato il 27 novembre 2013.)_

`acurl` è un pratico alias che ti consente di eseguire il `curl` dei comandi {{site.data.keyword.cloudantfull}} negli URL
senza dover immettere il tuo nome utente e la password per ogni richiesta.
Ciò significa che un semplice `GET` in un database non deve più essere scritto come
`https://$ACCOUNT:$PASSWORD@$ACCOUNT.cloudant.com/foo`
ma puoi utilizzare solo `https://$ACCOUNT.cloudant.com/foo`.

Non solo questo riduce gli URL fastidiosamente lunghi,
ma l'alias `acurl` è anche più sicuro.
Impedisce ad altri di leggere la tua password mentre la digiti
e soprattutto
assicura che la tua password non venga inviata in testo normale sulla rete applicando HTTPS.

Servono solo tre semplici passi:

1.	[Codifica nome utente e password](#encode-username-and-password).
2.	[Crea un alias](#create-an-alias)
3.	[Attiva l'alias](#activate-the-alias).

## Codifica nome utente e password

In primo luogo, codifichiamo in base64 il tuo nome utente e password {{site.data.keyword.cloudant_short_notm}}.
Questo ci dà una sequenza di caratteri in base64 come output.

Il comando per codificare in base64 alcuni dati è simile al seguente esempio:

```python
python -c 'import base64; print base64.urlsafe_b64encode("$ACCOUNT:$PASSWORD")'
```
{:codeblock}

Supponiamo che l'output si chiami `<OUTPUT-OF-BASE64>`.

Ad esempio,
se utilizzi il comando:

```python
python -c 'import base64; print base64.urlsafe_b64encode("$ACCOUNT:$PASSWORD")'
```
{:codeblock}

Otterrai il seguente output:

```
bXl1c2VybmFtZTpteXBhc3N3b3Jk
```
{:codeblock}

>	**Nota**: ricorda che la tua password è ancora memorizzata in testo normale sul tuo computer;
	la codifica in base64 _non_ è uguale alla crittografia.
	Se utilizzi la codifica in base64 sulla stessa sequenza di caratteri,
	otterrai sempre la stessa sequenza output di caratteri corrispondente.

## Crea un alias

Adesso, creiamo un alias per `curl` che include queste credenziali in modo da non doverle immettere
ogni volta che scriviamo un comando `curl`.

Aggiungi la seguente riga al tuo `~/.bashrc` o `~/.bash_profile`:

```sh
alias acurl="curl -s --proto '=https' -g -H 'Authorization: Basic <OUTPUT-OF-BASE64>'"
```
{:codeblock}

Questo alias aggiunge un'intestazione di autorizzazione invece di includere le
credenziali di autorizzazione nell'URL che immetti nella riga di comando.
Inoltre, forza l'utilizzo di HTTPS che noi consigliamo vivamente rispetto all'HTTP semplice
in quanto effettua la crittografia dei tuoi dati e delle tue credenziali in transito e ti garantisce di connetterti ai sistemi {{site.data.keyword.cloudant_short_notm}}.

## Attiva l'alias

Adesso avvia una nuova shell o esegui `source ~/.bash_profile` (o `~/.bashrc` se hai utilizzato questo) per rendere funzionale l'alias.

## Test di `acurl`

Ora assicuriamoci che tutto sia impostato correttamente.
Vai avanti ed esegui:

```sh
acurl https://$ACCOUNT.cloudant.com/_all_dbs
```
{:codeblock}

Se ottieni l'elenco dei tuoi database,
è stato eseguito tutto correttamente.
`acurl` è impostato e pronto per l'uso.

Inizia a codificare.
