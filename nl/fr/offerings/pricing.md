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
{:tip: .tip}

<!-- Acrolinx: 2018-06-07 -->

# Tarification
{: #pricing}

{{site.data.keyword.cloudantfull}} permet d'effectuer des tâches d'optimisation afin d'augmenter et de réduire le débit mis à votre disposition (nombre réservé de consultations, d'écritures et de requêtes alloués chaque seconde à une instance).
Le niveau de capacité de débit est le niveau d'utilisation maximum. Si vous tentez de dépasser la capacité réservée, vous obtenez un code de statut HTTP 429 indiquant que l'application tente de dépasser son allocation de capacité de débit mise à disposition. 


## Exemples de tarification 
{: #pricing-examples}

Imaginons que vous construisiez une application mobile avec {{site.data.keyword.cloudant_short_notm}} et que vous ne connaissiez pas encore la capacité dont vous pourriez avoir besoin. Dans ce cas, nous vous recommandons de commencer avec la plus faible capacité de débit mise à disposition et de l'augmenter en fonction des besoins liés à l'utilisation de votre application. {{site.data.keyword.cloudant_short_notm}} facture à l'heure de manière proportionnelle et le fait de modifier la capacité de débit mise à disposition ne génère pas de temps d'indisponibilité.
 

Pour l'exemple d'application mobile, vous commencez avec la capacité de débit mise à disposition minimum pour le plan standard qui est de 100 consultations/sec, 50 écritures/sec et 5 requêtes/sec.
Le coût pour cette capacité est 0,105 $ par heure. Les 100 consultations/sec, 50 écritures/sec et 5 requêtes/sec constituent un bloc de capacité de débit mise à disposition.
Lorsque vous avez besoin d'augmenter (ou de réduire) la capacité, vous pouvez le faire par incréments de ces blocs de capacité.
En supposant que l'instance comporte un espace inférieur au stockage de 20 Go inclus dans le plan standard, aucun coût de stockage n'est engagé. Sur l'onglet
Compte > Capacité du tableau de bord de {{site.data.keyword.cloudant_short_notm}}, la définition de la capacité de débit mise à disposition se présente comme suit :


![Onglet Capacité du tableau de bord de {{site.data.keyword.cloudant_short_notm}}](../images/cloudant-dashboard.png)

Le curseur de capacité illustre le coût horaire de la capacité de débit mise à disposition de 100 consultations/sec, 50 écritures/sec et 5 requêtes/sec en dollars américains : 0,105 $/heure. Le curseur affiche un coût approximatif de 76,65 $ par mois. Le montant mensuel est une estimation basée sur une moyenne de 730 heures par mois. Le coût mensuel peut être légèrement différent en fonction du nombre d'heures dans le mois.

Exemple d'équation : 

- 0,105 $ par heure pour 1 bloc de capacité de débit mise à disposition de 100 consultations/sec, 50 écritures/sec et 5 requêtes/sec * 730 heures (nombre d'heures approximatif dans un mois) 
- Total = 76,65

Les consultations, les écritures et les requêtes ne peuvent pas être mises à l'échelle de manière indépendante. Utilisez le curseur pour sélectionner le nombre de blocs de capacité de débit mise à disposition en fonction de la limite maximale de consultations/sec, d'écritures/sec ou de requêtes/sec requises pour votre application. Par exemple, si votre application requiert 1000 consultations par seconde, utilisez le curseur pour sélectionner la capacité qui offre 1000 consultations/sec, 500 écritures/sec et 50 requêtes/sec, même si vous n'avez pas besoin du nombre d'écritures ou de requêtes correspondant.

![Onglet Capacité du tableau de bord de {{site.data.keyword.cloudant_short_notm}} avec davantage de capacité sélectionnée](../images/cloudant-gran-tuning.png)

Comment estimer le coût total de la capacité de débit mise à disposition par mois de 1000 consultations, 500 écritures et 50 requêtes ? 

- 0,105 $ par heure pour 10 blocs de capacité de débit mise à disposition de 100 consultations/sec, 50 écritures/sec et 5 requêtes/sec * 730 heures (nombre d'heures approximatif dans un mois) 
- Le curseur vous montre aussi que la capacité de débit mise à disposition de 1000 consultations/sec, 500 écritures/sec et 50 requêtes/sec coûte 1,050 $/heure * 730 heures
- Total = 766,50 $

## Utilisation des données 
{: #data-usage}

Qu'en est-il de la tarification des excédents de données ? Comment cela fonctionne-t-il ?

Plan | Stockage inclus | Limite d'excédent
-----|------------------|--------------
Limité | 1 Go |Votre compte est bloqué et ne peut plus écrire de nouvelles données tant que vous ne supprimez pas suffisamment de données pour passer au-dessous de la limite de 1 Go ou que vous n'effectuez pas une mise à niveau vers un plan de niveau ultérieur. 
Standard | 20 Go | Le stockage supplémentaire coûte 0,0014 $ par Go par heure, ce qui correspond à environ 1 $/Go par mois.

Comment les données s'affichent-elles dans le tableau de bord Utilisation de {{site.data.keyword.cloud_notm}} ?

Cette vue affiche les montants totaux d'utilisation provisionnés durant le mois en cours, par conséquent, pour l'instant, seuls les coûts pour le mois sont affichés. Le montant total estimé reflète la facturation jusqu'à maintenant pour le mois. D'ici la fin du mois, vous verrez votre capacité moyenne pour le mois, ce qui correspondra à votre facture mensuelle totale. La zone `STORAGE_MANAGED_PER_MONTH` affiche uniquement le volume supérieur aux 20 Go inclus. Ainsi, dans l'exemple suivant, vous voyez en tout environ 40 Go de données dans le compte.  

![Vue des métriques d'utilisation du tableau de bord de {{site.data.keyword.cloudant_short_notm}} avec une valeur supérieure dans la zone STORAGE_MANAGED_PER_MONTH](../images/usage-dashboard1.png)

Lorsque vous utilisez moins de 20 Go du stockage, l'écran affiche 0 Go puisque vous n'avez pas dépassé la limite.
