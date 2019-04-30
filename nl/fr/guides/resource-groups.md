---

copyright:
  years: 2015, 2019
lastupdated: "2019-02-27"

keywords: migrate to a resource group, downtime, migrate existing instance, organization and space, standard plan, dedicated hardware instance, how to migrate

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

# Comment {{site.data.keyword.cloudant_short_notm}} fonctionne-t-il avec les groupes de ressources {{site.data.keyword.cloud_notm}} ?
{: #how-does-ibm-cloudant-work-with-ibm-cloud-resource-groups-}

Depuis le 16 juillet 2018, les nouvelles instances de ressources {{site.data.keyword.cloudantfull}} sont mises à disposition par groupes de ressources, et non par espaces Cloud Foundry. Ce document répond aux questions communes que le support de {{site.data.keyword.cloudant_short_notm}} a reçues au sujet de cette transition.

## Comment puis-je faire migrer une instance existante vers un groupe de ressources ?
{: #how-do-i-migrate-an-existing-instance-to-a-resource-group-}

Pour faire migrer une instance {{site.data.keyword.cloudant_short_notm}} d'un espace Cloud Foundry à un groupe de ressources, reportez-vous à la section [Migrating Cloud Foundry service instances and apps to a resource group](https://cloud.ibm.com/docs/resources/instance_migration.html#migrate){: new_window}.

Vous pouvez faire migrer des instances {{site.data.keyword.cloudant_short_notm}} sur les plans suivants :

- Lite
- Standard
- Dedicated Hardware

## Quel est le temps d'arrêt à prévoir lors de la migration d'une instance vers un groupe de ressources ?
{: #how-much-downtime-occurs-when-you-migrate-an-instance-to-a-resource-group-}

Le processus de migration n'entraîne aucun temps d'arrêt.

## Pourquoi certaines instances ont-elles une organisation et un espace et d'autres pas ?
{: #why-do-some-instances-have-an-organisation-and-space-and-others-do-not-}

Depuis le 16 juillet 2018, les nouvelles instances sont mises à disposition par groupes de ressources, et non par espaces Cloud Foundry. Les instances de ressources mises à disposition avant cette date ont une organisation et un espace Cloud Foundry associés. Les instances mises à disposition après cette date sont associées à un groupe de ressources à la place.

## Pourquoi ne puis-je pas recevoir de nouvelles instances de plan Standard sur mes instances Dedicated Hardware ?
{: #why-can-t-i-create-new-standard-plan-instances-on-my-dedicated-hardware-instances-}

Les nouvelles instances du plan Standard sont mises à disposition en groupes de ressources. Afin de mettre à disposition ces instances sur une instance Dedicated Hardware, l'instance Dedicated Hardware doit d'abord être migrée vers un groupe de ressources.

Pour en savoir plus sur la façon de procéder, voir [Migrating Cloud Foundry service instances and apps to a resource group](https://cloud.ibm.com/docs/resources/instance_migration.html#migrate){: new_window}.

Une fois que l'instance Dedicated Hardware été migrée vers un groupe de ressources, elle apparaît dans le menu déroulant Emplacement lors de la mise à disposition des plans Standard.

## Comment dois-je faire migrer mes instances Dedicated Hardware et les instances du plan Standard hébergées sur elles ?
{: #how-should-i-migrate-my-dedicated-hardware-instances-and-the-standard-plan-instances-hosted-on-them-}

En théorie, les instances peuvent être migrées vers des groupes de ressources dans n'importe quel ordre. Dans la pratique, nous recommandons l'ordre suivant pour les instances Dedicated Hardware et les instances du plan Standard hébergées sur elles :

1. Migrer les instances Dedicated Hardware vers un groupe de ressources. Ceci permet de créer des nouvelles instances du plan Standard sur Dedicated Hardware.
2. Migrer les instances Standard.

Les instances du plan Lite et du plan Standard non hébergées sur Dedicated Hardware peuvent être migrées à tout moment.
{: tip}
