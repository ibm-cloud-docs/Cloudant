---

copyright:
  years: 2017, 2018
lastupdated: "2018-10-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:tip: .tip}

<!-- Acrolinx: 2017-05-10 -->

# Création d'une application {{site.data.keyword.cloud_notm}} simple permettant d'accéder à une base de données {{site.data.keyword.cloudant_short_notm}} : téléchargement de l'application

Cette section du tutoriel décrit comment télécharger une application {{site.data.keyword.cloud}}.
{:shortdesc}

<div id="uploading"></div>

## Connexion à {{site.data.keyword.cloud_notm}}

La première tâche consiste à se connecter à {{site.data.keyword.cloud_notm}}.

Le [kit d'outils {{site.data.keyword.cloud_notm}}](create_bmxapp_appenv.html#toolkits) vous aide à établir la connexion.

Cloud Foundry doit connaître l'URL à employer pour effectuer les appels d'API, par exemple lorsque vous téléchargez une application.
Le kit d'outils {{site.data.keyword.cloud_notm}} utilise la commande '`cf api`' pour gérer le noeud final d'API.
Vous trouverez davantage d'informations sur la commande '`cf api`' [ici ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://console.ng.bluemix.net/docs/cli/reference/cfcommands/index.html#cf_api){:new_window}.

Utilisez la commande suivante pour indiquer à Cloud Foundry l'URL à utiliser :

```sh
bluemix api https://api.ng.bluemix.net
```
{:pre}

Vous devez obtenir un résultat similaire à la sortie suivante :

```
Invoking 'cf api https://api.ng.bluemix.net'...

Setting api endpoint to https://api.ng.bluemix.net...
OK

API endpoint:   https://api.ng.bluemix.net
API version:    2.54.0
Not logged in. Use 'bluemix login' to log in.
```
{:codeblock}

Cloud Foundry sait désormais où il doit envoyer les appels d'API pour la gestion des applications.

L'étape suivante consiste à vous connecter à votre environnement d'application {{site.data.keyword.cloud_notm}}.
Vous devez indiquer les détails du compte suivants :

-   Votre nom d'utilisateur, spécifié en tant que paramètre '`-u`'.
-   Votre nom d'organisation, spécifié en tant que paramètre '`-o`'.
-   Votre espace, spécifié en tant que paramètre '`-s`'.

  Les détails du compte sont disponibles sur votre tableau de bord {{site.data.keyword.cloud_notm}} lorsque vous vous connectez via un navigateur Web, comme illustré dans l'exemple ci-dessous :
  {: tip}

  ![Recherche des détails de votre compte {{site.data.keyword.cloud_notm}}](images/img0035.png)

Utilisez une commande similaire à l'exemple suivant pour vous connecter à votre environnement d'application {{site.data.keyword.cloud_notm}}.
Vous êtes invité à entrer le mot de passe de votre compte.

```sh
bluemix login -u Adrian.Warman@uk.ibm.com -o Adrian.Warman@uk.ibm.com -s dev
```
{:pre}

Vous devez obtenir un résultat similaire à la sortie suivante :

```
Invoking 'cf login -u Adrian.Warman@uk.ibm.com -o Adrian.Warman@uk.ibm.com -s dev'...

API endpoint: https://api.ng.bluemix.net

Password>
Authenticating...
OK

Targeted org Adrian.Warman@uk.ibm.com

Targeted space dev
                
API endpoint:   https://api.ng.bluemix.net (API version: 2.54.0)
User:           adrian.warman@uk.ibm.com
Org:            Adrian.Warman@uk.ibm.com
Space:          dev
```
{:codeblock}

## Téléchargement de l'application

Le kit d'outils {{site.data.keyword.cloudant_short_notm}} Foundry sait désormais comment se connecter à l'environnement {{site.data.keyword.cloud_notm}}.

L'étape suivante consiste à télécharger l'application elle-même.
Les détails d'une application {{site.data.keyword.cloud_notm}} sont fournis dans le [fichier manifeste](create_bmxapp_appenv.html#manifest).

Le fichier manifeste de l'application du tutoriel a été mis à jour comme indiqué [ici](create_bmxapp_createapp.html#essential-files).

Utilisez une commande similaire à l'exemple suivant pour vous connecter à votre application {{site.data.keyword.cloud_notm}}.

```sh
cf push "Cloudant Python"
```
{:pre}

Une séquence de messages de résultat s'affiche.

```
Using manifest file /..../BMXDemo/manifest.yml

Updating app {{site.data.keyword.cloudant_short_notm}} Python in org Adrian.Warman@uk.ibm.com / space dev as Adrian.Warman@uk.ibm.com...
OK
```
{:codeblock}

Le kit d'outils Cloud Foundry a localisé le fichier manifeste et se prépare à télécharger l'application à l'aide des détails de connexion et d'identification que vous avez fournis [précédemment](#uploading).

```
Using route Cloudant-Python.mybluemix.net
Uploading Cloudant Python...
Uploading app files from: /..../BMXDemo
Uploading 1.5K, 3 files
Done uploading               
OK
Binding service {{site.data.keyword.cloudant_short_notm}} Service 2017 to app {{site.data.keyword.cloudant_short_notm}} Python in org Adrian.Warman@uk.ibm.com / space dev as Adrian.Warman@uk.ibm.com...
OK
```
{:codeblock}

L'application a été téléchargée avec succès et une connexion a été établie avec l'instance de base de données {{site.data.keyword.cloudant_short_notm}}.

```
Starting app {{site.data.keyword.cloudant_short_notm}} Python in org Adrian.Warman@uk.ibm.com / space dev as Adrian.Warman@uk.ibm.com...
-----> Downloaded app package (4.0K)
-----> Downloaded app buildpack cache (29M)
-------> Buildpack version 1.5.5
     $ pip install -r requirements.txt
DEPRECATION: --allow-all-external has been deprecated and will be removed in the future. Due to changes in the repository protocol, it no longer has any effect.
       Collecting cloudant==2.3.1 (from -r requirements.txt (line 1))
         Downloading cloudant-2.3.1-py2-none-any.whl (63kB)
       Collecting requests<3.0.0,>=2.7.0 (from cloudant==2.3.1->-r requirements.txt (line 1))
         Downloading requests-2.12.4-py2.py3-none-any.whl (576kB)
       Installing collected packages: requests, cloudant
       Successfully installed cloudant-2.3.1 requests-2.12.4
You are using pip version 8.1.1, however version 9.0.1 is available.
You should consider upgrading via the 'pip install --upgrade pip' command.
You are using pip version 8.1.1, however version 9.0.1 is available.
You should consider upgrading via the 'pip install --upgrade pip' command.
-----> Uploading droplet (30M)

0 of 1 instances running, 1 starting
1 of 1 instances running

App started


OK

App {{site.data.keyword.cloudant_short_notm}} Python was started using this command `python server.py`
```
{:codeblock}

L'application se lance automatiquement.
Dans le cadre du démarrage, une vérification s'assure que toutes les exigences sont
satisfaites grâce à l'évaluation du contenu du
[fichier requirements.txt](create_bmxapp_appenv.html#requirements).
L'application doit avoir accès à la bibliothèque {{site.data.keyword.cloudant_short_notm}}, qui a été
[spécifiée](create_bmxapp_createapp.html#essential-files) lors de la création de l'application.

Une fois que vous avez téléchargé et démarré l'application, certaines vérifications
système simples sont exécutées pour confirmer que l'application s'exécute correctement en
ce qui concerne {{site.data.keyword.cloud_notm}}.

```
Showing health and status for app {{site.data.keyword.cloudant_short_notm}} Python in org Adrian.Warman@uk.ibm.com / space dev as Adrian.Warman@uk.ibm.com...
OK

requested state: started
instances: 1/1
usage: 128M x 1 instances
urls: Cloudant-Python.mybluemix.net
last uploaded: Thu Dec 22 15:58:18 UTC 2016
stack: cflinuxfs2
buildpack: python 1.5.5

     state     since                    cpu    memory          disk           details
#0   running   2016-12-22 03:59:21 PM   0.0%   49.9M of 128M   110.6M of 1G
```
{:codeblock}

## Test du modèle d'application

Testez maintenant votre application et vérifiez qu'elle fonctionne correctement. 

1.  Ouvrez le tableau de bord {{site.data.keyword.cloud_notm}}. Le lien vers l'application que vous avez créée s'affiche sous Applications Cloud Foundry. Cliquez sur `Cloudant CF app` pour ouvrir la page d'information détaillée.<br/>  
![Capture d'écran représentant le tableau de bord de l'application](images/img0017.png)

2.  Sur la page d'information détaillée `Cloudant CF app`, cliquez sur `Routes` puis cliquez sur le lien `Cloudant-CF-app.mybluemix.net`. <br/>
![Page d'information détaillée d'application Cloudant CF](images/img0030.png)

3. Une nouvelle fenêtre de navigateur s'ouvre à l'adresse https://cloudant-cf-app.mybluemix.net/. Le message vérifie que l'application est en cours. Il dit "Hello World! Thanks for creating a Python Starter Application."<br/>
![Hello World! a vérifié que l'application Cloudant CF fonctionne correctement](images/img0054.png)


### Confirmation des détails de la base de données

Dans le tableau de bord {{site.data.keyword.cloud_notm}}, ouvrez l'instance de service {{site.data.keyword.cloudant_short_notm}} que vous avez créée. Cliquez sur l'instance de service. Accédez à l'onglet `Gérer` et cliquez sur `Lancer le tableau de bord Cloudant`.<br/>
![Lancer le tableau de bord Cloudant sur la page de service {{site.data.keyword.cloudant_short_notm}}](images/img0036.png)

Pour trouver votre page de service {{site.data.keyword.cloudant_short_notm}},
reportez-vous aux informations détaillées contenues dans le tutoriel [Création d'une instance {{site.data.keyword.cloudant_short_notm}}](create_service.html#locating-your-service-credentials).
{: tip}

Lorsque le tableau de bord s'affiche, vous pouvez voir que l'application a créé la
base de données '`databasedemo`' :<br/>
![Tableau de bord {{site.data.keyword.cloudant_short_notm}} affichant la nouvelle base de données](images/img0031.png)

La base de données contient un seul document, créé par l'application.
Pour vérifier la présence du document, cliquez sur le nom de la base de données dans le
tableau de bord.
La liste des options pour la base de données s'affiche.
Lorsque vous sélectionnez l'onglet `Tous les documents`, les détails d'un seul document s'affichent :<br/>
![Un document dans la nouvelle base de données](images/img0032.png)

Pour afficher le contenu du document, cliquez sur l'icône `Editer` représentée par un crayon :<br/>
![Détails du document](images/img0033.png)

Lorsque le contenu du document apparaît, vous pouvez voir chaque zone créée par
l'application du tutoriel.<br/>
![Zones du document](images/img0034.png)<br/>
En particulier, la zone `rightNow` contient la date et l'heure
de création du document.
Cette valeur correspond à l'heure enregistrée dans le
[fichier journal de l'application](#testing-the-sample-application).

## Etape suivante

L'étape suivante du tutoriel consiste à [effectuer des opérations de maintenance
sur l'application](create_bmxapp_maintain.html), comme démarrer, arrêter et déboguer l'application.
