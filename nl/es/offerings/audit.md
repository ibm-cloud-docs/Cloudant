---

copyright:
  years: 2015, 2018
lastupdated: "2018-10-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:tip: .tip}

<!-- Acrolinx: 2017-05-10 -->

# Registro de auditoría


El registro de auditoría registra los principales de {{site.data.keyword.cloudantfull}} que han
accedido a los datos almacenados en {{site.data.keyword.cloudant_short_notm}}. Para todo el acceso de la API HTTP
a {{site.data.keyword.cloudant_short_notm}}, la función de registro de auditoría
registra la siguiente información sobre cada solicitud HTTP:

Información | Descripción
------------|------------
`Principal` | Credenciales de cuenta, clave de API o credenciales de IAM de IBM Cloud.
`Acción` | La acción llevada a cabo (por ejemplo, lectura de documento).
`Recurso` | Detalles sobre la cuenta, la base de datos y el documento al que se ha accedido o del que se ha realizado una consulta.
`Indicación de fecha y hora` | Un registro de la hora y de los datos del suceso. 

Los registros de auditoría de {{site.data.keyword.cloudant_short_notm}} se pueden utilizar para comprender:

- Qué y cuándo se ha accedido a las bases de datos y a los documentos dentro de una cuenta, y quién.
- Qué y cuándo se han ejecutado las consultas y quién lo ha hecho.
- Qué principal o usuario específico ha accedido, actualizado o suprimido, y cuándo.
- Qué y cuándo se han creado o suprimido documentos de réplica.
{:shortdesc}

## Cómo acceder a registros de auditoría para su cuenta

Para solicitar el acceso a los registros de auditoría para la cuenta, póngase en contacto
con el soporte de {{site.data.keyword.cloudant_short_notm}}. El soporte proporciona una copia de los registros de auditoria que son de interés para usted.

Al ponerse en contacto con el soporte, asegúrese de incluir:

- La cuenta de {{site.data.keyword.cloudant_short_notm}} a la que se relaciona la solicitud.
- El periodo de tiempo para los registros de auditoría (no debe ser superior a un mes por solicitud de soporte).
- Cualquier base de datos, documento o principal específico de su interés.
