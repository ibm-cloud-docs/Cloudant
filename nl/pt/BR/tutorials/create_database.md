---

copyright:
  years: 2017, 2019
lastupdated: "2019-06-12"

keywords: close connection, delete database, request ibm cloudant api endpoint, data retrieval, store data, create database, connect to ibm cloudant

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

# Criando e preenchendo um banco de dados {{site.data.keyword.cloudant_short_notm}} simples no {{site.data.keyword.cloud_notm}}
{: #creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud}

Este tutorial mostra como usar a [linguagem de programação Python ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.python.org/){: new_window} para
criar um banco de dados do {{site.data.keyword.cloudantfull}} em sua instância de serviço do {{site.data.keyword.cloud_notm}}
e preencher o banco de dados com uma coleção simples de dados.
{: shortdesc}

## Pré-requisitos
{: #prerequisites-create_database}

Assegure-se de que tenha os recursos ou as informações a seguir prontos,
antes de começar a trabalhar ao longo do tutorial.

### Python
{: #python-create-database}

Deve-se ter uma instalação atual da [linguagem de programação Python ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.python.org/){: new_window}
instalada no sistema.

Para verificar isso,
execute o comando a seguir em um prompt:

```sh
python --version
```
{: pre}

Você deverá ter um resultado semelhante a:

```
Python 2.7.12
```
{: codeblock}

### Python Client Library para o {{site.data.keyword.cloudant_short_notm}}
{: #python-client-library-for-ibm-cloudant}

Há uma [biblioteca oficialmente suportada](/docs/services/Cloudant?topic=cloudant-supported-client-libraries#python-supported) para permitir que os aplicativos Python trabalhem com o
{{site.data.keyword.cloudant_short_notm}} no {{site.data.keyword.cloud_notm}}. Use as instruções fornecidas para instalá-lo. 

Para verificar se a biblioteca do cliente foi instalada com sucesso,
execute o comando a seguir em um prompt:

```sh
pip freeze
```
{: pre}

É necessário obter uma lista de todos os módulos Python instalados no sistema.
Inspecione a lista,
procurando uma entrada do {{site.data.keyword.cloudant_short_notm}} semelhante à seguinte:

```
cloudant==2.3.1
```
{: codeblock}

### Criando uma instância de serviço do {{site.data.keyword.cloudant_short_notm}} no {{site.data.keyword.cloud_notm}}
{: #creating-an-ibm-cloudant-service-instance-on-ibm-cloud}

O processo para criar uma instância de serviço adequada é descrito [neste tutorial](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-an-ibm-cloudant-instance-on-ibm-cloud).

Assegure-se de que você tenha as Credenciais de serviço a seguir disponíveis para sua instância de serviço:

Campo      | Propósito
-----------|--------
`host`     | O nome do host usado por aplicativos para localizar a instância de serviço.
`username` | O nome de usuário necessário para que os aplicativos acessem a instância de serviço.
`password` | A senha necessária para que os aplicativos acessem a instância de serviço.
`port`     | O número da porta HTTP para acessar a instância de serviço no host. Normalmente 443 para forçar o acesso HTTPS.
`url`      | Uma sequência que agrega outras informações de credenciais em uma única URL, adequada para ser usada pelos aplicativos.

Para obter mais informações sobre como localizar as credenciais de serviço para a sua instância de serviço, consulte [Localizando suas credenciais de serviço](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#locating-your-service-credentials).

## Contexto
{: #context}

Este tutorial constrói uma série de instruções da linguagem Python,
adequadas para as tarefas a seguir:

1.  [Conectando-se a uma instância de serviço do {{site.data.keyword.cloudant_short_notm}} no {{site.data.keyword.cloud}}](#connecting-to-an-ibm-cloudant-service-instance-on-ibm-cloud).
2.  [Criando um banco de dados na instância de serviço](#creating-a-database-within-the-service-instance).
3.  [Armazenando uma pequena coleção de dados como documentos no banco de dados](#storing-a-small-collection-of-data-as-documents-within-the-database).
4.  [Recuperando dados](#retrieving-data).
5.  [Excluindo o banco de dados](#deleting-the-database).
6.  [Fechando a conexão com a instância de serviço](#closing-the-connection-to-the-service-instance).

Código Python específico para cada tarefa é fornecido como parte da descrição de tarefa neste tutorial.

Para obter informações sobre o programa Python completo para executar todas as tarefas, consulte a [listagem completa](#complete-listing).

Nenhuma tentativa foi feita para criar código Python _eficiente_ para este tutorial;
a intenção é mostrar o código de trabalho simples e fácil de entender
com o qual é possível aprender e aplicar para seus próprios aplicativos.

Além disso,
nenhuma tentativa foi feita para tratar de todas as possíveis verificações ou condições de erro.
Algumas verificações de exemplo são mostradas aqui
para ilustrar as técnicas,
mas será necessário aplicar as melhores práticas normais para verificar e manipular todas as
condições de aviso ou de erro encontradas por seus próprios aplicativos. 

## Conectando-se a uma instância de serviço do {{site.data.keyword.cloud_notm}} no {{site.data.keyword.cloudant_short_notm}}
{: #connecting-to-an-ibm-cloudant-service-instance-on-ibm-cloud}

Um aplicativo Python requer que os componentes do {{site.data.keyword.cloudant_short_notm}} Client Library sejam capazes de se conectar à instância de serviço.
Esses componentes são identificados como instruções `import` normais:

```python
from cloudant.client import Cloudant
from cloudant.error import CloudantException
from cloudant.result import Result, ResultByKey
```
{: codeblock}

O aplicativo deve ter as [Credenciais de serviço](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#locating-your-service-credentials) para o serviço:

```python
serviceUsername = "353466e8-47eb-45ce-b125-4a4e1b5a4f7e-bluemix"
servicePassword = "49c0c343d225623956157d94b25d574586f26d1211e8e589646b4713d5de4801"
serviceURL = "https://353466e8-47eb-45ce-b125-4a4e1b5a4f7e-bluemix.cloudant.com"
```
{: codeblock}

As credenciais de serviço ilustradas aqui
    foram definidos quando um serviço de demonstração do {{site.data.keyword.cloudant_short_notm}} foi criado no {{site.data.keyword.cloud_notm}}.
    As credenciais foram reproduzidas aqui para mostrar como seriam usadas em um aplicativo Python.
    No entanto, o serviço {{site.data.keyword.cloudant_short_notm}} de demonstração foi removido agora, então essas credenciais não funcionarão. Será _necessário_ fornecer e usar suas próprias credenciais de serviço.
{:  tip}

Depois de ter ativado a biblioteca do cliente Python em seu aplicativo
e identificado as credenciais de serviço,
será possível estabelecer uma conexão com a instância de serviço:

```python
client = Cloudant(serviceUsername, servicePassword, url=serviceURL)
client.connect()
```
{: codeblock}

Neste ponto,
seu aplicativo Python tem acesso à instância de serviço no {{site.data.keyword.cloud_notm}}.

## Criando um banco de dados na instância de serviço
{: #creating-a-database-within-the-service-instance}

A próxima etapa será criar um banco de dados na instância de serviço,
chamado `databasedemo`.

Fazemos isso definindo uma variável no aplicativo Python:

```python
databaseName = "databasedemo"
```
{: codeblock}

Em seguida, criamos o banco de dados:

```python
myDatabaseDemo = client.create_database(databaseName)
```
{: codeblock}

Será útil verificar se o banco de dados foi criado com sucesso:

```python
if myDatabaseDemo.exists():
    print "'{0}' successfully created.\n".format(databaseName)
```
{: codeblock}

## Armazenando uma pequena coleção de dados como documentos no banco de dados
{: #storing-a-small-collection-of-data-as-documents-within-the-database}

Agora desejamos armazenar uma coleção
de dados pequena e simples no banco de dados.

Começamos identificando alguns dados:

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

Em seguida,
algum código comum do Python 'percorre' os dados,
convertendo-os em documentos JSON.
Cada documento é armazenado no banco de dados:

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
{: codeblock}

Observe que verificamos que cada documento foi criado com sucesso.

## Recuperando dados
{: #retrieving-data}

Neste ponto,
uma pequena coleção de dados
foi armazenada como documentos no banco de dados.
Agora será possível executar várias consultas,
ilustrando maneiras diferentes de recuperar dados do banco de dados.

### Uma recuperação mínima de um documento
{: #a-minimal-retrieval-of-a-document}

Para executar uma recuperação mínima,
primeiramente solicitamos uma lista de todos os documentos do banco de dados.
Essa lista é retornada como uma matriz.
Podemos, então, mostrar o conteúdo de um elemento na matriz.

No código de amostra,
solicitamos o primeiro documento recuperado do banco de dados:

```python
result_collection = Result(myDatabaseDemo.all_docs)
print "Retrieved minimal document:\n{0}\n".format(result_collection[0])
```
{: codeblock}

O resultado é semelhante ao exemplo a seguir:

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
{: codeblock}

A natureza de bancos de dados NoSQL,
    como o {{site.data.keyword.cloudant_short_notm}},
significa que noções simples, como a de que o primeiro documento armazenado em um banco de dados
sempre é o primeiro documento retornado em uma lista de resultados,
não se aplicam necessariamente.
{: tip}

### Recuperação completa de um documento
{: #full-retrieval-of-a-document}

Para executar uma recuperação completa,
solicitamos uma lista de todos os documentos do banco de dados
e além disso especificar que o conteúdo do documento também seja retornado.
Fazemos isso usando a opção `include_docs`.
Como antes,
os resultados são retornados como uma matriz.
Podemos, então, mostrar os detalhes de um elemento na matriz,
desta vez incluindo o conteúdo completo do documento. 

Como antes,
solicitamos o primeiro documento recuperado do banco de dados:

```python
result_collection = Result(myDatabaseDemo.all_docs, include_docs=True)
print "Retrieved minimal document:\n{0}\n".format(result_collection[0])
```
{: codeblock}

O resultado é semelhante ao exemplo a seguir:

```json
[
    {
        "value":
            {
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
    }
]
```
{: codeblock}

## Chamando um terminal de API do {{site.data.keyword.cloudant_short_notm}} diretamente
{: #calling-an-ibm-cloudant-api-endpoint-directly}

Também podemos trabalhar com os terminais de API do {{site.data.keyword.cloudant_short_notm}} diretamente
de dentro de um aplicativo Python.

Neste código de exemplo,
solicitamos novamente uma lista de todos os documentos,
incluindo seu conteúdo.
Dessa vez,
no entanto,
fazemos isso chamando o terminal [`/_all_docs` do {{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant?topic=cloudant-databases#get-documents).

Primeiro,
identificamos o terminal para contato
e quaisquer parâmetros a serem fornecidos junto à chamada:

```python
end_point = '{0}/{1}'.format(serviceURL, databaseName + "/_all_docs")
params = {'include_docs': 'true'}
```
{: codeblock}

Em seguida,
enviamos a solicitação para a instância de serviço
e, então, exibimos os resultados:

```python
response = client.r_session.get(end_point, params=params)
print "{0}\n".format(response.json())
```
{: codeblock}

O resultado é semelhante ao exemplo _abreviado_ a seguir:

```json
{
    "rows": [
        {
            "value":
            {
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
{: codeblock}

## Excluindo o banco de dados
{: #deleting-the-database}

Quando tivermos concluído com o banco de dados,
ele poderá ser excluído.

Esta é uma etapa simples,
conforme mostrado no código Python de amostra a seguir:

```python
try :
    client.delete_database(databaseName)
except CloudantException:
    print "There was a problem deleting '{0}'.\n".format(databaseName)
else:
    print "'{0}' successfully deleted.\n".format(databaseName)
```
{: codeblock}

Incluímos alguma manipulação de erros básica para ilustrar como os problemas podem ser capturados e direcionados.

## Fechando a conexão com a instância de serviço
{: #closing-the-connection-to-the-service-instance}

A etapa final é desconectar o aplicativo cliente Python da instância de serviço:

```python
client.disconnect()
```
{: codeblock}

## Listagem completa
{: #complete-listing}

O código a seguir é um programa Python completo para acessar uma instância de serviço do {{site.data.keyword.cloud_notm}} no {{site.data.keyword.cloudant_short_notm}}
e executar uma série de tarefas típicas:

1.  Conectando à instância de serviço.
2.  Criando um banco de dados na instância de serviço.
3.  Armazenando uma pequena coleção de dados como documentos no banco de dados.
4.  Recuperando uma lista completa dos documentos.
5.  Excluindo o banco de dados.
6.  Fechando a conexão com a instância de serviço.

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
{: codeblock}
