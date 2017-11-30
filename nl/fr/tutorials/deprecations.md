---

copyright:
  years: 2017
lastupdated: "2017-07-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-07-12 -->

# Changements majeurs ou liés au comportement

Ce document récapitule les changements apportés au comportement dans les éditions Cloudant.
{:shortdesc}

## Incompatibilité entre CouchDB version 1.6 et Cloudant version 2.0.0

-   La version la plus récente de Cloudant et le codebase basé sur CouchDB 1.6 ne sont pas compatibles. Dans
l'ancienne version   de Cloudant, si vous ajoutiez un paramètre de requête
("reduce=false") au corps de la demande, le paramètre du corps de la demande était ignoré alors que le paramètre de l'URL de la demande était respectée. Dans
les versions récentes de Cloudant, le paramètre de requête ("reduce=false") du corps de la demande n'est pas ignoré. 

## Message d'erreur revu

- Le message d'erreur émis lorsque vous tentez de placer un document joint avec
une révision qui n'existe pas a été modifié en erreur 409 avec les informations suivantes :

	```
	{"error":"not_found","reason":"missing_rev"}
	```

## X-Frame-Options

Le paramètre `X-Frame-Options` est un en-tête de réponse qui indique si une réponse HTTP peut être imbriquée dans un élément `<frame>`, `<iframe>` ou `<object>`. Cette fonction de sécurité permet d'éviter le détournement de clic. 

Vous pouvez configurer cette option en fonction de vos paramètres CORS. Si CORS est
activé, le paramètre `X-Frame-Options` est automatiquement activé et envoie par défaut l'en-tête de réponse `X-Frame-Options: DENY`. Si un en-tête HOST de demande correspond à l'URL indiquée dans la section origins de CORS, un en-tête de réponse `X-Frame-Options: ALLOW-FROM URL` est renvoyé.
 
Cette modification risque d'avoir une incidence sur les clients qui accèdent directement à la base de données depuis le navigateur. Si
vous rencontrez le message d'erreur, "X-Frame-Options: DENY" et qu'il entraîne une interruption de votre service, vous devez activer CORS comme indiqué dans
[Définition de la configuration de CORS](../api/cors.html#setting-the-cors-configuration). Après
avoir activé CORS, ajoutez la valeur à l'en-tête HOST que vous envoyez dans la demande de liste des éléments `origins` autorisés.

## Tâches actives

-   Les entrées de l'indexeur dans la réponse `_active_tasks` ne signalent plus la zone `user`.
-   Les entrées de l'indexeur de recherche dans la réponse `_active_tasks` ne signalent plus la zone `user`.

## Vues

-   La normalisation Unicode des valeurs de clé est cohérente entre les résultats des vues réduites et développées. Une conséquence de ce correctif est que l'ordre des résultats est susceptible de changer si un classement par ligne est spécifié dans un document de conception.
-   Lorsque vous interrogez une vue ou la base de données `_all_docs`, une erreur est générée si vous spécifiez le paramètre `keys` et l'un des paramètres `key`, `startkey` ou `endkey`.
-   Une erreur est générée si vous transmettez les paramètres `startkey` et `endkey` à une vue s'il est impossible d'obtenir une correspondance de ligne. 
Par exemple, lorsque le paramètre `startkey` est supérieur au paramètre `endkey` pour `descending=false`, ou lorsque le paramètre `startkey` est inférieur au paramètre `endkey` pour `descending=true`, Cloudant renvoie l'erreur `400 Bad Request`.
-   Lorsque `dbcopy` est configuré dans un document de vue, il est automatiquement transformé en zone `options` dans un document de conception.  

## Documents de conception

-   Validation plus stricte des documents de conception. Cette validation n'est pas censée générer de problèmes avec les documents de conception existants, mais les documents de conception incorrectement formés ne seront pas sauvegardés. 
-   Les vues écrites dans un langage non pris en charge répondent toutes avec une erreur `error` `unknown_query_language`. Auparavant, la réponse était `reason` `unknown_query_language`.
-   Lorsqu'un réducteur NULL est utilisé pour insérer un document de conception de base de données, le système répond avec le motif d'erreur `'(null)'`. Auparavant, il renvoyait `((new String("null")))`.
-   Si `updates` est spécifié dans un document de conception, il ne doit pas avoir pour valeur NULL. 

## Authentification

-   `authentication_handlers` des métadonnées `_session` ne contient plus `["delegated", "local"]`.

## Documents utilisateur

-   Validez la structure des documents utilisateur créés dans la base de données `_users`. Après la mise à niveau de DBNext, les documents utilisateur doivent être conformes aux exigences ASF CouchdDB. Auparavant, Cloudant ne validait pas la structure des documents utilisateur.  

## Réplication 

-   Les documents du réplicateur conservent le message d'erreur le plus récent dans la zone JSON `_replication_state_reason`. Cette zone reste identique même après un redémarrage de la réplication et est à l'état `triggered`. Ce changement facilite la détection du code du réplicateur et empêche l'écriture de la même erreur de manière répétée dans le document. 
-   Une erreur survenue au cours de la réplication ne met pas à jour le document de réplication, sauf si le motif de l'erreur change. Auparavant, lorsqu'une erreur se produisait lors de la réplication, une boucle sans fin commençait et générait des fragments considérables.   

## Ensemble de résultats

-   Le noeud final `_db_updates` renvoie un ensemble de résultats contenant une clé nommée `db_name`. Auparavant, il renvoyait un ensemble de résultats doté d'une clé nommée `dbname`.
-   Définissez la longueur maximale de l'ID de document. Auparavant, il n'était pas possible de définir une longueur maximale pour l'ID de document. 

## `dbcopy`

- La fonction `dbcopy` peut générer des problèmes dans certaines circonstances.
  Les informations relatives à cette fonction ont été retirées de la documentation.
  L'utilisation de `dbcopy` est fortement déconseillée. 
