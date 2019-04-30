---

copyright:
  years: 2015, 2019
lastupdated: "2019-03-18"

keywords: numbers, strings, booleans, arrays, objects

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

# JSON
{: #json}

A maioria das solicitações e respostas para e do {{site.data.keyword.cloudantfull}}
usa o [JavaScript Object Notation (JSON) ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://en.wikipedia.org/wiki/JSON){: new_window}
para formatar o conteúdo e a estrutura dos dados e respostas.
{: shortdesc}

Em bancos de dados {{site.data.keyword.cloudant_short_notm}},
o objeto JSON é usado para representar uma variedade de estruturas,
incluindo todos os documentos em um banco de dados.

A análise de JSON em um objeto JavaScript é suportada por meio da função `JSON.parse()` em JavaScript
ou por meio de várias [bibliotecas](/docs/services/Cloudant?topic=cloudant-client-libraries#client-libraries)
que executam a análise do conteúdo em um objeto JavaScript para você. As bibliotecas para a análise e geração de JSON estão disponíveis para muitas linguagens de programação principais.

O JSON é usado porque é a solução mais simples e mais fácil para trabalhar com dados usando um navegador da web.
Isso é porque as estruturas JSON podem ser avaliadas e usadas como objetos JavaScript dentro do ambiente do navegador da web.
O JSON também se integra ao JavaScript do lado do servidor usado no {{site.data.keyword.cloudant_short_notm}}.
Os documentos JSON são sempre codificados em UTF-8.

Certifique-se de que:
-   Suas estruturas JSON sejam válidas.
-   Você normaliza as sequências em documentos JSON recuperados do {{site.data.keyword.cloudant_short_notm}},

O JSON suporta os mesmos tipos básicos suportados por JavaScript:

-   [Números](#numbers)
-   [Sequências](#strings)
-   [Booleanos](#booleans)
-   [Matrizes](#arrays)
-   [Objetos](#objects)

## Números
{: #numbers}

Os números podem ser valores de número inteiro ou de vírgula flutuante.

_Exemplo de um número no formato JSON:_

```json
123
```
{: codeblock}

## Sequências
{: #strings}

A sequência deve ser colocada entre aspas duplas. As sequências suportam caracteres Unicode e escape de barra invertida.

_Exemplo de uma sequência no formato JSON:_

```json
"A String"
```
{: codeblock}

## Booleanos
{: #booleans}

Um valor `true` ou `false`.

_Exemplo de um booleano no formato JSON:_

```json
{
  "value": true
}
```
{: codeblock}

## Matrizes
{: #arrays}

Uma lista de valores entre colchetes. Os valores incluídos podem ser qualquer JSON válido.

_Exemplo de uma matriz no formato JSON:_

```json
[
    "one",
    2,
    "three",
    [],
    true,
    {
        "foo":
        "bar"
    }
]
```
{: codeblock}

_Exemplo de uma matriz no formato JSON (linear):_

```json
[ "one", 2, "three", [], true, { "foo": "bar" } ]
```
{: codeblock}

## Objetos
{: #objects}

Um conjunto de pares chave/valor,
como uma matriz associativa
ou um hash.
A chave deve ser uma sequência,
mas o valor pode ser qualquer um dos valores JSON suportados.

_Exemplo de um objeto JSON:_

```json
{
    "servings" : 4,
    "subtitle" : "Easy to make in advance, and then cook when ready",
    "cooktime" : 60,
    "title" : "Chicken Coriander"
}
```
{: codeblock}
