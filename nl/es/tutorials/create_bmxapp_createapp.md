---

copyright:
  years: 2017, 2018
lastupdated: "2018-03-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-01-11 -->

# Creación de una aplicación sencilla de {{site.data.keyword.cloud_notm}} para acceder a una base de datos de {{site.data.keyword.cloudant_short_notm}}: el código

En esta sección de la guía de aprendizaje se describe el código correspondiente a una aplicación de {{site.data.keyword.Bluemix}}.
{:shortdesc}

<div id="theApp"></div>

## Creación de la aplicación

Dispone de los siguientes componentes, listos para empezar a crear la aplicación:

-   [El lenguaje de programación Python](create_bmxapp_prereq.html#python).
-   [Una instancia de base de datos de {{site.data.keyword.cloudant_short_notm}}](create_bmxapp_prereq.html#csi).
-   [Un entorno de aplicación de {{site.data.keyword.Bluemix_notm}}](create_bmxapp_appenv.html#creating).
-   Una [conexión](create_bmxapp_appenv.html#connecting) entre la instancia de base de datos de {{site.data.keyword.cloudant_short_notm}} y el entorno de aplicación de {{site.data.keyword.Bluemix_notm}}.
-   Los [kits de herramientas](create_bmxapp_appenv.html#toolkits) para gestionar las aplicaciones {{site.data.keyword.Bluemix_notm}} basadas en Cloud Foundry.
-   Un [paquete de aplicación 'de inicio'](create_bmxapp_appenv.html#starter), que contiene la configuración inicial y archivos de plantilla de código.

>   **Nota**: En esta guía de aprendizaje no se pretende crear código Python _eficiente_.
    La finalidad es mostrar un código sencillo y fácil de comprender que funcione, con el que pueda aprender y que pueda aplicar a sus propias aplicaciones.
    Tampoco se pretende realizar todas las comprobaciones posibles ni analizar todas las condiciones de error.
    Se incluyen algunas comprobaciones de ejemplo para ilustrar algunas de las técnicas.
    En sus aplicaciones debe comprobar y analizar todas las condiciones de aviso o de error.

### Archivos esenciales

La aplicación necesita tres archivos de configuración y un archivo de origen, todos disponibles en el [paquete de aplicación 'de inicio'](create_bmxapp_appenv.html#starter):
 
-   ['`Procfile`'](create_bmxapp_appenv.html#procfile)
-   ['`manifest.yml`'](create_bmxapp_appenv.html#manifest)
-   ['`requirements.txt`'](create_bmxapp_appenv.html#requirements)
-   El archivo de origen de la aplicación, que se describe en esta sección de la guía de aprendizaje.

Modifique los archivos de configuración de la siguiente manera:

1.  Edite el archivo '`Procfile`' para que contenga el texto siguiente:
    ```
    web: python server.py
    ```
    {:codeblock}

2.  Edite el archivo '`manifest.yml`' para que contenga el texto siguiente:
    ```
    applications:
    - path: .
      memory: 128M
      instances: 1
      domain: <your domain>
      name: <your application name>
      host: <your application host>
      disk_quota: 1024M
      services:
      - <your database instance>
    ```
    {:codeblock}
    >   **Nota**: Asegúrese de modificar los valores de '`domain`', '`name`', '`host`' y '`services`'. Son los valores especificados cuando se creó el [entorno de aplicación de {{site.data.keyword.Bluemix_notm}}](create_bmxapp_appenv.html#creating) y la [instancia de base de datos de {{site.data.keyword.cloudant_short_notm}}](create_bmxapp_prereq.html#csi).

3.  Edite el archivo '`requirements.txt`' para que contenga el texto siguiente:
    ```
    cloudant==2.3.1
    ```
    {:codeblock}

### El código de la aplicación

El siguiente paso consiste en trabajar en el código de la aplicación.
Se describe cada sección y se presenta el código.
Al final de esta sección de la guía de aprendizaje encontrará un [listado completo](#complete-listing) del código de la aplicación.

#### Iniciación

La aplicación Python necesita algunos componentes básicos para funcionar.
Se importan de la siguiente manera:

```python
# Dejar disponibles los módulos de Python.
import os
import json

# Esto resulta útil para tener acceso a herramientas
# para formatear valores de fecha y hora.
from time import gmtime, strftime
```
{:codeblock}

La aplicación funciona como un sencillo servidor web, mostrando una sola página: un registro que contiene los resultados de conectar con la instancia de la base de datos de {{site.data.keyword.cloudant_short_notm}} y de crear una base de datos.

La aplicación necesita componentes para poder servir una página web:

```python
# Simplificar el acceso a herramientas básicas de servidor web de Python.
try:
    from SimpleHTTPServer import SimpleHTTPRequestHandler as Handler
    from SocketServer import TCPServer as Server
except ImportError:
    from http.server import SimpleHTTPRequestHandler as Handler
    from http.server import HTTPServer as Server
```
{:codeblock}

>   **Nota**: Este segmento de código se suministra como parte del [paquete de aplicación 'de inicio'](create_bmxapp_appenv.html#starter).

La aplicación se conecta a la instancia de la base de datos de {{site.data.keyword.cloudant_short_notm}}, por lo que debe importar los componentes de la biblioteca de {{site.data.keyword.cloudant_short_notm}}:

```python
# Habilitar las bibliotecas de Python necesarias para trabajar en {{site.data.keyword.cloudant_short_notm}}.
from cloudant.client import Cloudant
from cloudant.error import CloudantException
from cloudant.result import Result, ResultByKey
```
{:codeblock}

La aplicación crea una base de datos dentro de la instancia de la base de datos de {{site.data.keyword.cloudant_short_notm}}.
Se necesita un nombre para la base de datos:

```python
# Este es el nombre de la base de datos que queremos crear.
databaseName = "databasedemo"
```
{:codeblock}

La aplicación registra el progreso a medida que se conecta a la instancia de la base de datos de {{site.data.keyword.cloudant_short_notm}} y crea la base de datos.
El registro adopta la forma de un archivo de registro, que se almacena en una carpeta a la que puede acceder el servidor web Python.

Cree una carpeta (denominada '`static`' en la aplicación) y prepárela para que almacene un archivo:

```python
# Cambiar el directorio actual para no exponer los archivos de control
try:
    os.mkdir('static')
except OSError:
    # El directorio ya existe,
    # no es necesario crearlo.
    pass
os.chdir('static')
```
{:codeblock}

A continuación, cree un archivo HTML sencillo.
El archivo contendrá el registro de cada actividad a medida que la aplicación crea la base de datos:

```python
# Empezar a crear una página web muy sencilla.
filename = "index.html"
target = open(filename, 'w')
target.truncate()
target.write("<html><head><title>Demo de {{site.data.keyword.cloudant_short_notm}} Python</title></head><body><p>Registro de los pasos de Cloudant Python...</p><pre>")
```
{:codeblock}

La primera parte del registro es un registro de la fecha y hora actuales.
Este registro ayuda a confirmar que la base de datos creada es nueva:

```python
# Colocar una indicación clara de la fecha y hora actuales en la parte superior de la página.
target.write("====\n")
target.write(strftime("%Y-%m-%d %H:%M:%S", gmtime()))
target.write("\n====\n\n")
```
{:codeblock}

#### Cómo trabajar con una instancia de la base de datos de {{site.data.keyword.cloudant_short_notm}}

La aplicación Python se ejecuta en un entorno de aplicación de {{site.data.keyword.Bluemix_notm}}.
El entorno proporciona toda la información necesaria para que la aplicación acceda a los servicios conectados.
La información se proporciona en una variable de entorno denominada '`VCAP_SERVICES`'.
La aplicación puede acceder a esta variable y utilizarla para determinar los detalles de la conexión.

La primera tarea consiste en asegurarse de que la aplicación se está ejecutando dentro del entorno de aplicación de {{site.data.keyword.Bluemix_notm}}.
Para ello compruebe si existe la variable de entorno '`VCAP_SERVICES`':

```python
# Comprobar que se está ejecutando en un entorno de aplicación de {{site.data.keyword.cloud_notm}}.
if 'VCAP_SERVICES' in os.environ:
```
{:codeblock}

>   **Nota**: Las siguientes secciones de código solo se ejecutan si se ha encontrado la variable de entorno.
    En Python, este código está sangrado para indicar que es el cuerpo de la prueba.
    En esta guía de aprendizaje, se omite la sangría de los segmentos de código para ahorrar espacio.
    Sin embargo, en el [listado completo](#complete-listing) se muestra la sangría correctamente.

Suponiendo que la variable se ha encontrado, se procederá a utilizar la información.
Empiece cargando los datos JSON que almacenados en la variable y registrando el suceso en el nuevo 'archivo de registro':

```python
# Comprobado; obtener la información de servicio.
vcap_servicesData = json.loads(os.environ['VCAP_SERVICES'])
# Registrar que se ha encontrado correctamente cierta información de servicio.
target.write("Got vcap_servicesData\n")
```
{:codeblock}

A continuación, busque información sobre la instancia de base de datos de {{site.data.keyword.cloudant_short_notm}} conectada.
Nuevamente, registre el suceso en el 'archivo de registro':

```python
# Buscar la instancia de servicio de {{site.data.keyword.cloudant_short_notm}}.
cloudantNoSQLDBData = vcap_servicesData['cloudantNoSQLDB']
# Registrar que se ha encontrado correctamente cierta información de servicio de {{site.data.keyword.cloudant_short_notm}}.
target.write("Got cloudantNoSQLDBData\n")
```
{:codeblock}

Es posible que haya varios servicios de {{site.data.keyword.Bluemix_notm}} conectados al entorno de aplicación.
Las credenciales de cada servicio se muestran como elementos de una matriz.
En esta guía de aprendizaje, solo [se ha creado una conexión de servicio](create_bmxapp_appenv.html#connecting).
Por lo tanto, la aplicación accede al primer elemento (elemento 'cero').
Cada elemento de servicio contiene las credenciales correspondientes a dicho servicio, expresadas como una lista indexada por los nombres de campo esenciales que se necesitan para acceder al servicio.
Encontrará más información sobre los nombres de los campos en la [guía de aprendizaje](create_database.html#a-cloudant-service-instance-on-bluemix) que describe una tarea de ejemplo de creación de una base de datos.

```python
# Obtener una lista que contenga la información de conexión de {{site.data.keyword.cloudant_short_notm}}.
credentials = cloudantNoSQLDBData[0]
# Obtener los valores esenciales para que nuestra aplicación se comunique con el servicio.
credentialsData = credentials['credentials']
# Registrar que se han encontrado correctamente los valores de {{site.data.keyword.cloudant_short_notm}}.
target.write("Got credentialsData\n\n")
```
{:codeblock}

A continuación, examine la lista y recupere los valores esenciales:

```python
# Obtener el nombre de usuario ...
serviceUsername = credentialsData['username']
target.write("Got username: ")
target.write(serviceUsername)
target.write("\n")
# ... la contraseña ...
servicePassword = credentialsData['password']
target.write("Got password: ")
target.write(servicePassword)
target.write("\n")
# ... y el URL del servicio dentro de Bluemix.
serviceURL = credentialsData['url']
target.write("Got URL: ")
target.write(serviceURL)
target.write("\n")
```
{:codeblock}

Ahora la aplicación tiene todos los detalles necesarios para crear una base de datos dentro de la instancia de base de datos de {{site.data.keyword.cloudant_short_notm}}.
Esta tarea se describe con más detalle en la [guía de aprendizaje](create_database.html#a-cloudant-service-instance-on-bluemix) que describe la creación de una base de datos sencilla.

La aplicación debe realizar estas tareas:

1.  Establece una conexión con la instancia de base de datos.
2.  Crea una base de datos con el nombre proporcionado [anteriormente](#getting-started).
3.  Crea un documento JSON que contiene la fecha y hora actuales.
4.  Almacena el documento JSON en la base de datos.
5.  Confirma que el documento se ha almacenado de forma segura.
6.  Cierra la conexión con la instancia de base de datos.

El código correspondiente a estas tareas es el siguiente:

```python
# Ahora tenemos todos los detalles necesarios para trabajar con la instancia de servicio de {{site.data.keyword.cloudant_short_notm}}.
# Conectar con la instancia de servicio.
client = Cloudant(serviceUsername, servicePassword, url=serviceURL)
client.connect()
# Crear una base de datos dentro de la instancia.
myDatabaseDemo = client.create_database(databaseName)
if myDatabaseDemo.exists():
    target.write("'{0}' successfully created.\n".format(databaseName))
    # Crear un documento JSON muy sencillo con la fecha y hora actuales.
    jsonDocument = {
        "rightNow": strftime("%Y-%m-%d %H:%M:%S", gmtime())
    }
    # Almacenar el documento JSON en la base de datos.
    newDocument = myDatabaseDemo.create_document(jsonDocument)
    if newDocument.exists():
        target.write("Document successfully created.\n")
# Ya está todo hecho - desconectar de la instancia de servicio.
client.disconnect()
```
{:codeblock}

#### Cómo cerrar el archivo de registro

El siguiente paso consiste en cerrar el archivo de registro, listo para servirlo utilizando un servidor web Python simple dentro de la aplicación:

```python
# Colocar otra indicación clara de la fecha y hora actuales en la parte inferior de la página.
target.write("\n====\n")
target.write(strftime("%Y-%m-%d %H:%M:%S", gmtime()))
target.write("\n====\n")
# Terminar de crear la página web.
target.write("</pre></body></html>")
target.close()
```
{:codeblock}

#### Cómo servir el archivo de registro

La última tarea consiste iniciar el servidor web dentro de la aplicación Python.
La única finalidad del servidor es devolver el archivo de registro bajo demanda.
Este archivo de registro confirma que la aplicación Python ha completado correctamente las siguientes tareas:

1.  Se ha ejecutado correctamente en el entorno de aplicación de {{site.data.keyword.Bluemix_notm}}.
2.  Ha determinado los detalles de las conexiones de servicio.
3.  Ha conectado con una instancia de base de datos de {{site.data.keyword.cloudant_short_notm}}.
4.  Ha creado una base de datos.
5.  Ha creado un documento dentro de la base de datos.
6.  Ha respondido con el registro de sucesos cuando se ha solicitado.

El código para iniciar el servidor web Python se incluye como parte del [paquete de aplicación 'de inicio'](create_bmxapp_appenv.html#starter):

```python
# Iniciar la aplicación de servidor web Python sencilla
# para que pueda 'servir' nuestra página web recién creada.
PORT = int(os.getenv('PORT', 8000))
httpd = Server(("", PORT), Handler)
try:
  print("Start serving at port %i" % PORT)
  httpd.serve_forever()
except KeyboardInterrupt:
  pass
httpd.server_close()
```
{:codeblock}

## El paso siguiente

El siguiente paso de esta guía de aprendizaje es [cargar la aplicación](create_bmxapp_upload.html) para probarla.

## Listado completo

El código siguiente es el programa Python completo para acceder a una instancia de servicio de {{site.data.keyword.cloudant_short_notm}} en {{site.data.keyword.Bluemix_notm}}:

```python
# Dejar disponibles los módulos de Python.
import os
import json

# Esto resulta útil para tener acceso a herramientas
# para formatear valores de fecha y hora.
from time import gmtime, strftime

# Simplificar el acceso a herramientas básicas de servidor web de Python.
try:
    from SimpleHTTPServer import SimpleHTTPRequestHandler as Handler
    from SocketServer import TCPServer as Server
except ImportError:
    from http.server import SimpleHTTPRequestHandler as Handler
    from http.server import HTTPServer as Server

# Habilitar las bibliotecas de Python necesarias para trabajar en {{site.data.keyword.cloudant_short_notm}}.
from cloudant.client import Cloudant
from cloudant.error import CloudantException
from cloudant.result import Result, ResultByKey

# Este es el nombre de la base de datos que queremos crear.
databaseName = "databasedemo"

# Cambiar el directorio actual para no exponer los archivos de control
try:
    os.mkdir('static')
except OSError:
    # El directorio ya existe,
    # no es necesario crearlo.
    pass
os.chdir('static')

# Empezar a crear una página web muy sencilla.
filename = "index.html"
target = open(filename, 'w')
target.truncate()
target.write("<html><head><title>Demo de Python de Cloudant</title></head><body><p>Registro de los pasos de {{site.data.keyword.cloudant_short_notm}} Python...</p><pre>")

# Colocar una indicación clara de la fecha y hora actuales en la parte superior de la página.
target.write("====\n")
target.write(strftime("%Y-%m-%d %H:%M:%S", gmtime()))
target.write("\n====\n\n")

# Empezar a trabajar con la instancia de servicio de {{site.data.keyword.cloudant_short_notm}}.

# Comprobar que se está ejecutando en un entorno de aplicación de Bluemix.
if 'VCAP_SERVICES' in os.environ:
    # Comprobado; obtener la información de servicio.
    vcap_servicesData = json.loads(os.environ['VCAP_SERVICES'])
    # Registrar que se ha encontrado correctamente cierta información de servicio.
    target.write("Got vcap_servicesData\n")
    # Buscar la instancia de servicio de {{site.data.keyword.cloudant_short_notm}}.
    cloudantNoSQLDBData = vcap_servicesData['cloudantNoSQLDB']
    # Registrar que se ha encontrado correctamente cierta información de servicio de {{site.data.keyword.cloudant_short_notm}}.
    target.write("Got cloudantNoSQLDBData\n")
    # Obtener una lista que contenga la información de conexión de {{site.data.keyword.cloudant_short_notm}}.
    credentials = cloudantNoSQLDBData[0]
    # Obtener los valores esenciales para que nuestra aplicación se comunique con el servicio.
    credentialsData = credentials['credentials']
    # Registrar que se han encontrado correctamente los valores de {{site.data.keyword.cloudant_short_notm}}.
    target.write("Got credentialsData\n\n")
    # Obtener el nombre de usuario...
    serviceUsername = credentialsData['username']
    target.write("Got username: ")
    target.write(serviceUsername)
    target.write("\n")
    # ... la contraseña ...
    servicePassword = credentialsData['password']
    target.write("Got password: ")
    target.write(servicePassword)
    target.write("\n")
    # ... y el URL del servicio dentro de Bluemix.
    serviceURL = credentialsData['url']
    target.write("Got URL: ")
    target.write(serviceURL)
    target.write("\n")

    # Ahora tenemos todos los detalles necesarios para trabajar con la instancia de servicio de {{site.data.keyword.cloudant_short_notm}}.
    # Conectar con la instancia de servicio.
    client = Cloudant(serviceUsername, servicePassword, url=serviceURL)
    client.connect()
    # Crear una base de datos dentro de la instancia.
    myDatabaseDemo = client.create_database(databaseName)
    if myDatabaseDemo.exists():
        target.write("'{0}' successfully created.\n".format(databaseName))
        # Crear un documento JSON muy sencillo con la fecha y hora actuales.
        jsonDocument = {
            "rightNow": strftime("%Y-%m-%d %H:%M:%S", gmtime())
        }
        # Almacenar el documento JSON en la base de datos.
        newDocument = myDatabaseDemo.create_document(jsonDocument)
        if newDocument.exists():
            target.write("Document successfully created.\n")
    # Ya está todo hecho - desconectar de la instancia de servicio.
    client.disconnect()

# Colocar otra indicación clara de la fecha y hora actuales en la parte inferior de la página.
target.write("\n====\n")
target.write(strftime("%Y-%m-%d %H:%M:%S", gmtime()))
target.write("\n====\n")
# Terminar de crear la página web.
target.write("</pre></body></html>")
target.close()

# Iniciar la aplicación de servidor web Python sencilla
# para que pueda 'servir' nuestra página web recién creada.
PORT = int(os.getenv('PORT', 8000))
httpd = Server(("", PORT), Handler)
try:
  print("Start serving at port %i" % PORT)
  httpd.serve_forever()
except KeyboardInterrupt:
  pass
httpd.server_close()
```
{:codeblock}
