---

copyright:
  years: 2017, 2018
lastupdated: "2017-11-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-01-10 -->

# Creación de una aplicación sencilla de {{site.data.keyword.Bluemix_notm}} para acceder a una base de datos de {{site.data.keyword.cloudant_short_notm}}: requisitos previos

En esta sección de la guía de aprendizaje se describen los requisitos previos para crear una aplicación de {{site.data.keyword.Bluemix}}.
{:shortdesc}

## Requisitos previos

Asegúrese de tener los siguientes recursos o información preparados antes de empezar a trabajar con esta guía de aprendizaje.

### Python

Para todo menos para el trabajo de desarrollo más simple posible, es mucho más sencillo si tiene una instalación actualizada del [lenguaje de programación Python![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.python.org/){:new_window}
en su sistema.

Para comprobarlo, ejecute el siguiente mandato:

```sh
python --version
```
{:pre}

El resultado se debería parecer al siguiente:

```
Python 2.7.12
```
{:codeblock}

<div id="csi"></div>

### Una instancia de servicio de {{site.data.keyword.cloudant_short_notm}} en {{site.data.keyword.Bluemix_notm}}

Puede consultar otra guía de aprendizaje para crear una instancia de servicio de {{site.data.keyword.cloudantfull}} denominada '`Cloudant Service 2017`' [aquí](create_service.html).

En esta guía se presupone que ya ha creado una instancia de servicio denominada '`Cloudant Service 2017`'.

### Una aplicación de base de datos de {{site.data.keyword.cloudant_short_notm}}

Puede consultar otra guía de aprendizaje para crear una aplicación Python autónoma
para trabajar con una instancia de servicio de {{site.data.keyword.cloudant_short_notm}}
[aquí](create_database.html).
Contiene una introducción a diversos conceptos que resultan útiles para comprender cómo se crea y se llena una base de datos de {{site.data.keyword.cloudant_short_notm}}.

En esta guía presupone que está familiarizado con dichos conceptos.

## El paso siguiente

El siguiente paso de esta guía de aprendizaje es [crear el entorno de aplicación](create_bmxapp_appenv.html).
