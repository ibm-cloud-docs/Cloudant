---

copyright:
  years: 2017, 2019
lastupdated: "2019-06-12"

keywords: maintenance tasks, find application status, start application, stop application, upload application, diagnose problems, resolve problems, application log

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

<!-- Acrolinx: 2017-01-11 -->

# Criando um aplicativo {{site.data.keyword.cloud_notm}} simples para acessar um banco de dados do {{site.data.keyword.cloudant_short_notm}}: manutenção e resolução de problemas
{: #creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting}

Este tutorial mostra como manter um
aplicativo {{site.data.keyword.cloud}},
hospedado em sua instância de serviço do {{site.data.keyword.cloud_notm}}.
{: shortdesc}

## Executando tarefas básicas de manutenção do aplicativo
{: #performing-basic-application-maintenance-tasks}

Esta seção do tutorial explica como atualizar,
iniciar
e parar
seus aplicativos Python no {{site.data.keyword.cloud_notm}}.

### Localizando o status de seu aplicativo
{: #finding-the-status-of-your-application}

O status de aplicativos dentro da
instância de serviço do {{site.data.keyword.cloud_notm}} é exibido no painel.

No exemplo a seguir, o aplicativo `Cloudant CF app` não está em execução
e tem um estado `Stopped`:

![Captura de tela mostrando o painel do aplicativo em um estado 'stopped'](images/img0037.png)

### Iniciando seu aplicativo
{: #starting-your-application}

Se você tentar iniciar o aplicativo do tutorial sem primeiro excluir o banco de dados de demonstração do tutorial, o aplicativo não poderá funcionar corretamente. O aplicativo entrará em um ciclo de tentativa de iniciar,
falhando, porque o banco de dados existe,
parando e,
em seguida, tentando iniciar novamente. Para resolver o problema,
[pare o aplicativo](#stopping-your-application)
e exclua o banco de dados de demonstração do tutorial. O aplicativo poderá então iniciar com sucesso.
{: note}
    
Para iniciar um aplicativo parado, clique na opção `Iniciar`no menu:<br/>
![Screen capture showing 'Start' option](images/img0039.png)

### Parando seu aplicativo
{: #stopping-your-application}

Para parar um aplicativo em execução, clique na opção `Parar`no menu:<br/>
![Screen capture showing 'Stop' option](images/img0041.png)

### Fazendo upload de uma nova versão do aplicativo
{: #uploading-a-fresh-version-of-your-application}

Para fazer upload de uma nova versão do aplicativo,
basta seguir o [processo de upload](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-uploading-the-application#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-uploading-the-application).
A nova versão sobrescreve a versão mais antiga do aplicativo.

Se a versão mais antiga do aplicativo já estiver em execução quando você iniciar o upload, o {{site.data.keyword.cloud_notm}} interromperá automaticamente o aplicativo primeiro.
{: tip}

## Diagnosticando e resolvendo problemas
{: #diagnosing-and-resolving-problems}

Esta seção do tutorial fornece algumas dicas básicas de resolução de problemas para ajudar
a identificar,
diagnosticar
e resolver alguns problemas que possam ser encontrados ao desenvolver e implementar
seus primeiros aplicativos {{site.data.keyword.cloud_notm}}.

Uma boa fonte de orientação sobre as boas práticas para criar aplicativos {{site.data.keyword.cloud_notm}} ou Cloud Foundry é [Considerações para projetar e executar um aplicativo no Cloud ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://docs.cloudfoundry.org/devguide/deploy-apps/prepare-to-deploy.html){: new_window}.

Especificamente,
o conselho sobre como
[evitar gravações no sistema de arquivos local ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://docs.cloudfoundry.org/devguide/deploy-apps/prepare-to-deploy.html#filesystem){: new_window}
é prudente.

Por razões de simplicidade, esse tutorial grava conteúdo no sistema de arquivos local. No entanto,
a quantidade de material é pequena. Não se espera persistência
e não é 'essencial'.
{: tip}

### Usando o log do aplicativo
{: #using-the-application-log}

O recurso mais útil para diagnosticar e resolver problemas com o
aplicativo {{site.data.keyword.cloud_notm}} é o arquivo de log.

O arquivo de log para um aplicativo {{site.data.keyword.cloud_notm}}pode ser localizado ao clicar na guia `Logs`para abrir a página de informações de criação de log:<br/>
![Screen capture showing the link to access the 'Logs' information page](images/img0042.png)

Como a maioria dos arquivos de log,
um log do aplicativo {{site.data.keyword.cloud_notm}} contém detalhes sobre quais eventos ocorreram
e quando.

O log também identifica qual componente estava envolvido no evento registrado.
A tabela a seguir identifica os principais componentes:

Rótulo do componente | Componente
----------------|----------
`API`           | O sistema Cloud Foundry.
`APP`           | Seu aplicativo.
`CELL`          | O contêiner que contém seu aplicativo no {{site.data.keyword.cloud_notm}}.
`RTR`           | Os componentes de rede transportam mensagens de ou para seu aplicativo.

Por exemplo,
a captura de tela a seguir inclui um número de eventos típicos:<br/>
![Screen capture showing indicative log information](images/img0043.png)

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
![Screen capture showing error information within the log](images/img0044.png)

Às 2h31min23s,
o aplicativo detectou um problema:<br/>
`"Banco de dados { 0 } já existe". format (dbname)`

As mensagens restantes são o que se espera de qualquer aplicativo Python que encontra um problema.

De fato,
o log mostra qual componente encontrou um problema
e fornece o máximo de detalhes possível.
Deve-se então aplicar os procedimentos normais de resolução de problemas do aplicativo para resolver o problema.

## Término do tutorial
{: #end-of-tutorial}

O tutorial está completo.
