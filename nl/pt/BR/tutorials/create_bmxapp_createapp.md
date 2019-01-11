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

# Criando um aplicativo {{site.data.keyword.cloud_notm}} para acessar um banco de dados do {{site.data.keyword.cloudant_short_notm}}: o código

Esta seção do tutorial descreve o código
para um aplicativo {{site.data.keyword.cloud}}.
{:shortdesc}

<div id="theApp"></div>

## Criando seu aplicativo

Os componentes a seguir estão agora em vigor,
prontos para começar a criar o aplicativo:

-   [A linguagem de programação Python](create_bmxapp_prereq.html#python).
-   [Uma instância de banco de dados do {{site.data.keyword.cloudant_short_notm}}](create_bmxapp_prereq.html#csi).
-   [Um ambiente de aplicativos do {{site.data.keyword.cloud_notm}}](create_bmxapp_appenv.html#creating).
-   Uma [conexão](create_bmxapp_appenv.html#connecting) entre a instância de banco de dados do {{site.data.keyword.cloudant_short_notm}}
e o ambiente de aplicativos do {{site.data.keyword.cloud_notm}}.
-   O [kits de ferramentas](create_bmxapp_appenv.html#toolkits) para gerenciar aplicativos {{site.data.keyword.cloud_notm}} baseados no Cloud Foundry.
-   Um [pacote de aplicativos 'iniciadores'](create_bmxapp_appenv.html#starter) contendo arquivos de configuração inicial e de modelo de código.

>   **Nota**: não foi feita nenhuma tentativa de criar código Python _eficiente_ para este tutorial.
    A intenção é mostrar código operacional simples e fácil de entender
que você possa aprender e aplicar a seus próprios aplicativos.
    Além disso,
não foi feita nenhuma tentativa de tratar todas as verificações ou condições de erro possíveis.
    Foram incluídas algumas verificações de exemplo para ilustrar algumas das técnicas.
    Em seus aplicativos,
procure
e lide com
todos os avisos ou condições de erro.

### Arquivos essenciais

Seu aplicativo requer três arquivos de configuração e um arquivo de origem,
todos disponíveis no [pacote de aplicativos 'iniciadores'](create_bmxapp_appenv.html#starter):
 
-   ['`Procfile`'](create_bmxapp_appenv.html#procfile)
-   ['`manifest.yml`'](create_bmxapp_appenv.html#manifest)
-   ['`requirements.txt`'](create_bmxapp_appenv.html#requirements)
-   O arquivo de origem do aplicativo, que é descrito nesta seção do tutorial.

Modifique seus arquivos de configuração como a seguir:

1.  Edite o arquivo '`Procfile`' para que contenha o texto a seguir:
    ```
    web: python server.py
    ```
    {:codeblock}

2.  Edite o arquivo '`manifest.yml`' para que contenha o texto a seguir:
    ```
    Aplicativos:
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
    >   **Nota**: assegure-se de modificar os valores de '`domain`', '`name`', '`host`' e '`services`'. Eles são os valores que foram inseridos quando você criou seu [ambiente de aplicativos do {{site.data.keyword.cloud_notm}}](create_bmxapp_appenv.html#creating) e sua [instância de banco de dados do {{site.data.keyword.cloudant_short_notm}}](create_bmxapp_prereq.html#csi).

3.  Edite o arquivo '`requirements.txt`' para que contenha o texto a seguir:
    ```
    cloudant==2.3.1
    ```
    {:codeblock}

### O código do aplicativo

A próxima etapa é trabalhar no código do aplicativo.
Cada seção é descrita e o código é apresentado.
Uma [listagem completa](#complete-listing) do código do aplicativo
está no final desta seção do tutorial.

#### Introdução

O aplicativo Python requer alguns componentes básicos para funcionar.
Eles são importados como a seguir:

```python
# Make Python modules available.
import os
import json

# It is helpful to have access to tools
# for formatting date and time values.
from time import gmtime, strftime
```
{:codeblock}

O aplicativo opera como um servidor da web simples,
mostrando apenas uma página:
um log contendo os resultados da conexão com a instância de banco de dados do {{site.data.keyword.cloudant_short_notm}}
e a criação de um banco de dados.

O aplicativo requer componentes para entregar uma página da web:

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

>   **Nota**: este segmento de código é fornecido como parte do [pacote de aplicativos 'iniciadores'](create_bmxapp_appenv.html#starter).

O aplicativo conecta-se à instância de banco de dados do {{site.data.keyword.cloudant_short_notm}},
portanto, deve importar os componentes da Biblioteca do {{site.data.keyword.cloudant_short_notm}}:

```python
# Ative as bibliotecas do Python necessárias para trabalhar com o {{site.data.keyword.cloudant_short_notm}}.
from cloudant.client import Cloudant
from cloudant.error import CloudantException
from cloudant.result import Result, ResultByKey
```
{:codeblock}

O aplicativo cria um banco de dados dentro da instância de banco de dados do {{site.data.keyword.cloudant_short_notm}}.
É necessário um nome para o banco de dados:

```python
# This is the name of the database we intend to create.
databaseName = "databasedemo"
```
{:codeblock}

O aplicativo registra o progresso à medida que se conecta à
instância de banco de dados do {{site.data.keyword.cloudant_short_notm}}
e cria o banco de dados.
O registro assume a forma de um arquivo de log,
que é armazenado em uma pasta acessível pelo servidor da web Python.

Crie uma pasta (chamada '`static`' no aplicativo)
e prepare-se para armazenar um arquivo nela:

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

Em seguida,
crie um arquivo HTML simples.
O arquivo conterá o log de cada atividade à medida que o aplicativo criar o banco de dados:

```python
# Begin creating a very simple web page.
filename = "index.html"
target = open(filename, 'w')
target.truncate()
target.write("<html><head><title>{{site.data.keyword.cloudant_short_notm}} Demo do Python</title></head><body><p>Log of Cloudant Python steps...</p><pre>")
```
{:codeblock}

A primeira parte do log é um registro da data e hora atuais.
Esse registro ajuda a confirmar que o banco de dados realmente está sendo recém-criado:

```python
# Put a clear indication of the current date and time at the top of the page.
target.write("====\n")
target.write(strftime("%Y-%m-%d %H:%M:%S", gmtime()))
target.write("\n====\n\n")
```
{:codeblock}

#### Trabalhando com a instância de banco de dados do {{site.data.keyword.cloudant_short_notm}}

O aplicativo Python é executado em um ambiente de aplicativos do {{site.data.keyword.cloud_notm}}.
O ambiente fornece todas as informações necessárias para o aplicativo acessar serviços conectados.
As informações são fornecidas em uma variável de ambiente
chamada '`VCAP_SERVICES`'.
Essa variável pode ser acessada pelo aplicativo
e usada para determinar os detalhes da conexão.

A primeira tarefa é assegurar que o aplicativo esteja em execução em
um ambiente de aplicativos do {{site.data.keyword.cloud_notm}}.
Verifique testando a presença da variável de ambiente '`VCAP_SERVICES`':

```python
# Check that we are running in an {{site.data.keyword.cloud_notm}} application environment.
if 'VCAP_SERVICES' in os.environ:
```
{:codeblock}

>   **Nota**: as próximas seções de código serão executadas apenas se a variável de ambiente tiver sido localizada.
    No Python,
esse código é indentado para indicar que é o corpo do teste.
    Neste tutorial,
a indentação é omitida dos segmentos de código para economizar espaço.
    No entanto,
a [listagem completa](#complete-listing) mostra a indentação corretamente.

Supondo que a variável tenha sido localizada,
continue usando as informações.
Comece carregando os dados JSON armazenados na variável
e registrando o evento no novo 'arquivo de log':

```python
# Yes we are, so get the service information.
vcap_servicesData = json.loads(os.environ['VCAP_SERVICES'])
# Log the fact that we successfully found some service information.
target.write("Got vcap_servicesData\n")
```
{:codeblock}

Em seguida,
procure informações sobre a instância de banco de dados conectada do {{site.data.keyword.cloudant_short_notm}}.
Novamente,
registre o evento no 'arquivo de log':

```python
# Look for the {{site.data.keyword.cloudant_short_notm}} service instance.
cloudantNoSQLDBData = vcap_servicesData['cloudantNoSQLDB']
# Log the fact that we successfully found some {{site.data.keyword.cloudant_short_notm}} service information.
target.write("Got cloudantNoSQLDBData\n")
```
{:codeblock}

Vários serviços do {{site.data.keyword.cloud_notm}} podem ser conectados ao ambiente de aplicativos.
As credenciais para cada serviço são listadas como elementos de matriz.
Neste tutorial,
apenas uma [conexão de serviço foi criada](create_bmxapp_appenv.html#connecting).
Portanto,
o aplicativo acessa o primeiro elemento (elemento 'zero').
Cada elemento de serviço contém as credenciais para esse serviço,
expressas como uma lista indexada pelos nomes de campo essenciais que são necessários para acessar o serviço.
Mais informações sobre os nomes de campo são fornecidas no
[tutorial](create_database.html#pre-requisites) que descreve uma tarefa de criação de banco de dados simples.

```python
# Get a list containing the {{site.data.keyword.cloudant_short_notm}} connection information.
credentials = cloudantNoSQLDBData[0]
# Get the essential values for our application to talk to the service.
credentialsData = credentials['credentials']
# Log the fact that we successfully found the {{site.data.keyword.cloudant_short_notm}} values.
target.write("Got credentialsData\n\n")
```
{:codeblock}

Em seguida,
inspecione a lista e recupere os valores essenciais:

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

O aplicativo agora tem todos os detalhes necessários para criar um banco de dados dentro da
instância de banco de dados do {{site.data.keyword.cloudant_short_notm}}
Essa tarefa é descrita em mais detalhes no
[tutorial](create_database.html#creating-a-database-within-the-service-instance) que descreve a criação do banco de dados simples.

O aplicativo deve executar estas tarefas:

1.  Estabelece uma conexão com a instância de banco de dados.
2.  Cria um banco de dados com o nome fornecido [anteriormente](#getting-started).
3.  Cria um documento JSON que contém a data e hora atuais.
4.  Armazena o documento JSON no banco de dados.
5.  Confirma que o documento foi armazenado com segurança.
6.  Fecha a conexão com a instância de banco de dados.

O código para essas tarefas é como a seguir:

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

#### Fechando o arquivo de log

A próxima etapa é terminar o arquivo de log e estar
pronto para entregá-lo usando um servidor da web Python simples dentro do aplicativo:

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

#### Entregando o arquivo de log

A tarefa final é iniciar o servidor da web no aplicativo Python.
O propósito exclusivo do servidor é retornar o arquivo de log por encomenda.
Esse arquivo de log confirma que o aplicativo Python concluiu com sucesso as tarefas a seguir:

1.  Foi executado com êxito dentro do ambiente de aplicativos do {{site.data.keyword.cloud_notm}}.
2.  Determinou os detalhes para conexões de serviço.
3.  Conectou-se a uma instância de banco de dados do {{site.data.keyword.cloudant_short_notm}}.
4.  Criou um banco de dados.
5.  Criou um documento dentro do banco de dados.
6.  Respondeu com o log de eventos quando solicitado.

O código para iniciar o servidor da web Python está incluído como parte do
[pacote de aplicativos 'iniciadores'](create_bmxapp_appenv.html#starter):

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

## A próxima etapa

A próxima etapa no tutorial é [fazer upload do aplicativo](create_bmxapp_upload.html) para propósitos de teste.

## Listagem completa

O código a seguir é o programa Python completo para acessar uma instância de serviço do {{site.data.keyword.cloud_notm}} no {{site.data.keyword.cloudant_short_notm}}:

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

# Ative as bibliotecas do Python necessárias para trabalhar com o {{site.data.keyword.cloudant_short_notm}}.
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
target.write("<html><head><title>Cloudant Python Demo</title></head><body><p>Log de etapas do Python do {{site.data.keyword.cloudant_short_notm}}...</p><pre>")

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
