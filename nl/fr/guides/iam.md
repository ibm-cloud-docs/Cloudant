---

copyright:
  years: 2017, 2019
lastupdated: "2019-06-12"

keywords: legacy access controls, api keys, enable iam, provisioning, how to choose between iam and legacy credentials, making requests, required client libraries, actions, endpoints, map actions to iam roles

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

<!-- Acrolinx: 2018-07-02 -->

# {{site.data.keyword.cloud_notm}} Identity and Access Management (IAM)
{: #ibm-cloud-identity-and-access-management-iam-}

{{site.data.keyword.cloud}} Identity and Access Management offre une approche unifiée pour gérer les identités des utilisateurs, les services et le contrôle d'accès.
{: shortdesc}

## Présentation
{: #introduction}

Ce document décrit l'intégration d'{{site.data.keyword.cloudantfull}} à {{site.data.keyword.cloud_notm}} Identity and
Access Management. Il expose les différences entre les contrôles d'accès existants de {{site.data.keyword.cloudant_short_notm}} et le contrôle d'accès d'{{site.data.keyword.cloud_notm}} IAM. Il présente ensuite les avantages et les inconvénients de chaque option pour vous aider à décider laquelle utiliser. Nous verrons ensuite comment utiliser IAM dans les bibliothèques client de {{site.data.keyword.cloudant_short_notm}} et via les appels HTTP. Pour finir, nous terminerons avec une section de références décrivant toutes les actions d'IAM et les rôles disponibles dans {{site.data.keyword.cloudant_short_notm}}.

Vous trouverez ci-après une présentation de [IAM ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://cloud.ibm.com/docs/iam/index.html#iamoverview){: new_window}, concernant notamment :

- la gestion des ID d'utilisateur et des ID de service.
- la gestion des données d'identification disponibles.
- l'utilisation des politiques d'accès IAM qui autorisent et révoquent les accès aux instances de service {{site.data.keyword.cloudant_short_notm}}.

## Différences entre les contrôles d'accès existants de {{site.data.keyword.cloudant_short_notm}} et les contrôles d'accès IAM
{: #differences-between-ibm-cloudant-legacy-and-iam-access-controls}

La section qui suit offre une brève présentation des différences entre les mécanismes de contrôle d'accès existants de {{site.data.keyword.cloudant_short_notm}} et ceux d'{{site.data.keyword.cloud_notm}} IAM.

### {{site.data.keyword.cloud_notm}} Identity and Access Management
{: #ibm-cloud-identity-and-access-management}

- Gestion centrale des accès dans tout {{site.data.keyword.cloud_notm}}.
- Permet à un utilisateur ou à un service d'accéder à plusieurs ressources différentes avec le même ensemble de données d'identification (par exemple, avec le même nom d'utilisateur/mot de passe ou clé d'API IAM).
- Les clés d'API IAM peuvent obtenir un accès aux fonctions de gestion du compte, comme pour la création de nouvelles bases de données, par exemple.

### Données d'identification existantes de {{site.data.keyword.cloudant_short_notm}}
{: #ibm-cloudant-legacy}

- Uniques à {{site.data.keyword.cloudant_short_notm}}.
- L'accès à chaque instance de service nécessite son propre ensemble de données d'identification.
- Utilisation de l'authentification de base HTTP avec des données d'identification qui ne sont pas liées à un utilisateur ou à un service individuel.
- Les clés d'API de {{site.data.keyword.cloudant_short_notm}} obtiennent seulement des autorisations au niveau de la base de données.

### Remarques concernant les clés d'API
{: #api-key-notes}

Dans ce document, lorsque des clés d'API sont mentionnées, il est toujours question de clés d'API IAM.
Le contrôle d'accès existant de {{site.data.keyword.cloudant_short_notm}} inclut également un concept de clés d'API et dans toutes les discussions relatives aux données d'identification existantes de {{site.data.keyword.cloudant_short_notm}} ou aux combinaisons de nom d'utilisateur/mot de passe, il est également question des clés d'API {{site.data.keyword.cloudant_short_notm}}. 

## Activation d'IAM avec {{site.data.keyword.cloudant_short_notm}}
{: #enabling-iam-with-ibm-cloudant}

Seules les nouvelles instances de service de {{site.data.keyword.cloudant_short_notm}} peuvent être utilisées avec {{site.data.keyword.cloud_notm}} IAM depuis fin juillet 2018.

Toutes les nouvelles instances de services de {{site.data.keyword.cloudant_short_notm}} sont activées pour utiliser IAM lors de la mise à disposition. En option, vous pouvez également activer le mécanisme d'authentification existant.  Lorsque vous mettez à disposition une nouvelle instance {{site.data.keyword.cloudant_short_notm}} à partir du catalogue {{site.data.keyword.cloud_notm}}, vous devez sélectionner l'une des méthodes d'authentification disponibles :

1. **Use both legacy credentials and IAM (Utiliser les données d'identification existantes et IAM)** : ce mode signifie que les données d'identification existantes et IAM sont toutes deux utilisées pour accéder au compte. En particulier, les ensembles de données d'identification existantes et IAM sont fournis à toutes les applications liées au compte et aux données d'identification de service générées.
2. **Use only IAM (Utiliser uniquement IAM)** : ce mode signifie que seules les données d'identification IAM sont fournies via la liaison des services et la génération des données d'identification.

### Clés d'API de {{site.data.keyword.cloudant_short_notm}} et _Utiliser uniquement IAM_
{: #ibm-cloudant-api-keys-and-_use-only-iam_}

L'utilisation en parallèle des clés d'API de {{site.data.keyword.cloudant_short_notm}} et IAM est possible bien que **non recommandée**. Cette recommandation tient au fait que les clés d'API de {{site.data.keyword.cloudant_short_notm}} et les autorisations ne sont pas visibles ou gérables via l'interface de la politique IAM, ce qui rend impossible la gestion holistique des accès.

Le choix entre _Utiliser uniquement IAM_ ou _Utiliser les données d'identification existantes et IAM_ affecte :

1. Si des données d'identification existantes de {{site.data.keyword.cloudant_short_notm}} du compte sont disponibles pour gérer les bases de données et d'autres actions au niveau du compte.
2. Le style de données d'identification fournies durant la génération des données d'identification du service.

En particulier, les clés d'API de {{site.data.keyword.cloudant_short_notm}} peuvent continuer d'être utilisées pour gérer l'accès à la base de données. Ces données d'identification doivent être générées et configurées via l'API HTTP.

### Mise à disposition à l'aide de la ligne de commande
{: #provisioning-by-using-the-command-line}

Lorsque vous mettez à disposition une nouvelle instance {{site.data.keyword.cloudant_short_notm}} depuis la ligne de commande, fournissez une option à l'outil `ic` en utilisant le paramètre `-p` pour activer ou désactiver les données d'identification existantes pour un compte. L'option est transférée au format JSON et est appelée `legacyCredentials`.

Pour mettre à disposition une instance et _Utiliser uniquement IAM_ (recommandé), exécutez la commande suivante :

```sh
ic resource service-instance-create  "Instance Name" \
    cloudantnosqldb Standard us-south \
    -p {"legacyCredentials": false}
```

Pour mettre à disposition une instance et _Utiliser les données d'identification existantes et IAM_, exécutez la commande suivante :

```sh
ic resource service-instance-create  "Instance Name" \
    cloudantnosqldb Standard us-south \
    -p {"legacyCredentials": true}
```

### Exemples JSON de données d'identification de service pour chaque option
{: #service-credential-json-examples-for-each-option}

La sélection du contrôle d'accès _Utiliser uniquement IAM_ et _Utiliser les données d'identification existantes et IAM_ affecte la manière dont les données d'identification sont livrées à votre application lors de la liaison et de la génération des données d'identification du service. Lorsque vous générez des données d'identification dans l'interface IAM principale de {{site.data.keyword.cloud_notm}}, les clés d'API s'affichent dans cette interface, une fois générée.

Vous pouvez également générer des données d'identification à partir de la section Données d'identification pour le service, d'une instance de service. La génération de données d'identification de service de cette manière crée un objet BLOB JSON de données d'identification de service que vous pouvez coller dans les applications avec tous les détails nécessaires pour accéder à l'instance de service.

Cette section montre à quoi ressemble le JSON de données d'identification de service et ce que signifie chaque valeur.

Lorsque vous sélectionnez _Utiliser uniquement IAM_, les données d'identification de service qui sont générées contiennent uniquement des valeurs IAM, semblables à l'exemple suivant :

```json
{
  "apikey": "MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz",
  "iam_apikey_description": "Auto generated apikey during resource-key [...]",
  "iam_apikey_name": "auto-generated-apikey-050d21b5-5f[...]",
  "iam_role_crn": "crn:v1:bluemix:public:iam::::serviceRole:Manager",
  "iam_serviceid_crn": "crn:v1:staging:public:iam-identity::[...]",
  "url": "https://76838001-b883-444d-90d0-46f89e942a15-bluemix.cloudant.com",
  "username": "76838001-b883-444d-90d0-46f89e942a15-bluemix"
}
```

Chaque valeur fournie dans l'exemple de JSON précédent doit être interprétée comme suit :

- `apikey` : clé d'API IAM.
- `iam_apikey_description` : description de la clé d'API IAM.
- `iam_apikey_name` : ID de la clé d'API IAM.
- `iam_role_crn` : Rôle IAM de la clé d'API IAM.
- `iam_serviceid_crn` : CRN de l'ID de service.
- `url` : Adresse URL de service de {{site.data.keyword.cloudant_short_notm}}.
- `username`: Nom du compte {{site.data.keyword.cloudant_short_notm}} interne.

Lorsque vous sélectionnez _Utiliser les données d'identification existantes et IAM_, les données d'identification du service qui sont générées contiennent à la fois les données d'identification existantes et les données d'identifications IAM, comme dans l'exemple suivant :

```json
{
  "apikey": "MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz",
  "host": "76838001-b883-444d-90d0-46f89e942a15-bluemix.cloudant.com",
  "iam_apikey_description": "Auto generated apikey during resource-key [...]",
  "iam_apikey_name": "auto-generated-apikey-050d21b5-5f[...]",
  "iam_role_crn": "crn:v1:bluemix:public:iam::::serviceRole:Manager",
  "iam_serviceid_crn": "crn:v1:staging:public:iam-identity::[...]",
  "password": "8fb6a16b48903e87b769e7f4968521e85c2394ed8f0e69b2769e56dcb27d2e76",
  "port": 443,
  "url": "https://<username>:<password>@76838001-b883-444d-90d0-46f89e942a15-bluemix.cloudant.com",
  "username": "76838001-b883-444d-90d0-46f89e942a15-bluemix"
}
```
{: codeblock}

Chaque valeur fournie dans l'exemple de JSON précédent doit être interprétée comme suit :

- `apikey` : clé d'API IAM.
- `host` : Nom d'hôte du service {{site.data.keyword.cloudant_short_notm}}.
- `iam_apikey_description` : description de la clé d'API IAM.
- `iam_apikey_name` : ID de la clé d'API IAM.
- `iam_role_crn` : Rôle IAM de la clé d'API IAM.
- `iam_serviceid_crn` : CRN de l'ID de service.
- `password` : Mot de passe des données d'identification existantes de {{site.data.keyword.cloudant_short_notm}}.
- `port` : Port du service {{site.data.keyword.cloudant_short_notm}}.
- `url` : URL du service {{site.data.keyword.cloudant_short_notm}} incluant les données d'identification existantes de {{site.data.keyword.cloudant_short_notm}} intégrées.
- `username` : Nom d'utilisateur des données d'identification existantes de {{site.data.keyword.cloudant_short_notm}}.

## Quelle option choisir : _Utiliser uniquement IAM_ ou _Utiliser les données d'identification existantes et IAM_ ?
{: #should-i-use-_use-only-iam_-or-_use-both-legacy-credentials-and-iam_-}

Si possible, il est préférable de choisir l'option _Utiliser uniquement IAM_. L'option d'utiliser {{site.data.keyword.cloud_notm}} IAM offre les principaux avantages suivants :

- Gestion des accès à {{site.data.keyword.cloudant_short_notm}} avec les outils standard de {{site.data.keyword.cloud_notm}} au lieu de combiner la gestion des données d'identifications spécifique à {{site.data.keyword.cloud_notm}} et à {{site.data.keyword.cloudant_short_notm}}.
- Les données d'identification peuvent être facilement révoquées et renouvelées lorsque vous utilisez {{site.data.keyword.cloud_notm}} IAM.

Vous trouverez ci-dessous une description supplémentaire des avantages et des inconvénients de chaque approche.

### Avantages et inconvénients des deux mécanismes de contrôle d'accès
{: #advantages-and-disadvantages-of-the-two-access-control-mechanisms}

Globalement, {{site.data.keyword.cloud_notm}} IAM est le modèle d'authentification recommandé. Cependant il existe des inconvénients à cette approche, principalement si vous avez une application existante ou n'êtes pas en mesure d'utiliser une bibliothèque client prise en charge par {{site.data.keyword.cloudant_short_notm}}.

<table>
<caption style="caption-side:top">Tableau 1. Avantages et inconvénients des deux mécanismes de contrôle d'accès</caption>
<thead>
<tr>
<th id="mode">Mode</th>
<th id="advantages">Avantages</th>
<th id="disadvantages">Inconvénients</th>
</tr>
</thead>
<tr>
<td headers="mode">IAM</td>
<td headers="advantages" valign="top"><ul><li>Gestion des accès pour plusieurs services à l'aide d'une seule interface. L'accès à un utilisateur peut être révoqué globalement.</li>
<li>Clés d'API au niveau du compte via les ID de service.</li>
<li>Données d'identification faciles à renouveler.</li>
<li>Les journaux de suivi des activités capturent les personnes et les services individuels.</li>
<li>IAM est fédéré avec d'autres systèmes d'identification, tels que les référentiels LDAP d'entreprise.</li></ul>
</td>
<td headers="disadvantages"><ul><li>Si vous n'utilisez pas les bibliothèques prises en charge par {{site.data.keyword.cloudant_short_notm}}, il est possible que des modifications soient nécessaires au niveau de l'application pour utiliser les clés d'API d'IAM et les jetons d'accès.</li>
<li>Aucune modification au niveau de la base de données (pour l'instant).</li>
<li>Certains noeuds finaux ne sont pas disponibles, voir [Noeuds finaux non disponibles](#unavailable-endpoints).</li>
<li>Il est impossible de spécifier une base de données comme "publique", c'est-à-dire qui ne nécessite pas d'utilisateur autorisé pour l'accès.</li></ul>
</td>
</tr>

<tr>
<td headers="mode">Existantes</td>
<td headers="advantages">
<ul><li>Pas besoin de changer les applications existantes ou les dépendances de bibliothèques client.</li>
<li>Autorisation au niveau de la base de données.</li>
</ul>
</td>
<td headers="disadvantages">
<ul><li>Pas de clé d'API au niveau du compte : vous devez utiliser les données d'identification `root` pour gérer les bases de données.</li>
<li>Gestion séparée des données d'identification {{site.data.keyword.cloudant_short_notm}} et donc impossibilité d'obtenir un aperçu complet de tous les accès au sein de l'interface centralisée.</li>
<li>Difficulté d'implémenter le renouvellement des données d'identification.</li>
</ul>
</td>
</tr>
</table>

## Envoi de demandes aux instances à l'aide des données d'identification IAM
{: #making-requests-to-instances-by-using-iam-credentials}

Cette section explique comment utiliser {{site.data.keyword.cloudant_short_notm}} avec les instances de service via l'authentification et le contrôle d'accès IAM. Elle utilise les détails de l'exemple JSON de données d'identification de service mentionné plus haut.

{{site.data.keyword.cloud_notm}} IAM exige qu'une clé d'API IAM soit échangée contre un jeton d'accès limité dans le temps avant d'envoyer une demande à une ressource ou à un service. Le jeton d'accès est ensuite inclus dans l'en-tête HTTP `Authorization` envoyée au service. Quand le jeton d'accès expire, l'application consommatrice doit en obtenir un autre de la part du service de jeton IAM. Pour plus d'informations, veuillez consulter la documentation [Getting an {{site.data.keyword.cloud_notm}} IAM token by using an API key ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://cloud.ibm.com/docs/iam/apikey_iamtoken.html#iamtoken_from_apikey).

Les bibliothèques client officielles de {{site.data.keyword.cloudant_short_notm}} gèrent l'obtention d'un jeton à partir d'une clé d'API pour vous. Si vous accédez à {{site.data.keyword.cloudant_short_notm}} directement à l'aide d'un client HTTP au lieu d'une bibliothèque client {{site.data.keyword.cloudant_short_notm}}, vous devez gérer l'échange et actualiser un jeton d'accès limité dans le temps à l'aide d'une clé d'API IAM avec le service de jeton IAM. Une fois qu'un jeton expire, {{site.data.keyword.cloudant_short_notm}} renvoie un code de statut HTTP `401`.

### Versions de bibliothèques client requises
{: #required-client-library-versions}

Veuillez utiliser au moins les versions de bibliothèques client suivantes avec les instances de services {{site.data.keyword.cloudant_short_notm}} activées pour IAM :

<table>
<caption style="caption-side:top">Tableau 2. Version de bibliothèque client recommandée </caption>
<thead>
<tr>
<th id="library">Bibliothèque</th>
<th id="recommended">Recommandé</th>
</tr>
</thead>
<tr>
<td headers="library"><a href="https://github.com/cloudant/java-cloudant" target="_blank">java-cloudant <img src="../images/launch-glyph.svg" alt="Icône de lien externe" title="Icône de lien externe"></a></td>
<td headers="recommended">2.13.0+</td>
</tr>

<tr>
<td headers="library"><a href="https://github.com/cloudant/nodejs-cloudant" target="_blank">nodejs-cloudant <img src="../images/launch-glyph.svg" alt="Icône de lien externe" title="Icône de lien externe"></a></td>
<td headers="recommended">2.3.0+</td>
</tr>

<tr>
<td headers="library"><a href="https://github.com/cloudant/python-cloudant" target="_blank">python-cloudant <img src="../images/launch-glyph.svg" alt="Icône de lien externe" title="Icône de lien externe"></a></td>
<td headers="recommended">2.9.0+</td>
</tr>

<tr>
<td headers="library"><a href="https://github.com/cloudant/couchbackup/" target="_blank">couchbackup <img src="../images/launch-glyph.svg" alt="Icône de lien externe" title="Icône de lien externe"></a></td>
<td headers="recommended">2.3.1+</td>
</tr>

<tr>
<td headers="library"><a href="https://github.com/cloudant/cdtdatastore/" target="_blank">CDTDatastore <img src="../images/launch-glyph.svg" alt="Icône de lien externe" title="Icône de lien externe"></a></td>
<td headers="recommended">2.0.3+</td>
</tr>

<tr>
<td headers="library"><a href="https://github.com/cloudant/sync-android/" target="_blank">sync-android <img src="../images/launch-glyph.svg" alt="Icône de lien externe" title="Icône de lien externe"></a></td>
<td headers="recommended">2.2.0+</td>
</tr>
</table>

Les fragments de code suivants nécessitent ces versions.

### Java
{: #java-iam}

Requiert [java-cloudant ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/cloudant/java-cloudant){: new_window}, 2.13.0+.

Utilisez la méthode `iamApiKey()` pour créer un client de base de données avec une clé d'API IAM :

```java
package com.mycompany.app;

import com.cloudant.client.api.ClientBuilder;
import com.cloudant.client.api.CloudantClient;


public class App {
    public static void main( String[] args )
    {
        CloudantClient client = ClientBuilder
                .account("76838001-b883-444d-90d0-46f89e942a15-bluemix")
                .iamApiKey("MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz")
                .build();

        for (String db : client.getAllDbs()) {
            System.out.println(db);
        }
    }
}
```

### Node.js
{: #node.js}

Requiert [nodejs-cloudant ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/cloudant/nodejs-cloudant){: new_window}, 2.3.0+.

Utilisez le plug-in `iamauth` pour créer un client de base de données avec une clé d'API IAM :

```js
var Cloudant = require('@cloudant/cloudant');

var cloudant = new Cloudant({
  account: '76838001-b883-444d-90d0-46f89e942a15-bluemix',
  plugins: {
    iamauth: {
      iamApiKey: 'MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz'
    }
  }
});
cloudant.db.list(function(err, body) {
  body.forEach(function(db) {
    console.log(db);
  });
});
```

### Python
{: #python}

Requiert [python-cloudant ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/cloudant/python-cloudant){: new_window}, 2.9.0+.

Utilisez la méthode `Cloudant.iam(account_name, api_key, **kwargs)` pour créer un client de base de données avec une clé d'API IAM :

```python
from cloudant.client import Cloudant

client = Cloudant.iam(
    "76838001-b883-444d-90d0-46f89e942a15-bluemix",
    "MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz",
    connect=True
)
print client.all_dbs()
```

### Accès à l'aide du client HTTP
{: #access-by-using-http-client}

{{site.data.keyword.cloud_notm}} IAM exige qu'une clé d'API IAM soit échangée contre un jeton d'accès limité dans le temps avant d'envoyer une demande à une ressource ou à un service. Le jeton d'accès est ensuite inclus dans l'en-tête HTTP `Authorization` envoyée au service. Lorsque le jeton d'accès expire, le client doit en obtenir un autre du service de jeton IAM.

Comme indiqué précédemment, l'utilisation de {{site.data.keyword.cloud_notm}} IAM nécessite que vous échangiez d'abord une clé d'API {{site.data.keyword.IBM_notm}} contre un jeton d'accès à durée limitée, puis que vous utilisiez le jeton pour vous authentifier auprès de l'API {{site.data.keyword.cloudant_short_notm}}.

Exemple dans Python :

```python
import time

import requests

API_KEY = "MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz"
ACCOUNT = "76838001-b883-444d-90d0-46f89e942a15-bluemix"

def get_access_token(api_key):
    """Retrieve an access token from the IAM token service."""
    token_response = requests.post(
        "https://iam.cloud.ibm.com/identity/token",
        data={
            "grant_type": "urn:ibm:params:oauth:grant-type:apikey",
            "response_type": "cloud_iam",
            "apikey": api_key
        },
        headers={
            "Accept": "application/json"
        }
    )
    if token_response.status_code == 200:
        print "Got access token from IAM"
        return token_response.json()['access_token']
    else:
        print token_response.status_code, token_response.json()
        return None

def main(api_key, account):
    access_token = None
    while True:
        if not access_token:
            access_token = get_access_token(api_key)

        if access_token:
            response = requests.get(
                "https://{0}.cloudant.com/_all_dbs".format(account),
                headers={
                    "Accept": "application/json",
                    "Authorization": "Bearer {0}".format(access_token)
                }
            )
            print "Got Cloudant response, status code", response.status_code
            if response.status_code == 401:
                print "Token has expired."
                access_token = None

        time.sleep(1)

if __name__ == "__main__":
    main(API_KEY, ACCOUNT)
```

## Référence
{: #reference}

Cette section contient une liste complète des actions IAM de {{site.data.keyword.cloudant_short_notm}} et indique quelles sont les actions autorisées pour chaque rôle de système IAM.

### Actions de {{site.data.keyword.cloudant_short_notm}}
{: #ibm-cloudant-actions}

Les tableaux suivants décrivent les actions et les rôles IAM disponibles.  

<table>
<caption style="caption-side:top">Tableau 3. Description de l'action disponible </caption>
<thead>
<tr>
<th id="action">Action</th>
<th id="description">Description</th>
</tr>
</thead>

<tr>
<td headers="action"><code>cloudant.db.any</code></td>
<td headers="description">Accès à n'importe quel noeud final de base de données (ceux dont les chemins d'accès ne commencent pas par `/_api`).</td>
</tr>

<tr>
<td headers="action"><code>cloudantnosqldb.sapi.dbsecurity</code></td>
<td headers="description">Accès à `/_api/v2/db/<path:db>/_security`.</td>
</tr>

<tr>
<td headers="action"><code>cloudantnosqldb.sapi.usercors</code></td>
<td headers="description">Accès à `/_api/v2/user/config/cors/`.</td>
</tr>

<tr>
<td headers="action"><code>cloudantnosqldb.sapi.apikeys</code></td>
<td headers="description">Accès à `/_api/v2/api_keys`.</td>
</tr>

<tr>
<td headers="action"><code>cloudantnosqldb.sapi.userinfo</code></td>
<td headers="description">Accès à `/_api/v2/user`.</td>
</tr>
</table>
</br>
Pour une autorisation détaillée, nous proposons les rôles Responsable, Lecteur et Rédacteur. </br>

<table>
<caption style="caption-side:top">Tableau 4. Actions réservées au Responsable</caption>
<thead>
<tr>
<th id="method">Méthode</th>
<th id="endpoint">Noeud final</th>
<th id="action-name">Nom d'action</th>
<th id="role">Rôle</th>
</tr>
</thead>

<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/</code></td>
<td headers="action-name">cloudantnosqldb.db.meta-info</td>
<td headers="role">Responsable</td>
</tr>

<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/_active_tasks</code></td>
<td headers="action-name">cloudantnosqldb.account.active-tasks</td>
<td headers="role">Responsable</td>
</tr>

<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/_replicator</code></td>
<td headers="action-name">cloudantnosqldb.replication.status</td>
<td headers="role">Responsable</td>
</tr>

<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/_replicator/$DOC</code></td>
<td headers="action-name">cloudantnosqldb.replication.status</td>
<td headers="role">Responsable</td>
</tr>

<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/_scheduler/jobs</code></td>
<td headers="action-name">cloudantnosqldb.replication.status</td>
<td headers="role">Responsable</td>
</tr>

<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/_scheduler/docs</code></td>
<td headers="action-name">cloudantnosqldb.replication.status</td>
<td headers="role">Responsable</td>
</tr>

<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/_replicate</code></td>
<td headers="action-name">cloudantnosqldb.replication.write</td>
<td headers="role">Responsable</td>
</tr>

<tr>
<td headers="method"><code>PUT/DELETE</code></td>
<td headers="endpoint"><code>/_replicator</code></td>
<td headers="action-name">cloudantnosqldb.replication.write</td>
<td headers="role">Responsable</td>
</tr>

<tr>
<td headers="method"><code>PUT/DELETE</code></td>
<td headers="endpoint"><code>/_replicator/$DOC</code></td>
<td headers="action-name">cloudantnosqldb.replication.write</td>
<td headers="role">Responsable</td>
</tr>

<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/_up</code></td>
<td headers="action-name">cloudantnosqldb.account.up</td>
<td headers="role">Responsable</td>
</tr>

<tr>
<td headers="method"><code>PUT</code></td>
<td headers="endpoint"><code>/$DB/</code></td>
<td headers="action-name">cloudantnosqldb.database.create</td>
<td headers="role">Responsable</td>
</tr>

<tr>
<td headers="method"><code>DELETE</code></td>
<td headers="endpoint"><code>/$DB/</code></td>
<td headers="action-name">cloudantnosqldb.database.delete</td>
<td headers="role">Responsable</td>
</tr>

<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/$DB/_design_docs/queries</code></td>
<td headers="action-name">cloudantnosqldb.index.read</td>
<td headers="role">Responsable</td>
</tr>

<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID/_geo_info</code></td>
<td headers="action-name">cloudantnosqldb.index.read</td>
<td headers="role">Responsable</td>
</tr>

<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID/_info/$FURTHER_PATH_PARTS</code></td>
<td headers="action-name">cloudantnosqldb.index.read</td>
<td headers="role">Responsable</td>
</tr>

<tr>
<td headers="method"><code>GET</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID/_search_disk_size/$FURTHER_PATH_PARTS</code></td>
<td headers="action-name">cloudantnosqldb.index.read</td>
<td headers="role">Responsable</td>
</tr>

<tr>
<td headers="method"><code>GET</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID/_search_info/$FURTHER_PATH_PARTS</code></td>
<td headers="action-name">cloudantnosqldb.index.read</td>
<td headers="role">Responsable</td>
</tr>

<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/$DB/_index/$FURTHER_PATH_PARTS</code></td>
<td headers="action-name">cloudantnosqldb.index.read</td>
<td headers="role">Responsable</td>
</tr>

<tr>
<td headers="method"><code>GET</code></td>
<td headers="endpoint"><code>/$DB/_design_docs</code></td>
<td headers="action-name">cloudantnosqldb.index.read</td>
<td headers="role">Responsable</td>
</tr>

<tr>
<td headers="method"><code>GET</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID</code></td>
<td headers="action-name">cloudantnosqldb.index.read</td>
<td headers="role">Responsable</td>
</tr>

<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID/$ATTACHMENT</code></td>
<td headers="action-name">cloudantnosqldb.index.read</td>
<td headers="role">Responsable</td>
</tr>

<tr>
<td headers="method"><code>PUT</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID</code></td>
<td headers="action-name">cloudantnosqldb.index.write</td>
<td headers="role">Responsable</td>
</tr>

<tr>
<td headers="method"><code>COPY</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID</code></td>
<td headers="action-name">cloudantnosqldb.index.write</td>
<td headers="role">Responsable</td>
</tr>

<tr>
<td headers="method"><code>DELETE</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID</code></td>
<td headers="action-name">cloudantnosqldb.index.write</td>
<td headers="role">Responsable</td>
</tr>

<tr>
<td headers="method"><code>PUT</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID/$ATTACHMENT</code></td>
<td headers="action-name">cloudantnosqldb.index.write</td>
<td headers="role">Responsable</td>
</tr>

<tr>
<td headers="method"><code>DELETE</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID/$ATTACHMENT</code></td>
<td headers="action-name">cloudantnosqldb.index.write</td>
<td headers="role">Responsable</td>
</tr>

<tr>
<td headers="method"><code>POST/DELETE</code></td>
<td headers="endpoint"><code>/$DB/_index/$FURTHER_PATH_PARTS</code></td>
<td headers="action-name">cloudantnosqldb.index.write</td>
<td headers="role">Responsable</td>
</tr>

<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/$DB/_missing_revs</code></td>
<td headers="action-name">cloudantnosqldb.database.missing-revs</td>
<td headers="role">Responsable</td>
</tr>

<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/$DB/_missing_revs</code></td>
<td headers="action-name">cloudantnosqldb.database.missing-revs</td>
<td headers="role">Responsable</td>
</tr>

<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/$DB/_revs_diff</code></td>
<td headers="action-name">cloudantnosqldb.database.revs-diff</td>
<td headers="role">Responsable</td>
</tr>

<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/$DB/_security</code></td>
<td headers="action-name">cloudantnosqldb.database-security.read</td>
<td headers="role">Responsable</td>
</tr>

<tr>
<td headers="method"><code>PUT</code></td>
<td headers="endpoint"><code>/$DB/_security</code></td>
<td headers="action-name">cloudantnosqldb.database-security.write</td>
<td headers="role">Responsable</td>
</tr>

<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/$DB/_shards</code></td>
<td headers="action-name">cloudantnosqldb.database.shards</td>
<td headers="role">Responsable</td>
</tr>

<tr>
<td headers="method"><code>COPY</code></td>
<td headers="endpoint"><code>/$DB/$DOC_ID</code></td>
<td headers="action-name">cloudantnosqldb.document.copy</td>
<td headers="role">Responsable</td>
</tr>

<tr>
<td headers="method"><code>GET</code></td>
<td headers="endpoint"><code>/_membership</code></td>
<td headers="action-name">cloudantnosqldb.cluster-membership.read</td>
<td headers="role">Responsable</td>
</tr>

<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/$DB/_ensure_full_commit</code></td>
<td headers="action-name">cloudantnosqldb.database.ensure-full-commit</td>
<td headers="role">Responsable</td>
</tr>
</table>

</br>

<table>
<caption style="caption-side:top">Tableau 5. Actions de Responsable et Rédacteur </caption>
<thead>
<tr>
<th id="method">Méthode</th>
<th id="endpoint">Noeud final</th>
<th id="action-name">Nom d'action</th>
<th id="role">Rôle</th>
</tr>
</thead>

<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/_uuids</code></td>
<td headers="action-name">cloudantnosqldb.account.uuids</td>
<td headers="role">Responsable, Rédacteur</td>
</tr>

<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/$DB/</code></td>
<td headers="action-name">cloudantnosqldb.document.write</td>
<td headers="role">Responsable, Rédacteur</td>
</tr>

<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/$DB/_bulk_docs</code></td>
<td headers="action-name">cloudantnosqldb.document.write</td>
<td headers="role">Responsable, Rédacteur</td>
</tr>

<tr>
<td headers="method"><code>PUT</code></td>
<td headers="endpoint"><code>/$DB/$DOC_ID</code></td>
<td headers="action-name">cloudantnosqldb.document.write</td>
<td headers="role">Responsable, Rédacteur</td>
</tr>

<tr>
<td headers="method"><code>DELETE</code></td>
<td headers="endpoint"><code>/$DB/$DOC_ID</code></td>
<td headers="action-name">cloudantnosqldb.document.write</td>
<td headers="role">Responsable, Rédacteur</td>
</tr>

<tr>
<td headers="method"><code>PUT</code></td>
<td headers="endpoint"><code>/$DB/$DOC_ID/$ATTACHMENT</code></td>
<td headers="action-name">cloudantnosqldb.document.write</td>
<td headers="role">Responsable, Rédacteur</td>
</tr>

<tr>
<td headers="method"><code>DELETE</code></td>
<td headers="endpoint"><code>/$DB/$DOC_ID/$ATTACHMENT</code></td>
<td headers="action-name">cloudantnosqldb.document.write</td>
<td headers="role">Responsable, Rédacteur</td>
</tr>

<tr>
<td headers="method"><code>PUT/DELETE</code></td>
<td headers="endpoint"><code>/$DB/_local/$DOC_ID</code></td>
<td headers="action-name">cloudantnosqldb.document-local.write</td>
<td headers="role">Responsable, Rédacteur</td>
</tr>

<tr>
<td headers="method"><code>COPY</code></td>
<td headers="endpoint"><code>/$DB/_local/$DOC_ID</code></td>
<td headers="action-name">cloudantnosqldb.document-local.copy</td>
<td headers="role">Responsable, Rédacteur</td>
</tr>
</table>

</br>

<table>
<caption style="caption-side:top">Tableau 6. Actions de Responsable, Rédacteur et Lecteur </caption>
<thead>
<tr>
<th id="method">Méthode</th>
<th id="endpoint">Noeud final</th>
<th id="action-name">Nom d'action</th>
<th id="role">Rôle</th>
</tr>
</thead>
<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/_iam_session</code></td>
<td headers="action-name">cloudantnosqldb.iam-session.read</td>
<td headers="role">Responsable, Rédacteur, Lecteur </td>
</tr>

<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/_iam_session</code></td>
<td headers="action-name">cloudantnosqldb.iam-session.write</td>
<td headers="role">Responsable, Rédacteur, Lecteur </td>
</tr>
<tr>
<td headers="method"><code>DELETE</code></td>
<td headers="endpoint"><code>/_iam_session</code></td>
<td headers="action-name">cloudantnosqldb.iam-session.delete</td>
<td headers="role">Responsable, Rédacteur, Lecteur </td>
</tr>
<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/_session</code></td>
<td headers="action-name">cloudantnosqldb.session.read</td>
<td headers="role">Responsable, Rédacteur, Lecteur </td>
</tr>
<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/_session</code></td>
<td headers="action-name">cloudantnosqldb.session.write</td>
<td headers="role">Responsable, Rédacteur, Lecteur </td>
</tr>
<tr>
<td headers="method"><code>DELETE</code></td>
<td headers="endpoint"><code>/_session</code></td>
<td headers="action-name">cloudantnosqldb.session.delete</td>
<td headers="role">Responsable, Rédacteur, Lecteur </td>
</tr>
<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/_all_dbs</code></td>
<td headers="action-name">cloudantnosqldb.account.all-dbs</td>
<td headers="role">Responsable, Rédacteur, Lecteur </td>
</tr>
<tr>
<td headers="method"><code>GET</code></td>
<td headers="endpoint"><code>/_db_updates</code></td>
<td headers="action-name">cloudantnosqldb.account.db-updates</td>
<td headers="role">Responsable, Rédacteur, Lecteur </td>
</tr>
<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/_dbs_info</code></td>
<td headers="action-name">cloudantnosqldb.account.dbs-info</td>
<td headers="role">Responsable, Rédacteur, Lecteur </td>
</tr>
<tr>
<td headers="method"><code>GET</code></td>
<td headers="endpoint"><code>/$DB/</code></td>
<td headers="action-name">cloudantnosqldb.database.info</td>
<td headers="role">Responsable, Rédacteur, Lecteur </td>
</tr>
<tr>
<td headers="method"><code>GET/POST</code></td>
<td headers="endpoint"><code>/$DB/_all_docs</code></td>
<td headers="action-name">cloudantnosqldb.database.all-docs</td>
<td headers="role">Responsable, Rédacteur, Lecteur </td>
</tr>
<tr>
<td headers="method"><code>GET/POST</code></td>
<td headers="endpoint"><code>/$DB/_changes</code></td>
<td headers="action-name">cloudantnosqldb.database.changes</td>
<td headers="role">Responsable, Rédacteur, Lecteur </td>
</tr>
<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/$DB/$DOC_ID</code></td>
<td headers="action-name">cloudantnosqldb.document.read</td>
<td headers="role">Responsable, Rédacteur, Lecteur </td>
</tr>
<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/$DB/$DOC_ID/$ATTACHMENT</code></td>
<td headers="action-name">cloudantnosqldb.document.read</td>
<td headers="role">Responsable, Rédacteur, Lecteur </td>
</tr>
<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/$DB/_bulk_get</code></td>
<td headers="action-name">cloudantnosqldb.document.read</td>
<td headers="role">Responsable, Rédacteur, Lecteur </td>
</tr>

<tr>
<td headers="method"><code>GET/POST</code></td>
<td headers="endpoint"><code>/_search_analyze</code></td>
<td headers="action-name">cloudantnosqldb.query.execute</td>
<td headers="role">Responsable, Rédacteur, Lecteur </td>
</tr>
<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/$DB/_all_docs/queries</code></td>
<td headers="action-name">cloudantnosqldb.query.execute</td>
<td headers="role">Responsable, Rédacteur, Lecteur </td>
</tr>
<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID/_geo/$FURTHER_PATH_PARTS</code></td>
<td headers="action-name">cloudantnosqldb.query.execute</td>
<td headers="role">Responsable, Rédacteur, Lecteur </td>
</tr>
<tr>
<td headers="method"><code>GET/POST</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID/_list/$FURTHER_PATH_PARTS</code></td>
<td headers="action-name">cloudantnosqldb.query.execute</td>
<td headers="role">Responsable, Rédacteur, Lecteur </td>
</tr>
<tr>
<td headers="method"><code>GET/POST</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID/_search/$FURTHER_PATH_PARTS</code></td>
<td headers="action-name">cloudantnosqldb.query.execute</td>
<td headers="role">Responsable, Rédacteur, Lecteur </td>
</tr>
<tr>
<td headers="method"><code>GET/POST</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID/_show/$FURTHER_PATH_PARTS</code></td>
<td headers="action-name">cloudantnosqldb.query.execute</td>
<td headers="role">Responsable, Rédacteur, Lecteur </td>
</tr>
<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID/_view/$VIEW/queries</code></td>
<td headers="action-name">cloudantnosqldb.query.execute</td>
<td headers="role">Responsable, Rédacteur, Lecteur </td>
</tr>
<tr>
<td headers="method"><code>GET/POST</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID/_view/$FURTHER_PATH_PARTS</code></td>
<td headers="action-name">cloudantnosqldb.query.execute</td>
<td headers="role">Responsable, Rédacteur, Lecteur </td>
</tr>
<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/$DB/_explain/$FURTHER_PATH_PARTS</code></td>
<td headers="action-name">cloudantnosqldb.query.execute</td>
<td headers="role">Responsable, Rédacteur, Lecteur </td>
</tr>
<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/$DB/_find/$FURTHER_PATH_PARTS</code></td>
<td headers="action-name">cloudantnosqldb.query.execute</td>
<td headers="role">Responsable, Rédacteur, Lecteur </td>
</tr>
<tr>
<td headers="method"><code>GET</code></td>
<td headers="endpoint"><code>/$DB/_local_docs</code></td>
<td headers="action-name">cloudantnosqldb.document-local.read</td>
<td headers="role">Responsable, Rédacteur, Lecteur </td>
</tr>
<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/$DB/_local_docs/queries</code></td>
<td headers="action-name">cloudantnosqldb.document-local.read</td>
<td headers="role">Responsable, Rédacteur, Lecteur </td>
</tr>
<tr>
<td headers="method"><code>GET</code></td>
<td headers="endpoint"><code>/$DB/_local/$DOC_ID</code></td>
<td headers="action-name">cloudantnosqldb.document-local.read</td>
<td headers="role">Responsable, Rédacteur, Lecteur </td>
</tr>
</table>

</br>

#### Noeuds finaux non disponibles
{: #unavailable-endpoints}

Les noeuds finaux suivants ne sont pas disponibles pour les demandes autorisées avec IAM :

- Responsables de réécriture HTTP : `/db/_design/design-doc/_rewrite/path`. <br>
Bien que les documents de conception puissent contenir des gestionnaires de réécriture, les utilisateurs ne peuvent pas les appeler.
- Responsables de mise à jour : `POST /{db}/_design/{ddoc}/_update/{func}`. <br>
Bien que les documents de conception puissent contenir des fonctions de mise à jour, les utilisateurs ne peuvent pas les appeler.

### Mappage d'actions {{site.data.keyword.cloudant_short_notm}} aux rôles IAM
{: #mapping-of-ibm-cloudant-actions-to-iam-roles}

Seuls les utilisateurs et les services ayant le rôle de responsable peuvent accéder aux données de {{site.data.keyword.cloudant_short_notm}}.

<table>
<caption style="caption-side:top">Tableau 7. Rôles mappés sur les actions autorisées </caption>
<thead>
<tr>
<th id="role">Rôle</th>
<th id="allowed-action">Action autorisée</th>
</tr>
</thead>

<tr>
<td headers="role">Responsable</td>
<td headers="allowed-action">Toutes les actions documentées</td>
</tr>

<tr>
<td headers="role">Lecteur</td>
<td headers="allowed-action">Aucune</td>
</tr>

<tr>
<td headers="role">Rédacteur</td>
<td headers="allowed-action">Aucune</td>
</tr>
</table>

## Traitement des incidents
{: #troubleshooting}
Si vous avez des difficultés à utiliser IAM pour vous authentifier quand vous envoyez des demandes à votre instance de service {{site.data.keyword.cloudant_short_notm}}, procédez à la vérification ci-après.

### Vérifiez que votre compte est activé pour IAM
{: #ensure-your-account-is-iam-enabled}

Dans la partie Présentation du tableau de bord IBM Cloudant, la "méthode d'authentification" est répertoriée sous les détails du déploiement. Vos méthodes d'authentification disponibles y sont répertoriées. 
