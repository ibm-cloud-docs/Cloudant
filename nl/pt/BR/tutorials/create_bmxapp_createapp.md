---

copyright:
  years: 2017, 2019
lastupdated: "2019-08-05"

keywords: create application, complete python program, log files, work with ibm cloudant database instance

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

# Criando um aplicativo {{site.data.keyword.cloud_notm}} para acessar um banco de dados do {{site.data.keyword.cloudant_short_notm}}: o código
{: #creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-code}

Esta seção do tutorial descreve o código
para um aplicativo {{site.data.keyword.cloud}}.
{: shortdesc}

## Criando seu aplicativo
{: #creating-your-application}

Os componentes a seguir estão agora em vigor,
prontos para começar a criar o aplicativo:

-   [A linguagem de programação Python](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites#python-create-bmxapp-prereq).
-   [Uma instância do banco de dados do {{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites#an-ibm-cloudant-database-application).
-   [Uma ambiente de aplicativos do {{site.data.keyword.cloud_notm}}](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#creating-an-ibm-cloud-application-environment).
-   Uma [conexão](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#connecting-ibm-cloud-applications-and-services) entre a instância de banco de dados do {{site.data.keyword.cloudant_short_notm}}
e o ambiente de aplicativos do {{site.data.keyword.cloud_notm}}.
-   O [kits de ferramentas](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#the-cloud-foundry-and-ibm-cloud-command-toolkits) para gerenciar aplicativos {{site.data.keyword.cloud_notm}} baseados no Cloud Foundry.
-   Um [pacote de aplicativos 'iniciadores'](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#the-starter-application) contendo arquivos de configuração inicial e de modelo de código.

Nenhuma tentativa foi feita para criar o código Python _eficiente_ para este tutorial. A intenção é mostrar código operacional simples e fácil de entender
que você possa aprender e aplicar a seus próprios aplicativos. Além disso,
não foi feita nenhuma tentativa de tratar todas as verificações ou condições de erro possíveis. Foram incluídas algumas verificações de exemplo para ilustrar algumas das técnicas. Em seus aplicativos,
procure
e lide com
todos os avisos ou condições de erro.
{: tip}


### Arquivos essenciais
{: #essential-files}

Seu aplicativo requer três arquivos de configuração e um arquivo de origem,
todos disponíveis no [pacote do aplicativo `starter`](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#the-starter-application):
 
-   [`Procfile`](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#the-procfile-file)
-   [`manifest.yml`](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#the-manifest.yml-file)
-   [`requirements.txt`](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#the-requirements.txt-file)
-   O arquivo de origem do aplicativo, que é descrito nesta seção do tutorial.

Modifique seus arquivos de configuração como a seguir:

1.  Edite o arquivo `Procfile` para que ele contenha o texto a seguir:
    ```
    web: python server.py
    ```
    {: codeblock}

2.  Edite o arquivo `manifest.yml` para que ele contenha o texto a seguir:
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
    {: codeblock}

Certifique-se de modificar os valores `domain`, `name`, `host` e `services`. Eles são os valores que foram inseridos quando você criou seu [ambiente de aplicativos do {{site.data.keyword.cloud_notm}}](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#creating-an-ibm-cloud-application-environment) e sua [instância de banco de dados do {{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites).
{: note}

3.  Edite o arquivo `requirements.txt` para que ele contenha o texto a seguir:
    ```
    cloudant==2.3.1
    ```
    {: codeblock}

### O código do aplicativo
{: #the-application-code}

A próxima etapa é trabalhar no código do aplicativo.
Cada seção é descrita e o código é apresentado.
Uma [listagem completa](#complete-python-program) do código do aplicativo
está no final desta seção do tutorial.

#### Introdução
{: #getting-started-create_bmxapp_createapp}

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
{: codeblock}

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
{: codeblock}

Esse segmento de código é fornecido como parte do [pacote de aplicativos 'starter'](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#the-starter-application).
{: note}

O aplicativo conecta-se à instância de banco de dados do {{site.data.keyword.cloudant_short_notm}},
portanto, deve importar os componentes da Biblioteca do {{site.data.keyword.cloudant_short_notm}}:

```python
# Ative as bibliotecas do Python necessárias para trabalhar com o {{site.data.keyword.cloudant_short_notm}}.
from cloudant.client import Cloudant
from cloudant.error import CloudantException
from cloudant.result import Result, ResultByKey
```
{: codeblock}

O aplicativo cria um banco de dados dentro da instância de banco de dados do {{site.data.keyword.cloudant_short_notm}}.
É necessário um nome para o banco de dados:

```python
# This is the name of the database we intend to create.
databaseName = "databasedemo"
```
{: codeblock}

O aplicativo registra o progresso à medida que se conecta à
instância de banco de dados do {{site.data.keyword.cloudant_short_notm}}
e cria o banco de dados.
O registro assume a forma de um arquivo de log,
que é armazenado em uma pasta acessível pelo servidor da web Python.

Crie uma pasta (chamada `static` no aplicativo) e prepare-se para armazenar um arquivo nela:

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
{: codeblock}

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
{: codeblock}

A primeira parte do log é um registro da data e hora atuais.
Esse registro ajuda a confirmar que o banco de dados realmente está sendo recém-criado:

```python
# Put a clear indication of the current date and time at the top of the page.
target.write("====\n")
target.write(strftime("%Y-%m-%d %H:%M:%S", gmtime()))
target.write("\n====\n\n")
```
{: codeblock}

#### Trabalhando com a instância de banco de dados do {{site.data.keyword.cloudant_short_notm}}
{: #working-with-the-ibm-cloudant-database-instance}

O aplicativo Python é executado em um ambiente de aplicativos do {{site.data.keyword.cloud_notm}}.
O ambiente fornece todas as informações necessárias para o aplicativo acessar serviços conectados.
As informações são fornecidas em uma variável de ambiente, chamada `VCAP_SERVICES`.
Essa variável pode ser acessada pelo aplicativo
e usada para determinar os detalhes da conexão.

A primeira tarefa é assegurar que o aplicativo esteja em execução em
um ambiente de aplicativos do {{site.data.keyword.cloud_notm}}.
Verifique testando a presença da variável de ambiente `VCAP_SERVICES`:

```python
# Check that we are running in an {{site.data.keyword.cloud_notm}} application environment.
if 'VCAP_SERVICES' in os.environ:
```
{: codeblock}

As próximas seções de código serão executadas apenas se a variável de ambiente foi localizada. No Python,
esse código é indentado para indicar que é o corpo do teste. Neste tutorial,
a indentação é omitida dos segmentos de código para economizar espaço. No entanto,
a [listagem completa](#complete-python-program) mostra a indentação corretamente.
{: note}

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
{: codeblock}

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
{: codeblock}

Vários serviços do {{site.data.keyword.cloud_notm}} podem ser conectados ao ambiente de aplicativos.
As credenciais para cada serviço são listadas como elementos de matriz.
Neste tutorial,
apenas uma [conexão de serviço foi criada](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#connecting-ibm-cloud-applications-and-services).
Portanto,
o aplicativo acessa o primeiro elemento (elemento 'zero').
Cada elemento de serviço contém as credenciais para esse serviço,
expressas como uma lista indexada pelos nomes de campo essenciais que são necessários para acessar o serviço.
Para obter mais informações sobre os nomes de campos, consulte o tutorial [Criando e preenchendo um banco de dados {{site.data.keyword.cloudant_short_notm}} simples no {{site.data.keyword.cloud_notm}}](/docs/services/Cloudant?topic=cloudant-creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud#prerequisites-create_database) que descreve uma tarefa de criação de banco de dados simples.

```python
# Get a list containing the {{site.data.keyword.cloudant_short_notm}} connection information.
credentials = cloudantNoSQLDBData[0]
# Get the essential values for our application to talk to the service.
credentialsData = credentials['credentials']
# Log the fact that we successfully found the {{site.data.keyword.cloudant_short_notm}} values.
target.write("Got credentialsData\n\n")
```
{: codeblock}

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
{: codeblock}

O aplicativo agora tem todos os detalhes necessários para criar um banco de dados dentro da
instância de banco de dados do {{site.data.keyword.cloudant_short_notm}}
Essa tarefa é descrita com mais detalhes na seção [Criando um banco de dados dentro da instância de serviço](/docs/services/Cloudant?topic=cloudant-creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud#creating-a-database-within-the-service-instance) que descreve a criação de banco de dados simples.

Para obter mais informações sobre a criação de banco de dados simples, consulte [Criando um banco de dados na instância de serviço](/docs/services/Cloudant?topic=cloudant-creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud#creating-a-database-within-the-service-instance).

O aplicativo deve executar estas tarefas:

1.  Estabelece uma conexão com a instância de banco de dados.
2.  Cria um banco de dados com o nome fornecido [anteriormente](#getting-started-create_bmxapp_createapp).
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
{: codeblock}

#### Fechando o arquivo de log
{: #closing-the-log-file}

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
{: codeblock}

#### Entregando o arquivo de log
{: #serving-the-log-file}

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
[pacote de aplicativos 'iniciadores'](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#the-starter-application):

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
{: codeblock}

A próxima etapa no tutorial é [fazer upload do aplicativo](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-uploading-the-application#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-uploading-the-application) para propósitos de teste.

## Concluir o programa Python
{: #complete-python-program}

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
{: codeblock}
