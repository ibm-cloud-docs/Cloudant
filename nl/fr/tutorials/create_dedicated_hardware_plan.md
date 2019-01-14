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


# Création et exploitation d'une instance de plan {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware sur {{site.data.keyword.cloud_notm}}

Ce tutoriel vous montre comment créer une instance de plan {{site.data.keyword.cloudantfull}} Dedicated Hardware utilisant le tableau de bord {{site.data.keyword.cloud}} et montre comment mettre à disposition ensuite une ou plusieurs instances du plan Standard pour s'exécuter dessus à l'aide du catalogue {{site.data.keyword.cloud_notm}} ou de l'interface de ligne de commande de {{site.data.keyword.cloud_notm}}. 

La création d'une instance de plan {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware entraîne la mise à disposition d'un environnement {{site.data.keyword.cloudant_short_notm}} sur du matériel dédié à votre usage exclusif. Une instance de service est créée dans le tableau de bord {{site.data.keyword.cloud_notm}}, mais vous ne pouvez pas accéder à l'instance du plan Dedicated Hardware directement et vous n'aurez pas de données d'identification de service pour cela. Vous pouvez utiliser une instance de plan {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware après sa création en mettant à disposition une ou plusieurs instances de plan Standard.

## Création d'une instance de plan {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware 

1.  Connectez-vous à votre compte {{site.data.keyword.cloud_notm}}.<br/>
    Le tableau de bord {{site.data.keyword.cloud_notm}} est disponible à l'adresse :
    [http://bluemix.net ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](http://bluemix.net){:new_window}.
    Une fois que vous vous êtes authentifié avec votre nom d'utilisateur et votre mot de passe, le tableau de bord {{site.data.keyword.cloud_notm}} apparaît :<br/>
    ![Tableau de bord {{site.data.keyword.cloud_notm}}](images/img0001.png)

2.  Cliquez sur le bouton `Créer une ressource` :<br/>
    ![Bouton Créer une ressource de {{site.data.keyword.cloud_notm}}](images/img0002.png)<br/>
    
3.  Voir le catalogue {{site.data.keyword.cloud_notm}} et les services disponibles. Cliquez sur la catégorie `Bases de données`.
    ![{{site.data.keyword.cloud_notm}}](images/img0000.png)

4.  Cliquez sur le service {{site.data.keyword.cloudant_short_notm}} :<br/>
    ![{{site.data.keyword.cloud_notm}} Sélection du service {{site.data.keyword.cloudant_short_notm}}](images/img0003.png)<br/>
    La page de création d'un service s'affiche.

5.  Sélectionnez le plan `Dedicated Hardware` dans la liste des plans de tarification au bas de la page :<br/>
    ![Plans de tarification](../tutorials/images/pricing_plan.png)
    
6.  Remplissez les paramètres suivants en haut de la page : <br/>
    -   Entrez un nom de service.<br/>
    -   Spécifiez la région/l'emplacement où vous souhaitez déployer.<br/>
    -   Sélectionnez un groupe de ressources.</br>
    -   Sélectionnez un emplacement pour le déploiement.<br/>
    -   Sélectionnez `yes` ou `no` à la question de savoir si HIPAA est nécessaire.<br/>
   
    HIPAA est uniquement valide pour les sites américains. {{site.data.keyword.IBM}} peut mettre à disposition un cluster dédié ou bare metal pour implémenter les contrôles HIPAA. Un cluster est uniquement mis à disposition sur confirmation d'un accord BAA (Business Associate Agreement) établi avec {{site.data.keyword.IBM_notm}}. L'accord est décrit dans les conditions de la description du service. La mise à disposition d'un cluster pour gérer des données HIPAA peut prendre plus longtemps que la durée estimée de 5 jours.
    {: tip}
    
    Les instances du plan Standard doivent être déployées et mises à disposition dans la même région et le même espace.
    {: tip}

    ![Configurer le matériel dédié](../tutorials/images/select_deployment_location.png)
        
7.  Cliquez sur le bouton `Créer` pour démarrer le processus de mise à disposition. <br/>

    La facturation est calculée au prorata quotidiennement, donc veillez à mettre à disposition et à payer un environnement avant de cliquer sur le bouton **Créer**.{: tip}

    ![Mettre à disposition le matériel dédié](../tutorials/images/create_button_provision.png)

    Lors de la mise à disposition, une roue tournante apparaît en regard de l'instance dans votre tableau de bord {{site.data.keyword.cloud_notm}}. Une requête est envoyée pour mettre à disposition une instance de plan Dedicated Hardware sur des serveurs Bare Metal. La durée de mise à disposition est asynchrone et peut prendre jusqu'à 5 jours.
    {: tip}   

    ![Mise à disposition de la version alternative du matériel dédié](../tutorials/images/create_button_provision2.png)
    
## Mise à disposition d'une instance de plan Standard dans un environnement Dedicated Hardware

1.  Connectez-vous à votre compte {{site.data.keyword.cloud_notm}}.<br/>
    Le tableau de bord {{site.data.keyword.cloud_notm}} est disponible à l'adresse :
    [http://bluemix.net ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](http://bluemix.net){:new_window}.
    Une fois que vous vous êtes authentifié avec votre nom d'utilisateur et votre mot de passe, le tableau de bord {{site.data.keyword.cloud_notm}} apparaît :<br/>
    ![Tableau de bord {{site.data.keyword.cloud_notm}}](images/img0001.png)

2.  Cliquez sur le bouton `Créer une ressource` :<br/>
    ![{{site.data.keyword.cloud_notm}} créer une ressource](images/img0002.png)<br/>
    La liste des services disponibles sur {{site.data.keyword.cloud_notm}} s'affiche.

3.  Cliquez sur la catégorie `Bases de données` et sélectionnez le service `Cloudant` :<br/>
    ![{{site.data.keyword.cloud_notm}} Sélection du service {{site.data.keyword.cloudant_short_notm}}](images/img0003.png)</br>
    La page de création d'un service s'affiche.<br/>  

4.  Cliquez sur `Standard` dans la liste des plans de tarification<br/>
    ![Plan de tarification standard](../tutorials/images/standard_pricing_plan.png)
    
    Vous ne pouvez pas mettre à disposition une instance de plan Lite sur un environnement Dedicated Hardware.
    {: tip}
    
5.  Renseignez les paramètres suivants : <br/>
    -   Entez un nom de service.<br/>
    -   Spécifiez la région/l'emplacement où vous souhaitez déployer.<br/>
    -   Sélectionnez un groupe de ressources.</br>
    -   Sélectionnez une méthode d'authentification.</br>
    -   Sélectionnez un environnement.</br>
    ![Configurer l'instance standard](../tutorials/images/select_environment.png)
    
6.  Cliquez sur le bouton `Créer`.<br/>
    Après quelques secondes, l'instance est mise à disposition sur l'environnement que vous avez sélectionné.<br/>
    ![Mettre à disposition l'instance standard](../tutorials/images/create_button_provision_standard.png)
    
7.  Obtenez vos Données d'identification pour le service et accédez au tableau de bord de {{site.data.keyword.cloudant_short_notm}} comme vous le faites pour une instance {{site.data.keyword.cloudant_short_notm}} à service partagé. 
    
    Pour plus d'informations, voir [comment localiser vos données d'identification de service](../tutorials/create_service.html#locating-your-service-credentials){:new_window}. 
    
## Mise à disposition d'une instance de plan Standard sur un environnement Dedicated Hardware avec l'interface de ligne de commande de {{site.data.keyword.cloud_notm}}

Pour utiliser l'interface de ligne de commande de {{site.data.keyword.cloud_notm}}, vous devez être connecté. Pour en savoir plus sur la manière dont vous pouvez vous connecter et définir un groupe de ressources cible, voir [Connexion à votre compte {{site.data.keyword.cloud_notm}}](create_service_cli.html#logging-in-to-your-ibm-cloud-account){:new_window}. 

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

Les instances {{site.data.keyword.cloudant_short_notm}} qui sont déployées sur les environnements Dedicated Hardware nécessitent deux paramètres supplémentaires :

Paramètre | Description
----------|------------
`environment_crn` | Ce paramètre doit être défini sur le CRN de l'instance du plan {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware. Vous pouvez déterminer quel est le CRN en consultant l'exemple de commande d'interface de ligne de commande dans l'onglet Gérer de l'instance du plan {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware dans le tableau de bord de {{site.data.keyword.cloud_notm}}. Vous pouvez également déterminer quel est le CRN à l'aide de la commande `ibmcloud resource service-instance SERVICE_INSTANCE_NAME`.
`legacyCredentials` | Paramètre facultatif défini sur true par défaut qui dicte si l'instance utilise les données d'identification existante et les données d'identification IAM ou seulement IAM. Voir le [guide IAM![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](../guides/iam.html#ibm-cloud-identity-and-access-management-iam-){:new_window} pour plus de détails sur le choix d'une méthode d'authentification.

Voir l'exemple de commande suivant : 

```sh
ibmcloud resource service-instance-create cloudant_on_ded_hardware_cli cloudantnosqldb standard us-south -p '{"environment_crn":"crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b43434444bb7e2abb0841ca25d28ee4c:301a3118-7678-4d99-b1b7-4d45cf5f7b29::","legacyCredentials":false}'
```
     
