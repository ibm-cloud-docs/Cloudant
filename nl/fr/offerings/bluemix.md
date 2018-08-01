---

copyright:
  years: 2015, 2018
lastupdated: "2018-06-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2018-06-05 -->

# {{site.data.keyword.Bluemix_notm}} public
{: #ibm-cloud-public}

{{site.data.keyword.cloudantfull}} public est l'offre la plus riche en fonctionnalités de {{site.data.keyword.cloudant_short_notm}} qui reçoit en premier lieu les mises à jour et les nouvelles fonctionnalités. La tarification est basée sur vos besoins en débit et en stockage, ce qui la rend adaptée à toute charge requise. 

Le [plan limité](#lite-plan) gratuit offre un montant fixe de capacité de débit et de données destiné au développement et à l'évaluation. Le [plan standard](#standard-plan) payant offre une tarification configurable pour le débit et le stockage des données mis à disposition qui évolue en fonction de l'évolution des exigences de vos applications. Un [forfait ou Plan de matériel dédié](#dedicated-hardware-plan) en option est également disponible moyennant des frais mensuels supplémentaires pour exécuter une ou plusieurs de vos instances de Plan standard dans un environnement matériel dédié. L'environnement matériel dédié est pour votre utilisation exclusive et si une instance de plan de matériel dédié est mise à disposition dans un emplacement américain, vous pouvez éventuellement sélectionner une configuration conforme à la [loi HIPAA (Health Insurance Portability Accountability Act)![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){:new_window}.

Le tableau suivant récapitule la configuration de capacité de débit et d'espace disque mise à disposition pour le plan limité et contient quelques exemples pour le plan standard :

<div id="maxtable"></div>

<table border='1'>

<tr>
<th id="plans">Plans</th><th id="lite">Limité</th><th id="standard" colspan='4'>Standard</th>
</tr>
<tr>
<th id="base-priceperhour" headers="plans">Prix de base (par heure)</td>
<td headers="lite base-priceperhour">0,00 $</td>
<td headers="standard base-priceperhour" colspan='4'>Voir la rubrique <a href="../offerings/pricing.html#pricing" target="_blank">Tarification<img src="../images/launch-glyph.svg" alt="Icône de lien externe" title="Icône de lien externe"></a>.</td>
</tr>
<tr>
<th id="provisionedthroughputcapacity-lookupspersecond" headers="plans">Capacité de débit mise à disposition (consultations par seconde)</td>
<td headers="lite provisionedthroughputcapacity-lookupspersecond-lite">20</td>
<td headers="standard provisionedthroughputcapacity-lookupspersecond">100</td>
<td headers="standard provisionedthroughputcapacity-lookupspersecond">1 000</td>
<td headers="standard provisionedthroughputcapacity-lookupspersecond">5 000</td>
<td headers="standard provisionedthroughputcapacity-lookupspersecond">20 000</td>
</tr>
<tr>
<th id="provisionedthroughputcapacity-writespersecond" headers="plans">Capacité de débit mise à disposition (écritures par seconde)</td>
<td headers="lite provisionedthroughputcapacity-writespersecond">10</td>
<td headers="standard provisionedthroughputcapacity-writespersecond">50</td>
<td headers="standard provisionedthroughputcapacity-writespersecond">500</td>
<td headers="standard provisionedthroughputcapacity-writespersecond">2 500</td>
<td headers="standard provisionedthroughputcapacity-writespersecond">10 000</td>
</tr>
<tr>
<th id="provisionedthroughputcapacity-queriespersecond" headers="plans">Capacité de débit mise à disposition (requêtes par seconde)</td>
<td headers="lite provisionedthroughputcapacity-queriespersecond">5</td>
<td headers="standard provisionedthroughputcapacity-queriespersecond">5</td>
<td headers="standard provisionedthroughputcapacity-queriespersecond">50</td>
<td headers="standard provisionedthroughputcapacity-queriespersecond">250</td>
<td headers="standard provisionedthroughputcapacity-queriespersecond">1 000</td>
</tr>
<tr>
<th headers="diskspaceincluded" headers="plans">Espace disque inclus</td>
<td headers="lite diskspaceincluded">1 Go</td>
<td headers="standard diskspaceincluded" colspan='4'>20 Go</td>
</tr>
<tr>
<th headers="diskoveragepergbhour" headers="plans">Excédent de disque (par Go/heure)</td>
<td headers="lite diskoveragepergbhour">Non disponible</td>
<td headers="standard diskoveragepergbhour" colspan='4'>Voir la rubrique <a href="../offerings/pricing.html#pricing" target="_blank">Tarification<img src="../images/launch-glyph.svg" alt="Icône de lien externe" title="Icône de lien externe"></a>.</td>
</tr>

</table>

## Plans
{: #plans}

Vous pouvez sélectionner le plan à employer lors de la [mise à disposition de votre instance
de service {{site.data.keyword.cloudant_short_notm}}](#provisioning-a-cloudant-instance-on-bluemix).
Par défaut, le [Plan limité](#lite-plan) est sélectionné.

Sélection du plan de l'instance de service ![{{site.data.keyword.cloudant_short_notm}}](../images/fb87416a.png)

### Plan limité
{: #lite-plan}

Le Plan limité est gratuit, mais vous
limite à un maximum de 1 Go de stockage de données.
Des limites s'appliquent également à la capacité de débit mise à disposition pour les consultations, les écritures et
les requêtes. 

Une vérification de l'utilisation du stockage a lieu tous les jours. Si vous dépassez votre limite de stockage, les demandes HTTP émises auprès du compte reçoivent un
code d'état 402 assorti du message d'erreur : "Account has exceeded its data usage quota. An upgrade to a paid plan is required."
Une bannière apparaît également sur le tableau de bord {{site.data.keyword.cloudant_short_notm}} pour vous informer. Vous avez toujours la possibilité de lire et de supprimer des données. Toutefois,
si vous souhaitez écrire de nouvelles données, vous devez effectuer une mise à niveau vers un compte payant ou supprimer des données et patienter jusqu'à la vérification suivante pour que votre compte soit réactivé. 

Si vous désirez stocker une quantité de données supérieure à 1 Go ou disposer d'une capacité de débit plus élevée, passez au [Plan standard](#standard-plan).

### Plan standard
{: #standard-plan}

Le Plan standard inclut 20 Go de stockage de données.
Si vous stockez plus de 20 Go, vous êtes facturé sur la base d'un coût défini par Go par heure.
Pour connaître le coût actuel, voir la rubrique [Tarification](../offerings/pricing.html#pricing){:new_window}.
Le plan standard vous permet également de modifier la capacité de débit pour les
consultations, les écritures et les requêtes.

### Plan de matériel dédié
{: #dedicated-hardware-plan}

Vous pouvez aussi exécuter vos instances de plan standard dans un environnement matériel dédié dans n'importe quel [centre de données {{site.data.keyword.IBM}} ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/cloud-computing/bluemix/data-centers) moyennant un forfait mensuel. Vous pouvez acheter un seul plan de matériel dédié pour un emplacement donné et pouvez y mettre à disposition une ou plusieurs instances de plan standard. Ce plan est nécessaire pour la conformité à HIPAA et doit être sélectionné au moment de la mise à disposition. 

Le plan de matériel dédié n'est pas disponible pour les clients de {{site.data.keyword.Bluemix_notm}} dédié et n'est disponible que pour les clients {{site.data.keyword.Bluemix_notm}} public.
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

Par exemple, le plan standard est mis à disposition pour 200 consultations par seconde. Votre compte peut effectuer un maximum de 200 demandes de
consultation au cours d'une période de 1 000 millisecondes consécutives (1 seconde).
Les demandes de consultation suivantes effectuées au cours de la période glissante de 1 000 millisecondes sont rejetées jusqu'à ce que le nombre de demandes de consultation
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

Pour passer à une capacité de débit différente, sélectionnez la mise à disposition souhaitée, puis cliquez sur le bouton `Update`.
Vous devez confirmer la modification et vous êtes informé que la modification de la mise à disposition peut
prendre jusqu'à 24 heures.

![Tableau de bord du compte](../images/cloudant_capacity_change.png)

<div id="throughput"></div>

### Surveillance de l'utilisation 
{: #monitoring-usage}

Vous trouverez des informations sur votre utilisation dans le panneau Current Operations de l'onglet Monitoring de votre tableau de bord {{site.data.keyword.cloudant_short_notm}}. 

![Surveillance de l'utilisation sur le tableau de bord](../images/cloudant_usage.png)

Vous y trouverez des détails sur votre [débit](#provisioned-throughput-capacity) en cours, ainsi que sur la quantité de [données stockées](#disk-space-included).

La surveillance vous aide à prendre conscience qu'un changement de mise à
disposition de votre plan pourrait être à envisager.
Par exemple, si vous approchez
régulièrement du nombre maximal de consultations de base de données, vous pouvez modifier la mise à disposition grâce au panneau [Service](#servicetier)
de l'onglet Compte du tableau de bord.

## Utilisation des données
{: #data-usage}

### Espace disque inclus
{: #disk-space-included}

Cette valeur représente la capacité de stockage incluse dans le plan.
Elle est indiquée pour le stockage des données et des index.

### Excédent de disque
{: #disk-overage}

Toutes les instances de service des Plans standard et limité font l'objet d'une surveillance quant à l'espace disque utilisé.
Si
le compte utilise plus que la quantité de stockage fournie dans la configuration de votre
plan, il est considéré comme étant en "dépassement".
Le dépassement entraîne la facturation du compte au tarif indiqué pour chaque Go supplémentaire utilisé au-delà de l'allocation du plan.

La somme supplémentaire que vous devez payer pour l'utilisation d'une quantité d'espace disque supérieure à l'espace disque fourni est appelé "excédent".
L'excédent est calculé sur une base horaire.
Il n'est pas possible d'utiliser plus que l'espace disque disponible dans le Plan limité.

Supposons, par exemple, que votre instance de Plan standard augmente l'utilisation
du disque jusqu'à atteindre 107 Go pendant une demie-journée (12 heures).
Cela signifie que votre instance a entraîné un dépassement de 87 Go par rapport aux 20
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
 

Limite |Taille maximale 
------|-------------
Taille de document individuel | 1 Mo
Taille de pièce jointe unique | 10 Mo
Taille de corps de demande | 11 Mo 

Lorsque l'une de ces limites de taille est dépassée, un [réponse 413](../api/http.html#413) est générée.

Il est recommandé de stocker des pièces jointes binaires ou des objets BLOB JSON volumineux dans un espace de stockage d'objets et de sauvegarder un lien vers l'emplacement dans un document JSON {{site.data.keyword.cloudant_short_notm}}.    

Lorsque vous effectuez des réplications, les documents ou les pièces jointes dont la taille est supérieure à ces limites ne sont pas répliqués dans la base de données cible. Vous trouverez [ici](../api/replication.html#replication-errors) davantage d'informations sur la procédure à suivre pour détecter des erreurs de réplication. 

## Emplacements et service
{: #locations-and-tenancy}

Par défaut, tous les Plans limité et standard sont déployés dans des environnements à service partagé. Lorsque vous sélectionnez un plan, vous pouvez choisir l'une des régions suivantes de {{site.data.keyword.Bluemix_notm}} Public :

-   Est des Etats-Unis
-   Sud des Etats-Unis
-   Royaume Uni
-   Sydney
-   Allemagne&Dagger;

Des instances de plan de matériel dédié peuvent être déployées dans la plupart
[ des emplacements de centre de données {{site.data.keyword.IBM_notm}} ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/cloud-computing/bluemix/data-centers).
Voir le menu déroulant dans le catalogue {{site.data.keyword.Bluemix_notm}} pour consulter une mise à jour de la liste des emplacements disponibles.

&Dagger;Touts les instances {{site.data.keyword.cloudant_short_notm}} qui sont déployés à partir de la région Allemagne pour
{{site.data.keyword.Bluemix_notm}} public sont déployés dans des environnements gérés par l'UE.
Tout compte {{site.data.keyword.cloudant_short_notm}} ou toute clé d'API qui est généré en dehors de l'environnement géré par l'UE ne peut pas se voir accorder un accès à une instance {{site.data.keyword.cloudant_short_notm}} gérée par l'UE. 

## Sécurité, chiffrement et conformité
{: #security-encryption-and-compliance}

Tous les plans sont fournis sur des serveurs dotés d'un chiffrement de disque
[au repos ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://en.wikipedia.org/wiki/Data_at_rest){:new_window}.
L'accès est chiffré sur une connexion réseau utilisant HTTPS.
Pour plus de détails, voir [{{site.data.keyword.Bluemix_notm}}Sécurité ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://console.bluemix.net/docs/services/Cloudant/offerings/security.html#security){:new_window}.

Les plans offrent également une [Certification de conformité à la sécurité ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://cloudant.com/product/cloudant-features/cloudant-compliance/){:new_window}.
La conformité [HIPAA ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){:new_window}
requiert un [environnement dédié](#dedicated-hardware-plan) ; vous devez donc demander cet environnement dans le cadre du [processus de mise à disposition](#provisioning-a-cloudant-instance-on-bluemix).

<div id="byok"></div>

Si vous avez besoin du mode de chiffrement BYOK (bring-your-own-key) pour les données au repos, il est activé à l'aide de {{site.data.keyword.cloud}} Key
Protect. {{site.data.keyword.cloudant_short_notm}} prend en charge cette fonction pour les nouvelles instances de [plan matériel dédié](https://console.bluemix.net/docs/services/Cloudant/offerings/bluemix.html#ibm-cloud-public) {{site.data.keyword.cloudant_short_notm}} qui sont déployées dans toutes les régions.
Tout d'abord, créez une instance du plan matériel dédié à l'aide du [catalogue {{site.data.keyword.cloud_notm}}](https://console.bluemix.net/catalog/). Soumettez ensuite un ticket de demande de service. Notre équipe de support se chargera d'obtenir les clés de chiffrement des données au repos de votre nouvelle instance de matériel dédié qui sont gérées par votre instance Key Protect. 

## Haute disponibilité, reprise après incident et sauvegarde
{: #high-availability-disaster-recovery-and-backup}

Dans le but de fournir la haute disponibilité et la reprise après incident au sein d'un centre de données, toutes les données sont stockées en trois exemplaires sur trois serveurs physiques distincts d'un cluster. Vous pouvez mettre à disposition des comptes dans plusieurs centres de données, puis
faire appel à la réplication de données en continu pour fournir les fonctions de haute
disponibilité et de reprise après incident sur ces différents centres de données. Les données {{site.data.keyword.cloudant_short_notm}} ne sont pas automatiquement sauvegardées, mais des outils pris en charge sont   
fournis pour traiter les sauvegardes. Consultez le guide [Reprise après incident et sauvegarde ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://console.bluemix.net/docs/services/Cloudant/guides/disaster-recovery-and-backup.html#disaster-recovery-and-backup) pour explorer toutes les considérations relatives à la haute disponibilité, à la reprise après sinistre et à la sauvegarde afin de répondre aux exigences de votre application. 

## Support
{: #support}

Le support des instances de service des Plans standard et dédié est facultatif.
Il est fourni si vous achetez le "Support standard {{site.data.keyword.Bluemix}}".
Le support n'est pas disponible pour le Plan limité.

Une calculatrice de prix du Support standard
{{site.data.keyword.Bluemix_notm}} est disponible [ici ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://console.ng.bluemix.net/?direct=classic/#/pricing/cloudOEPaneId=pricing&paneId=pricingSheet){:new_window}.
Vous trouverez des informations sur les détails de l'accord sur les niveaux de service de support (SLA)
[ici ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](http://www-03.ibm.com/software/sla/sladb.nsf/pdf/6606-08/$file/i126-6606-08_05-2016_en_US.pdf){:new_window}.

## Mise à disposition d'une instance {{site.data.keyword.cloudant_short_notm}} sur {{site.data.keyword.Bluemix_notm}}
{: #provisioning-a-cloudant-nosql-db-instance-on-ibm-cloud}

Vous pouvez mettre à disposition une instance de plan limité ou standard {{site.data.keyword.cloudant_short_notm}} sur {{site.data.keyword.Bluemix}} de deux manières :

- A l'aide du tableau de bord. Un tutoriel qui décrit ce processus est disponible [ici![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://console.bluemix.net/docs/services/Cloudant/tutorials/create_service.html#creating-a-cloudant-instance-on-bluemix){:new_window}.
- A l'aide de l'outil de ligne de commande Cloud Foundry. Un tutoriel qui décrit ce processus est disponible [ici![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://console.bluemix.net/docs/services/Cloudant/tutorials/create_service_cli.html#creating-a-cloudant-instance-on-bluemix-using-the-cloud-foundry-tools){:new_window}.
 
Pour créer et optimiser une instance de plan de matériel dédié {{site.data.keyword.cloudant_short_notm}}, suivez le tutoriel qui décrit le processus [ici ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://console.bluemix.net/docs/services/Cloudant/tutorials/create_dedicated_hardware_plan.html#creating-and-leveraging-a-cloudant-dedicated-hardware-plan-instance-on-bluemix){:new_window}.




