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

# Création d'une application {{site.data.keyword.cloud_notm}} simple permettant d'accéder à une base de données {{site.data.keyword.cloudant_short_notm}} : le code

Cette section du tutoriel décrit le code d'une application {{site.data.keyword.cloud}}.
{:shortdesc}

<div id="theApp"></div>

## Création de votre application

Les composants suivants sont désormais en place, prêts pour la création de l'application :

-   [Le langage de programmation Python](create_bmxapp_prereq.html#python)
-   [Une instance de base de données {{site.data.keyword.cloudant_short_notm}}](create_bmxapp_prereq.html#csi)
-   [Un environnement d'application {{site.data.keyword.cloud_notm}}](create_bmxapp_appenv.html#creating)
-   Une [connexion](create_bmxapp_appenv.html#connecting) entre l'instance de base de données {{site.data.keyword.cloudant_short_notm}} et l'environnement d'application {{site.data.keyword.cloud_notm}}
-   Les [kits d'outils](create_bmxapp_appenv.html#toolkits) pour la gestion des applications {{site.data.keyword.cloud_notm}} basées sur Cloud Foundry
-   Un [package d'application de démarrage](create_bmxapp_appenv.html#starter), contenant la configuration initiale et les fichiers de modèle de code.

>   **Remarque** : Aucune tentative de création d'un code Python _efficace_ n'a été effectuée pour ce tutoriel.
    Notre seule intention est de vous montrer un code simple et facile à comprendre, qui
fonctionne, et que vous pouvez apprendre et appliquer à vos propres applications.
    De même, nous n'avons pas essayé de résoudre toutes les vérifications ou conditions d'erreur possibles.
    Certains exemples de vérifications sont inclus dans le but d'illustrer certaines techniques.
    Dans vos applications, vérifiez et gérez les avertissements et les conditions d'erreur.

### Fichiers essentiels

Votre application exige trois fichiers de configuration et un fichier source, tous disponibles dans le [package d'application de démarrage](create_bmxapp_appenv.html#starter) :
 
-   ['`Procfile`'](create_bmxapp_appenv.html#procfile)
-   ['`manifest.yml`'](create_bmxapp_appenv.html#manifest)
-   ['`requirements.txt`'](create_bmxapp_appenv.html#requirements)
-   Le fichier source de l'application, décrit dans cette section du tutoriel.

Modifiez vos fichiers de configuration comme suit :

1.  Editez le fichier '`Procfile`' pour y inclure le texte suivant :
    ```
    web: python server.py
    ```
    {:codeblock}

2.  Editez le fichier '`manifest.yml`' pour y inclure le texte suivant :
    ```
    applications:
    - path: .
      memory: 128M
      instances: 1
      domain: <your domain>
      name: <your application name>
      host: <your application host>
      disk_quota: 1024M
      services:
      - <your database instance>
    ```
    {:codeblock}
    >   **Remarque** : prenez soin de modifier les valeurs '`domain`', '`name`', '`host`' et '`services`'. Il s'agit des valeurs que vous avez entrées lors de la création de votre [environnement d'application {{site.data.keyword.cloud_notm}}](create_bmxapp_appenv.html#creating) et de votre [instance de base de données {{site.data.keyword.cloudant_short_notm}}](create_bmxapp_prereq.html#csi).

3.  Editez le fichier '`requirements.txt`' pour y inclure le texte suivant :
    ```
    cloudant==2.3.1
    ```
    {:codeblock}

### Code de l'application

L'étape suivante consiste à rédiger le code de l'application.
Chaque section est décrite et le code est présenté.
Un [listing complet](#complete-listing) du code de l'application
figure à la fin de cette section du tutoriel.

#### Initiation

L'application Python requiert certains composants de base pour fonctionner.
Ils sont importés de la manière suivante :

```python
# Make Python modules available.
import os
import json

# It is helpful to have access to tools
# for formatting date and time values.
from time import gmtime, strftime
```
{:codeblock}

L'application fonctionne comme un simple serveur Web, n'affichant qu'une seule page :
un journal contenant les résultats de la connexion à l'instance de base de données
{{site.data.keyword.cloudant_short_notm}} et de la création d'une base de données.

L'application requiert des composants pour servir une page Web :

```python
# Simplify access to basic Python web server tools.
try:
    from SimpleHTTPServer import SimpleHTTPRequestHandler as Handler
    from SocketServer import TCPServer as Server
except ImportError:
    from http.server import SimpleHTTPRequestHandler as Handler
    from http.server import HTTPServer as Server
```
{:codeblock}

>   **Remarque** : Ce segment de code est fourni dans le [package d'application de démarrage](create_bmxapp_appenv.html#starter).

L'application se connecte à l'instance de base de données {{site.data.keyword.cloudant_short_notm}} ; elle doit donc importer les composants {{site.data.keyword.cloudant_short_notm}} Library :

```python
# Enable the required Python libraries for working with {{site.data.keyword.cloudant_short_notm}}.
from cloudant.client import Cloudant
from cloudant.error import CloudantException
from cloudant.result import Result, ResultByKey
```
{:codeblock}

L'application crée une base de données dans l'instance de base de données {{site.data.keyword.cloudant_short_notm}}.
Vous devez indiquer un nom pour la base de données :

```python
# This is the name of the database we intend to create.
databaseName = "databasedemo"
```
{:codeblock}

L'application enregistre la progression lors de sa connexion à l'instance de base
de données {{site.data.keyword.cloudant_short_notm}} et de la création de la base
de données.
L'enregistrement prend la forme d'un fichier journal, stocké dans un dossier accessible par le serveur Web Python.

Créez un dossier (nommé '`static`' dans l'application) et tenez-vous prêt pour y stocker un fichier :

```python
# Change current directory to avoid exposure of control files
try:
    os.mkdir('static')
except OSError:
    # The directory already exists,
    # no need to create it.
    pass
os.chdir('static')
```
{:codeblock}

Ensuite, créez un fichier HTML simple.
Ce fichier est destiné à contenir le journal de chaque activité lors de la création de la base de données par l'application :

```python
# Begin creating a very simple web page.
filename = "index.html"
target = open(filename, 'w')
target.truncate()
target.write("<html><head><title>{{site.data.keyword.cloudant_short_notm}} Python Demo</title></head><body><p>Log of Cloudant Python steps...</p><pre>")
```
{:codeblock}

La première partie du journal est un enregistrement de la date et de l'heure en cours.
Cet enregistrement permet de confirmer que la base de données a vraiment été créée récemment.

```python
# Put a clear indication of the current date and time at the top of the page.
target.write("====\n")
target.write(strftime("%Y-%m-%d %H:%M:%S", gmtime()))
target.write("\n====\n\n")
```
{:codeblock}

#### Utilisation de l'instance de la base de données {{site.data.keyword.cloudant_short_notm}}

L'application Python s'exécute dans un environnement d'application {{site.data.keyword.cloud_notm}}.
L'environnement fournit toutes les informations nécessaires à l'application pour accéder aux services connectés.
Ces informations sont indiquées dans une variable d'environnement nommée '`VCAP_SERVICES`'.
L'application peut accéder à cette variable qui permet de déterminer les détails de la connexion.

La première tâche consiste à vous assurer que l'application s'exécute dans un environnement d'application {{site.data.keyword.cloud_notm}}.
Pour ce faire, testez la présence de la variable d'environnement '`VCAP_SERVICES`' :

```python
# Check that we are running in an {{site.data.keyword.cloud_notm}} application environment.
if 'VCAP_SERVICES' in os.environ:
```
{:codeblock}

>   **Remarque** : Les sections suivantes du code sont exécutées uniquement si la variable d'environnement est introuvable.
    Dans Python, ce code est destiné à indiquer qu'il s'agit du corps du test.
    Dans ce tutoriel, l'indentation est omise des segments de code dans une optique de gain de place.
    Toutefois, le [listing complet](#complete-listing) indique correctement l'indentation.

En supposant que la variable est détectée, procédez comme suit pour utiliser les informations.
Commencez par charger les données JSON stockées dans la variable et par enregistrer l'événement dans le nouveau 'fichier journal' :

```python
# Yes we are, so get the service information.
vcap_servicesData = json.loads(os.environ['VCAP_SERVICES'])
# Log the fact that we successfully found some service information.
target.write("Got vcap_servicesData\n")
```
{:codeblock}

Recherchez ensuite les informations relatives à l'instance de base de données {{site.data.keyword.cloudant_short_notm}} connectée.
Enregistrez une nouvelle fois l'événement dans le 'fichier journal' :

```python
# Look for the {{site.data.keyword.cloudant_short_notm}} service instance.
cloudantNoSQLDBData = vcap_servicesData['cloudantNoSQLDB']
# Log the fact that we successfully found some {{site.data.keyword.cloudant_short_notm}} service information.
target.write("Got cloudantNoSQLDBData\n")
```
{:codeblock}

Il se peut que plusieurs services {{site.data.keyword.cloud_notm}} soient connectés à l'environnement d'application.
Les données d'identification de chaque service sont indiquées sous forme d'éléments de tableau.
Dans ce tutoriel, une seule [connexion au service a été créée](create_bmxapp_appenv.html#connecting).
L'application accède donc au premier élément (l'élément 'zero').
Chaque élément de service contient les données d'identification de ce service, exprimées sous forme de liste indexée par les noms de zone essentiels nécessaires pour accéder au service.
Vous trouverez davantage d'informations sur les noms de zone dans le [tutoriel](create_database.html#pre-requisites) qui décrit une tâche de création de base de données simple.

```python
# Get a list containing the {{site.data.keyword.cloudant_short_notm}} connection information.
credentials = cloudantNoSQLDBData[0]
# Get the essential values for our application to talk to the service.
credentialsData = credentials['credentials']
# Log the fact that we successfully found the {{site.data.keyword.cloudant_short_notm}} values.
target.write("Got credentialsData\n\n")
```
{:codeblock}

Examinez ensuite la liste et procédez à l'extraction des valeurs essentielles :

```python
# Get the username ...
serviceUsername = credentialsData['username']
target.write("Got username: ")
target.write(serviceUsername)
target.write("\n")
# ... the password ...
servicePassword = credentialsData['password']
target.write("Got password: ")
target.write(servicePassword)
target.write("\n")
# ... and the URL of the service within {{site.data.keyword.cloud_notm}}.
serviceURL = credentialsData['url']
target.write("Got URL: ")
target.write(serviceURL)
target.write("\n")
```
{:codeblock}

L'application dispose maintenant de toutes les informations nécessaires à la création d'une base de données dans l'instance de base de données {{site.data.keyword.cloudant_short_notm}}.
Cette tâche est décrite plus en détails dans le [tutoriel](create_database.html#creating-a-database-within-the-service-instance) qui décrit la création d'une base de données simple.

L'application doit effectuer les tâches suivantes :

1.  Etablir une connexion avec l'instance de base de données.
2.  Créer une base de données portant le nom fourni [précédemment](#getting-started).
3.  Créer un document JSON contenant la date et l'heure en cours.
4.  Stocker le document JSON dans la base de données.
5.  Confirmer que le document a été stocké de manière sécurisée.
6.  Fermer la connexion à l'instance de base de données.

Le code de ces tâches est le suivant :

```python
# We now have all the details we need to work with the {{site.data.keyword.cloudant_short_notm}} service instance.
# Connect to the service instance.
client = Cloudant(serviceUsername, servicePassword, url=serviceURL)
client.connect()
# Create a database within the instance.
myDatabaseDemo = client.create_database(databaseName)
if myDatabaseDemo.exists():
    target.write("'{0}' successfully created.\n".format(databaseName))
    # Create a very simple JSON document with the current date and time.
    jsonDocument = {
        "rightNow": strftime("%Y-%m-%d %H:%M:%S", gmtime())
    }
    # Store the JSON document in the database.
    newDocument = myDatabaseDemo.create_document(jsonDocument)
    if newDocument.exists():
        target.write("Document successfully created.\n")
# All done - disconnect from the service instance.
client.disconnect()
```
{:codeblock}

#### Fermeture du fichier journal

L'étape suivante consiste à terminer le fichier journal afin qu'il soit prêt à être servi via un serveur Web Python simple dans l'application:

```python
# Put another clear indication of the current date and time at the bottom of the page.
target.write("\n====\n")
target.write(strftime("%Y-%m-%d %H:%M:%S", gmtime()))
target.write("\n====\n")
# Finish creating the web page.
target.write("</pre></body></html>")
target.close()
```
{:codeblock}

#### Service du fichier journal

La tâche finale consiste à démarrer le serveur Web dans l'application Python.
L'unique objectif de ce serveur est de renvoyer le fichier journal sur demande.
Ce fichier journal confirme que l'application Python a effectué les tâches suivantes avec succès :

1.  S'est exécutée avec succès dans l'environnement d'application {{site.data.keyword.cloud_notm}}.
2.  A déterminé les détails des connexions de service.
3.  S'est connectée à une instance de base de données {{site.data.keyword.cloudant_short_notm}}.
4.  A créé une base de données.
5.  A créé un document dans la base de données.
6.  A répondu avec le journal des événements lorsque cela était demandé.

Le code de démarrage du serveur Web Python est inclus dans le [package d'application de démarrage](create_bmxapp_appenv.html#starter) :

```python
# Start up the simple Python web server application,
# so that it can 'serve' our newly created web page.
PORT = int(os.getenv('PORT', 8000))
httpd = Server(("", PORT), Handler)
try:
  print("Start serving at port %i" % PORT)
  httpd.serve_forever()
except KeyboardInterrupt:
  pass
httpd.server_close()
```
{:codeblock}

## Etape suivante

L'étape suivante du tutoriel consiste à [télécharger l'application](create_bmxapp_upload.html) à des fins de test.

## Listing complet

Le code suivant représente la totalité du programme Python permettant d'accéder à
une instance de service {{site.data.keyword.cloudant_short_notm}} sur {{site.data.keyword.cloud_notm}} :

```python
# Make Python modules available.
import os
import json

# It is helpful to have access to tools
# for formatting date and time values.
from time import gmtime, strftime

# Simplify access to basic Python web server tools.
try:
    from SimpleHTTPServer import SimpleHTTPRequestHandler as Handler
    from SocketServer import TCPServer as Server
except ImportError:
    from http.server import SimpleHTTPRequestHandler as Handler
    from http.server import HTTPServer as Server

# Enable the required Python libraries for working with {{site.data.keyword.cloudant_short_notm}}.
from cloudant.client import Cloudant
from cloudant.error import CloudantException
from cloudant.result import Result, ResultByKey

# This is the name of the database we intend to create.
databaseName = "databasedemo"

# Change current directory to avoid exposure of control files
try:
    os.mkdir('static')
except OSError:
    # The directory already exists,
    # no need to create it.
    pass
os.chdir('static')

# Begin creating a very simple web page.
filename = "index.html"
target = open(filename, 'w')
target.truncate()
target.write("<html><head><title>Cloudant Python Demo</title></head><body><p>Log of {{site.data.keyword.cloudant_short_notm}} Python steps...</p><pre>")

# Put a clear indication of the current date and time at the top of the page.
target.write("====\n")
target.write(strftime("%Y-%m-%d %H:%M:%S", gmtime()))
target.write("\n====\n\n")

# Start working with the {{site.data.keyword.cloudant_short_notm}} service instance.

# Check that we are running in an {{site.data.keyword.cloud_notm}} application environment.
if 'VCAP_SERVICES' in os.environ:
    # Yes we are, so get the service information.
    vcap_servicesData = json.loads(os.environ['VCAP_SERVICES'])
    # Log the fact that we successfully found some service information.
    target.write("Got vcap_servicesData\n")
    # Look for the {{site.data.keyword.cloudant_short_notm}} service instance.
    cloudantNoSQLDBData = vcap_servicesData['cloudantNoSQLDB']
    # Log the fact that we successfully found some {{site.data.keyword.cloudant_short_notm}} service information.
    target.write("Got cloudantNoSQLDBData\n")
    # Get a list containing the {{site.data.keyword.cloudant_short_notm}} connection information.
    credentials = cloudantNoSQLDBData[0]
    # Get the essential values for our application to talk to the service.
    credentialsData = credentials['credentials']
    # Log the fact that we successfully found the {{site.data.keyword.cloudant_short_notm}} values.
    target.write("Got credentialsData\n\n")
    # Get the username ...
    serviceUsername = credentialsData['username']
    target.write("Got username: ")
    target.write(serviceUsername)
    target.write("\n")
    # ... the password ...
    servicePassword = credentialsData['password']
    target.write("Got password: ")
    target.write(servicePassword)
    target.write("\n")
    # ... and the URL of the service within {{site.data.keyword.cloud_notm}}.
    serviceURL = credentialsData['url']
    target.write("Got URL: ")
    target.write(serviceURL)
    target.write("\n")

    # We now have all the details we need to work with the {{site.data.keyword.cloudant_short_notm}} service instance.
    # Connect to the service instance.
    client = Cloudant(serviceUsername, servicePassword, url=serviceURL)
    client.connect()
    # Create a database within the instance.
    myDatabaseDemo = client.create_database(databaseName)
    if myDatabaseDemo.exists():
        target.write("'{0}' successfully created.\n".format(databaseName))
        # Create a very simple JSON document with the current date and time.
        jsonDocument = {
            "rightNow": strftime("%Y-%m-%d %H:%M:%S", gmtime())
        }
        # Store the JSON document in the database.
        newDocument = myDatabaseDemo.create_document(jsonDocument)
        if newDocument.exists():
            target.write("Document successfully created.\n")
    # All done - disconnect from the service instance.
    client.disconnect()

# Put another clear indication of the current date and time at the bottom of the page.
target.write("\n====\n")
target.write(strftime("%Y-%m-%d %H:%M:%S", gmtime()))
target.write("\n====\n")
# Finish creating the web page.
target.write("</pre></body></html>")
target.close()

# Start up the simple Python web server application,
# so that it can 'serve' our newly created web page.
PORT = int(os.getenv('PORT', 8000))
httpd = Server(("", PORT), Handler)
try:
  print("Start serving at port %i" % PORT)
  httpd.serve_forever()
except KeyboardInterrupt:
  pass
httpd.server_close()
```
{:codeblock}
