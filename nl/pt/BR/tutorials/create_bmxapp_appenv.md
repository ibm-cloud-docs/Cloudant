---

copyright:
  years: 2017, 2018
lastupdated: "2018-06-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-01-10 -->

# Criando um aplicativo {{site.data.keyword.cloud_notm}} simples para acessar um banco de dados do {{site.data.keyword.cloudant_short_notm}}: o ambiente de aplicativos

Esta seção do tutorial descreve como configurar o ambiente de aplicativos que deve-se ter
para criar um aplicativo {{site.data.keyword.cloud}}.
{:shortdesc}

<div id="creating"></div>

## Criando um ambiente de aplicativos do {{site.data.keyword.cloud_notm}}

1.  Efetue login em sua conta do {{site.data.keyword.cloud_notm}}.
    O painel do {{site.data.keyword.cloud_notm}} pode ser localizado em:
[http://bluemix.net ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://bluemix.net){:new_window}.
    Após a autenticação com seu nome de usuário e senha,
o painel do {{site.data.keyword.cloud_notm}} aparece:<br/>
    ![Painel do {{site.data.keyword.cloud_notm}}](images/img0001.png)

2.  Clique no link '`Catalog`':<br/>
    ![Link de catálogo do {{site.data.keyword.cloud_notm}}](images/img0002.png)<br/>
    Aparece uma lista dos serviços disponíveis no {{site.data.keyword.cloud_notm}}.

3.  Clique na entrada '`Cloud Foundry Apps`' sob o título `Apps`:<br/>
    ![Aplicativos Cloud Foundry do {{site.data.keyword.cloud_notm}}](images/img0012.png)<br/>
    Aparece uma lista dos aplicativos Cloud Foundry
    disponíveis no {{site.data.keyword.cloud_notm}}.

4.  Clique na entrada '`Python`':<br/>
    ![Aplicativo Python Cloud Foundry do {{site.data.keyword.cloud_notm}}](images/img0013.png)<br/>
    Aparece um formulário '`Create a Cloud Foundry App`'.

5.  Use o formulário '`Create a Cloud Foundry App`' para  especificar e criar o ambiente
para seu aplicativo Python Cloud Foundry.
    Insira um nome para seu aplicativo,
por exemplo, '`Cloudant Python`'.
    O nome do host é gerado para você automaticamente,
embora seja possível customizá-lo:<br/>
    ![Nomes de aplicativos Python Cloud Foundry do {{site.data.keyword.cloud_notm}}](images/img0014.png)<br/>
    >   **Nota**: o nome do host deve ser exclusivo no domínio do {{site.data.keyword.cloud_notm}}. Neste exemplo, o domínio é '`mybluemix.net`', fornecendo um nome completo do host de '`Cloudant-Python.mybluemix.net`'.

6.  Clique em '`Create`' para criar o ambiente de aplicativos:<br/>
    ![Criar o aplicativo Python Cloud Foundry do {{site.data.keyword.cloud_notm}}](images/img0015.png)

7.  Após uma curta pausa, a
janela '`Getting Started`' para seu novo ambiente de aplicativos aparece.
    Um aplicativo de teste é criado automaticamente no ambiente.
    O aplicativo é iniciado automaticamente,
conforme mostrado pelo ícone verde e o status `Your app is running`.
    O aplicativo é um programa 'pulsação',
suficiente para mostrar que o novo ambiente de aplicativos está pronto para você usar.
    Clique no link `Dashboard`' para retornar para o painel de sua conta do {{site.data.keyword.cloud_notm}}.<br/>
    ![O novo app Python Cloud Foundry do {{site.data.keyword.cloud_notm}} pela primeira vez](images/img0016.png)

8.  Seu painel agora inclui o ambiente de aplicativos recém-criado:<br/>
    ![O app Python Cloud Foundry básico do {{site.data.keyword.cloud_notm}} aparecendo no painel](images/img0017.png)

Agora você tem um ambiente de aplicativos do Python do {{site.data.keyword.cloud_notm}},
pronto para uso.

Para trabalhar com uma instância de banco de dados do {{site.data.keyword.cloudant_short_notm}},
a próxima etapa é criar uma 'conexão' entre o ambiente de aplicativos e a instância de banco de dados.

<div id="connecting"></div>

## Conectando aplicativos e serviços do {{site.data.keyword.cloud_notm}}

Esta seção do tutorial explica como você conecta
ambientes de aplicativos e serviços do {{site.data.keyword.cloud_notm}} usando
a área de configuração e gerenciamento de seu aplicativo.

1.  No painel do {{site.data.keyword.cloud_notm}},
clique na entrada de seu aplicativo.<br/>
    ![Selecionando seu aplicativo no painel do {{site.data.keyword.cloud_notm}}](images/img0018.png)<br/>
    >   **Nota**: evite a coluna '`Route`', pois clicar no link que está associado a seu aplicativo chama o aplicativo em vez de levá-lo para a área de configuração. Um local melhor para clicar é no nome de seu aplicativo.

    Aparece a área de visão geral de configuração e gerenciamento para seu aplicativo.

2.  Para conectar o ambiente de aplicativos a outro serviço,
clique no link '`Connections`':<br/>
    ![Selecionando a configuração de conexão para seu aplicativo {{site.data.keyword.cloud_notm}}](images/img0019.png)<br/>
    Aparece uma área para configurar uma conexão entre seu aplicativo e quaisquer outros serviços disponíveis em sua conta.

3.  Um [pré-requisito](create_bmxapp_prereq.html#prerequisites) para esse tutorial é uma
instância de banco de dados existente do {{site.data.keyword.cloudant_short_notm}}.
    Clique em '`Connect existing`' para estabelecer uma conexão entre essa instância do banco de dados e seu aplicativo:<br/>
    ![Conectar a uma instância de banco de dados existente](images/img0020.png)<br/>
    Aparece uma lista das instâncias de serviço existentes em sua conta.

4.  Clique na instância de banco de dados do {{site.data.keyword.cloudant_short_notm}} que você deseja usar.
    Este tutorial usa a instância '`Cloudant Service 2017`':<br/>
    ![Escolher a instância de banco de dados de exemplo do tutorial](images/img0021.png)

5.  Você é solicitado a confirmar que realmente deseja conectar a instância de banco de dados a seu aplicativo.
    Clique em '`Connect`' para confirmar a conexão:<br>
    ![Confirmar a conexão com a instância de banco de dados](images/img0022.png)

6.  Modificar as conexões de serviço de um aplicativo afeta sua configuração geral.
    A modificação requer uma 'remontagem' do aplicativo,
que também força um aplicativo em execução a parar.
    Aparece uma janela para você confirmar que está pronto para que a 'remontagem' continue.
    Clique em '`Restage`' para continuar:<br/>
    ![Confirmar remontagem do aplicativo](images/img0023.png)

7.  A página de conexões de serviço reaparece.
    Agora ela inclui a instância de banco de dados recém-conectada:<br/>
    ![A instância de banco de dados recém-conectada](images/img0024.png)

O ambiente de aplicativos e a instância de banco de dados estão agora conectados.
A próxima etapa é assegurar-se de que as ferramentas necessárias estejam instaladas para você
trabalhar com aplicativos {{site.data.keyword.cloud_notm}}.

<div id="toolkits"></div>

## Os kits de ferramentas de comandos do Cloud Foundry e {{site.data.keyword.cloud_notm}}

Esta seção do tutorial descreve os kits de ferramentas que devem ser instalados para funcionar com
seu ambiente,
aplicativos
e serviços do {{site.data.keyword.cloud_notm}}.

O kit de ferramentas do [Cloud Foundry ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://en.wikipedia.org/wiki/Cloud_Foundry){:new_window}
é uma coleção de ferramentas para trabalhar com aplicativos que são
implementados em um ambiente compatível com o Cloud Foundry.
Use essas ferramentas para tarefas como a atualização de um aplicativo implementado
ou para iniciar e parar um aplicativo em execução.

O kit de ferramentas do {{site.data.keyword.cloud_notm}} fornece recursos extras,
que são necessários para trabalhar com aplicativos hospedados e em execução em um ambiente do {{site.data.keyword.cloud_notm}}.

> **Nota**: assegure-se de instalar os kits de ferramentas do Cloud Foundry _e_
do {{site.data.keyword.cloud_notm}}.

Fazer download e instalar os kits de ferramentas é uma tarefa única.
Se os kits de ferramentas já estiverem instalados e funcionando em seu sistema,
não será necessário fazer download deles novamente,
a menos que sejam atualizados.

Informações gerais sobre os kits de ferramentas estão disponíveis
[aqui ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](../getting-started.html#getting-started-with-cloudant){:new_window}.

### Instalando o kit de ferramentas do Cloud Foundry

Algumas distribuições do sistema operacional possuem uma versão do kit de ferramentas do Cloud Foundry já disponível.
Se a versão suportada for 6.11 ou superior,
ela será compatível com o {{site.data.keyword.cloud_notm}} e poderá ser usada.
É possível verificar qual versão está instalada, executando [este teste](#checkCFversion).

Como alternativa,
use as etapas a seguir para fazer download e instalar o kit de ferramentas do Cloud Foundry em seu sistema: 

1.  Um link para fazer download do kit de ferramentas do Cloud Foundry está disponível na janela '`Getting started`'
de seu ambiente de aplicativos:<br/>
    ![Um link para fazer download do kit de ferramentas do Cloud Foundry](images/img0025.png)

2.  Clicar no link leva você para uma
[página de download no GitHub ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/cloudfoundry/cli/releases){:new_window}:<br/>
    ![A página de download do kit de ferramentas do Cloud Foundry no GitHub](images/img0026.png)

3.  Faça download e execute a versão mais recente do instalador para seu sistema.

4.  <div id='checkCFversion'></div>Para verificar se você tem um kit de ferramentas operacional do Cloud Foundry,
execute o comando a seguir em um prompt:

    ```sh
    cf --version
    ```
    {:pre}
    
    Espere um resultado semelhante à saída a seguir:
    
    ```
    cf version 6.20.0+25b1961-2016-06-29
    ```
    {:codeblock}
    
    >   **Nota**: a versão do kit de ferramentas do Cloud Foundry deverá ser 6.11 ou mais recente para compatibilidade com o {{site.data.keyword.cloud_notm}}.

### Instalando o kit de ferramentas do {{site.data.keyword.cloud_notm}}

Use as etapas a seguir para fazer download e instalar o kit de ferramentas do {{site.data.keyword.cloud_notm}} em seu sistema.

1.  Um link para fazer download do kit de ferramentas do {{site.data.keyword.cloud_notm}} está disponível
na janela '`Introdução`' de seu aplicativo:<br/>
    ![Um link para fazer download do kit de ferramentas do Cloud Foundry](images/img0027.png)

2.  Clicar no link leva você para uma [página de download ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://console.bluemix.net/docs/cli/reference/bluemix_cli/get_started.html#getting-started){:new_window}:<br/>
    ![A página de download do kit de ferramentas do {{site.data.keyword.cloud_notm}}](images/img0028.png)


3.  Faça download e execute o instalador apropriado para seu sistema.

    O instalador verifica para assegurar que você tenha uma versão adequada do kit de ferramentas do Cloud Foundry instalada.
    Se tudo estiver correto,
o kit de ferramentas do {{site.data.keyword.cloud_notm}} será instalado em seu sistema.

4.  Para verificar se você tem um kit de ferramentas funcional do {{site.data.keyword.cloud_notm}},
    execute o comando a seguir em um prompt:
    
    ```sh
    bluemix --version
    ```
    {:pre}
    
    Espere um resultado semelhante à saída a seguir:
    
    ```
    bluemix version 0.4.5+03c29de-2016-12-08T07:01:01+00:00
    ```
    {:codeblock}
    
As ferramentas que funcionarão com os aplicativos {{site.data.keyword.cloud_notm}} estão agora disponíveis.
A próxima etapa é obter os materiais 'iniciadores' para ajudá-lo a criar
um aplicativo {{site.data.keyword.cloud_notm}}.

<div id="starter"></div>

## O aplicativo 'iniciador'

Essa seção do tutorial descreve um aplicativo iniciador do {{site.data.keyword.cloud_notm}}
e explica como customizá-lo para acessar
uma instância de banco de dados do
{{site.data.keyword.cloudant_short_notm}}.

Um aplicativo iniciador do {{site.data.keyword.cloud_notm}} é a coleção mínima possível
de arquivos de origem e de configuração necessários
para criar um aplicativo funcional do {{site.data.keyword.cloud_notm}}.
Em alguns aspectos,
é semelhante a um [aplicativo 'Hello World' ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://en.wikipedia.org/wiki/%22Hello,_World!%22_program){:new_window};
suficiente apenas para mostrar que o sistema básico e a configuração estão funcionando corretamente.

Um aplicativo iniciador do {{site.data.keyword.cloud_notm}} é um archive de arquivos de exemplo que deve ser modificado ou estendido à medida que você desenvolve seu aplicativo {{site.data.keyword.cloud_notm}}.

Três arquivos especificamente são essenciais:

-   ['`Procfile`'](#procfile)
-   ['`manifest.yml`'](#manifest)
-   ['`requirements.txt`'](#requirements)

<div id="procfile"></div>

### O arquivo '`Procfile`'

O '`Procfile`' contém os detalhes
que o {{site.data.keyword.cloud_notm}} precisa para executar seu aplicativo.

Mais especificamente,
um '`Procfile`' é um artefato do Cloud Foundry que
define um tipo de processo de aplicativo
e o comando para executar o aplicativo.
Mais informações sobre o '`Procfile`' estão disponíveis
[aqui ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://docs.cloudfoundry.org/buildpacks/prod-server.html#procfile){:new_window}.

O '`Procfile`' para um aplicativo iniciador do Python do {{site.data.keyword.cloud_notm}}
é semelhante ao exemplo a seguir:

```
web: python server.py
```
{:codeblock}

Esse exemplo indica que o aplicativo é um aplicativo da web Python
e que é iniciado executando o comando:

```sh
python server.py
```
{:codeblock}

Um arquivo de origem Python iniciador '`server.py`' é incluído no archive do aplicativo iniciador.
O arquivo '`server.py`' é modificado para seu aplicativo.
Como alternativa,
crie um arquivo de origem Python inteiramente novo.
Em seguida,
atualize o '`Procfile`' para que o novo arquivo seja usado quando seu aplicativo for iniciado.

<div id="manifest"></div>

### O arquivo '`manifest.yml`'

O arquivo '`manifest.yml`' é uma descrição completa do aplicativo
e do ambiente que ele requer para ser executado.

O arquivo para um aplicativo iniciador do Python do {{site.data.keyword.cloud_notm}} é semelhante ao exemplo a seguir:

```
applications:
- path: .
  memory: 128M
  instances: 1
  domain: mybluemix.net
  name: Cloudant Python
  host: Cloudant-Python
  disk_quota: 1024M
  services:
  - Cloudant Service 2017
```
{:codeblock}

Três pontos são dignos de nota:

-   Os valores '`domain`',
'`name`'
e '`host`' correspondiam aos valores inseridos quando
o aplicativo {{site.data.keyword.cloud_notm}} era [criado](#creating).
-   O valor '`name`' é usado pelo kit de ferramentas do Cloud Foundry para identificar o aplicativo que você está administrando.
-   O valor '`services`' confirma que a instância de banco de dados '`Cloudant Service 2017`'
do {{site.data.keyword.cloudant_short_notm}} está conectada ao ambiente de aplicativos.

Normalmente não é necessário modificar o arquivo '`manifest.yml`',
no entanto, é útil entender por que ele deve estar presente para que seu aplicativo funcione.

<div id="requirements"></div>

### O arquivo '`requirements.txt`'

O arquivo '`requirements.txt`' especifica quaisquer componentes adicionais que são necessários para que seu aplicativo funcione.

No aplicativo iniciador,
o arquivo '`requirements.txt`' está vazio.

No entanto, neste tutorial o aplicativo Python acessa uma
instância de banco de dados do {{site.data.keyword.cloudant_short_notm}}.
Portanto,
o aplicativo deve ser capaz de usar a
biblioteca do cliente [{{site.data.keyword.cloudant_short_notm}} para aplicativos Python](../libraries/supported.html#python).

Para ativar a biblioteca do cliente Python,
modifique o arquivo '`requirements.txt`' para informar:
```
cloudant==2.3.1
```
{:codeblock}

## A próxima etapa

A próxima etapa no tutorial é [criar o aplicativo](create_bmxapp_createapp.html).
