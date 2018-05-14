---

copyright:
  years: 2017
lastupdated: "2017-07-13"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-04-28 -->

# Sécurité

## Sécurité et protection des données dans Cloudant DBaaS

La protection des données des applications mobiles et Web à grande échelle peut s'avérer complexe, surtout quand il s'agit de bases de données distribuées et NoSQL.

Tout en réduisant les efforts de maintenance de vos bases de données nécessaires à leur fonctionnement et à leur croissance ininterrompue,
{{site.data.keyword.cloudantfull}} garantit également la sécurité et la protection de vos données. 

## Plateformes physiques de niveau supérieur

{{site.data.keyword.cloudant_short_notm}} DBaaS est hébergée physiquement
sur des fournisseurs d'infrastructure de cloud de niveau 1, tels qu'{{site.data.keyword.BluSoftlayer_full}} et Amazon.
Vos données sont ainsi protégées par le réseau et les mesures de sécurité physiques mises
en oeuvre par ces fournisseurs qui comprennent : 

- Les certifications : conformité avec les normes SSAE16, SOC2 Type 1, ISAE 3402, ISO 27001, CSA et d'autres normes.
- La gestion des accès et des identités.
- La sécurité physique générale des centres de données et la surveillance des centres des opérations réseau. 
- Le renforcement des serveurs.
- {{site.data.keyword.cloudant_short_notm}} vous donne la possibilité de choisir ou de basculer entre les différents fournisseurs au fur et à mesure des
modifications des exigences de votre accord sur les niveaux de service (SLA) ou de vos coûts.

> **Remarque :** Vous trouverez plus de détails sur les certifications dans les [informations relatives à la conformité](compliance.html).

## Contrôle d'accès sécurisé

De nombreuses fonctions de sécurité sont intégrées dans {{site.data.keyword.cloudant_short_notm}} et vous permettent de contrôler l'accès aux données : 

- Authentification : {{site.data.keyword.cloudant_short_notm}} est
accessible via une API HTTP.
  Lorsque le noeud final d'API l'exige, l'utilisateur est authentifié à chaque demande
HTTPS ou HTTP reçue par {{site.data.keyword.cloudant_short_notm}}.
- Autorisation : accordez des droits de lecture, d'écriture et d'administration sur des bases de données spécifiques. 
- Chiffrement "à la volée" : l'accès à {{site.data.keyword.cloudant_short_notm}} est entièrement chiffré via HTTPS.
- Chiffrement au repos : possibilité de chiffrer les données stockées sur disque dans {{site.data.keyword.cloudant_short_notm}}.
  > **Remarque** : Les données stockées dans une instance {{site.data.keyword.Bluemix_notm}} {{site.data.keyword.cloudant_short_notm}} sont toujours chiffrées. 
- Accès via une API : l'accès à {{site.data.keyword.cloudant_short_notm}}
s'effectue à l'aide d'un programme via une API et le protocole HTTP sécurisé (HTTPS).
  Vous pouvez générer les clés d'API via le tableau de bord {{site.data.keyword.cloudant_short_notm}}.
- Placement sur liste blanche des adresses IP : les clients {{site.data.keyword.cloudant_short_notm}} des environnements dédiés
peuvent placer sur liste blanche des adresses IP afin de limiter l'accès aux seuls serveurs et utilisateurs spécifiés. 
- CORS : activez la prise en charge de CORS pour des domaines spécifiques grâce au
tableau de bord {{site.data.keyword.cloudant_short_notm}}.

## Protection contre la perte ou l'altération des données

{{site.data.keyword.cloudant_short_notm}} comporte plusieurs fonctions vous
permettant de gérer la qualité et la disponibilité des données : 

- Stockage de données redondant et durable : par défaut,
  {{site.data.keyword.cloudant_short_notm}} sauvegarde sur disque trois copies de
chaque document sur trois noeuds différents d'un cluster.
  Cette sauvegarde de copies garantit ainsi la disponibilité d'une copie de bascule de vos
données, quelle que soit la défaillance. 
- Réplication et exportation des données : vous pouvez répliquer vos bases de
données en continu entre des clusters de différents centres de données, sur un cluster
Cloudant Local sur site ou sur Apache CouchDB.
  Vous pouvez aussi exporter les données depuis {{site.data.keyword.cloudant_short_notm}} (au format JSON) vers d'autres
emplacements ou sources (comme votre propre centre de données) afin de créer une redondance des données supplémentaire. 
