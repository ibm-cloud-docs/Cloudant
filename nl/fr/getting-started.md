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

<!-- Acrolinx: 2018-05-31 -->

# Tutoriel de mise en route
{: #getting-started-with-cloudant}

Dans ce tutoriel de mise en route d'{{site.data.keyword.cloudantfull}}, nous allons utiliser le langage Python pour créer une base de données {{site.data.keyword.cloudant_short_notm}} et la remplir avec une collection simple de données.
{:shortdesc}

En plus de ce tutoriel, consultez nos tutoriels de travaux pratiques afin d'en apprendre davantage sur {{site.data.keyword.cloudant_short_notm}}. Ou, essayez l'un des tutoriels qui se concentre sur un langage spécifique :

- [Liberty for Java et {{site.data.keyword.cloudant_short_notm}} ![Icône de lien externe](images/launch-glyph.svg "Icône de lien externe")](https://console.bluemix.net/docs/runtimes/liberty/getting-started.html#getting-started-tutorial){:new_window}
- [Node.js et {{site.data.keyword.cloudant_short_notm}} ![Icône de lien externe](images/launch-glyph.svg "Icône de lien externe")](https://console.bluemix.net/docs/runtimes/nodejs/getting-started.html#getting-started-tutorial){:new_window}
- [Swift et {{site.data.keyword.cloudant_short_notm}} ![Icône de lien externe](images/launch-glyph.svg "Icône de lien externe")](https://console.bluemix.net/docs/runtimes/swift/getting-started.html#getting-started-tutorial){:new_window}

Pour des tutoriels sur des langages plus spécifiques, consultez [Commencez à déployer votre première application![Icône de lien externe](images/launch-glyph.svg "Icône de lien externe")](https://console.bluemix.net/docs/){:new_window}. 

<div id="prerequisites"></div>

## Avant de commencer
{: #prereqs}

Vous devez posséder un [compte {{site.data.keyword.cloud}} ![Icône de lien externe](images/launch-glyph.svg "Icône de lien externe")](https://console.ng.bluemix.net/registration/){:new_window}, une instance du service {{site.data.keyword.cloudant_short_notm}} et respecter les exigences Python suivantes :

*	Installez la version la plus récente du [langage de programmation Python ![Icône de lien externe](images/launch-glyph.svg "Icône de lien externe")](https://www.python.org/){:new_window} sur votre système.
	
	Pour savoir si vous disposez d'une telle installation, exécutez la commande suivante à l'invite :
	```sh
	python --version
	```
	{:pre}
	
	Un résultat similaire à celui-ci s'affiche :

	```
	Python 2.7.12
	```
	{:screen}

*	Installez la [bibliothèque Python](libraries/supported.html#python) pour que vos applications Python soient compatibles avec {{site.data.keyword.cloudant_short_notm}} sur {{site.data.keyword.cloud_notm}}.
	
	Pour vérifier que vous avez installé la bibliothèque client correctement,
exécutez la commande suivante à l'invite :
	```sh
	pip freeze
	```
	{:pre}
	
	Vous verrez une liste de tous les modules Python installés sur votre système. Inspectez la liste et recherchez une entrée {{site.data.keyword.cloudant_short_notm}} similaire à celle-ci :

	```
	cloudant==2.3.1
	```
	{:screen}
	
	Si le module `cloudant` n'est pas installé, installez-le à l'aide d'une commande similaire à la commande ci-dessous :
	
	```
	pip install cloudant==2.3.1
	```
	{:pre}

## Etape 1 : Connexion à votre instance de service {{site.data.keyword.cloudant_short_notm}} sur {{site.data.keyword.cloud_notm}}
{: #step-1-connect-to-your-cloudant-nosql-db-service-instance-on-ibm-cloud}

1.	Exécutez les instructions '`import`' des composants Bibliothèque client {{site.data.keyword.cloudant_short_notm}} pour que votre application Python puisse se connecter à votre instance de service {{site.data.keyword.cloudant_short_notm}}.
	```python
	from cloudant.client import Cloudant
	from cloudant.error import CloudantException
	from cloudant.result import Result, ResultByKey
	```
	{: codeblock}

2.  Créez de nouvelles données d'identification pour le service {{site.data.keyword.cloudant_short_notm}} :
  <br>Dans la console {{site.data.keyword.cloud_notm}}, ouvrez le tableau de bord de votre instance de service.
  <br>Dans le volet de navigation gauche, cliquez sur `Données d'identification pour le service`.
  <br>a. Cliquez sur le bouton `Nouvelles données d'identification`.
  <br>![Créer de nouvelles données d'identification de service](tutorials/images/img0050.png)
  <br>b. Entrez un nom pour les nouvelles données d'identification dans la fenêtre Ajouter de nouvelles données d'identification, comme illustré dans la capture d'écran suivante.
  <br>c. Ajoutez des paramètres de configuration en ligne (facultatif).
  <br>d. Cliquez sur le bouton `Ajouter`.
  <br>![Ajouter de nouvelles données d'identification de service](tutorials/images/img0051.png)
  <br>Vos données d'identification sont ajoutées à la table Données d'identification pour le service.
  <br>e. Cliquez sur `Afficher les données d'identification` sous Actions.
  <br>![Afficher toutes les données d'identification pour le service](tutorials/images/img0052.png)
  <br>Les détails des données d'identification du service s'affichent :
   <br>![Données d'identification du service {{site.data.keyword.cloudant_short_notm}}](tutorials/images/img0009.png)
   
3.	Etablissez une connexion à l'instance de service en exécutant la commande ci-dessous.
	Utilisez les données d'identification de l'étape précédente :
	```python
	client = Cloudant("<username>", "<password>", url="<url>")
	client.connect()
	```
	{: codeblock}


## Etape 2 : Création d'une base de données
{: #step-2-create-a-database}

1. Définissez une variable dans l'application Python :
  ```python
  databaseName = "<yourDatabaseName>"
  ```
  {: codeblock}
  ... où `<yourDatabaseName>` désigne le nom que vous souhaitez attribuer à votre base de données. 

  Le nom de la base de données doit commencer par une lettre et peut uniquement inclure des caractères en minuscules (a-z), des chiffres (0-9) ainsi que les caractères spéciaux `_`, `$`, `(`, `)`, `+`, `-` et `/`.
  {: tip}

2. Créez la base de données :
  ```python
  myDatabase = client.create_database(databaseName)
  ```
  {: codeblock}

3. Confirmez que la base de données a été créée correctement :
  ```python
  if myDatabase.exists():
      print "'{0}' successfully created.\n".format(databaseName)
  ```
  {: codeblock}

## Etape 3 : Stockage d'une petite collection de données sous forme de documents dans la base de données
{: #step-3-store-a-small-collection-of-data-as-documents-within-the-database}

1. Définissez une collection de données :
  ```python
  sampleData = [
      [1, "one", "boiling", 100],
      [2, "two", "hot", 40],
      [3, "three", "warm", 20],
      [4, "four", "cold", 10],
      [5, "five", "freezing", 0]
    ]
  ```
  {: codeblock}

2. Utilisez le code Python pour "passer en revue" les données et les convertir en documents JSON.
  Chaque document est stocké dans la base de données :

  ```python
  # Create documents by using the sample data.
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

    # Create a document by using the database API.
    newDocument = myDatabase.create_document(jsonDocument)

    # Check that the document exists in the database.
    if newDocument.exists():
        print "Document '{0}' successfully created.".format(number)
  ```
  {: codeblock}

  Notez que nous nous assurons que chaque document a bien été créé.
  {: tip}

## Etape 4 : Extraction des données à l'aide de requêtes
{: #step-4-retrieving-data-through-queries}

Une petite collection de données a été stockée sous forme de documents dans la base de données.
Vous pouvez procéder à l'extraction complète ou partielle des données de la base de données.
Une extraction partielle récupère les données de base _concernant_ un document.
Une extraction complète inclut également les données figurant _dans_ le document.

* Pour exécuter une extraction partielle :
  1. Commencez par demander la liste de tous les documents de la base de données.
    ```python
    result_collection = Result(myDatabase.all_docs)
    ```      
    {: codeblock}

    Cette liste est renvoyée sous forme de tableau.

  2. Affichez le contenu d'un élément du tableau.
    ```python
    print "Retrieved minimal document:\n{0}\n".format(result_collection[0])
    ```
    {: codeblock}

    Le résultat est similaire à ce qui suit :
    
    ```
    [{u'value': {u'rev': u'1-106e76a2612ea13468b2f243ea75c9b1'}, u'id': u'14be111aac74534cf8d390eaa57db888', u'key': u'14be111aac74534cf8d390eaa57db888'}]
    ```
    {:screen}
    
    Le préfixe `u` indique que Python affiche une chaîne Unicode.
    {: tip}

    Si nous arrangeons un peu l'apparence, nous voyons que les détails minimaux du document que nous avons obtenus sont semblables à cet exemple :
    
    ```json
    [
        {
            "value": {
                "rev": "1-106e76a2612ea13468b2f243ea75c9b1"
            },
            "id": "14be111aac74534cf8d390eaa57db888",
            "key": "14be111aac74534cf8d390eaa57db888"
        }
    ]
    ```
    {: codeblock}

    La règle selon laquelle le premier document stocké dans la base de données est toujours le premier document renvoyé dans une liste de résultats ne s'applique pas toujours aux bases de données NoSQL comme {{site.data.keyword.cloudant_short_notm}}.
    {: tip}

* Pour exécuter une extraction complète,
  demandez la liste de tous les documents de la base de données
  et spécifiez que le contenu du document doit également être renvoyé
  à l'aide de l'option `include_docs`.
  ```python
  result_collection = Result(myDatabase.all_docs, include_docs=True)
  print "Retrieved full document:\n{0}\n".format(result_collection[0])
  ```
  {: codeblock}
  
  Le résultat est similaire à ce qui suit :
  ```
  [{u'value': {u'rev': u'1-7130413a8c7c5f1de5528fe4d373045c'}, u'id': u'0cfc7d902f613d5fdb7b7818e262353b', u'key': u'0cfc7d902f613d5fdb7b7818e262353b', u'doc': {u'temperatureField': 40, u'descriptionField': u'hot', u'numberField': 2, u'nameField': u'two', u'_id': u'0cfc7d902f613d5fdb7b7818e262353b', u'_rev': u'1-7130413a8c7c5f1de5528fe4d373045c'}}]
  ```
  {: screen}
  
  Si nous arrangeons un peu l'apparence, nous pouvons voir que les détails complets du document que nous avons obtenus sont équivalents à cet exemple :
  
  ```json
  [
    {
      "value": {
        "rev": "1-7130413a8c7c5f1de5528fe4d373045c
      },
      "id": "0cfc7d902f613d5fdb7b7818e262353b",
      "key": "0cfc7d902f613d5fdb7b7818e262353b",
      "doc": {
        "temperatureField": 40,
        "descriptionField": "hot",
        "numberField": 2,
        "nameField": "two",
        "_id": "0cfc7d902f613d5fdb7b7818e262353b",
        "_rev": "1-7130413a8c7c5f1de5528fe4d373045c"
      }
    }
  ]
  ```
  {: codeblock}

## Etape 5 : Extraction des données à l'aide du noeud final d'API {{site.data.keyword.cloudant_short_notm}}
{: #step-5-retrieving-data-through-the-cloudant-nosql-db-api-endpoint}

Vous pouvez aussi demander la liste de tous les documents et de leur contenu en appelant le noeud final {{site.data.keyword.cloudant_short_notm}} [`/_all_docs`](api/database.html#get-documents).

1. Identifiez le noeud final à contacter, ainsi que tous les paramètres à renseigner parallèlement à l'appel :
  ```python
  end_point = '{0}/{1}'.format("<url>", databaseName + "/_all_docs")
  params = {'include_docs': 'true'}
  ```
  {: codeblock}
  ... où `<url>` désigne la valeur d'URL associée aux données d'identification du service obtenues à l'étape 1.

2. Envoyez la demande à l'instance de service et affichez les résultats :
  ```python
  response = client.r_session.get(end_point, params=params)
  print "{0}\n".format(response.json())
  ```
  {: codeblock}

  Le résultat est similaire à l'exemple _abrégé_ suivant :
  
  ```
  {u'rows': [{u'value': {u'rev': u'1-6d8cb5905316bf3dbe4075f30daa9f59'}, u'id': u'0532feb6fd6180d79b842d871316c444', u'key': u'0532feb6fd6180d79b842d871316c444', u'doc': {u'temperatureField': 20, u'descriptionField': u'warm', u'numberField': 3, u'nameField': u'three', u'_id': u'0532feb6fd6180d79b842d871316c444', u'_rev': u'1-6d8cb5905316bf3dbe4075f30daa9f59'}}, ... , {u'value': {u'rev': u'1-3f61736fa96473d358365ce1665e3d97'}, u'id': u'db396f77bbe12a567b09177b4accbdbc', u'key': u'db396f77bbe12a567b09177b4accbdbc', u'doc': {u'temperatureField': 0, u'descriptionField': u'freezing', u'numberField': 5, u'nameField': u'five', u'_id': u'db396f77bbe12a567b09177b4accbdbc', u'_rev': u'1-3f61736fa96473d358365ce1665e3d97'}}], u'total_rows': 5, u'offset': 0}
  ```
  {:screen}
  
  Si nous arrangeons un peu l'apparence, nous voyons que les détails _abrégés_ que nous avons obtenus sont semblables à cet exemple :
  
  ```json
  {
      "rows": [
          {
              "value": {
                "rev": "1-6d8cb5905316bf3dbe4075f30daa9f59"
              },
              "id": "0532feb6fd6180d79b842d871316c444",
              "key": "0532feb6fd6180d79b842d871316c444",
              "doc": {
                  "temperatureField": 20,
                  "descriptionField": "warm",
                  "numberField": 3,
                  "nameField": "three",
                  "_id": "0532feb6fd6180d79b842d871316c444",
                  "_rev": "1-6d8cb5905316bf3dbe4075f30daa9f59"
              }
          },
          ...
          {
              "value":
              {
                "rev": "1-6d8cb5905316bf3dbe4075f30daa9f59"
              },
              "id": "db396f77bbe12a567b09177b4accbdbc",
              "key": "db396f77bbe12a567b09177b4accbdbc",
              "doc": {
                  "temperatureField": 0,
                  "descriptionField": "freezing",
                  "numberField": 5,
                  "nameField": "five",
                  "_id": "db396f77bbe12a567b09177b4accbdbc",
                  "_rev": "1-6d8cb5905316bf3dbe4075f30daa9f59"
              }
          }
      ],
      "total_rows": 5,
      "offset": 0
  }
  ```
  {: codeblock}

## Etape 6 : Suppression de la base de données
{: #step-6-delete-the-database}

Lorsque vous n'avez plus besoin de la base de données, vous pouvez la supprimer.

```python
try :
    client.delete_database(databaseName)
except CloudantException:
    print "There was a problem deleting '{0}'.\n".format(databaseName)
else:
    print "'{0}' successfully deleted.\n".format(databaseName)
```
{: codeblock}

Nous avons inclus quelques notions de base sur la gestion des erreurs pour vous montrer comment dépanner et résoudre les problèmes potentiels.

## Etape 7 : Déconnexion de l'instance de service
{: #step-7-close-the-connection-to-the-service-instance}

L'étape finale consiste à déconnecter l'application client Python de l'instance de service :

```python
client.disconnect()
```
{: codeblock}

## Etapes suivantes
{: #next-steps}

Pour en savoir plus sur toutes les offres {{site.data.keyword.cloudant_short_notm}}, consultez le site officiel de [{{site.data.keyword.cloudant_short_notm}} ![Icône de lien externe](images/launch-glyph.svg "Icône de lien externe")](http://www.ibm.com/analytics/us/en/technology/cloud-data-services/cloudant/){:new_window}.

Pour tout renseignement complémentaire ou tutoriel sur les concepts, tâches et techniques de {{site.data.keyword.cloudant_short_notm}}, consultez la [documentation {{site.data.keyword.cloudant_short_notm}}](cloudant.html).

## Annexe : Liste complète du code Python
{: #appendix-complete-python-code-listing}

Vous trouverez ci-dessous la liste complète du code Python. 
Pensez à remplacer les valeurs `<username>`,
`<password>` et `<url>` par les données d'identification de votre service.
De même, remplacez la valeur `<yourDatabaseName>` par le nom de votre base de données.

```python
from cloudant.client import Cloudant
from cloudant.error import CloudantException
from cloudant.result import Result, ResultByKey

client = Cloudant("<username>", "<password>", url="<url>")
client.connect()

databaseName = "<yourDatabaseName>"

myDatabase = client.create_database(databaseName)

if myDatabase.exists():
    print "'{0}' successfully created.\n".format(databaseName)

sampleData = [
    [1, "one", "boiling", 100],
    [2, "two", "hot", 40],
    [3, "three", "warm", 20],
    [4, "four", "cold", 10],
    [5, "five", "freezing", 0]
]

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
    newDocument = myDatabase.create_document(jsonDocument)

    # Check that the document exists in the database.
    if newDocument.exists():
        print "Document '{0}' successfully created.".format(number)

result_collection = Result(myDatabase.all_docs)

print "Retrieved minimal document:\n{0}\n".format(result_collection[0])

result_collection = Result(myDatabase.all_docs, include_docs=True)
print "Retrieved full document:\n{0}\n".format(result_collection[0])

end_point = '{0}/{1}'.format("<url>", databaseName + "/_all_docs")
params = {'include_docs': 'true'}
response = client.r_session.get(end_point, params=params)
print "{0}\n".format(response.json())


try :
    client.delete_database(databaseName)
except CloudantException:
    print "There was a problem deleting '{0}'.\n".format(databaseName)
else:
    print "'{0}' successfully deleted.\n".format(databaseName)

client.disconnect()

```
{: codeblock}
