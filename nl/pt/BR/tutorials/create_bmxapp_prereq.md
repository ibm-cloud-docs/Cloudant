---

copyright:
  years: 2017, 2018
lastupdated: "2018-10-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:tip: .tip}

<!-- Acrolinx: 2017-05-10 -->

# Criando um aplicativo {{site.data.keyword.cloud_notm}} simples para acessar um banco de dados {{site.data.keyword.cloudant_short_notm}}: pré-requisitos

Esta seção do tutorial descreve os pré-requisitos
para criar um aplicativo {{site.data.keyword.cloud}}.
{:shortdesc}

## Pré-requisitos

Assegure-se de que tenha os recursos ou as informações a seguir prontas
antes de começar a trabalhar no tutorial.

### Python

Para todos, exceto o trabalho de desenvolvimento mais simples possível,
será muito mais fácil se você tiver uma instalação atual da
[linguagem de programação Python ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.python.org/){:new_window}
em seu sistema.

Para verificar,
execute o seguinte comando em um prompt:

```sh
python --version
```
{:pre}

Espere um resultado semelhante à saída a seguir:

```
Python 2.7.12
```
{:codeblock}

<div id="csi"></div>

### Uma instância de serviço do {{site.data.keyword.cloud_notm}} no {{site.data.keyword.cloudant_short_notm}}

Um tutorial separado para criar uma instância de serviço do {{site.data.keyword.cloudantfull}} chamada
'`Cloudant Service 2017`' está disponível [aqui](create_service.html).

Este tutorial supõe que você já tenha criado uma instância de serviço chamada
'`Cloudant Service 2017`'.

### Um aplicativo de banco de dados do {{site.data.keyword.cloudant_short_notm}}

Um tutorial separado para criar um aplicativo Python independente
para trabalhar com uma instância de serviço do {{site.data.keyword.cloudant_short_notm}}
está disponível [aqui](create_database.html).
Ele apresenta uma série de conceitos que são úteis para entender como criar e preencher um banco de dados do {{site.data.keyword.cloudant_short_notm}}.

Este tutorial supõe que você esteja familiarizado com esses conceitos.

## A próxima etapa

A próxima etapa no tutorial é [criar o ambiente de aplicativos](create_bmxapp_appenv.html).
