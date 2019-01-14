---

copyright:
  years: 2017, 2018
lastupdated: "2018-10-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:tip: .tip}

<!-- Acrolinx: 2017-05-10 -->

# Création et remplissage d'une base de données {{site.data.keyword.cloudant_short_notm}} simple sur {{site.data.keyword.cloud_notm}}

Ce tutoriel explique comment utiliser le [langage de programmation Python ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://www.python.org/){:new_window} pour créer une base de données
{{site.data.keyword.cloudantfull}} dans votre instance de service {{site.data.keyword.cloud_notm}} et comment la remplir avec une collection de données simple.
{:shortdesc}

## Conditions prérequises

Vérifiez que vous disposez des ressources ou des informations suivantes avant de
commencer à travailler sur ce tutoriel.

### Python

Vous devez disposez d'une installation en cours du [langage de programmation Python ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://www.python.org/){:new_window} sur votre système.

Pour savoir si vous disposez d'une telle installation, exécutez la commande suivante à l'invite :

```sh
python --version
```
{:pre}

Vous devez obtenir un résultat similaire à ce qui suit :

```
Python 2.7.12
```
{:codeblock}

### Python Client Library for {{site.data.keyword.cloudant_short_notm}}

Il existe une [bibliothèque officiellement prise en charge](../libraries/supported.html#python) qui active vos applications Python et fait en sorte qu'elles fonctionnent avec {{site.data.keyword.cloudant_short_notm}} sur {{site.data.keyword.cloud_notm}}.

Installez-la en suivant les instructions fournies [ici](../libraries/supported.html#python).

Pour vérifier que la bibliothèque client est correctement installée, exécutez la commande suivante à l'invite :

```sh
pip freeze
```
{:pre}

Vous devez obtenir la liste de tous les modules Python installés sur votre système.
Examinez cette liste en recherchant une entrée {{site.data.keyword.cloudant_short_notm}} similaire à l'entrée suivante :

```
cloudant==2.3.1
```
{:codeblock}

### Instance de service {{site.data.keyword.cloudant_short_notm}} sur {{site.data.keyword.cloud_notm}}

Le processus de création d'une instance de service appropriée est décrite dans [ce tutoriel](create_service.html).

Assurez-vous de disposer des données d'identification de service suivantes pour votre instance de service :

Zone      | Objectif
-----------|--------
`host`     | Nom d'hôte employé par les applications pour localiser l'instance de service.
`username` | Nom d'utilisateur requis par les applications pour accéder à l'instance de service.
`password` | Mot de passe requis par les applications pour accéder à l'instance de service.
`port`     | Numéro de port HTTP pour l'accès à l'instance de service sur l'hôte. Il s'agit généralement du numéro de port 443 qui force l'accès HTTPS.
`url`      | Chaîne regroupant les autres informations de données d'identification en une seule URL, adaptée pour une utilisation par des applications.

Vous trouverez des informations sur la recherche des données d'identification de service pour votre instance de service [ici](create_service.html#locating-your-service-credentials).

## Contexte

Ce tutoriel repose sur une série d'instructions en langage Python pouvant être utilisées lors des tâches suivantes :

1.  [Connexion à une instance de service {{site.data.keyword.cloudant_short_notm}} sur {{site.data.keyword.cloud}}](#connecting-to-a-cloudant-no-sql-db-service-instance-on-ibm-cloud).
2.  [Création d'une base de données dans l'instance de service](#creating-a-database-within-the-service-instance).
3.  [Stockage d'une petite collection de données sous forme de documents dans la base de données](#storing-a-small-collection-of-data-as-documents-within-the-database).
4.  [Extraction d'une liste complète des documents](#retrieving-a-complete-list-of-the-documents).
5.  [Suppression de la base de données](#deleting-the-database).
6.  [Fermeture de la connexion à l'instance de service](#closing-the-connection-to-the-service-instance).

Le code Python spécifique à chaque tâche est fourni dans la description de cette dernière dans ce tutoriel.

Un programme Python complet qui permet d'exécuter toutes les tâches est fourni à la fin de ce tutoriel, [ici](#complete-listing).

Aucune tentative de création d'un code Python _efficace_ n'a été effectuée pour ce tutoriel. Notre seule intention est de vous montrer un code simple et
facile à comprendre, qui fonctionne, et que vous pouvez apprendre et appliquer à vos propres applications.

De même, nous n'avons pas essayé de résoudre toutes les vérifications ou conditions d'erreur possibles.
Certains exemples de vérifications sont inclus dans le but d'illustrer certaines techniques, mais vous devez appliquer les meilleures pratiques afin de vérifier et
traiter tous les avertissements ou cas d'erreur que vous rencontrez dans vos propres applications. 

## Connexion à une instance de service {{site.data.keyword.cloudant_short_notm}} sur {{site.data.keyword.cloud_notm}}

Une application Python requiert les composants {{site.data.keyword.cloudant_short_notm}} Client Library pour pouvoir se connecter à l'instance de service.
Ces composants sont identifiés comme des instructions `import` normales :

```python
from cloudant.client import Cloudant
from cloudant.error import CloudantException
from cloudant.result import Result, ResultByKey
```
{:codeblock}

L'application doit disposer des [Données d'identification pour le service](create_service.html#locating-your-service-credentials) :

```python
serviceUsername = "353466e8-47eb-45ce-b125-4a4e1b5a4f7e-bluemix"
servicePassword = "49c0c343d225623956157d94b25d574586f26d1211e8e589646b4713d5de4801"
serviceURL = "https://353466e8-47eb-45ce-b125-4a4e1b5a4f7e-bluemix.cloudant.com"
```
{:codeblock}

Les données d'identification du service illustrées ici
    ont été définies lors de la création d'un service {{site.data.keyword.cloudant_short_notm}} de démonstration sur {{site.data.keyword.cloud_notm}}.
    Ces données d'identification sont reproduites ici pour illustrer la manière dont elles sont utilisées dans une application Python.
    Toutefois, le service {{site.data.keyword.cloudant_short_notm}} de démonstration ayant été retiré, elles ne
fonctionnent pas. Vous _devez_ indiquer et utiliser vos propres données
d'identification pour le service.
{: tip}

Une fois que vous avez activé la bibliothèque client Python dans votre application
et que vous avez identifié les données d'identification du service, vous pouvez établir
une connexion vers l'instance de service :

```python
client = Cloudant(serviceUsername, servicePassword, url=serviceURL)
client.connect()
```
{:codeblock}

A ce stade, votre application Python a accès à l'instance de service sur {{site.data.keyword.cloud_notm}}.

## Création d'une base de données dans l'instance de service

L'étape suivante consiste à créer une base de données dans l'instance de service nommée `databasedemo`.

Pour ce faire, définissez une variable dans l'application Python :

```python
databaseName = "databasedemo"
```
{:codeblock}

Créez ensuite la base de données :

```python
myDatabaseDemo = client.create_database(databaseName)
```
{:codeblock}

Il est utile de vérifier que la base de données a bien été créée :

```python
if myDatabaseDemo.exists():
    print "'{0}' successfully created.\n".format(databaseName)
```
{:codeblock}

## Stockage d'une petite collection de données sous forme de documents dans la base de données

Vous souhaitez maintenant stocker une petite collection simple de données dans la base de données.

Commencez par identifier certaines données :

```python
sampleData = [
    [1, "one", "boiling", 100],
    [2, "two", "hot", 40],
    [3, "three", "warm", 20],
    [4, "four", "cold", 10],
    [5, "five", "freezing", 0]
]
```
{:codeblock}

Appliquez ensuite plusieurs étapes de code Python ordinaire aux données afin de les convertir en documents JSON.
Chaque document est stocké dans la base de données :

```python
# Create documents using the sample data.
# Go through each row in the array
for document in sampleData:
    # Retrieve the fields in each row.
    number = document[0]
    name = document[1]
    description = document[2]
    temperature = document[3]

    # Create a JSON document that represents
    # all the data in the row.
    jsonDocument = {
        "numberField": number,
        "nameField": name,
        "descriptionField": description,
        "temperatureField": temperature
    }

    # Create a document using the Database API.
    newDocument = myDatabaseDemo.create_document(jsonDocument)

    # Check that the document exists in the database.
    if newDocument.exists():
        print "Document '{0}' successfully created.".format(number)
```
{:codeblock}

Notez que nous avons vérifié que chaque document avait bien été créé.

## Extraction des données

A ce stade, une petite collection de données a été stockée sous forme de documents dans la base de données.
Vous pouvez maintenant effectuer une série de requêtes illustrant les différents modes d'extraction des données à partir de la base de données.

### Extraction partielle d'un document

Pour procéder à une extraction partielle, commencez par demander la liste de
tous les documents figurant dans la base de données.
Cette liste est renvoyée sous forme de tableau.
Vous pouvez ensuite afficher le contenu d'un élément du tableau.

Cet exemple de code permet de demander le premier document extrait depuis la base de données :

```python
result_collection = Result(myDatabaseDemo.all_docs)
print "Retrieved minimal document:\n{0}\n".format(result_collection[0])
```
{:codeblock}

Le résultat est similaire à ce qui suit :

```json
[
    {
        "value": {
            "rev": "1-b2c48b89f48f1dc172d4db3f17ff6b9a"
        },
        "id": "14746fe384c7e2f06f7295403df89187",
        "key": "14746fe384c7e2f06f7295403df89187"
    }
]
```
{:codeblock}

La nature des bases de données NoSQL,
    comme {{site.data.keyword.cloudant_short_notm}}, signifie que les notions simples du premier document stocké dans une
base de données et toujours le premier à être renvoyé dans une liste de
résultats, ne s'appliquent pas nécessairement.
{: tip}

### Extraction complète d'un document

Pour procéder à une extraction complète, demandez la liste de tous les
documents figurant dans la base de données et indiquez que le contenu des
documents doit également être renvoyé.
Pour ce faire, indiquez l'option `include_docs`.
Comme précédemment, les résultats sont renvoyés sous forme de tableau.
Vous pouvez ensuite afficher les détails d'un élément du tableau, y compris cette fois le
contenu complet du document. 

Comme précédemment, demandez tout d'abord le premier document extrait à partir de la base de données :

```python
result_collection = Result(myDatabaseDemo.all_docs, include_docs=True)
print "Retrieved minimal document:\n{0}\n".format(result_collection[0])
```
{:codeblock}

Le résultat est similaire à ce qui suit :

```json
[
    {
        "value": {
          "rev": "1-b2c48b89f48f1dc172d4db3f17ff6b9a"
        }, "id": "14746fe384c7e2f06f7295403df89187",
        "key": "14746fe384c7e2f06f7295403df89187",
        "doc": {
            "temperatureField": 10,
            "descriptionField": "cold",
            "numberField": 4,
            "nameField": "four",
            "_id": "14746fe384c7e2f06f7295403df89187",
            "_rev": "1-b2c48b89f48f1dc172d4db3f17ff6b9a"
        }
    }
]
```
{:codeblock}

## Appel direct d'un noeud final d'API {{site.data.keyword.cloudant_short_notm}}

Vous pouvez également utiliser directement les noeuds finaux d'API {{site.data.keyword.cloudant_short_notm}} à partir d'une application Python.

Cet exemple de code permet d'appeler la liste de tous les documents, y compris leur
contenu.
Cependant, cette fois, il appelle le noeud final {{site.data.keyword.cloudant_short_notm}} [`/_all_docs`](../api/database.html#get-documents).

Identifiez d'abord le noeud final à contacter ainsi que d'éventuels paramètres à
indiquer lors de l'appel :

```python
end_point = '{0}/{1}'.format(serviceURL, databaseName + "/_all_docs")
params = {'include_docs': 'true'}
```
{:codeblock}

Envoyez ensuite la demande à l'instance de service, puis affichez les résultats :

```python
response = client.r_session.get(end_point, params=params)
print "{0}\n".format(response.json())
```
{:codeblock}

Le résultat est similaire à l'exemple _abrégé_ suivant :

```json
{
    "rows": [
        {
            "value": {
              "rev": "1-b2c48b89f48f1dc172d4db3f17ff6b9a"
            },
            "id": "14746fe384c7e2f06f7295403df89187",
            "key": "14746fe384c7e2f06f7295403df89187",
            "doc": {
                "temperatureField": 10,
                "descriptionField": "cold",
                "numberField": 4,
                "nameField": "four",
                "_id": "14746fe384c7e2f06f7295403df89187",
                "_rev": "1-b2c48b89f48f1dc172d4db3f17ff6b9a"
            }
        },
        ...
        {
            "value":
            {
              "rev": "1-7130413a8c7c5f1de5528fe4d373045c"
            },
            "id": "49baa66cc66b4dda86ffb2852ae78eb8",
            "key": "49baa66cc66b4dda86ffb2852ae78eb8",
            "doc": {
                "temperatureField": 40,
                "descriptionField": "hot",
                "numberField": 2,
                "nameField": "two",
                "_id": "49baa66cc66b4dda86ffb2852ae78eb8",
                "_rev": "1-7130413a8c7c5f1de5528fe4d373045c"
            }
        }
    ],
    "total_rows": 5,
    "offset": 0
}
```
{:codeblock}

## Suppression de la base de données

Une fois que vous en avez terminé avec la base de données, vous pouvez la supprimer.

Il s'agit d'une étape simple, comme indiqué dans l'exemple de code Python suivant :

```python
try :
    client.delete_database(databaseName)
except CloudantException:
    print "There was a problem deleting '{0}'.\n".format(databaseName)
else:
    print "'{0}' successfully deleted.\n".format(databaseName)
```
{:codeblock}

Un traitement d'erreurs de base a été inclus pour illustrer la manière dont les
problèmes peuvent être interceptés et résolus.

## Fermeture de la connexion à l'instance de service

L'étape finale consiste à déconnecter l'application client Python de l'instance de service :

```python
client.disconnect()
```
{:codeblock}

## Listing complet

Le code suivant est un programme Python complet qui accède à une instance de service
{{site.data.keyword.cloudant_short_notm}} sur
{{site.data.keyword.cloud_notm}} et effectue une série de tâches typique :

1.  Connexion à l'instance de service
2.  Création d'une base de données dans l'instance de service
3.  Stockage d'une petite collection de données sous forme de documents dans la base de données
4.  Extraction de la liste complète des documents
5.  Suppression de la base de données
6.  Fermeture de la connexion à l'instance de service

```python
# 1.  Connecting to the service instance.

# Enable the required Python libraries.

from cloudant.client import Cloudant
from cloudant.error import CloudantException
from cloudant.result import Result, ResultByKey

# Useful variables
serviceUsername = "353466e8-47eb-45ce-b125-4a4e1b5a4f7e-bluemix"
servicePassword = "49c0c343d225623956157d94b25d574586f26d1211e8e589646b4713d5de4801"
serviceURL = "https://353466e8-47eb-45ce-b125-4a4e1b5a4f7e-bluemix.cloudant.com"

# This is the name of the database we are working with.
databaseName = "databasedemo"

# This is a simple collection of data,
# to store within the database.
sampleData = [
    [1, "one", "boiling", 100],
    [2, "two", "hot", 40],
    [3, "three", "warm", 20],
    [4, "four", "cold", 10],
    [5, "five", "freezing", 0]
]

# Start the demo.
print "===\n"

# Use the {{site.data.keyword.cloudant_short_notm}} library to create an {{site.data.keyword.cloudant_short_notm}} client.
client = Cloudant(serviceUsername, servicePassword, url=serviceURL)

# Connect to the server
client.connect()

# 2.  Creating a database within the service instance.

# Create an instance of the database.
myDatabaseDemo = client.create_database(databaseName)

# Check that the database now exists.
if myDatabaseDemo.exists():
    print "'{0}' successfully created.\n".format(databaseName)

# Space out the results.
print "----\n"

# 3.  Storing a small collection of data as documents within the database.

# Create documents using the sample data.
# Go through each row in the array
for document in sampleData:
    # Retrieve the fields in each row.
    number = document[0]
    name = document[1]
    description = document[2]
    temperature = document[3]

    # Create a JSON document that represents
    # all the data in the row.
    jsonDocument = {
        "numberField": number,
        "nameField": name,
        "descriptionField": description,
        "temperatureField": temperature
    }

    # Create a document using the Database API.
    newDocument = myDatabaseDemo.create_document(jsonDocument)

    # Check that the document exists in the database.
    if newDocument.exists():
        print "Document '{0}' successfully created.".format(number)

# Space out the results.
print "----\n"

# 4.  Retrieving a complete list of the documents.

# Simple and minimal retrieval of the first
# document in the database.
result_collection = Result(myDatabaseDemo.all_docs)
print "Retrieved minimal document:\n{0}\n".format(result_collection[0])

# Simple and full retrieval of the first
# document in the database.
result_collection = Result(myDatabaseDemo.all_docs, include_docs=True)
print "Retrieved full document:\n{0}\n".format(result_collection[0])

# Space out the results.
print "----\n"

# Use an {{site.data.keyword.cloudant_short_notm}} API endpoint to retrieve
# all the documents in the database,
# including their content.

# Define the end point and parameters
end_point = '{0}/{1}'.format(serviceURL, databaseName + "/_all_docs")
params = {'include_docs': 'true'}

# Issue the request
response = client.r_session.get(end_point, params=params)

# Display the response content
print "{0}\n".format(response.json())

# Space out the results.
print "----\n"

# All done.
# Time to tidy up.

# 5.  Deleting the database.

# Delete the test database.
try :
    client.delete_database(databaseName)
except CloudantException:
    print "There was a problem deleting '{0}'.\n".format(databaseName)
else:
    print "'{0}' successfully deleted.\n".format(databaseName)

# 6.  Closing the connection to the service instance.

# Disconnect from the server
client.disconnect()

# Finish the demo.
print "===\n"

# Say good-bye.
exit()
```
{:codeblock}
