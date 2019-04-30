---

copyright:
  years: 2015, 2019
lastupdated: "2019-03-15"

keywords: generate uuid, record payments, add additional documents, advantages

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

# Agrupación de documentos relacionados en {{site.data.keyword.cloudant_short_notm}}
{: grouping-related-documents-together-in-ibm-cloudant}

Tradicionalmente, los sistemas de comercio electrónico se basan en bases de datos relacionales.
Estas bases de datos suelen utilizar varias tablas unidas para registrar ventas, detalles de los clientes, productos comprados e información sobre el seguimiento de las entregas.
Las bases de datos relacionales ofrecen un alto nivel de coherencia, lo que significa que los desarrolladores de aplicaciones pueden basar sus aplicaciones en las sólidas funciones de la base de datos, que incluyen el uso de uniones entre colecciones, enumeraciones para registrar el estado de un objeto y transacciones de bases de datos para garantizar las operaciones atómicas.

{{site.data.keyword.cloudantfull}} da prioridad a la disponibilidad frente a la coherencia.
Es una base de datos distribuida de alta disponibilidad con tolerancia de errores que es finalmente coherente.
Esto ofrece la ventaja de que el servicio de compra del cliente siempre está disponible y es lo suficientemente escalable como para abarcar varios usuarios que realizan compras al mismo tiempo.
Esto significa que la aplicación puede utilizar las ventajas de {{site.data.keyword.cloudant_short_notm}} y no tratarlo como una base de datos relacional.

En este tema se describen algunos de los factores que intervienen en la creación de un sistema de comercio electrónico que aprovecha las ventajas de {{site.data.keyword.cloudant_short_notm}}, utilizando conceptos que se pueden aplicar a muchos otros dominios, como por ejemplo:

-   Utilización de varios documentos para representar el estado de una compra en lugar de tener que actualizar con frecuencia un solo documento.
-   Almacenamiento de copias de objetos relacionados en orden en lugar de unirlas a otra colección.
-   Creación de vistas para intercalar documentos mediante `order_id` para reflejar el estado actual de una compra.

Por ejemplo, puede crear un documento `purchase` que contenga detalles como los artículos solicitados, información sobre el cliente, coste e información sobre la entrega.

_Ejemplo de documento que describe una compra_

```json
{
    "_id": "023f7a21dbe8a4177a2816e4ad1ea27e",
    "type": "purchase",
    "order_id": "320afa89017426b994162ab004ce3383",
    "basket": [
        {
            "product_id": "A56",
            "title": "Adele - 25",
            "category": "Audio CD",
            "price": 8.33,
            "tax": 0.2,
            "quantity": 2
        },
        {
            "product_id": "B32",
            "title": "The Lady In The Van - Alan Bennett",
            "category": "Paperback book",
            "price": 3.49,
            "tax": 0,
            "quantity": 2
        }
    ],
    "account_id": "985522332",
    "delivery": {
        "option": "Next Day",
        "price": 2.99,
        "address": {
            "street": "17 Front Street",
            "town": "Middlemarch",
            "postcode": "W1A 1AA"
        }
    },
    "pretax" : 20.15,
    "tax" : 3.32,
    "total": 26.46
}
```
{: codeblock}

Este documento contiene suficientes datos para que un registro de compra muestre un resumen de un pedido en una página web o un correo electrónico sin tener que capturar registros adicionales.
Observe los detalles clave sobre el pedido, en especial:

-   La cesta contiene varios ID de referencia (`product_id`) a una base de datos de productos almacenados en otro lugar.
-   La cesta duplica algunos de los datos de los productos en este registro, suficientes para registrar el estado de los artículos adquiridos en el punto de venta.
-   El documento no contiene campos que marquen el estado del pedido.
    Se deberían añadir documentos adicionales posteriormente para registrar pagos y entregas.
-   La base de datos genera automáticamente un `_id` de documento cuando inserta el documento en la base de datos.
-   Se suministra un identificador exclusivo (`order_id`) con cada registro de pedido para hacer referencia al pedido posteriormente. 
 
Cuando el cliente realiza un pedido, en el momento en que se entra en la fase de "extracción" en el sitio web, se crea un registro de orden de compra parecido al del ejemplo anterior. 

## Generación de sus propios identificadores exclusivos (UUID)
{: #generating-your-own-unique-identifiers-uuids-}

En una base de datos relacional suelen utilizarse números secuenciales que se "incrementan automáticamente", pero en las bases de datos distribuidas, en las que los datos están distribuidos en un clúster de servidores, se utilizan UUID más largos para garantizar que los documentos se almacenan con su propio ID exclusivo.

Para crear un identificador exclusivo para utilizarlo en la aplicación, como por ejemplo `order_id`, llame al [punto final `GET _uuids`](/docs/services/Cloudant?topic=cloudant-advanced-api#-get-_uuids-) en la API de {{site.data.keyword.cloudant_short_notm}}.
La base de datos genera automáticamente un identificador.
Se puede utilizar el mismo punto final para generar varios ID añadiendo el parámetro `count`, por ejemplo `/_uuids?count=10`.

## Registro de pagos
{: #recording-payments}

Cuando el cliente paga correctamente los artículos, se añaden registros adicionales a la base de datos para registrar el pedido.

_Ejemplo de registro de pago:_

```json
{
    "_id": "bf70c30ea5d8c3cd088fef98ad678e9e",
    "type": "payment",
    "account_id": "985522332",
    "order_id": "320afa89017426b994162ab004ce3383",
    "value": 6.46,
    "method": "credit card",
    "payment_reference": "AB9977G244FF2F667"
}
...
{
    "_id": "12c0ea6cd3d2c6e3b1d34442aea6a2d9",
    "type": "payment",
    "account_id": "985522332",
    "order_id": "320afa89017426b994162ab004ce3383",
    "value": 20.00,
    "method": "voucher",
    "payment_reference": "Q88775662377224"
}
```
{: codeblock}

En el ejemplo anterior, el cliente ha pagado con una tarjeta de crédito y ha canjeado un bono de pago anticipado.
El total de los dos pagos suma el importe del pedido.
Cada pago se ha escrito en {{site.data.keyword.cloudant_short_notm}} como un documento distinto.

Puede ver el estado de un pedido creando una vista de todo lo que conoce sobre un `order_id`.
La vista ofrecería un libro mayor que contendría la siguiente información: 

-   Totales de compras como números positivos.
-   Pagos sobre la cuenta como números negativos.

Se podría utilizar una función de correlación para identificar los valores necesarios.

_Función de correlación de ejemplo para buscar los valores de total de compras y de pagos:_ 

```javascript
function (doc) {
    if (doc.type === 'purchase') {
        emit(doc.order_id, doc.total);
    } else {
        if (doc.type === 'payment') {
            emit(doc.order_id, -doc.value);
        }
    }
}
```
{: codeblock}

El uso del [reductor `_sum`](/docs/services/Cloudant?topic=cloudant-views-mapreduce#built-in-reduce-functions) integrado le permite generar la información de salida como un libro mayor de los sucesos relacionados con los pagos.

_Ejemplo de utilización de un reductor `_sum` integrado, consultado con `?reduce=false`:_

```json
{
    "total_rows":3,"offset":0,"rows":[
        {
            "id":"320afa89017426b994162ab004ce3383",
            "key":"985522332",
            "value":26.46
        },
        {
            "id":"320afa89017426b994162ab004ce3383",
            "key":"985522332",
            "value":-20
        },
        {
            "id":"320afa89017426b994162ab004ce3383",
            "key":"985522332",
            "value":-6.46
        }
    ]
}
```
{: codeblock}

También podría generar totales agrupados por `order_id`.

_Ejemplo de totales agrupados por `order_id`, con `?group_level=1`:_

```json
{
    "rows":[
        {
            "key":"320afa89017426b994162ab004ce3383",
            "value":0
        }
    ]
}
```
{: codeblock}

Puesto que la vista del ejemplo anterior devuelve 0 para el valor del pedido, el resultado indica que el pedido se ha pagado por completo.
El motivo es que el total positivo de la orden de compra cancela los importes negativos de los pagos.
Registrar los sucesos como documentos separados (es decir, uno para el pedido y uno para cada pago) constituye una buena práctica en {{site.data.keyword.cloudant_short_notm}}, ya que evita la posibilidad de que se creen conflictos cuando varios procesos modifican el mismo documento simultáneamente.

## Adición de documentos adicionales
{: #adding-additional-documents}

Podría añadir otros documentos separados a la base de datos para registrar los siguientes cambios de estado a medida que se suministran y distribuyen los pedidos:

-   Notificaciones de distribución.
-   Recibos de entregas.
-   Registros de reembolsos.

A medida que llegan datos, {{site.data.keyword.cloudant_short_notm}} escribe en cada documento por separado.
Por lo tanto, no es necesario modificar el documento principal de compra.

## Ventajas de almacenar las órdenes de compra en {{site.data.keyword.cloudant_short_notm}}
{: #advantages-of-storing-purchase-orders-in-ibm-cloudant}

El uso de {{site.data.keyword.cloudant_short_notm}} para almacenar información sobre los pedidos de compra ofrece un sistema de pedidos altamente disponible y escalable que le permite gestionar grandes volúmenes de datos y altas tasas de acceso simultáneo.
Al modelar los datos en documentos separados que solo se escriben una vez, podemos garantizar que los documentos nunca entran en conflicto, como por ejemplo durante el acceso simultáneo al mismo documento por parte de distintos procesos.

Además, los documentos pueden contener copias de datos que existen en otras colecciones para representar (sin depender de los mismos) la unión de datos con una clave foránea.
Por ejemplo, cuando se registra el estado de una cesta en el momento de la compra.
Esto permite capturar el estado de un pedido mediante una única llamada a una vista de {{site.data.keyword.cloudant_short_notm}} que agrupa documentos relacionados por `order_id`.
