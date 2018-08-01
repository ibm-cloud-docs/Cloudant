---

copyright:
  years: 2017, 2018
lastupdated: "2018-06-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-01-11 -->

# Création d'une application {{site.data.keyword.cloud_notm}} simple permettant d'accéder à une base de données {{site.data.keyword.cloudant_short_notm}} : maintenance et traitement des incidents 

Ce tutoriel vous explique comment effectuer des opérations de maintenance sur une
application {{site.data.keyword.cloud}} hébergée dans votre instance de service {{site.data.keyword.cloud_notm}}.
{:shortdesc}

<div id="maintenance"></div>

## Tâches de maintenance de base sur une application

Cette section du tutoriel explique comment actualiser, démarrer et arrêter vos applications Python sur {{site.data.keyword.cloud_notm}}.

### Recherche du statut de votre application

Le statut des applications d'une instance de service {{site.data.keyword.cloud_notm}} apparaît sur le tableau de bord.

Dans l'exemple suivant, l'application `Cloudant Python` n'est pas en cours d'exécution et est à l'état `Arrêté` :<br/>
![Capture d'écran montrant le tableau de bord de l'application dans un état Arrêté](images/img0037.png)

### Démarrage de votre application

>   **Remarque** : Si vous tentez de démarrer l'application du tutoriel
    sans supprimer au préalable la base de données de démonstration du tutoriel,
    l'application ne peut pas fonctionner correctement.
    L'application entre dans un cycle dans lequel elle tente de démarrer, échoue car la
base de données existe, s'arrête et tente à nouveau de démarrer.
    Pour résoudre ce
problème, [arrêtez l'application](#stopping-your-application) puis
supprimez la base de données de démonstration du tutoriel.
    L'application peut ensuite démarrer avec succès.

Pour démarrer une application arrêtée, cliquez d'abord sur l'icône du menu de
l'application dans le tableau de bord :<br/>
![Capture d'écran représentant le tableau de bord avec l'icône de gestion de l'application](images/img0038.png)

Cliquez ensuite sur l'option `Démarrer l'application` dans le menu :<br/>
![Capture d'écran montrant l'option 'Démarrer l'application'](images/img0039.png)

### Arrêt de votre application

Pour arrêter une application en cours d'exécution, cliquez d'abord sur l'icône du menu de l'application dans le tableau de bord :<br/>
![Capture d'écran représentant le tableau de bord avec l'icône de gestion de l'application](images/img0040.png)

Cliquez ensuite sur l'option `Arrêter l'application` dans le menu :<br/>
![Capture d'écran montrant l'option 'Arrêter l'application'](images/img0041.png)

<div id="troubleshooting"></div>

### Téléchargement d'une version actualisée de votre application

Pour télécharger une version actualisée de votre application, suivez simplement le [processus de téléchargement](create_bmxapp_upload.html).
La nouvelle version remplace l'ancienne version de l'application.

>   **Remarque** : Si l'ancienne version de l'application est déjà en cours d'exécution lorsque vous entamez le téléchargement,
    {{site.data.keyword.cloud_notm}} commence automatiquement par arrêter l'application.

## Diagnostic et résolution des problèmes

Cette section du tutoriel fournit quelques conseils en matière de traitement des
incidents pour vous aider à identifier, diagnostiquer et résoudre certains problèmes que
vous êtes susceptible de rencontrer au cours du développement et du déploiement de vos
premières applications {{site.data.keyword.cloud_notm}}.

Des conseils et les meilleures pratiques en matière de création d'applications {{site.data.keyword.cloud_notm}} ou Cloud Foundry sont disponibles [ici ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://docs.cloudfoundry.org/devguide/deploy-apps/prepare-to-deploy.html){:new_window}.

En particulier, il est prudent de suivre le conseil qui permet d'[éviter les écritures sur le système de fichiers local ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://docs.cloudfoundry.org/devguide/deploy-apps/prepare-to-deploy.html#filesystem){:new_window}.

>   **Remarque** : Pour plus de simplicité,
    ce tutoriel écrit du contenu dans le système de fichiers local.
    Le volume
ainsi écrit est toutefois faible.
    Il n'est pas censé persister et n'est pas considéré comme 'indispensable à la mission'.

### Utilisation du journal de l'application

La ressource la plus utile pour le diagnostic et la résolution des problèmes liés
à une application {{site.data.keyword.cloud_notm}} est le fichier journal.

Le fichier journal d'une application {{site.data.keyword.cloud_notm}} se trouve sur la page d'informations `Journaux` :<br/>
![Capture d'écran montrant le lien permettant d'accéder à la page d'informations Journaux](images/img0042.png)

Comme la plupart des fichiers journaux, le journal d'une application
{{site.data.keyword.cloud_notm}} contient des détails sur les événements
survenus et indique quand ils se sont produits.

Le journal identifie également les composants impliqués dans l'événement enregistré.
Le tableau suivant identifie les composants clés :

Libellé du composant | Composant
----------------|----------
`API`           | Système Cloud Foundry
`APP`           | Votre application
`CELL`          | Conteneur détenant votre application dans {{site.data.keyword.cloud_notm}}
`RTR`           | Les composants réseau transmettent des messages vers ou depuis votre application.

Par exemple, la capture d'écran suivante inclut un certain nombre d'événements type :<br/>
![Capture d'écran montrant des informations du journal à titre d'indication](images/img0043.png)

Vous remarquerez les événements suivants :

-   A 1:56:56 PM, l'application a démarré avec succès.
-   A 1:58:43 PM, le réseau a reçu une demande HTTP simple : `GET /`.
-   Plus tard, l'application a reçu la demande HTTP et y a répondu.
-   A 2:13:46 PM, une demande d'arrêt de l'application a été reçue.
-   A 2:13:48 PM, l'application a achevé le processus d'arrêt.

L'application décrite dans ce tutoriel est délibérément minimale.
Ainsi, aucune tentative n'a été effectuée pour déterminer si la base de données cible
existait et, si elle n'avait pas existé, pour éviter de la créer à nouveau.
Par conséquent, si vous essayez d'exécuter l'application du tutoriel plusieurs fois sans
supprimer au préalable la base de données, l'application échoue et redémarre de manière répétée.

La capture d'écran suivante illustre ce comportement :<br/>
![Capture d'écran montrant les informations d'erreur du journal](images/img0044.png)

A 2:31:23 PM, l'application a détecté un problème :<br/>
`"Database {0} already exists".format(dbname)`

Les autres messages sont typiques d'une application Python qui rencontre un problème.

En effet, le journal indique le composant ayant rencontré un problème et fournit autant de détails que possible.
Vous devez ensuite appliquer les procédures de traitement des incidents normales afin de résoudre le problème.

## Fin du tutoriel

Le tutoriel est terminé.
