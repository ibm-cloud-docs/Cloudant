---

copyright:
  years: 2017, 2019
lastupdated: "2019-03-19"

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

# Creación de una aplicación sencilla de {{site.data.keyword.cloud_notm}} para acceder a una base de datos de {{site.data.keyword.cloudant_short_notm}}: requisitos previos
{: #creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites}

En esta sección de la guía de aprendizaje se describen los requisitos previos para crear una aplicación de {{site.data.keyword.cloud}}.
{: shortdesc}

## Requisitos previos
{: #prerequisites}

Asegúrese de tener los siguientes recursos o información preparados antes de empezar a trabajar con esta guía de aprendizaje.

### Python
{: #python-create-bmxapp-prereq}

Para todo menos para el trabajo de desarrollo más simple posible, es mucho más sencillo si tiene una instalación actualizada del [lenguaje de programación Python ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.python.org/){: new_window} en su sistema.

Para comprobarlo, ejecute el siguiente mandato:

```sh
python --version
```
{: pre}

El resultado se debería parecer al siguiente:

```
Python 2.7.12
```
{: codeblock}

### Una instancia de servicio de {{site.data.keyword.cloudant_short_notm}} en {{site.data.keyword.cloud_notm}}
{: #an-ibm-cloudant-service-instance-on-ibm-cloud}

Puede consultar otra guía de aprendizaje para crear una instancia de servicio de {{site.data.keyword.cloudantfull}} denominada '`Cloudant-o7`' [aquí](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-an-ibm-cloudant-instance-on-ibm-cloud).

En esta guía se presupone que ya ha creado una instancia de servicio denominada '`Cloudant-o7`'.

### Una aplicación de base de datos de {{site.data.keyword.cloudant_short_notm}}
{: #an-ibm-cloudant-database-application}

Puede consultar otra guía de aprendizaje para crear una aplicación Python autónoma
para trabajar con una instancia de servicio de {{site.data.keyword.cloudant_short_notm}}
[aquí](/docs/services/Cloudant?topic=cloudant-creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud#creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud).
Contiene una introducción a diversos conceptos que resultan útiles para comprender cómo se crea y se llena una base de datos de {{site.data.keyword.cloudant_short_notm}}.

En esta guía presupone que está familiarizado con dichos conceptos.

El siguiente paso de esta guía de aprendizaje es [crear el entorno de aplicación](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment).
