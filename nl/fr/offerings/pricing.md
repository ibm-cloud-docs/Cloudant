---

copyright:
  years: 2015, 2019
lastupdated: "2019-03-07"

keywords: pricing examples, data usage, ibm cloud usage dashboard

subcollection: cloudant

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:note: .note}
{:important: .important}
{:deprecated: .deprecated}

<!-- Acrolinx: 2019-01-11 -->

# Tarification
{: #pricing}

La tarification d'{{site.data.keyword.cloudantfull}} repose sur la capacité de débit mise à disposition que vous avez allouée pour votre instance ainsi que sur le volume de stockage de données consommé. {{site.data.keyword.cloudant_short_notm}} vous permet de faire évoluer votre capacité de débit mise à disposition vers le haut et vers le bas et de payer au prorata horaire. La capacité de débit mise à disposition est un nombre réservé de lectures, d'écritures et de requêtes globales par seconde allouées à une instance. Le paramètre de capacité de débit est le niveau d'utilisation maximale pour une seconde donnée. Si vous tentez de dépasser la capacité réservée pour des requêtes globales ou de lectures et d'écritures, vous obtenez un code de statut HTTP 429 indiquant que l'application tente de dépasser son allocation de capacité de débit mise à disposition.

Le tableau suivant montre une tarification horaire exemple pour divers paramètres de capacité de débit mise à disposition. Vous pouvez changer de capacité en blocs granulaires de 100 lectures/sec, 50 écritures/sec et 5 requêtes globales par seconde sur une base horaire. Un coût mensuel approximatif est aussi indiqué pour chaque paramètre, en prenant comme hypothèse une durée moyenne mensuelle de 730 heures. Les prix sont indiqués en dollars américains. Vous pouvez utiliser le calculateur de prix {{site.data.keyword.cloud_notm}} pour obtenir les coûts estimés dans d'autres devises en cliquant sur le bouton `Ajouter à l'estimation` depuis la vignette de catalogue {{site.data.keyword.cloudant_short_notm}}.

![feuille de tarification](../images/pricing_spreadsheet.png)

Vous pouvez sélectionner **Tableau de bord** {{site.data.keyword.cloudant_short_notm}} > **Compte** > onglet **Capacité** pour afficher et modifier la capacité de débit mise à disposition et voir les coûts mensuels et horaires estimés : 

![curseur](../images/migrate2.gif)

## Exemples de tarification 
{: #pricing-examples}

Imaginons que vous construisiez une application mobile avec {{site.data.keyword.cloudant_short_notm}} et que vous ne connaissiez pas encore la capacité dont vous pourriez avoir besoin. Dans ce cas, nous vous recommandons de commencer avec la plus faible capacité de débit mise à disposition et de l'augmenter en fonction des besoins liés à l'utilisation de votre application. {{site.data.keyword.cloudant_short_notm}} facture à l'heure de manière proportionnelle et le fait de modifier la capacité de débit mise à disposition ne génère pas de temps d'indisponibilité. 

Pour l'exemple d'application mobile, vous commencez avec la capacité de débit mise à disposition minimale pour le plan Standard qui est de 100 lectures/sec, 50 écritures/sec et 5 requêtes globales/sec. Le coût pour cette capacité est 0,105 $ par heure. Les 100 lectures/sec, 50 écritures/sec et 5 requêtes globales/sec constituent un bloc de capacité de débit mise à disposition. Lorsque vous avez besoin d'augmenter (ou de réduire) la capacité, vous pouvez le faire par incréments de ces blocs de capacité. En supposant que l'instance comporte un espace inférieur au stockage de 20 Go inclus dans le plan Standard, aucun coût de stockage n'est engagé. Sur l'onglet
Compte > Capacité du tableau de bord de {{site.data.keyword.cloudant_short_notm}}, la définition de la capacité de débit mise à disposition se présente comme suit :

![Onglet Capacité du tableau de bord de {{site.data.keyword.cloudant_short_notm}}](../images/cloudant-dashboard.png)

Le curseur de capacité illustre le coût horaire de la capacité de débit mise à disposition de 100 lectures/sec, 50 écritures/sec et 5 requêtes globales/sec en dollars américains de 0,105 $/heure. Le curseur affiche un coût approximatif de 76,65 $ par mois. Le montant mensuel est une estimation basée sur une moyenne de 730 heures par mois. Le coût mensuel peut être légèrement différent en fonction du nombre d'heures dans le mois.

Exemple d'équation : 

- 0,105 $ par heure \* 1 bloc (de capacité de débit mise à disposition de 100 lectures/sec, 50 écritures/sec et 5 requêtes globales) \* 730 heures (mensuelles estimées)
- Total = 76,65


Les lectures, écritures et requêtes globales ne peuvent être dimensionnées indépendamment. Utilisez le curseur pour sélectionner le nombre de blocs de capacité de débit mise à disposition en fonction de la limite maximale de lectures/sec, d'écritures/sec ou de requêtes/sec requises pour votre application. Ainsi, si votre application requiert 1000 lectures par seconde, utilisez le curseur pour sélectionner la capacité qui offre 1000 lectures/sec, 500 écritures/sec et 50 requêtes globales/sec, même si vous n'avez pas besoin du nombre d'écritures ou de requêtes globales correspondant.

![Onglet Capacité du tableau de bord de {{site.data.keyword.cloudant_short_notm}} avec davantage de capacité sélectionnée](../images/cloudant-gran-tuning.png)

Comment estimer le coût total de la capacité de débit mise à disposition par mois de 1000 lectures, 500 écritures et 50 requêtes globales ? 

- 0,105 $ par heure \* 10 blocs (de capacité de débit mise à disposition de 100 lectures/sec, 50 écritures/sec et 5 requêtes globales) \* 730 heures (mensuelles estimées)
- Le curseur vous montre aussi que la capacité de débit mise à disposition de 1000 lectures/sec, 500 écritures/sec et 50 requêtes/sec coûte 1,050 $/heure * 730 heures
- Total = 766,50 $

## Tarification de l'utilisation des données
{: #data-usage-pricing}

Qu'en est-il de la tarification des excédents de données ? Comment cela fonctionne-t-il ?

Plan | Stockage inclus | Limite d'excédent
-----|------------------|--------------
Lite | 1 Go |  Votre compte est bloqué et ne peut plus écrire de nouvelles données tant que vous ne supprimez pas suffisamment de données pour passer au-dessous de la limite de 1 Go ou que vous n'effectuez pas une mise à niveau vers un plan de niveau ultérieur.
Standard | 20 Go | Le stockage supplémentaire coûte 0,0014 $ par Go par heure, ce qui correspond à environ 1 $/Go par mois.

## Tableau de bord de l'utilisation {{site.data.keyword.cloud_notm}} 
{: #usage-dashboard}

Comment les données s'affichent-elles dans le tableau de bord de l'utilisation de {{site.data.keyword.cloud_notm}} ?

Les factures d'utilisation actuelle et historiques sont visibles dans le tableau de bord {{site.data.keyword.cloud_notm}}, sous Gérer -> Facturation et utilisation -> Utilisation. Cette vue affiche les montants totaux d'utilisation provisionnés durant un mois particulier, au niveau du service, du plan ou de l'instance. Le montant total estimé reflète la facturation jusqu'à maintenant pour le mois actuel ou pour des mois complets déjà passés. Elle n'affiche que les coûts horaires cumulés jusqu'à ce point pour le mois actuel. A la fin du mois, vous voyez votre capacité de débit mise à disposition moyenne pour le mois qui s'affiche dans les zones `LOOKUPS_PER_MONTH`, `WRITES_PER_MONTH` et `QUERIES_PER_MONTH`. (Notez que les consultations s'appellent désormais lectures et les requêtes, requêtes globales.) La zone `STORAGE_MANAGED_PER_MONTH` ne montre que le stockage facturé et n'inclut pas les 20 Go qui sont compris dans le plan Standard. Dans l'exemple suivant, une quantité de 20+ Go reflète qu'il y a eu une moyenne de 40 Go de données dans l'instance pour le mois. Lorsque vous utilisez moins de 20 Go du stockage, l'écran affiche 0 Go puisque vous n'avez pas dépassé la limite.   

![Vue des métriques d'utilisation du tableau de bord de {{site.data.keyword.cloudant_short_notm}} avec une valeur supérieure dans la zone STORAGE_MANAGED_PER_MONTH](../images/usage-dashboard1.png)


