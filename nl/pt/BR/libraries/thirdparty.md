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

<!-- Acrolinx: 2017-05-10 -->

# Bibliotecas do cliente de terceiros

>   **Nota**: as bibliotecas do cliente de terceiros não são mantidas ou suportadas pelo {{site.data.keyword.cloudantfull}}.

## Bibliotecas móveis de terceiros

Trabalhando com um banco de dados do {{site.data.keyword.cloudant_short_notm}}:

-   [Apps iOS Objective-C nativos desenvolvidos com o IBM Worklight ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://www.tricedesigns.com/2014/11/17/ibm-worklight-powered-native-objective-c-ios-apps/){:new_window} com um {{site.data.keyword.cloudant_short_notm}} Adapter.

## C# / .NET

[MyCouch ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/danielwertheim/mycouch){:new_window}
é um cliente assíncrono CouchDB e {{site.data.keyword.cloudant_short_notm}} para .Net.

Para instalar a biblioteca, abra o console do gerenciador de pacote e chame:

```
install-package mycouch.cloudant
```
{:codeblock}

### Bibliotecas e estruturas para C#/.NET

-   [MyCouch ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/danielwertheim/mycouch){:new_window}.
-   [LoveSeat ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/soitgoes/LoveSeat){:new_window}.
-   [Divan ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/foretagsplatsen/Divan){:new_window}.
-   [Relax ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/arobson/Relax){:new_window}.
-   [Hammock ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://code.google.com/p/relax-net/){:new_window}.
-   [EasyCouchDB ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/hhariri/EasyCouchDB){:new_window}.
-   `WDK.API.CouchDB` do [Kanapes IDE ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://kanapeside.com/){:new_window}.

### Exemplos e tutoriais para C#/.NET

-   [CRUD ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/cloudant/haengematte/tree/master/c%23){:new_window}.

## PHP

[Sag ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/sbisbee/sag){:new_window} é o cliente CouchDB e {{site.data.keyword.cloudant_short_notm}} do PHP.
[Sag.js ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/sbisbee/sag-js){:new_window} é a contraparte JavaScript de Sag.

Para instalar,
faça download de `sag` de [https://github.com/sbisbee/sag ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/sbisbee/sag){:new_window}
e, em seguida, inclua a biblioteca em seu aplicativo:

```
require_once('./src/Sag.php');
```
{:codeblock}

### Bibliotecas e estruturas para PHP

-   [sag ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/sbisbee/sag){:new_window}.
-   [Doctrine CouchDB Client ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/doctrine/couchdb-client){:new_window}.
-   [PHP-on-Couch ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/dready92/PHP-on-Couch){:new_window}.

### Exemplos e tutoriais para PHP

-   [CRUD ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/cloudant/haengematte/tree/master/php){:new_window}.

## JavaScript

[PouchDB ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://pouchdb.com/){:new_window} é um banco de dados JavaScript que pode ser sincronizado com o {{site.data.keyword.cloudant_short_notm}},
o que significa que é possível fazer com que seus apps fiquem prontos para acesso off-line apenas usando o PouchDB.
Para obter mais informações,
veja [nossa postagem do blog ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://cloudant.com/blog/pouchdb){:new_window} no PouchDB.

Para obter o PouchDB
e para obter detalhes de configuração,
consulte [PouchDB ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://pouchdb.com/){:new_window}.

>   **Nota**: o PouchDB também está disponível para o Node.js: `npm install pouchdb`.

>   **Nota**: o PouchDB também pode ser instalado com o Bower: `bower install pouchdb`.

### Bibliotecas e estruturas para JavaScript

-   [Backbone.cloudant ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/cloudant-labs/backbone.cloudant){:new_window}.
    Veja a [postagem do blog ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://cloudant.com/blog/backbone-and-cloudant/){:new_window} para obter mais informações.
-   [sag.js ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/sbisbee/sag-js){:new_window}.
-   [PouchDB ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://pouchdb.com/){:new_window} - banco de dados JavaScript para navegador,
com sincronização off-line.

### Exemplos e tutoriais para JavaScript

-   [CRUD ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/cloudant/haengematte/tree/master/javascript-jquery){:new_window} usando jQuery.
-   [CSVtoCloudant ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/michellephung/CSVtoCloudant){:new_window} -
    UI para importar arquivos `.csv` para o {{site.data.keyword.cloudant_short_notm}}.
    O app também pode ser acessado [aqui ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://michellephung.github.io/CSVtoCloudant/){:new_window}.
-   [csv2couchdb ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/Mango-information-systems/csv2couchdb){:new_window} -
    UI de sistemas Mango para importar arquivos do `.csv` para o CouchDB/{{site.data.keyword.cloudant_short_notm}}.
-   [songblog ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/millayr/songblog){:new_window} - app de exemplo usando JQuery.
-   [Guia de introdução do PouchDB ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://pouchdb.com/getting-started.html){:new_window} -
    aplicativo Todo de exemplo que sincroniza do navegador para o {{site.data.keyword.cloudant_short_notm}} ou CouchDB.
-   [locationtracker ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/rajrsingh/locationtracker){:new_window} -
    app de exemplo para registrar e mapear local usando o PouchDB,
    CouchApp
    e {{site.data.keyword.cloudant_short_notm}}.

## Ruby

[CouchRest ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/couchrest/couchrest){:new_window} é um cliente CouchDB e {{site.data.keyword.cloudant_short_notm}}
com extensões para trabalhar com o Rails usando o [Modelo CouchRest ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/couchrest/couchrest_model){:new_window}.

Para instalar o CouchRest, execute o comando:

```sh
gem install couchrest
```
{:codeblock}

### Bibliotecas e estruturas para Ruby

Há vários clientes CouchDB listados no
[Ruby Toolbox ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.ruby-toolbox.com/categories/couchdb_clients){:new_window}.

### Exemplos e tutoriais para Ruby

-   [CRUD ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/cloudant/haengematte/tree/master/ruby){:new_window}.

<div id="couchdb"></div>

## Meteor

[cloudant:couchdb ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://atmospherejs.com/cloudant/couchdb){:new_window} é a
biblioteca do {{site.data.keyword.cloudant_short_notm}} para o pacote `couchdb-meteor`.
Como o Apache CouchDB não é fornecido com o Meteor ou o pacote couchdb,
deve-se fornecer uma URL para o Meteor para se conectar
a uma instância do servidor CouchDB ou {{site.data.keyword.cloudant_short_notm}} em execução antes de instalar o Meteor.
Inclua este pacote em seu aplicativo Meteor:

```sh
meteor add cloudant:couchdb
```
{:codeblock}

O pacote couchdb-meteor fornece:

-   Implementação Livequery e atualizações em tempo real do banco de dados ao consumir o feed `_changes` de CouchDB.
-   Terminais Distributed Data Protocol (DDP) RPC que atualizam dados de clientes conectados localmente.
-   Serialização e desserialização de atualizações para o formato DDP.

>   **Nota**: a sintaxe de consulta JSON usada pelo {{site.data.keyword.cloudant_short_notm}} Query
    e desenvolvida inicialmente pelo {{site.data.keyword.cloudant_short_notm}}
    foi contribuída novamente para o Apache CouchDB para a versão 2.0.
    Binários pré-construídos para o Apache CouchDB versão 2.0 ainda não
   estão disponíveis.
    É possível usar este módulo com o {{site.data.keyword.cloudant_short_notm}} DBaaS ou Cloudant Local até que os binários pré-construídos estejam disponíveis.

Para configurar as informações de conexão do servidor Apache CouchDB ou {{site.data.keyword.cloudant_short_notm}},
passe sua URL como a variável de ambiente `COUCHDB_URL` para o processo do servidor Meteor:

```sh
$ export COUCHDB_URL=https://username:password@username.cloudant.com
```
{:codeblock}

Veja a [Referência de API](../api/index.html) para obter mais informações sobre APIs meteor-couchdb. 

## Apache Spark

As [extensões de Apache Bahir para o Apache Spark ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://bahir.apache.org/#home){:new_window}
incluem um conector `spark-sql-cloudant` que é a biblioteca do {{site.data.keyword.cloudant_short_notm}} para o Apache Spark.

O conector spark-sql-cloudant já está carregado na oferta
[Apache Spark-as-a-Service do {{site.data.keyword.cloud_notm}} ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://console.ng.bluemix.net/catalog/services/apache-spark/){:new_window}.
Ele pode ser usado com qualquer cluster Spark independente.

Veja as [informações sobre o projeto ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/apache/bahir/tree/master/sql-cloudant){:new_window}
e a [documentação do Apache Bahir spark-sql-cloudant ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://bahir.apache.org/docs/spark/current/spark-sql-cloudant/){:new_window} para obter mais detalhes.
