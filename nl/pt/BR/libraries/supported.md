---

copyright:
  years: 2015, 2018
lastupdated: "2017-11-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-03-06 -->

# Bibliotecas do cliente suportadas

## Dispositivo móvel

A biblioteca de Sincronização do {{site.data.keyword.cloudantfull}} é usada para armazenar,
indexar
e consultar dados JSON locais em um dispositivo móvel.
Ela também é usada para sincronizar dados entre vários dispositivos.
A sincronização é controlada por seu aplicativo.
A
biblioteca também fornece métodos auxiliares para localizar e resolver conflitos,
ambos no dispositivo local e no banco de dados remoto.

Estão disponíveis duas versões:

-   [Sincronização do {{site.data.keyword.cloudant_short_notm}} - Android / JavaSE ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/cloudant/sync-android){:new_window}.
-   [Sincronização do {{site.data.keyword.cloudant_short_notm}} - iOS (CDTDatastore) ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/cloudant/CDTDatastore){:new_window}.

Uma [visão geral ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://cloudant.com/product/cloudant-features/sync/){:new_window} da Sincronização do {{site.data.keyword.cloudant_short_notm}} está disponível.
Detalhes de recursos da Sincronização do {{site.data.keyword.cloudant_short_notm}}[ ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://cloudant.com/cloudant-sync-resources/){:new_window} também estão disponíveis.

## Componente

[java-cloudant ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/cloudant/java-cloudant){:new_window} é a biblioteca
oficial {{site.data.keyword.cloudantfull}} para Java.

Informações sobre a instalação da biblioteca ao incluí-la como uma dependência nas construções Maven ou Gradle estão disponíveis
[aqui ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/cloudant/java-cloudant#installation-and-usage){:new_window},
junto a detalhes e exemplos de como usar a biblioteca.

### Bibliotecas e estruturas

#### Suportado

-   [java-cloudant ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/cloudant/java-cloudant){:new_window}.

#### Não suportado

-   [ektorp ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://ektorp.org/){:new_window}.
-   [jcouchdb ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://code.google.com/p/jcouchdb/){:new_window}.
-   [jrelax ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/isterin/jrelax){:new_window}.
-   [LightCouch ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://www.lightcouch.org/){:new_window}.
-   [Modelo Java {{site.data.keyword.cloudant_short_notm}} Web Starter ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://ace.ng.bluemix.net/#/store/cloudOEPaneId=store&appTemplateGuid=CloudantJavaBPTemplate&fromCatalog=true){:new_window} para Bluemix.

### Exemplos e tutoriais

-   [Criar, ler, atualizar e excluir ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/cloudant/haengematte/tree/master/java){:new_window} com as bibliotecas HTTP e JSON.
-   [Criar, ler, atualizar e excluir ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/cloudant/haengematte/tree/master/java/CrudWithEktorp){:new_window} com a biblioteca ektorp.
-   [Construindo apps usando Java com o {{site.data.keyword.cloudant_short_notm}} no IBM Bluemix ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://cloudant.com/blog/building-apps-using-java-with-cloudant-on-ibm-bluemix/){:new_window}.
-   [Construir um app de jogo com o Liberty, {{site.data.keyword.cloudant_short_notm}} e Single Sign On ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://www.ibm.com/developerworks/cloud/library/cl-multiservicegame-app/index.html?ca=drs-){:new_window} Exemplo do Bluemix.
-   [Construindo um app Java EE no IBM Bluemix usando o Watson e o {{site.data.keyword.cloudant_short_notm}} ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://developer.ibm.com/bluemix/2014/10/17/building-java-ee-app-ibm-bluemix-using-watson-cloudant/){:new_window} Exemplo do Bluemix junto com [vídeo do YouTube ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.youtube.com/watch?feature=youtu.be&v=9AFMY6m0LIU&app=desktop){:new_window}.


## Node.js

[nodejs-cloudant ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/cloudant/nodejs-cloudant){:new_window}
é a biblioteca oficial {{site.data.keyword.cloudant_short_notm}} para Node.js.
É possível instalá-la com npm:

```sh
npm install cloudant
```
{:codeblock}

### Bibliotecas e estruturas

#### Suportado

-   [nodejs-cloudant ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/cloudant/nodejs-cloudant){:new_window} ([npm ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.npmjs.org/package/cloudant){:new_window}).

#### Não suportado

-   [sag-js ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/sbisbee/sag-js){:new_window}, que também funciona no navegador.
    Veja [saggingcouch ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/sbisbee/saggingcouch.com){:new_window} para obter mais detalhes.
-   [nano ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/dscape/nano){:new_window} é uma implementação minimalista.
-   [restler ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/danwrong/restler){:new_window} entrega o melhor desempenho, mas é realmente uma estrutura.
-   [cradle ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/flatiron/cradle){:new_window} é um cliente de alto nível que também estará disponível
se você precisar absolutamente de facilidade de uso com o custo de desempenho reduzido.
-   [cane_passport ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/ddemichele/cane_passport){:new_window} - {{site.data.keyword.cloudant_short_notm}} Angular Node Express com autoinicialização.
-   [express-cloudant ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/cloudant-labs/express-cloudant){:new_window} - um modelo para a estrutura Node.js Express que também usa PouchDB e Grunt.
-   [Node.js {{site.data.keyword.cloudant_short_notm}} DB Web Starter ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://ace.ng.bluemix.net/#/store/cloudOEPaneId=store&appTemplateGuid=nodejscloudantbp&fromCatalog=true){:new_window} - modelo para Bluemix.
-   [Nuvem para dispositivo móvel ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://ace.ng.bluemix.net/#/store/cloudOEPaneId=store&appTemplateGuid=mobileBackendStarter&fromCatalog=true){:new_window} - modelo para Bluemix (Node.js, Segurança, Push e Dados móveis/{{site.data.keyword.cloudant_short_notm}}).

### Exemplos e tutoriais

-   [Criar, ler, atualizar e excluir ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/cloudant/haengematte/tree/master/nodejs){:new_window}.
-   [Cloudant-Uploader ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/garbados/Cloudant-Uploader){:new_window} - utilitário para fazer upload de arquivos `.csv` para o {{site.data.keyword.cloudant_short_notm}}.
-   [couchimport ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/glynnbird/couchimport){:new_window} - utilitário para importar arquivos `.csv` ou `.tsv` para o CouchDB ou {{site.data.keyword.cloudant_short_notm}}.
-   [Introdução ao {{site.data.keyword.Bluemix}} e Node.js ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://thoughtsoncloud.com/2014/07/getting-started-ibm-bluemix-node-js/){:new_window}.
-   [Um mistura de nuvem com o {{site.data.keyword.Bluemix_notm}}, {{site.data.keyword.cloudant_short_notm}} e Node.js ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://gigadom.wordpress.com/2014/08/15/a-cloud-medley-with-ibm-bluemix-cloudant-db-and-node-js/){:new_window}.
-   [Construir um app de jogo de palavras simples usando o {{site.data.keyword.cloudant_short_notm}} no {{site.data.keyword.Bluemix_notm}} ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://www.ibm.com/developerworks/cloud/library/cl-guesstheword-app/index.html?ca=drs-){:new_window} - usa o Node.js.
-   [Construindo um app de votação SMS em tempo real ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.twilio.com/blog/2012/09/building-a-real-time-sms-voting-app-part-1-node-js-couchdb.html){:new_window} - série com seis partes que usa Node.js, Twilio e {{site.data.keyword.cloudant_short_notm}}.
-   [Construindo um aplicativo da web Windows Azure multicamada ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://msopentech.com/blog/2013/12/19/tutorial-building-multi-tier-windows-azure-web-application-use-cloudants-couchdb-service-node-js-cors-grunt-2/){:new_window} - usa {{site.data.keyword.cloudant_short_notm}}, Node.js, CORS e Grunt.
-   [Faça você mesmo: construa um aplicativo de inspeção remota usando {{site.data.keyword.Bluemix_notm}}, {{site.data.keyword.cloudant_short_notm}} e Raspberry Pi. ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://www.ibm.com/developerworks/library/ba-remoteservpi-app/index.html){:new_window}.

## Python

Uma biblioteca suportada para trabalhar com o {{site.data.keyword.cloudant_short_notm}} usando Python está
disponível [aqui ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/cloudant/python-cloudant){:new_window}.

>   **Nota:** os aplicativos Python que acessam o {{site.data.keyword.cloudant_short_notm}} possuem dependências de componente. Essas dependências devem ser especificadas em um arquivo `requirements.txt`. Para obter mais informações, veja [aqui ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://pip.readthedocs.io/en/1.1/requirements.html){:new_window}.

Faça download da liberação da biblioteca atual [aqui ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://pypi.python.org/pypi/cloudant/){:new_window}.
Obtenha mais informações sobre a linguagem Python em [python.org ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.python.org/about/){:new_window}. 

## Swift

Uma biblioteca suportada está disponível para funcionar com o {{site.data.keyword.cloudant_short_notm}}.
A biblioteca chama-se Swift{{site.data.keyword.cloudant_short_notm}}
e é instalada usando `cocoapods`.

A entrada de podfile é:

```sh
pod 'SwiftCloudant'
```
{:codeblock}

Mais informações sobre SwiftCloudant,
incluindo detalhes da instalação e como usar a biblioteca para armazenar,
indexar
e consultar dados JSON remotos no {{site.data.keyword.cloudant_short_notm}}
estão disponíveis [aqui ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/cloudant/swift-cloudant){:new_window}.

A biblioteca está em uma versão de liberação antiga.
Como tal,
ela não tem atualmente uma cobertura de API completa do {{site.data.keyword.cloudant_short_notm}}. 

>   **Nota**: o SwiftCloudant não é suportado no iOS e não pode ser chamado por meio do Objective-C.
