---

copyright:
  years: 2017
lastupdated: "2017-01-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-01-11 -->

# Criando um aplicativo Bluemix simples para acessar um banco de dados Cloudant: manutenção e resolução de problemas

Este tutorial mostra como manter um
aplicativo {{site.data.keyword.Bluemix}}
hospedado em sua instância de serviço do {{site.data.keyword.Bluemix_notm}}.
{:shortdesc}

<div id="maintenance"></div>

## Executando tarefas básicas de manutenção do aplicativo

Esta seção do tutorial explica como atualizar,
iniciar
e parar
seus aplicativos Python no {{site.data.keyword.Bluemix_notm}}.

### Localizando o status de seu aplicativo

O status de aplicativos dentro da
instância de serviço do {{site.data.keyword.Bluemix_notm}} é exibido no painel.

No exemplo a seguir,
o aplicativo `Cloudant Python` não está em execução
e tem um estado `Stopped`:<br/>
![Captura de tela mostrando o painel do aplicativo em um estado 'stopped'](images/img0037.png)

### Iniciando seu aplicativo

>   **Nota**: se você tentar iniciar o aplicativo tutorial
sem primeiro excluir o banco de dados de demonstração do tutorial,
o aplicativo não poderá funcionar corretamente.
O aplicativo entrará em um ciclo de tentativa de iniciar,
falhando, porque o banco de dados existe,
parando e,
em seguida, tentando iniciar novamente.
Para resolver o problema,
[pare o aplicativo](#stopping-your-application)
e exclua o banco de dados de demonstração do tutorial.
O aplicativo poderá então iniciar com sucesso.

Para iniciar um aplicativo interrompido,
primeiro clique no ícone de menu do aplicativo no painel:<br/>
![Captura de tela mostrando o painel com o ícone de gerenciamento de aplicativo](images/img0038.png)

Em seguida,
clique na opção `Start App` no menu:<br/>
![Captura de tela mostrando a opção 'Start App'](images/img0039.png)

### Parando seu aplicativo

Para parar um aplicativo em execução,
primeiro clique no ícone de menu do aplicativo no painel:<br/>
![Captura de tela mostrando o painel com o ícone de gerenciamento de aplicativo](images/img0040.png)

Em seguida,
clique na opção `Stop App` no menu:<br/>
![Captura de tela mostrando a opção 'Stop App'](images/img0041.png)

<div id="troubleshooting"></div>

### Fazendo upload de uma nova versão do aplicativo

Para fazer upload de uma nova versão do aplicativo,
basta seguir o [processo de upload](create_bmxapp_upload.html).
A nova versão sobrescreve a versão mais antiga do aplicativo.

>   **Nota**: se a versão mais antiga do aplicativo já estiver em execução quando você iniciar o upload,
    o {{site.data.keyword.Bluemix_notm}} parará automaticamente o aplicativo primeiro.

## Diagnosticando e resolvendo problemas

Esta seção do tutorial fornece algumas dicas básicas de resolução de problemas para ajudar
a identificar,
diagnosticar
e resolver alguns problemas que possam ser encontrados ao desenvolver e implementar
seus primeiros aplicativos {{site.data.keyword.Bluemix_notm}}.

Uma boa fonte de conselhos sobre as melhores práticas para criar aplicativos {{site.data.keyword.Bluemix_notm}} ou
Cloud Foundry está
[aqui ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://docs.cloudfoundry.org/devguide/deploy-apps/prepare-to-deploy.html){:new_window}.

Especificamente,
o conselho sobre como
[evitar gravações no sistema de arquivos local ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://docs.cloudfoundry.org/devguide/deploy-apps/prepare-to-deploy.html#filesystem){:new_window}
é prudente.

>   **Nota**: por razões de simplicidade,
este tutorial grava o conteúdo no sistema de arquivos local.
No entanto,
a quantidade de material é pequena.
Não se espera persistência
e não é 'essencial'.

### Usando o log do aplicativo

O recurso mais útil para diagnosticar e resolver problemas com o
aplicativo {{site.data.keyword.Bluemix_notm}} é o arquivo de log.

O arquivo de log de um aplicativo {{site.data.keyword.Bluemix_notm}} pode ser localizado na página de informações `Logs`:<br/>
![Captura de tela mostrando o link para acessar a página de informações 'Logs'](images/img0042.png)

Como a maioria dos arquivos de log,
um log do aplicativo {{site.data.keyword.Bluemix_notm}} contém detalhes sobre quais eventos ocorreram
e quando.

O log também identifica qual componente estava envolvido no evento registrado.
A tabela a seguir identifica os principais componentes:

Rótulo do componente | Componente
----------------|----------
`API`           | O sistema Cloud Foundry.
`APP`           | Seu aplicativo.
`CELL`          | O contêiner que contém seu aplicativo no {{site.data.keyword.Bluemix_notm}}.
`RTR`           | Os componentes de rede transportam mensagens de ou para seu aplicativo.

Por exemplo,
a captura de tela a seguir inclui vários eventos típicos:<br/>
![Captura de tela mostrando informação de log indicativa](images/img0043.png)

Observe os eventos nos horários a seguir:

-   Às 13h56min56s, o aplicativo foi iniciado com sucesso.
-   Às 13h58min43s, a rede recebeu uma solicitação de HTTP simples para `GET /`.
-   Momentos depois, o aplicativo recebeu a solicitação de HTTP e respondeu a ela.
-   Às 14h13min46s, uma solicitação foi recebida para parar o aplicativo.
-   Às 14h13min48s, o aplicativo concluiu o processo de parada.

O aplicativo descrito neste tutorial é deliberadamente mínimo.
Como um exemplo específico,
nenhuma tentativa será feita para determinar se o banco de dados de destino existe
e,
se existir,
evitar tentar criá-lo novamente.
O efeito é que se você tentar executar o aplicativo tutorial mais de uma vez,
sem remover o banco de dados antes,
o aplicativo falhará e reiniciará repetidamente.

É possível ver esse efeito na captura de tela a seguir:<br/>
![Captura de tela mostrando informações de erro no log](images/img0044.png)

Às 14h31min23s,
o aplicativo detectou um problema:<br/>
`"Database {0} already exists".format(dbname)`

As mensagens restantes são o que se espera de qualquer aplicativo Python que encontra um problema.

De fato,
o log mostra qual componente encontrou um problema
e fornece o máximo de detalhes possível.
Deve-se então aplicar os procedimentos normais de resolução de problemas do aplicativo para resolver o problema.

## Término do tutorial

O tutorial está completo.
