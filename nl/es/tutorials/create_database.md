---

copyright:
  years: 2017, 2019
lastupdated: "2019-06-12"

keywords: close connection, delete database, request ibm cloudant api endpoint, data retrieval, store data, create database, connect to ibm cloudant

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

# Cómo crear y llenar una base de datos de {{site.data.keyword.cloudant_short_notm}} sencilla en {{site.data.keyword.cloud_notm}}
{: #creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud}

En esta guía de aprendizaje se muestra cómo utilizar el [lenguaje de programación Python ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.python.org/){: new_window} para crear una base de datos de {{site.data.keyword.cloudantfull}} en la instancia de servicio de {{site.data.keyword.cloud_notm}} y llenar la base de datos con una sencilla colección de datos.
{: shortdesc}

## Requisitos previos
{: #prerequisites-create_database}

Asegúrese de tener los siguientes recursos o información preparados antes de empezar a trabajar con esta guía de aprendizaje.

### Python
{: #python-create-database}

Debe tener una instalación actualizada del [lenguaje de programación Python ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.python.org/){: new_window}
en su sistema.

Para comprobarlo, ejecute el siguiente mandato:

```sh
python --version
```
{: pre}

Debería obtener un resultado parecido al siguiente:

```
Python 2.7.12
```
{: codeblock}

### Biblioteca de cliente de Python para {{site.data.keyword.cloudant_short_notm}}
{: #python-client-library-for-ibm-cloudant}

Existe una [biblioteca oficialmente admitida](/docs/services/Cloudant?topic=cloudant-supported-client-libraries#python-supported) para permitir que las aplicaciones Python funcionen con {{site.data.keyword.cloudant_short_notm}} en {{site.data.keyword.cloud_notm}}. Utilice las instrucciones proporcionadas para instalarla. 

Para comprobar que ha instalado correctamente la biblioteca de cliente, ejecute el siguiente mandato:

```sh
pip freeze
```
{: pre}

Debería obtener una lista de todos los módulos de Python instalados en el sistema.
Examine la lista, buscando una entrada de {{site.data.keyword.cloudant_short_notm}} similar a la siguiente:

```
cloudant==2.3.1
```
{: codeblock}

### Creación de una instancia de servicio de {{site.data.keyword.cloudant_short_notm}} en {{site.data.keyword.cloud_notm}}
{: #creating-an-ibm-cloudant-service-instance-on-ibm-cloud}

El proceso para crear una instancia de servicio adecuada se describe en [esta guía de aprendizaje](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-an-ibm-cloudant-instance-on-ibm-cloud).

Asegúrese de tener disponibles las siguientes credenciales de servicio para su instancia de servicio:

Campo      | Finalidad
-----------|--------
`host`     | El nombre de host que utilizan las aplicaciones para localizar la instancia de servicio.
`username` | El nombre de usuario que necesitan las aplicaciones para acceder a la instancia de servicio.
`password` | La contraseña que necesitan las aplicaciones para acceder a la instancia de servicio.
`port`     | El número de puerto HTTP para acceder a la instancia de servicio en el host. Normalmente es 443 para forzar el acceso HTTPS.
`url`      | Una serie que agrega la otra información de credenciales en un URL único, adecuado para que lo utilicen las aplicaciones.

Para obtener más información sobre cómo buscar las credenciales de servicio para su instancia de servicio, consulte
[Localización de las credenciales de servicio](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#locating-your-service-credentials).

## Contexto
{: #context}

En esta guía de aprendizaje se creará una serie de instrucciones en lenguaje Python, adecuadas para las siguientes tareas:

1.  [Conectar con una instancia de servicio de {{site.data.keyword.cloudant_short_notm}} en {{site.data.keyword.cloud}}](#connecting-to-an-ibm-cloudant-service-instance-on-ibm-cloud).
2.  [Crear una base de datos dentro de la instancia de servicio](#creating-a-database-within-the-service-instance).
3.  [Almacenar una pequeña colección de datos como documentos dentro de la base de datos](#storing-a-small-collection-of-data-as-documents-within-the-database).
4.  [Recuperación de datos](#retrieving-data).
5.  [Suprimir la base de datos](#deleting-the-database).
6.  [Cerrar la conexión con la instancia de servicio](#closing-the-connection-to-the-service-instance).

En esta guía de aprendizaje se proporciona código de Python específico de cada tarea como parte de la descripción de la tarea.

Para obtener información sobre el programa Python completo para realizar todas las tareas, consulte el
[listado completo](#complete-listing).

En esta guía de aprendizaje no se pretende crear código Python _eficiente_; el objetivo es mostrar un código sencillo y fácil de comprender que funcione, con el que pueda aprender y que pueda aplicar a sus propias aplicaciones.

Tampoco se pretende realizar todas las comprobaciones posibles ni analizar todas las condiciones de error.
Aquí se muestran algunas comprobaciones de ejemplo para ilustrar las técnicas, pero debe aplicar las prácticas recomendadas habituales para comprobar y manejar todas las condiciones de aviso y de error que encuentren sus propias aplicaciones. 

## Conectar con una instancia de servicio de {{site.data.keyword.cloudant_short_notm}} en {{site.data.keyword.cloud_notm}}
{: #connecting-to-an-ibm-cloudant-service-instance-on-ibm-cloud}

Una aplicación Python necesita los componentes de la biblioteca de cliente de {{site.data.keyword.cloudant_short_notm}} para poder conectar con la instancia de servicio.
Estos componentes se identifican como sentencias `import` normales:

```python
from cloudant.client import Cloudant
from cloudant.error import CloudantException
from cloudant.result import Result, ResultByKey
```
{: codeblock}

La aplicación debe tener las [credenciales de servicio](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#locating-your-service-credentials) para el servicio:

```python
serviceUsername = "353466e8-47eb-45ce-b125-4a4e1b5a4f7e-bluemix"
servicePassword = "49c0c343d225623956157d94b25d574586f26d1211e8e589646b4713d5de4801"
serviceURL = "https://353466e8-47eb-45ce-b125-4a4e1b5a4f7e-bluemix.cloudant.com"
```
{: codeblock}

Las credenciales de servicio que se muestran aquí
    se han definido durante la creación del servicio {{site.data.keyword.cloudant_short_notm}} de demostración en {{site.data.keyword.cloud_notm}}.
    Aquí se reproducen las credenciales para mostrar cómo se utilizarían en una aplicación Python.
    Sin embargo, el servicio {{site.data.keyword.cloudant_short_notm}} de demostración se ha eliminado, de modo que _debe_ proporciona y usar sus propias credenciales de servicio.
{:  tip}

Cuando haya habilitado la biblioteca de cliente de Python en su aplicación e identificado las credenciales de servicio, puede establecer una conexión con la instancia de servicio:

```python
client = Cloudant(serviceUsername, servicePassword, url=serviceURL)
client.connect()
```
{: codeblock}

En este punto, la aplicación Python tiene acceso a la instancia de servicio en {{site.data.keyword.cloud_notm}}.

## Creación de una base de datos dentro de la instancia de servicio
{: #creating-a-database-within-the-service-instance}

El siguiente paso consiste en crear una base de datos dentro de la instancia de servicio, denominada `databasedemo`.

Para ello vamos a definir una variable en la aplicación Python:

```python
databaseName = "databasedemo"
```
{: codeblock}

Luego creamos la base de datos:

```python
myDatabaseDemo = client.create_database(databaseName)
```
{: codeblock}

Resulta útil comprobar que la base de datos se ha creado correctamente:

```python
if myDatabaseDemo.exists():
    print "'{0}' successfully created.\n".format(databaseName)
```
{: codeblock}

## Almacenamiento de una pequeña colección de datos como documentos dentro de la base de datos
{: #storing-a-small-collection-of-data-as-documents-within-the-database}

Ahora queremos almacenar una pequeña y sencilla colección de datos en la base de datos.

Empezamos por identificar algunos datos:

```python
sampleData = [
    [1, "one", "boiling", 100],
    [2, "two", "hot", 40],
    [3, "three", "warm", 20],
    [4, "four", "cold", 10],
    [5, "five", "freezing", 0]
]
```
{: codeblock}

A continuación, parte del código ordinario de Python 'recorre' los datos, convirtiéndolos en documentos JSON.
Cada documento se almacena en la base de datos:

```python
# Crear documentos utilizando los datos de ejemplo.
# Examinar cada fila de la matriz para el documento en sampleData:
# Recuperar los campos de cada fila.
    number = document[0]
    name = document[1]
    description = document[2]
    temperature = document[3]

    # Crear un documento JSON que represente todos
    # los datos de la fila.
    jsonDocument = {
        "numberField": number,
        "nameField": name,
        "descriptionField": description,
        "temperatureField": temperature
    }

    # Crear un documento utilizando la API de la base de datos.
    newDocument = myDatabaseDemo.create_document(jsonDocument)

    # Comprobar que el documento existe en la base de datos.
    if newDocument.exists():
        print "Document '{0}' successfully created.".format(number)
```
{: codeblock}

Observe que comprobamos que cada documento se ha creado correctamente.

## Recuperación de datos
{: #retrieving-data}

En este punto, una pequeña colección de datos se han almacenado como documentos en la base de datos.
Ahora podemos realizar una serie de consultas que ilustren distintas maneras de recuperar datos de la base de datos.

### Una recuperación mínima de un documento
{: #a-minimal-retrieval-of-a-document}

Para realizar una recuperación mínima, en primer lugar solicite una lista de todos los documentos de la base de datos.
Esta lista se devuelve como una matriz.
Ahora podemos mostrar el contenido de un elemento de la matriz.

En el código de ejemplo, solicitamos el primer documento recuperado de la base de datos:

```python
result_collection = Result(myDatabaseDemo.all_docs)
print "Retrieved minimal document:\n{0}\n".format(result_collection[0])
```
{: codeblock}

El resultado es parecido al del siguiente ejemplo:

```json
[
    {
        "value": {
            "rev": "1-b2c48b89f48f1dc172d4db3f17ff6b9a"
        },
        "id": "14746fe384c7e2f06f7295403df89187",
        "key": "14746fe384c7e2f06f7295403df89187"
    }
]
```
{: codeblock}

La naturaleza de bases de datos NoSQL,
    como {{site.data.keyword.cloudant_short_notm}}, implica que no necesariamente se aplican las nociones más sencillas, como que el primer documento almacenado en una base de datos es siempre el primer documento que se devuelve en una lista de resultados.
{: tip}

### Recuperación completa de un documento
{: #full-retrieval-of-a-document}

Para realizar una recuperación completa, solicitamos una lista de todos los documentos de la base de datos y además especificamos que también se debe devolver el contenido del documento.
Para ello utilizamos la opción `include_docs`.
Como antes, los resultados se devuelven como una matriz.
Ahora podemos mostrar los detalles de un elemento de la matriz, esta vez incluyendo el contenido completo del documento. 

Como antes, solicitamos el primer documento recuperado de la base de datos:

```python
result_collection = Result(myDatabaseDemo.all_docs, include_docs=True)
print "Retrieved minimal document:\n{0}\n".format(result_collection[0])
```
{: codeblock}

El resultado es parecido al del siguiente ejemplo:

```json
[
    {
        "value": {
          "rev": "1-b2c48b89f48f1dc172d4db3f17ff6b9a"
        },
            "id": "14746fe384c7e2f06f7295403df89187",
            "key": "14746fe384c7e2f06f7295403df89187",
            "doc": {
            "temperatureField": 10,
                "descriptionField": "cold",
                "numberField": 4,
                "nameField": "four",
                "_id": "14746fe384c7e2f06f7295403df89187",
                "_rev": "1-b2c48b89f48f1dc172d4db3f17ff6b9a"
            }
    }
]
```
{: codeblock}

## Llamada directa a un punto final de API de {{site.data.keyword.cloudant_short_notm}}
{: #calling-an-ibm-cloudant-api-endpoint-directly}

También podemos trabajar directamente con los puntos finales de la API de {{site.data.keyword.cloudant_short_notm}}, desde una aplicación Python.

En este código de ejemplo, volvemos a solicitar una lista de todos los documentos, incluido su contenido.
Esta vez, sin embargo, lo hacemos invocando el punto final [`/_all_docs`](/docs/services/Cloudant?topic=cloudant-databases#get-documents) de {{site.data.keyword.cloudant_short_notm}}.

En primer lugar identificamos el punto final con el que vamos a establecer contacto y los parámetros que se deben suministrar junto con la llamada:

```python
end_point = '{0}/{1}'.format(serviceURL, databaseName + "/_all_docs")
params = {'include_docs': 'true'}
```
{: codeblock}

A continuación enviamos la solicitud a la instancia de servicio y luego visualizamos los resultados:

```python
response = client.r_session.get(end_point, params=params)
print "{0}\n".format(response.json())
```
{: codeblock}

El resultado es parecido al del siguiente ejemplo _abreviado_:

```json
{
    "rows": [
        {
            "value": {
              "rev": "1-b2c48b89f48f1dc172d4db3f17ff6b9a"
            },
            "id": "14746fe384c7e2f06f7295403df89187",
            "key": "14746fe384c7e2f06f7295403df89187",
            "doc": {
                "temperatureField": 10,
                "descriptionField": "cold",
                "numberField": 4,
                "nameField": "four",
                "_id": "14746fe384c7e2f06f7295403df89187",
                "_rev": "1-b2c48b89f48f1dc172d4db3f17ff6b9a"
            }
        },
        ...
        {
            "value":
            {
              "rev": "1-7130413a8c7c5f1de5528fe4d373045c"
            },
            "id": "49baa66cc66b4dda86ffb2852ae78eb8",
            "key": "49baa66cc66b4dda86ffb2852ae78eb8",
            "doc": {
                "temperatureField": 40,
                "descriptionField": "hot",
                "numberField": 2,
                "nameField": "two",
                "_id": "49baa66cc66b4dda86ffb2852ae78eb8",
                "_rev": "1-7130413a8c7c5f1de5528fe4d373045c"
            }
        }
    ],
    "total_rows": 5,
    "offset": 0
}
```
{: codeblock}

## Supresión de la base de datos
{: #deleting-the-database}

Cuando hayamos terminado con la base de datos, la podemos suprimir.

Este es un paso sencillo, tal como se muestra en el siguiente código Python de ejemplo:

```python
try :
    client.delete_database(databaseName)
except CloudantException:
    print "There was a problem deleting '{0}'.\n".format(databaseName)
else:
    print "'{0}' successfully deleted.\n".format(databaseName)
```
{: codeblock}

Hemos incluido algún ejemplo de gestión de errores básicos para ilustrar cómo se pueden detectar y solucionar problemas.

## Cierre de la conexión con la instancia de servicio
{: #closing-the-connection-to-the-service-instance}

El paso final es desconectar la aplicación cliente Python de la instancia de servicio:

```python
client.disconnect()
```
{: codeblock}

## Listado completo
{: #complete-listing}

El código siguiente es el programa Python completo para acceder a una instancia de servicio de {{site.data.keyword.cloudant_short_notm}} en {{site.data.keyword.cloud_notm}} y realizar una típica serie de tareas:

1.  Conectar con la instancia de servicio.
2.  Crear una base de datos dentro de la instancia de servicio.
3.  Almacenar una pequeña colección de datos como documentos dentro de la base de datos.
4.  Recuperar una lista completa de documentos.
5.  Suprimir la base de datos.
6.  Cerrar la conexión con la instancia de servicio.

```python
# 1.  Conectar con la instancia de servicio.

# Habilitar las bibliotecas de Python necesarias.

from cloudant.client import Cloudant
from cloudant.error import CloudantException
from cloudant.result import Result, ResultByKey

# Variables útiles
serviceUsername = "353466e8-47eb-45ce-b125-4a4e1b5a4f7e-bluemix"
servicePassword = "49c0c343d225623956157d94b25d574586f26d1211e8e589646b4713d5de4801"
serviceURL = "https://353466e8-47eb-45ce-b125-4a4e1b5a4f7e-bluemix.cloudant.com"

# Este es el nombre de la base de datos con la que trabajamos.
databaseName = "databasedemo"

# Esta es una sencilla colección de datos
# que guardaremos en la base de datos.
sampleData = [
    [1, "one", "boiling", 100],
    [2, "two", "hot", 40],
    [3, "three", "warm", 20],
    [4, "four", "cold", 10],
    [5, "five", "freezing", 0]
]

# Iniciar la demo.
print "===\n"

# Utilizar la biblioteca de {{site.data.keyword.cloudant_short_notm}} para crear un cliente de {{site.data.keyword.cloudant_short_notm}}.
client = Cloudant(serviceUsername, servicePassword, url=serviceURL)

# Conectar con el servidor
client.connect()

# 2.  Crear una base de datos dentro de la instancia de servicio.

# Crear una instancia de la base de datos.
myDatabaseDemo = client.create_database(databaseName)

# Comprobar que ahora la base de datos existe.
if myDatabaseDemo.exists():
    print "'{0}' successfully created.\n".format(databaseName)

# Separar los resultados.
print "----\n"

# 3.  Almacenar una pequeña colección de datos como documentos dentro de la base de datos.

# Crear documentos utilizando los datos de ejemplo.
# Examinar cada fila de la matriz para el documento en sampleData:
# Recuperar los campos de cada fila.
    number = document[0]
    name = document[1]
    description = document[2]
    temperature = document[3]

    # Crear un documento JSON que represente todos
    # los datos de la fila.
    jsonDocument = {
        "numberField": number,
        "nameField": name,
        "descriptionField": description,
        "temperatureField": temperature
    }

    # Crear un documento utilizando la API de la base de datos.
    newDocument = myDatabaseDemo.create_document(jsonDocument)

    # Comprobar que el documento existe en la base de datos.
    if newDocument.exists():
        print "Document '{0}' successfully created.".format(number)

# Separar los resultados.
print "----\n"

# 4.  Recuperar una lista completa de documentos.

# Recuperación sencilla y mínima del primer
# documento de la base de datos.
result_collection = Result(myDatabaseDemo.all_docs)
print "Retrieved minimal document:\n{0}\n".format(result_collection[0])

# Recuperación sencilla y completa del primer
# documento de la base de datos.
result_collection = Result(myDatabaseDemo.all_docs, include_docs=True)
print "Retrieved full document:\n{0}\n".format(result_collection[0])

# Separar los resultados.
print "----\n"

# Utilizar un punto final de API de {{site.data.keyword.cloudant_short_notm}} para recuperar
# todos los documentos de la base de datos,
# incluido su contenido.

# Definir el punto final y los parámetros
end_point = '{0}/{1}'.format(serviceURL, databaseName + "/_all_docs")
params = {'include_docs': 'true'}

# Emitir la solicitud
response = client.r_session.get(end_point, params=params)

# Mostrar el contenido de la respuesta
print "{0}\n".format(response.json())

# Separar los resultados.
print "----\n"

# Todo finalizado.
# Ha llegado el momento de limpiar.

# 5.  Suprimir la base de datos.

# Suprimir la base de datos de prueba.
try :
    client.delete_database(databaseName)
except CloudantException:
    print "There was a problem deleting '{0}'.\n".format(databaseName)
else:
    print "'{0}' successfully deleted.\n".format(databaseName)

# 6.  Cerrar la conexión con la instancia de servicio.

# Desconectar del servidor
client.disconnect()

# Finalizar la demo.
print "===\n"

# Decir adiós.
exit()
```
{: codeblock}
