---

copyright:
  years: 2015, 2017
lastupdated: "2017-01-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-01-24 -->

<div id="cap_theorem"></div>

<div id="consistency"></div>

# Théorème CAP

{{site.data.keyword.cloudantfull}} s'appuie sur le modèle de cohérence ['Cohérence finale' ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](http://en.wikipedia.org/wiki/Eventual_consistency){:new_window}.
{:shortdesc}

Pour comprendre comment fonctionne ce modèle,
et pourquoi il représente un aspect essentiel de l'utilisation de {{site.data.keyword.cloudant_short_notm}},
considérons tout d'abord ce que l'on entend par Cohérence.

La cohérence est l'une des quatre propriétés ['ACID' ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://en.wikipedia.org/wiki/ACID){:new_window} nécessaires pour traiter correctement les transactions d'une base de données.

En outre, la cohérence correspond à l'un des trois attributs du théorème
<a href="http://en.wikipedia.org/wiki/CAP_Theorem" target="_blank">'CAP' <img src="../images/launch-glyph.svg" alt="Icône de lien externe" title="Icône de lien externe"></a>.
Ces attributs sont les suivants : **C**onsistency (Cohérence),
**A**vailability (Disponibilité) et **P**artition tolerance (Tolérance au partitionnement).
Ce théorème dit qu'il est impossible sur un système informatique de calcul distribué, tel que {{site.data.keyword.cloudant_short_notm}}, de garantir _en même temps_ les trois contraintes suivantes :

-   Consistency (Cohérence) : tous les noeuds du système voient exactement les mêmes données au même moment ;
-   Availability (Disponibilité) : garantit que toutes les requêtes reçoivent une réponse ;
-   Partition tolerance (Tolérance au partitionnement) : le système continue à fonctionner même si une partie du système est perdue ou tombe en panne.

L'incapacité à assurer les trois attributs en même temps signifie que {{site.data.keyword.cloudant_short_notm}} ne garantit pas l'attribut Consistency (Cohérence).
Dans un modèle mettant l'accent sur la cohérence finale, tel que {{site.data.keyword.cloudant_short_notm}}, lorsqu'une mise à jour est apportée à une partie du système, les autres parties du système _finissent_ par la voir.
Lorsque la mise à jour est propagée, le système "converge" lorsque la cohérence est atteinte.

La cohérence finale permet d'obtenir de bonnes performances.
Avec un modèle de cohérence fort, le système doit attendre que les mises à jour soient complètement propagées avant d'exécuter une demande d'écriture ou de mise à jour.
Avec un modèle de cohérence finale, la demande d'écriture ou de mise à jour peut être renvoyée presque immédiatement, tandis que la propagation sur le système se poursuit en "arrière-plan".

Une base de données ne peut garantir que deux de ces trois attributs pour des raisons à la fois théoriques et pratiques.
Une base de domaine mettant l'accent sur la cohérence et la disponibilité est simple :
un noeud unique stocke une copie unique de vos données.
Mais ce modèle s'avère difficile à faire évoluer sachant que vous devez mettre à niveau le noeud pour optimiser les performances, au lieu d'utiliser des noeuds supplémentaires.
En outre, le moindre incident système peut arrêter un système à noeud unique, tandis que la perte de messages peut induire une importante perte de données.
Pour durer, le système doit devenir plus pointu.

## Compromis au niveau de la tolérance au partitionnement

Une base de données qui met l'accent sur la cohérence et la tolérance au partitionnement utilise généralement une architecture
<a href="http://en.wikipedia.org/wiki/Master/slave_(technology)" target="_blank">maître-esclave <img src="../images/launch-glyph.svg" alt="Icône de lien externe" title="Icône de lien externe"></a> dans laquelle un noeud du système joue le rôle de maître.
Seul le maître peut approuver les écritures de données, alors que les autres noeuds répliquent les données à partir du maître pour gérer les lectures.
Si le maître perd sa connexion au réseau, ou s'il ne parvient pas à communiquer avec un grand nombre de noeuds du système, un nouveau maître est choisi.
Ce processus de sélection est différent d'un système à l'autre, et peut être source de [problèmes majeurs![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](http://aphyr.com/posts/284-call-me-maybe-mongodb){:new_window}.

{{site.data.keyword.cloudant_short_notm}} met l'accent sur la disponibilité et la tolérance au partitionnement en s'appuyant sur une topologie maître-maître, de sorte que chaque noeud puisse accepter les écritures et les lectures sur sa partie de vos données.
Les noeuds multiples comportent une copie de chaque partie de vos données.
Chaque noeud copie les données avec d'autres noeuds.
Si un noeud n'est plus accessible, d'autres peuvent prendre sa place le temps que le réseau soit rétabli.
De cette manière, le système renvoie vos données en temps voulu malgré une défaillance de noeud arbitraire et préserve une [cohérence finale ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](http://en.wikipedia.org/wiki/Eventual_consistency){:new_window}.
Le compromis visant à faire passer la cohérence absolue au second plan découle du délai nécessaire pour que tous les noeuds voient les mêmes données.
Par conséquent, certaines réponses peuvent contenir d'anciennes données, tandis que les nouvelles données sont propagées sur le système.

## Changement d'approche

La conservation d'une vue cohérente des données est logique et facile à comprendre, car une base de données relationnelle se charge de le faire pour vous.
On s'attend donc que les services Web qui interagissent avec les systèmes de base de données en fassent de même.
Mais cela ne veut pas dire qu'ils fonctionnent de la même manière.
La cohérence n'est pas acquise, et cela demande du travail pour changer l'approche.

En fait, la cohérence n'est pas nécessairement essentielle pour un grand nombre de service cloud d'entreprise.
Avec un système très utilisé, il existe une forte probabilité qu'une partie de ce système tombe en panne.
Une base de données conçue autour de la nécessité d'accorder la priorité à la disponibilité et à la cohérence finale est mieux adaptée pour maintenir l'application en ligne.
La cohérence des données d'application peut être abordée après coup.
Comme Seth Gilbert et Nancy Lynch de l'institut MIT [concluent ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](http://www.glassbeam.com/sites/all/themes/glassbeam/images/blog/10.1.1.67.6951.pdf){:new_window},
"la plupart des systèmes du monde réel doivent se contenter de renvoyer la plupart des données, la plupart du temps."

## Disponibilité d'application et cohérence dans l'entreprise

Si l'on examine les services Web les plus populaires, il ressort que les utilisateurs s'attendent déjà à une haute disponibilité et échangent bien volontiers cette disponibilité contre des données cohérentes finales sans même s'en rendre compte.

Un grand nombre d'applications induisent les utilisateurs en erreur pour le bien de la disponibilité.
Prenons l'exemple des ATM :
A cause des données bancaires incohérentes, il est encore possible d'être à découvert sans s'en rendre compte.
Il est irréaliste de présenter une vue cohérente du solde de votre compte dans l'ensemble du système bancaire si chaque noeud du réseau doit s'arrêter et enregistrer cette valeur avant de poursuivre les opérations.
Il vaut mieux rendre le système hautement disponible.

Le secteur bancaire l'a compris dans les années 1980, mais de nombreuses sociétés informatiques s'inquiètent toujours de privilégier la disponibilité au détriment de la cohérence.
Pensez au nombre d'appels passés au support technique lorsque vos équipes commerciales ne parviennent pas à accéder à leur CRM.
Maintenant, dites-vous qu'elles ne remarqueraient même pas que la mise à jour de base de données prendrait quelques secondes pour se propager sur l'ensemble de l'application.

La disponibilité est bien plus importante que la cohérence.
Pensez aux systèmes de panier en ligne, aux caches HTTP et autres serveurs de noms de domaine pour ne citer que quelques exemples.
Les organisations doivent prendre en compte le coût du temps d'indisponibilité lié à la frustration des utilisateurs, à la perte de productivité et aux opportunités manquées.

## De la théorie à la pratique

Il est essentiel de relever le défi de la haute disponibilité pour les applications en cloud.
Sinon, la cohérence de base de données globale reste un goulot d'étranglement lorsque vous procédez aux mises à niveau.
Les applications à haute disponibilité ont un besoin permanent de rester en contact avec leurs données, même si ces dernières ne sont pas les plus à jour.
C'est le concept même de la cohérence finale, et il n'y a aucune raison d'en avoir peur.
Au sens plus large, il est parfois préférable de fournir des réponses qui ne sont pas tout à fait correctes plutôt que de ne rien répondre du tout.

Les systèmes de base de données masquent les difficultés de la disponibilité par rapport à la cohérence de différentes façons, mais elles existent quand même.
Le point de vue adopté par DBaaS (database-as-a-service) de {{site.data.keyword.cloudant_short_notm}}, CouchDB et autres bases de données NoSQL, est qu'il vaut mieux que les développeurs traitent ces difficultés le plus tôt possible dans le processus de conception.
En travaillant suffisamment en amont, vous réduisez le risque de mauvaises surprises, car les applications sont prêtes à être déployées dès le premier jour.
