---

copyright:
  years: 2015, 2017
lastupdated: "2017-06-09"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-02-23 -->

# IBM Bluemix

{{site.data.keyword.cloudant}} est également disponible en tant que [service {{site.data.keyword.Bluemix}} ![External link icon](../images/launch-glyph.svg "External link icon")](https://console.ng.bluemix.net/catalog/services/cloudant-nosql-db/){:new_window}.
{:shortdesc}

{{site.data.keyword.Bluemix_short}} est une plateforme à normes ouvertes reposant sur le cloud qui permet de construire, d'exécuter et de gérer des applications.
Pour en savoir plus sur {{site.data.keyword.Bluemix_notm}} et commencer à
l'utiliser, consultez sa [page d'accueil ![External link icon](../images/launch-glyph.svg "External link icon")](https://console.ng.bluemix.net/){:new_window}.

## Bluemix Public

{{site.data.keyword.cloudantfull}} est disponible en tant que [plan Lite plan](#lite-plan) gratuit et sous forme de configurations
multiples dans le [plan standard](#standard-plan) payant.
Un [plan dédié](#dedicated-plan) est également disponible.
Ce plan propose la même configurabilité que le plan standard, mais est fourni sur un
matériel dédié.
Le matériel dédié n'est pas partagé avec d'autres comptes, ce qui signifie qu'il
est exclusivement destiné à votre utilisation.
Si une instance de plan dédié est mise à disposition dans un
[emplacement aux Etats-Unis](#locations), vous pouvez, si vous le
souhaitez, sélectionner une configuration conforme à la loi
[HIPAA ![External link icon](../images/launch-glyph.svg "External link icon")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){:new_window}.

Le tableau suivant récapitule les mesures de performance de chaque plan. 

>   **Remarque** : Les informations de ce tableau sont fournies à titre indicatif, en date de septembre 2016.
Pour connaître les valeurs en cours, contactez le [support {{site.data.keyword.cloudant_short_notm}} ![External link icon](../images/launch-glyph.svg "External link icon")](mailto:support@cloudant.com){:new_window}.

>   **Remarque** : Toutes les valeurs de devise de ce document sont indiquées en dollars américains ($).

<table border='1'>

<tr>
<th>Plans</th><th>Lite</th><th colspan='4'>standard <i>et</i> dédié</th>
</tr>
<tr>
<td>Prix de base (par heure)</td>
<td>0,00 $</td>
<td colspan='4'>Voir les <a href="http://cloudant.com/bluemix" target="_blank">informations de tarification <img src="../images/launch-glyph.svg" alt="External link icon" title="External link icon"></a>.</td>
</tr>
<tr>
<td>Débit mis à disposition (consultations par seconde)</td>
<td>20</td>
<td>100</td>
<td>1 000</td>
<td>5 000</td>
<td>20 000</td>
</tr>
<tr>
<td>Débit mis à disposition (écritures par seconde)</td>
<td>10</td>
<td>50</td>
<td>500</td>
<td>2 500</td>
<td>10 000</td>
</tr>
<tr>
<td>Débit mis à disposition (requêtes par seconde)</td>
<td>5</td>
<td>5</td>
<td>50</td>
<td>250</td>
<td>1 000</td>
</tr>
<tr>
<td>Taille de document individuel</td>
<td>1 Mo</td>
<td colspan='4'>1 Mo</td>
</tr>
<tr>
<td>Espace disque inclus</td>
<td>1 Go</td>
<td colspan='4'>20 Go</td>
</tr>
<tr>
<td>Excédent de disque (par Go/heure)</td>
<td>Non disponible</td>
<td colspan='4'>Voir les <a href="http://cloudant.com/bluemix" target="_blank">informations de tarification <img src="../images/launch-glyph.svg" alt="External link icon" title="External link icon"></a>.</td>
</tr>

</table>

Vous pouvez sélectionner le plan à employer lors de la [mise à disposition de votre instance
de service {{site.data.keyword.cloudant_short_notm}}](#provisioning-a-cloudant-instance-on-bluemix).
Par défaut, le [plan Lite](#lite-plan) est sélectionné.

![Sélection du plan de l'instance de service Cloudant](../images/fb87416a.png)

### Plan Lite

Le plan Lite est gratuit, mais vous limite à un maximum de 1 Go de stockage de données.
Des limites s'appliquent également au débit mis à disposition pour les consultations, les écritures et les requêtes. 

Une vérification de l'utilisation du stockage a lieu tous les jours. Si vous dépassez votre limite de stockage, les demandes HTTP émises auprès du compte reçoivent un
code d'état 402 assorti du message d'erreur : "Account has exceeded its data usage quota. An upgrade to a paid plan is required."
Une bannière apparaît également sur le tableau de bord Cloudant pour vous informer. Vous avez toujours la possibilité de lire et de supprimer des données. Toutefois,
si vous souhaitez écrire de nouvelles données, vous devez effectuer une mise à niveau vers un compte payant ou supprimer des données et patienter jusqu'à la vérification suivante pour que votre compte soit réactivé.  

Si vous désirez stocker une quantité de données supérieure à 1 Go ou disposer d'un débit plus élevé, passez au [plan standard](#standard-plan).

### Plan standard

Le plan standard inclut 20 Go de stockage de données.
Si vous stockez plus de 20 Go, vous êtes facturé sur la base d'un coût défini par Go par heure.
Pour connaître le tarif en cours, voir les [informations de tarification ![External link icon](../images/launch-glyph.svg "External link icon")](http://cloudant.com/bluemix){:new_window}.
Le plan standard vous permet également de modifier le débit pour les
consultations, les écritures et les requêtes. 

### Plan dédié

{{site.data.keyword.cloudant_short_notm}} est disponible sur du matériel dédié à service exclusif dans le cadre d'une configuration [{{site.data.keyword.Bluemix_notm}} Dedicated ![External link icon](../images/launch-glyph.svg "External link icon")](http://www.ibm.com/cloud-computing/bluemix/dedicated/){:new_window}.

<div id="servicetier"></div>

## Niveaux de service

Vous pouvez voir les détails du débit des plans disponibles pour votre compte.
Vous pouvez sélectionner le niveau de mise à disposition que vous souhaitez utiliser via l'onglet Compte du tableau de bord de votre compte {{site.data.keyword.cloudant_short_notm}}. 

![Tableau de bord du compte](../images/cloudant_capacity.png)

Pour passer à un débit différent, sélectionnez la mise à disposition souhaitée,
puis cliquez sur le bouton `Change Capacity`.
Vous devez confirmer la modification et êtes informé que la modification de débit peut
prendre jusqu'à 24 heures.

![Tableau de bord du compte](../images/cloudant_capacity_change.png)

<div id="throughput"></div>

### Débit mis à disposition

La mise à disposition du débit est identifiée et mesurée grâce à l'une des trois
sortes d'événement suivantes : 

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
	-	Requête Cloudant ([`_find`](../api/cloudant_query.html#finding-documents-using-an-index))
	-	Modifications ([`_changes`](../api/database.html#get-changes))

La mesure du débit consiste simplement à compter le nombre d'événements de chaque type, par seconde, la seconde étant une fenêtre _glissante_.
Si votre compte connaît un dépassement du nombre d'événements de débit mis à disposition
pour le plan, les demandes sont rejetées jusqu'à ce que le nombre d'événements au sein de
la fenêtre glissante ne dépasse plus le nombre mis à disposition.
Pour plus de facilité, vous pouvez considérer la fenêtre d'une seconde glissante comme une période de 1 000 millisecondes consécutives. 

Par exemple, si vous utilisez le plan standard avec 200 consultations par seconde
mises à disposition, votre compte peut effectuer un maximum de 200 demandes de
consultation au cours d'une période de 1 000 millisecondes consécutives (1 seconde).
Les demandes de consultation suivantes effectuées au cours de la période glissante de 1 000 millisecondes sont rejetées jusqu'à ce que le nombre de demandes de consultation
au cours de cette période devienne à nouveau inférieur à 200. 

Lorsqu'une demande est rejetée en raison du dépassement du nombre d'événements, les
applications reçoivent une réponse [`429` Too Many Requests](../api/http.html#429).

Les versions récentes des bibliothèques client prises en charge (pour les langages
[Java](../libraries/supported.html#java), [Node.js](../libraries/supported.html#node-js) et
[Python](../libraries/supported.html#python)) vous aident à traiter les réponses `429`.
Par exemple, la bibliothèque Java émet une exception
[`TooManyRequestsException` ![External link icon](../images/launch-glyph.svg "External link icon")](http://static.javadoc.io/com.cloudant/cloudant-client/2.5.1/com/cloudant/client/org/lightcouch/TooManyRequestsException.html){:new_window}.

Par défaut, les bibliothèques client prises en charge ne tentent pas
automatiquement d'effectuer une nouvelle demande en cas de réception d'une réponse
`429`.

Il est préférable de vous assurer que votre application gère correctement les réponses `429`.
En effet, le nombre de nouvelles tentatives est limité ; la violation régulière du nombre
de demandes est un mauvais indicateur pour le passage à une configuration de plan différente.

>   **Remarque** : Si vous portez une application existante, 
elle risque de ne pas pouvoir gérer une réponse `429`.
Dans le cadre de la vérification de la migration, vérifiez que votre application
traite correctement les réponses `429`.
En résumé, vous devez vous assurer que votre application peut gérer correctement
les réponses [`429`](../api/http.html#429).

### Taille de document individuel

Les données sont stockées dans {{site.data.keyword.cloudant_short_notm}} sous forme de [documents JSON](../api/document.html).
Dans le cas des documents d'un service {{site.data.keyword.cloudant_short_notm}}
sur {{site.data.keyword.Bluemix_notm}}, la taille maximale d'un document individuel est de 1 Mo.
Au-delà de cette limite, une [erreur `413`](../api/http.html#413) est générée.

### Espace disque inclus

Cette valeur représente la capacité de stockage incluse dans le plan.
Elle est indiquée pour le stockage des données et des index. 

### Excédent de disque

Toutes les instances de service des plans standard et Lite font l'objet d'une surveillance quant à l'espace disque utilisé. Si
le compte utilise plus que la quantité de stockage fournie dans la configuration de votre
plan, il est considéré comme étant en "dépassement".
Le dépassement entraîne la facturation du compte au tarif indiqué pour chaque Go supplémentaire utilisé au-delà de l'allocation du plan.

La somme supplémentaire que vous devez payer pour l'utilisation d'une quantité d'espace disque supérieure à l'espace disque fourni est appelé "excédent".
L'excédent est calculé sur une base horaire.
Il n'est pas possible d'utiliser plus que l'espace disque disponible dans le plan Lite. 

Supposons, par exemple, que votre instance de plan standard augmente l'utilisation
du disque jusqu'à atteindre 107 Go pendant une demie-journée (12 heures).
Cela signifie que votre instance a entraîné un dépassement de 87 Go par rapport aux 20
Go fournis par l'allocation du plan pendant 12 heures.
Vous seriez donc facturé de frais en excédent basés sur 87 Go x 12 heures = 1044 Go heures pour cet espace supplémentaire. 

L'excédent est calculé selon le nombre maximal de Go supplémentaire utilisé par rapport à l'allocation du plan pendant une heure en spécifique au cours du cycle de facturation. 

### Exemple d'excédent en contexte

Supposons que vous commencez un mois de 30 jours avec une instance de service de plan standard qui utilise 9 Go de stockage.
Votre stockage augmente ensuite pour atteindre 21,5 Go pendant 15 minutes au cours de l'heure commençant à 02h00 du jour 3.
L'instance revient ensuite à 9,5 Go pendant les 10 minutes qui suivent, puis augmente à
nouveau pour atteindre 108 Go pendant les 25 minutes suivantes, toujours dans l'heure commençant à 02h00.
Finalement, votre instance termine l'heure et le reste du mois avec un stockage
revenu à 28 Go.

Ce schéma signifie que le nombre maximal de Go supplémentaire par rapport à l'allocation du plan est de 88 Go pendant l'heure 2 du jour 3.
Pendant l'heure commençant à 03h00 du jour 3 et le reste du mois, votre instance était supérieure de
8 Go par rapport à l'allocation du plan. 

Pour l'heure 02h00 du jour 3, vous seriez donc facturé pour un excédent de 88 Go x 1 heure = 88 Go heures.

Pour l'heure 03h00 du jour 3 et jusqu'à la fin du jour 3, vous seriez facturé pour un excédent de 8 Go x 21 heures = 168 Go heures.

Pour l'heure 00h00 du jour 4 et jusqu'à la fin du mois (de 30 jours), vous seriez facturé pour un excédent de 8 Go x 24 heures x 27 jours = 5184 Go heures.

La facture de l'excédent total du mois indiquerait donc un total de 88 + 168 + 5184 = 5440 Go heures.

## Emplacements

Par défaut, tous les plans à l'exception du plan dédié reposent sur des clusters à service partagé.
Lorsque vous sélectionnez un plan, vous pouvez choisir l'une des régions suivantes de {{site.data.keyword.Bluemix_notm}} Public :

-   Sud des Etats-Unis
-   Royaume Uni
-   Sydney
-   Allemagne

## Sécurité, chiffrement et conformité

Tous les plans sont fournis sur des serveurs dotés d'un chiffrement de disque
[au repos ![External link icon](../images/launch-glyph.svg "External link icon")](https://en.wikipedia.org/wiki/Data_at_rest){:new_window}.
L'accès est chiffré sur une connexion réseau utilisant HTTPS.
Pour plus de détails, voir [Sécurité DBaaS ![External link icon](../images/launch-glyph.svg "External link icon")](https://cloudant.com/product/cloudant-features/dbaas-security/){:new_window}.

Les plans offrent également une [Certification de conformité à la sécurité ![External link icon](../images/launch-glyph.svg "External link icon")](https://cloudant.com/product/cloudant-features/cloudant-compliance/){:new_window}.
La conformité [HIPAA ![External link icon](../images/launch-glyph.svg "External link icon")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){:new_window}
requiert un [environnement dédié](#dedicated-plan) ; vous devez donc demander cet environnement dans le cadre du [processus de mise à disposition](#provisioning-a-cloudant-instance-on-bluemix).

## Haute disponibilité, reprise après incident et sauvegarde

Dans le but de fournir la haute disponibilité et la reprise après incident au sein
d'un centre de données, toutes les données sont stockées en trois exemplaires sur trois serveurs physiques distincts d'un cluster.
Vous pouvez mettre à disposition des comptes dans plusieurs centres de données, puis
faire appel à la réplication de données en continu pour fournir les fonctions de haute
disponibilité et de reprise après incident sur ces différents centres de données. 

Les données {{site.data.keyword.cloudant_short_notm}} ne sont pas automatiquement sauvegardées.
Vous pouvez demander l'activation d'une [fonction de sauvegarde incrémentielle](../guides/backup-guide.html) ou
implémenter votre propre solution en utilisant l'une des nombreuses techniques possibles décrites
[ici ![External link icon](../images/launch-glyph.svg "External link icon")](https://developer.ibm.com/clouddataservices/2016/03/22/simple-couchdb-and-cloudant-backup/){:new_window}.  

## Surveillance de l'utilisation

Vous trouverez des informations sur votre utilisation dans le panneau Utilisation de l'onglet Activité de votre tableau de bord {{site.data.keyword.cloudant_short_notm}}.

![Surveillance de l'utilisation sur le tableau de bord](../images/cloudant_usage.png).

Vous y trouverez des détails sur votre [débit](#throughput) en cours, ainsi que sur la quantité de [données stockées](#disk-space-included).

La surveillance vous aide à prendre conscience qu'un changement de mise à
disposition de votre plan pourrait être à envisager. Par exemple, si vous approchez
régulièrement du nombre maximal de consultations de base de données, vous pouvez modifier la mise à disposition grâce au panneau [Service](#servicetier)
de l'onglet Compte du tableau de bord.

## Spécification matérielle

Tous les plans à l'exception du plan dédié sont implémentés sur des clusters à service partagé.
Toutes les données sont stockées en triple exemplaire sur des noeuds physiques distincts
dans le but de fournir des fonctions de haute disponibilité et de reprise après incident. 

## Support

Le support des instances de service des plans standard et dédié est facultatif.
Il est fourni si vous achetez le "Support standard {{site.data.keyword.Bluemix_notm}}".
Le support n'est pas disponible pour le plan Lite.

Une calculatrice de prix du Support standard
{{site.data.keyword.Bluemix_notm}} est disponible [ici ![External link icon](../images/launch-glyph.svg "External link icon")](https://console.ng.bluemix.net/?direct=classic/#/pricing/cloudOEPaneId=pricing&paneId=pricingSheet){:new_window}.
Vous trouverez des informations sur les détails de l'accord sur les niveaux de service de support (SLA)
[ici ![External link icon](../images/launch-glyph.svg "External link icon")](http://www-03.ibm.com/software/sla/sladb.nsf/pdf/6606-08/$file/i126-6606-08_05-2016_en_US.pdf){:new_window}.

## Mise à disposition d'une instance Cloudant sur Bluemix

Vous pouvez mettre à disposition une instance {{site.data.keyword.cloudant_short_notm}} sur {{site.data.keyword.Bluemix_notm}} de deux manières :

-	A l'aide du tableau de bord. Un tutoriel décrivant le processus est disponible [ici](../tutorials/create_service.html).
-	A l'aide de l'outil de ligne de commande Cloud Foundry. Un tutoriel décrivant le processus est disponible [ici](../tutorials/create_service_cli.html).
