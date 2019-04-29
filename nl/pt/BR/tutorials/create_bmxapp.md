---

copyright:
  years: 2017, 2019
lastupdated: "2019-03-19"

keywords: create applications, deploy applications, create simple application

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

# Criando um aplicativo {{site.data.keyword.cloud_notm}} simples para acessar um banco de dados {{site.data.keyword.cloudant_short_notm}}
{: #creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database}

Este tutorial mostra como criar um aplicativo {{site.data.keyword.cloud}} que usa a
[linguagem de programação Python ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.python.org/){: new_window} para
acessar um banco de dados {{site.data.keyword.cloudantfull}}
hospedado na instância de serviço do {{site.data.keyword.cloud_notm}}.
{: shortdesc}

## Vantagens do {{site.data.keyword.cloud_notm}}
{: #advantages-of-ibm-cloud}

Uma vantagem significativa do {{site.data.keyword.cloud}} é que é possível criar e implementar aplicativos no
próprio {{site.data.keyword.cloud_notm}}.
Não é necessário localizar e manter um servidor para executar os aplicativos.

Se você já estiver usando uma instância de banco de dados {{site.data.keyword.cloudant_short_notm}} no {{site.data.keyword.cloud_notm}}, fará sentido também ter seus aplicativos lá.

Os aplicativos {{site.data.keyword.cloud_notm}} são criados geralmente usando
a tecnologia [Cloud Foundry ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://en.wikipedia.org/wiki/Cloud_Foundry){: new_window}.
O Cloud Foundry oferece um recurso de Plataforma como serviço (PaaS)
que simplifica o processo de criação de aplicativos que podem ser implementados e executados
em um ambiente de nuvem.

[Um tutorial separado](/docs/services/Cloudant?topic=cloudant-creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud#creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud) mostrou-lhe como criar um aplicativo Python independente que usa uma instância de banco de dados {{site.data.keyword.cloudant_short_notm}} no {{site.data.keyword.cloud_notm}}.
Neste tutorial,
você configurará e criará um aplicativo Python pequeno hospedado no {{site.data.keyword.cloud_notm}}.
O aplicativo conecta-se à instância de banco de dados do {{site.data.keyword.cloudant_short_notm}}
e cria um único
documento simples.

O código Python específico para cada tarefa é fornecido como parte deste tutorial.
Um programa Python completo,
suficiente para demonstrar os conceitos,
é fornecido no tutorial
[aqui](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-code#complete-python-program).

Não foi feita nenhuma tentativa de criar código Python _eficiente_ para este tutorial;
a intenção é mostrar código operacional simples e fácil de entender
que você possa aprender e aplicar a seus próprios aplicativos.

Além disso,
não foi feita nenhuma tentativa de tratar todas as verificações ou condições de erro possíveis.
Foram incluídas algumas verificações de exemplo para ilustrar algumas das técnicas,
mas será necessário aplicar as melhores práticas normais para verificar e manipular todos os
avisos ou condições de erro que forem encontrados por seus próprios aplicativos.

## Visão geral da tarefa
{: #task-overview}

Para criar um aplicativo Python operacional no {{site.data.keyword.cloud_notm}}
que possa acessar uma instância de banco de dados do {{site.data.keyword.cloudant_short_notm}},
será necessário executar as tarefas a seguir:

-   [Criar um ambiente de aplicativos Python no {{site.data.keyword.cloud_notm}}.](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#creating-an-ibm-cloud-application-environment)
-   [Assegurar-se de que o ambiente de aplicativos Python possua uma 'conexão' para uma instância de banco de dados do {{site.data.keyword.cloudant_short_notm}}.](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#connecting-ibm-cloud-applications-and-services)
-   [(Tarefa única) Fazer download e instalar o Cloud Foundry e os kits de ferramentas de linha de comandos do {{site.data.keyword.cloud_notm}}.](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#the-cloud-foundry-and-ibm-cloud-command-toolkits)
-   [Fazer download do aplicativo 'iniciador'.](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#the-starter-application)
-   [Customizar o aplicativo iniciador para criar seu próprio aplicativo para acessar a instância de banco de dados do {{site.data.keyword.cloudant_short_notm}}.](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-code#the-application-code)
-   [Fazer upload de seu aplicativo e testar se ele funciona.](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-uploading-the-application#uploading-the-application)
-   [Executar tarefas básicas de manutenção do aplicativo.](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting)
-   [Diagnosticar e resolver problemas (resolução de problemas).](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting#diagnosing-and-resolving-problems)

## Estrutura do tutorial
{: #tutorial-structure}

O tutorial consiste em cinco seções:

1.  [Pré-requisitos](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites)
2.  [O ambiente de aplicativos](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment)
3.  [Criando seu aplicativo](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-code#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-code)
4.  [Fazendo upload e executando seu aplicativo](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-uploading-the-application#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-uploading-the-application)
5.  [Mantendo e solucionando problemas de seu aplicativo](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting)

Para iniciar o tutorial,
comece [verificando os pré-requisitos](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites).
