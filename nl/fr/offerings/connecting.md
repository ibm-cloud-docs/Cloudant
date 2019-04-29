---

copyright:
  years: 2019
lastupdated: "2019-03-18"

keywords: endpoints, service credentials, authentication, ibm cloudant dashboard, curl, client libraries

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

<!-- Acrolinx: 2018-07-02 -->

# Connexion
{: #connecting}

L'accès à {{site.data.keyword.cloudantfull}} s'effectue via une API HTTP. Ce document décrit les différentes parties que vous utilisez pour vous connecter à {{site.data.keyword.cloudant_short_notm}} :
- Noeuds finaux
- Données d'identification au service
- Authentification
- Accès au tableau de bord {{site.data.keyword.cloudant_short_notm}}
- Accès à l'aide d'un programme à {{site.data.keyword.cloudant_short_notm}} via [curl ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://curl.haxx.se/){: new_window} ou des bibliothèques client
{: shortdesc}

## Noeuds finaux
{: #endpoints}

L'accès à {{site.data.keyword.cloudant_short_notm}} s'effectue via les noeuds finaux d'API HTTP. Les noeuds finaux pour une instance s'affichent aussi bien dans la zone URL des données d'identification de service pour l'instance, et dans **Compte** > onglet **Paramètres** du tableau de bord {{site.data.keyword.cloudant_short_notm}}.

L'accès à tous les noeuds finaux HTTP {{site.data.keyword.cloudant_short_notm}} devant s'effectuer via TLS, commencez donc par `https://`.

Le noeud final externe visible publiquement est :

`https://USERNAME.cloudant.com`

Toutes les instances mises à disposition après 1er janvier 2019 incluent un noeud final de domaine appdomain.cloud. Le noeud final externe visible publiquement est :

`https://USERNAME.cloudantnosqldb.appdomain.cloud`

Des noeuds finaux internes sont ajoutés à toutes les instances déployées sur les environnements Dedicated Hardware mis à disposition après le 1er janvier 2019 en dehors de l'environnement géré par l'UE. Le noeud final de réseau interne {{site.data.keyword.cloud_notm}} est :

`https://USERNAME.private.cloudantnosqldb.appdomain.cloud`

où USERNAME est le nom de service de l'utilisateur d'instance de service dans l'URL. Cette zone sert aussi de nom d'administrateur lors de l'utilisation de l'authentification {{site.data.keyword.cloudant_short_notm}} existante. Avec un nom USERNAME exemple de810d0e-763f-46a6-ae88-50823dc85581-bluemix, le noeud final externe exemple résultant serait de810d0e-763f-46a6-ae88-50823dc85581-bluemix.cloudantnosqldb.appdomain.cloud. 

## Données d'identification au service
{: #service-credentials}

Pour générer des  données d'identification de service pour {{site.data.keyword.cloudant_short_notm}} via le tableau de bord {{site.data.keyword.cloud_notm}}, voir le tutoriel [Création d'une instance {{site.data.keyword.cloudant_short_notm}} sur {{site.data.keyword.cloud_notm}}](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-an-ibm-cloudant-instance-on-ibm-cloud). Pour générer des  données d'identification de service depuis l'interface de ligne de commande {{site.data.keyword.cloud_notm}}, voir [Création des données d'identification de votre service {{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli#creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli). 

Quelques exemples de données d'identification de service pour une instance {{site.data.keyword.cloudant_short_notm}} sont présentés ci-dessous :

```json
{
  "apikey": "MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz",
  "host": "76838001-b883-444d-90d0-46f89e942a15-bluemix.cloudant.com",
  "iam_apikey_description": "Auto generated apikey during resource-key [...]",
  "iam_apikey_name": "auto-generated-apikey-050d21b5-5f[...]",
  "iam_role_crn": "crn:v1:bluemix:public:iam::::serviceRole:Manager",
  "iam_serviceid_crn": "crn:v1:staging:public:iam-identity::[...]",
  "password": "8fb6a16b48903e87b769e7f4968521e85c2394ed8f0e69b2769e56dcb27d2e76",
  "port": 443,
  "url": "https://<username>:<password>@76838001-b883-444d-90d0-46f89e942a15-bluemix.cloudant.com",
  "username": "76838001-b883-444d-90d0-46f89e942a15-bluemix"
}
```
{: codeblock}

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

## Authentification
{: #authentication-overview}

{{site.data.keyword.cloudant_short_notm}} offre deux méthodes d'authentification au moment de la mise à disposition : `Use only IAM` (Utiliser uniquement IAM) et `Use both legacy credentials and IAM` (Utiliser les données d'identification existantes et IAM). Vous pouvez voir les détails de vos données d'identification existantes dans les données d'identification de service uniquement si la méthode permettant d'utiliser à la fois les données d'identification existantes et IAM est choisie. Les données d'identification s'affichent sur l'onglet Données d'identification pour le service, pour votre instance. Pour plus d'informations, consultez le [guide IAM](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-) et le document [sur l'authentification existante](/docs/services/Cloudant?topic=cloudant-authentication#authentication) pour obtenir des détails sur l'utilisation de chaque type d'authentification.
 
L'équipe {{site.data.keyword.cloudant_short_notm}} recommande l'utilisation des contrôles d'accès IAM pour l'authentification à chaque fois que c'est possible. Si vous vous servez de l'authentification {{site.data.keyword.cloudant_short_notm}} existante, il vous est conseillé d'utiliser les [clés d'API](/docs/services/Cloudant?topic=cloudant-authorization#api-keys){: new_window} plutôt que les données d'identification au niveau du compte pour l'accès par programme et les travaux de réplication. 
{: important}

## Tableau de bord {{site.data.keyword.cloudant_short_notm}}
{: #ibm-cloudant-dashboard}

Vous pouvez ouvrir le tableau de bord {{site.data.keyword.cloudant_short_notm}} pour votre instance en accédant à l'onglet
Gérer de la page des détails de l'instance du tableau de bord {{site.data.keyword.cloud_notm}}. Vous pouvez utiliser les boutons `Lancer` ou `Lancer le tableau de bord Cloudant` pour ouvrir le
tableau de bord dans un nouvel onglet de navigateur. Le tableau de bord {{site.data.keyword.cloudant_short_notm}} vous permet d'effectuer les tâches suivantes :

- Gérer votre consommation actuelle de l'instance
- Exécuter une opération CRUD (Create, Read, Update, Delete) sur les bases de données, les documents et les index {{site.data.keyword.cloudant_short_notm}}
- Configurer et afficher les travaux de réplication
- Afficher les tâches actives
- Afficher et mettre à jour des informations de compte, comme la capacité de débit mise à disposition, les annonces, les partages CORS et les paramètres

## Accès par programme
{: #programmatic-access}

### Ligne de commande (curl)
{: #command-line-curl-}

Vous pouvez optimiser l'utilitaire de ligne de commande curl pour accéder à l'API HTTPS {{site.data.keyword.cloudant_short_notm}}. 

Si vous utilisez l'authentification {{site.data.keyword.cloudant_short_notm}} existante, voir la présentation
[Référence d'API](/docs/services/Cloudant?topic=cloudant-api-reference-overview#api-reference-overview) pour des détails sur la façon de fournir un nom d'utilisateur et un mot de passe
pour accéder à l'API {{site.data.keyword.cloudant_short_notm}} avec curl, comme illustré dans  les exemples de référence d'API.

Si vous utilisez l'authentification IAM {{site.data.keyword.cloud_notm}}, vous devez d'abord obtenir un jeton IAM {{site.data.keyword.cloud_notm}} en utilisant une clé d'API. Ensuite, vous passez le jeton IAM à l'instance {{site.data.keyword.cloudant_short_notm}} pour vous authentifier. Voir le tutoriel [Transmission d'un
jeton {{site.data.keyword.cloud_notm}} pour l'authentification avec une API de service](https://cloud.ibm.com/docs/services/iam?topic=iam-iamapikeysforservices#token_auth){: new_window}. 

Vous ne pouvez pas utiliser une clé d'API IAM directement pour vous authentifier sur {{site.data.keyword.cloudant_short_notm}}.
{: note}

### Bibliothèques client
{: #client-libraries-overview}

{{site.data.keyword.cloudant_short_notm}} dispose de bibliothèques client officielles pour Java, Node.js, Python, Swift et Mobile. Pour plus d'informations, voir la [documentation relative aux bibliothèques client](/docs/services/Cloudant?topic=cloudant-client-libraries#client-libraries) pour accéder aux bibliothèques ainsi que des exemples pour la connexion à une instance {{site.data.keyword.cloudant_short_notm}}. 
