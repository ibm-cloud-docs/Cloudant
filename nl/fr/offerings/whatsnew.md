---

copyright:
  years: 2017
lastupdated: "2017-07-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-05-04 -->

# Nouveautés de Cloudant

Tenez-vous informé des modifications et des mises à jour de Cloudant.
{:shortdesc}

## Matériel dédié

Une nouvelle [instance de service dédiée](bluemix.html#dedicated-plan) est disponible. 

## Génération 6233

- Introduit un nouveau planificateur de réplication.
  Outre les performances et les noeuds finaux supplémentaires qu'il apporte, le
planificateur modifie la façon dont le statut de réplication est surveillé, ainsi que la
production de rapports associée.
  En particulier, l'enregistrement des mises à jour du statut dans un document de
réplication n'est plus pris en charge.
  Pour plus d'informations sur cette modification importante, voir
[Planificateur de réplication](../api/advanced_replication.html#the_replication_scheduler).
  Pour toute question, contactez le support Cloudant en ouvrant un ticket via le tableau de bord Cloudant. 

## Génération 6069

- Auparavant, un travail de réplication en panne pour une raison quelconque
entraînait une mise à jour du document de réplication, puis une tentative de
démarrage d'une nouvelle réplication.
  Dans certaines circonstances, ce comportement pouvait continuer indéfiniment et
générait de nombreux doublons du même message d'erreur.
  Un correctif a été introduit pour faire en sorte que le document de réplication ne soit pas
mis à jour sauf en cas de changement du motif de l'erreur.
- Si le document de conception destiné à la spécification d'un index géospatial
est non valide, une tentative d'extraction des informations relatives à l'index via le
[noeud
final _geo_info](../api/cloudant-geo.html#obtaining-information-about-a-cloudant-geo-index) génère une réponse [HTTP 404](http.html#404).
- Ajout de la prise en charge de l'opérateur [`$allmatch`](../api/cloudant_query.html#the-allmatch-operator).

## Génération 5834

- La longueur maximale d'un `id` de document est désormais de 7168 caractères (7k).

## Génération 5728

- Cloudant est plus tolérant par rapport aux documents utilisateur incorrectement
formés et stockés dans la base de données `_users`.
  Les documents utilisateur doivent être structurés et remplis pour être conformes aux
[exigences d'Apache Software Foundation CouchDB ![External link icon](../images/launch-glyph.svg "External link icon")](http://docs.couchdb.org/en/2.0.0/intro/security.html#users-documents){:new_window}.

## Génération 5638

-   Introduit de nouveaux paramètre de requête "stable" et "update" pour les vues. 
-   Le réplicateur n'effectue pas de nouvelles tentatives à l'infini s'il ne parvient pas à écrire de points de contrôle dans le base de données source.

## Génération 5421

-	Les flux de changements prennent en charge les filtres basés sur les vues. 
-	Les flux de changements prennent en charge le filtre `_doc_ids`. 
-	Les demandes `POST` sont prises en charge pour `_changes`.
-	`_all_docs` et `_changes` prennent en charge le paramètre `attachments=true`.
-	Les fonctions de base de données CouchDB 1.6 `_users` sont prises en charge, notamment le hachage côté serveur des mots de passe lorsque des documents sont créés dans la base de données `_users`. 
-	Le noeud final `/_bulk_get` réduit le nombre de demandes utilisées dans la réplication vers les clients mobiles.
-	Les métadonnées de document de conception contiennent une zone `update pending`. 
-	Cloudant Query ne renvoie plus d'erreur s'il n'existe aucun index valide. 

### Changements majeurs ou liés au comportement

Tâches actives

-   Les entrées de l'indexeur dans la réponse `_active_tasks` ne signalent plus la zone `user`.
-   Les entrées de l'indexeur de recherche dans la réponse `_active_tasks` ne signalent plus la zone `user`.

Vues

-   La normalisation Unicode des valeurs de clé est cohérente entre les résultats des vues réduites et développées. Une conséquence de ce correctif est que l'ordre des résultats est susceptible de changer si un classement par ligne est spécifié dans un document de conception.
-   Lorsque vous interrogez une vue ou la base de données `_all_docs`, une erreur est générée si vous spécifiez le paramètre `keys` et l'un des paramètres `key`, `startkey` ou `endkey`.
-   Une erreur est générée si vous transmettez les paramètres `startkey` et `endkey` à une vue s'il est impossible d'obtenir une correspondance de ligne. Par exemple, lorsque le paramètre `startkey` est supérieur au paramètre `endkey` pour `descending=false`, ou lorsque le paramètre `startkey` est inférieur au paramètre `endkey` pour `descending=true`, Cloudant renvoie l'erreur `400 Bad Request`.
-   Lorsque `dbcopy` est configuré dans un document de vue, il est automatiquement transformé en zone `options` dans un document de conception.  

Documents de conception

-   Validation plus stricte des documents de conception. Cette validation n'est pas censée générer de problèmes avec les documents de conception existants, mais les documents de conception incorrectement formés ne seront pas sauvegardés. 
-   Les vues écrites dans un langage non pris en charge répondent toutes avec une erreur `error` `unknown_query_language`. Auparavant, la réponse était `reason` `unknown_query_language`.
-   Lorsqu'un réducteur NULL est utilisé pour insérer un document de conception de base de données, le système répond avec le motif d'erreur `'(null)'`. Auparavant, il renvoyait `((new String("null")))`.
-   Si `updates` est spécifié dans un document de conception, il ne doit pas avoir pour valeur NULL. 

Authentification

-   `authentication_handlers` des métadonnées `_session` ne contient plus `["delegated", "local"]`.

Documents utilisateur

-   Validez la structure des documents utilisateur créés dans la base de données `_users`. Après la mise à niveau de DBNext, les documents utilisateur doivent être conformes aux exigences ASF CouchdDB. Auparavant, Cloudant ne validait pas la structure des documents utilisateur.  

Réplication 

-   Les documents du réplicateur conservent le message d'erreur le plus récent dans la zone JSON `_replication_state_reason`. Cette zone reste identique même après un redémarrage de la réplication et est à l'état `triggered`. Ce changement facilite la détection du code du réplicateur et empêche l'écriture de la même erreur de manière répétée dans le document. 
-   Une erreur survenue au cours de la réplication ne met pas à jour le document de réplication, sauf si le motif de l'erreur change. Auparavant, lorsqu'une erreur se produisait lors de la réplication, une boucle sans fin commençait et générait des fragments considérables.   

Ensemble de résultats

-   Le noeud final `_db_updates` renvoie un ensemble de résultats contenant une clé nommée `db_name`. Auparavant, il renvoyait un ensemble de résultats doté d'une clé nommée `dbname`.
-   Définissez la longueur maximale de l'ID de document. Auparavant, il n'était pas possible de définir une longueur maximale pour l'ID de document. 

`dbcopy`

- La fonction `dbcopy` peut générer des problèmes dans certaines circonstances.
  Les informations relatives à cette fonction ont été retirées de la documentation.
  L'utilisation de `dbcopy` est fortement déconseillée. 
