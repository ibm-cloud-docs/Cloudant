---

copyright:
  years: 2017, 2019
lastupdated: "2019-06-12"

keywords: create database, create api key for replication, grant access permission, set up replications, test replication, configure application, active-active configuration, active-passive configuration, fail over, recovering from fail over

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

# Configuration de {{site.data.keyword.cloudant_short_notm}} pour la reprise après incident interrégionale
{: #configuring-ibm-cloudant-for-cross-region-disaster-recovery}

Le [guide de reprise après incident de {{site.data.keyword.cloudant_short_notm}} ](/docs/services/Cloudant?topic=cloudant-disaster-recovery-and-backup#disaster-recovery-and-backup) explique que l'une des façons d'activer la reprise après incident consiste à utiliser la réplication {{site.data.keyword.cloudantfull}} afin de créer une redondance au niveau de plusieurs régions.

Vous pouvez configurer la réplication dans {{site.data.keyword.cloudant_short_notm}} à l'aide d'une topologie 'active-active'
ou 'active-passive' selon les centres de données.

Le diagramme ci-dessous illustre une configuration type qui fait appel
à deux comptes {{site.data.keyword.cloudant_short_notm}},
un dans chaque région :

![Exemple d'architecture active-active](../images/active-active.png)

Informations importantes :

* Au sein de chaque centre de données,
  {{site.data.keyword.cloudant_short_notm}} offre déjà une haute disponibilité
  en stockant les données en trois exemplaires dans trois serveurs différents.
* La réplication a lieu au niveau de la base de données et non au niveau du compte,
  et doit être configurée de manière explicite.
* {{site.data.keyword.cloudant_short_notm}} ne fournit pas d'accords sur les niveaux de licence
  ni aucune certitude sur le temps d'attente de réplication.
* {{site.data.keyword.cloudant_short_notm}} ne surveille pas les réplications individuelles.
  Nous vous recommandons de surveiller vous-même les réplications qui ont échoué et de les redémarrer le cas échéant.

## Avant de commencer un déploiement actif-actif
{: #before-you-begin-an-active-active-deployment}

Pour un déploiement actif-actif, une stratégie de gestion des conflits doit être mise en place. Par conséquent, assurez-vous de comprendre parfaitement comment fonctionne la [réplication](/docs/services/Cloudant?topic=cloudant-replication-api#replication-api) et les [conflits](/docs/services/Cloudant?topic=cloudant-document-versioning-and-mvcc#document-versioning-and-mvcc) avant d'envisager cette architecture.
{: note}

Contactez le support technique de [{{site.data.keyword.cloudant_short_notm}} ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](mailto:support@cloudant.com){: new_window} si vous avez besoin d'aide pour modéliser les données afin de gérer efficacement les conflits.

## Présentation
{: #overview-active-active}

La présente documentation explique comment créer une réplication bidirectionnelle.
Cette configuration permet à deux bases de données de fonctionner dans une topologie active-active.

La configuration présuppose que vous possédez deux comptes dans des régions différentes :

* `myaccount-dc1.cloudant.com`
* `myaccount-dc2.cloudant.com`

Une fois ces deux comptes mis en place, les principales étapes à effectuer sont les suivantes :

1. [Création](#step-1-create-your-databases) d'une paire de bases de données d'homologues dans les comptes
2. [Définition](#step-2-create-an-api-key-for-your-replications) des clés d'API à utiliser pour la réplication entre ces bases de données
3. Octroi des droits appropriés
4. Configuration des réplications
5. Vérification du bon fonctionnement des réplications
6. Configuration de l'application et de l'infrastructure à des fins d'utilisation active-active ou active-passive des bases de données

## Etape 1 : Création de vos bases de données
{: #step-1-create-your-databases}

[Créez les bases de données](/docs/services/Cloudant?topic=cloudant-databases#create-database) que vous voulez répliquer entre chaque compte.

Dans l'exemple ci-dessous, une base de données appelée `mydb` est créée.

Bien que les noms de bases de données utilisés dans cet exemple ne soient pas importants, l'utilisation d'un même nom est plus simple.

```sh
curl https://myaccount-dc1.cloudant.com/mydb -XPUT -u myaccount-dc1
curl https://myaccount-dc2.cloudant.com/mydb -XPUT -u myaccount-dc2
```
{: codeblock}

## Etape 2 : Création d'une clé d'API pour vos réplications
{: #step-2-create-an-api-key-for-your-replications}

Il est intéressant d'utiliser une [clé d'API](/docs/services/Cloudant?topic=cloudant-authorization#api-keys) pour les réplications continues.
En effet, si les détails de votre compte principal changent, en raison par exemple d'une réinitialisation de mot de passe, vos réplications peuvent rester inchangées.

Les clés d'API ne sont pas liées à un seul compte.
Autrement dit, vous pouvez créer une clé d'API unique, puis lui accorder les droits de base de données appropriés pour les deux comptes.

Par exemple, la commande ci-dessous requiert une clé d'API pour le compte `myaccount-dc1` :

```sh
$ curl -XPOST https://myaccount-dc1.cloudant.com/_api/v2/api_keys -u myaccount-dc1
```
{: codeblock}

Une réponse positive est similaire à l'exemple abrégé ci-dessous :

```json
{
  "password": "YPN...Tfi",
  "ok": true,
  "key": "ble...igl"
}
```
{: codeblock}

Notez soigneusement le mot de passe. Il est en effet impossible de le récupérer ultérieurement.
{: important}

## Etape 3 : Octroi des droits d'accès
{: #step-3-grant-access-permission}

Accordez à la clé d'API un [droit d'accès](/docs/services/Cloudant?topic=cloudant-authorization#modifying-permissions) en lecture et en écriture sur les deux bases de données.

Si vous voulez également répliquer les index, attribuez des droits d'administration.

Utilisez le tableau de bord de {{site.data.keyword.cloudant_short_notm}} ou consultez les informations d'[autorisation](/docs/services/Cloudant?topic=cloudant-authorization#authorization) pour savoir comment accorder les droits à l'aide d'un programme.

## Etape 4 : Configuration des réplications
{: #step-4-set-up-replications}

Dans {{site.data.keyword.cloudant_short_notm}}, les réplications sont toujours unidirectionnelles :
d'une base de données vers une autre.
Par conséquent, si vous souhaitez effectuer des réplications bidirectionnelles entre deux bases de données, deux réplications sont nécessaires, une pour chaque direction.

Une réplication est créée dans chaque compte, utilisant la clé d'API créée [précédemment](#step-2-create-an-api-key-for-your-replications).

Tout d'abord, créez une réplication de la base de données `myaccount-dc1.cloudant.com/mydb` vers la base de données `myaccount-dc2.cloudant.com/mydb`.

```sh
curl -XPOST 'https://myaccount-dc1.cloudant.com/_replicator'
	-u myaccount-dc1
	-H 'Content-type: application/json'
	-d '{ "_id": "mydb-myaccount-dc1-to-myaccount-dc2",
	"source": "https://ble...igl:YPN...Tfi@myaccount-dc1.cloudant.com/mydb",
	"target": "https://ble...igl:YPN...Tfi@myaccount-dc2.cloudant.com/mydb",
	"continuous": true
}'
```
{: codeblock}

Ensuite, créez une réplication de la base de données `myaccount-dc2.cloudant.com/mydb` vers la base de données `myaccount-dc1.cloudant.com/mydb`.

```sh
curl -XPOST 'https://myaccount-dc2.cloudant.com/_replicator'
	-u myaccount-dc2
	-H 'Content-type: application/json'
	-d '{ "_id": "mydb-myaccount-dc2-to-myaccount-dc1",
	"source": "https://ble...igl:YPN...Tfi@myaccount-dc2.cloudant.com/mydb",
	"target": "https://ble...igl:YPN...Tfi@myaccount-dc1.cloudant.com/mydb",
	"continuous": true
}'
```
{: codeblock}

Si cette étape échoue car la base de données `_replicator`  n'existe pas, créez-la.
{: note}

## Etape 5 : Vérification de votre réplication
{: #step-5-test-your-replication}

Testez les processus de réplication en créant, modifiant et supprimant des documents dans l'une ou l'autre base de données.

Chaque fois qu'une modification est apportée dans une base de données, vérifiez que celle-ci se reflète au niveau de l'autre base de données.

## Etape 6 : Configuration de votre application
{: #step-6-configure-your-application}

A ce stade, les bases de données sont configurées pour rester synchronisées.

Il s'agit ensuite de décider si vous voulez utiliser les bases de données de manière [active-active](#active-active) ou [active-passive](#active-passive).

### Active-active 
{: #active-active}

Dans une configuration active-active, différentes instances d'application peuvent écrire dans différentes bases de données.

Par exemple, l'application 'A' peut écrire dans la base de données `myaccount-dc1.cloudant.com/mydb`, tandis que l'application 'B' peut écrire dans la base de données `myaccount-dc2.cloudant.com/mydb`.

Cette configuration offre plusieurs avantages :

- Le chargement peut être réparti sur plusieurs comptes.
- Les applications peuvent être configurées pour accéder à un compte avec un temps d'attente inférieur (pas forcément le compte le plus proche géographiquement).

Une application peut être configurée pour communiquer avec le compte {{site.data.keyword.cloudant_short_notm}} le "plus proche".
Pour les applications hébergées dans le centre de données DC1, définissez leur URL {{site.data.keyword.cloudant_short_notm}} sur `"https://myaccount-dc1.cloudant.com/mydb"`.
De même, pour les applications hébergées dans le centre de données DC2, définissez leur URL {{site.data.keyword.cloudant_short_notm}} sur `"https://myaccount-dc2.cloudant.com/mydb"`.

### Active-passive
{: #active-passive}

Dans une configuration active-passive, toutes les instances d'une application sont configurées pour utiliser une base de données principale.
Toutefois, l'application peut basculer vers la base de données de sauvegarde secondaire, en cas de nécessité.
Le basculement peut être implémenté dans la logique d'application elle-même, par le biais d'un équilibreur de charge ou à l'aide de tout autre moyen.

Un test simple permettant de déterminer si le basculement est requis consiste à utiliser le noeud final de la base de données principale comme "pulsation".
Par exemple, une simple demande `GET` envoyée au noeud final de la base de données principale doit normalement renvoyer des [détails sur la base de données](/docs/services/Cloudant?topic=cloudant-databases#getting-database-details).
Si aucune réponse n'est reçue, un basculement peut s'avérer nécessaire.

### Autres configurations
{: #other-configurations}

Vous pouvez envisager d'autres approches hybrides pour votre configuration.

Par exemple, dans une configuration de type 'Write-Primary, Read-Replica', toutes les écritures sont stockées dans l'une des bases de données, mais la charge de lecture est répartie entre les répliques.

## Etapes 7 : Etapes suivantes
{: #step-7-next-steps}

* Envisagez la surveillance des [réplications](/docs/services/Cloudant?topic=cloudant-advanced-replication#advanced-replication) entre les bases de données.
  Appuyez-vous sur les données pour déterminer si votre configuration peut être encore optimisée.
*	Examinez la façon dont vos documents de conception et index sont déployés et mis à jour.
  Il peut être plus efficace d'automatiser ces tâches.

## Basculement entre les régions {{site.data.keyword.cloudant_short_notm}}
{: #failing-over-between-ibm-cloudant-regions}

En règle générale, le processus de gestion d'un basculement entre les régions ou les centres de données est géré à un niveau supérieur au sein de votre liste d'applications, par exemple en configurant les changements de basculement de serveur d'application ou en équilibrant la charge.

{{site.data.keyword.cloudant_short_notm}} ne fournit pas d'installation permettant de gérer explicitement les basculements ou de réacheminer les demandes entre les régions.
Cette contrainte est liée en partie à des raisons techniques et en partie au fait que les conditions dans lesquelles le basculement peut avoir lieu ont tendance à être propres à l'application.
Par exemple, vous souhaitez peut-être forcer un basculement en réponse à un attribut de performance personnalisé.

Toutefois, si vous avez besoin de gérer les basculements, les options possibles sont les suivantes :

* Placez votre propre [proxy HTTP devant {{site.data.keyword.cloudant_short_notm}} ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/greenmangaming/cloudant-nginx){: new_window}.
  Configurez votre application de sorte qu'elle communique avec le proxy plutôt qu'avec l'instance {{site.data.keyword.cloudant_short_notm}}.
  Cette configuration indique que la tâche de modification des instances {{site.data.keyword.cloudant_short_notm}} utilisées par les applications peut être gérée via une modification apportée à la configuration du proxy plutôt qu'aux paramètres de l'application.
  Un grand nombre de proxys sont capables d'équilibrer la charge en fonction des diagnostics d'intégrité définis par l'utilisateur.
* Utilisez un équilibreur de charge tel que [{{site.data.keyword.cloud}} Internet Services ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](/docs/infrastructure/cis?topic=cis-global-load-balancer-glb-concepts#global-load-balancer-glb-concepts){: new_window} ou [Dyn Traffic Director ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](http://dyn.com/traffic-director/){: new_window} pour procéder au routage vers {{site.data.keyword.cloudant_short_notm}}.
  Cette option requiert une définition `CNAME` qui achemine vers différents comptes {{site.data.keyword.cloudant_short_notm}}, en fonction d'un diagnostic d'intégrité ou d'une règle de temps d'attente.


## Reprise sur basculement
{: #recovering-from-fail-over}

Si une seule instance {{site.data.keyword.cloudant_short_notm}} est joignable, évitez de réacheminer le trafic dès qu'il est de nouveau accessible.
La raison est qu'un certain temps est nécessaire pour les tâches intensives, telles que la synchronisation de l'état de la base de données à partir d'un homologue, ou la vérification de la mise à jour des index.

Il est utile de disposer d'un mécanisme de surveillance des tâches afin de décider à quel moment l'état de la base de données est approprié pour gérer votre trafic de production.

Par exemple, une liste de vérifications standard incluent les éléments suivants :

* [Réplications](#replications)
* [Index](#indexes)

Si vous implémentez le réacheminement ou le basculement suite à un test d'intégrité, vous pouvez ajouter les vérifications correspondantes afin d'éviter des réacheminements prématurés vers une instance de service toujours en cours de récupération.
{: note}

### Réplications
{: #replications}

* Certaines réplications ont-elles un état d'erreur ?
* Certaines réplications nécessitent-elles un redémarrage ?
* Combien de changements en attente sont encore en attente de réplication dans la base de données ?

Vous pouvez obtenir plus de renseignements sur la [surveillance de le statut de réplication](/docs/services/Cloudant?topic=cloudant-advanced-replication#replication-status).

Si une base de données reçoit sans cesse des modifications, il est peu probable que le statut de réplication soit à 0. Vous devez décider du seuil de statut acceptable ou représentant un état d'erreur.
{: note}

### Index
{: #indexes}

* Les index sont-ils suffisamment à jour ?
  Vérifiez-les en utilisant le noeud final des [tâches actives](/docs/services/Cloudant?topic=cloudant-active-tasks#active-tasks).
* Testez le niveau de "réactivité des index" en envoyant une demande à l'index et en décidant si le délai de réponse est acceptable ou non.
