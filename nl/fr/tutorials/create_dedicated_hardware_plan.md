---

copyright:
  years: 2015, 2018
lastupdated: "2018-06-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-02-23 -->

# Création et exploitation d'une instance de plan de matériel dédié {{site.data.keyword.cloudant_short_notm}} sur {{site.data.keyword.Bluemix_notm}} 

Ce tutoriel vous montre comment créer une instance de plan de matériel dédié {{site.data.keyword.cloudantfull}} à l'aide du tableau de bord {{site.data.keyword.Bluemix}} et vous montre comment mettre ensuite à disposition une ou plusieurs instances de plan standard pour les exécuter.  

La création d'une instance de plan de matériel dédié {{site.data.keyword.cloudant_short_notm}} entraîne la mise à disposition d'un environnement {{site.data.keyword.cloudant_short_notm}} sur du matériel dédié à votre usage exclusif. Une instance de service est créée dans le tableau de bord {{site.data.keyword.Bluemix_notm}}, mais notez que vous ne pouvez pas accéder directement à l'instance de Plan de matériel dédié et que vous ne disposez d'aucune donnée d'identification du service pour cette instance. Vous pouvez utiliser une instance de plan de matériel dédié {{site.data.keyword.cloudant_short_notm}} après sa création en mettant à disposition une ou plusieurs instances de plan standard. 

## Création d'une instance de plan de matériel dédié {{site.data.keyword.cloudant_short_notm}}

1.  Connectez-vous à votre compte {{site.data.keyword.Bluemix_notm}}.<br/>
    Le tableau de bord {{site.data.keyword.Bluemix_notm}} est disponible à l'adresse :
    [http://bluemix.net ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](http://bluemix.net){:new_window}.
    Une fois que vous vous êtes authentifié avec votre nom d'utilisateur et votre mot de passe, le tableau de bord {{site.data.keyword.Bluemix_notm}} apparaît :<br/>
    ![Tableau de bord {{site.data.keyword.Bluemix_notm}}](images/img0001.png)

2.  Cliquez sur le lien `Catalogue` :<br/>
    ![Lien du catalogue {{site.data.keyword.Bluemix_notm}}](images/img0002.png)<br/>
    La liste des services disponibles sur {{site.data.keyword.Bluemix_notm}} s'affiche.

3.  Cliquez sur l'entrée `Données & analyse` sous l'en-tête `Services` :<br/>
    ![Services {{site.data.keyword.Bluemix_notm}} Données & analyse](images/img0003.png)<br/>
    La liste des services Données & analyse disponibles sur {{site.data.keyword.Bluemix_notm}} apparaît.

4.  Cliquez sur le service {{site.data.keyword.cloudant_short_notm}} :<br/>
    ![Sélection du service {{site.data.keyword.Bluemix_notm}} {{site.data.keyword.cloudant_short_notm}}](images/img0004.png)<br/>
    La page de création d'un service s'affiche. 

5.  Sélectionnez le plan de matériel `Matériel dédié` dans la liste des Plans de tarification au bas de la page :<br/>
    ![Plans de tarification](../tutorials/images/pricing_plan.png)
    
6.  Remplissez les paramètres suivants en haut de la page : <br/>
    -   Entrez un nom de service.<br/>
    -   Spécifiez la région et l'espace à déployer.<br/>
    -   Sélectionnez un emplacement pour le déploiement.<br/>
    -   Répondez oui ou non à la question de savoir si HIPAA est nécessaire. Notez que HIPAA n'est valide que pour les sites américains.<br/> 
     
    **Remarque** : déployez et mettez à disposition des instances de Plan standard dans la même région et le même espace.    
    ![Configurer le matériel dédié](../tutorials/images/select_deployment_location.png)<br/>
    Commencez le processus de mise à disposition. 
    
7.  Cliquez sur le bouton `Créer` pour commencer la mise à disposition depuis le bas de la page. <br/>
    **Remarque** : la facturation est calculée au prorata quotidiennement, donc veillez à mettre à disposition et acheter un environnement avant de cliquer sur le bouton **Créer**.<br/>
    ![Mettre à disposition le matériel dédié](../tutorials/images/create_button_provision.png)<br/>
    **Remarque** : lors de la mise à disposition, une roue tournante apparaît en regard de l'instance dans votre tableau de bord {{site.data.keyword.Bluemix_notm}}. Une requête est envoyée pour mettre à disposition une instance de Plan de matériel dédié sur des serveurs Bare Metal. Le temps de mise à disposition est asynchrone et peut prendre jusqu'à 5 jours. ![Mettre à disposition une version alternative matérielle dédiée](../tutorials/images/create_button_provision2.png)<br/>
    
## Mise à disposition d'une instance de Plan standard dans un Environnement matériel dédié

1.  Connectez-vous à votre compte {{site.data.keyword.Bluemix_notm}}.<br/>
    Le tableau de bord {{site.data.keyword.Bluemix_notm}} est disponible à l'adresse :
    [http://bluemix.net ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](http://bluemix.net){:new_window}.
    Une fois que vous vous êtes authentifié avec votre nom d'utilisateur et votre mot de passe, le tableau de bord {{site.data.keyword.Bluemix_notm}} apparaît :<br/>
    ![Tableau de bord {{site.data.keyword.Bluemix_notm}}](images/img0001.png)

2.  Cliquez sur le lien `Catalogue` :<br/>
    ![Lien du catalogue {{site.data.keyword.Bluemix_notm}}](images/img0002.png)<br/>
    La liste des services disponibles sur {{site.data.keyword.Bluemix_notm}} s'affiche.

3.  Cliquez sur l'entrée `Données & analyse` sous l'en-tête `Services` :<br/>
    ![Services {{site.data.keyword.Bluemix_notm}} Données & analyse](images/img0003.png)<br/>
    La liste des services Données & analyse disponibles sur {{site.data.keyword.Bluemix_notm}} apparaît.

4.  Cliquez sur le service {{site.data.keyword.cloudant_short_notm}} :<br>
    ![Sélection du service {{site.data.keyword.Bluemix_notm}} {{site.data.keyword.cloudant_short_notm}}](images/img0004.png)<br/>
    La page de création d'un service s'affiche.  

5.  Cliquez sur `Standard` sur les plans de tarification au bas de la page. <br/>
    **Remarque** : vous ne pouvez pas mettre à disposition une instance de Plan limité dans un environnement de Matériel dédié.<br/>
    ![Plan de tarification standard](../tutorials/images/standard_pricing_plan.png)
    
6.  Complétez les paramètres en haut de la page en entrant un Nom de service, un Nom des données d'identification et ainsi de suite comme vous le feriez pour une instance de Plan standard. Décidez si vous souhaitez effectuer la mise à disposition sur l'environnement régional à service partagé par défaut ou sur l'environnement de Matériel dédié que vous avez mis à disposition à l'aide de la liste déroulante `Sélectionner l'environnement`.<br/>
    ![Configurer l'instance standard](../tutorials/images/select_environment.png)
    
7.  Cliquez sur le bouton `Créer` en bas de la page.<br/>
    Après quelques secondes, l'instance est mise à disposition sur l'environnement que vous avez sélectionné.<br/>
    ![Mettre à disposition l'instance standard](../tutorials/images/create_button_provision_standard.png)
    
8.  Obtenez vos Données d'identification pour le service et accédez au tableau de bord de {{site.data.keyword.cloudant_short_notm}} comme vous le faites pour une instance {{site.data.keyword.cloudant_short_notm}} à service partagé. 
    Voir plus d'informations sur la façon de localiser vos Données d'identification pour le service [ici ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://console.bluemix.net/docs/services/Cloudant/tutorials/create_service.html#locating-your-service-credentials){:new_window}. 
     
