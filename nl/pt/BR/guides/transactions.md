---

copyright:
  years: 2015, 2017
lastupdated: "2017-01-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# Agrupando documentos relacionados no Cloudant

Tradicionalmente,
os sistemas e-commerce são construídos com bancos de dados relacionais.
Esses bancos de dados geralmente usam várias tabelas associadas para registrar vendas,
detalhes do cliente,
produtos comprados
e informações de rastreamento de entrega.
Os bancos de dados relacionais oferecem alta consistência,
ou seja, os desenvolvedores de aplicativos podem construir seus aplicativos para os pontos fortes de um banco de dados,
incluindo o uso de junções entre as coletas,
enumerações para registrar o estado de um objeto
e transações do banco de dados para garantir operações atômicas.

O Cloudant favorece a disponibilidade sobre a consistência.
É um banco de dados distribuído
de alta disponibilidade,
tolerante a falhas, eventualmente consistente.
A vantagem disso é que o serviço de compras do cliente está sempre disponível e escalável o suficiente
para lidar com múltiplos usuários fazendo compras ao mesmo tempo.
Isso significa que seu aplicativo pode utilizar os pontos fortes do Cloudant e não tratá-lo como um banco de dados relacional.

A discussão neste tópico descreve alguns dos fatores
envolvidos na construção de um sistema e-commerce que aproveita os pontos fortes do Cloudant
usando conceitos que são aplicáveis a muitos outros domínios,
como:

-   Usando múltiplos documentos para representar o estado de uma compra,
em vez de atualizar frequentemente um único documento.
-   Armazenando cópias de objetos relacionados em ordem, em vez de se associar a outra coleção.
-   Criando visualizações para intercalar documentos por `order_id` para refletir o estado atual de uma compra.

Por exemplo,
é possível criar um documento `purchase` contendo detalhes como os itens pedidos,
informações do cliente,
custo
e informações de entrega.

_Exemplo de documento descrevendo uma compra:_

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
{:codeblock}

Esse documento fornece dados suficientes para um registro de compra renderizar um resumo de uma ordem em uma página da web
ou um e-mail,
sem buscar registros adicionais.
Observe os detalhes principais sobre a ordem,
especificamente:

-   A cesta contém IDs de referência (`product_id`) para um banco de dados de produtos armazenados em outro lugar.
-   A cesta duplica alguns dos dados do produto nesse registro,
o suficiente para registrar o estado dos itens comprados no ponto de venda.
-   O documento não contém campos que marcam o status da ordem.
Documentos adicionais seriam incluídos posteriormente para registrar pagamentos e entrega.
-   O banco de dados gera automaticamente um documento `_id` ao inserir o documento no banco de dados.
-   Um identificador exclusivo (`order_id`) é fornecido com cada registro de compra para referenciar a ordem posteriormente. 
 
Quando o cliente faz uma ordem,
geralmente no ponto em que entra na fase de "check-out" no website,
um registro de ordem de compra é criado de forma semelhante ao exemplo anterior. 

## Gerando seus próprios identificadores exclusivos (UUIDs)

Em um banco de dados relacional,
números sequenciais de "incremento automático" são frequentemente usados,
mas em bancos de dados distribuídos,
em que os dados são difundidos em torno do cluster de servidores,
UUIDs mais longos são usados para assegurar que os documentos sejam armazenados com seus próprios IDs exclusivos.

Para criar um identificador exclusivo para uso em seu aplicativo,
como um `order_id`,
chame o terminal [`GET _uuids`](../api/advanced.html#-get-_uuids-) na API do Cloudant.
O banco de dados gera um identificador para você.
O mesmo terminal pode ser usado para gerar múltiplos IDs incluindo um parâmetro `count`,
por exemplo, `/_uuids?count=10`.

## Registrando pagamentos

Quando o cliente paga com sucesso seus itens,
registros adicionais são incluídos no banco de dados para registrar a ordem.

_Exemplo de um registro de pagamento:_

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
{:codeblock}

No exemplo anterior,
o cliente pagou fornecendo um cartão de crédito e resgatando um voucher pago antecipadamente.
O total dos dois pagamentos totalizou a quantia da ordem.
Cada pagamento foi gravado no Cloudant como um documento separado.

Você poderia ver o status de uma ordem criando uma visualização de tudo o que sabe sobre um `order_id`.
A visualização permitiria um livro razão contendo as informações a seguir: 

-   Totais da compra como números positivos.
-   Pagamentos com relação à conta como números negativos.

Uma função de mapa poderia ser usada para identificar os valores necessários.

_Função de mapa de exemplo para localizar valores totais e de pagamento da compra:_ 

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
{:codeblock}

O uso do [redutor `_sum`](../api/creating_views.html#built-in-reduce-functions) integrado
permite que você produza saída como um livro razão de eventos de pagamento.

_Exemplo de uso do redutor `_sum` integrado, consultado com `?reduce=false`:_

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
{:codeblock}

Como alternativa,
você poderia produzir os totais agrupados por `order_id`.

_Exemplo de totais agrupados por `order_id`, com `?group_level=1`:_

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
{:codeblock}

Como a visualização no exemplo anterior retorna 0 para o valor da ordem,
o resultado indica que a ordem foi totalmente paga.
A razão é que o total positivo da ordem de compra cancela as quantias de pagamento negativo.
Registrar eventos como documentos separados,
isto é, um para a ordem e um para cada pagamento,
é uma boa prática no Cloudant,
já que evita a possibilidade de criar conflitos quando múltiplos processos modificam o mesmo documento simultaneamente.

## Incluindo documentos adicionais

Seria possível incluir outros
documentos separados no banco de dados para registrar as mudanças de estado a seguir conforme a ordem fosse provisionada e despachada:

-   Notificações de despacho.
-   Recibos de entrega.
-   Registros de reembolso.

Conforme os dados chegam,
o Cloudant grava cada documento separadamente.
Portanto,
não é necessário modificar o documento de compra principal.

## Vantagens de armazenar ordens de compra no Cloudant

Usar o Cloudant para armazenar informações da ordem de compra permite que um sistema de ordenação fique altamente disponível e escalável,
permitindo lidar com grandes volumes de dados e altas taxas de acesso simultâneo.
Ao modelar os dados em documentos separados que são gravados apenas uma vez,
é possível assegurar que os documentos nunca entrem em conflito,
como durante o acesso simultâneo ao mesmo documento em processos separados.

Além disso,
os documentos podem conter cópias de dados existentes em outras coletas
para representar - em vez de depender - a junção de dados com uma chave estrangeira.
Por exemplo,
ao registrar o estado de uma cesta no momento da compra.
Isso permite que o estado de uma ordem seja buscado por uma única chamada
para uma visualização do Cloudant que agrupa documentos relacionados por `order_id`.
