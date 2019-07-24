---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: links to documentation, how to contribute

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

<!-- Acrolinx: 2018-06-01 -->

# Présentation
{: #overview}

La documentation en ligne de {{site.data.keyword.cloudantfull}} a pour but de vous aider à vous familiariser rapidement. Pour plus d'informations sur {{site.data.keyword.cloudant_short_notm}}, voir la page produit [{{site.data.keyword.cloudant_short_notm}} ![Icône de lien externe](images/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/cloud/cloudant){: new_window}.
{: shortdesc}

[{{site.data.keyword.cloudant_short_notm}} ![Icône de lien externe](images/launch-glyph.svg "Icône de lien externe")](https://www.youtube.com/watch?v=qdMTLK2vYoI){: new_window}
est une DBaaS (database as a service) orientée document
qui stocke les données en tant que documents JSON.
Elle a été conçue afin d'être évolutive, hautement disponible et durable.
Elle est fournie avec un large éventail d'options d'indexation telles que MapReduce, {{site.data.keyword.cloudantfull}} Query, la recherche en texte intégral et le traitement des données géospatiales.
Ses fonctions de réplication facilitent la synchronisation des données entre les clusters de base de données, les ordinateurs de bureau et les périphériques
mobiles.

Pour plus d'informations sur les autres offres de {{site.data.keyword.cloudant_short_notm}}, consultez le site officiel de [{{site.data.keyword.cloudant_short_notm}} ![Icône de lien externe](images/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/cloud/cloudant){: new_window}.
La présente documentation en ligne fournit des détails sur les concepts, les tâches et les techniques de {{site.data.keyword.cloudant_short_notm}}.

Vous pouvez démarrer le service {{site.data.keyword.cloudant_short_notm}} à partir du tableau de bord [{{site.data.keyword.cloud}} ![Icône de lien externe](images/launch-glyph.svg "Icône de lien externe")](https://cloud.ibm.com/catalog/services/cloudant){: new_window}.

Un tutoriel rapide pour commencer à utiliser {{site.data.keyword.cloudant_short_notm}}, appelé [Tutoriel de mise en route](/docs/services/Cloudant?topic=cloudant-getting-started#getting-started), est disponible, ainsi que des [tutoriels](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-an-ibm-cloudant-instance-on-ibm-cloud) décrivant les tâches plus en détail. Vous trouverez davantage d'informations sur des détails, tels que l'authentification auprès d'instances de base de données ou l'interrogation de données, dans [Référence d'API](/docs/services/Cloudant?topic=cloudant-api-reference-overview#api-reference-overview).

## Contenu de la documentation
{: #documentation-contents}

*	[Tutoriel de mise en route](/docs/services/Cloudant?topic=cloudant-getting-started#getting-started) : montre comment créer une base de données {{site.data.keyword.cloudantfull}} et remplir cette base de données avec une simple collection de données à l'aide de Python.
*	[Blogue{{site.data.keyword.cloudant_short_notm}} ![Icône de lien externe](images/launch-glyph.svg "Icône de lien externe")](https://blog.cloudant.com/) : des blogues sont disponibles sur de nombreux sujets, incluant les fondamentaux {{site.data.keyword.cloudant_short_notm}}, le retrait des conflits, la génération de données exemple, les bases de données partitionnées, et plus encore. 
*	[{{site.data.keyword.cloud_notm}} public](/docs/services/Cloudant?topic=cloudant-ibm-cloud-public#ibm-cloud-public) : description de l'offre {{site.data.keyword.cloud_notm}} publique, y compris les fonctions, l'option et la tarification. 
*	[Tarification](/docs/services/Cloudant?topic=cloudant-pricing#pricing) : article qui décrit les options et la flexibilité disponibles avec le modèle de tarification {{site.data.keyword.cloudant_short_notm}}. 
*	[Sécurité et conformité](/docs/services/Cloudant?topic=cloudant-security#security) : ensemble d'articles qui décrivent la position {{site.data.keyword.cloudant_short_notm}} en matière de sécurité, conformité, confidentialité de données et gouvernance, consignation dans le journal d'audit et RGPD (Règlement général sur la protection des données).
*	[Informations sur l'édition](/docs/services/Cloudant?topic=cloudant-release-notes#release-notes) : informations relatives à l'édition incluant des notes sur l'édition, ce qui a changé entre les éditions majeures et les obsolescences. 
*	[Autres offres](/docs/services/Cloudant?topic=cloudant-ibm-cloud-dedicated#ibm-cloud-dedicated) : outre {{site.data.keyword.cloud_notm}} public, {{site.data.keyword.cloudant_short_notm}} est disponible dans différentes offres, toutes décrites ici.
* [Tutoriels](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-an-ibm-cloudant-instance-on-ibm-cloud) : collection d'articles détaillés, expliquant comment effectuer des tâches essentielles à l'aide de {{site.data.keyword.cloudant_short_notm}} sur {{site.data.keyword.cloud_notm}}.
*	[Guides](/docs/services/Cloudant?topic=cloudant-authorized-curl-acurl-#authorized-curl-acurl-) : guides détaillés sur les cas d'utilisation et d'autres activités et problèmes plus complexes.
	Les guides explorent également certains des concepts importantes derrière les mécanismes d'une base de données {{site.data.keyword.cloudant_short_notm}}.
*	[{{site.data.keyword.cloudant_short_notm}} de base](/docs/services/Cloudant?topic=cloudant-ibm-cloudant-basics#ibm-cloudant-basics) : si vous n'avez jamais utilisé {{site.data.keyword.cloudant_short_notm}} ni de bases de données NoSQL en général, parcourez cette rapide présentation des notions de base avant d'aller plus loin.
	Cette présentation décrit les choses les plus importantes à connaître au sujet de {{site.data.keyword.cloudant_short_notm}}.
	Le reste de la documentation part du principe que vous connaissez ces notions de base.
*	[Référence d'API {{site.data.keyword.cloudant_short_notm}} ](/docs/services/Cloudant?topic=cloudant-api-reference-overview#api-reference-overview) : la référence d'API représente un catalogue complet des différentes fonctionnalités de {{site.data.keyword.cloudant_short_notm}}.
	Vous y trouverez des informations détaillées sur les actions que vous pouvez réaliser avec {{site.data.keyword.cloudant_short_notm}}.
*	Exemples d'application : Offline First shopping list, Open Fridge, iOS game with Core ML and Watson Visual Recognition et Mobile health app with Watson Studio. 
*	[Bibliothèques client](/docs/services/Cloudant?topic=cloudant-client-libraries#client-libraries) : les bibliothèques client sont des kits d'outils qui vous permettent de développer vos propres applications pour utiliser les bases de données {{site.data.keyword.cloudant_short_notm}}.


## Contribution
{: #contribute}

{{site.data.keyword.cloudant_short_notm}} s'appuie sur les technologies open source les plus élaborées et nous nous engageons dans la technologie que nous utilisons.
Nous accordons également une grande importance à la documentation.
Si vous n'en êtes pas satisfait, nous ne le serons pas non plus.
N'hésitez pas à nous faire part de vos commentaires ou suggestions sur le site {{site.data.keyword.cloudant_short_notm}} Labs sur la page [GitHub ![Icône de lien externe](images/launch-glyph.svg "Icône de lien externe")](https://github.com/cloudant-labs/slate){: new_window}.
