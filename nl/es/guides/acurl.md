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

# Curl autorizado: `acurl`

_(Esta guía se basa en un artículo del blog de Samantha Scharr: [
"Authorized curl, a.k.a. acurl" ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://cloudant.com/blog/authorized-curl-a-k-a-acurl/){:new_window},
publicado por primera vez el 27 de noviembre de 2013)._

`acurl` es un alias práctico que le permite ejecutar por `curl` mandatos de {{site.data.keyword.cloudantfull}} a URL sin tener que escribir su nombre y contraseña en cada solicitud.
Esto significa que un simple `GET` emitido a una base de datos ya no se tiene que escribir como `https://$ACCOUNT:$PASSWORD@$ACCOUNT.cloudant.com/foo`, sino como `https://$ACCOUNT.cloudant.com/foo`.

Esto no solo evita la incomodidad de escribir URL largos, sino que el alias `acurl` también ofrece mayor seguridad.
Evita que alguien pueda leer su contraseña mientras la escribe y, lo que es más importante, garantiza que su contraseña no se envía como texto sin formato sobre la red al imponer el uso de HTTPS.

Solo hay que seguir tres sencillos pasos:

1.	[Codifique su nombre de usuario y su contraseña](#encode-username-and-password).
2.	[Cree un alias](#create-an-alias)
3.	[Active el alias](#activate-the-alias).

Si está utilizando un ordenador Windows, puede especificar el nombre de usuario y la contraseña desde la línea de mandatos.
{:tip}

## Codifique el nombre de usuario y contraseña

Primero, codificamos en base64 el nombre de usuario y contraseña de {{site.data.keyword.cloudant_short_notm}}.
Esto nos devuelve una secuencia de caracteres base64.

El mandato para codificar datos en base64 es parecido al del siguiente ejemplo:

```python
python -c 'import base64; print base64.urlsafe_b64encode("$ACCOUNT:$PASSWORD")'
```
{:codeblock}

Supongamos que la salida es `<OUTPUT-OF-BASE64>`.

Por ejemplo, si utiliza el mandato:

```python
python -c 'import base64; print base64.urlsafe_b64encode("$ACCOUNT:$PASSWORD")'
```
{:codeblock}

Obtendrá la siguiente salida:

```
bXl1c2VybmFtZTpteXBhc3N3b3Jk
```
{:codeblock}

>	**Nota**: Recuerde que su contraseña sigue guardada en texto sin formato en su sistema; codificar en base64 _no_ equivale a cifrar.
	Si utiliza la codificación base64 en la misma secuencia de caracteres, siempre obtendrá la misma secuencia de salida de los caracteres correspondientes.

## Crear un alias

Ahora crearemos un alias para `curl` que incluirá credenciales para que no tengamos que especificarlas cada vez que escribimos un mandato `curl`.

Añada la siguiente línea a `~/.bashrc` o `~/.bash_profile`:

```sh
alias acurl="curl -s --proto '=https' -g -H 'Authorization: Basic <OUTPUT-OF-BASE64>'"
```
{:codeblock}

Este alias añade una cabecera de autorización en lugar de incluir las credenciales de autorización en el URL que especifique en la línea de mandatos.
También impone el uso de HTTPS, que recomendamos encarecidamente sobre HTTP sin formato, ya que cifra los datos y las credenciales en tránsito y le ayuda a asegurarse de que está conectando con sistemas {{site.data.keyword.cloudant_short_notm}}.

## Activar el alias

Ahora inicie un nuevo shell o ejecute `source ~/.bash_profile` (o `~/.bashrc` si lo utiliza) para que el alias sea funcional.

## Probar `acurl`

Ahora nos vamos a asegurar de que todo se ha configurado correctamente.
Ejecute el siguiente mandato:

```sh
acurl https://$ACCOUNT.cloudant.com/_all_dbs
```
{:codeblock}

Si obtiene una lista de sus bases de datos, ¡estupendo!; significa que
`acurl` está configurado y listo para ser utilizado.

¡Que tenga una feliz codificación!
