---

copyright:
  years: 2017, 2018
lastupdated: "2017-11-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-05-10 -->

# Reprise après incident et sauvegarde

Vos données sont importantes et précieuses.
Vous devez les protéger afin de garantir leur sécurité,
leur disponibilité et leur intégrité.
{{site.data.keyword.cloudantfull}} permet de protéger vos données et de maintenir vos applications opérationnelles de plusieurs manières. {:shortdesc}

Certaines de ces fonctions de protection sont automatiques.
Pour les autres formes de protection,
{{site.data.keyword.cloudant_short_notm}} propose des outils pris en charge pour vous aider à créer vos propres fonctions de haute disponibilité et de reprise après incident.

Le présent document fournit un aperçu des fonctions automatiques et des outils compatibles qui sont mis à votre disposition par {{site.data.keyword.cloudant_short_notm}}.

## Types et niveaux de protection

Le type de protection susceptible de vous intéresser dépend du problème que vous souhaitez résoudre.

Par exemple, vous pouvez vouloir un haut niveau de disponibilité de vos données pour pouvoir toujours y accéder,
même en cas de légère panne matérielle.
Vous avez alors besoin d'une fonction de haute disponibilité.
Celle-ci garantit la meilleure disponibilité des données possible en cas de panne matérielle.
Différentes techniques de haute disponibilité acceptent différents niveaux de défaillance avant que les opérations n'en soient perturbées.

Vous pouvez également vouloir des moyens rapides et faciles de sauvegarder et restaurer les données.
Par exemple, après une panne matérielle grave ou compliquée, vous voulez que toutes les données soient disponibles sur un autre système le plus rapidement possible.
Vous avez alors besoin d'une fonction de reprise après incident.
Un incident signifie généralement qu'une base de données n'est plus disponible dans un ou plusieurs emplacements.
Par exemple, une coupure de courant peut provoquer la défaillance de tous les systèmes d'un cluster de bases de données.
Un défaillance réseau à grande échelle peut indiquer que les systèmes d'un cluster ne peuvent pas être contactés, même s'ils continuent à fonctionner correctement.

La réponse aux exigences de haute disponibilité et de reprise après incident commence souvent par la simplification du problème en des besoins plus génériques.
Une fois que vous avez identifié vos besoins, vous pouvez appliquez les outils et les fonctions qui permettent de résoudre les besoins génériques.
Ensemble, les outils et les fonctions peuvent ensuite faire face à vos besoins de haute disponibilité ou de reprise après incident.

>	**Remarque** : Divers outils et fonctions fournissent plusieurs niveaux de protection.
	Les différentes fonctions peuvent être plus ou moins adaptées à votre problème spécifique de haute disponibilité ou de reprise après incident.

{{site.data.keyword.cloudant_short_notm}} offre un certain nombre d'outils et de fonctions qui résolvent des questions générales :

1.	La redondance des données au sein d'une même région, également connue sous le nom de [Redondance automatique des données dans une seule région](#in-region-automatic-data-redundancy).
2.	La redondance des données et la reprise après incident inter-région, également connue sous le nom de [Redondance inter-région pour la reprise après incident](#cross-region-redundancy-for-disaster-recovery).
3.	La sauvegarde par image instantanée à un "moment donné" pour la restauration jusqu'à un point de cohérence, à l'aide de la méthode traditionnelle de [Sauvegarde et reprise de base de données](#database-backup-and-recovery).

## Redondance automatique de données dans une seule région

Au sein d'un seul et même compte {{site.data.keyword.cloudant_short_notm}}, les données sont stockées en trois exemplaires à l'aide de processus internes et automatiques.
Aucune action n'est nécessaire pour activer cette réplication de données interne.

La redondance de données dans une seule région active la protection à haute disponibilité.
Plus précisément, elle protège vos données contre toute défaillance matérielle au niveau de la région.
Si une unité de matériel tombe en panne dans la région, seule la copie de vos données qui est stockée sur cette unité n'est plus disponible.
Vos applications demeurent utilisables, {{site.data.keyword.cloudant_short_notm}} acheminant automatiquement les demandes vers les copies de vos données qui sont disponibles sur les autres unités matérielles de la région.
Entre-temps, la surveillance automatique des systèmes détecte la panne de l'unité de matériel, et lance les actions appropriées afin de restaurer la redondance totale.

Les comptes {{site.data.keyword.cloudant_short_notm}} sont hébergés dans une seule région.
Toutes les données que vous stockez dans votre compte sont ainsi stockées sur des serveurs séparés, chacun des serveurs étant hébergés dans cette même région.

La redondance automatique de données dans une seule région se limite à :

1.	Fournir une protection au sein d'une seule et même région
2.	Préserver les données en cours

Pour fournir une protection supplémentaire au-delà de la région unique associée à votre compte, vous devez utilisez la [Redondance inter-région pour la reprise après incident](#cross-region-redundancy-for-disaster-recovery).

Pour fournir une protection de "l'historique" de vos données, par exemple pour activer le contrôle des modifications apportées aux données par les applications, utilisez les images instantanées de données qui sont créées par les outils [Sauvegarde et reprise de base de données](#database-backup-and-recovery).

En résumé, la redondance de données dans une seule région active la fonctionnalité de haute disponibilité en assurant la tolérance aux pannes qui affectent des systèmes uniques au sein de la région.

## Redondance inter-région pour la reprise après incident

La fonctionnalité de réplication de {{site.data.keyword.cloudant_short_notm}} vous aide à concevoir une fonction de reprise après incident flexible dans vos applications.
Le principal moyen d'activer la reprise après incident est d'utiliser la réplication de {{site.data.keyword.cloudant_short_notm}} pour créer une redondance entre régions.
Le résultat est que votre application peut tolérer la situation dans laquelle une ou plusieurs régions ne sont pas disponibles.

Les principales étapes de la création d'une redondance entre régions sont les suivantes :

1.  Créer des comptes {{site.data.keyword.cloudant_short_notm}} dans plusieurs régions.
2.  Créer des bases de données dans chaque région selon les besoins.
3.  Pour les bases de données devant être stockées à l'aide de la redondance inter-région, configurer des réplications continues bidirectionnelles entre les bases de données correspondantes dans chaque compte.
4.  Concevoir et implémenter vos applications pour que les demandes de données soient acheminées selon que votre environnement ait une configuration "active-passive" ou "active-active".
  Un guide de configuration détaillé est [disponible](active-active.html).

Lorsque vous configurez vos applications pour qu'elles fonctionnent avec des données provenant de plusieurs régions, tenez compte des points suivants :

* Les applications peuvent envoyer des demandes à la base de données la plus proche de leur emplacement physique.
  Cette proximité permet de réduire les temps d'attente des réseaux et d'améliorer les temps de réponse.
  C'est ce que l'on appelle la méthode "active-active".
  Elle se caractérise par l'utilisation simultanée de plusieurs exemplaires de données.
  Les applications qui s'exécutent dans une configuration active-active doivent disposer d'une [stratégie de gestion des conflits](mvcc.html#distributed-databases-and-conflicts) afin d'éviter les problèmes liés aux multiples copies de données.
* Les applications peuvent demander des données provenant d'une seule région par défaut.
  Si la région n'est pas disponible,
  l'application bascule la demande vers une autre région.
  C'est ce que l'on appelle la méthode "active-passive".
  Elle se caractérise par l'utilisation active d'un jeu de données unique à la fois.
* Une application peut reposer sur une configuration hybride,
  dans laquelle un compte unique est utilisé pour toutes les demandes d'écriture de données,
  et d'autres emplacements sont utilisés exclusivement pour les demandes en lecture seule.
  C'est ce que l'on appelle la méthode active-active pour les lectures.
* Dans un scénario de reprise après incident,
  votre application doit réacheminer les demandes d'accès pour accéder aux comptes
  qui sont hébergés dans les régions qui sont toujours en ligne.
  Cela signifie que votre application doit être en mesure de détecter la perte de connexion à une région,
  et de réacheminer les demandes de données.

En résumé, la redondance inter-région ressemble à la fonctionnalité de haute disponibilité,
si ce n'est qu'elle s'applique aux pannes qui se produisent sur l'ensemble d'une région.
Toutefois, cette configuration fournit une vraie fonction de reprise après incident.
La raison en est que les applications peuvent continuer à fonctionner si les données d'une région ne sont pas disponibles pendant un certain temps.
La réplication de {{site.data.keyword.cloudant_short_notm}} garantit la synchronisation des données entre les régions.
Toutefois, vos applications doivent pouvoir "basculer" vers les copies de données qui sont stockées dans d'autres régions.

## Sauvegarde et reprise de base de données

La [redondance automatique de données dans une seule région](#in-region-automatic-data-redundancy) offre aux applications un accès à haute disponibilité aux données.
La [redondance inter-région pour la reprise après incident](#cross-region-redundancy-for-disaster-recovery) assure aux applications une fonctionnalité de reprise après incident.
Toutefois, ces deux fonctionnalités se concentrent seulement sur l'accès à la copie _en cours_ de vos données.

Dans la pratique, les utilisateurs et les applications peuvent commettre des erreurs et modifier accidentellement des données.
Les applications elles-mêmes peuvent implémenter un certain niveau de protection, mais des modifications indésirables peuvent toujours se produire.
Dans ce cas, il est utile de pouvoir restaurer les données à un point de cohérence antérieur.
Les sauvegardes de bases de données en sont toutes capables.

Outre la protection de vos données avec les fonctionnalités de haute disponibilité et de reprise après incident, envisagez de vider les données de votre base de données vers un emplacement distinct, à intervalles réguliers.
Assurez-vous de contrôler et de tester les sauvegardes afin d'être certain que tout est correct.

{{site.data.keyword.cloudant_short_notm}} est compatible avec les outils qui permettent de vider le contenu JSON des bases de données vers des fichiers, puis de restaurer ces bases de données à partir de ces fichiers.

Plus précisément, les outils pris en charge par {{site.data.keyword.cloudant_short_notm}} vous permettent de :

*	Sauvegarder des bases de données entières dans un fichier, à des fins de traitement et de stockage hors site ultérieurs.
*	Restaurer des bases de données entières à partir d'un état antérieur qui se trouve dans votre fichier de sauvegarde.

<strong style="color:red;">Avertissement</strong> : Les outils pris en charge par {{site.data.keyword.cloudant_short_notm}} comportent les limites suivantes : 

*	Les paramètres `_security` ne sont pas sauvegardés par les outils.
*	Les pièces jointes ne sont pas sauvegardées par les outils.
*	Les sauvegardes ne sont pas vraiment des instantanés à un "moment donné".
	La raison en est que les documents présents dans la base de données sont extraits par lots, mais que d'autres applications peuvent être en train de mettre à jour des documents au même moment.
	Par conséquent, les données de la base de données peuvent varier entre la lecture du premier lot et celle du dernier lot.
*	Les définitions d'index contiennent les documents de conception qui sont sauvegardés, mais lorsque les données sont restaurées, les index doivent être régénérés.
	Cette opération peut prendre un temps considérable en fonction du volume de données à restaurer.

<div id="conclusion"></div>

## Etapes suivantes

Vous pouvez développer des applications basées sur les fonctions {{site.data.keyword.cloudant_short_notm}} de base et les outils pris en charge pour créer des stratégies de protection des données plus complexes.

Exemples de scénarios :

*	Restauration de documents uniques à partir d'un état précédent
*	Stockage de plusieurs états de documents antérieurs afin de procéder à des restaurations très anciennes
*	Migration de données anciennes vers une solution de stockage moins onéreuse, pour un meilleur rapport coût-efficacité

Les outils de sauvegarde se composent d'une application de ligne de commande et d'une bibliothèque node.js.
Ils sont disponibles [sur NPM ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://www.npmjs.com/package/@cloudant/couchbackup){:new_window}.

Pour obtenir des idées et des exemples expliquant les modalités d'intégration de ces outils dans votre stratégie de protection des données, voir le [manuel d'instructions relatives aux sauvegardes](backup-cookbook.html).
