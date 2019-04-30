---

copyright:
  years: 2015, 2019
lastupdated: "2019-04-02"

keywords: create dedicated hardware plan instance, provision standard plan instance, cli, create credentials, list service credentials

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

# Création et exploitation d'une instance de plan {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware sur {{site.data.keyword.cloud_notm}}
{: #creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud}

Ce tutoriel vous montre comment créer une instance de plan {{site.data.keyword.cloudantfull}} Dedicated Hardware utilisant le tableau de bord {{site.data.keyword.cloud}} et montre comment mettre à disposition ensuite une ou plusieurs instances du plan Standard pour s'exécuter dessus à l'aide du catalogue {{site.data.keyword.cloud_notm}} ou de l'interface de ligne de commande de {{site.data.keyword.cloud_notm}}. 
{: shortdesc}

La création d'une instance de plan {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware entraîne la mise à disposition d'un environnement {{site.data.keyword.cloudant_short_notm}} sur du matériel dédié à votre usage exclusif. Une instance de service est créée dans le tableau de bord {{site.data.keyword.cloud_notm}}, mais vous ne pouvez pas accéder à l'instance du plan Dedicated Hardware directement et vous n'aurez pas de données d'identification de service pour cela. Vous pouvez utiliser une instance de plan {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware après sa création en mettant à disposition une ou plusieurs instances de plan Standard.

## Création d'une instance de plan {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware
{: #creating-an-ibm-cloudant-dedicated-hardware-plan-instance}

1.  Connectez-vous à votre compte {{site.data.keyword.cloud_notm}}.<br/>
    Le tableau de bord {{site.data.keyword.cloud_notm}} se trouve à l'adresse : [`https://cloud.ibm.com/` ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://cloud.ibm.com/){: new_window}.
    Une fois que vous vous êtes identifié avec votre nom d'utilisateur et votre mot de passe, le tableau de bord {{site.data.keyword.cloud_notm}} apparaît. Cliquez sur le bouton `Créer une ressource` :<br/>
    ![Tableau de bord {{site.data.keyword.cloud_notm}}](images/img0001.png)

2.  Cliquez sur `Bases de données` dans le menu de gauche et sur `Cloudant` dans la liste des services de base de données.<br/>
     ![{{site.data.keyword.cloud_notm}} Sélection du service {{site.data.keyword.cloudant_short_notm}}](images/img0003.png)<br/>

3.  Sélectionnez le plan `Dedicated Hardware` dans la liste des plans de tarification au bas de la page :<br/>
    ![Plans de tarification](/docs/services/Cloudant/tutorials/images/pricing_plan.png)
    
4.  Remplissez les paramètres suivants en haut de la page : <br/>
    -   Entrez un nom de service.<br/>
    -   Spécifiez la région/l'emplacement où vous souhaitez déployer.<br/>
    -   Sélectionnez un groupe de ressources.</br>
    -   Ajoutez une balise. 
    -   Sélectionnez un emplacement pour le déploiement.<br/>
    -   Sélectionnez `yes` ou `no` à la question de savoir si HIPAA est nécessaire.<br/> 
    
    HIPAA est uniquement valide pour les sites américains. {{site.data.keyword.IBM}} peut mettre à disposition un environnement de plan Dedicated Hardware pour implémenter des contrôles HIPAA. Un environment est uniquement mis à disposition sur confirmation d'un accord BAA (Business Associate Agreement) établi avec {{site.data.keyword.IBM_notm}}. Voir [Activation des paramètres pris en charge dans l'Union Européenne et pour la loi HIPAA](https://cloud.ibm.com/docs/account/eu_hipaa_supported.html#enabling-the-hipaa-supported-setting) ainsi que les conditions de description de service pour plus de détails. La mise à disposition d'un cluster pour gérer des données HIPAA peut prendre plus longtemps que la durée estimée de 5 jours.
    {: note}

    ![Configurer le matériel dédié](/docs/services/Cloudant/tutorials/images/select_deployment_location.png)
        
5.  Cliquez sur le bouton `Créer` pour démarrer le processus de mise à disposition. <br/>

    La facturation est calculée au prorata quotidiennement, donc veillez à mettre à disposition et à payer un environnement avant de cliquer sur le bouton **Créer**.
    {: note}

    ![Mettre à disposition le matériel dédié](/docs/services/Cloudant/tutorials/images/create_button_provision.png)

    Lors de la mise à disposition, une roue tournante apparaît en regard de l'instance dans votre tableau de bord {{site.data.keyword.cloud_notm}}. Une requête est envoyée pour mettre à disposition une instance de plan Dedicated Hardware sur des serveurs Bare Metal. La durée de mise à disposition est asynchrone et peut prendre jusqu'à 5 jours. 
    {: note}   

    ![Mise à disposition de la version alternative du matériel dédié](/docs/services/Cloudant/tutorials/images/create_button_provision2.png)
    
## Mise à disposition d'une instance de plan Standard dans un environnement Dedicated Hardware
{: #provisioning-a-standard-plan-instance-on-a-dedicated-hardware-environment}

1.  Connectez-vous à votre compte {{site.data.keyword.cloud_notm}}.<br/>
    Le tableau de bord {{site.data.keyword.cloud_notm}} se trouve à l'adresse :
    [https://cloud.ibm.com/ ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://cloud.ibm.com/){: new_window}.
    Une fois que vous vous êtes identifié avec votre nom d'utilisateur et votre mot de passe, le tableau de bord {{site.data.keyword.cloud_notm}} apparaît. Cliquez sur le bouton `Créer une ressource` :<br/>
    ![Tableau de bord {{site.data.keyword.cloud_notm}}](images/img0001.png)

2.  Cliquez sur `Databases` dans le menu de gauche et sur `Cloudant` dans la liste des services de base de données.<br/>
     ![{{site.data.keyword.cloud_notm}} Sélection du service {{site.data.keyword.cloudant_short_notm}}](images/img0003.png)<br/>
    La page de création d'un service s'affiche.<br/>  

3.  Cliquez sur `Standard` dans la liste des plans de tarification <br/>
    ![Plan de tarification standard](/docs/services/Cloudant/tutorials/images/standard_pricing_plan.png)
    
    Vous ne pouvez pas mettre à disposition une instance de plan Lite sur un environnement Dedicated Hardware.
    {: tip}
    
4.  Renseignez les paramètres suivants : <br/>
    -   Entrez un nom de service.<br/>
    -   Spécifiez la région/l'emplacement où vous souhaitez déployer. <br/>
    -   Sélectionnez un groupe de ressources. </br>
    -   Ajoutez une balise. 
    -   Sélectionnez une méthode d'authentification.</br>
    -   Sélectionnez un environnement.</br>
    ![Configurer l'instance standard](/docs/services/Cloudant/tutorials/images/select_environment.png)
    
5.  Cliquez sur le bouton `Créer`.<br/>
    Après quelques secondes, l'instance est mise à disposition sur l'environnement que vous avez sélectionné.<br/>
    ![Mettre à disposition l'instance standard](/docs/services/Cloudant/tutorials/images/create_button_provision_standard.png)
    
6.  Obtenez vos Données d'identification pour le service et accédez au tableau de bord de {{site.data.keyword.cloudant_short_notm}} comme vous le faites pour une instance {{site.data.keyword.cloudant_short_notm}} à service partagé. 
    
    Pour plus d'informations, voir [comment localiser vos données d'identification de service](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#locating-your-service-credentials){: new_window}. 
    
## Mise à disposition d'une instance de plan Standard sur un environnement Dedicated Hardware avec l'interface de ligne de commande de {{site.data.keyword.cloud_notm}}
{: #provisioning-a-standard-plan-instance-on-a-dedicated-hardware-environment-with-the-ibm-cloud-cli}

Pour utiliser l'interface de ligne de commande de {{site.data.keyword.cloud_notm}}, vous devez être connecté. Pour plus d'informations sur la façon dont vous pouvez vous connecter et définir un groupe de ressources cible, voir [Connexion à votre compte {{site.data.keyword.cloud_notm}}](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli#logging-in-to-your-ibm-cloud-account){: new_window}. 

Pour créer une instance de plan Standard {{site.data.keyword.cloudant_short_notm}} sur votre environnement {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware, utilisez le format de commande de base suivant :


Zone | Description
------|------------
`NAME`| Nom arbitraire que vous affectez à l'instance.
`SERVICE_NAME` | `cloudantnosqldb`
`PLAN_NAME` | Plan standard
`LOCATION` |  Emplacement où vous souhaitez déployer, par us-south, us-east ou eu-gb. 

Voir l'exemple de commande suivant : 

```sh
ibmcloud resource service-instance-create NAME SERVICE_NAME SERVICE_PLAN_NAME LOCATION [-p, --parameters @JSON_FILE | JSON_STRING ]
```
{: codeblock}

Les instances {{site.data.keyword.cloudant_short_notm}} qui sont déployées sur les environnements Dedicated Hardware nécessitent deux paramètres supplémentaires :

Paramètre | Description
----------|------------
`environment_crn` | Ce paramètre doit être défini sur le CRN de l'instance du plan {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware. Vous pouvez déterminer quel est le CRN en consultant l'exemple de commande d'interface de ligne de commande dans l'onglet Gérer de l'instance du plan {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware dans le tableau de bord de {{site.data.keyword.cloud_notm}}. Vous pouvez également déterminer quel est le CRN à l'aide de la commande `ibmcloud resource service-instance SERVICE_INSTANCE_NAME`. 
`legacyCredentials` | Paramètre facultatif défini sur true par défaut qui dicte si l'instance utilise les données d'identification existante et les données d'identification IAM ou seulement IAM. Voir le [guide IAM![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-){: new_window} pour plus de détails sur le choix d'une méthode d'authentification.

Voir l'exemple de commande suivant : 

```sh
ibmcloud resource service-instance-create cloudant_on_ded_hardware_cli cloudantnosqldb standard us-south -p '{"environment_crn":"crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b43434444bb7e2abb0841ca25d28ee4c:301a3118-7678-4d99-b1b7-4d45cf5f7b29::","legacyCredentials":false}'
```
{: codeblock}

## Création des données d'identification pour votre service {{site.data.keyword.cloudant_short_notm}}
{: #creating-the-credentials-for-your-ibm-cloudant-service}

Les applications qui requièrent un accès à votre service
{{site.data.keyword.cloudant_short_notm}} doivent disposer des données d'identification nécessaires.

Les données d'identification du service sont précieuses. Si un utilisateur ou une application dispose d'un accès aux données d'identification, il peut effectuer n'importe quelle opération sur l'instance de service. Par exemple, créer des données erronées ou supprimer des informations utiles. Il convient de bien protéger ces données d'identification.
{: important}

Pour plus d'informations sur les zones incluses dans les données d'identification du service, voir le [guide IAM ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-){: new_window}.

Le format de la commande de base qui permet de créer les données d'identification d'une instance de service dans
{{site.data.keyword.cloud_notm}} est le suivant :

```sh
ibmcloud resource service-key-create NAME ROLE_NAME --instance-name SERVICE_INSTANCE_NAME [--enable-internal-service-endpoint true]
```
{: pre}

Les zones sont décrites dans le tableau suivant :

Zone | Description
------|------------
`NAME` | Nom arbitraire que vous donnez aux données d'identification du service. 
`ROLE_NAME` | Cette zone n'admet actuellement que le rôle de responsable.
`SERVICE_INSTANCE_NAME` | Nom que vous donnez à votre instance {{site.data.keyword.cloudant_short_notm}}.
`enable-internal-service-endpoint` | Zone facultative permettant de renseigner la zone d'URL dans les données d'identification de service avec un noeud final interne pour connecter le service au réseau interne {{site.data.keyword.cloud_notm}}. Ignorez cette zone pour renseigner l'URL avec un noeud final externe accessible publiquement. Ne s'applique qu'aux instances de plan Standard déployées sur des environnements Dedicated Hardware qui prennent en charge les noeuds finaux internes. La commande génère une erreur 400 si l'environnement ne prend pas en charge les noeuds finaux interne. 

Si vous voulez créer des données d'identification pour l'instance `cs20170517a` d'un service {{site.data.keyword.cloudant_short_notm}} (où le nom des données d'identification est `creds_for_cs20170517a`), vous devez utiliser une commande similaire à l'exemple suivant :

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

Si vous voulez créer des données d'identification pour l'instance `cs20170517a` d'un service {{site.data.keyword.cloudant_short_notm}} (où le nom des données d'identification est `creds_for_cs20170517a`) et que vous voulez renseigner l'URL avec un noeud final interne, vous devez utiliser une commande similaire à l'exemple suivant :

```sh
ibmcloud resource service-key-create creds_for_cs20170517a Manager --instance-name cs20170517a --enable-internal-service-endpoint true
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
Created At:    Tue Jan 02 19:58:38 UTC 2019   
State:         active   
Credentials:                                   
               iam_apikey_name:          auto-generated-apikey-621ffde2-ea10-4318-b297-d6d849cec48a      
               iam_role_crn:             crn:v1:bluemix:public:iam::::serviceRole:Manager      
               url:                      https://2624fed5-e53e-41de-a85b-3c7d7636886f-bluemix.private.cloudantnosqldb.appdomain.cloud      
               username:                 f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix          
               apikey:                   XXXXX-XXXXXX_XXXXXXXXXXXXX-XXXXXXXXXXX      
               host:                     2624fed5-e53e-41de-a85b-3c7d7636886f-bluemix.private.cloudantnosqldb.appdomain.cloud      
               iam_apikey_description:   Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42116849bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3::      
               iam_serviceid_crn:        crn:v1:bluemix:public:iam-identity::a/b42116849bb7e2abb0841ca25d28ee4c::serviceid:ServiceId-53f9e2a2-cdfb-4f90-b072-bfffafb68b3e       
```
{: pre}

## Affichage de la liste des données d'identification de votre service {{site.data.keyword.cloudant_short_notm}}
{: #listing-the-service-credentials-for-your-ibm-cloudant-service}

Le format de la commande de base qui permet d'extraire les données d'identification
d'une instance de service dans {{site.data.keyword.cloud_notm}} est le suivant :

```sh
ibmcloud resource service-key KEY_NAME
```
{: codeblock}

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
