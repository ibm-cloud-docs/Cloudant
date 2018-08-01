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

# Criando um aplicativo {{site.data.keyword.Bluemix_notm}} simples para acessar um banco de dados do {{site.data.keyword.cloudant_short_notm}}

Este tutorial mostra como criar um aplicativo {{site.data.keyword.Bluemix}} que usa a
[linguagem de programação Python ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.python.org/){:new_window} para
acessar um banco de dados {{site.data.keyword.cloudantfull}}
hospedado na instância de serviço do {{site.data.keyword.Bluemix_notm}}.
{:shortdesc}

## Contexto

Uma vantagem significativa do {{site.data.keyword.Bluemix_notm}} é que é possível criar e implementar aplicativos no
próprio {{site.data.keyword.Bluemix_notm}}.
Não é necessário localizar e manter um servidor para executar os aplicativos.

Se você já está usando uma instância de banco de dados do {{site.data.keyword.Bluemix_notm}}
no {{site.data.keyword.cloudant_short_notm}},
faz sentido que seus aplicativos também fiquem lá.

Os aplicativos {{site.data.keyword.Bluemix_notm}} são criados geralmente usando
a tecnologia [Cloud Foundry ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://en.wikipedia.org/wiki/Cloud_Foundry){:new_window}.
O Cloud Foundry oferece um recurso de Plataforma como serviço (PaaS)
que simplifica o processo de criação de aplicativos que podem ser implementados e executados
em um ambiente de nuvem.

[Um tutorial separado](create_database.html) mostrou como criar um aplicativo Python independente
que usa uma instância de banco de dados do {{site.data.keyword.Bluemix_notm}}
no {{site.data.keyword.cloudant_short_notm}}.
Neste tutorial,
você configurará e criará um aplicativo Python pequeno hospedado no {{site.data.keyword.Bluemix_notm}}.
O aplicativo conecta-se à instância de banco de dados do {{site.data.keyword.cloudant_short_notm}}
e cria um único
documento simples.

O código Python específico para cada tarefa é fornecido como parte deste tutorial.
Um programa Python completo,
suficiente para demonstrar os conceitos,
é fornecido no tutorial
[aqui](create_bmxapp_createapp.html#complete-listing).

Não foi feita nenhuma tentativa de criar código Python _eficiente_ para este tutorial;
a intenção é mostrar código operacional simples e fácil de entender
que você possa aprender e aplicar a seus próprios aplicativos.

Além disso,
não foi feita nenhuma tentativa de tratar todas as verificações ou condições de erro possíveis.
Foram incluídas algumas verificações de exemplo para ilustrar algumas das técnicas,
mas será necessário aplicar as melhores práticas normais para verificar e manipular todos os
avisos ou condições de erro que forem encontrados por seus próprios aplicativos.

## Visão geral da tarefa

Para criar um aplicativo Python operacional no {{site.data.keyword.Bluemix_notm}}
que possa acessar uma instância de banco de dados do {{site.data.keyword.cloudant_short_notm}},
será necessário executar as tarefas a seguir:

-   [Criar um ambiente de aplicativos Python no {{site.data.keyword.Bluemix_notm}}.](create_bmxapp_appenv.html#creating)
-   [Assegurar-se de que o ambiente de aplicativos Python possua uma 'conexão' para uma instância de banco de dados do {{site.data.keyword.cloudant_short_notm}}.](create_bmxapp_appenv.html#connecting)
-   [(Tarefa única) Fazer download e instalar o Cloud Foundry e os kits de ferramentas de linha de comandos do {{site.data.keyword.Bluemix_notm}}.](create_bmxapp_appenv.html#toolkits)
-   [Fazer download do aplicativo 'iniciador'.](create_bmxapp_appenv.html#starter)
-   [Customizar o aplicativo iniciador para criar seu próprio aplicativo para acessar a instância de banco de dados do {{site.data.keyword.cloudant_short_notm}}.](create_bmxapp_createapp.html#theApp)
-   [Fazer upload de seu aplicativo e testar se ele funciona.](create_bmxapp_upload.html#uploading)
-   [Executar tarefas básicas de manutenção do aplicativo.](create_bmxapp_maintain.html#maintenance)
-   [Diagnosticar e resolver problemas (resolução de problemas).](create_bmxapp_maintain.html#troubleshooting)

## Estrutura do tutorial

O tutorial consiste em cinco seções:

1.  [Pré-requisitos](create_bmxapp_prereq.html)
2.  [O ambiente de aplicativos](create_bmxapp_appenv.html)
3.  [Criando seu aplicativo](create_bmxapp_createapp.html)
4.  [Fazendo upload e executando seu aplicativo](create_bmxapp_upload.html)
5.  [Mantendo e solucionando problemas de seu aplicativo](create_bmxapp_maintain.html)

## A próxima etapa

Para iniciar o tutorial,
comece [verificando os Pré-requisitos](create_bmxapp_prereq.html).
