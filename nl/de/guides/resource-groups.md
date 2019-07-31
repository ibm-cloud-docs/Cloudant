---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

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

# Wie arbeitet {{site.data.keyword.cloudant_short_notm}} mit {{site.data.keyword.cloud_notm}}-Ressourcengruppen?
{: #how-does-ibm-cloudant-work-with-ibm-cloud-resource-groups-}

Seit dem 16. Juli 2018 werden neue {{site.data.keyword.cloudantfull}}-Ressourceninstanzen in Ressourcengruppen und nicht mehr in Cloud Foundry-Bereichen
bereitgestellt. Im vorliegenden Dokument werden die allgemeinen Fragen behandelt, die
der {{site.data.keyword.cloudant_short_notm}}-Support zu dieser Umstellung erhalten hat.

## Wie kann ich eine vorhandene Instanz auf eine Ressourcengruppe migrieren?
{: #how-do-i-migrate-an-existing-instance-to-a-resource-group-}

Zur Migration einer {{site.data.keyword.cloudant_short_notm}}-Instanz aus einem Cloud Foundry-Bereich in eine Ressourcengruppe sollten Sie die Informationen unter [Cloud Foundry-Serviceinstanzen und -Apps in eine Ressourcengruppe migrieren ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://cloud.ibm.com/docs/resources/instance_migration.html#migrate){: new_window} lesen. 

Sie können {{site.data.keyword.cloudant_short_notm}}-Instanzen für die folgenden Pläne migrieren:

- Lite
- Standard
- Dedizierte Hardware

## Wie viele Ausfallzeiten entstehen bei der Migration einer Instanz auf eine Ressourcengruppe?
{: #how-much-downtime-occurs-when-you-migrate-an-instance-to-a-resource-group-}

Während des Migrationsprozesses treten keine Ausfallzeiten auf.

## Warum verfügen bestimmte Instanzen über eine Organisation und einen Bereich, andere hingegen nicht?
{: #why-do-some-instances-have-an-organization-and-space-and-others-do-not-}

Seit dem 16. Juli 2018 werden neue Instanzen in Ressourcengruppen und nicht mehr in Cloud Foundry-Bereichen
bereitgestellt. Ressourceninstanzen, die vor diesem Datum bereitgestellt wurden, verfügen über
eine zugehörige Cloud Foundry-Organisation und einen entsprechenden Bereich. Instanzen, die nach diesem Datum bereitgestellt wurden, werden stattdessen einer Ressourcengruppe zugeordnet.

## Warum kann ich keine neuen Standard-Plan-Instanzen auf meinen Instanzen für dedizierte Hardware erstellen?
{: #why-can-t-i-create-new-standard-plan-instances-on-my-dedicated-hardware-instances-}

Neue Standard-Plan-Instanzen werden in Ressourcengruppen bereitgestellt. Zur Bereitstellung dieser Instanzen auf einer Instanz für dedizierte Hardware muss die Instanz für dedizierte Hardware zuerst in eine Ressourcengruppe migriert werden.

Weitere Informationen zu diesem Arbeitsschritt finden Sie unter [Cloud Foundry-Serviceinstanzen und -Apps in eine Ressourcengruppe migrieren ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://cloud.ibm.com/docs/resources/instance_migration.html#migrate){: new_window}. 

Nachdem die Instanz für dedizierte Hardware auf eine Ressourcengruppe migriert wurde, wird sie im Dropdown-Menü des Standorts angezeigt, wenn Standard-Pläne bereitgestellt
werden.

## Wie kann ich meine Instanzen für dedizierte Hardware und die darauf gehosteten Standard-Plan-Instanzen migrieren?
{: #how-should-i-migrate-my-dedicated-hardware-instances-and-the-standard-plan-instances-hosted-on-them-}

Theoretisch können Instanzen in beliebiger Reihenfolge auf Ressourcengruppen migriert werden. In der Praxis wird jedoch empfohlen, die Instanzen für dedizierte Hardware und die darauf gehosteten Standard-Plan-Instanzen in der folgenden Reihenfolge zu migrieren:

1. Migrieren Sie die Instanzen für dedizierte Hardware auf eine Ressourcengruppe. Dadurch können auf der dedizierten Hardware neue Standard-Plan-Instanzen erstellt werden.
2. Migrieren Sie die Standard-Instanzen.

Lite-Plan-Instanzen und Standard-Plan-Instanzen, die nicht auf dedizierter Hardware gehostet werden, können jederzeit migriert
werden.
{: tip}
