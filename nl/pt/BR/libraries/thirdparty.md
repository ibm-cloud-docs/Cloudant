---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: client, mobile, c#, .net, libraries, frameworks, examples, tutorials, php, javascript, ruby, meteor, apache spark, 

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

# Bibliotecas do cliente de terceiros
{: #third-party-client-libraries}

As bibliotecas do cliente de terceiro não são mantidas nem suportadas pelo {{site.data.keyword.cloudantfull}}.
{: shortdesc}

## C# / .NET
{: #c-net}

[MyCouch ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/danielwertheim/mycouch){: new_window}
é um cliente assíncrono CouchDB e {{site.data.keyword.cloudant_short_notm}} para .Net.

Para instalar a biblioteca, abra o console do gerenciador de pacote e chame:

```
install-package mycouch.cloudant
```
{: codeblock}

### Bibliotecas e estruturas para C#/.NET
{: #libraries-and-frameworks-for-c-net}

-   [MyCouch ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/danielwertheim/mycouch){: new_window}.
-   [LoveSeat ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/soitgoes/LoveSeat){: new_window}.
-   [Divan ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/foretagsplatsen/Divan){: new_window}.
-   [Relax ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/arobson/Relax){: new_window}.
-   [Hammock ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://code.google.com/p/relax-net/){: new_window}.
-   [EasyCouchDB ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/hhariri/EasyCouchDB){: new_window}.
-   `WDK.API.CouchDB` do [Kanapes IDE ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://kanapeside.com/){: new_window}.

### Exemplos e tutoriais para C#/.NET
{: #examples-and-tutorials-for-c-net}

-   [CRUD ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/cloudant/haengematte/tree/master/c%23){: new_window}.

## Componente
{: #java-thirdparty}

### Bibliotecas não suportadas para Java
{: #unsupported-for-libraries-for-java-thirdparty}

-   [ektorp ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://helun.github.io/Ektorp/reference_documentation.html){: new_window}.
-   [jcouchdb ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://code.google.com/p/jcouchdb/){: new_window}.
-   [jrelax ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/isterin/jrelax){: new_window}.
-   [LightCouch ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://www.lightcouch.org/){: new_window}.

## JavaScript
{: #javascript}

### Bibliotecas e estruturas para JavaScript
{: #libraries-and-frameworks-for-javascript}

-   [Backbone.cloudant ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/cloudant-labs/backbone.cloudant){: new_window}.
-   [sag.js ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/sbisbee/sag-js){: new_window}.

### Exemplos e tutoriais para JavaScript
{: #examples-and-tutorials-for-javascript}

-   [CRUD ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/cloudant/haengematte/tree/master/javascript-jquery){: new_window} usando jQuery.
-   [CSVtoCloudant ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/michellephung/CSVtoCloudant){: new_window} -
    UI para importar arquivos `.csv` para o {{site.data.keyword.cloudant_short_notm}}.
    O app também pode ser acessado [aqui ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://michellephung.github.io/CSVtoCloudant/){: new_window}.
-   [csv2couchdb ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/Mango-information-systems/csv2couchdb){: new_window} -
    UI de sistemas Mango para importar arquivos do `.csv` para o CouchDB/{{site.data.keyword.cloudant_short_notm}}.
-   [songblog ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/millayr/songblog){: new_window} - app de exemplo usando JQuery.
    
## PouchDB (JavaScript)
{: #pouchdb}

[PouchDB ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://pouchdb.com/){: new_window} é um banco de dados JavaScript que pode ser sincronizado com o {{site.data.keyword.cloudant_short_notm}},
o que significa que é possível fazer com que seus apps fiquem prontos para acesso off-line apenas usando o PouchDB.
Para obter mais informações,
consulte [nossa postagem do blog ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://cloudant.com/blog/pouchdb){: new_window} no PouchDB.

Para obter o PouchDB
e para obter detalhes de configuração,
consulte [PouchDB ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://pouchdb.com/){: new_window}.

O PouchDB também está disponível para o Node.js: `npm install pouchdb`.
{: note}

O PouchDB também pode ser instalado com o Bower: `bower install pouchdb`.
{: note}

### Bibliotecas e estruturas para o PouchDB
{: #libraries-and-frameworks-for-pouchdb}

-   [PouchDB ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://pouchdb.com/){: new_window} - banco de dados JavaScript para navegador,
com sincronização off-line.

### Exemplos e tutoriais para o PouchDB
{: #examples-and-tutorials-for-pouchdb}

-   [Guia de introdução do PouchDB ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://pouchdb.com/getting-started.html){: new_window} -
    aplicativo Todo de exemplo que sincroniza do navegador para o {{site.data.keyword.cloudant_short_notm}} ou CouchDB.
-   [locationtracker ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/rajrsingh/locationtracker){: new_window} -
    app de exemplo para registrar e mapear local usando o PouchDB,
    CouchApp
    e {{site.data.keyword.cloudant_short_notm}}.

## Node.js
{: #node-js-thirdparty}

### Bibliotecas e estruturas não suportadas para o Node.js
{: #unsupported-libraries-and-frameworks-for-node-js-thirdparty}

-   [sag-js ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/sbisbee/sag-js){: new_window}, que também funciona no navegador.
    Veja [saggingcouch ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/sbisbee/saggingcouch.com){: new_window} para obter mais detalhes.
-   [nano ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/dscape/nano){: new_window} é uma implementação minimalista.
-   [restler ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/danwrong/restler){: new_window} entrega o melhor desempenho, mas é realmente uma estrutura.
-   [cradle ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/flatiron/cradle){: new_window} é um cliente de alto nível que também estará disponível
se você precisar absolutamente de facilidade de uso com o custo de desempenho reduzido.
-   [cane_passport ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/ddemichele/cane_passport){: new_window} - {{site.data.keyword.cloudant_short_notm}} Angular Node Express com autoinicialização.
-   [express-cloudant ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/cloudant-labs/express-cloudant){: new_window} - um modelo para a estrutura Node.js Express que também usa PouchDB e Grunt.

## PHP
{: #php}

[Sag ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/sbisbee/sag){: new_window} é o cliente CouchDB e {{site.data.keyword.cloudant_short_notm}} do PHP.
[Sag.js ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/sbisbee/sag-js){: new_window} é a contraparte JavaScript de Sag.

Para instalar,
faça download de `sag` de [https://github.com/sbisbee/sag ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/sbisbee/sag){: new_window}
e, em seguida, inclua a biblioteca em seu aplicativo:

```
require_once('./src/Sag.php');
```
{: codeblock}

### Bibliotecas e estruturas para PHP
{: #libraries-and-frameworks-for-php}

-   [sag ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/sbisbee/sag){: new_window}.
-   [Doctrine CouchDB Client ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/doctrine/couchdb-client){: new_window}.
-   [PHP-on-Couch ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/dready92/PHP-on-Couch){: new_window}.

### Exemplos e tutoriais para PHP
{: #examples-and-tutorials-for-php}

-   [CRUD ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/cloudant/haengematte/tree/master/php){: new_window}.

## Python
{: #python}

### Bibliotecas e estruturas não suportadas para Python
{: #unsupported-libraries-and-frameworks-for-python}

-   [Solicitações ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://docs.python-requests.org/en/master/){: new_window}.

## Ruby
{: #ruby}

[CouchRest ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/couchrest/couchrest){: new_window} é um CouchDB e cliente do {{site.data.keyword.cloudant_short_notm}}
com extensões para trabalhar com o Rails usando o [Modelo CouchRest ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/couchrest/couchrest_model){: new_window}.

Para instalar o CouchRest, execute o comando:

```sh
gem install couchrest
```
{: codeblock}

### Bibliotecas e estruturas para Ruby
{: #libraries-and-frameworks-for-ruby}

Há vários clientes CouchDB listados no
[Ruby Toolbox ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.ruby-toolbox.com/categories/couchdb_clients){: new_window}.

### Exemplos e tutoriais para Ruby
{: #examples-and-tutorials-for-ruby}

-   [CRUD ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/cloudant/haengematte/tree/master/ruby){: new_window}.

## Meteor
{: #meteor}

[cloudant:couchdb ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://atmospherejs.com/cloudant/couchdb){: new_window} é a
biblioteca do {{site.data.keyword.cloudant_short_notm}} para o pacote `couchdb-meteor`.
Como o Apache CouchDB não está incluído com o Meteor ou o pacote CouchDB,
deve-se fornecer uma URL para o Meteor se conectar
a uma instância do servidor do {{site.data.keyword.cloudant_short_notm}} ou do CouchDB em execução antes de instalar o Meteor.
Inclua este pacote em seu aplicativo Meteor:

```sh
meteor add cloudant:couchdb
```
{: codeblock}

O pacote couchdb-meteor fornece:

-   Implementação Livequery e atualizações em tempo real do banco de dados ao consumir o feed `_changes` de CouchDB.
-   Terminais Distributed Data Protocol (DDP) RPC que atualizam dados de clientes conectados localmente.
-   Serialização e desserialização de atualizações para o formato DDP.

A sintaxe de consulta JSON usada pelo {{site.data.keyword.cloudant_short_notm}} Query, e inicialmente desenvolvida pelo {{site.data.keyword.cloudant_short_notm}}, foi retribuída ao Apache CouchDB para a versão 2.0. Binários pré-construídos para o Apache CouchDB versão 2.0 ainda não
   estão disponíveis. É possível usar este módulo com o {{site.data.keyword.cloudant_short_notm}} DBaaS ou Cloudant Local até que os binários pré-construídos estejam disponíveis.
{: note}

Para configurar as informações de conexão do servidor Apache CouchDB ou {{site.data.keyword.cloudant_short_notm}},
passe sua URL como a variável de ambiente `COUCHDB_URL` para o processo do servidor Meteor:

```sh
$ export COUCHDB_URL=https://username:password@username.cloudant.com
```
{: codeblock}

Para obter mais informações sobre as APIs de meteor-couchdb, consulte a [Referência de API](/docs/services/Cloudant?topic=cloudant-api-reference-overview#api-reference-overview). 
