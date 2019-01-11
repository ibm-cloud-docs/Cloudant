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

# {{site.data.keyword.cloud_notm}} Public
{: #ibm-cloud-public}

{{site.data.keyword.cloudantfull}} Public est l'offre la plus riche en fonctionnalités de {{site.data.keyword.cloudant_short_notm}} qui reçoit en premier lieu les mises à jour et les nouvelles fonctionnalités. La tarification est basée sur vos besoins en débit et en stockage, ce qui la rend adaptée à toute charge requise. 

Le [plan Lite](#lite-plan) gratuit offre un montant fixe de capacité de débit et de données destiné au développement et à l'évaluation. Le [plan Standard](#standard-plan) payant offre une tarification configurable pour le débit et le stockage des données mis à disposition qui évolue en fonction de l'évolution des exigences de vos applications.  Un [plan Dedicated Hardware](#dedicated-hardware-plan) en option est également disponible moyennant des frais mensuels supplémentaires pour exécuter une ou plusieurs de vos instances de plan Standard dans un environnement Dedicated Hardware. L'environnement Dedicated Hardware est pour votre utilisation exclusive et si une instance du plan Dedicated Hardware est mise à disposition dans un emplacement américain, vous pouvez éventuellement sélectionner une configuration conforme à la [loi HIPAA (Health Insurance Portability Accountability Act)![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){:new_window}.

Le tableau suivant récapitule la capacité de débit et l'espace disque mis à disposition pour le plan Lite et contient quelques exemples pour le plan Standard :

<div id="maxtable"></div>

<table>

<tr>
<th id="capacity-config-plan">Plan</th><th id="lite">Lite</th><th id="standard" colspan='4'>Standard</th>
</tr>
<tr>
<th id="base-priceperhour" headers="capacity-config-plan">Prix de base (par heure)</td>
<td headers="lite base-priceperhour">0,00 $</td>
<td headers="standard base-priceperhour" colspan='4'>Voir la rubrique <a href="../offerings/pricing.html#pricing" target="_blank">Tarification<img src="../images/launch-glyph.svg" alt="Icône de lien externe" title="Icône de lien externe"></a>.</td>
</tr>
<tr>
<th id="provisionedthroughputcapacity-lookupspersecond" headers="capacity-config-plan">Capacité de débit mise à disposition (consultations par seconde)</td>
<td headers="lite provisionedthroughputcapacity-lookupspersecond-lite">20</td>
<td headers="standard provisionedthroughputcapacity-lookupspersecond">100</td>
<td headers="standard provisionedthroughputcapacity-lookupspersecond">1 000</td>
<td headers="standard provisionedthroughputcapacity-lookupspersecond">5 000</td>
<td headers="standard provisionedthroughputcapacity-lookupspersecond">20 000</td>
</tr>
<tr>
<th id="provisionedthroughputcapacity-writespersecond" headers="capacity-config-plan">Capacité de débit mise à disposition (écritures par seconde)</td>
<td headers="lite provisionedthroughputcapacity-writespersecond">10</td>
<td headers="standard provisionedthroughputcapacity-writespersecond">50</td>
<td headers="standard provisionedthroughputcapacity-writespersecond">500</td>
<td headers="standard provisionedthroughputcapacity-writespersecond">2 500</td>
<td headers="standard provisionedthroughputcapacity-writespersecond">10 000</td>
</tr>
<tr>
<th id="provisionedthroughputcapacity-queriespersecond" headers="capacity-config-plan">Capacité de débit mise à disposition (requêtes par seconde)</td>
<td headers="lite provisionedthroughputcapacity-queriespersecond">5</td>
<td headers="standard provisionedthroughputcapacity-queriespersecond">5</td>
<td headers="standard provisionedthroughputcapacity-queriespersecond">50</td>
<td headers="standard provisionedthroughputcapacity-queriespersecond">250</td>
<td headers="standard provisionedthroughputcapacity-queriespersecond">1 000</td>
</tr>
<tr>
<th id="diskspaceincluded" headers="capacity-config-plan">Espace disque inclus</td>
<td headers="lite diskspaceincluded">1 Go</td>
<td headers="standard diskspaceincluded" colspan='4'>20 Go</td>
</tr>
<tr>
<th id="diskoveragepergbhour" headers="capacity-config-plan">Excédent de disque (par Go/heure)</td>
<td headers="lite diskoveragepergbhour">Non disponible</td>
<td headers="standard diskoveragepergbhour" colspan='4'>Voir la rubrique <a href="../offerings/pricing.html#pricing" target="_blank">Tarification<img src="../images/launch-glyph.svg" alt="Icône de lien externe" title="Icône de lien externe"></a>.</td>
</tr>

</table>

## Plans
{: #plans}

Vous pouvez sélectionner le plan à employer lors de la
[mise à disposition de votre instance de service {{site.data.keyword.cloudant_short_notm}}](#provisioning-a-cloudant-nosql-db-instance-on-ibm-cloud).
Par défaut, le [plan Lite](#lite-plan) est sélectionné.

Sélection du plan de l'instance de service ![{{site.data.keyword.cloudant_short_notm}}](../images/lite_pricing_plan.png)

### Plan Lite
{: #lite-plan}

Le plan Lite est gratuit et est conçu à des fins de développement et d'évaluation. Toutes les fonctionnalités de {{site.data.keyword.cloudant_short_notm}} sont incluses mais les instances du plan Lite ont une capacité de débit et de stockage de données fixe. La capacité de débit mise à disposition est fixée à 20 consultations/seconde, 10 écritures/seconde et 5 requêtes/seconde, et le stockage des données est limité à 1 Go. 

Une vérification de l'utilisation du stockage a lieu tous les jours. Si vous dépassez votre limite de stockage de 1 Go, les demandes adressées à l'instance {{site.data.keyword.cloudant_short_notm}} reçoivent un code d'état 402 avec le message d'erreur "Account has exceeded its data usage quota. An upgrade to a paid plan is required."
Une bannière apparaît également sur le tableau de bord {{site.data.keyword.cloudant_short_notm}}. Vous avez toujours la possibilité de lire et de supprimer des données. Toutefois, pour écrire de nouvelles données, vous avez deux options. La première est de passer à un plan payant, le [plan Standard](#standard-plan), qui supprime immédiatement la limitation en écriture. La seconde est de supprimer des données pour que votre capacité de stockage totale tombe sous la limite de 1 Go et attendre jusqu'à ce que le prochain contrôle quotidien de stockage soit exécuté pour votre instance afin d'autoriser à nouveau les écritures. 

Si vous souhaitez stocker une quantité de données supérieure à 1 Go ou disposer d'une capacité de débit plus élevée, passez au [plan Standard](#standard-plan).

Vous êtes limité à une seule instance de plan Lite {{site.data.keyword.cloudant_short_notm}} par compte {{site.data.keyword.cloud_notm}}. Si vous avez déjà une instance de plan Lite, toute tentative de créer une nouvelle instance de plan Lite, ou de changer une instance de plan Standard en une instance de plan Lite, renvoie le message : "Vous ne pouvez disposer que d'une seule instance d'un plan Lite par service. Pour créer une nouvelle instance, supprimez votre instance de plan Lite existante ou sélectionnez un plan payant".
{: tip}

### Plan Standard
{: #standard-plan}

Le plan {{site.data.keyword.cloudant_short_notm}} Standard est disponible pour tous les comptes payants {{site.data.keyword.cloud}}, que ce soit sous forme de paiement à l'utilisation ou d'abonnement, et peut évoluer pour répondre aux besoins de votre application. Le prix du plan Standard est basé sur deux facteurs : la capacité de débit allouée et la quantité de données stockées dans l'instance. 

Le prix est calculé au prorata horaire avec une capacité de débit de départ mise à disposition de 100 consultations/sec, 50 écritures/sec, et 5 requêtes/sec équivalant à un coût de départ de 0,105 USD/heure. Vous pouvez augmenter ou diminuer la capacité de débit fournie par incréments de 100 consultations/sec, 50 écritures/sec et 5 requêtes/sec dans le tableau de bord {{site.data.keyword.cloudant_short_notm}}. Les coûts sont calculés en fonction de la capacité de débit allouée et non en fonction du volume de demandes mesuré. Le plan Standard inclut 20 Go de stockage de données. Si vous stockez plus de 20 Go, vous êtes facturé sur la base d'un coût défini par Go par heure. 

Voir le Calculateur de prix {{site.data.keyword.cloud_notm}} pour calculer les prix pour les différentes capacités et dans les différentes devises et les informations de [tarification](../offerings/pricing.html#pricing){:new_window} pour voir des exemples d'estimation de coûts.

### Plan Dedicated Hardware
{: #dedicated-hardware-plan}

Une instance de plan {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware est un environnement {{site.data.keyword.cloudant_short_notm}} bare metal qui est mis à disposition pour l'usage exclusif de vos instances de plan {{site.data.keyword.cloudant_short_notm}} Standard. Un environnement de plan {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware peut être fourni dans n'importe quel centre de données [{{site.data.keyword.IBM}} ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/cloud-computing/bluemix/data-centers). Ce plan est nécessaire pour la conformité à HIPAA et doit être sélectionné au moment de la mise à disposition. De plus, les utilisateurs d'un environnement de plan {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware peuvent employer la mise sur liste blanche des adresses IP et les clés de chiffrement BYOK gérées par les clients avec IBM Key Protect. 

Vous pouvez mettre à disposition une ou plusieurs instances de plan Standard et l'environnement Dedicated Hardware se développe ou se contracte en fonction de la capacité et des données utilisées par les instances du plan Standard. Il s'agit d'un prix fixe supplémentaire au prix de consommation des instances de plan Standard {{site.data.keyword.cloudant_short_notm}}. La facturation est calculée au prorata sur une base quotidienne et il y a une durée minimale d'un mois à facturer pour l'environnement. La mise à disposition d'un plan {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware est asynchrone et peut prendre entre 5 et 7 jours ouvrables. Pour créer une instance de plan {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware et y mettre à disposition une instance de plan Standard, suivez les instructions du tutoriel [Création et exploitation d'une instance de plan {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware sur {{site.data.keyword.cloud_notm}} ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](../tutorials/create_dedicated_hardware_plan.html#creating-and-leveraging-a-cloudant-dedicated-hardware-plan-instance-on-bluemix){:new_window}. 

Le plan Dedicated Hardware n'est pas disponible pour les clients {{site.data.keyword.cloud_notm}} Dedicated. Il est uniquement disponible pour les clients {{site.data.keyword.cloud_notm}} Public.
{: tip}

## Capacité de débit mise à disposition
{: #provisioned-throughput-capacity}

La mise à disposition de la capacité de débit est identifiée et mesurée grâce à l'un des trois types d'événement suivants :

1.	Une consultation, qui consiste à lire un document spécifique et est basée sur l'`_id` du document.
2.	Une écriture, qui consiste à créer, modifier ou supprimer un document
individuel, ou à effectuer une mise à jour via une génération d'index.
3.	Une requête, qui est une demande effectuée auprès de l'un des noeuds finaux de
requête {{site.data.keyword.cloudant_short_notm}} et qui peut être des types
suivants :
	-	Index primaire ([`_all_docs`](../api/database.html#get-documents))
	-	Vue MapReduce ([`_view`](../api/creating_views.html#using-views))
	-	Index de recherche ([`_search`](../api/search.html#queries))
	-	Index géospatial ([`_geo`](../api/cloudant-geo.html#querying-a-cloudant-geo-index))
	-	Requête {{site.data.keyword.cloudant_short_notm}} ([`_find`](../api/cloudant_query.html#finding-documents-using-an-index))

La mesure du débit consiste simplement à compter le nombre d'événements de chaque type, par seconde, la seconde étant une fenêtre _glissante_.
Si votre compte connaît un dépassement du nombre d'événements de débit mis à disposition
pour le plan, les demandes sont rejetées jusqu'à ce que le nombre d'événements au sein de
la fenêtre glissante ne dépasse plus le nombre mis à disposition.
Pour plus de facilité, vous pouvez considérer la fenêtre d'une seconde glissante comme une période de 1 000 millisecondes consécutives.

Par exemple, le plan Standard est mis à disposition pour 200 consultations par seconde. Votre compte peut effectuer un maximum de 200 demandes de
consultation au cours d'une période de 1 000 millisecondes consécutives (1 seconde). Les demandes de consultation suivantes effectuées au cours de la période glissante de 1 000 millisecondes sont rejetées jusqu'à ce que le nombre de demandes de consultation
au cours de cette période devienne à nouveau inférieur à 200.

Lorsqu'une demande est rejetée en raison du dépassement du nombre d'événements, les applications reçoivent une réponse [`429` Too Many Requests](../api/http.html#429).

Les versions récentes des bibliothèques client prises en charge (pour les langages
[Java](../libraries/supported.html#java), [Node.js](../libraries/supported.html#node-js) et
[Python](../libraries/supported.html#python)) vous aident à traiter les réponses `429`.
Par exemple, la bibliothèque Java génère une réponse [`TooManyRequestsException` ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](http://static.javadoc.io/com.cloudant/cloudant-client/2.5.1/com/cloudant/client/org/lightcouch/TooManyRequestsException.html){:new_window}.

Par défaut, les bibliothèques client prises en charge ne tentent pas
automatiquement d'effectuer une nouvelle demande en cas de réception d'une réponse
`429`.

Il est préférable de vous assurer que votre application gère correctement les réponses `429`.
En effet, le nombre de nouvelles tentatives est limité ; la violation régulière du nombre
de demandes est un mauvais indicateur pour le passage à une configuration de plan différente.

Si vous portez une application existante, elle risque de ne pas pouvoir gérer une réponse `429`. Dans le cadre de la vérification de la migration, vérifiez que votre application
traite correctement les réponses `429`.
{: tip}

En résumé, vous devez vous assurer que votre application peut gérer correctement
les réponses [`429`](../api/http.html#429).

<div id="servicetier"></div>

### Affichage et modification de la capacité
{: #viewing-and-changing-capacity}

Vous pouvez voir les détails de la capacité de débit des plans disponibles pour votre compte.
Vous pouvez sélectionner le niveau de mise à disposition que vous souhaitez utiliser via l'onglet Compte du tableau de bord de votre compte {{site.data.keyword.cloudant_short_notm}}.

![Tableau de bord du compte](../images/cloudant_capacity.png)

Pour passer à une capacité de débit différente, sélectionnez la mise à disposition souhaitée, puis cliquez sur le bouton `Update`. Vous devez confirmer la modification et vous êtes informé que la modification de la mise à disposition peut
prendre jusqu'à 24 heures.

![Tableau de bord du compte](../images/cloudant_capacity_change.png)

La taille de l'augmentation de capacité est limitée à 10 unités (1000 consultations/seconde, 500 écritures/secondet et 50 requêtes/seconde) par échange. Les diminutions ne sont pas limitées par le nombre d'unités. Tout changement de capacité, qu'il s'agisse d'une augmentation ou d'une diminution, est limité à une fois par heure. Si vous avez besoin d'une capacité supérieure à celle disponible sur le tableau de bord {{site.data.keyword.cloudant_short_notm}}, contactez le [support {{site.data.keyword.cloudant_short_notm}} ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](mailto:support@cloudant.com){:new_window}.
{: tip}

<div id="throughput"></div>

### Surveillance de l'utilisation 
{: #monitoring-usage}

Des informations sur votre utilisation sont disponibles dans le panneau Opérations en cours de l'onglet Surveillance de votre tableau de bord {{site.data.keyword.cloudant_short_notm}}. 

![Surveillance de l'utilisation sur le tableau de bord](../images/cloudant_usage.png)

Vous y trouverez des détails sur votre [débit](#provisioned-throughput-capacity) en cours, ainsi que sur la quantité de [données stockées](#disk-space-included).

La surveillance vous aide à prendre conscience qu'un changement de mise à
disposition de votre plan pourrait être à envisager.
Par exemple, si vous approchez régulièrement le nombre maximum de consultations dans la base de données, vous pouvez modifier la mise à disposition via le panneau [Service](#servicetier) de l'onglet Compte du tableau de bord. 

## Utilisation des données
{: #data-usage}

### Espace disque inclus
{: #disk-space-included}

Cette valeur représente la capacité de stockage incluse dans le plan.
Elle est indiquée pour le stockage des données et des index.

### Excédent de disque
{: #disk-overage}

Tous les plans Standard et Lite incluent un espace disque qui
est utilisé pour les données JSON, les annexes et les index. Tous les plans Standard et Lite sont surveillés pour vérifier l'espace disque utilisé. Lorsque la quantité de données utilisées dépasse la quantité allouée par le plan, vous pouvez vous attendre à ce que les conditions décrites dans le tableau suivant s'appliquent :

<table>

<tr>
<th id="disk-overage-plan">Plan</th><th id="description">Description</th>
</tr>
<tr>
<th headers="standard-plan">Standard</td>
<td headers="description"><p>
<ul><li>Si le compte utilise plus que la quantité de stockage allouée dans la configuration de votre
plan, il est considéré comme étant en "dépassement".
Le dépassement entraîne la facturation du compte au tarif indiqué pour chaque Go supplémentaire utilisé au-delà de l'allocation du plan.</li>
<li>La somme supplémentaire que vous devez payer pour dépasser l'espace disque fourni dans le plan est appelé 'excédent'. Un excédent est calculé sur une base horaire.</li></ul></p></td>
</tr>
<tr>
<th headers="lite-plan">Lite</td>
<td headers="description"><p>
<ul><li>L'utilisation du disque est plafonnée sur le plan Lite. Une fois le plafond atteint, vous ne pouvez plus écrire de nouvelles données. Pour écrire de nouvelles données, vous devez soit passer au plan Standard, soit supprimer des données et attendre que le prochain contrôle soit exécuté pour que votre compte soit réactivé.</p>
</li></ul></td>
</tr>
</table>

Par exemple, supposons que votre plan Standard augmente l'utilisation du disque à 107 Go pendant une demi-journée (12 heures). Cela signifie que votre instance a entraîné un dépassement de 87 Go par rapport aux 20
Go fournis par l'allocation du plan pendant 12 heures.
Vous seriez donc facturé de frais en excédent basés sur 87 Go x 12 heures = 1044 Go heures pour cet espace supplémentaire.

L'excédent est calculé selon le nombre maximal de Go supplémentaire utilisé par rapport à l'allocation du plan pendant une heure en spécifique au cours du cycle de facturation.

### Exemple d'excédent de disque
{: #disk-overage-example}

Supposons que vous commencez un mois de 30 jours avec une instance de service de Plan standard qui utilise 9 Go de stockage.
Votre stockage augmente ensuite pour atteindre 21,5 Go pendant 15 minutes au cours de l'heure commençant à 02h00 du jour 3.
L'instance revient ensuite à 9,5 Go pendant les 10 minutes qui suivent, puis augmente à
nouveau pour atteindre 108 Go pendant les 25 minutes suivantes, toujours dans l'heure commençant à 02h00.
Finalement, votre instance termine l'heure et le reste du mois avec un stockage revenu à 28 Go.

Ce schéma signifie que le nombre maximal de Go supplémentaire par rapport à l'allocation du plan est de 88 Go pendant l'heure 2 du jour 3.
Pendant l'heure commençant à 03h00 du jour 3 et le reste du mois, votre instance était supérieure de
8 Go par rapport à l'allocation du plan.

Par conséquent, pour l'heure 02h00 du jour 3, votre facture comprend un excédent de 88 Go x 1 heure = 88 Go heures.

Pour l'heure 03h00 du jour 3 et jusqu'à la fin du jour 3, votre facture comprend un excédent de 8 Go x 21 heures = 168 Go heures.

Pour l'heure 00h00 du jour 4 et jusqu'à la fin du mois (de 30 jours), votre facture comprend un excédent de 8 Go x 24 heures x 27 jours = 5184 Go heures.

La facture de l'excédent total du mois indique un total de 88 + 168 + 5184 = 5440 Go heures.

## Limites de taille pour les demandes et les documents
{: #request-and-document-size-limits}

Les limites de taille qui s'appliquent aux demandes et aux documents JSON {{site.data.keyword.cloudant_short_notm}} sont les suivantes : 

Limite | Taille maximale
------|-------------
Taille de document individuel | 1 Mo
Taille de pièce jointe unique | 10 Mo
Taille de corps de demande | 11 Mo

Lorsque l'une de ces limites de taille est dépassée, un [réponse 413](../api/http.html#413) est générée.

Il est recommandé de stocker des pièces jointes binaires ou des objets BLOB JSON volumineux dans un espace de stockage d'objets et de sauvegarder un lien vers l'emplacement dans un document JSON {{site.data.keyword.cloudant_short_notm}}.   

Lorsque vous effectuez des réplications, les documents ou les pièces jointes dont la taille est supérieure à ces limites ne sont pas répliqués dans la base de données cible. Vous trouverez [ici](../api/replication.html#replication-errors) davantage d'informations sur la procédure à suivre pour détecter des erreurs de réplication.

## Emplacements et service
{: #locations-and-tenancy}

Par défaut, tous les plans Lite et Standard sont déployés dans des environnements à service partagé. Lorsque vous sélectionnez un plan, vous pouvez choisir l'une des régions suivantes de {{site.data.keyword.cloud_notm}} Public :

-   Est des Etats-Unis
-   Sud des Etats-Unis
-   Royaume Uni
-   Sydney
-   Allemagne&Dagger;
-   Asie Pacifique Nord (Tokyo)

Les instances du plan Dedicated Hardware peuvent être déployées dans la plupart
[ des emplacements de centre de données {{site.data.keyword.IBM_notm}} ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/cloud-computing/bluemix/data-centers).
Voir le menu déroulant dans le catalogue {{site.data.keyword.cloud_notm}} pour consulter la liste actualisée des emplacements disponibles.

&Dagger;Toutes les instances {{site.data.keyword.cloudant_short_notm}} qui sont déployées dans la région Allemagne pour
{{site.data.keyword.cloud_notm}} Public sont déployées dans des environnements gérés par l'UE. Tout compte {{site.data.keyword.cloudant_short_notm}} ou toute clé d'API qui est généré en dehors de l'environnement géré par l'UE ne peut pas se voir accorder un accès à une instance {{site.data.keyword.cloudant_short_notm}} gérée par l'UE.

## Méthodes d'authentification
{: #authentication-methods}

L'accès à {{site.data.keyword.cloudant_short_notm}} s'effectue à l'aide d'une API HTTPS. Lorsque le noeud final d'API l'exige, l'utilisateur est authentifié pour chaque requête HTTPS reçue par {{site.data.keyword.cloudant_short_notm}}. Pendant la mise à disposition, les méthodes d'authentification disponibles sont : 'Use both legacy credentials and IAM' (Utiliser les données d'identification existantes et IAM) ou 'Use only IAM' (Utiliser uniquement IAM). Pour plus d'informations, consultez le [guide IAM](../guides/iam.html){:new_window} ou le document [API d'authentification](../api/authentication.html){:new_window}.

Une fois qu'une instance {{site.data.keyword.cloudant_short_notm}} a été mise à disposition, l'URL de connexion et les détails d'autorisation de l'IAM peuvent être trouvés en générant de nouvelles données d'identification dans l'onglet Données d'identification pour le service du tableau de bord {{site.data.keyword.cloud_notm}}. Si vous choisissez cette option durant la mise à disposition, le nom d'utilisateur {{site.data.keyword.cloudant_short_notm}} existant et le mot de passe sont également inclus.


## Haute disponibilité, reprise après incident et sauvegarde
{: #high-availability-disaster-recovery-and-backup}

Dans le but de fournir la haute disponibilité et la reprise après incident au sein d'un centre de données, toutes les données sont stockées en trois exemplaires sur trois serveurs physiques distincts d'un cluster. Vous pouvez mettre à disposition des comptes dans plusieurs centres de données, puis
faire appel à la réplication de données en continu pour fournir les fonctions de haute
disponibilité et de reprise après incident sur ces différents centres de données. Les données {{site.data.keyword.cloudant_short_notm}} ne sont pas automatiquement sauvegardées, mais des outils pris en charge sont fournis pour gérer les sauvegardes. Consultez le guide [Reprise après incident et sauvegarde ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://console.bluemix.net/docs/services/Cloudant/guides/disaster-recovery-and-backup.html#disaster-recovery-and-backup) pour explorer toutes les considérations relatives à la haute disponibilité, à la reprise après sinistre et à la sauvegarde afin de répondre aux exigences de votre application. 

## Support
{: #support}

Le support des instances de service des plans Standard et Dedicated est facultatif.
Il est fourni si vous achetez le *support standard {{site.data.keyword.cloud_notm}}*. Le support n'est pas disponible pour le plan Lite.

Pour en savoir plus sur les plans de support, consultez les [plans de support standard de {{site.data.keyword.cloud_notm}}![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/cloud/support#944376){:new_window}. Pour en savoir plus sur le support, consultez le [guide de support {{site.data.keyword.IBM_notm}} ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/support/home/pages/support-guide/){:new_window}.

Les systèmes de support utilisés pour {{site.data.keyword.cloudant_short_notm}} n'offrent pas de fonction pour la protection des contenus comportant des informations de soins de santé, des données de santé, des informations de santé protégées ou des données soumises à des exigences réglementaires supplémentaires. A ce titre, le client ne doit pas fournir ou saisir ce type de données.
{: tip}

## Mise à disposition d'une instance {{site.data.keyword.cloudant_short_notm}} sur {{site.data.keyword.cloud_notm}}
{: #provisioning-a-cloudant-nosql-db-instance-on-ibm-cloud}

Vous pouvez mettre à disposition une instance de plan Lite ou Standard {{site.data.keyword.cloudant_short_notm}} sur {{site.data.keyword.cloud_notm}} de deux manières :

- A l'aide du tableau de bord. Un tutoriel qui décrit ce processus est disponible [ici![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://console.bluemix.net/docs/services/Cloudant/tutorials/create_service.html#creating-a-cloudant-instance-on-bluemix){:new_window}.
- A l'aide de l'outil de ligne de commande Cloud Foundry. Un tutoriel qui décrit ce processus est disponible [ici![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://console.bluemix.net/docs/services/Cloudant/tutorials/create_service_cli.html#creating-a-cloudant-instance-on-bluemix-using-the-cloud-foundry-tools){:new_window}.
 
Pour créer et optimiser une instance de plan {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware, suivez le tutoriel qui décrit le processus [ici ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://console.bluemix.net/docs/services/Cloudant/tutorials/create_dedicated_hardware_plan.html#creating-and-leveraging-a-cloudant-dedicated-hardware-plan-instance-on-bluemix){:new_window}.




