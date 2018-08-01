---

copyright:
  years: 2015, 2018
lastupdated: "2018-06-08"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:tip: .tip}

<!-- Acrolinx: 2017-04-28 -->

# Guía de aprendizaje de iniciación
{: #getting-started-with-cloudant}

En esta guía de aprendizaje de iniciación de {{site.data.keyword.cloudantfull}} utilizaremos
Python para crear una base de datos {{site.data.keyword.cloudant_short_notm}} y llenaremos la base de datos con una sencilla colección de datos.
{:shortdesc}

Además de esta guía de aprendizaje, consulte nuestras guías de aprendizaje prácticas que le ayudan a obtener más información sobre {{site.data.keyword.cloudant_short_notm}}. O bien, pruebe una de las guías de aprendizaje que se centre en un idioma específico:

- [Liberty for Java y {{site.data.keyword.cloudant_short_notm}} ![Icono de enlace externo](images/launch-glyph.svg "Icono de enlace externo")](https://console.bluemix.net/docs/runtimes/liberty/getting-started.html#getting-started-tutorial){:new_window}
- [Node.js y {{site.data.keyword.cloudant_short_notm}} ![Icono de enlace externo](images/launch-glyph.svg "Icono de enlace externo")](https://console.bluemix.net/docs/runtimes/nodejs/getting-started.html#getting-started-tutorial){:new_window}
- [Swift y {{site.data.keyword.cloudant_short_notm}} ![Icono de enlace externo](images/launch-glyph.svg "Icono de enlace externo")](https://console.bluemix.net/docs/runtimes/swift/getting-started.html#getting-started-tutorial){:new_window}

Para obtener más guías de aprendizaje específicas de cada idioma, consulte [Empiece desplegando su primera app ![Icono de enlace externo](images/launch-glyph.svg "Icono de enlace externo")](https://console.bluemix.net/docs/){:new_window}. 

<div id="prerequisites"></div>

## Antes de empezar
{: #prereqs}

Necesitará una [cuenta de Bluemix ![Icono de enlace externo](images/launch-glyph.svg "Icono de enlace externo")](https://console.ng.bluemix.net/registration/){:new_window},
una instancia del servicio {{site.data.keyword.cloudant}} y los siguientes requisitos de Python:

*	Instale la última versión del
	[lenguaje de programación Python ![Icono de enlace externo](images/launch-glyph.svg "Icono de enlace externo")](https://www.python.org/){:new_window} en su sistema.
	
	Para comprobarlo, ejecute el siguiente mandato:
	```sh
	python --version
	```
	{:pre}
	
	Debería obtener un resultado parecido al siguiente:

	```
	Python 2.7.12
	```
	{:screen}

*	Instale la [biblioteca de Python](libraries/supported.html#python)
	para que sus aplicaciones Python puedan trabajar con {{site.data.keyword.cloudant_short_notm}} en {{site.data.keyword.Bluemix_notm}}.
	
	Para comprobar que ha instalado correctamente la biblioteca de cliente, ejecute el siguiente mandato:
	```sh
	pip freeze
	```
	{:pre}
	
	Debería obtener una lista de todos los módulos de Python instalados en el sistema. Examine la lista, buscando una entrada de {{site.data.keyword.cloudant_short_notm}} similar a la siguiente:

	```
	cloudant==2.3.1
	```
	{:screen}
	
	Si el módulo `cloudant` no está instalado, instálelo con un mandato parecido al siguiente:
	
	```
	pip install cloudant==2.3.1
	```
	{:pre}

## Paso 1: Conectar con la instancia del servicio {{site.data.keyword.cloudant_short_notm}} en {{site.data.keyword.Bluemix_notm}}

1.	Ejecute las siguientes sentencias '`import`' de los componentes de la biblioteca de cliente de {{site.data.keyword.cloudant_short_notm}} para permitir que
la aplicación Python se conecte con la instancia de servicio de {{site.data.keyword.cloudant_short_notm}}.
	```python
	from cloudant.client import Cloudant
	from cloudant.error import CloudantException
	from cloudant.result import Result, ResultByKey
	```
	{: codeblock}

2. Identifique las credenciales de servicio de {{site.data.keyword.cloudant_short_notm}}:
  1. En la consola de {{site.data.keyword.Bluemix_notm}}, abra el panel de control correspondiente a la instancia de servicio.
  2. En el panel de navegación izquierdo, pulse **`Credenciales de servicio`**.
  3. Pulse **`Ver credenciales`** bajo **`ACCIONES`**.

3.	Establezca una conexión con la instancia de servicio ejecutando el mandato siguiente.
	Sustituya las credenciales de servicio del paso anterior:
	```python
	client = Cloudant("<username>", "<password>", url="<url>")
	client.connect()
	```
	{: codeblock}


## Paso 2: Crear una base de datos

1. Defina una variable en la aplicación Python:
  ```python
  databaseName = "<yourDatabaseName>"
  ```
  {: codeblock}
  ... donde `<yourDatabaseName>` es el nombre que desea asignar a la base de datos. 

  > **Nota:** La base de datos debe comenzar por una letra y solo puede incluir caracteres en minúsculas (a-z), valores numéricos (0-9) y cualquiera de los siguientes caracteres `_`, `$`, `(`, `)`, `+`, `-` y `/`.

2. Cree la base de datos:
  ```python
  myDatabase = client.create_database(databaseName)
  ```
  {: codeblock}

3. Confirme que la base de datos se ha creado correctamente:
  ```python
  if myDatabase.exists():
      print "'{0}' successfully created.\n".format(databaseName)
  ```
  {: codeblock}

## Paso 3: Almacenar una pequeña colección de datos como documentos dentro de la base de datos

1. Defina una colección de datos:
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

2. Utilice el código Python para 'recorrer' los datos y convertirlos en documentos JSON.
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
    newDocument = myDatabase.create_document(jsonDocument)

    # Comprobar que el documento existe en la base de datos.
    if newDocument.exists():
        print "Document '{0}' successfully created.".format(number)
  ```
  {: codeblock}

Tenga en cuenta que realizamos comprobaciones para asegurarnos de que cada documento se ha creado satisfactoriamente.
{: tip}

## Paso 4: Recuperar de datos mediante consultas

En este punto, una pequeña colección de datos se han almacenado como documentos en la base de datos.
Puede realizar una recuperación mínima o completa de dichos datos de la base de datos.
Una recuperación mínima obtiene los datos básicos _sobre_ un documento.
Una recuperación completa también incluye los datos _incluidos_ en un documento.

* Para realizar una recuperación mínima:
  1. En primer lugar, solicite una lista de todos los documentos de la base de datos.
    ```python
    result_collection = Result(myDatabase.all_docs)
    ```      
    {: codeblock}

    Esta lista se devuelve como una matriz.

  2. Muestre el contenido de un elemento de la matriz.
    ```python
    print "Retrieved minimal document:\n{0}\n".format(result_collection[0])
    ```
    {: codeblock}

    El resultado es parecido al del
siguiente ejemplo:
    
    ```
    [{u'value': {u'rev': u'1-106e76a2612ea13468b2f243ea75c9b1'}, u'id': u'14be111aac74534cf8d390eaa57db888', u'key': u'14be111aac74534cf8d390eaa57db888'}]
    ```
    {:screen}
    
    > **Nota:** El prefijo `u'` es simplemente una indicación de que Python está mostrando una serie Unicode. 
    
    Si organizamos un poco el aspecto, veremos que los detalles del documento mínimo que hemos obtenido equivalen a lo siguiente:
    
    ```json
    [
        {
            "value": {
                "rev": "1-106e76a2612ea13468b2f243ea75c9b1"
            },
            "id": "14be111aac74534cf8d390eaa57db888",
            "key": "14be111aac74534cf8d390eaa57db888"
        }
    ]
    ```
    {: codeblock}

  > **Nota:** Las nociones simples, como que el primer documento almacenado en una base de datos sea siempre
  el primero devuelto en una lista de resultados, no siempre se aplican a bases de datos NoSQL como
  {{site.data.keyword.cloudant_short_notm}}.

* Para realizar una recuperación completa,
  solicite una lista de todos los documentos de la base de datos e indique que también se debe devolver el contenido del documento especificando la opción `include_docs`.
  ```python
  result_collection = Result(myDatabase.all_docs, include_docs=True)
  print "Documento completo recuperado:\n{0}\n".format(result_collection[0])
  ```
  {: codeblock}
  
  El resultado es parecido al del
siguiente ejemplo:
  ```
  [{u'value': {u'rev': u'1-7130413a8c7c5f1de5528fe4d373045c'}, u'id': u'0cfc7d902f613d5fdb7b7818e262353b', u'key': u'0cfc7d902f613d5fdb7b7818e262353b', u'doc': {u'temperatureField': 40, u'descriptionField': u'hot', u'numberField': 2, u'nameField': u'two', u'_id': u'0cfc7d902f613d5fdb7b7818e262353b', u'_rev': u'1-7130413a8c7c5f1de5528fe4d373045c'}}]
  ```
  {: screen}
  
  Si organizamos un poco el aspecto, veremos que los detalles del documento completo que hemos obtenido equivalen a lo siguiente:
  
  ```json
  [
    {
      "value": {
        "rev": "1-7130413a8c7c5f1de5528fe4d373045c
      },
      "id": "0cfc7d902f613d5fdb7b7818e262353b",
      "key": "0cfc7d902f613d5fdb7b7818e262353b",
      "doc": {
        "temperatureField": 40,
        "descriptionField": "hot",
        "numberField": 2,
        "nameField": "two",
        "_id": "0cfc7d902f613d5fdb7b7818e262353b",
        "_rev": "1-7130413a8c7c5f1de5528fe4d373045c"
      }
    }
  ]
  ```
  {: codeblock}

## Paso 5: Recuperar datos a través del punto final de la API de {{site.data.keyword.cloudant_short_notm}}

También puede solicitar una lista de todos los documentos y su contenido invocando el [punto final `/_all_docs` de {{site.data.keyword.cloudant_short_notm}}](api/database.html#get-documents).

1. Identifique el punto final con el que va a establecer contacto y los parámetros que se deben suministrar junto con la llamada:
  ```python
  end_point = '{0}/{1}'.format("<url>", databaseName + "/_all_docs")
  params = {'include_docs': 'true'}
  ```
  {: codeblock}
  ... donde `<url>` es el valor de URL de las credenciales de servicio que ha encontrado en el paso 1.

2. Envíe la solicitud a la instancia de servicio y luego visualice los resultados:
  ```python
  response = client.r_session.get(end_point, params=params)
  print "{0}\n".format(response.json())
  ```
  {: codeblock}

  El resultado es parecido al del siguiente ejemplo _abreviado_:
  
  ```
  {u'rows': [{u'value': {u'rev': u'1-6d8cb5905316bf3dbe4075f30daa9f59'}, u'id': u'0532feb6fd6180d79b842d871316c444', u'key': u'0532feb6fd6180d79b842d871316c444', u'doc': {u'temperatureField': 20, u'descriptionField': u'warm', u'numberField': 3, u'nameField': u'three', u'_id': u'0532feb6fd6180d79b842d871316c444', u'_rev': u'1-6d8cb5905316bf3dbe4075f30daa9f59'}}, ... , {u'value': {u'rev': u'1-3f61736fa96473d358365ce1665e3d97'}, u'id': u'db396f77bbe12a567b09177b4accbdbc', u'key': u'db396f77bbe12a567b09177b4accbdbc', u'doc': {u'temperatureField': 0, u'descriptionField': u'freezing', u'numberField': 5, u'nameField': u'five', u'_id': u'db396f77bbe12a567b09177b4accbdbc', u'_rev': u'1-3f61736fa96473d358365ce1665e3d97'}}], u'total_rows': 5, u'offset': 0}
  ```
  {:screen}
  
  Podemos organizar un poco el aspecto y ver que los detalles _abreviados_ que hemos obtenido se parecen a lo siguiente:
  
  ```json
  {
      "rows": [
          {
              "value": {
                "rev": "1-6d8cb5905316bf3dbe4075f30daa9f59"
              },
              "id": "0532feb6fd6180d79b842d871316c444",
              "key": "0532feb6fd6180d79b842d871316c444",
              "doc": {
                  "temperatureField": 20,
                  "descriptionField": "warm",
                  "numberField": 3,
                  "nameField": "three",
                  "_id": "0532feb6fd6180d79b842d871316c444",
                  "_rev": "1-6d8cb5905316bf3dbe4075f30daa9f59"
              }
          },
          ...
          {
              "value":
              {
                "rev": "1-6d8cb5905316bf3dbe4075f30daa9f59"
              },
              "id": "db396f77bbe12a567b09177b4accbdbc",
              "key": "db396f77bbe12a567b09177b4accbdbc",
              "doc": {
                  "temperatureField": 0,
                  "descriptionField": "freezing",
                  "numberField": 5,
                  "nameField": "five",
                  "_id": "db396f77bbe12a567b09177b4accbdbc",
                  "_rev": "1-6d8cb5905316bf3dbe4075f30daa9f59"
              }
          }
      ],
      "total_rows": 5,
      "offset": 0
  }
  ```
  {: codeblock}

## Paso 6: Suprimir la base de datos

Cuando haya terminado con la base de datos, ya la puede suprimir.

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

## Paso 7: Cerrar la conexión con la instancia del servicio

El paso final es desconectar la aplicación cliente Python de la instancia de servicio:

```python
client.disconnect()
```
{: codeblock}

## Siguientes pasos

Para obtener más información sobre todas las ofertas de {{site.data.keyword.cloudant_short_notm}}, consulte el sitio principal de [{{site.data.keyword.cloudant_short_notm}} ![Icono de enlace externo](images/launch-glyph.svg "Icono de enlace externo")](http://www.ibm.com/analytics/us/en/technology/cloud-data-services/cloudant/){:new_window}.

Para ver más detalles y las guías de aprendizaje sobre conceptos, tareas y técnicas de {{site.data.keyword.cloudant_short_notm}}, consulte la [documentación de {{site.data.keyword.cloudant_short_notm}}](cloudant.html).

## Apéndice: Listado completo del código Python

El listado completo del código Python es el siguiente.
Recuerde sustituir los valores `<username>`,
`<password>`
y `<url>` por sus credenciales de servicio.
Paralelamente, sustituya el valor `<yourDatabaseName>` por el nombre de su base de datos.

```python
from cloudant.client import Cloudant
from cloudant.error import CloudantException
from cloudant.result import Result, ResultByKey

client = Cloudant("<username>", "<password>", url="<url>")
client.connect()

databaseName = "<yourDatabaseName>"

myDatabase = client.create_database(databaseName)

if myDatabase.exists():
      print "'{0}' successfully created.\n".format(databaseName)

sampleData = [
    [1, "one", "boiling", 100],
    [2, "two", "hot", 40],
    [3, "three", "warm", 20],
    [4, "four", "cold", 10],
    [5, "five", "freezing", 0]
]

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
    newDocument = myDatabase.create_document(jsonDocument)

    # Comprobar que el documento existe en la base de datos.
    if newDocument.exists():
        print "Document '{0}' successfully created.".format(number)

result_collection = Result(myDatabase.all_docs)

print "Documento mínimo recuperado:\n{0}\n".format(result_collection[0])

result_collection = Result(myDatabase.all_docs, include_docs=True)
print "Documento completo recuperado:\n{0}\n".format(result_collection[0])

end_point = '{0}/{1}'.format("<url>", databaseName + "/_all_docs")
params = {'include_docs': 'true'}
response = client.r_session.get(end_point, params=params)
print "{0}\n".format(response.json())


try :
    client.delete_database(databaseName)
except CloudantException:
    print "There was a problem deleting '{0}'.\n".format(databaseName)
else:
    print "'{0}' successfully deleted.\n".format(databaseName)

client.disconnect()

```
{: codeblock}
