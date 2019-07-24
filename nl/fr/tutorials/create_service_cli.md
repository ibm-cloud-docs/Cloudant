---

copyright:
  years: 2017, 2019
lastupdated: "2019-06-12"

keywords: identify, api endpoints, log in, select ibm cloudant plan, create ibm cloudant service, create credentials, list service credentials, use ibm cloudant service instance, delete service credentials, delete service instance

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

<!-- Acrolinx: 2018-08-20 -->

# Création d'une instance {{site.data.keyword.cloudant_short_notm}} sur {{site.data.keyword.cloud_notm}} à l'aide de l'interface de ligne de commande {{site.data.keyword.cloud_notm}}
{: #creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli}

Ce tutoriel vous apprend à créer une instance de service {{site.data.keyword.cloudantfull}} sur {{site.data.keyword.cloud}} à l'aide de l'interface de ligne de commande {{site.data.keyword.cloud_notm}}.
{: shortdesc}

## Avant de démarrer ce tutoriel 
{: #before-you-start-this-tutorial}

Pour suivre ce tutoriel, vous devez d'abord installer les outils de développement de l'interface de ligne de commande {{site.data.keyword.cloud_notm}}. Pour en savoir plus sur l'installation des outils, consultez le tutoriel [Getting started with the {{site.data.keyword.cloud_notm}} CLI ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://cloud.ibm.com/docs/cli?topic=cloud-cli-ibmcloud-cli#overview){: new_window}.

## Identification du noeud final d'API {{site.data.keyword.cloud_notm}}
{: #identifying-the-ibm-cloud-api-endpoint}

Spécifiez le noeud final d'API cible pour vos commandes {{site.data.keyword.cloud_notm}} :

```sh
ibmcloud api https://api.ng.bluemix.net
```
{: codeblock}

Le résultat confirme que vous avez identifié correctement le noeud final :

```sh
Setting api endpoint to https://api.ng.bluemix.net...
OK

API endpoint:   https://api.ng.bluemix.net (API version: 2.54.0)
Not logged in. Use 'ibmcloud login' to log in.
```
{: pre}

## Connexion à votre compte {{site.data.keyword.cloud_notm}}
{: #logging-in-to-your-ibm-cloud-account}

L'exemple suivant décrit le processus de connexion. Si vous utilisez un ID d'utilisateur fédéré, il est important de passer à un code unique (`ibmcloud login --sso`), ou d'utiliser une clé d'API (`ibmcloud --apikey key or @key_file`) pour s'authentifier. Pour en savoir plus sur la connexion à l'aide de l'interface de ligne de commande, voir [Commandes générales de l'interface CLI (ibmcloud) ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://cloud.ibm.com/docs/cli/reference/ibmcloud?topic=cloud-cli-ibmcloud_cli#ibmcloud_login){: new_window} sous `ibmcloud login`. 

1.  Démarrez le processus de connexion pour votre compte  {{site.data.keyword.cloud_notm}} à l'aide de la commande suivante :
  
  ```sh
  ibmcloud login
  ```
  {: codeblock}
  
  {{site.data.keyword.cloud_notm}} répond en vous rappelant le noeud final d'API en cours, puis vous demande l'adresse électronique de votre compte :
  
  ```sh
  API endpoint: https://api.ng.bluemix.net
  
  Email>
  ```
  {: pre}

2.  Entrez l'adresse e-mail de votre compte, puis votre mot de passe :

  ```sh
  API endpoint: https://api.ng.bluemix.net
  
  Email> J.Doe@email.com
  
  Password>
  ```
  {: pre}
  
  {{site.data.keyword.cloud_notm}} valide vos données et récapitule les informations sur votre session de connexion :

  ```sh
  API endpoint: https://api.ng.bluemix.net
  
  Email> J.Doe@email.com
  
  Password>
  Authenticating...
  OK
  
  Targeted account J DOE's Account (707...a32)
  
  Targeted org J.Doe@email.com
  
  Targeted space dev
  
  API endpoint:   https://api.ng.bluemix.net (API version: 2.54.0)
  Region:         us-south
  User:           j.doe@email.com
  Account:        J DOE's Account (707...a32)
  Org:            J.Doe@email.com
  Space:          dev
  ```
  {: pre}

3.  Vous êtes maintenant connecté à votre compte {{site.data.keyword.cloud_notm}}.

## Choix du plan {{site.data.keyword.cloudant_short_notm}} pour votre service
{: #choosing-the-ibm-cloudant-plan-for-your-service}

Voir la section [Plans](/docs/services/Cloudant?topic=cloudant-ibm-cloud-public#plans) de la documentation pour obtenir des informations sur l'utilisation du forfait Lite ou Standard de {{site.data.keyword.cloudant_short_notm}}.
{: pre}

## Création du service {{site.data.keyword.cloudant_short_notm}}
{: #creating-the-ibm-cloudant-service}

{{site.data.keyword.cloudant_short_notm}} utilise des groupes de ressources pour mettre à disposition de nouvelles instances au lieu d'organisation et d'espaces Cloud Foundry. Les instances {{site.data.keyword.cloudant_short_notm}} mises à disposition dans le passé peuvent continuer d'être déployées dans les organisations et les espaces Cloud Foundry. Pour en savoir plus, voir [Comment {{site.data.keyword.cloudant_short_notm}} fonctionne-t-il avec les groupes de ressources {{site.data.keyword.cloud_notm}} ? ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](/docs/services/Cloudant?topic=cloudant-how-does-ibm-cloudant-work-with-ibm-cloud-resource-groups-#how-does-ibm-cloudant-work-with-ibm-cloud-resource-groups-){: new_window} .

Configurez d'abord votre groupe de ressources cible et la région comme décrit sous [Commandes générales de l'interface CLI (ibmcloud) ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://cloud.ibm.com/docs/cli/reference/ibmcloud?topic=cloud-cli-ibmcloud_cli#ibmcloud_target){: new_window} sous `ibmcloud target` en utilisant le format suivant :

```sh
ibmcloud target [-r REGION_NAME] [-g RESOURCE_GROUP]
```

Pour obtenir une liste des régions, exécutez la commande suivante :

```sh
ibmcloud regions
```

Pour obtenir une liste des groupes de ressources, exécutez la commande suivante : 

```sh
ibmcloud resource groups
```

Ensuite, pour créer une instance de service, le format de commande de base dans {{site.data.keyword.cloud_notm}} est le suivant :

```sh
ibmcloud resource service-instance-create NAME SERVICE_NAME|SERVICE_ID SERVICE_PLAN_NAME|SERVICE_PLAN_ID LOCATION [-p, --parameters @JSON_FILE | JSON_STRING ]
```
{: pre}

Les zones sont décrites dans le tableau suivant : 


Zone | Description
------|------------
`NAME` | Nom arbitraire que vous donnez à l'instance. 
`SERVICE_NAME` | `cloudantnosqldb`
`PLAN_NAME` | Plan Lite ou plan Standard.
`LOCATION` | Lieu où vous souhaitez déployer : Asie-Pacifique Nord, Allemagne, Global, Sydney, Royaume-Uni, Est des Etats-Unis ou Sud des Etats-Unis. 
`legacyCredentials` | La valeur par défaut est true. Cette zone dicte si l'instance utilise à la fois les données d'identification existantes et IAM ou seulement IAM. 

Pour en savoir plus sur le choix de la méthode d'authentification, consultez le [guide IAM](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-){: new_window}. L'équipe {{site.data.keyword.cloudant_short_notm}} recommande l'utilisation des contrôles d'accès IAM plutôt que de l'authentification {{site.data.keyword.cloudant_short_notm}} existante, à chaque fois que c'est possible.
{: important}

Dans cet exemple, nous voulons créer une instance d'un service {{site.data.keyword.cloudant_short_notm}} à l'aide du plan `Lite` (le nom d'instance est `cs20170517a`, la région est le Sud des Etats-Unis et nous utilisons les données d'identification IAM uniquement). Pour créer cette instance, utilisez une commande similaire à l'exemple suivant :

```sh
ibmcloud resource service-instance-create cs20170517a cloudantnosqldb lite us-south -p '{"legacyCredentials": false}'
```
{: codeblock}

Une fois l'instance de service créée, {{site.data.keyword.cloud_notm}} répond avec un message similaire à l'exemple suivant :

```sh
Creating service instance cs20170517a in resource group default of account John Does's Account as j.doe@email.com...
OK
Service instance cs20170517a was created.
Name          Location   State    Type               Tags   
cs20170517a   us-south   active   service_instance  
```
{: pre}

## Création des données d'identification de votre service {{site.data.keyword.cloudant_short_notm}}
{: #creating-credentials-for-your-ibm-cloudant-service}

Les applications qui requièrent un accès à votre service
{{site.data.keyword.cloudant_short_notm}} doivent disposer des données d'identification nécessaires.

Les données d'identification du service sont précieuses. Si un utilisateur ou une application dispose d'un accès aux données d'identification, il peut effectuer n'importe quelle opération sur l'instance de service. Par exemple, créer des données erronées ou supprimer des informations utiles. Il convient de bien protéger ces données d'identification.
{: important}

Pour en savoir plus sur les zones incluses dans les données d'identification du service, consultez le [guide IAM](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-){: new_window}.

Le format de la commande de base qui permet de créer les données d'identification d'une instance de service dans
{{site.data.keyword.cloud_notm}} est le suivant :

```sh
ibmcloud resource service-key-create NAME ROLE_NAME --instance-name SERVICE_INSTANCE_NAME
```
{: pre}

Les zones sont décrites dans le tableau suivant :

Zone | Description
------|------------
`NAME` | Nom arbitraire que vous donnez aux données d'identification du service. 
`ROLE_NAME` | Cette zone n'admet actuellement que le rôle de responsable.
`SERVICE_INSTANCE_NAME` | Nom que vous donnez à votre instance {{site.data.keyword.cloudant_short_notm}}. 

Si vous souhaitez créer des données d'identification pour l'instance `cs20170517a` d'un service {{site.data.keyword.cloudant_short_notm}} (le nom des données d'identification est `creds_for_cs20170517a`), créez ces données d'identification à l'aide d'une commande similaire à l'exemple suivant :

```sh
ibmcloud resource service-key-create creds_for_cs20170517a Manager --instance-name cs20170517a
```
{: codeblock}

Après avoir reçu la demande de création des données d'identification pour
l'instance de service, {{site.data.keyword.cloud_notm}} répond avec un message
similaire à celui de l'exemple suivant :

```sh
Creating service key in resource group default of account John Does's Account as john.doe@email.com...
OK
Service key crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a was created.
                  
Name:          creds_for_cs20170517a   
ID:            crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a   
Created At:    Tue Sep 18 19:58:38 UTC 2018   
State:         active   
Credentials:                                   
               iam_apikey_name:          auto-generated-apikey-621ffde2-ea10-4318-b297-d6d849cec48a      
               iam_role_crn:             crn:v1:bluemix:public:iam::::serviceRole:Manager      
               url:                      https://f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix:5811381f6daff7255b288695c3544be63f550e975bcde46799473e69c7d48d61@f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix.cloudant.com      
               username:                 f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix      
               port:                     443      
               apikey:                   XXXXX-XXXXXX_XXXXXXXXXXXXX-XXXXXXXXXXX      
               host:                     f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix.cloudant.com      
               iam_apikey_description:   Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42116849bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3::      
               iam_serviceid_crn:        crn:v1:bluemix:public:iam-identity::a/b42116849bb7e2abb0841ca25d28ee4c::serviceid:ServiceId-53f9e2a2-cdfb-4f90-b072-bfffafb68b3e      
               password:                 581138...7d48d61 
```
{: pre}

## Extraction des données d'identification de service pour votre service {{site.data.keyword.cloudant_short_notm}}
{: #retrieving-the-service-credentials-for-your-ibm-cloudant-service}

Le format de la commande de base qui permet d'extraire les données d'identification
d'une instance de service dans {{site.data.keyword.cloud_notm}} est le suivant :

```sh
ibmcloud resource service-key KEY_NAME
```
{: pre}

Dans cet exemple, nous voulons extraire les données d'identification de l'instance `cs20170517a` d'un service {{site.data.keyword.cloudant_short_notm}} (le nom des données d'identification est `creds_for_cs20170517a`). Pour extraire les données d'identification, utilisez une commande similaire à l'exemple suivant :

```sh
ibmcloud resource service-key creds_for_cs20170517b
```
{: codeblock}

Après avoir reçu la demande d'extraction des données d'identification pour
l'instance de service, {{site.data.keyword.cloud_notm}} répond avec un message
similaire à celui de l'exemple suivant (abrégé) :

```sh
Retrieving service key in resource group default of account John Does's Account as john.doe@email.com...
OK
Service key crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a was created.
                  
Name:          creds_for_cs20170517a   
ID:            crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a   
Created At:    Tue Sep 18 19:58:38 UTC 2018   
State:         active   
Credentials:                                   
               iam_apikey_name:          auto-generated-apikey-621ffde2-ea10-4318-b297-d6d849cec48a      
               iam_role_crn:             crn:v1:bluemix:public:iam::::serviceRole:Manager      
               url:                      https://f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix:5811381f6daff7255b288695c3544be63f550e975bcde46799473e69c7d48d61@f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix.cloudant.com      
               username:                 f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix      
               port:                     443      
               apikey:                   XXXXX-XXXXXX_XXXXXXXXXXXXX-XXXXXXXXXXX      
               host:                     f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix.cloudant.com      
               iam_apikey_description:   Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42116849bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3::      
               iam_serviceid_crn:        crn:v1:bluemix:public:iam-identity::a/b42116849bb7e2abb0841ca25d28ee4c::serviceid:ServiceId-53f9e2a2-cdfb-4f90-b072-bfffafb68b3e      
               password:                 581138...7d48d61 
```
{: pre}

## Utilisation de votre instance de service {{site.data.keyword.cloudant_short_notm}}
{: #using-your-ibm-cloudant-service-instance}

Vous avez maintenant terminé les tâches suivantes :

1.  Créé une instance de service {{site.data.keyword.cloudant_short_notm}} dans {{site.data.keyword.cloud_notm}}.
2.  Créé des données d'identification pour l'instance de service {{site.data.keyword.cloudant_short_notm}}.
3.  Extrait les données d'identification de l'instance de service de telle sorte qu'elles puissent être utilisées par votre application.

Pour plus d'informations, consultez le tutoriel [Création et remplissage d'une base de données {{site.data.keyword.cloudant_short_notm}} simple sur {{site.data.keyword.cloud_notm}}](/docs/services/Cloudant?topic=cloudant-creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud#context){: new_window}. Ce tutoriel vous montre comment utiliser une instance de service {{site.data.keyword.cloudant_short_notm}} à partir d'une application Python à l'aide des données d'identification existantes. Pour rappel, vous devez remplacer les données d'identification par celles que vous avez créées dans ce tutoriel.

## (facultatif) Nettoyage postérieur
{: #-optional-tidying-up-afterward}

La liste de commandes suivante peut s'avérer utile si vous souhaitez nettoyer votre environnement de développement.

### Suppression des données d'identification du service
{: #deleting-service-credentials}

Pour supprimer un ensemble de données d'identification de service, utilisez une commande similaire à celle-ci :

```sh
ibmcloud resource service-key-delete KEY_NAME
```
{: pre}

Par exemple, pour supprimer les données d'identification `creds_for_cs20170517a`, utilisez une commande similaire à celle-ci :

```sh
ibmcloud resource service-key-delete creds_for_cs20170517a
```
{: pre}

### Suppression d'une instance de service
{: #deleting-a-service-instance}

Pour supprimer une instance de service, utilisez une commande similaire à celle-ci :

```sh
ibmcloud resource service-instance-delete SERVICE_INSTANCE_NAME
```
{: pre}

Par exemple, pour supprimer l'instance `cs20170517a` d'un service {{site.data.keyword.cloudant_short_notm}}, utilisez une commande similaire à celle-ci :

```sh
ibmcloud resource service-instance-delete cs20170517a
```
{: pre}

