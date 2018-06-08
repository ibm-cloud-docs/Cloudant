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

# Commande curl autorisée : `acurl`

_(Ce guide est basé sur un article de blog rédigé par Samantha Scharr : [
"Authorized curl, a.k.a. acurl" ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://cloudant.com/blog/authorized-curl-a-k-a-acurl/){:new_window}, initialement publié le 27 novembre 2013.)_

`acurl` est un alias pratique qui vous permet d'exécuter des commandes `curl` {{site.data.keyword.cloudantfull}} vers des adresses URL sans avoir à saisir votre nom d'utilisateur et votre mot de passe à chaque requête.
Cela signifie qu'une simple commande `GET` vers une base de données n'a plus besoin d'être saisie au format `https://$ACCOUNT:$PASSWORD@$ACCOUNT.cloudant.com/foo`, mais seulement au format `https://$ACCOUNT.cloudant.com/foo`.

Cela permet non seulement de raccourcir les interminables adresses URL, mais aussi de sécuriser davantage l'alias `acurl`.
Plus besoin d'avoir peur des personnes qui regardent par-dessus votre épaule lorsque vous saisissez votre mot de passe et plus important encore, votre mot de passe n'est pas envoyé en texte en clair sur le réseau grâce au protocole HTTPS.

Il vous suffit pour cela d'exécuter les trois étapes suivantes :

1.	[Codage de votre nom d'utilisateur et mot de passe](#encode-username-and-password)
2.	[Création d'un alias](#create-an-alias)
3.	[Activation de l'alias](#activate-the-alias).

## Codage de votre nom d'utilisateur et mot de passe

Nous codons tout d'abord votre nom d'utilisateur et mot de passe {{site.data.keyword.cloudant_short_notm}} en base64.
Nous obtenons ainsi une séquence de caractères en base64.

Pour ce faire, la commande utilisée est similaire à l'exemple suivant :

```python
python -c 'import base64; print base64.urlsafe_b64encode("$ACCOUNT:$PASSWORD")'
```
{:codeblock}

Nous partons du principe que la sortie s'appelle `<OUTPUT-OF-BASE64>`.

Par exemple, si vous exécutez la commande :

```python
python -c 'import base64; print base64.urlsafe_b64encode("$ACCOUNT:$PASSWORD")'
```
{:codeblock}

Vous obtenez la sortie suivante :

```
bXl1c2VybmFtZTpteXBhc3N3b3Jk
```
{:codeblock}

>	**Remarque** : Rappelez-vous que votre mot de passe est toujours stocké en texte en clair sur votre ordinateur ; le codage en base64 n'est _pas_ un chiffrement.
	Si vous utilisez le codage en base64 sur la même séquence de caractères, vous obtenez toujours la même séquence correspondante.

## Création d'un alias

La deuxième étape consiste à créer un alias pour `curl` qui intègre les données d'identification afin de ne pas avoir à les ressaisir à chaque exécution d'une commande `curl`.

Ajoutez la ligne ci-dessous à `~/.bashrc` ou `~/.bash_profile` :

```sh
alias acurl="curl -s --proto '=https' -g -H 'Authorization: Basic <OUTPUT-OF-BASE64>'"
```
{:codeblock}

Cet alias ajoute un en-tête d'autorisation au lieu d'inclure les données d'identification de l'autorisation dans l'adresse URL que vous entrez sur la ligne de commande.
Il force également l'utilisation du protocole HTTPS dont nous recommandons vivement l'utilisation par rapport au simple protocole HTTP, qui va chiffrer vos données et vos informations d'identification en transit et va vous aider à vérifier que vous êtes connecté aux systèmes {{site.data.keyword.cloudant_short_notm}}.

## Activation de l'alias

Démarrez un nouveau shell ou exécutez `source ~/.bash_profile` (ou `~/.bashrc` si vous l'utilisez) pour rendre l'alias opérationnel.

## Test de `acurl`

Vérifiez maintenant que tout a été configuré correctement.
Exécutez la commande suivante :

```sh
acurl https://$ACCOUNT.cloudant.com/_all_dbs
```
{:codeblock}

Si la liste de vos bases de données s'affiche, c'est parfait.
`acurl` est configuré et prêt à fonctionner.

A vous de jouer maintenant !
