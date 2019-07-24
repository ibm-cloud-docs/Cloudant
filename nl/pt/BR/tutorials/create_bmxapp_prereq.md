---

copyright:
  years: 2017, 2019
lastupdated: "2019-06-12"

keywords: python, create service instance, create stand-alone python application

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

# Criando um aplicativo {{site.data.keyword.cloud_notm}} simples para acessar um banco de dados {{site.data.keyword.cloudant_short_notm}}: pré-requisitos
{: #creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites}

Esta seção do tutorial descreve os pré-requisitos
para criar um aplicativo {{site.data.keyword.cloud}}.
{: shortdesc}

## Pré-requisitos
{: #prerequisites-create_bmxapp_prereq}

Assegure-se de que tenha os recursos ou as informações a seguir prontas
antes de começar a trabalhar no tutorial.

### Python
{: #python-create-bmxapp-prereq}

Para todos, exceto o trabalho de desenvolvimento mais simples possível,
será muito mais fácil se você tiver uma instalação atual da
[linguagem de programação Python ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.python.org/){: new_window}
em seu sistema.

Para verificar,
execute o seguinte comando em um prompt:

```sh
python --version
```
{: pre}

Espere um resultado semelhante à saída a seguir:

```
Python 2.7.12
```
{: codeblock}

### Uma instância de serviço do {{site.data.keyword.cloud_notm}} no {{site.data.keyword.cloudant_short_notm}}
{: #an-ibm-cloudant-service-instance-on-ibm-cloud}

Um tutorial separado para [criar uma instância de serviço do {{site.data.keyword.cloudantfull}} no {{site.data.keyword.cloud_notm}}](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-an-ibm-cloudant-instance-on-ibm-cloud) cria uma instância de serviço chamada '`Cloudant-o7`'. 

Este tutorial supõe que você já tenha criado uma instância de serviço chamada '`Cloudant-o7`'.

### Um aplicativo de banco de dados do {{site.data.keyword.cloudant_short_notm}}
{: #an-ibm-cloudant-database-application}

Um tutorial separado para [criar um aplicativo Python
independente para trabalhar com uma instância de serviço do {{site.data.keyword.cloudant_short_notm}}
service instance] (/docs/services/Cloudant?topic=cloudant-creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud#creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud) também está disponível. Ele apresenta uma série de conceitos que são úteis para entender como criar e preencher um banco de dados do {{site.data.keyword.cloudant_short_notm}}.

Este tutorial supõe que você esteja familiarizado com esses conceitos.

A próxima etapa no tutorial é [criar o ambiente de aplicativos](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment).
