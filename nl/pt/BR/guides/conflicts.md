---

copyright:
  years: 2015, 2019
lastupdated: "2019-03-15"

keywords: find conflicts, resolve conflicts, merge changes, upload new revision, delete revision

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

<!-- Acrolinx: 2018-05-07 -->

# Conflitos
{: #conflicts}

Em bancos de dados distribuídos,
em que as cópias de dados podem ser armazenadas em mais de um local,
a rede natural e as características do sistema podem significar que as mudanças feitas em um
documento armazenado em um local não podem atualizar ou replicar instantaneamente para outras partes do banco de dados.

Em outras palavras,
se atualizações independentes são feitas para diferentes cópias de documentos,
o efeito pode ser apresentar desacordo ou 'conflitos' quanto ao que é o conteúdo
correto e definitivo para o documento.

O {{site.data.keyword.cloudantfull}} tenta ajudar a evitar conflitos avisando sobre problemas em potencial.
Ele avisa você retornando uma resposta [`409`](/docs/services/Cloudant?topic=cloudant-http#http-status-codes) para uma solicitação de atualização problemática.
No entanto,
uma resposta `409` poderá não ser recebida se a atualização de banco de dados for solicitada em um
sistema não conectado atualmente à rede.
Por exemplo,
o banco de dados pode estar em um dispositivo móvel que está temporariamente desconectado da
Internet,
tornando impossível naquele momento verificar se outras atualizações potencialmente conflitantes
foram feitas.

Se você solicita um documento que está em uma situação de conflito,
O {{site.data.keyword.cloudant_short_notm}} retorna o documento como esperado.
No entanto,
a versão retornada é determinada por um algoritmo interno que considera um
número de fatores.
Não se deve presumir que o documento retornado é sempre a versão mais recente,
por exemplo.

Se você não verifica conflitos
ou não os direciona,
seu banco de dados {{site.data.keyword.cloudant_short_notm}} começa a exibir vários comportamentos:

* Aumentar inconsistências no conteúdo do documento, porque há cada vez mais documentos conflitantes.
* Aumentar o tamanho do banco de dados, porque todos os documentos conflitantes devem ser retidos até que o conflito seja resolvido.
* Diminuir o desempenho, porque o {{site.data.keyword.cloudant_short_notm}} deve trabalhar mais em resposta a cada solicitação que tenta identificar a 'melhor versão possível' de um documento em conflito.

As práticas sugeridas a seguir podem ajudá-lo a decidir quando verificar
e resolver
conflitos:

<table>
<tr>
<th>Característica do aplicativo</th>
<th>Frequência de atualização de documento</th>
<th>Verificar conflitos em recuperação?</th>
<th>Verifique conflitos na atualização?</th>
</tr>
<tr>
<td>Sempre conectado à rede, por exemplo um servidor.</td>
<td>Frequentemente</td>
<td>S</td>
<td>-</td>
</tr>
<tr>
<td>Sempre conectado à rede.</td>
<td>Ocasionalmente</td>
<td>-</td>
<td>S</td>
</tr>
<tr>
<td>Geralmente, mas nem sempre conectado à rede, por exemplo um laptop.</td>
<td>Frequentemente</td>
<td>-</td>
<td>S</td>
</tr>
<tr>
<td>Geralmente, mas nem sempre conectado à rede.</td>
<td>Ocasionalmente</td>
<td>-</td>
<td>S</td>
</tr>
<tr>
<td>Ocasionalmente conectado à rede, por exemplo um tablet.</td>
<td>Frequentemente</td>
<td>-</td>
<td>S</td>
</tr>
</table>

## Localizando conflitos
{: #finding-conflicts}

Para localizar quaisquer conflitos que podem estar afetando um documento,
inclua o parâmetro de consulta `conflicts=true` ao recuperar um documento.
Quando retornado,
o documento resultante contém uma matriz `_conflicts`,
que inclui uma lista de todas as revisões conflitantes.

> Exemplo de função de mapa para localizar conflitos de documentos:

```
function (doc) {
  if (doc._conflicts) {
    emit(null, [doc._rev].concat(doc._conflicts));
    }
}
```

Para localizar conflitos para múltiplos documentos em um banco de dados,
grave uma [visualização](/docs/services/Cloudant?topic=cloudant-views-mapreduce#views-mapreduce).
Usando uma função de mapa, como o exemplo fornecido,
é possível localizar todas as revisões para cada documento com um conflito.

Quando você tem uma visualização como essa,
é possível usá-la para localizar e resolver conflitos conforme necessário.
Como alternativa,
você pode consultar a visualização após cada replicação para identificar e resolver conflitos imediatamente.

## Como resolver conflitos
{: #how-to-resolve-conflicts}

Depois de ter localizado um conflito, é possível resolvê-lo seguindo 4 etapas:

1.	[Obter](#get-conflicting-revisions) as revisões conflitantes.
2.	[Mesclá-las](#merge-the-changes) em seu aplicativo ou perguntar ao usuário o que ele deseja fazer.
3.	[Fazer upload](#upload-the-new-revision) da nova revisão.
4.	[Excluir](#delete-old-revisions) as revisões antigas.

> Exemplo de documento - a primeira versão.

```json
{
  "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "1-7438df87b632b312c53a08361a7c3299",
    "name": "Samsung Galaxy S4",
    "description": "",
    "price": 650
}
```

Vamos considerar um exemplo de como isso pode ser feito.
Suponha que você tenha um banco de dados de produtos para uma loja on-line.
A primeira versão de um documento pode ser semelhante ao exemplo fornecido.

> A segunda versão (primeira revisão) do documento, incluindo uma descrição.

```json
{
  "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "2-61ae00e029d4f5edd2981841243ded13",
    "name": "Samsung Galaxy S4",
    "description": "Latest smartphone from Samsung",
    "price": 650
}
```

O documento ainda não tem uma descrição,
portanto, alguém poderia incluir uma.

> Segunda versão _alternativa_, introduzindo uma mudança de dados de redução de preço na primeira versão do documento.

```json
{
  "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "2-f796915a291b37254f6df8f6f3389121",
    "name": "Samsung Galaxy S4",
    "description": "",
    "price": 600
}
```

Ao mesmo tempo, outra pessoa - trabalhando com um banco de dados replicado - reduz o preço.
Essa mudança é feita para a primeira versão do documento.
Portanto, a mudança de redução de preço não "sabe" sobre a mudança de descrição.

Mais tarde,
quando os dois bancos de dados são replicados,
pode não ficar claro qual das duas versões alternativas do documento está correta.
Este é um cenário de conflito.

## Obter revisões conflitantes
{: #get-conflicting-revisions}

Para localizar quaisquer revisões conflitantes para um documento,
recupere esse documento normalmente,
mas inclua o parâmetro `conflicts=true`,
semelhante ao exemplo a seguir:

`http://ACCOUNT.cloudant.com/products/$_ID?conflicts=true`


> Exemplo de resposta para recuperação de documento, mostrando revisões conflitantes

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

Se o documento tiver quaisquer conflitos,
você receberá uma resposta semelhante ao exemplo fornecido,
baseado na descrição mudada ou no problema do preço mudado.

A versão com o preço mudado foi escolhida _arbitrariamente_ como a versão mais recente do documento.
Não se deve presumir que a versão atualizada mais recentemente do documento seja considerada como a versão mais recente para propósitos de resolução de conflito.

Nesse exemplo,
um conflito é considerado existir entre o documento recuperado que tem o valor `_rev` `2-f796915a291b37254f6df8f6f3389121`
e outro documento que tem o valor `_rev` `2-61ae00e029d4f5edd2981841243ded13`.
Os detalhes do documento conflitante são indicados na matriz `_conflicts`.

Geralmente,
você pode achar que a matriz tem somente um elemento,
mas é possível que haja muitas revisões conflitantes,
cada um das quais é listada na matriz.

## Mesclar as mudanças
{: #merge-the-changes}

Seu aplicativo deve identificar todas as mudanças em potencial
e reconciliá-las,
mesclando efetivamente as atualizações corretas e válidas para produzir uma única
versão não conflitante do documento.

Para comparar as revisões e identificar o que mudou,
seu aplicativo deve recuperar todas as versões do banco de dados.
Conforme descrito anteriormente,
começamos recuperando um documento e os detalhes de quaisquer versões conflitantes.
Fazemos isso usando um comando semelhante ao seguinte,
que também solicita a matriz `_conflicts`:

`http://$ACCOUNT.cloudant.com/products/$_ID?conflicts=true
`

Essa recuperação nos dá uma versão atual do documento que armazenamos
_e_ uma lista de todos os outros documentos conflitantes que também devem ser recuperados,
por exemplo `...rev=2-61ae00e029d4f5edd2981841243ded13` e `...rev=1-7438df87b632b312c53a08361a7c3299`.
Cada uma dessas outras versões conflitantes também é recuperada e armazenada,
por exemplo:

  `http://$ACCOUNT.cloudant.com/products/$_ID?rev=2-61ae00e029d4f5edd2981841243ded13`
  `http://$ACCOUNT.cloudant.com/products/$_ID?rev=1-7438df87b632b312c53a08361a7c3299`

Depois de ter todas as revisões conflitantes de um documento disponíveis,
é possível prosseguir para resolver os conflitos.

Em nosso cenário anterior,
as diferenças entre as versões do documento eram para campos diferentes no documento,
tornando mais fácil mesclá-las.

Conflitos mais complexos podem requerer análise de modo correspondente.
Para obter ajuda,
você pode escolher dentre uma variedade de estratégias de resolução de conflito diferentes,
como:

*	Baseado em tempo: usando um teste simples da primeira edição ou mais recente.
*	Avaliação do usuário: os conflitos são relatados para usuários, que então decidem sobre a melhor resolução.
*	Algoritmos de mesclagem sofisticados: são frequentemente usados em [sistemas de controle de versão](https://en.wikipedia.org/wiki/Merge_%28version_control%29). Um exemplo é a [mesclagem de 3 vias](https://en.wikipedia.org/wiki/Merge_%28version_control%29#Three-way_merge).

Para obter um exemplo prático de como implementar essas mudanças, veja [este projeto com o código de amostra](https://github.com/glynnbird/deconflict).

## Fazer upload da nova revisão
{: #upload-the-new-revision}

> Revisão final, depois de resolver e mesclar mudanças das revisões conflitantes anteriores.

```json
{
  "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "3-daaecd7213301a1ad5493186d6916755",
    "name": "Samsung Galaxy S4",
    "description": "Latest smartphone from Samsung",
    "price": 600
}
```

Após avaliar e resolver os conflitos, você cria um documento contendo os dados atuais e definitivos.
Esse novo documento é transferido por upload para o banco de dados.

## Excluir revisões antigas
{: #delete-old-revisions}

> Exemplo de solicitações para excluir as revisões antigas.

```http
DELETE http://$ACCOUNT.cloudant.com/products/$_ID?rev=2-61ae00e029d4f5edd2981841243ded13

DELETE http://$ACCOUNT.cloudant.com/products/$_ID?rev=2-f796915a291b37254f6df8f6f3389121
```

A etapa final é aquela em que você exclui as revisões antigas.
Você faz isso enviando uma solicitação `DELETE`,
especificando as revisões para exclusão.

Quando as versões mais antigas de um documento são excluídas,
os conflitos associados a esse documento são marcados como resolvidos.
É possível verificar se não há nenhum conflito restante solicitando o documento novamente,
com o parâmetro `conflicts` configurado como true e usando
[localizar conflitos](#finding-conflicts) como antes.
