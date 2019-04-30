---

copyright:
  years: 2015, 2019
lastupdated: "2019-04-02"

keywords: connect to service instance, create a database, populate database with data, retrieve data through queries, retrieve data with api endpoint, delete database, close connection, complete python code listing, couchdb as a service, couchdb hosted, couchdb, databases for couchdb

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

<!-- Acrolinx: 2018-05-31 -->

# Tutorial de introdução
{: #getting-started}

Neste tutorial de introdução ao {{site.data.keyword.cloudantfull}},
usamos Python para criar um banco de dados do {{site.data.keyword.cloudant_short_notm}}
e preencher o banco de dados com uma coleção simples de dados.
{: shortdesc}

Além deste tutorial, veja os nossos tutoriais práticos que ajudam você a aprender mais sobre o {{site.data.keyword.cloudant_short_notm}} ou experimente um dos tutoriais que focam em uma linguagem específica:

- [Liberty for Java e {{site.data.keyword.cloudant_short_notm}} ![Ícone de link externo](images/launch-glyph.svg "Ícone de link externo")](https://cloud.ibm.com/docs/runtimes/liberty/getting-started.html#getting-started-tutorial){: new_window}
- [Node.js e {{site.data.keyword.cloudant_short_notm}} ![Ícone de link externo](images/launch-glyph.svg "Ícone de link externo")](https://cloud.ibm.com/docs/runtimes/nodejs/getting-started.html#getting-started-tutorial){: new_window}
- [Swift e {{site.data.keyword.cloudant_short_notm}} ![Ícone de link externo](images/launch-glyph.svg "Ícone de link externo")](https://cloud.ibm.com/docs/runtimes/swift/getting-started.html#getting-started-tutorial){: new_window}

Para obter tutoriais específicos da linguagem, consulte [Introdução à implementação de seu primeiro aplicativo ![Ícone de link externo](images/launch-glyph.svg "Ícone de link externo")](https://cloud.ibm.com/docs/){: new_window}. 

## Antes de iniciar
{: #prereqs}

Você precisa de uma [conta do {{site.data.keyword.cloud}} ![Ícone de link externo](images/launch-glyph.svg "Ícone de link externo")](https:///cloud.ibm.com/registration/){: new_window},
de uma instância do serviço {{site.data.keyword.cloudant_short_notm}} e dos requisitos do Python a seguir:

*	Instale a versão mais recente da
[linguagem de programação Python ![Ícone de link externo](images/launch-glyph.svg "Ícone de link externo")](https://www.python.org/){: new_window} em seu sistema.
	
	Para verificar,
execute o seguinte comando em um prompt:
	```sh
	python --version
	```
	{: pre}
	
	Você vê um resultado semelhante a este:

	```
	Python 2.7.12
	```
	{: screen}

*	Instale a biblioteca Python
	para permitir que os aplicativos Python funcionem com o
	{{site.data.keyword.cloudant_short_notm}} no {{site.data.keyword.cloud_notm}}.
	
	Para verificar se a biblioteca do cliente já está instalada,
execute o comando a seguir em um prompt:
	```sh
	pip freeze
	```
	{: pre}
	
	Você verá uma lista de todos os módulos Python que estão instalados em seu sistema. Inspecione a lista, procurando uma entrada do {{site.data.keyword.cloudant_short_notm}} semelhante à seguinte:

	```
	cloudant == < version>
	```
	{: screen}
	
	Se o módulo `cloudant` não estiver instalado, instale-o usando um comando semelhante ao seguinte:
	
	```
	pip install cloudant
	```
	{: pre}
  
  Para obter mais informações sobre a biblioteca Python, consulte a documentação [Plataformas suportadas](/docs/services/Cloudant/libraries/supported.html#python). 

## Etapa 1: Conectar-se à instância de serviço do {{site.data.keyword.cloudant_short_notm}} no {{site.data.keyword.cloud_notm}}
{: #step-1-connect-to-your-cloudant-nosql-db-service-instance-on-ibm-cloud}

1.	Execute as instruções de `import` dos componentes da Biblioteca do cliente do {{site.data.keyword.cloudant_short_notm}} para permitir que o aplicativo Python se conecte à instância de serviço do {{site.data.keyword.cloudant_short_notm}}.
	```python
	from cloudant.client import Cloudant
	from cloudant.error import CloudantException
	from cloudant.result import Result, ResultByKey
	```
	{: codeblock}

2.  Crie uma credencial de serviço do {{site.data.keyword.cloudant_short_notm}}:
  <br>No painel do {{site.data.keyword.cloud_notm}}, acesse o ícone de **Menu** > **Lista de recursos** e abra a sua instância de serviço do {{site.data.keyword.cloudant_short_notm}}.
  <br>Na navegação à esquerda, clique em `Service credentials`.
  <br>a. Clique no botão  ` Nova credencial ` .
  <br>![Criar novas credenciais de serviço](/docs/services/Cloudant/tutorials/images/img0050.png)
  <br>b. Insira um nome para a nova credencial na janela Incluir nova credencial, conforme mostrado na captura de tela a seguir.
  <br>c. (Opcional) Inclua parâmetros de configuração sequenciais.
  <br>d. Clique no botão  ` Incluir ` . 
  <br>![Incluir uma nova credencial de serviço](/docs/services/Cloudant/tutorials/images/img0051.png)
  <br>Suas credenciais são incluídas na tabela Credenciais de serviço.
  <br>e. Clique em `Visualizar credenciais` em Ações. 
  <br>![Visualizar todas as credenciais de serviço](/docs/services/Cloudant/tutorials/images/img0052.png)
  <br>Os detalhes das credenciais de serviço aparecem:
   <br>![The {{site.data.keyword.cloudant_short_notm}} service credentials](/docs/services/Cloudant/tutorials/images/img0009.png)
   
3.	Estabeleça uma conexão com a instância de serviço do {{site.data.keyword.cloudant_short_notm}}. Para fazer isso, o mecanismo depende do fato de você estar usando a autenticação do {{site.data.keyword.cloud_notm}} IAM ou do {{site.data.keyword.cloudant_short_notm}} Legacy. Consulte o [{{site.data.keyword.cloud_notm}}Identity and Access Management (IAM) guide ![Ícone de link externo](images/launch-glyph.svg "Ícone de link externo")](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-)para obter mais detalhes sobre o tipo de autenticação.

	Se você estiver usando a autenticação do {{site.data.keyword.cloudant_short_notm}} Legacy, substitua suas credenciais de serviço da etapa anterior:
	```python
	client = Cloudant("<username>", "<password>", url="<url>")
	client.connect()
	```
	{: codeblock}
	
	Se você estiver usando a autenticação do IAM, substitua as credenciais de serviço da etapa anterior:
	```python
	client = Cloudant.iam("<username>", "<apikey>")
	client.connect()
	```
	{: codeblock}


## Etapa 2: crie um banco de dados
{: #step-2-create-a-database}

1. Defina uma variável no aplicativo Python:
  ```python
  databaseName = "<your-database-name>"
  ```
  {: codeblock}

  ... em que `<your-database-name>`é o nome que você gostaria de fornecer ao seu banco de dados. 

  O nome do banco de dados deve começar com uma letra e pode incluir apenas caracteres minúsculos (a - z), numerais (0 - 9) e qualquer um dos caracteres a seguir `_`, `$`, `(`, `)`, `+`, `-` e `/`.
  {: warning}

2. Crie o banco de dados:
  ```python
  myDatabase = client.create_database(databaseName)
  ```
  {: codeblock}

3. Confirme se o banco de dados foi criado com êxito:
  ```python
  if myDatabase.exists():
      print "'{0}' successfully created.\n".format(databaseName)
  ```
  {: codeblock}

## Etapa 3: armazene uma pequena coleção de dados como documentos dentro do banco de dados
{: #step-3-store-a-small-collection-of-data-as-documents-within-the-database}

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
  # Create documents by using the sample data.
  # Go through each row in the array
  for document in sampleData:
    # Retrieve the fields in each row.
    number = document[0]
    name = document[1]
    description = document[2]
    temperature = document[3]
    #
    # Create a JSON document that represents
    # all the data in the row.
    jsonDocument = {
        "numberField": number,
        "nameField": name,
        "descriptionField": description,
        "temperatureField": temperature
    }
    #
    # Create a document by using the database API.
    newDocument = myDatabase.create_document(jsonDocument)
    #
    # Check that the document exists in the database.
    if newDocument.exists():
        print "Document '{0}' successfully created.".format(number)
  ```
  {: codeblock}

  Observe que nós asseguramos a criação bem-sucedida de cada documento.
  {: tip}

## Etapa 4: recuperando dados por meio de consultas
{: #step-4-retrieving-data-through-queries}

Uma pequena coleta de dados foi armazenada como documentos dentro do banco de dados.
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
    {: screen}
    
    O prefixo `u` é uma indicação de que o Python está exibindo uma sequência Unicode. 
    {: tip}

    Se arrumarmos a aparência um pouco, poderemos ver que os detalhes mínimos do documento que temos de volta são equivalentes a este exemplo:
    
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

    A ideia de que o primeiro documento armazenado em um banco de dados é sempre o primeiro documento retornado em uma lista de resultados nem sempre se aplica a bancos de dados NoSQL como o {{site.data.keyword.cloudant_short_notm}}.
    {: note}

* Para executar uma recuperação completa, solicite uma lista de todos os documentos dentro do banco de dados e especifique que o conteúdo do documento também deve ser retornado fornecendo a opção `include_docs`.
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
  
  Se arrumarmos a aparência um pouco, poderemos ver que os detalhes completos do documento que temos de volta são equivalentes a este exemplo:
  
  ```json
  [
    {
      "value":
              {
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

## Etapa 5: recuperando dados por meio do terminal de API do {{site.data.keyword.cloudant_short_notm}}
{: #step-5-retrieving-data-through-the-cloudant-nosql-db-api-endpoint}

Também é possível solicitar uma lista de todos os documentos e seus conteúdos
chamando o [terminal `/_all_docs`](/docs/services/Cloudant?topic=cloudant-databases#get-documents) do {{site.data.keyword.cloudant_short_notm}}.

1. Identifique o terminal para contato e quaisquer parâmetros a serem fornecidos junto à chamada:
  ```python
  end_point = '{0}/{1}'.format("client.server_url", databaseName + "/_all_docs")
  params = {'include_docs': 'true'}
  ```
  {: codeblock}
  ... em que `client.server_url` é o valor da URL das credenciais de serviço que você localizou na Etapa 1.

2. Envie a solicitação para a instância de serviço e exiba os resultados:
  ```python
  response = client.r_session.get(end_point, params=params)
  print "{0}\n".format(response.json())
  ```
  {: codeblock}

  O resultado é semelhante ao exemplo _abreviado_ a seguir:
  
  ```
  {u'rows': [{u'value': {u'rev': u'1-6d8cb5905316bf3dbe4075f30daa9f59'}, u'id': u'0532feb6fd6180d79b842d871316c444', u'key': u'0532feb6fd6180d79b842d871316c444', u'doc': {u'temperatureField': 20, u'descriptionField': u'warm', u'numberField': 3, u'nameField': u'three', u'_id': u'0532feb6fd6180d79b842d871316c444', u'_rev': u'1-6d8cb5905316bf3dbe4075f30daa9f59'}}, ... , {u'value': {u'rev': u'1-3f61736fa96473d358365ce1665e3d97'}, u'id': u'db396f77bbe12a567b09177b4accbdbc', u'key': u'db396f77bbe12a567b09177b4accbdbc', u'doc': {u'temperatureField': 0, u'descriptionField': u'freezing', u'numberField': 5, u'nameField': u'five', u'_id': u'db396f77bbe12a567b09177b4accbdbc', u'_rev': u'1-3f61736fa96473d358365ce1665e3d97'}}], u'total_rows': 5, u'offset': 0}
  ```
  {: screen}
  
  Podemos arrumar a aparência um pouco e ver que os detalhes _abreviados_ que nós temos de volta são semelhantes a este exemplo:
  
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

## (opcional) Etapa 6: Consultar as informações do banco de dados no painel do {{site.data.keyword.cloudant_short_notm}}
{: #optional-step-6-ibm-cloudant-dashboard}

Siga estas etapas para ver o banco de dados e os documentos no painel do {{site.data.keyword.cloudant_short_notm}}. 

1.  Efetue login em sua conta do IBM Cloud.
    O painel do IBM Cloud pode ser localizado em: https://cloud.ibm.com/. Depois de autenticar-se com seu nome de usuário e sua senha, o painel do IBM Cloud é apresentado.
2.  Clique em **Serviços** na área de janela Resumo de recursos para ver as suas instâncias de serviço do {{site.data.keyword.cloudant_short_notm}}. 
3.  Clique na instância de serviço cujos detalhes você deseja ver.
4.  Clique em **Ativar o painel do Cloudant**.
    Quando o painel for aberto, será possível ver os bancos de dados associados a seu serviço.


## Etapa 7: Excluir o banco de dados
{: #step-7-delete-the-database}

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

Incluímos alguma manipulação de erros básica para mostrar como resolver problemas e abordar problemas em potencial.

## Etapa 8: Fechar a conexão com a instância de serviço
{: #step-8-close-the-connection-to-the-service-instance}

A etapa final é desconectar o aplicativo cliente Python da instância de serviço:

```python
client.disconnect()
```
{: codeblock}

## Etapas Seguintes
{: #next-steps}

Para obter mais informações sobre todas as ofertas do {{site.data.keyword.cloudant_short_notm}}, consulte o site principal [{{site.data.keyword.cloudant_short_notm}}![Ícone de link externo](images/launch-glyph.svg "Ícone de link externo")](http://www.ibm.com/analytics/us/en/technology/cloud-data-services/cloudant/){: new_window}.

Para obter mais informações, consulte os tutoriais, os conceitos, as tarefas e as técnicas do {{site.data.keyword.cloudant_short_notm}} na [documentação do {{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant?topic=cloudant-overview#overview).

## Apêndice: listagem completa de códigos do Python
{: #appendix-complete-python-code-listing}

A listagem completa de códigos do Python é como a seguir. 
Lembre-se de substituir o `<username>`,
`Valores do<password>`, `<url>`e `<apikey>`com suas credenciais de serviço.
Similarmente,
substitua o valor `<yourDatabaseName>`pelo nome de seu banco de dados.

```python
from cloudant.client import Cloudant
from cloudant.error import CloudantException
from cloudant.result import Result, ResultByKey

# {{site.data.keyword.cloudant_short_notm}} Legacy authentication
client = Cloudant("<username>", "<password>", url="<url>")
client.connect()

# IAM Authentication (uncomment if needed, and comment out {{site.data.keyword.cloudant_short_notm}} Legacy authentication section above)
client = Cloudant.iam("<username","<apikey>")
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
