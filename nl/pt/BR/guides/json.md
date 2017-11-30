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

# JSON

A maioria das solicitações e respostas de e para o Cloudant
usa o [JavaScript Object Notation (JSON) ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://en.wikipedia.org/wiki/JSON){:new_window}
para formatar o conteúdo e a estrutura dos dados e das respostas.
{:shortdesc}

Em bancos de dados Cloudant,
o objeto JSON é usado para representar uma variedade de estruturas,
incluindo todos os documentos em um banco de dados.

A análise de JSON em um objeto JavaScript é suportada por meio da função `JSON.parse()` em JavaScript
ou por meio de várias [bibliotecas](../libraries/index.html)
que executam a análise do conteúdo em um objeto JavaScript para você.
Há [bibliotecas](../libraries/index.html) para análise e geração de JSON
disponíveis para muitas linguagens de programação principais.

O JSON é usado porque é a solução mais simples e mais fácil para trabalhar com dados usando um navegador da web.
Isso é porque as estruturas JSON podem ser avaliadas e usadas como objetos JavaScript dentro do ambiente do navegador da web.
O JSON também se integra ao JavaScript do lado do servidor usado no Cloudant.
Os documentos JSON são sempre codificados em UTF-8.

>   **Nota**: deve-se tomar cuidado para assegurar que:

-   Suas estruturas JSON sejam válidas.
    Estruturas inválidas façam com que o Cloudant retorne um código de status HTTP de [400 (solicitação inválida)](../api/http.html#400).
-   Você normalize sequências em documentos JSON recuperados do Cloudant,
antes de compará-los.
    Isso é porque a normalização de Unicode pode ter sido aplicada
para que uma sequência armazenada e, em seguida, recuperada não seja idêntica em um nível binário.

O JSON suporta os mesmos tipos básicos suportados por JavaScript:

-   [Números](#numbers)
-   [Sequências](#strings)
-   [Booleanos](#booleans)
-   [Matrizes](#arrays)
-   [Objetos](#objects)

## Números

Os números podem ser valores de número inteiro ou de vírgula flutuante.

_Exemplo de um número no formato JSON:_

```json
123
```
{:codeblock}

## Sequências

A sequência deve ser colocada entre aspas duplas. As sequências suportam caracteres Unicode e escape de barra invertida.

_Exemplo de uma sequência no formato JSON:_

```json
"A String"
```
{:codeblock}

## Booleanos

Um valor `true` ou `false`.

_Exemplo de um booleano no formato JSON:_

```json
{
  "value": true
}
```
{:codeblock}

## Matrizes

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
{:codeblock}

_Exemplo de uma matriz no formato JSON (linear):_

```json
[ "one", 2, "three", [], true, { "foo": "bar" } ]
```
{:codeblock}

## Objetos

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
{:codeblock}
