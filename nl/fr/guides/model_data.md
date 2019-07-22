---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: immutable data, pre-calculate results, de-normalise data, avoid conflicts, conflict resolution

subcollection: cloudant

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:tip: .tip}
{:note: .note}
{:important: .important}
{:deprecated: .deprecated}

<!-- Acrolinx: 2017-05-10 -->

# Cinq conseils pour la modélisation de vos données
{: #five-tips-for-modeling-your-data-to-scale}

Cet article présente les points principaux de
modélisation des données d'application pour un fonctionnement efficace à grande échelle.
{: shortdesc}

*(Ce guide s'inspire d'un article de blogue de Mike Rhodes : ["My Top 5 Tips for Modeling Data to Scale" ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://cloudant.com/blog/my-top-5-tips-for-modeling-your-data-to-scale/), publié le 17 décembre 2013.)*

La façon dont vous modélisez vos données dans {{site.data.keyword.cloudantfull}} impacte de manière significative
la possibilité d'évolution de votre application. Notre modèle de données sous-jacent est très différent d'un modèle relationnel et ne pas tenir compte
de cet état de fait peut avoir des conséquences sur les performances.

Comme toujours, une modélisation réussie implique un équilibre entre une facilité d'utilisation et les
performances souhaitées.

Sans attendre, passons directement au vif du sujet.

## Prise en compte des données non modifiables
{: #consider-immutable-data}

Si vous changez un état toutes les secondes ou plus souvent, pensez à
rendre vos documents non modifiables. Ainsi, vous réduisez considérablement le risque de création
de documents conflictuels.

Inversement, si vous mettez à jour un document spécifique à une fréquence inférieure à 10 secondes, un
modèle de mise à jour de données en place (autrement dit, mise à jour des documents existants) simplifie
fortement le code de l'application.

Généralement, les modèles de données s'appuyant sur des données non modifiables nécessitent l'utilisation de vues
qui résument les documents indiquant l'état en cours. Comme les vues sont précalculées, cela ne devrait avoir
aucune conséquence sur les performances de l'application.

## En quoi cela vous aide-t-il de prendre en compte les données non modifiables 
{: #why-this-helps-you-consider-immutable-data}

Derrière notre interface `https://$ACCOUNT.cloudant.com/` se trouve une base de données répartie. 
Dans le cluster, les documents sont placés dans des fragments qui collectivement forment la
base de données. Ces fragments sont ensuite répartis entre les noeuds du cluster. Ainsi, il est possible
de prendre en charge des bases de données de plusieurs téraoctets.

Par défaut, en plus de la division d'une base de données en fragments, tous les fragments ont trois
copies, ou répliques, chacune d'entre elles se trouvant sur un noeud différent du cluster de base de données. 
Ainsi, la base de données peut continuer à prendre en charge les demandes en cas de défaillance d'un noeud. C'est pourquoi,
la sauvegarde d'un document implique l'écriture sur trois noeuds. Autrement dit, si deux mises à jour sont effectuées
simultanément dans le même document, il est possible qu'un sous-ensemble de noeuds accepte la première
mise à jour et que l'autre sous-ensemble accepte la deuxième mise à jour. Lorsque le cluster détecte cette
différence, il associe les documents comme le ferait une réplication normale pour les mises à jour
simultanées en créant un conflit.

Les documents en conflit ont des conséquences sur les performances. Pour plus d'informations sur les raisons de ce problème, consultez le texte suivant.
Un modèle de mise à jour simultanée fréquente augmente également la probabilité que les opérations d'écriture soient
rejetées car le paramètre `_rev` n'est pas celui attendu. Par conséquent, l'application va
effectuer de nouvelles tentatives et le traitement va être retardé.

Nous avons détecté que ce scénario de conflit de documents a plus de risque de se produire dans le cas de mises
à jour survenant à des fréquences supérieures à une seconde, mais nous recommandons néanmoins des documents non modifiables
pour les mises à jour survenant à des fréquences supérieures à dix secondes pour des raisons de sécurité.

## Utilisation de vues pour précalculer des résultats plutôt que comme des index de recherche
{: #use-views-to-pre-calculate-results-rather-than-as-search-indexes}

Au lieu d'utiliser systématiquement des vues comme index de recherche ("extraction de tous les documents `person`"), essayez
de laisser la base de données effectuer le travail pour vous. Par exemple, au lieu d'extraire un grand nombre de
documents person pour calculer leurs heures de travail, utilisez une vue avec une clé composite pour
pré-calculer ces données par année, mois, jour, demi-journée et heure en utilisant la réduction intégrée `_sum`. 
Ainsi, le travail que vous devez effectuer dans l'application est réduit et la base de données peut prendre en charge un
grand nombre de petites demandes au lieu de lire de grandes quantités de données sur le disque pour traiter une seule
demande de grande taille.

## En quoi cela vous aide-t-il d'utiliser des vues pour pré-calculer des résultats
{: #why-this-helps-you-use-views-to-pre-calculate-results}

L'avantage de cette méthode est évident : tout d'abord, les mappes et les réductions
sont pré-calculées. Cela signifie
que la demande du résultat d'une fonction de réduction est une opération peu onéreuse, particulièrement lorsqu'elle
est comparée aux quantités importantes d'opérations d'E-S requises pour compacter des centaines voire des milliers de
documents à partir du stockage sur disque.

A un niveau inférieur, lorsqu'un noeud reçoit une demande de vue, il demande aux noeuds incluant
les répliques de fragment pour la base de données de la vue de lui fournir les résultats de la demande de vue
pour les documents de chaque fragment. Dès qu'il reçoit les réponses (utilisant la première d'entre elles concernant chaque réplique de fragment), le noeud
traitant la demande de vue associe les résultats et transmet le résultat final au client. 
Plus le nombre de documents impliqués est important, plus la transmission des résultats par chaque réplique à partir du
disque sur le réseau est longue. De plus, le noeud prenant en charge la demande a plus de tâches
à effectuer lors de l'association des résultats de chaque fragment de base de données.

Généralement, l'objectif d'une demande de vue est de solliciter le moins de données possibles dans chaque fragment,
ce qui permet de réduire la durée de la transmission des données, lesquelles sont regroupées pour donner le résultat final. Pour cela,
vous pouvez notamment utiliser la puissance des vues afin de précalculer les données d'agrégation. Ainsi la durée d'attente pour
l'exécution de la demande est réduite.

## Dénormalisation de vos données
{: #de-normalise-your-data}

Dans les bases de données relationnelles, la normalisation des données constitue souvent la meilleure méthode de stockage pour les données. 
Ce choix est d'autant plus judicieux lorsque vous pouvez utiliser des opérations JOIN pour associer facilement des données provenant de plusieurs tables. 
Dans {{site.data.keyword.cloudant_short_notm}}, il est fort probable que vous ayez besoin d'une demande HTTP GET pour chaque donnée. Il est donc recommandé de réduire
le nombre de demandes dont vous avez besoin pour générer une image complète d'une entité modélisée car ainsi vous pouvez présenter plus rapidement les
informations à vos utilisateurs.

L'utilisation des vues vous permet de tirer le meilleur parti des données
normalisées tout en conservant la version dénormalisée pour des raisons d'efficacité.

Par exemple, dans une base de données relationnelle, vous présentez généralement les
balises dans une table séparée et utilisez une table de connexion pour joindre les balises
aux documents liés, ce qui permet d'avoir d'une vue rapide de tous les documents avec une
balise spécifique.

Dans {{site.data.keyword.cloudant_short_notm}}, vous stockez les balises dans une liste pour chaque document. Vous utilisez ensuite une vue pour extraire les
documents ayant une balise spécifique en
[émettant chaque balise en tant que clé dans la fonction de mappe de votre vue](/docs/services/Cloudant?topic=cloudant-views-mapreduce#views-mapreduce). 
Le fait de demander une clé spécifique dans la vue permet d'obtenir tous les documents ayant cette balise.

## En quoi cela vous aide-t-il de dénormaliser vos données
{: #why-this-helps-you-de-normalize-your-data}

Le nombre de demandes HTTP effectuées par votre application. Chaque ouverture
de connexion HTTP génère un coût (plus particulièrement pour HTTPS). Si une réutilisation des connexions peut
être une bonne idée, la création d'un nombre de demandes plus faible permet à votre application de traiter plus rapidement les données.

En outre, les documents dénormalisés et les vues précalculées permettent souvent que la valeur
demandée par votre application soit générée à l'avance au lieu d'être construite à la volée lors de la
demande.

## Prévention des conflits à l'aide de documents à granularité fin
{: #avoid-conflicts-by-using-finer-grained-documents}

Outre la dénormalisation de vos données, nous vous recommandons d'utiliser
des documents à granularité fine pour réduire le risque de modifications simultanées créant des conflits. 
Cette opération est similaire à la normalisation de vos données. Vous devez trouver un équilibre entre la réduction du
nombre de demandes HTTP et le fait d'éviter les conflits.

Utilisons par exemple un enregistrement médical contenant une liste d'opérations :

```json
{
    "_id": "Joe McIllness",
    "operations": [
        { "surgery": "heart bypass" },
        { "surgery": "lumbar puncture" }
    ]
}
```
{: codeblock}

Si Joe subit beaucoup d'opérations en même temps, le nombre de mises à jour
simultanées élevé apportées à un même document peut créer des documents conflictuels, comme cela est décrit ci-dessus.
Il est préférable de répartir les opérations dans différents documents faisant référence au document personnel de Joe
et d'utiliser une vue pour connecter les différentes éléments. Pour représenter chaque opération, téléchargez des documents
similaires aux exemples suivants :

```json
{
    "type": "operation",
    "patient": "Joe McIllness",
    "surgery": "heart bypass"
}
```
{: codeblock}

```json
{
    "type": "operation",
    "patient": "Joe McIllness",
    "surgery": "lumbar puncture"
}
```
{: codeblock}

Le fait d'émettre la zone `"patient"` en tant que clé dans votre vue vous permet alors de demander toutes
les opérations pour un patient spécifique. Les vues permettent de créer une image complète d'une entité spécifique
à partir de différents documents, ce qui permet de réduire le nombre de demandes HTTP même si
les données d'une entité modélisée ont été fractionnées.

## En quoi cela vous aide-t-il d'éviter les conflits
{: #why-this-helps-you-avoid-conflicts}

En évitant les documents en conflit, vous accélérez le traitement d'un grand nombre d'opérations sur vos bases de données {{site.data.keyword.cloudant_short_notm}}. 
Cela est dû au fait qu'il existe un processus qui résout la révision gagnante en cours utilisée dès
que le document est lu : extractions de document, appels avec `include_docs=true`, génération de vue,
etc.

La révision gagnante est une révision spécifique dans l'arborescence principale du document. N'oubliez
pas que ces documents de {{site.data.keyword.cloudant_short_notm}} sont en fait des arborescences de révisions. Un algorithme arbitraire mais déterministe
sélectionne une des feuilles non supprimées de cette arborescence afin d'indiquer quand une demande est effectuée
pour le document. Le traitement des arborescences de plus grande taille avec un facteur de ramification plus important peut
durer plus longtemps que le traitement d'une arborescence de documents sans branche ou avec peu de branches. En effet, il est
nécessaire de suivre chaque branche pour savoir s'il s'agit potentiellement de la révision gagnante. Les gagnants potentiels doivent ensuite être comparés les uns aux autres afin d'effectuer
le choix final.

Lorsque le nombre de branches est peu élevé, {{site.data.keyword.cloudant_short_notm}} en assure correctement la gestion. Effectivement, la réplication s'appuie sur le
fait qu'il est possible que les documents soient fractionnés, et ce afin d'éviter la suppression des données. Cependant, dès que leur nombre devient
très élevé, particulièrement si les conflits ne sont pas résolus, le parcours de l'arborescence des documents peut être très long et
utiliser un grand nombre de ressources.

## Intégration de la résolution de conflit
{: #build-in-conflict-resolution}

Dans un système cohérent ({{site.data.keyword.cloudant_short_notm}}, par exemple) des conflits peuvent survenir. Comme
décrit ci-dessus, c'est là l'inconvénient de l'évolutivité et de la résilience des données.

Structurer vos données de telle manière que la résolution des conflits soit rapide et ne
demande aucune assistance de l'opérateur permet de garantir un bon fonctionnement de vos bases de données. La possibilité de
résoudre automatiquement les conflits sans aucune intervention des utilisateurs optimise leur expérience tout en réduisant
les opérations de support pour votre entreprise.

La façon de procéder dépend de vos applications mais voici quelques conseils :

-   Evitez, si possible, d'utiliser des invariants dans les zones de document. Il est ainsi plus probable qu'une simple
    opération de fusion, utilisant la zone modifiée de chaque révision de document en conflit, soit
    adaptée. Le code d'application est ainsi plus simple et plus robuste.
-   Faites en sorte que les documents puissent être autonomes. Le fait de devoir extraire d'autres documents pour une résolution
    correcte augmente le temps d'attente. Vous risquez également d'obtenir
    une version des autres documents qui est incohérente avec le document en cours de résolution, ce qui complique
    l'opération, sans parler de la possibilité que les autres documents peuvent être en conflit.

## En quoi cela vous aide-t-il d'intégrer la résolution de conflit 
{: #why-this-helps-you-build-in-conflict-resolution}

Comme décrit ci-dessus, les documents en conflit constituent un lourd handicap pour la base de données. Intégrer la possibilité
de résoudre les conflits dès qu'ils apparaissent permet d'éviter d'avoir des documents en conflit.

## Récapitulatif
{: #summary}

Ces conseils présentent comment la modélisation de données peut avoir des conséquences sur les
performances de votre application. Le magasin de données de {{site.data.keyword.cloudant_short_notm}} a des caractéristiques spécifiques (certaines constituant des
inconvénients, d'autres des avantages) permettant de garantir que les performances de base de données évoluent au fur et à mesure de la
croissance de votre application. Nous avons conscience que cela peut être déstabilisant mais sommes toujours à votre écoute et prêts à vous donner des conseils.

Pour plus d'informations, voir le site
présentant le [modèle de données de Foundbite ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://cloudant.com/blog/foundbites-data-model-relational-db-vs-nosql-on-cloudant/){: new_window}
ou la page [présentant un exemple de Twilio ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://www.twilio.com/blog/2013/01/building-a-real-time-sms-voting-app-part-3-scaling-node-js-and-couchdb.html){: new_window}.

