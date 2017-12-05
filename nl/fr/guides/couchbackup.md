---

copyright:
  years: 2017
lastupdated: "2017-05-02"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-05-02 -->

# Sauvegarde de vos données à l'aide de CouchBackup

Le caractère distribué de {{site.data.keyword.cloudant}} fournit une forme inhérente de sauvegarde de données.
CouchBackup est un outil de ligne de commande qui fournit une nouvelle approche de sauvegarde plus flexible et plus puissante.
{:shortdesc}

## Aperçu

Les avantages liés à la distribution de {{site.data.keyword.cloudant_short_notm}} sont obtenus en utilisant des clusters.
Dans un cluster, les données d'une base de données sont stockées dans plusieurs exemplaires.
Ces copies sont réparties dans au moins trois serveurs physiques distincts.
L'utilisation de clusters à des fins de stockage de données garantit haute disponibilité et reprise après incident à {{site.data.keyword.cloudant_short_notm}}.
Elle aide {{site.data.keyword.cloudant_short_notm}} à supporter la perte d'un noeud au sein d'un cluster sans perte de données.

Cependant, même avec ces fonctions de haute disponibilité et de reprise après incident, il y a d'autres cas d'utilisation où vous pouvez souhaiter bénéficier d'une sauvegarde de données améliorée.

<div id="activepassive"></div>

### Indisponibilité du centre de données et reprise après incident

La [réplication continue](../api/replication.html#continuous-replication) entre clusters est une bonne solution au problème de disponibilité partielle d'un cluster {{site.data.keyword.cloudant_short_notm}}.
La réplication continue est un modèle "actif-passif".
La composante "active" du modèle désigne la réplication continue.
La composante "passive" du modèle reconnaît que la réplique n'est pas normalement destinée à répondre aux requêtes des applications.
Elle est plutôt majoritairement utilisée en tant que clone de la base de données d'origine.
Si nécessaire, les données sont accessibles depuis le clone.
Les données du clone peuvent également être restaurées ailleurs par le biais de la [réplication](../api/replication.html).

>	**Remarque** : La restauration d'une base de données volumineuse à l'aide d'une réplication à partir d'un clone peut prendre un certain temps.

### Haute disponibilité, reprise automatique et équilibrage des charges géographique

Une autre solution à l'approche ["active-passive"](#activepassive) consiste à configurer deux centres de données pour utiliser un modèle "actif-actif".

Dans ce modèle, tous les changements apportés à une base de données dans un cluster A sont répliqués dans une base de données d'un cluster B.
De la même manière, tous les changements apportés à la base de données du cluster B sont répliqués dans la base de données du cluster A.

>	**Remarque** : Vous pouvez configurer ce modèle à l'aide du tableau de bord {{site.data.keyword.cloudant_short_notm}}.
Il n'est pas nécessaire pour cela de faire appel au support de {{site.data.keyword.cloudant_short_notm}}.

Une fois ce modèle en place,
vous pouvez concevoir vos applications de base de données de manière à basculer vers l'un des clusters si certains critères de disponibilité sont remplis.
Vous pouvez définir les critères de disponibilité dans le cadre de votre conception d'application.

Vous pouvez également inclure un "équilibrage des charges" géographique dans votre conception d'application.
Par exemple,
une application client utilisée dans une zone géographique peut s'attendre à de meilleures performances lorsqu'elle accède aux données d'un cluster installé dans une zone géographique environnante.
Si vous souhaitez optimiser les performances de l'application, nous vous conseillons de concevoir l'application client de sorte qu'elle identifie le cluster "le plus proche" et qu'elle s'y connecte lors des requêtes de base de données.

Un tutoriel expliquant la procédure de configuration d'un environnement d'application dans plusieurs régions est disponible [ici ![External link icon](../images/launch-glyph.svg "External link icon")](http://www.ibm.com/developerworks/cloud/library/cl-multi-region-bluemix-apps-with-cloudant-and-dyn-trs/index.html){:new_window}.

### Modification des données, accidentelle ou malveillante

{{site.data.keyword.cloudant_short_notm}} ne prévoit aucun dispositif de création d'image instantanée de votre base de données.
Si vous en avez besoin, par exemple pour faciliter le retour à un état connu au niveau d'un fichier, vous pouvez atteindre le même effet de l'une des deux façons suivantes :

1.	En utilisant la réplication. Répliquez tout d'abord la base de données. Assurez-vous d'enregistrer l'ID de séquence finale. Suivant le calendrier de votre choix, répliquez la base de données vers une nouvelle base de données. Démarrez la réplication à partir du dernier ID de séquence enregistré. En conservant les ID de séquence pour les réplications, vous pouvez imiter le mécanisme de cumul. Le résultat est similaire à la création d'instantanés "hebdomadaires" réguliers à partir des instantanés "quotidiens". La limite de cette approche est qu'elle réplique également les révisions de documents supprimés ou "désactivés", ainsi que les conflits non résolus.

2.	En vidant le contenu de la base de données dans un fichier. Plusieurs outils existent pour cela. Le fichier de vidage qui en découle peut être stocké sur un périphérique ou service orienté bloc plus économique. La limite d'une telle approche est qu'elle ne vide généralement que les révisions de document en cours. Les conflits non résolus ne sont donc pas inclus.

La création d'un vidage de base de données est un moyen efficace d'activer un grand nombre de solutions de sauvegardes.
Le reste de la discussion va donc porter sur cette approche.

<!--
https://developer.ibm.com/clouddataservices/2016/03/22/simple-couchdb-and-cloudant-backup/

A useful approach is to have couchbackup's snapshots placed on the Bluemix Object Storage service, as described here:

https://developer.ibm.com/recipes/tutorials/object-storage-cloudant-backup/
-->
