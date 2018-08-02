---

copyright:
  years: 2015, 2018
lastupdated: "2018-05-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-02-23 -->

# {{site.data.keyword.cloud_notm}} dédié

{{site.data.keyword.cloudantfull}} pour ({{site.data.keyword.cloud}} dédié) est un module complémentaire payant facultatif destiné à un environnement {{site.data.keyword.cloud_notm}} dédié. Le prix du module complémentaire facultatif pour {{site.data.keyword.cloudant_short_notm}} dédié dans {{site.data.keyword.cloud_notm}} dédié varie en fonction de la capacité matérielle allouée à l'environnement. Vous pouvez l'acquérir en contactant votre ingénieur commercial {{site.data.keyword.IBM}}.   

Les clients {{site.data.keyword.cloud_notm}} dédié peuvent également choisir d'utiliser {{site.data.keyword.cloudant_short_notm}} dans {{site.data.keyword.cloud_notm}} public via le catalogue syndiqué, y compris les instances de plans limité et standard. Notez que les utilisateurs de {{site.data.keyword.cloud_notm}} dédié ne sont pas éligibles pour acheter le plan de matériel dédié dans le catalogue {{site.data.keyword.cloud_notm}} public et doivent utiliser {{site.data.keyword.cloudant_short_notm}} dédié sur {{site.data.keyword.cloud_notm}} dédié si un matériel dédié est requis.    

La capture d'écran ci-dessous montre un exemple de catalogue {{site.data.keyword.cloud_notm}} mettant en évidence la version syndiquée {{site.data.keyword.cloud_notm}} public de {{site.data.keyword.cloudant_short_notm}} (à gauche) et l'environnement {{site.data.keyword.cloudant_short_notm}} dédié (à droite).  

![Catalogue {{site.data.keyword.cloudant_short_notm}}](../images/bluemix_catalog.png)

## Capacité matérielle 

{{site.data.keyword.cloudant_short_notm}} dans {{site.data.keyword.cloud_notm}} dédié est acheté via un composant '{{site.data.keyword.cloud_notm}} Dedicated {{site.data.keyword.cloudant_short_notm}} 1.6 TB Capacity', qui comprend un environnement en cluster {{site.data.keyword.cloudant_short_notm}} composé de trois noeuds de base de données et de deux équilibreurs de charge. Chaque noeud de base de données contient 1,6 To sur les disques SSD, et comme toutes les données sont stockées en triple, cela équivaut à 1,6 To d'espace disque unique sur le cluster. Vous pouvez étendre un environnement en achetant des composants '{{site.data.keyword.cloud_notm}} Dedicated {{site.data.keyword.cloudant_short_notm}} 1.6TB Capacity' supplémentaires, que vous pouvez utiliser pour développer le cluster {{site.data.keyword.cloudant_short_notm}} en multiples de trois noeuds de base de données. Les clients peuvent également choisir d'avoir plusieurs environnements {{site.data.keyword.cloudant_short_notm}} distincts plutôt que d'étendre un seul environnement.

## Emplacements et service 

L'environnement {{site.data.keyword.cloudant_short_notm}} dédié dans un environnement {{site.data.keyword.cloud_notm}} dédié se trouve sur un matériel désigné pour une utilisation exclusive par le client {{site.data.keyword.cloud_notm}} dédié. Le client peut mettre à disposition une ou plusieurs instances de {{site.data.keyword.cloudant_short_notm}} sur l'environnement donné, et chaque instance de {{site.data.keyword.cloudant_short_notm}} partage les ressources matérielles sous-jacentes qui composent l'environnement {{site.data.keyword.cloudant_short_notm}}. 

## Sécurité, chiffrement et conformité 

Tous les plans sont fournis sur des serveurs dotés d'un chiffrement de disque [ au repos ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://en.wikipedia.org/wiki/Data_at_rest). L'accès est établi sur la connexion au réseau public et chiffré à l'aide du protocole HTTPS. Pour plus de détails, voir [Sécurité ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](../offerings/security.html#security){:new_window}. 
Une liste blanche des adresses IP est disponible sur demande auprès du support {{site.data.keyword.cloudant_short_notm}} et s'applique à la totalité de l'environnement {{site.data.keyword.cloudant_short_notm}} et non au niveau de l'instance. 

Si vous avez besoin du mode de chiffrement BYOK (bring-your-own-key) pour les données au repos, il est activé à l'aide de {{site.data.keyword.cloud}} Key
Protect. {{site.data.keyword.cloudant_short_notm}} prend en charge cette fonction pour les nouvelles instances de [plan matériel dédié](https://console.bluemix.net/docs/services/Cloudant/offerings/bluemix.html#ibm-cloud-public) {{site.data.keyword.cloudant_short_notm}} déployées dans toutes les régions.
Tout d'abord, créez une instance du plan matériel dédié à l'aide du [catalogue {{site.data.keyword.cloud_notm}}](https://console.bluemix.net/catalog/). Soumettez ensuite un ticket de demande de service. Notre équipe de support se chargera d'obtenir les clés de chiffrement des données au repos de votre nouvelle instance de matériel dédié qui sont gérées par votre instance Key Protect.  

Le plan offre également une [Certification de conformité à la sécurité ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://console.bluemix.net/docs/services/Cloudant/offerings/compliance.html#cloudant-security-compliance){:new_window}. 

La conformité [HIPAA ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){:new_window} est disponible sur demande, demandez-la lors du processus d'achat avec votre ingénieur commercial {{site.data.keyword.IBM_notm}}. 

## Haute disponibilité, reprise après incident et sauvegarde 

Dans le but de fournir la haute disponibilité et la reprise après incident au sein d'un centre de données, toutes les données sont stockées en trois exemplaires sur trois serveurs physiques distincts d'un cluster. Lorsqu'ils sont disponibles, vous pouvez mettre à disposition des comptes dans plusieurs emplacements, puis faire appel à la réplication de données en continu pour fournir les fonctions de haute disponibilité et de reprise après incident sur ces différents centres de données. Les données {{site.data.keyword.cloudant_short_notm}} ne sont pas automatiquement sauvegardées, mais des outils pris en charge sont fournis pour gérer les sauvegardes. Consultez le guide [Reprise après incident et sauvegarde ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://console.bluemix.net/docs/services/Cloudant/guides/disaster-recovery-and-backup.html#disaster-recovery-and-backup){:new_window} pour explorer toutes les considérations relatives à la haute disponibilité, à la reprise après sinistre et à la sauvegarde afin de répondre aux exigences de votre application.
