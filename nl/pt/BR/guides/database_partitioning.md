---

copyright:
  years: 2019
lastupdated: "2019-03-27"

keywords: database shards, non-partitioned databases, partition key, global query, partition query, create partition database, create partition query index

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

<!-- Acrolinx: 2018-08-17 -->

# Particionamento de banco de dados
{: #database-partitioning}

O recurso de banco de dados particionado do {{site.data.keyword.cloudant_short_notm}} está atualmente no modo beta. Os bancos de dados de partição não devem ser empregados no uso do aplicativo de produção. Esse recurso está sendo lançado em todos os ambientes do {{site.data.keyword.cloudant_short_notm}} e estará geralmente disponível nas próximas semanas.
{: important}

O{{site.data.keyword.cloudantfull}}suporta dois tipos de bancos de dados:

- Particionado
- Não particionado

Um banco de dados _particionado_ oferece um desempenho significativo e vantagens de custo, mas
requer que você especifique um particionamento lógico de seus dados. Isso é descrito
mais abaixo.

Como alternativa, um banco de dados _não particionado_ pode ser criado. Esse tipo de
banco de dados pode ser mais fácil de trabalhar, já que nenhum esquema de particionamento precisa ser definido, mas apenas índices secundários globais podem ser criados.

O {{site.data.keyword.cloudant_short_notm}} recomenda fortemente que você use um banco de dados particionado para melhor desempenho do banco de dados de longo prazo
em que o modelo de dados permite o particionamento lógico
de documentos.

O tipo de particionamento de um banco de dados é configurado no momento da criação do banco de dados.  Ao
criar um banco de dados, use o parâmetro de sequência de consultas `partitioned` para configurar se
o banco de dados é particionado. O padrão para `partitioned` é `false`,
mantendo a compatibilidade com versões anteriores.

O tipo de particionamento não pode ser mudado para um banco de dados existente.

## Shards de banco de dados
{: #database-shards}

Antes de ler este documento, deve-se entender o
[conceito de sharding](/docs/services/Cloudant?topic=cloudant-how-is-data-stored-in-ibm-cloudant-#how-is-data-stored-in-ibm-cloudant-) no {{site.data.keyword.cloudant_short_notm}}.

## Bancos de dados não particionados
{: #non-partitioned-databases}

Um banco de dados não particionado é o tipo mais antigo do banco de dados do {{site.data.keyword.cloudant_short_notm}} e aquele
que será familiar se você tiver usado CouchDB ou o {{site.data.keyword.cloudant_short_notm}} anteriormente.

Em um banco de dados não particionado, os documentos são distribuídos para shards de uma maneira arbitrária
com base em uma transformação de seu ID do documento. Portanto, não há
relação real entre o ID de um documento e o shard em que ele termina. É improvável que documentos
com IDs de documentos muito semelhantes sejam colocados no mesmo shard.

Um banco de dados não particionado oferece somente consultas globais, descritas em mais
detalhes a seguir.

## Bancos de dados particionados
{: #partitioned-databases}

Um banco de dados particionado é o tipo mais novo do banco de dados do {{site.data.keyword.cloudant_short_notm}}. Em um
banco de dados particionado, os documentos são formados em partições lógicas pelo uso
de uma _chave de partição_, que faz parte de IDs de documento para documentos em
bancos de dados particionados. Todos os documentos são designados a uma partição, e muitos
em geral, os documentos são fornecidos com a mesma chave de partição. Os dados JSON primários de uma partição
e seus índices são finalizados de forma colocalizada, o que significa que o banco de dados é
capaz de consultar dados dentro de uma partição de forma mais eficiente.

Um banco de dados particionado oferece consultando particionado e global. A consulta particionada
aproveita o layout de dados dentro do cluster do banco de dados para
entregar um desempenho de consulta melhorado e mais escalável. Além disso, as consultas
de partição são frequentemente mais baratas do que as consultas globais.

Como os bancos de dados particionados oferecem as vantagens da consulta global
e de partição, o {{site.data.keyword.cloudant_short_notm}} recomenda que novos aplicativos se aproveitem deles.

## O que faz uma boa chave de partição?
{: #what-makes-a-good-partition-key-}

Se você estiver pensando em usar o novo recurso *banco de dados particionado* do {{site.data.keyword.cloudant_short_notm}}, a
opção de uma chave de partição será muito importante. Uma chave de partição deve ter:

- Muitos valores - muitas partições pequenas são melhores do que algumas grandes.
- Sem pontos de acesso - evite projetar um sistema que faça uma partição manipular uma alta
proporção da carga de trabalho. Se o trabalho for distribuído uniformemente ao redor
das partições, o banco de dados executará mais suavemente.
- Repetido - se cada chave de partição for exclusiva, haverá um documento por
partição. Para obter a melhor saída de bancos de dados particionados, deve haver
múltiplos documentos por partição - documentos que logicamente pertencem uns aos outros.

Vamos ver alguns casos de uso e algumas opções boas e ruins para uma chave de partição.

| Caso de uso                   | Descrição                 | Chave da partição | Efetividade                                                                                                  |
|----------------------------|-----------------------------|---------------|------------------------------------------------------------------------------------------------------------------|
| Sistema de e-commerce - pedidos | Um documento por pedido     | order_id      | Neutro-um documento por partição está bom, mas ele não fornece os benefícios das Consultas de Partição.          |
| Sistema de e-commerce - pedidos | Um documento por pedido     | user_id       | Bom - todos os pedidos de um usuário serão mantidos juntos.                                                             |
| Sistema de e-commerce - pedidos | Um documento por pedido      | status        | Ruim - agrupar pedidos por alguns valores de status (provisórios, pagos, reembolsados, cancelados) criará muito poucas partições excessivamente grandes.  |
| Plataforma de blog          | Um documento por postagem do blog | author_id     | Bom - desde que haja muitos autores. Fácil para consultar os posts de cada autor.                                     |
| IOT - leituras do sensor      | Um documento por leitura    | device_id     | Bom - se houver muitos dispositivos. Certifique-se de que um dispositivo não esteja produzindo muito mais leituras do que os outros. |
| IOT - leituras do sensor      | Um documento por leitura    | date          | Ruim - as leituras atuais causarão um "ponto de acesso" na partição da data atual.                                  |

Há alguns casos de uso em que não há uma opção viável para uma chave de partição.
Nessas situações, é provável que um banco de dados não particionado seja a melhor
opção, por exemplo, um banco de dados de usuários que armazenam endereços de e-mail, hashes de senha e datas de último login. Nenhum desses campos contribui para uma chave de partição adequada, portanto,
um banco de dados normal não particionado deve ser usado no lugar.

## Consultando
{: #querying}

Esta seção descreve quais tipos de consulta do {{site.data.keyword.cloudant_short_notm}} estão disponíveis
para consultas globais e de partição, juntamente com uma breve visão geral do
mecanismo de consulta subjacente para permitir que você selecione o melhor mecanismo de consulta
para cada consulta que seu aplicativo precisa fazer.

### Consulta global
{: #global-querying}

É possível fazer consultas globais para os tipos de índice a seguir:

- {{site.data.keyword.cloudant_short_notm}} Query
- Visualizações
- Procura
- Geo

Ao fazer uma consulta global, o banco de dados deve executar uma operação de dispersão/reunião
em todos os dados no banco de dados. Isso significa fazer solicitações de vários
servidores de banco de dados individuais. O nó de coordenação da API recebe as respostas de todos
esses servidores e os combina para formar uma única resposta para o cliente. Isso
poderá envolver armazenamento de dados em buffer e atrasar a resposta para o cliente se, por
exemplo, os dados exigirem classificação.

### Consulta de partição
{: #partition-querying}

É possível fazer consultas de partição para os tipos de índice a seguir:

- {{site.data.keyword.cloudant_short_notm}} Query
- Visualizações
- Procura

Ao fazer uma consulta de partição, o banco de dados é capaz de consultar apenas
os dados dentro de uma única partição. Como os dados de uma partição residem em apenas um shard (com
três réplicas), o nó de coordenação da API é capaz de fazer uma solicitação diretamente
para os servidores que hospedam os dados em vez de precisarem combinar respostas de
vários servidores. Ele também é liberado de armazenamento em buffer da resposta, pois não há
combinação de um passo para levar a cabo. Portanto, os dados chegam ao cliente mais
rapidamente.

Além disso, à medida que o tamanho de um banco de dados aumenta, o número de shards
precisa aumentar. Isso aumenta diretamente o número de consultas que
o nó de coordenação da API precisa fazer para os servidores que hospedam dados ao usar consultas
globais. Ao usar consultas de partição, no entanto, o número de shards
não tem efeito no número de servidores com os quais o nó de coordenação da API precisa entrar em contato. Como
esse número permanece pequeno, o aumento do tamanho dos dados não tem efeito na latência de consulta,
diferentemente das consultas globais.

## Exemplo: particionando dados de leitura do IoT
{: #example-partitioning-iot-reading-data}

Essa discussão é bastante abstrata; vamos torná-la concreta com um exemplo. Nós
tomaremos o domínio Internet of Things e analisaremos o uso do {{site.data.keyword.cloudant_short_notm}} como um historiador para
leituras do dispositivo. Digamos que os dispositivos estão fornecendo leituras do sensor em peças
de infraestrutura como estradas ou pontes.

Vamos supor:

- Centenas ou milhares de dispositivos relatando leituras.
- Cada dispositivo possui um ID exclusivo.
- Cada parte da infraestrutura possui um ID exclusivo.
- Os dispositivos não são movidos entre as partes da infraestrutura.
- Cada dispositivo grava uma leitura no {{site.data.keyword.cloudant_short_notm}} a cada 10 segundos. Provavelmente
isso é entregue por meio de um barramento de mensagem para o {{site.data.keyword.cloudant_short_notm}}.

Em um banco de dados não particionado, você pode permitir que o {{site.data.keyword.cloudant_short_notm}}gere o documento
IDs. Outra alternativa é nomear os documentos por ID do dispositivo e registro de data e hora do registro.

Usando a segunda abordagem, nós teríamos IDs de documento como o seguinte:

```
device-123456:20181211T11:13:24.123456Z
```

O registro de data e hora também pode ser um registro de data e hora de época.

Essa abordagem permitirá que os dados de cada dispositivo sejam consultados eficientemente
usando índices particionados, mas os índices globais podem precisar ser usados para criar
visualizações sobre múltiplos dispositivos (digamos que todos os dispositivos em uma determinada parte da
infraestrutura).

Para fins ilustrativos, vamos tornar o cenário um pouco mais complicado,
supondo que o aplicativo precisa principalmente ler todos os dados do sensor para uma
determinada parte da infraestrutura em vez de dispositivos individuais.

Nesse aplicativo, queremos que a consulta por item de infraestrutura seja mais
eficiente, portanto, particionar os dados por parte da infraestrutura faz muito mais sentido
do que por ID. Isso permitiria que todos os dispositivos para uma determinada parte
da infraestrutura fossem consultados de forma eficiente como um grupo.

Para as consultas raras por dispositivo, há duas abordagens:

1. Construa um índice global chaveado por dispositivo e consulte isso. Isto é mais eficaz.
    se as consultas para dispositivos individuais forem raras e não forem repetidas.
2. Construa um dispositivo de mapeamento de índice global para a infraestrutura e, em seguida,
emita consultas de partição para a partição de infraestrutura. Isso faz sentido caso as consultas repetidas
para os dispositivos fornecidos sejam usadas, pois o mapeamento pode ser armazenado em cache. Vamos supor
que esse é o caso para o nosso aplicativo.

Vamos dar uma olhada em como isso funciona. Vamos olhar para quatro consultas:

1. Leituras para todo o tempo para uma parte da infraestrutura.
1. Leituras para hoje para uma parte da infraestrutura.
1. Leituras para todo o tempo para um dispositivo específico.
1. Leituras para hoje para um dispositivo específico.

### Criando o banco de dados
{: #creating-the-database}

Usaremos um banco de dados chamado `readings` e uma conta chamada
`acme`. Para criar isso como um banco de dados particionado, passe `true` como o
argumento `partitioned` para a solicitação de criação do banco de dados:

```
curl -XPUT 'https://acme.cloudant.com/readings?partitioned=true'
```

### Estrutura do documento
{: #document-struture}

Primeiro, vamos definir um formato de documento simples para trabalhar:

```json
{
    "deviceID": "device-123456",
    "infrastructureID": "bridge-9876",
    "ts": "20181211T11:13:24.123456Z",
    "reading": {
        "temperature": {"value": 12, "unit": "c"}
    }
}
```

Para este documento, usando o esquema de particionamento com base na parte
da infraestrutura. O ID do documento pode incluir o ID da infraestrutura como
a chave de partição e incluir o dispositivo e o registro de data e hora como a chave do documento:

```
bridge-9876:device-123456-20181211T11:13:24.123456Z
```

### Criando índices
{: #creating-indexes}

Para as consultas acima, precisaremos de dois índices:

1. Um ID do dispositivo de mapeamento de índice global para o ID da infraestrutura.
2. IDs de dispositivo de mapeamento de índice particionado para leituras.

#### Criando um índice de visualização global
{: #creating-a-global-view-index}

Um índice de visualização é a maneira mais eficiente de fazer o mapeamento
simples de ID do dispositivo para ID da infraestrutura. Para defini-lo, faça upload de um documento de design com
`options.partitioned` configurado como `false`, pois esse índice é global. Embora em uma
função `map` real você seria mais defensivo quanto à existência do campo,
isso se pareceria com o seguinte:

```json
{
    "_id": "_design/infrastructure-mapping",
    "options": {"partitioned": false},
    "views": {
        "by-device": {
            "map": "function (doc) { emit (doc.deviceID, doc.infratureID) }"
        }
    }
}
```

Presumindo que o documento acima seja `./view.json`, isso é transferido por upload
para o banco de dados usando:

```
curl -XPOST https://acme.cloudant.com/readings -d @view.json
```

#### Criando um índice particionado do {{site.data.keyword.cloudant_short_notm}} Query
{: #creating-a-paritioned-ibm-cloudant-query-index}

Para retornar as leituras para um determinado dispositivo por meio de uma partição, podemos usar um
índice do {{site.data.keyword.cloudant_short_notm}} Query. Para isso, nós `POST`para `_index`com uma definição de índice
que inclui o campo `particionado`configurado como `true`. 

Para definições de índice do Query, o campo `partitioned` não está aninhado dentro de um objeto
`options`.
{: note}

Para nossas consultas, precisamos de dois índices particionados:

1. Por registro de data e hora
2. Por ID do dispositivo e registro de data e hora

A definição do registro de data e hora é a seguinte:

```json
{
   "index": {
      "fields": [
         "ts"
      ]
   },
   "name": "timestamped-readings",
   "type": "json",
   "partitioned:" true
}
```

Presumindo que o documento acima seja `./query-index1.json`, faça upload do índice para
o banco de dados usando este comando:

```
curl -XPOST https://acme.cloudant.com/readings/_index -d @query-index1.json
```

A definição de por ID do dispositivo e registro de data e hora é a seguinte:

```json
{
   "index": {
      "fields": [
         "deviceID",
         "ts"
      ]
   },
   "name": "deviceID-readings",
   "type": "json",
   "partitioned:" true
}
```

Presumindo que o documento acima seja `./query-index2.json`, faça upload do índice para
o banco de dados usando este comando:

```
curl -XPOST https://acme.cloudant.com/readings/_index -d @query-index2.json
```

### Fazendo consultas
{: #making-queries}

Em geral, queremos fazer quatro consultas:

1. Leituras para todo o tempo para uma parte da infraestrutura.
1. Leituras para hoje para uma parte da infraestrutura.
1. Leituras para todo o tempo para um dispositivo específico.
1. Leituras para hoje para um dispositivo específico.

#### Localizando todas as leituras para uma parte da infraestrutura
{: #finding-all-readings-for-a-piece-of-infrastructure}

Como nossas partições são baseadas em infraestrutura, podemos usar `_all_docs` para uma
partição. Por exemplo, consultando todas as leituras para a parte da infraestrutura
`bridge-1234`:

```
curl -XGET \
    'https://acme.cloudant.com/readings/_partition/bridge-1234/_all_docs?include_docs=true'
```

#### Localizando leituras recentes para uma parte da infraestrutura
{: #finding-recent-readings-for-a piece-of-infrastructure}

Esta consulta precisa usar o índice particionado `timestamped-leituras`. É possível
emitir uma consulta para a partição para obter as leituras de hoje:

_query.json, supondo que hoje seja 13 de dezembro de 2018:_

```json
{
    "selector": {
        "ts": { "$gte": "20181213"}
    }
}
```

A partição é integrada no caminho HTTP ao emitir a solicitação para o {{site.data.keyword.cloudant_short_notm}}:

```
curl -XPOST \
    'https://acme.cloudant.com/readings/_partition/bridge-1234/_find' \
    -d @query.json
```

#### Localizando o ID da infraestrutura para um dispositivo
{: #finding-the-infrastructure-id-for-a-device}

As duas consultas que ainda temos de executar são:

1. Leituras para todo o tempo para um dispositivo específico.
2. Leituras para hoje para um dispositivo específico.

Para essas duas consultas, é necessário localizar a partição para os dispositivos usando o índice
global `by-device`. Em seguida, podemos consultar a partição individual para
leituras. Embora possamos ter usado um índice global para consultar as leituras
de dispositivos individuais, o mapeamento do dispositivo para o ID da infraestrutura é altamente
armazenável em cache e isso nunca muda. Assim, essa abordagem nos permite usar principalmente
a consulta particionada mais barata e mais eficiente para a maioria das solicitações.

O uso de um índice global para consultar diretamente as leituras do dispositivo poderá ser mais eficiente
se o armazenamento em cache do dispositivo para o mapeamento de infraestrutura não funcionar bem para um aplicativo
especificado.

Para localizar a partição relevante para um dispositivo, consultamos a visualização `by-device`,
enviando o ID do dispositivo como a chave:

```
curl -XGET \
  'https://acme.cloudant.com/readings/_design/infrastructure-mapping/_view/by-device?keys = [ "device-123456" ] &limit=1 '
```

Isso retorna:

```json
{"total_rows":5,"offset":0,"rows":[
{
    "id":"bridge-9876:device-123456-20181211T11:13:24.123456Z",
    "key":"device-123456",
    "value":"bridge-9876"
}
]}
```

Nós temos nossa chave de partição no campo `valor`da linha incluída:
`ponte-9876`.

#### Consultando todos os resultados para um dispositivo
{: #querying-for-all-results-for-a-device}

Para obter os resultados de um dispositivo, emitimos uma consulta de partição para o dispositivo
dentro da partição `bridge-9876`. Um seletor de {{site.data.keyword.cloudant_short_notm}}Consulta padrão é
usado, como se um estivesse emitindo uma consulta global.

_query.json:_

```json
{
   "selector": {
      "deviceID": {
         "$eq": "device-123456"
      }
   }
}
```

A partição é integrada no caminho HTTP ao emitir a solicitação para o {{site.data.keyword.cloudant_short_notm}}:

```
curl -XPOST \
    'https://acme.cloudant.com/readings/_partition/bridge-1234/_find' \
    -d @query.json
```

#### Consultando resultados recentes para um dispositivo
{: #querying-for-recent-results-for-a-device}

Para obter os resultados de um dispositivo, emitimos uma consulta de partição para o dispositivo
dentro da partição `bridge-9876`. O seletor é apenas um pouco mais
complicado, mas ainda o mesmo que uma consulta global equivalente.

_query.json, supondo que hoje seja 13 de dezembro de 2018:_

```json
{
   "selector": {
      "deviceID": {
         "$eq": "device-123456"
      },
      "ts": {
         "$gte": "20181213"
      }
   }
}
```

A partição é integrada no caminho HTTP ao emitir a solicitação para o {{site.data.keyword.cloudant_short_notm}}:

```
curl -XPOST \
    'https://acme.cloudant.com/readings/_partition/bridge-1234/_find' \
    -d @query.json
```
