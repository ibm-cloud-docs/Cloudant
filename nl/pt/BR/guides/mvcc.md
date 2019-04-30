---

copyright:
  years: 2015, 2019
lastupdated: "2019-03-15"

keywords: revisions, distributed databases, conflicts, resolve conflicts, find conflicting revisions, merge changes, upload new revisions, delete old revisions

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

# Versão de documento e MVCC
{: #document-versioning-and-mvcc}

[Multi-version concurrency control (MVCC) ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://en.wikipedia.org/wiki/Multiversion_concurrency_control){: new_window}
é como os bancos de dados {{site.data.keyword.cloudantfull}} asseguram que todos os nós no cluster de um banco de dados contenham
somente a [versão mais recente](/docs/services/Cloudant?topic=cloudant-documents#documents) de um documento.
{: shortdesc}

Como os bancos de dados {{site.data.keyword.cloudant_short_notm}} são [eventualmente consistentes](/docs/services/Cloudant?topic=cloudant-cap-theorem#cap-theorem),
isso é necessário para evitar que surjam inconsistências entre os nós
como resultado da sincronização entre documentos desatualizados.

O Multi-Version Concurrency Control (MVCC) permite o acesso simultâneo de leitura e gravação a um banco de dados do {{site.data.keyword.cloudant_short_notm}}.
MVCC é uma forma de [simultaneidade otimista ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://en.wikipedia.org/wiki/Optimistic_concurrency_control){: new_window}.
Ele torna as operações de leitura e gravação nos bancos de dados {{site.data.keyword.cloudant_short_notm}} mais rápidas porque
não há necessidade de bloqueio do banco de dados nas operações de leitura ou gravação.
O MVCC também permite sincronização entre os nós de banco de dados {{site.data.keyword.cloudant_short_notm}}.

## Revisões
{: #revisions}

Todo documento em um banco de dados do {{site.data.keyword.cloudant_short_notm}} tem um campo `_rev` indicando o seu número da revisão.

Um número de revisão é incluído em seus documentos pelo servidor quando você o insere ou o modifica.
O número é incluído na resposta do servidor quando você faz mudanças ou lê um documento.
O valor `_rev` é construído usando uma combinação de um contador simples e um hash do documento.

Os dois principais usos do número de revisão são para ajudar a:

1.  Determinar quais documentos devem ser replicados entre os servidores.
2.  Confirmar que um cliente está tentando modificar a versão mais recente de um documento.

Deve-se especificar o `_rev` anterior ao [atualizar um documento](/docs/services/Cloudant?topic=cloudant-documents#update)
ou então sua solicitação falhará e retornará um [erro 409](/docs/services/Cloudant?topic=cloudant-http#http-status-codes).

`_rev` não deve ser usado para construir um sistema de controle de versão. O motivo é que ele é um valor interno usado pelo servidor. Além disso,
revisões mais antigas de um documento são temporárias
e, portanto, removidas regularmente.
{: note}

É possível consultar uma revisão específica usando seu `_rev`,
no entanto,
as revisões mais antigas são excluídas regularmente por um processo chamado
[compactação ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://en.wikipedia.org/wiki/Data_compaction){: new_window}.
Uma consequência da compactação é que
não será possível confiar em uma resposta bem-sucedida ao consultar uma revisão de documento específica
usando seu `_rev` para obter um histórico de revisões para seu documento.
Se você precisar de um histórico de versões de seus documentos,
uma solução será [criar um novo documento](/docs/services/Cloudant?topic=cloudant-documents#create-document) para cada revisão.

## Bancos de dados distribuídos e conflitos
{: #distributed-databases-and-conflicts}

Os bancos de dados distribuídos funcionam sem uma conexão constante com o banco de dados principal no {{site.data.keyword.cloudant_short_notm}},
que é por si só distribuído,
portanto as atualizações baseadas na mesma versão anterior ainda podem estar em conflito.

Para localizar conflitos,
inclua o parâmetro de consulta [`conflicts=true`](/docs/services/Cloudant?topic=cloudant-databases#get-changes) ao recuperar um documento.
A resposta contém uma matriz `_conflicts` com todas as revisões conflitantes.

Para localizar conflitos para múltiplos documentos em um banco de dados,
grave uma visualização.

A função de mapa a seguir é um exemplo que emite todas as revisões conflitantes de cada documento que possui um conflito.

_Exemplo de uma função de mapa para localizar documentos com um conflito:_

```javascript
function (doc) {
    if (doc._conflicts) {
        emit(null, [doc._rev].concat(doc._conflicts));
    }
}
```
{: codeblock}

Você poderia consultar regularmente essa visualização e resolver conflitos conforme necessário
ou consultar a visualização após cada replicação.

## Etapas para resolver conflitos
{: #steps-to-resolve-conflicts}

Depois de ter localizado um conflito,
será possível resolvê-lo em 4 etapas.

1.  [Obter](#get-conflicting-revisions) as revisões conflitantes.
2.  [Mesclá-las](#merge-the-changes) em seu aplicativo ou perguntar ao usuário o que ele deseja fazer.
3.  [Fazer upload](#upload-the-new-revision) da nova revisão.
4.  [Excluir](#delete-old-revisions) revisões antigas.

Vamos considerar um exemplo de como isso pode ser feito.
Suponha que você tenha um banco de dados de produtos para uma loja on-line.
A primeira versão de um documento pode ser semelhante ao exemplo a seguir:

```json
{
    "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "1-7438df87b632b312c53a08361a7c3299",
    "name": "Samsung Galaxy S4",
    "description": "",
    "price": 650
}
```
{: codeblock}

Como o documento ainda não tem uma descrição,
alguém poderia incluir uma:

_Segunda versão do documento, criada incluindo uma descrição:_

```json
{
    "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "2-61ae00e029d4f5edd2981841243ded13",
    "name": "Samsung Galaxy S4",
    "description": "Latest smartphone from Samsung",
    "price": 650
}
```
{: codeblock}

Ao mesmo tempo, outra pessoa - trabalhando com um banco de dados replicado - reduz o preço:

_Uma revisão diferente, em conflito com a anterior, por causa do valor `price` diferente:_

```json
{
    "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "2-f796915a291b37254f6df8f6f3389121",
    "name": "Samsung Galaxy S4",
    "description": "",
    "price": 600
}
```
{: codeblock}

Os dois bancos de dados são então replicados.
A diferença em versões do documento resulta em um conflito.

### Obter revisões conflitantes
{: #get-conflicting-revisions}

Você identificará documentos com conflitos usando a opção `conflicts=true`.

_Exemplo de localização de documentos com conflitos:_

```http
http://$ACCOUNT.cloudant.com/products/$_ID?conflicts=true
```
{: codeblock}

_Exemplo de resposta mostrando revisões conflitantes que afetam os documentos:_

```json
{
    "_id":"74b2be56045bed0c8c9d24b939000dbe",
    "_rev":"2-f796915a291b37254f6df8f6f3389121",
    "name":"Samsung Galaxy S4",
    "description":"",
    "price":600,
    "_conflicts":["2-61ae00e029d4f5edd2981841243ded13"]
}
```
{: codeblock}

A versão com o preço mudado foi escolhida arbitrariamente como a versão mais recente do documento
e o conflito com outra versão é indicado fornecendo o ID dessa outra versão na matriz `_conflicts`.
Na maioria dos casos, essa matriz possui apenas um elemento,
mas pode haver muitas revisões conflitantes.

### Mesclar as mudanças
{: #merge-the-changes}

Para comparar as revisões e ver o que mudou,
seu aplicativo obtém todas as versões do banco de dados.

_Exemplo de comandos para recuperar todas as versões de um documento do banco de dados:_

```http
http://$ACCOUNT.cloudant.com/products/$_ID
http://$ACCOUNT.cloudant.com/products/$_ID?rev=2-61ae00e029d4f5edd2981841243ded13
http://$ACCOUNT.cloudant.com/products/$_ID?rev=1-7438df87b632b312c53a08361a7c3299
```
{: codeblock}

Como as mudanças conflitantes são para campos diferentes do documento,
é fácil mesclá-las.

Para conflitos mais complexos,
outras estratégias de resolução podem ser necessárias:

*   Baseado em tempo: use a primeira ou a última edição.
*   Intervenção do usuário: relatar conflitos para os usuários e deixar que decidam sobre a melhor resolução.
*   Algoritmos sofisticados: por exemplo, mesclagens em 3 vias de campos de texto.

Para obter um exemplo prático de como implementar uma mesclagem de mudanças,
consulte este projeto com o [código de amostra ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/glynnbird/deconflict){: new_window}.

### Fazer upload da nova revisão
{: #upload-the-new-revision}

A próxima etapa será criar um documento que resolva os conflitos
e atualizar o banco de dados com ele.

_Um documento de exemplo que mescla as mudanças das duas revisões conflitantes:_

```json
{
    "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "3-daaecd7213301a1ad5493186d6916755",
    "name": "Samsung Galaxy S4",
    "description": "Latest smartphone from Samsung",
    "price": 600
}
```
{: codeblock}

### Excluir revisões antigas
{: #delete-old-revisions}

Por fim,
você excluirá as revisões antigas enviando uma solicitação `DELETE` para as URLs com a revisão que desejamos excluir.

_Exemplo de solicitação para excluir uma revisão de documento antiga, usando HTTP:_

```http
DELETE https://$ACCOUNT.cloudant.com/products/$_ID?rev=2-61ae00e029d4f5edd2981841243ded13
```
{: codeblock}

_Exemplo de solicitação para excluir uma revisão de documento antiga, usando a linha de comandos:_

```sh
curl "https://$ACCOUNT.cloudant.com/products/$_ID?rev=2-f796915a291b37254f6df8f6f3389121" -X DELETE
```
{: codeblock}

Neste ponto,
os conflitos que afetam o documento são resolvidos.
É possível verificar isso com `GET`, ao obter o documento novamente com o parâmetro `conflicts` configurado como `true`.
