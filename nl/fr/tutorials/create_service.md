---

copyright:
  years: 2017, 2019
lastupdated: "2019-06-12"

keywords: create service instance, service credentials, locate service credentials

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

<!-- Acrolinx: 2018-09-19 -->

# Création d'une instance {{site.data.keyword.cloudant_short_notm}} sur {{site.data.keyword.cloud_notm}}
{: #creating-an-ibm-cloudant-instance-on-ibm-cloud}

Ce tutoriel explique comment créer une instance de service
{{site.data.keyword.cloudantfull}} à l'aide du tableau de bord
{{site.data.keyword.cloud}} et indique où trouver les informations
essentielles permettant d'activer vos applications en vue de leur utilisation avec la
base de données.
{: shortdesc} 

## Création d'une instance de service
{: #creating-a-service-instance}

1.  Connectez-vous à votre compte {{site.data.keyword.cloud_notm}}.<br/>
       Le tableau de bord {{site.data.keyword.cloud_notm}} se trouve à l'adresse :
    [https://cloud.ibm.com/ ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://cloud.ibm.com/){: new_window}.
    Une fois que vous vous êtes identifié avec votre nom d'utilisateur et votre mot de passe, le tableau de bord {{site.data.keyword.cloud_notm}} apparaît. Cliquez sur le bouton `Créer une ressource`. <br/>
    ![Tableau de bord {{site.data.keyword.cloud_notm}}](images/img0001.png) 

2.  Cliquez sur `Bases de données` dans le menu et sur `Cloudant` dans la liste des services de base de données :<br/>
    ![Services de base de données {{site.data.keyword.cloud_notm}}](images/img0003.png)<br/> 

3.  Dans la fenêtre de configuration du service, entrez un nom de service. Vérifiez que le nom du service, la région/l'emplacement, le groupe de ressources et les méthodes d'authentification sont corrects. Ajoutez une balise, si vous le souhaitez. Les méthodes d'authentification disponibles incluent `Use only IAM` (Utiliser uniquement IAM) et `Use both legacy credentials and IAM` (Utiliser les données d'identification existantes et IAM). Pour plus d'informations, voir [Méthodes d'authentification](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-){: new_window}. 
    Dans cet exemple, le nom de service est `Cloudant-o7` : <br/>
    ![Nom et données d'identification du service {{site.data.keyword.cloudant_short_notm}}](images/img0005.png)  
    
L'équipe {{site.data.keyword.cloudant_short_notm}} recommande l'utilisation des contrôles d'accès IAM plutôt que de l'authentification {{site.data.keyword.cloudant_short_notm}} existante, à chaque fois que c'est possible.
{: important}

4.  Par défaut, le service est créé avec le plan de tarification 'Lite', qui est gratuit mais qui met à disposition une capacité de débit et un espace de stockage de données fixes. Si vous disposez d'un compte payant {{site.data.keyword.cloud_notm}}, vous pouvez également choisir le plan payant 'Standard' afin d'activer ou désactiver la capacité de débit mise à disposition et d'adapter l'utilisation des données en fonction de vos besoins. Pour en savoir plus sur les plans de tarification, voir [Plans](/docs/services/Cloudant?topic=cloudant-ibm-cloud-public#plans){: new_window}. Pour créer le service, cliquez sur le bouton `Créer` : <br/>
    ![Création du nom et des données d'identification du service {{site.data.keyword.cloudant_short_notm}}](images/img0006.png) 

5.  Une page s'affiche, confirmant que le nouveau service {{site.data.keyword.cloudant_short_notm}} est disponible.
    Pour créer les informations de connexion dont votre application a besoin pour se connecter au service, cliquez sur l'onglet `Données d'identification pour le service` :<br/>
    ![Création des données d'identification pour le service {{site.data.keyword.cloudant_short_notm}}](images/img0007.png) :

6.  Créez de nouvelles données d'identification pour le service {{site.data.keyword.cloudant_short_notm}} :
  <br>a. Cliquez sur le bouton `Nouvelles données d'identification`.
  <br>![Créer de nouvelles données d'identification pour le service](images/img0050.png)
  <br>b. Entrez un nom pour les nouvelles données d'identification dans la fenêtre Ajouter de nouvelles données d'identification. Voir l'image.
  <br>c. Acceptez le rôle de Responsable.
  <br>d. (Facultatif) Créez un nouvel ID de service ou obtenez un ID généré automatiquement pour vous. 
  <br>d. Le paramètre "Ajouter des paramètres de configuration en ligne (facultatif)" n'est pas utilisé actuellement par les données d'identification du service {{site.data.keyword.cloudant_short_notm}} et vous pouvez donc l'ignorer. 
  <br>e. Cliquez sur le bouton `Ajouter`.</br>

<br>![Ajouter de nouvelles données d'identification de service](images/img0051.png)
  <br>Vos nouvelles données d'identification apparaissent en dessous du tableau.</br>
    <br>f. Cliquez sur `Afficher les données d'identification` sous Actions.
  <br>![Afficher toutes les données d'identification pour le service](images/img0052.png)

7.  Les détails des données d'identification du service s'affichent :<br/>
    ![Données d'identification du service  {{site.data.keyword.cloudant_short_notm}}](images/img0009.png)
   

Dans ces exemples, les données d'identification du service ont été définies lors de la création d'un service {{site.data.keyword.cloudant_short_notm}} de démonstration sur {{site.data.keyword.cloudant_short_notm}}. Ces données d'identification sont reproduites ici pour illustrer la manière dont elles apparaissent dans le tableau de bord. Toutefois, le service {{site.data.keyword.cloudant_short_notm}} de démonstration ayant été retiré, elles ne sont plus valides. Vous _devez_ indiquer et utiliser vos propres données d'identification pour le service.
{: note}

## Données d'identification du service
{: #the-service-credentials}

Les données d'identification du service sont précieuses. Si un utilisateur ou une application dispose d'un accès aux données d'identification, il peut effectuer n'importe quelle opération sur l'instance de service. Par exemple, créer des données erronées ou supprimer des informations utiles. Il convient de bien protéger ces données d'identification.
    
{{site.data.keyword.cloudant_short_notm}} offre deux méthodes d'authentification au moment de la mise à disposition : `Use only IAM` (Utiliser uniquement IAM) et `Use both legacy credentials and IAM` (Utiliser les données d'identification existantes et IAM). Les détails de vos données d'identification existantes s'afficheront uniquement si la méthode d'authentification `Use both legacy credentials and IAM` (Utiliser les données d'identification existantes et IAM) a été sélectionnée. Les données d'identification s'affichent sur l'onglet Données d'identification pour le service, pour votre instance. Pour plus d'informations, consultez le [guide IAM](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-) et le document [sur l'authentification existante](/docs/services/Cloudant?topic=cloudant-authentication#authentication) pour obtenir des détails sur l'utilisation de chaque type d'authentification.

Les données d'identification de service incluent les zones suivantes :

Zone | Objectif
------|--------
`username` | Nom de l'utilisateur de l'instance de service fourni dans l'URL. Cette zone sert également de nom d'administrateur. 
`password` | Mot de passe d'identification requis par les applications pour accéder à l'instance de service. Cette zone s'affiche uniquement si l'option `Use both legacy credentials and IAM` (Utiliser les données d'identification existantes et IAM) a été sélectionnée. 
`host` | Nom d'hôte employé par les applications pour localiser l'instance de service. Cette zone s'affiche uniquement si l'option `Use both legacy credentials and IAM` (Utiliser les données d'identification existantes et IAM) a été sélectionnée. 
`port` | Numéro de port HTTPS pour l'accès à l'instance de service sur l'hôte. Ce numéro est 443 car seul l'accès HTTPS est autorisé par {{site.data.keyword.cloudant_short_notm}}. Cette zone s'affiche uniquement si l'option `Use both legacy credentials and IAM` (Utiliser les données d'identification existantes et IAM) a été sélectionnée. 
`url`	| URL HTTPS d'accès à l'instance {{site.data.keyword.cloudant_short_notm}}. Si l'option `Use both legacy credentials and IAM` (Utiliser les données d'identification existantes et IAM) a été sélectionnée, elle inclut également le nom d'utilisateur et le mot de passe intégrés existants. 
`apikey` | Clé d'API IAM. 
`iam_apikey_description` | Description de la clé d'API IAM. 
`iam_apikey_name` | ID de la clé d'API IAM.
`iam_role_crn` | Rôle IAM associé à la clé d'API IAM.
`iam_serviceid_crn`	| CRN de l'ID de service.

Pour créer une application pouvant accéder à votre instance de service, vous avez besoin de ces données d'identification.

## Localisation de vos données d'identification du service
{: #locating-your-service-credentials}

A tout moment, vous pouvez retrouver les données d'identification d'un service qui est associé à votre compte.

1.  Commencez par vous connecter à {{site.data.keyword.cloud_notm}}.
    Le tableau de bord {{site.data.keyword.cloud_notm}} se trouve à l'adresse :
    [https://cloud.ibm.com/ ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://cloud.ibm.com/){: new_window}.
    Une fois que vous vous êtes authentifié avec votre nom d'utilisateur et votre mot de passe, le tableau de bord {{site.data.keyword.cloud_notm}} apparaît :<br/>
    ![Tableau de bord {{site.data.keyword.cloud_notm}}](images/img0001.png)

2.  Dans cet exemple, nous souhaitons trouver les données d'identification de l'instance de service {{site.data.keyword.cloudant_short_notm}}
    qui a été créée précédemment dans ce tutoriel et que nous avons appelée `Cloudant-o7`. Cliquez sur l'icône **Menu** > **Liste de ressources** puis sur la ligne correspondante :<br/>
    ![Sélection du service {{site.data.keyword.cloudant_short_notm}}](images/img0011.png)

3.  Pour afficher les données d'identification requises afin d'accéder au service, cliquez sur `Afficher les données d'identification` : <br/>
    ![Affichage des données d'identification du service {{site.data.keyword.cloudant_short_notm}}](images/img0052.png)  

4.  Les détails des données d'identification du service s'affichent :<br/>
    ![Données d'identification du service  {{site.data.keyword.cloudant_short_notm}}](images/img0009.png)
   

Dans ces exemples, les données d'identification du service ont été définies lors de la création d'un service {{site.data.keyword.cloudant_short_notm}} de démonstration sur {{site.data.keyword.cloudant_short_notm}}. Ces données d'identification sont reproduites ici pour illustrer la manière dont elles apparaissent dans le tableau de bord. Toutefois, le service {{site.data.keyword.cloudant_short_notm}} de démonstration ayant été retiré, elles ne sont plus valides. Vous _devez_ indiquer et utiliser vos propres données d'identification pour le service.
{: note}

