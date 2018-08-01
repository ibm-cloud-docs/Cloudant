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

# Regroupement des documents liés dans {{site.data.keyword.cloudant_short_notm}}

Généralement,
les systèmes de commerce électronique sont générés avec des bases de données relationnelles.
Ces bases de données utilisent habituellement plusieurs tables regroupées afin d'enregistrer les ventes,
les données des clients,
les produits achetés et
les informations de suivi de la livraison.
Les bases de données relationnelles affichent une cohérence élevée,
ce qui signifie que les développeurs peuvent générer leurs applications en fonction de la puissance d'une base de données,
incluant l'utilisation de jointures entre des collections,
les énumérations afin d'enregistrer l'état d'un objet et
les transactions de base de données afin de garantir les opérations atomiques.

{{site.data.keyword.cloudantfull}} favorise la disponibilité par rapport à la cohérence.
Il s'agit d'une base de données répartie à haute disponibilité,
insensible aux défaillances... en un mot :
cohérente.
Ainsi, le service d'achats du client est toujours disponible et suffisamment évolutif pour
prendre en charge les achats simultanés par plusieurs utilisateurs.
Votre application peut ainsi utiliser les points forts de {{site.data.keyword.cloudant_short_notm}} et ne pas considérer ce dernier comme une base de données relationnelle.

Cette rubrique met en avant certains facteurs impliqués lors de la
génération d'un système de commerce électronique tirant profit des points forts de {{site.data.keyword.cloudant_short_notm}},
en utilisant des concepts applicables à bien d'autres domaines, tels :

-   Utilisation de plusieurs documents afin de représenter l'état d'un achat,
    au lieu de fréquemment mettre à jour un seul document.
-   Stockage de copies des objets liés dans la commande au lieu de les associer à une autre collection
-   Création de vue afin d'assembler des documents par `order_id` afin de refléter l'état en cours d'un achat.

Par exemple,
vous pouvez créer un document `purchase` contenant des détails, tels que les articles commandés,
les données client,
le coût et les
informations de livraison.

_Document décrivant un achat - Exemple :_

```json
{
    "_id": "023f7a21dbe8a4177a2816e4ad1ea27e",
    "type": "purchase",
    "order_id": "320afa89017426b994162ab004ce3383",
    "basket": [
        {
            "product_id": "A56",
            "title": "Adele - 25",
            "category": "Audio CD",
            "price": 8.33,
            "tax": 0.2,
            "quantity": 2
        },
        {
            "product_id": "B32",
            "title": "The Lady In The Van - Alan Bennett",
            "category": "Paperback book",
            "price": 3.49,
            "tax": 0,
            "quantity": 2
        }
    ],
    "account_id": "985522332",
    "delivery": {
        "option": "Next Day",
        "price": 2.99,
        "address": {
            "street": "17 Front Street",
            "town": "Middlemarch",
            "postcode": "W1A 1AA"
        }
    },
    "pretax" : 20.15,
    "tax" : 3.32,
    "total": 26.46
}
```
{:codeblock}

Ce document inclut suffisamment de données pour qu'un enregistrement d'achat affiche un récapitulatif d'une commande sur une page Web,
ou dans un message électronique
sans qu'il soit nécessaire d'extraire des enregistrements supplémentaires.
Prenez en compte certaines informations importantes sur la commande,
en particulier :

-   Le panier contient des ID de référence (`product_id`) à une base de données de produits stockée à un autre emplacement.
-   Le panier duplique certaines des données de produit dans cet enregistrement,
    suffisamment pour enregistrer l'état des articles achetés à ce point de vente.
-   Le document ne contient pas de zones marquant le statut de la commande.
    Des documents supplémentaires sont ajoutés ultérieurement pour enregistrer les règlements et la livraison.
-   La base de données génère automatiquement un document `_id` lorsqu'il insère le document dans la base de données.
-   Un identificateur unique (`order_id`) est fourni avec chaque enregistrement d'achat pour référencer la commande ultérieurement. 
 
Lorsque le client passe une commande,
généralement lorsqu'il se trouve en phase de "réservation" sur le site Web,
un enregistrement de commande d'achat est créé, similaire à l'exemple précédent. 

## Génération de vos propres identificateurs uniques (UUID)

Dans une base de données relationnelle,
des numéros séquentiels à incrémentation automatique sont souvent utilisés,
mais dans des bases de données réparties,
où les données se trouvent dans différents clusters de serveurs,
des UUID plus longs permettent de garantir que les documents sont stockés avec leur propre ID unique.

Pour créer un identificateur unique à utiliser dans votre application,
tel `order_id`,
appelez le noeud final [`GET _uuids`](../api/advanced.html#-get-_uuids-) sur l'API {{site.data.keyword.cloudant_short_notm}}.
La base de données génère un identificateur pour vous.
Le même noeud final peut être utilisé pour générer plusieurs ID en ajoutant un paramètre `count`,
par exemple, `/_uuids?count=10`.

## Enregistrement des règlements

Lorsque le client paie ses articles,
des enregistrements supplémentaires sont ajoutés à la base de données afin d'enregistrer la commande.

_Enregistrement de règlement - Exemple :_

```json
{
    "_id": "bf70c30ea5d8c3cd088fef98ad678e9e",
    "type": "payment",
    "account_id": "985522332",
    "order_id": "320afa89017426b994162ab004ce3383",
    "value": 6.46,
    "method": "credit card",
    "payment_reference": "AB9977G244FF2F667"
}
...
{
    "_id": "12c0ea6cd3d2c6e3b1d34442aea6a2d9",
    "type": "payment",
    "account_id": "985522332",
    "order_id": "320afa89017426b994162ab004ce3383",
    "value": 20.00,
    "method": "voucher",
    "payment_reference": "Q88775662377224"
}
```
{:codeblock}

Dans l'exemple précédent,
le client a payé en fournissant des informations de carte de crédit et en validant un bon prépayé.
Le total de deux règlements correspond au montant de la commande.
Chaque règlement a été enregistré dans {{site.data.keyword.cloudant_short_notm}} en tant que document séparé.

Vous pouvez voir le statut d'une commande en créant une vue incluant tout ce dont vous avez connaissance à propos d'un élément `order_id`.
La vue active un registre contenant les informations suivantes : 

-   Total des achats sous forme de nombres positifs.
-   Règlements liés au compte sous forme de nombres négatifs.

Il est possible d'utiliser une fonction de mappe pour identifier les valeurs requises.

_Fonction de mappe permettant de trouver les valeurs de règlement et de total d'achat - Exemple :_ 

```javascript
function (doc) {
    if (doc.type === 'purchase') {
        emit(doc.order_id, doc.total);
    } else {
        if (doc.type === 'payment') {
            emit(doc.order_id, -doc.value);
        }
    }
}
```
{:codeblock}

L'utilisation du réducteur [`_sum`](../api/creating_views.html#built-in-reduce-functions) intégré
vous permet de générer un registre des événements de règlement.

_Utilisation du réducteur `_sum` intégré, interrogé avec `?reduce=false` - Exemple :_

```json
{
    "total_rows":3,"offset":0,"rows":[
        {
            "id":"320afa89017426b994162ab004ce3383",
            "key":"985522332",
            "value":26.46
        },
        {
            "id":"320afa89017426b994162ab004ce3383",
            "key":"985522332",
            "value":-20
        },
        {
            "id":"320afa89017426b994162ab004ce3383",
            "key":"985522332",
            "value":-6.46
        }
    ]
}
```
{:codeblock}

Vous pouvez également
générer des totaux regroupés par `order_id`.

_Totaux regroupés par `order_id` avec `?group_level=1` - Exemple :_

```json
{
    "rows":[
        {
            "key":"320afa89017426b994162ab004ce3383",
            "value":0
        }
    ]
}
```
{:codeblock}

Etant donné que la vue dans l'exemple précédent renvoie 0 pour la valeur de commande,
le résultat indique que la commande a été entièrement payée.
Cela est dû au fait que le total de bon de commande positif annule les montants de règlement négatifs.
L'enregistrement d'événements en tant que documents séparés (un pour la commande et un pour chaque règlement) est une pratique recommandée dans {{site.data.keyword.cloudant_short_notm}} car cela évite la probabilité de création de conflits lorsque plusieurs processus modifient le même document en même temps.

## Ajout de documents supplémentaires

Vous pouvez ajouter d'autres
documents séparés à la base de données pour enregistrer les modifications d'état suivants lorsque la commande est mise à disposition et distribuée :

-   Notifications de distribution
-   Reçus de livraison
-   Enregistrements de remboursement.

Lorsque les données arrivent, {{site.data.keyword.cloudant_short_notm}} les place séparément dans chaque document.
C'est pourquoi,
il n'est pas nécessaire de modifier le document d'achat principal.

## Avantages du stockage des bons de commande dans {{site.data.keyword.cloudant_short_notm}}

En utilisant {{site.data.keyword.cloudant_short_notm}} pour stocker des informations de bon de commande, le système de commande est hautement disponible et évolutif.
Ainsi, vous pouvez traiter une grande quantité de données et un nombre important d'accès simultanés.
En modélisant les données dans différents documents à écriture unique,
vous garantissez le fait que les documents n'entrent jamais en conflit, comme
cela pourrait se produire lors de l'accès simultané au même document par différents processus.

C'est pourquoi,
les documents peuvent inclure des copies des données qui existent dans d'autres collections
pour représenter l'association de données à une clé externe (et non dépendre de cette dernière).
Par exemple,
lors de l'enregistrement de l'état d'un panier au moment de l'achat.
Ainsi, il est possible d'extraire un état de commande via un seul
appel à une vue de {{site.data.keyword.cloudant_short_notm}} qui regroupe les documents liés par `order_id`.
