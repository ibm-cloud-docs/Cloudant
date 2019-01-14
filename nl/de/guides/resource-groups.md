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

# Wie arbeitet {{site.data.keyword.cloudant_short_notm}} mit {{site.data.keyword.cloud_notm}}-Ressourcengruppen?

Seit dem 16. Juli 2018 werden neue {{site.data.keyword.cloudantfull}}-Ressourceninstanzen in Ressourcengruppen und nicht mehr in Cloud Foundry-Bereichen
bereitgestellt. Im vorliegenden Dokument werden die allgemeinen Fragen behandelt, die
der {{site.data.keyword.cloudant_short_notm}}-Support zu dieser Umstellung erhalten hat.

## Wie kann ich eine vorhandene Instanz auf eine Ressourcengruppe migrieren?

Zur Migration einer {{site.data.keyword.cloudant_short_notm}}-Instanz von einem Cloud Foundry-Bereich auf eine Ressourcengruppe sollten Sie die Informationen im Abschnitt zur [Migration von Cloud Foundry-Serviceinstanzen und -Apps auf eine Ressourcengruppe](https://console.bluemix.net/docs/resources/instance_migration.html#migrate){:new_window} lesen.

Sie können {{site.data.keyword.cloudant_short_notm}}-Instanzen für die folgenden Pläne migrieren:

- Lite
- Standard
- Dedizierte Hardware

## Wie viele Ausfallzeiten entstehen bei der Migration einer Instanz auf eine Ressourcengruppe?

Während des Migrationsprozesses treten keine Ausfallzeiten auf.

## Warum verfügen bestimmte Instanzen über eine Organisation und einen Bereich, andere hingegen nicht?

Seit dem 16. Juli 2018 werden neue Instanzen in Ressourcengruppen und nicht mehr in Cloud Foundry-Bereichen
bereitgestellt. Ressourceninstanzen, die vor diesem Datum bereitgestellt wurden, verfügen über
eine zugehörige Cloud Foundry-Organisation und einen entsprechenden Bereich. Instanzen, die nach diesem Datum bereitgestellt wurden, werden stattdessen einer Ressourcengruppe zugeordnet.

## Warum kann ich keine neuen Standard-Plan-Instanzen auf meinen Instanzen für dedizierte Hardware erstellen?

Neue Standard-Plan-Instanzen werden in Ressourcengruppen bereitgestellt. Zur Bereitstellung dieser Instanzen auf einer Instanz für dedizierte Hardware muss die Instanz für dedizierte Hardware zuerst in eine Ressourcengruppe migriert werden.

Weitere Informationen zu diesem Arbeitsschritt finden Sie im Abschnitt zur [Migration von Cloud Foundry-Serviceinstanzen und -Apps auf eine Ressourcengruppe](https://console.bluemix.net/docs/resources/instance_migration.html#migrate){:new_window}.

Nachdem die Instanz für dedizierte Hardware auf eine Ressourcengruppe migriert wurde, wird sie im Dropdown-Menü des Standorts angezeigt, wenn Standard-Pläne bereitgestellt
werden.

## Wie kann ich meine Instanzen für dedizierte Hardware und die darauf gehosteten Standard-Plan-Instanzen migrieren?

Theoretisch können Instanzen in beliebiger Reihenfolge auf Ressourcengruppen migriert werden. In der Praxis wird jedoch empfohlen, die Instanzen für dedizierte Hardware und die darauf gehosteten Standard-Plan-Instanzen in der folgenden Reihenfolge zu migrieren:

1. Migrieren Sie die Instanzen für dedizierte Hardware auf eine Ressourcengruppe. Dadurch können auf der dedizierten Hardware neue Standard-Plan-Instanzen erstellt werden.
2. Migrieren Sie die Standard-Instanzen.

Lite-Plan-Instanzen und Standard-Plan-Instanzen, die nicht auf dedizierter Hardware gehostet werden, können jederzeit migriert
werden.
{: tip}
