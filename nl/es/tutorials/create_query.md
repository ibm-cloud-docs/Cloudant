---

copyright:
  years: 2017, 2019
lastupdated: "2019-03-19"

keywords: create database, create documents, create index, create query, run query, fields, operators

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

# Creación de una consulta de {{site.data.keyword.cloudant_short_notm}}
{: #creating-an-ibm-cloudant-query}

En esta guía de aprendizaje se muestra cómo crear una base de datos, llenarla con documentos, crear un índice y utilizar el índice para consultar la base de datos.
{: shortdesc}

Se proporcionan ejercicios para la ![Icono de línea de mandatos](../images/CommandLineIcon.png) _línea de mandatos_
y el ![Icono de panel de control](../images/DashboardIcon.png) _{{site.data.keyword.cloud}} panel de control_. Los ejercicios del panel de control de {{site.data.keyword.cloud_notm}} muestran un ejemplo visual de cada tarea. Puede seguir los enlaces de la guía de aprendizaje para obtener más información.

Para empezar, cree la base de datos `query-demo` y algunos documentos que contengan los datos para estos ejercicios.

## Supuestos
{: ##assumptions}

Antes de empezar, siga estos pasos para prepararse para la guía de aprendizaje:

1.  [Cree una {{site.data.keyword.cloud_notm}} cuenta ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://cloud.ibm.com/registration){: new_window}.
2.  Inicie sesión en el [panel de control de {{site.data.keyword.cloud_notm}} ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://cloud.ibm.com/catalog/services/cloudant){: new_window}.
3.  [Cree una instancia de {{site.data.keyword.cloudant_short_notm}} en {{site.data.keyword.cloud_notm}}](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-a-service-instance).
4.  (Opcional) [Cree un alias acurl](/docs/services/Cloudant?topic=cloudant-authorized-curl-acurl-#authorized-curl-acurl-) para que sea más fácil y más rápido ejecutar mandatos desde la línea de mandatos.
5.  Sustituya la variable `$ACCOUNT` de los mandatos que figuran en los ejercicios por el nombre de usuario que utiliza para iniciar sesión en el panel de control de {{site.data.keyword.cloudant_short_notm}}.
  Si decide no configurar `acurl`, utilice el siguiente URL en lugar del que se proporciona en los ejercicios:
  ``` sh
  curl https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com/query-demo
  ```
  {: codeblock}

## Creación de la base de datos `query-demo`
{: #creating-the-query-demo-database}

En esta sección, creará la [base de datos](/docs/services/Cloudant?topic=cloudant-databases#create-database)
`query-demo`, que es la base de datos que utilizaremos en esta guía de aprendizaje.

En esta guía de aprendizaje, utilizamos el alias `acurl` en lugar del mandato `curl`. El alias `acurl` se crea siguiendo los pasos que se describen [aquí](docs/services/Cloudant?topic=cloudant-authorized-curl-acurl-#authorized-curl-acurl-). Si prefiere utilizar el mandato `curl` u otro método para invocar los puntos finales de la API, sustituya su mandato en la guía de aprendizaje, junto con los parámetros que necesite el mandato, como nombre de usuario y contraseña.
{: tip}

![Icono de línea de mandatos](../images/CommandLineIcon.png) _Línea de mandatos_

1.  Cree una base de datos con este mandato:
  ``` sh
  acurl https://$ACCOUNT.cloudant.com/query-demo -X PUT
  ```
  {: codeblock}
2.  Revise los resultados:
  ```json
  {
    "ok": true
  }
  ```
  {: codeblock}

![Icono de panel de control](../images/DashboardIcon.png) _Panel de control de {{site.data.keyword.cloud_notm}}_

1.  Abra la instancia de servicio de {{site.data.keyword.cloudant_short_notm}} que ha creado.
2.  En la página de servicio de {{site.data.keyword.cloudant_short_notm}}, pulse **Iniciar**.
    Se abrirá el separador Bases de datos.
    
  ![Separador Bases de datos](../images/tabs.png)
4.  Pulse **Crear base de datos**.
5.  Escriba `query-demo` y pulse **Crear**.

  Se abre automáticamente la base de datos `query-demo`.

## Creación de documentos en la base de datos
{: #creating-documents-in-the-database}

Los [documentos](/docs/services/Cloudant?topic=cloudant-documents#documents) que cree en este ejercicio contienen los datos que se utilizan para consultar la base de datos `consulta demo` en ejercicios posteriores.

![Icono de línea de mandatos](../images/CommandLineIcon.png) _Línea de mandatos_

1.  Copie el texto de ejemplo en un archivo de datos denominado `bulkcreate.dat` para crear cinco documentos:
  ```json
  {
    "docs":
    [
      {
        "_id": "doc1",
        "firstname": "Sally",
        "lastname": "Brown",
        "age": 16,
        "location": "New York City, NY"
      },
      {
        "_id": "doc2",
        "firstname": "John",
        "lastname": "Brown",
        "age": 21,
        "location": "New York City, NY"
      },
      {
        "_id": "doc3",
        "firstname": "Greg",
        "lastname": "Greene",
        "age": 35,
        "location": "San Diego, CA"
      },
      {
        "_id": "doc4",
        "firstname": "Anna",
        "lastname": "Greene",
        "age": 44,
        "location": "Baton Rouge, LA"
      },
      {
        "_id": "doc5",
        "firstname": "Lois",
        "lastname": "Brown",
        "age": 33,
        "location": "Syracuse, NY"
      }
    ]
  }
  ```
  {: codeblock}

2.  Ejecute este mandato para crear los documentos:
  ```sh
  acurl https://$ACCOUNT.cloudant.com/query-demo/_bulk_docs -X POST -H "Content-Type: application/json" -d \@bulkcreate.dat
  ```
  {: codeblock}

Observe que el símbolo '`@`', que se utiliza para indicar que los datos se incluyen en un archivo, se identifica mediante el nombre proporcionado.
{: tip}

3.  Revise los resultados:
  ```json
  [
    {
      "ok":true,
      "id":"doc1",
      "rev":"1-57a08e644ca8c1bb8d8931240427162e"
    },
    {
      "ok":true,
      "id":"doc2",
      "rev":"1-bf51eef712165a9999a52a97e2209ac0"
    },
    {
      "ok":true,
      "id":"doc3",
      "rev":"1-9c9f9b893fcdd1cbe09420bc4e62cc71"
    },
    {
      "ok":true,
      "id":"doc4",
      "rev":"1-6aa4873443ddce569b27ab35d7bf78a2"
    },
    {
      "ok":true,
      "id":"doc5",
      "rev":"1-d881d863052cd9681650773206c0d65a"
    }
  ]
  ```
  {: codeblock}

![Icono de panel de control](../images/DashboardIcon.png) _Panel de control de {{site.data.keyword.cloud_notm}}_

1.  Pulse **`+`** y seleccione **Nuevo doc**. Se abre la ventana 'Nuevo documento'.
2.  Para crear un documento, copie el texto de ejemplo siguiente y sustituya el texto existente en el nuevo documento.

  _Primer documento de ejemplo_:
  ```json
  {
    "firstname": "Sally",
    "lastname": "Brown",
    "age": 16,
    "location": "New York City, NY",
    "_id": "doc1"
  }
  ```
  {: codeblock}

3.  Repita el paso 2 para añadir los documentos restantes a la base de datos.

  _Segundo documento de ejemplo_:
  ```json
  {
    "firstname": "John",
    "lastname": "Brown",
    "age": 21,
    "location": "New York City, NY",
    "_id": "doc2"
  }
  ```
  {: codeblock}

  _Tercer documento de ejemplo_:
  ```json
  {
    "firstname": "Greg",
    "lastname": "Greene",
    "age": 35,
    "location": "San Diego, CA",
    "_id": "doc3"
  }
  ```
  {: codeblock}

  _Cuarto documento de ejemplo_:
  ```json
  {
    "firstname": "Anna",
    "lastname": "Greene",
    "age": 44,
    "location": "Baton Rouge, LA",
    "_id": "doc4"
  }
  ```
  {: codeblock}

  _Quinto documento de ejemplo_:
  ```json
  {
    "firstname": "Lois",
    "lastname": "Brown",
    "age": 33,
    "location": "New York City, NY",
    "_id": "doc5"
  }
  ```
  {: codeblock}

  La base de datos `query-demo` se ha rellenado con cinco registros. Puede ver los registros desde la vista Tabla en la siguiente captura de pantalla:

  ![Documentos de ejemplo](../images/docs1.png)     

## Creación de un índice para consultar la base de datos
{: #creating-an-index-to-query-the-database}

{{site.data.keyword.cloudant_short_notm}} proporciona vistas e índices para consultar la base de datos. Una vista ejecuta una consulta que se guarda en la base de datos, y el resultado se denomina el conjunto de resultados. Cuando se envía una consulta a la vista, la consulta busca el conjunto de resultados. Un índice constituye una forma de estructurar los datos que mejora el tiempo de recuperación.

Utilizaremos {{site.data.keyword.cloudant_short_notm}} Query en esta guía de aprendizaje, que utiliza una sintaxis de consultas similar a Mongo para buscar documentos utilizando operadores lógicos. {{site.data.keyword.cloudant_short_notm}} Query es una combinación de una vista y un índice de búsqueda.

Al utilizar {{site.data.keyword.cloudant_short_notm}} Query, el planificador de consultas mira el selector (su consulta) para determinar el índice correcto en el que elegir. Si no encuentra ningún índice adecuado, utilizará el índice especial
`_all_docs`, que busca documentos por ID. En el peor caso, devolverá todos los documentos por ID (exploración de tabla completa). En la memoria, filtraremos los documentos mediante el selector, lo cual es el motivo por el que, incluso sin un índice, puede seguir realizando consultas con diversos campos. Las exploraciones de tabla completas son costosas y se recomienda crear un índice. Puede ver una descripción de los distintos tipos de índices en la lista siguiente:

*	Índice primario – buscar un documento o lista de documentos por ID.  
*	[Vista](/docs/services/Cloudant?topic=cloudant-views-mapreduce#views-mapreduce) – buscar en la base de datos información que coincida con los criterios de búsqueda que especifique, como recuentos, sumas, promedios y otras funciones matemáticas. Los criterios de búsqueda se pueden especificar en la definición de la vista. Las vistas utilizan el paradigma MapReduce.
*	[Índice de búsqueda](/docs/services/Cloudant?topic=cloudant-search#search) – buscar uno o varios campos, grandes cantidades de texto o utilizar caracteres comodín, búsqueda aproximada o facetas con la [sintaxis del analizador de consultas de Lucene ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://lucene.apache.org/core/4_3_0/queryparser/org/apache/lucene/queryparser/classic/package-summary.html#Overview){: new_window}.

Si no hay ningún índice definido disponible que coincida con la consulta especificada, {{site.data.keyword.cloudant_short_notm}}
utiliza el índice `_all_docs`.
{: tip}


![Icono de línea de mandatos](../images/CommandLineIcon.png) _Línea de mandatos_

1.  Copie los siguientes datos JSON de ejemplo en un archivo llamado `query-index.dat`.
  ```json
{
	"index": {
		"fields": [
			"age",
			"lastname"
		],
		"partial_filter_selector": {
			"age": {
				"$gte": 30
			},
			"lastname": {
				"$eq": "Greene"
			}
		}
	},
  		"ddoc": "partial-index",
		"type": "json"
}
  ```
  {: codeblock}

2.  Ejecute el siguiente mandato para crear un índice:
  ```sh
  acurl https://$ACCOUNT.cloudant.com/query-demo/_index -X POST -H "Content-Type: application/json" -d \@query-index.dat
  ```
  {: codeblock}

3.  Revise los resultados:
  ```json
  {
    "result":"created",
    "id":"_design/752c7031f3eaee0f907d18e1424ad387459bfc1d",
    "name":"query-index"
  }
  ```
  {: codeblock}



![Icono de panel de control](../images/DashboardIcon.png) _Panel de control de {{site.data.keyword.cloud_notm}}_

1.  Pulse **`+` > Índices de búsqueda** en el separador **Todos los documentos** o **Documentos de diseño**.
2.  Pegue los siguientes datos JSON de ejemplo en el campo **Índice**:
  ```json
  {
	"index": {
		"fields": [
			"age",
			"lastname"
		],
		"partial_filter_selector": {
			"age": {
				"$gte": 30
			},
			"lastname": {
				"$eq": "Greene"
			}
		}
	},
  		"ddoc": "partial-index",
		"type": "json"
  }
  ```
  {: codeblock}

  Se ha creado el índice. Puede ver el índice en la siguiente captura de pantalla:

  ![Índice de búsqueda](../images/query-index1.png)



## Creación de una consulta
{: #creating-a-query}

Las consultas le permiten extraer datos de {{site.data.keyword.cloudant_short_notm}}. Un [consulta](/docs/services/Cloudant?topic=cloudant-query#query) bien escrita puede delimitar la búsqueda y sus resultados de modo que solo incluyan los datos que desea.

En este ejercicio se muestra cómo escribir y ejecutar una consulta sencilla, cómo buscar con dos campos y cómo buscar con dos [operadores](/docs/services/Cloudant?topic=cloudant-query#operators).
Para realizar una búsqueda con un operador, especifique al menos un campo y su valor correspondiente.
La consulta utiliza este valor para buscar coincidencias en la base de datos.

Para consultas que no sean la más sencilla, añada JSON a un campo de datos y ejecútelas desde la línea de mandatos.

### Ejecución de una consulta sencilla
{: #running-a-simple-query}

En este ejemplo se muestra cómo utiliza {{site.data.keyword.cloudant_short_notm}} Query `query-index` para buscar `lastname` y cómo filtra los resultados en memoria para buscar `firstname`.   

![Icono de línea de mandatos](../images/CommandLineIcon.png) _Línea de mandatos_

1.  Copie los siguientes datos JSON de ejemplo en un archivo llamado `query1.dat`.
  ```json
    {
      "selector": {
            "lastname" : "Greene",
            "firstname" : "Anna"
         }
    }       
  ```    
  {: codeblock}

2.  Ejecute el siguiente mandato para consultar la base de datos:
  ```sh
  acurl https://$ACCOUNT.cloudant.com/query-demo/_find -X POST -H "Content-Type: application/json" -d \@query1.dat
  ```
  {: codeblock}

3.  Revise los resultados de la consulta:
  ```json
  {
    "docs": [
      {
        "_id":"doc4",
        "_rev":"3-751ab049e8b5dd1ba045cea010a33a72",
            "firstname":"Anna",
            "lastname":"Greene",
            "age":44,
            "location":"Baton Rouge, LA"
      }
    ]
  }
  ```
  {: codeblock}

![Icono de panel de control](../images/DashboardIcon.png) _Panel de control de {{site.data.keyword.cloud_notm}}_

1.  Pulse el separador **Consulta**.
2.  Copie y pegue los siguientes datos JSON de ejemplo en la ventana de {{site.data.keyword.cloudant_short_notm}} Query:
  ```json
   {
      "selector": {
            "lastname" : "Greene",
            "firstname" : "Anna"
         }
   }
  ```
  {: codeblock}

3.  Pulse **Ejecutar consulta**.

  Se muestran los resultados de la consulta. Puede verlos desde la vista Tabla en la siguiente captura de pantalla:

  ![Resultados de la consulta 1](../images/dashboard_query1_results.png)

### Ejecución de una consulta con dos campos
{: #running-a-query-with-two-fields}

En este ejemplo se utilizan dos campos para buscar todos los que se llaman `Brown` y viven en `New York City, NY`.

Para describir la búsqueda, utilizamos una [expresión 'selector'](/docs/services/Cloudant?topic=cloudant-query#selector-syntax)
parecida a la del siguiente ejemplo:
```json
  {
    "selector": {
      "lastname": "Brown",
      "location": "New York City, NY"
    }
  }
```
{: codeblock}

Podemos adaptar los resultados para que se ajusten a nuestras necesidades añadiendo más detalles en la expresión del selector.
El parámetro `fields` especifica los campos que se deben incluir en los resultados. En nuestro ejemplo, los resultados incluyen nombre (firstname), apellido (lastname) y ubicación (location). Los resultados están ordenados por nombre en orden ascendente en función de los valores del parámetro `sort`.
Los detalles adicionales se parecen a los del siguiente ejemplo:
```json
{
  ...
  "fields" : [
    "firstname",
      "lastname",
      "location"
  ]
}
```  
{: codeblock}

![Icono de línea de mandatos](../images/CommandLineIcon.png) _Línea de mandatos_

1.  Copie los datos JSON de ejemplo en un archivo llamado `query2.dat`.
  ```json
  {
    "selector": {
      "lastname": "Brown",
      "location": "New York City, NY"
    },
    "fields": [
     "firstname",
     "lastname",
     "location"
  ]
  }
  ```
  {: codeblock}

2.  Ejecute el siguiente mandato para consultar la base de datos:
  ```sh
  acurl https://$ACCOUNT.cloudant.com/query-demo/_find -X POST -H "Content-Type: application/json" -d \@query2.dat
  ```
  {: codeblock}

3.  Revise los resultados de la consulta:
  ```json
  {
    "docs": [
      {
        "firstname": "Sally",
        "lastname": "Brown",
        "location": "New York City, NY"
      },
      {
        "firstname": "John",
        "lastname": "Brown",
        "location": "New York City, NY"
      },
      {
        "firstname": "Lois",
        "lastname": "Brown",
        "location": "New York City, NY"
      }
    ]
  }
  ```
  {: codeblock}

![Icono de panel de control](../images/DashboardIcon.png) _Panel de control de {{site.data.keyword.cloud_notm}}_

1.  Pulse el separador **Consulta**.
2.  Copie y pegue los siguientes datos JSON de ejemplo en la ventana de {{site.data.keyword.cloudant_short_notm}} Query:
  ```json
  {
    "selector": {
      "lastname": "Brown",
      "location": "New York City, NY"
    },
    "fields": [
      "firstname",
      "lastname",
      "location"
    ] 
  }
  ```
  {: codeblock}

3.  Pulse **Ejecutar consulta**.

  Se muestran los resultados de la consulta. Puede verlos desde la vista Tabla en la siguiente captura de pantalla:

  ![Resultados de la consulta 2](../images/dashboard_query2_results.png)

### Ejecución de una consulta con operadores
{: #running-a-query-with-operators}

En este ejemplo, se utilizan los operadores `$eq` (igual a) y `$gt` (mayor que) para buscar los documentos que contienen el apellido `Greene` y una edad superior a `30`.

Utilizamos una expresión de selector como la del siguiente ejemplo:
```json
{
  "selector": {
    "age": {
      "$gt": 30
    },
    "lastname": {
      "$eq": "Greene"
    }
  }
}
``` 
{: codeblock}

Los resultados están ordenados por antigüedad en orden ascendente en función de los
valores especificados en el parámetro `sort`.

```json
    "sort": [
      {
        "age": "asc"   
      }
    ] 
```  
{: codeblock}

![Icono de línea de mandatos](../images/CommandLineIcon.png) _Línea de mandatos_

1.  Copie los siguientes datos JSON de ejemplo en un archivo llamado `query3.dat`.
  ```json
  {
   "selector": {
      "age": {
         "$gt": 30
      },
      "lastname": {
         "$eq": "Greene"
      }
   },
    "fields": [
      "age",
      "firstname"
   ],
    "sort": [
      {
         "age": "asc"   
      }
   ],
   "use_index": "_design/partial-index"
  }
  ```
  {: codeblock}

2. Ejecute esta consulta:
  ```sh
  acurl https://$ACCOUNT.cloudant.com/query-demo/_find -X POST -H "Content-Type: application/json" -d \@query3.dat
  ```
  {: codeblock}

3.  Revise los resultados de la consulta:
  ```json
  {"docs":[
     {"age":35,"firstname":"Greg"},
     {"age":44,"firstname":"Anna"}
   ],
  "bookmark": "g1AAAABCeJzLYWBgYMpgSmHgKy5JLCrJTq2MT8lPzkzJBYqzAFkmIDkOmFwOSHWiDkiSzb0oNTUvNSsLAEsmEeQ"
  }
  ```
  {: codeblock}

![Icono de panel de control](../images/DashboardIcon.png) _Panel de control de {{site.data.keyword.cloud_notm}}_

1.  Pulse el separador **Consulta**.
2.  Copie y pegue los siguientes datos JSON de ejemplo en la ventana de {{site.data.keyword.cloudant_short_notm}} Query:
  ```json
  {
   "selector": {
      "age": {
         "$gt": 30
      },
      "lastname": {
         "$eq": "Greene"
      }
   },
    "fields": [
      "age",
      "firstname"
   ],
    "sort": [
      {
         "age": "asc"   
      }
   ],
   "use_index": "_design/partial-index"
  }
  ```
  {: codeblock}

3.  Pulse **Ejecutar consulta**.

  Se muestran los resultados de la consulta. Puede verlos desde la vista Tabla en la siguiente captura de pantalla:

  ![Resultados de la consulta 3](../images/dashboard_query3_results.png)

Para obtener más información sobre {{site.data.keyword.cloudant_short_notm}}, consulte la [documentación de {{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant?topic=cloudant-overview#overview).
