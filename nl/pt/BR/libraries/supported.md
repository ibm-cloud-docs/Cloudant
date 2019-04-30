---

copyright:
  years: 2015, 2019
lastupdated: "2019-04-02"

keywords: mobile, java, libraries, framework, examples, tutorials, node.js, python, swift

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

# Bibliotecas do cliente suportadas
{: #supported-client-libraries}

## Dispositivo móvel
{: #mobile}

A biblioteca de Sincronização do {{site.data.keyword.cloudantfull}} é usada para armazenar,
indexar
e consultar dados JSON locais em um dispositivo móvel.
Ela também é usada para sincronizar dados entre vários dispositivos.
A sincronização é controlada por seu aplicativo.
A
biblioteca também fornece métodos auxiliares para localizar e resolver conflitos,
ambos no dispositivo local e no banco de dados remoto.

Estão disponíveis duas versões:

-   [{{site.data.keyword.cloudant_short_notm}} Sync - Android/JavaSE ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/cloudant/sync-android){: new_window}.
-   [{{site.data.keyword.cloudant_short_notm}} Sync - iOS (CDTDatastore) ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/cloudant/CDTDatastore){: new_window}.

Uma [visão geral ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://cloudant.com/product/cloudant-features/sync/){: new_window} da Sincronização do {{site.data.keyword.cloudant_short_notm}} está disponível.
Detalhes dos [recursos ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://cloudant.com/cloudant-sync-resources/){: new_window} do {{site.data.keyword.cloudant_short_notm}} Sync também estão disponíveis.

## Componente
{: #java}

[java-cloudant ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/cloudant/java-cloudant){: new_window} é a biblioteca
oficial {{site.data.keyword.cloudantfull}} para Java.

Informações sobre a instalação da biblioteca ao incluí-la como uma dependência nas construções Maven ou Gradle estão disponíveis
[aqui ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/cloudant/java-cloudant#installation-and-usage){: new_window},
junto a detalhes e exemplos de como usar a biblioteca.

### Bibliotecas e estruturas para Java
{: #libraries-and-frameworks-for-java}

#### Biblioteca suportada para Java
{: #supported-library-for-java}

-   [java-cloudant ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/cloudant/java-cloudant){: new_window}.

#### Bibliotecas não suportadas para Java
{: #unsupported-for-libraries-for-java}

-   [ektorp ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://helun.github.io/Ektorp/reference_documentation.html){: new_window}.
-   [jcouchdb ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://code.google.com/p/jcouchdb/){: new_window}.
-   [jrelax ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/isterin/jrelax){: new_window}.
-   [LightCouch ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://www.lightcouch.org/){: new_window}.
-   [Modelo Java Cloudant Web Starter ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://ace.ng.bluemix.net/#/store/cloudOEPaneId=store&appTemplateGuid=CloudantJavaBPTemplate&fromCatalog=true){: new_window} para {{site.data.keyword.cloud}}.

### Exemplos e tutoriais para Java
{: #examples-and-tutorials-for-java}

-   [Criar, ler, atualizar e excluir ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/cloudant/haengematte/tree/master/java){: new_window} com as bibliotecas HTTP e JSON.
-   [Criar, ler, atualizar e excluir ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/cloudant/haengematte/tree/master/java/CrudWithEktorp){: new_window} com a biblioteca ektorp.
-   [Desenvolvendo aplicativos usando Java com {{site.data.keyword.cloudant_short_notm}} no {{site.data.keyword.cloud}}![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://cloudant.com/blog/building-apps-using-java-with-cloudant-on-ibm-bluemix/){: new_window}.
-   [Construindo um aplicativo Java EE no {{site.data.keyword.cloud_notm}} usando o Watson e o {{site.data.keyword.cloudant_short_notm}}![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://developer.ibm.com/bluemix/2014/10/17/building-java-ee-app-ibm-bluemix-using-watson-cloudant/){: new_window}exemplo do {{site.data.keyword.cloud_notm}} juntamente com o [ vídeo do YouTube ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.youtube.com/watch?feature=youtu.be&v=9AFMY6m0LIU&app=desktop){: new_window}.


## Node.js
{: #node-js}

[nodejs-cloudant ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/cloudant/nodejs-cloudant){: new_window}
é a biblioteca oficial {{site.data.keyword.cloudant_short_notm}} para Node.js.
É possível instalá-la com npm:

```sh
npm install cloudant
```
{: codeblock}

### Bibliotecas e estruturas para node.js
{: #libraries-and-frameworks-for-node-js}

#### Biblioteca suportada para node.js
{: #supported-library-for-node-js}

-   [nodejs-cloudant ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/cloudant/nodejs-cloudant){: new_window} ([npm ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.npmjs.com/package/@cloudant/cloudant){: new_window}).

#### Bibliotecas e estruturas não suportadas para node.js
{: #unsupported-libraries-and-frameworks-for-node-js-supported}

-   [sag-js ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/sbisbee/sag-js){: new_window}, que também funciona no navegador.
    Veja [saggingcouch ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/sbisbee/saggingcouch.com){: new_window} para obter mais detalhes.
-   [nano ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/dscape/nano){: new_window} é uma implementação minimalista.
-   [restler ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/danwrong/restler){: new_window} entrega o melhor desempenho, mas é realmente uma estrutura.
-   [cradle ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/flatiron/cradle){: new_window} é um cliente de alto nível que também estará disponível
se você precisar absolutamente de facilidade de uso com o custo de desempenho reduzido.
-   [cane_passport ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/ddemichele/cane_passport){: new_window} - {{site.data.keyword.cloudant_short_notm}} Angular Node Express com autoinicialização.
-   [express-cloudant ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/cloudant-labs/express-cloudant){: new_window} - um modelo para a estrutura Node.js Express que também usa PouchDB e Grunt.
-   [Node.js {{site.data.keyword.cloudant_short_notm}} DB Web Starter ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://ace.ng.bluemix.net/#/store/cloudOEPaneId=store&appTemplateGuid=nodejscloudantbp&fromCatalog=true){: new_window} - modelo para {{site.data.keyword.cloud_notm}}.
-   [Mobile Cloud ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://ace.ng.bluemix.net/#/store/cloudOEPaneId=store&appTemplateGuid=mobileBackendStarter&fromCatalog=true){: new_window} - modelo para {{site.data.keyword.cloud_notm}} (Node.js, Segurança, Push e Dados Móveis/{{site.data.keyword.cloudant_short_notm}}).

### Exemplos e tutoriais para node.js
{: #examples-and-tutorials-for-node-js}

-   [Criar, ler, atualizar e excluir ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/cloudant/haengematte/tree/master/nodejs){: new_window}.
-   [Cloudant-Uploader ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/garbados/Cloudant-Uploader){: new_window} - utilitário para fazer upload de arquivos `.csv` para o {{site.data.keyword.cloudant_short_notm}}.
-   [couchimport ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/glynnbird/couchimport){: new_window} - utilitário para importar arquivos `.csv` ou `.tsv` para o CouchDB ou {{site.data.keyword.cloudant_short_notm}}.
-   [Introdução ao {{site.data.keyword.cloud_notm}} e ao Node.js ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://thoughtsoncloud.com/2014/07/getting-started-ibm-bluemix-node-js/){: new_window}.
-   [Uma mistura de nuvens com {{site.data.keyword.cloud_notm}}, {{site.data.keyword.cloudant_short_notm}} e Node.js ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://gigadom.wordpress.com/2014/08/15/a-cloud-medley-with-ibm-bluemix-cloudant-db-and-node-js/){: new_window}.
-   [Desenvolver um aplicativo de jogo de palavras simples usando {{site.data.keyword.cloudant_short_notm}} no {{site.data.keyword.cloud_notm}} ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://www.ibm.com/developerworks/cloud/library/cl-guesstheword-app/index.html?ca=drs-){: new_window} - usa Node.js.
-   [Construindo um app de votação SMS em tempo real ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.twilio.com/blog/2012/09/building-a-real-time-sms-voting-app-part-1-node-js-couchdb.html){: new_window} - série com seis partes que usa Node.js, Twilio e {{site.data.keyword.cloudant_short_notm}}.
-   [Desenvolvendo um aplicativo da web Windows Azure multicamada ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.ampower.me/article/CouchDB/Tutorial-Building-a-Multi-Tier-Windows-Azure-Web-application-use-Cloudants-Couchdb-as-a-Service-node-94-409665?eqs=Z2NWNlltTmlUWStWcHdEWENWc3UxdmowREpiMjlGUVpKajJOZGJpSlVkemlPS2oxa0YxZE5BPT0=){: new_window} - usa {{site.data.keyword.cloudant_short_notm}}, Node.js, CORS e Grunt.
-   [Faça você mesmo: construa um aplicativo de inspeção remota usando {{site.data.keyword.cloud_notm}}, {{site.data.keyword.cloudant_short_notm}} e Raspberry Pi. ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://www.ibm.com/developerworks/library/ba-remoteservpi-app/index.html){: new_window}.

## Python
{: #python-supported}

Uma biblioteca suportada para trabalhar com o {{site.data.keyword.cloudant_short_notm}} usando Python está
disponível [aqui ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/cloudant/python-cloudant){: new_window}.

Aplicativos Python que acessam o {{site.data.keyword.cloudant_short_notm}} têm dependências do componente. Essas dependências devem ser especificadas em um arquivo `requirements.txt`. Para obter mais informações, veja [aqui ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://pip.readthedocs.io/en/1.1/requirements.html){: new_window}.
{: tip}

Faça download da liberação da biblioteca atual [aqui ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://pypi.python.org/pypi/cloudant/){: new_window}.
Obtenha mais informações sobre a linguagem Python em [python.org ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.python.org/about/){: new_window}. 

## Swift
{: #swift}

Uma biblioteca suportada está disponível para funcionar com o {{site.data.keyword.cloudant_short_notm}}.
A biblioteca chama-se SwiftCloudant
e é instalada usando o `cocoapods`.

A entrada de podfile é:

```sh
pod 'SwiftCloudant'
```
{: codeblock}

Mais informações sobre o SwiftCloudant,
incluindo detalhes sobre a instalação e como usar a biblioteca para armazenar,
indexar e consultar dados JSON remotos no {{site.data.keyword.cloudant_short_notm}}, estão disponíveis [aqui ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/cloudant/swift-cloudant){: new_window}.

A biblioteca está em uma versão de liberação antiga.
Como tal,
ela não tem atualmente uma cobertura de API completa do {{site.data.keyword.cloudant_short_notm}}. 

O SwiftCloudant não é suportado no iOS e não é possível chamá-lo por meio do Objective-C.
{: tip}
