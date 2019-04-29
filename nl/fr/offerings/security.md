---

copyright:
  years: 2017, 2019
lastupdated: "2019-03-18"

keywords: dbaas data protection, top-tier physical platforms, secure access control, data loss, corruption

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

# Sécurité
{: #security}


## Sécurité et protection des données dans {{site.data.keyword.cloudant_short_notm}} DBaaS
{: #ibm-cloudant-dbaas-data-protection-and-security}

La protection des données des applications mobiles et Web à grande échelle peut s'avérer complexe, surtout quand il s'agit de bases de données distribuées et NoSQL.

Tout en réduisant les efforts de maintenance de vos bases de données nécessaires à leur fonctionnement et à leur croissance ininterrompue, {{site.data.keyword.cloudantfull}} garantit également la sécurité et la protection de vos données.
{: shortdesc}

## Plateformes physiques de niveau supérieur
{: #top-tier-physical-platforms}

{{site.data.keyword.cloudant_short_notm}} DBaaS est hébergée physiquement
sur des fournisseurs d'infrastructure de cloud de niveau 1, tels qu'{{site.data.keyword.cloud}} et Amazon.
Vos données sont ainsi protégées par le réseau et les mesures de sécurité physiques mises
en oeuvre par ces fournisseurs qui comprennent :

- Les certifications : conformité avec les normes SSAE16, SOC2 Type 1, ISAE 3402, ISO 27001, CSA et d'autres normes.
- La gestion des accès et des identités.
- La sécurité physique générale des centres de données et la surveillance des centres des opérations réseau.
- Le renforcement des serveurs.
- {{site.data.keyword.cloudant_short_notm}} vous donne la possibilité de choisir ou de basculer entre les différents fournisseurs au fur et à mesure des
modifications des exigences de votre accord sur les niveaux de service (SLA) ou de vos coûts.

Vous trouverez plus de détails sur les certifications dans les [informations relatives à la conformité](/docs/services/Cloudant?topic=cloudant-compliance#compliance).
{: tip}

## Contrôle d'accès sécurisé
{: #secure-access-control}

{{site.data.keyword.cloudant_short_notm}} possède de nombreuses fonctions de sécurité intégrées qui vous permettent de contrôler l'accès aux données :

Fonction | Description
--------|------------
Authentification | L'accès à {{site.data.keyword.cloudant_short_notm}} s'effectue à l'aide d'une API HTTPS. Lorsque le noeud final d'API l'exige, l'utilisateur est authentifié pour chaque requête HTTPS reçue par {{site.data.keyword.cloudant_short_notm}}. {{site.data.keyword.cloudant_short_notm}} prend en charge le contrôle d'accès existant et le contrôle d'accès IAM. Pour plus d'informations, consultez le [guide IAM](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-){: new_window} ou le document [API d'authentification](/docs/services/Cloudant?topic=cloudant-authentication#authentication){: new_window}.
Autorisation | {{site.data.keyword.cloudant_short_notm}} prend en charge le contrôle d'accès existant et le contrôle d'accès IAM. L'équipe {{site.data.keyword.cloudant_short_notm}} recommande l'utilisation des contrôles d'accès IAM pour l'authentification à chaque fois que c'est possible. Si vous vous servez de l'authentification {{site.data.keyword.cloudant_short_notm}} existante, il vous est conseillé d'utiliser les [clés d'API](/docs/services/Cloudant?topic=cloudant-authorization#api-keys){: new_window} plutôt que les données d'identification au niveau du compte pour l'accès par programme et les travaux de réplication. Pour plus d'informations, voir le [guide IAM](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-){: new_window} ou les documents relatifs à l'[API d'authentification](/docs/services/Cloudant?topic=cloudant-authentication#authentication){: new_window} et à l'[API d'autorisation](/docs/services/Cloudant?topic=cloudant-authorization#authorization){: new_window}.
Chiffrement "au repos" | Toutes les données qui sont stockées dans une instance {{site.data.keyword.cloudant_short_notm}} sont chiffrées au repos. Si vous avez besoin du mode de chiffrement BYOK (bring-your-own-key) pour les données au repos, il est activé à l'aide de {{site.data.keyword.cloud_notm}} Key
Protect. {{site.data.keyword.cloudant_short_notm}} prend en charge cette fonction pour les nouvelles instances du plan {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware qui sont déployées dans toutes les régions. Créez d'abord une instance du plan Dedicated Hardware à l'aide du catalogue {{site.data.keyword.cloud_notm}}. Ensuite, soumettez un ticket de demande de service. Notre équipe de support se chargera d'obtenir les clés de chiffrement des données au repos de votre nouvelle instance Dedicated Hardware qui sont gérées par votre instance Key Protect.
Chiffrement "à la volée" | Les accès à {{site.data.keyword.cloudant_short_notm}} sont chiffrés avec HTTPS.
TLS | Il est recommandé d'utiliser TLS 1.2 ou 1.3 pour tout accès à {{site.data.keyword.cloudant_short_notm}}. (***En juin 2019, la prise en charge de {{site.data.keyword.cloudant_short_notm}} retirera l'utilisation des versions plus anciennes (TLS 1.0 et 1.1), date à partir  de laquelle seul TLS 1.2+ sera accepté.***) Le certificat que {{site.data.keyword.cloudant_short_notm}} utilise pour les connexions HTTPS est signé par une autorité de certification  universellement approuvée qui est pré-certifiée par tous les navigateurs, systèmes d'exploitation et autres systèmes logiciel comme le kit JDK (Java Development Kit). IBM s'engage à toujours publier un certificat TLS valide (non expiré) signé par une autorité de certification universellement approuvée. Il lui est toutefois impossible de coordonner les changements avec les clients et aucun engagement de rester avec DigiCert n'est pris. Pour assurer un accès continu au service {{site.data.keyword.cloudant_short_notm}}, il est vivement déconseillé aux clients d'épingler le certificat actuel, qui est sujet à expiration et à une rotation rapide en cas de compromission. Les clients sont invités à la place à utiliser les regroupements de certificats par défaut pour leurs systèmes d'exploitation et navigateurs, ce qui permet d'assurer un service continu en cas de changements de certificats.
Noeuds finaux | Toutes les instances {{site.data.keyword.cloudant_short_notm}} sont fournies avec des noeuds finaux externes qui sont accessibles publiquement. Les environnements Dedicated Hardware mis à disposition après le 1er janvier 2019 ajoutent aussi des noeuds finaux internes pour toutes les instances de plan Standard qui y sont déployées. L'utilisation de noeuds finaux internes permet aux clients de se connecter à une instance {{site.data.keyword.cloudant_short_notm}} via le réseau {{site.data.keyword.cloud}} interne pour éviter que le trafic d'application en amont vienne empiéter sur le réseau public, ce qui aurait un effet sur la bande passante facturée. Voir [Documentation IBM Cloud Service Endpoint](https://cloud.ibm.com/docs/services/service-endpoint/getting-started.html#about){:new_window} pour plus de détails sur l'activation des noeuds finaux de service pour votre compte {{site.data.keyword.cloud}}.
Mise sur liste blanche des adresses IP | Les clients {{site.data.keyword.cloudant_short_notm}} qui ont un environnement {{site.data.keyword.cloudant_short_notm}} dédié peuvent mettre des adresses IP sur liste blanche pour restreindre l'accès aux serveurs et utilisateurs spécifiés uniquement. La mise sur liste blanche des adresses IP n'est pas disponible pour tous les plans Lite/Standard {{site.data.keyword.cloud_notm}} public déployé sur des environnements à service partagé. Ouvrez un ticket de demande de service pour demander des listes blanches d'adresses IP pour un ensemble spécifié d'adresses IP ou de plages d'adresses IP. Notez que les listes blanches d'adresses IP s'appliquent à la fois à l'API {{site.data.keyword.cloudant_short_notm}} et au tableau de bord, donc n'oubliez pas d'inclure toutes les adresses IP administrateur qui doivent accéder directement au tableau de bord {{site.data.keyword.cloudant_short_notm}}. 
CORS | Activez la prise en charge de CORS pour des domaines spécifiques en utilisant l'API ou le tableau de bord {{site.data.keyword.cloudant_short_notm}}. Pour plus d'informations, voir la documentation [d'API CORS](/docs/services/Cloudant?topic=cloudant-cors#cors){:new_window}.

<!--
> **Note**: Your data is visible to the {{site.data.keyword.cloudant_short_notm}} 
> worldwide team. If you don’t 
> want our team to see your data, encrypt it before sending it to 
> {{site.data.keyword.IBM_notm}}, and avoid leaking 
> data into your document `_id` and any attachment file names. In addition, 
> when you send personal data, you must use HTTPS to ensure that it is sent securely. 
> HTTP is no longer supported.  

> **Warning**: You are responsible for verifying that 
> {{site.data.keyword.cloudant_short_notm}} can be used to store 
> your data. You must also make sure that your data does not violate applicable 
> data protection laws or any regulations that require security measures 
> beyond those specified in the {{site.data.keyword.cloudant_short_notm}} 
> system requirements and {{site.data.keyword.cloud_notm}} Services terms. You must 
> verify that the security requirements are appropriate for any personal data 
> that is processed. If you are unsure, or intend to store data that is 
> beyond the scope of the {{site.data.keyword.cloudant_short_notm}} terms and conditions, 
> you must get approval from {{site.data.keyword.IBM_notm}} to ensure that it is 
> appropriate for {{site.data.keyword.cloudant_short_notm}} to store your data.
-->

## Protection contre la perte ou l'altération des données
{: #protection-against-data-loss-or-corruption}

{{site.data.keyword.cloudant_short_notm}} comporte plusieurs fonctions vous
permettant de gérer la qualité et la disponibilité des données :

Fonction | Description
--------|------------
Stockage de données redondant et durable | Par défaut, {{site.data.keyword.cloudant_short_notm}} sauvegarde sur disque trois copies de chaque document sur trois noeuds différents d'un cluster. Cette sauvegarde de copies garantit ainsi la disponibilité d'une copie de bascule de vos
données, quelle que soit la défaillance.
Réplication et exportation des données | Vous pouvez répliquer vos bases de données en continu entre des clusters de différents centres de données, sur un cluster {{site.data.keyword.cloudant_short_notm}} Local sur site ou sur Apache CouchDB. Vous pouvez aussi exporter les données depuis {{site.data.keyword.cloudant_short_notm}} (au format JSON) vers d'autres
emplacements ou sources (comme votre propre centre de données) afin de créer une redondance supplémentaire des données.
