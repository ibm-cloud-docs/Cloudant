---

copyright:
  years: 2017
lastupdated: "2017-07-03"

---
{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# Criando uma consulta do Cloudant

Este tutorial demonstra como criar um banco de dados, preenchê-lo
com documentos, criar um índice e usar o índice para consultar o banco de dados.

São fornecidos exercícios para a ![Ícone da linha de comandos](../images/CommandLineIcon.png) _Linha de comandos_
e o ![Ícone de painel](../images/DashboardIcon.png) _Painel do Cloudant_. Os
exercícios do Painel do Cloudant fornecem um exemplo visual de cada tarefa. É possível seguir os links
ao longo do tutorial para obter mais informações.

Para começar, você cria o banco de dados `query-demo` e alguns documentos que
contêm os dados para esses exercícios.

## Suposições

Antes de iniciar, siga estas etapas para se preparar para o tutorial:

1.  [Crie uma conta do Bluemix ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://console.ng.bluemix.net/registration/){:new_window}.
2.  Efetue login no
[Painel do Cloudant ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://console.ng.bluemix.net/catalog/services/cloudant-nosql-db){:new_window}.
3.  [Criar uma instância do Cloudant no Bluemix](create_service.html#creating-a-cloudant-instance-on-bluemix).
4.  (Opcional) [Crie um alias acurl](../guides/acurl.html#authorized-curl-acurl-) para facilitar e acelerar a execução de comandos por meio da linha de comandos.
5.  Substitua a variável `$ACCOUNT` nos comandos incluídos nos exercícios com o nome do usuário usado para efetuar login no Painel do Cloudant.
Se você decidir não configurar o `acurl`,
use a URL a seguir, em vez daquela fornecida nos exercícios:
  ``` sh
  curl https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com/query-demo
  ```
  {:codeblock}

## Criando um banco de dados

Nesta seção, você criará o [banco de dados](../api/database.html#create) `query-demo` que
é o banco de dados usado neste tutorial.

> **Nota:** neste tutorial,
usamos o alias `acurl`, em vez do comando `curl`.
O alias `acurl` é criado usando as etapas descritas [aqui](../guides/acurl.html#authorized-curl-acurl-).
Se você preferir usar o comando `curl`
ou outro método para chamar terminais de API,
substitua seu comando no tutorial
junto aos parâmetros requeridos por seu comando,
como username e password.

![Ícone da linha de comandos](../images/CommandLineIcon.png) _Linha de comandos_

1.  Crie um banco de dados executando este comando:
  ``` sh
  acurl https://$ACCOUNT.cloudant.com/query-demo -X PUT
  ```
  {:codeblock}
2.  Revise os resultados:
  ```json
  {
    "ok": true
  }
  ```
  {:codeblock}

![Ícone de Painel](../images/DashboardIcon.png) _Painel do Cloudant_

1.  Abra a instância de serviço do Cloudant que você criou.
2.  Selecione a guia Bancos de dados:

  ![Guia bancos de dados](../images/tabs.png)
3.  Clique em **Criar banco de dados**.
4.  Insira `query-demo` e clique em **Criar**.

  O banco de dados `query-demo` é aberto automaticamente.

## Criando documentos no banco de dados

Os [documentos](../api/document.html#documents)
criados neste exercício contêm os dados usados para consultar o banco de dados `query-demo` em exercícios posteriores.

![Ícone da linha de comandos](../images/CommandLineIcon.png) _Linha de comandos_

1.  Copie o texto de amostra para um arquivo de dados chamado `bulkcreate.dat` para criar cinco documentos:
  ```json
  {
    "docs":
    [
      {
        "_id": "doc1",
        "firstname": "Sally",
        "lastname": "Brown",
        "age": 16,
        "location": "New York City, NY"
      },
      {
        "_id": "doc2",
        "firstname": "John",
        "lastname": "Brown",
        "age": 21,
        "location": "New York City, NY"
      },
      {
        "_id": "doc3",
        "firstname": "Greg",
        "lastname": "Greene",
        "age": 35,
        "location": "San Diego, CA"
      },
      {
        "_id": "doc4",
        "firstname": "Anna",
        "lastname": "Greene",
        "age": 44,
        "location": "Baton Rouge, LA"
      },
      {
        "_id": "doc5",
        "firstname": "Lois",
        "lastname": "Brown",
        "age": 33,
        "location": "Syracuse, NY"
      }
    ]
  }
  ```
  {:codeblock}

2.  Execute este comando para criar os documentos:
  ```sh
  acurl https://$ACCOUNT.cloudant.com/query-demo/_bulk_docs -X POST -H "Content-Type: application/json" -d \@bulkcreate.dat
  ```
  {:codeblock}

  **Nota:** observe que o símbolo '`@`' usado para indicar que os dados
estão incluídos em um arquivo é identificado pelo nome fornecido.
3.  Revise os resultados:
  ```json
  [
    {
      "ok":true,
      "id":"doc1",
      "rev":"1-57a08e644ca8c1bb8d8931240427162e"
    },
    {
      "ok":true,
      "id":"doc2",
      "rev":"1-bf51eef712165a9999a52a97e2209ac0"
    },
    {
      "ok":true,
      "id":"doc3",
      "rev":"1-9c9f9b893fcdd1cbe09420bc4e62cc71"
    },
    {
      "ok":true,
      "id":"doc4",
      "rev":"1-6aa4873443ddce569b27ab35d7bf78a2"
    },
    {
      "ok":true,
      "id":"doc5",
      "rev":"1-d881d863052cd9681650773206c0d65a"
    }
  ]
  ```
  {:codeblock}

![Ícone de Painel](../images/DashboardIcon.png) _Painel do Cloudant_

1.  Clique em **`+`** e selecione **Novo doc**. A janela 'Novo documento' é aberta.
2.  Para criar um documento, copie o texto de amostra a seguir e substitua o texto existente no novo documento.

  _Primeiro documento de amostra_:
  ```json
  {
    "firstname": "Sally",
    "lastname": "Brown",
    "age": 16,
    "location": "New York City, NY",
    "_id": "doc1"
  }
  ```
  {:codeblock}

3.  Repita a etapa 2 para incluir os documentos restantes no banco de dados.

  _Segundo documento de amostra_:
  ```json
  {
    "firstname": "John",
    "lastname": "Brown",
    "age": 21,
    "location": "New York City, NY",
    "_id": "doc2"
  }
  ```
  {:codeblock}

  _Terceiro documento de amostra_:
  ```json
  {
    "firstname": "Greg",
    "lastname": "Greene",
    "age": 35,
    "location": "San Diego, CA",
    "_id": "doc3"
  }
  ```
  {:codeblock}

  _Quarto documento de amostra_:
  ```json
  {
    "firstname": "Anna",
    "lastname": "Greene",
    "age": 44,
    "location": "Baton Rouge, LA",
    "_id": "doc4"
  }
  ```
  {:codeblock}

  _Quinto documento de amostra_:
  ```json
  {
    "firstname": "Lois",
    "lastname": "Brown",
    "age": 33,
    "location": "New York City, NY",
    "_id": "doc5"
  }
  ```
  {:codeblock}

  O banco de dados `query-demo` foi criado. É possível ver os documentos na área de janela à direita.

  ![Documentos de amostra 1](../images/docs1.png)

  ![Documentos de amostra 2](../images/docs2.png)

  ![Documentos de amostra 3](../images/docs3.png)

  ![Documentos de amostra 4](../images/docs4.png)

  ![Documentos de amostra 5](../images/docs5.png)      

## Criando um índice

O Cloudant fornece visualizações e índices para consultar o banco de dados. Uma visualização executa uma consulta que é salva no banco de dados e
o resultado é chamado de conjunto de resultados. Ao enviar uma consulta para a visualização, sua consulta procura
o conjunto de resultados. Um índice é uma maneira de estruturar dados que melhoram o tempo de recuperação.

É possível usar o índice primário fornecido com o Cloudant ou índices secundários, como visualizações
(MapReduce), índices de procura, consultas do Cloudant Geoespatial ou Cloudant Query, conforme descrito
na lista a seguir:

*	Índice primário - consultar um documento ou uma lista de documentos por ID.  
*	[Visualização](../api/creating_views.html#views-mapreduce-) – procurar informações no banco de dados que correspondem aos critérios de procura especificados, como contagens, somas, médias e outras funções matemáticas. Os critérios que podem ser procurados são especificados na definição da visualização. As visualizações usam o paradigma MapReduce.
*	[Índice de procura](../api/search.html#search) – procure um ou mais campos, grandes quantias de texto ou use curingas, procura difusa ou máscaras com a [Sintaxe do analisador sintático de consulta Lucene ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://lucene.apache.org/core/4_3_0/queryparser/org/apache/lucene/queryparser/classic/package-summary.html#Overview){:new_window}.
*	[Cloudant Geoespatial](../api/cloudant-geo.html#cloudant-geospatial) – procure documentos com base em um relacionamento espacial.
*	[Cloudant Query](../api/cloudant_query.html#query) – use a sintaxe de consulta no estilo Mongo para procurar documentos usando operadores lógicos. O Cloudant Query é uma combinação de uma visualização e um índice de procura. Usamos o Cloudant Query neste tutorial.

> **Nota:** se não houver nenhum índice definido disponível que corresponda à consulta especificada, o Cloudant
> usará o índice `_all_docs`.


![Ícone da linha de comandos](../images/CommandLineIcon.png) _Linha de comandos_

1.  Copie os dados JSON de amostra a seguir em um arquivo chamado `query-index.dat`.
  ```json
  {
    "index": {
      "fields": [
        "lastname",
        "location",
        "age"
      ]
    },
    "name": "query-index",
    "type": "json"
  }
  ```
  {:codeblock}

2.  Execute o comando a seguir para criar um índice:
  ```sh
  acurl https://$ACCOUNT.cloudant.com/query-demo/_index -X POST -H "Content-Type: application/json" -d \@query-index.dat
  ```
  {:codeblock}

3.  Revise os resultados:
  ```json
  {
    "result":"created",
    "id":"_design/752c7031f3eaee0f907d18e1424ad387459bfc1d",
    "name":"query-index"
  }
  ```
  {:codeblock}



![Ícone de Painel](../images/DashboardIcon.png) _Painel do Cloudant_

1.  Clique em **`+` > Índices de consulta** na guia **Todos os documentos** ou **Documentos de design**.
2.  Cole os dados JSON de amostra a seguir no campo **Índice**:
  ```json
  {
    "index": {
      "fields": [
        "lastname",  
        "location",
        "age"
      ]
    },
    "name": "query-index",
    "type": "json"
  }
  ```
  {:codeblock}

  O índice foi criado. É possível vê-lo na área de janela à direita.

  ![Índice de consulta](../images/query-index1.png)



## Criando uma consulta

As consultas permitem extrair seus dados do Cloudant. Uma
[consulta](../api/cloudant_query.html#query) bem escrita pode limitar sua procura e
seus resultados para incluir apenas os dados desejados.

Este exercício mostra como gravar e executar uma consulta simples, consulta com dois campos
e consulta com um [operador](../api/cloudant_query.html#cloudant_query.html#operators).
Você consulta com um operador especificando pelo menos um campo e seu valor correspondente.
A consulta então usará esse valor para procurar correspondências no banco de dados.

Para qualquer coisa, exceto a consulta mais simples, inclua o JSON em um arquivo de dados e execute-o por meio da linha de comandos.

### Executando uma consulta simples

Este exemplo demonstra como o Cloudant Query usa o `query-index` para localizar o
`lastname` e filtra os resultados na memória para localizar o `firstaname`.   

![Ícone da linha de comandos](../images/CommandLineIcon.png) _Linha de comandos_

1.  Copie o JSON de amostra a seguir em um arquivo de dados chamado `query1.dat`.
  ```json
    {
      "selector": {
            "lastname" : "Greene",
            "firstname" : "Anna"            
         }        
    }       
  ```    
  {:codeblock}

2.  Execute o comando a seguir para consultar o banco de dados:
  ```sh
  acurl https://$ACCOUNT.cloudant.com/query-demo/_find -X POST -H "Content-Type: application/json" -d \@query1.dat
  ```
  {:codeblock}

3.  Revise os resultados da consulta:
  ```json
  {
    "docs": [
      {
        "_id":"doc4",
        "_rev":"3-751ab049e8b5dd1ba045cea010a33a72",
            "firstname":"Anna",
            "lastname":"Greene",
            "age":44,
            "location":"Baton Rouge, LA"
      }
    ]
  }
  ```
  {:codeblock}

![Ícone de Painel](../images/DashboardIcon.png) _Painel do Cloudant_

1.  Clique na guia **Consulta**.
2.  Copie e cole o JSON de amostra a seguir na janela do Cloudant Query:
  ```json
   {
      "selector": {
            "lastname" : "Greene",
            "firstname" : "Anna"            
         }        
   }
  ```
  {:codeblock}

3.  Clique em **Executar consulta**.

  Os resultados da consulta aparecem na área de janela à direita.

  ![Resultados da consulta 1](../images/dashboard_query1_results.png)

### Executando uma consulta com dois campos

Este exemplo usa dois campos para localizar todos que tenham o nome `Brown` e que vivem em `New York, NY`.

Descrevemos a procura usando uma [expressão 'selector'](../api/cloudant_query.html#selector-syntax),
que é semelhante ao exemplo a seguir:
```json
  {
    "selector": {
      "lastname": "Brown",
      "location": "New York City, NY"
    }
  }
```
{:codeblock}

Podemos customizar os resultados para atender as nossas necessidades
incluindo mais detalhes dentro da expressão selector.
O parâmetro `fields` especifica os campos a serem incluídos com os resultados. Em nosso exemplo, os
resultados incluem o nome, o sobrenome e o local. Os resultados são classificados pelo
nome em ordem ascendente com base nos valores no parâmetro `sort`.
Os detalhes extras são semelhantes ao exemplo a seguir:
```json
{
  ...
  "fields": [
    "lastname",
    "firstname",
    "location"
  ],
  "sort" : [
    {
      "lastname": "asc"
    },
    {
      "firstname": "asc"
    }
  ]
}
```  
{:codeblock}

![Ícone da linha de comandos](../images/CommandLineIcon.png) _Linha de comandos_

1.  Copie o JSON de amostra em um campo de dados chamado `query2.dat`.
  ```json
  {
    "selector": {
      "lastname": "Brown",
      "location": "New York City, NY"
    },
    "fields": [
      "firstname",
      "lastname",
      "location"
    ],
    "sort": [
      {
        "lastname": "asc"
      },
      {
        "firstname": "asc"
      }
    ]
  }
  ```
  {:codeblock}

2.  Execute o comando a seguir para consultar o banco de dados:
  ```sh
  acurl https://$ACCOUNT.cloudant.com/query-demo/_find -X POST -H "Content-Type: application/json" -d \@query2.dat
  ```
  {:codeblock}

3.  Revise os resultados da consulta:
  ```json
  {
    "docs": [
      {
        "firstname": "John",
        "lastname": "Brown",
        "location": "New York City, NY"
      },
      {
        "firstname": "Sally",
        "lastname": "Brown",
        "location": "New York City, NY"
      }
    ]
  }
  ```
  {:codeblock}

![Ícone de Painel](../images/DashboardIcon.png) _Painel do Cloudant_

1.  Clique na guia **Consulta**.
2.  Copie e cole o JSON de amostra a seguir na janela do Cloudant Query:
  ```json
  {
    "selector": {
      "lastname": "Brown",
      "location": "New York City, NY"
    },
    "fields": [
      "firstname",
      "lastname",
      "location"
    ],
    "sort": [
      {
        "lastname": "asc"
      },
      {
        "firstname": "asc"
      }
    ]  
  }
  ```
  {:codeblock}

3.  Clique em **Executar consulta**.

  Os resultados da consulta aparecem na área de janela à direita.

  ![Resultados da consulta 2](../images/dashboard_query2_results.png)

### Executando uma consulta com operadores

Neste exemplo, os operadores `$eq` (igual) e `$gt` (maior que) são usados para procurar
documentos que contêm o sobrenome `Greene` e uma idade maior que `30`.

Usamos uma expressão selector como o exemplo a seguir:
```json
{
  "selector": {
    "lastname": {
      "$eq": "Greene"
    },
    "age": {
      "$gt": 30
    }
  }
}
```   
{:codeblock}

![Ícone da linha de comandos](../images/CommandLineIcon.png) _Linha de comandos_

1.  Copie o JSON de amostra a seguir em um arquivo chamado `query3.dat`.
  ```json
  {
    "selector": {
      "lastname": {
        "$eq": "Greene"
      },
      "age": {
        "$gt": 30
      }
    },
    "fields" : [
      "firstname",
      "lastname",
      "age"
    ],
    "sort": [
      {
        "lastname": "asc"
      },
      {
        "firstname": "asc"
      }
    ]  
  }
  ```
  {:codeblock}

2. Execute esta consulta:
  ```sh
  acurl https://$ACCOUNT.cloudant.com/query-demo/_find -X POST -H "Content-Type: application/json" -d \@query3.dat
  ```
  {:codeblock}

3.  Revise os resultados da consulta:
  ```json
  {
    "docs": [
      {
        "firstname": "Anna",
        "lastname": "Greene",
        "age": 44
      },
      {
        "firstname": "Greg",
        "lastname": "Greene",
        "age": 35
      }
    ]
  }
  ```
  {:codeblock}

![Ícone de Painel](../images/DashboardIcon.png) _Painel do Cloudant_

1.  Clique na guia **Consulta**.
2.  Copie e cole o JSON de amostra a seguir na janela do Cloudant Query:
  ```json
  {
    "selector": {
      "lastname": {
        "$eq": "Greene"
      },
      "age": {
        "$gt": 30
      }
    },
    "fields" : [
      "firstname",
      "lastname",
      "age"
    ],
    "sort": [
      {
        "lastname": "asc"
      },
      {
        "firstname": "asc"
      }
    ]   
  }
  ```
  {:codeblock}

3.  Clique em **Executar consulta**.

  Os resultados da consulta aparecem na área de janela à direita.

  ![Resultados da consulta 3](../images/dashboard_query3_results.png)

Para obter mais informações sobre o Cloudant, veja a [Documentação do Cloudant](../cloudant.html#overview).
