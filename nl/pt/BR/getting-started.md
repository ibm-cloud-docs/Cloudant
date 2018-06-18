---

copyright:
  years: 2015, 2018
lastupdated: "2017-11-02"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:tip: .tip}

# Tutorial Introdução
{: #getting-started-with-cloudant}

Neste tutorial de introdução do {{site.data.keyword.cloudantfull}},
vamos usar Python para criar um banco de dados {{site.data.keyword.cloudant}}
e preenchê-lo com uma coleção simples de dados.
{:shortdesc}

<div id="prerequisites"></div>

## Antes de iniciar
{: #prereqs}

Você precisará de uma [conta do Bluemix ![Ícone de link externo](images/launch-glyph.svg "Ícone de link externo")](https://console.ng.bluemix.net/registration/){:new_window},
uma instância do serviço {{site.data.keyword.cloudant}} e os requisitos de Python a seguir:

*	Instale a versão mais recente da
[linguagem de programação Python ![Ícone de link externo](images/launch-glyph.svg "Ícone de link externo")](https://www.python.org/){:new_window} em seu sistema.
	
	Para verificar isso, execute o comando a seguir em um prompt:
	```sh
	python --version
	```
	{:pre}
	
	Você deverá ter um resultado semelhante a:

	```
	Python 2.7.12
	```
	{:screen}

*	Instale a [biblioteca do Python](libraries/supported.html#python)
para permitir que os aplicativos Python trabalhem com o
{{site.data.keyword.cloudant_short_notm}} no {{site.data.keyword.Bluemix_notm}}.
	
	Para verificar se a biblioteca do cliente foi instalada com sucesso,
execute o comando a seguir em um prompt:
	```sh
	pip freeze
	```
	{:pre}
	
	É necessário obter uma lista de todos os módulos Python instalados no sistema. Inspecione a lista, procurando uma entrada do {{site.data.keyword.cloudant_short_notm}} semelhante à seguinte:

	```
	cloudant==2.3.1
	```
	{:screen}
	
	Se o módulo do `cloudant` não estiver instalado, instale-o usando um comando semelhante ao seguinte:
	
	```
	pip install cloudant==2.3.1
	```
	{:pre}

## Etapa 1: conecte-se à sua instância de serviço do {{site.data.keyword.Bluemix_notm}} no {{site.data.keyword.cloudant_short_notm}}

1.	Execute as instruções '`import`' a seguir dos componentes da Biblioteca do cliente do {{site.data.keyword.cloudant_short_notm}}
para permitir que o aplicativo Python se conecte
à instância de serviço do {{site.data.keyword.cloudant_short_notm}}.
	```python
	from cloudant.client import Cloudant
	from cloudant.error import CloudantException
	from cloudant.result import Result, ResultByKey
	```
	{: codeblock}

2. Identifique as credenciais de serviço do {{site.data.keyword.cloudant_short_notm}}:
  1. No console do {{site.data.keyword.Bluemix_notm}}, abra o painel para sua instância de serviço.
  2. Na navegação à esquerda, clique em **`Service credentials`**.
  3. Clique em **`View credentials`** em **`ACTIONS`**.

3.	Estabeleça uma conexão com a instância de serviço executando o comando a seguir.
	Substitua suas credenciais de serviço da etapa anterior:
	```python
	client = Cloudant("<username>", "<password>", url="<url>")
	client.connect()
	```
	{: codeblock}


## Etapa 2: crie um banco de dados

1. Defina uma variável no aplicativo Python:
  ```python
  databaseName = "<yourDatabaseName>"
  ```
  {: codeblock}
  ... em que `<yourDatabaseName>` é o nome que você gostaria de dar ao banco de dados. 

  > **Nota:** o nome do banco de dados deve começar com uma letra e pode incluir apenas caracteres minúsculos (a - z), numerais (0 - 9) e qualquer um dos caracteres a seguir `_`, `$`, `(`, `)`, `+`, `-` e `/`.

2. Crie o banco de dados:
  ```python
  myDatabase = client.create_database(databaseName)
  ```
  {: codeblock}

3. Confirme se o banco de dados foi criado com sucesso:
  ```python
  if myDatabase.exists():
      print "'{0}' successfully created.\n".format(databaseName)
  ```
  {: codeblock}

## Etapa 3: armazene uma pequena coleção de dados como documentos dentro do banco de dados

1. Defina uma coleção de dados:
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

2. Use o código Python para 'passar' pelos dados e convertê-los em documentos JSON.
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
    newDocument = myDatabase.create_document(jsonDocument)

    # Check that the document exists in the database.
    if newDocument.exists():
        print "Document '{0}' successfully created.".format(number)
  ```
  {: codeblock}

Observe que verificamos que cada documento foi criado com sucesso.
{: tip}

## Etapa 4: recuperando dados por meio de consultas

Neste ponto,
uma pequena coleção de dados foi armazenada como documentos no banco de dados.
É possível executar uma recuperação mínima ou completa desses dados do banco de dados.
Uma recuperação mínima obtém os dados básicos _sobre_ um documento.
Uma recuperação completa também inclui os dados _dentro_ de um documento.

* Para executar uma recuperação mínima:
  1. Primeiro, solicite uma lista de todos os documentos no banco de dados.
    ```python
    result_collection = Result(myDatabase.all_docs)
    ```      
    {: codeblock}

    Essa lista é retornada como uma matriz.

  2. Exiba o conteúdo de um elemento na matriz.
    ```python
    print "Retrieved minimal document:\n{0}\n".format(result_collection[0])
    ```
    {: codeblock}

    O resultado é semelhante ao exemplo a seguir:
    
    ```
    [{u'value': {u'rev': u'1-106e76a2612ea13468b2f243ea75c9b1'}, u'id': u'14be111aac74534cf8d390eaa57db888', u'key': u'14be111aac74534cf8d390eaa57db888'}]
    ```
    {:screen}
    
    > **Nota:** o prefixo `u'` é simplesmente uma indicação de que o Python está exibindo uma sequência Unicode. 
    
    Se arrumarmos um pouco a aparência, poderemos ver que os detalhes mínimos do documento retornados são equivalentes a isto:
    
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
    {:screen}

  > **Nota:** a natureza de bancos de dados NoSQL,
como o {{site.data.keyword.cloudant_short_notm}},
significa que noções simples, como o primeiro documento armazenado em um banco de dados é sempre
o primeiro retornado em uma lista de resultados,
não se aplicam necessariamente.

* Para executar uma recuperação completa,
solicite uma lista de todos os documentos no banco de dados
e especifique que o conteúdo do documento também deve ser retornado
fornecendo a opção `include_docs`.
  ```python
  result_collection = Result(myDatabase.all_docs, include_docs=True)
  print "Retrieved full document:\n{0}\n".format(result_collection[0])
  ```
  {: codeblock}
  
  O resultado é semelhante ao exemplo a seguir:
  ```
  [{u'value': {u'rev': u'1-7130413a8c7c5f1de5528fe4d373045c'}, u'id': u'0cfc7d902f613d5fdb7b7818e262353b', u'key': u'0cfc7d902f613d5fdb7b7818e262353b', u'doc': {u'temperatureField': 40, u'descriptionField': u'hot', u'numberField': 2, u'nameField': u'two', u'_id': u'0cfc7d902f613d5fdb7b7818e262353b', u'_rev': u'1-7130413a8c7c5f1de5528fe4d373045c'}}]
  ```
  {: screen}
  
  Se arrumarmos um pouco a aparência, poderemos ver que os detalhes completos do documento retornados são equivalentes a isto:
  
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
  {:screen}

## Etapa 5: recuperando dados por meio do terminal de API do {{site.data.keyword.cloudant_short_notm}}

Também é possível solicitar uma lista de todos os documentos e seus conteúdos
chamando o [terminal `/_all_docs`](api/database.html#get-documents) do {{site.data.keyword.cloudant_short_notm}}.

1. Identifique o terminal para contato e quaisquer parâmetros a serem fornecidos junto à chamada:
  ```python
  end_point = '{0}/{1}'.format("<url>", databaseName + "/_all_docs")
  params = {'include_docs': 'true'}
  ```
  {: codeblock}
  ... em que `<url>` é o valor da URL das credenciais de serviço localizadas na Etapa 1.

2. Envie a solicitação para a instância de serviço
e, em seguida, exiba os resultados:
  ```python
  response = client.r_session.get(end_point, params=params)
  print "{0}\n".format(response.json())
  ```
  {: codeblock}

  O resultado é semelhante ao exemplo _abreviado_ a seguir:
  
  ```
  {u'rows': [{u'value': {u'rev': u'1-6d8cb5905316bf3dbe4075f30daa9f59'}, u'id': u'0532feb6fd6180d79b842d871316c444', u'key': u'0532feb6fd6180d79b842d871316c444', u'doc': {u'temperatureField': 20, u'descriptionField': u'warm', u'numberField': 3, u'nameField': u'three', u'_id': u'0532feb6fd6180d79b842d871316c444', u'_rev': u'1-6d8cb5905316bf3dbe4075f30daa9f59'}}, ... , {u'value': {u'rev': u'1-3f61736fa96473d358365ce1665e3d97'}, u'id': u'db396f77bbe12a567b09177b4accbdbc', u'key': u'db396f77bbe12a567b09177b4accbdbc', u'doc': {u'temperatureField': 0, u'descriptionField': u'freezing', u'numberField': 5, u'nameField': u'five', u'_id': u'db396f77bbe12a567b09177b4accbdbc', u'_rev': u'1-3f61736fa96473d358365ce1665e3d97'}}], u'total_rows': 5, u'offset': 0}
  ```
  {:screen}
  
  Podemos arrumar um pouco a aparência e ver que os detalhes _abreviados_ retornados são semelhantes a isto:
  
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
  {:screen}

## Etapa 6: exclua o banco de dados

Quando tiver concluído com o banco de dados,
ele poderá ser excluído.

```python
try :
    client.delete_database(databaseName)
except CloudantException:
    print "There was a problem deleting '{0}'.\n".format(databaseName)
else:
    print "'{0}' successfully deleted.\n".format(databaseName)
```
{: codeblock}

Incluímos alguma manipulação de erros básica
para ilustrar como os problemas podem ser capturados e direcionados.

## Etapa 7: feche a conexão com a instância de serviço

A etapa final é desconectar o aplicativo cliente Python da instância de serviço:

```python
client.disconnect()
```
{: codeblock}

## Etapas Seguintes

Para obter mais informações sobre todas as ofertas do {{site.data.keyword.cloudant_short_notm}},
veja o site principal do [{{site.data.keyword.cloudant_short_notm}} ![Ícone de link externo](images/launch-glyph.svg "Ícone de link externo")](http://www.ibm.com/analytics/us/en/technology/cloud-data-services/cloudant/){:new_window}.

Para obter mais detalhes e tutoriais sobre conceitos, tarefas e técnicas do {{site.data.keyword.cloudant_short_notm}},
veja a [documentação do {{site.data.keyword.cloudant_short_notm}}](cloudant.html).

## Apêndice: listagem completa de códigos do Python

A listagem completa de códigos do Python é como a seguir.
Lembre-se de substituir os valores `<username>`,
`<password>`
e `<url>` por suas credenciais de serviço.
Da mesma forma,
substitua o valor `<yourDatabaseName>` pelo nome de seu banco de dados.

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
