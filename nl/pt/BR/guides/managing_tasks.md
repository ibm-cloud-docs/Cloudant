---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: curl and jq basics, monitor view builds and search indexes, estimate time to complete task, monitor replication, troubleshooting

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

# Gerenciando tarefas
{: #managing-tasks}

Criar novos índices sobre muitos dados ou replicar um banco de dados grande pode levar muito tempo.
{: shortdesc}

Portanto, como é possível determinar se suas tarefas estão progredindo
ou se foram concluídas?
O [terminal `_active_tasks`](/docs/services/Cloudant?topic=cloudant-active-tasks#active-tasks) fornece informações sobre todas as tarefas em andamento.
No entanto,
se você iniciar muitas tarefas,
algumas delas poderão ser planejadas para execução posterior e não aparecerão sob `_active_tasks`
até que tenham sido iniciadas.

Este guia mostra como usar o terminal `_active_tasks` para monitorar tarefas de longa execução.
O comando `curl` é usado para acessar o terminal.
O processador JSON da linha de comandos `jq` é usado para processar a resposta JSON.

Como este é um tutorial focado em tarefas,
ele cobre apenas o que é essencial para realizar essa tarefa.
Para obter mais informações, consulte a [Referência de API](/docs/services/Cloudant?topic=cloudant-api-reference-overview#api-reference-overview) para obter um guia completo para as opções disponíveis.

## Noções básicas do `curl` e do `jq`
{: #curl-and-jq-basics}

Para obter todas as tarefas ativas e formatar a saída adequadamente,
chame sua conta usando `curl`
e canalize a saída como `jq`.

`jq` permite filtrar uma lista de documentos por seus valores de campo.
Isso facilita obter todos os documentos de replicação
ou os detalhes apenas de uma tarefa de indexação de visualização específica.
A referência de API possui mais informações sobre as opções.

*Exemplo de como obter e formatar uma lista de tarefas ativas:*

```sh
curl 'https://username:password@username.cloudant.com/_active_tasks' | jq '.'
```
{: codeblock}

## Monitorando construções de visualização e índices de procura
{: #monitoring-view-builds-and-search-indexes}

Os índices de visualização são reconstruídos quando um documento de design é atualizado.
Uma atualização em qualquer uma das visualizações faz com que todas as visualizações no documento sejam reconstruídas.

Os índices de procura são reconstruídos somente quando suas funções de índice correspondentes são mudadas.
Para cada índice de procura que está sendo construído e para cada documento de design com visualizações que são mudadas,
uma nova tarefa é criada para cada réplica de cada shard em um cluster.

Por exemplo,
se houver 24 shards,
com três réplicas cada um
e você atualizar dois índices de procura,
então 24 x 3 x 2 = 144 tarefas serão executadas.

Para localizar todas as tarefas de indexação de visualização,
canalize a saída `curl` como `jq`
e deixe-a filtrar os documentos na matriz por seu campo de tipo.
Um comando correspondente trabalha para tarefas de indexação de procura.

Em cada caso,
os resultados de se procurar uma lista de tarefas de indexação será uma lista de objetos JSON:
um para cada uma das tarefas ativas localizadas.

*Exemplo de como localizar todas as tarefas de indexação de visualização, filtrando pelo tipo `indexer`:*

```sh
curl -s 'https://username:password@username.cloudant.com/_active_tasks' | jq '.[] | select(.type=="indexer")'
```
{: codeblock}

*Exemplo de como localizar todas as tarefas de indexação de procura, filtrando pelo tipo `search_indexer`:*

```sh
curl -s 'https://username:password@username.cloudant.com/_active_tasks' | jq '.[] | select(.type=="search_indexer")'
```
{: codeblock}

*Exemplo de resultados depois de procurar tarefas de indexação de visualização:*

```json
{
    "total_changes": 6435,
    "started_on": 1371118332,
    "user": "username",
    "updated_on": 1371118334,
    "type": "indexer",
    "node": "dbcore@db6.meritage.cloudant.net",
    "pid": "<0.16366.6103>",
    "changes_done": 364,
    "database": "shards/40000000-7fffffff/username/database",
    "design_document": "_design/ngrams"
}
```
{: codeblock}

## Estimando o tempo para concluir uma tarefa
{: #estimating-the-time-to-complete-a-task}

Para estimar o tempo necessário até que a tarefa de indexação seja concluída,
monitore o número de `changes_done` e compare esse valor com `total_changes`.
Por exemplo,
se `changes_done` avançar por 250 por segundo
e `total_changes` for 1.000.000,
a tarefa deverá levar 1.000.000 / 250 = 4.000 segundos
ou aproximadamente 66 minutos, para ser concluída.

Estimativas do tempo para concluir uma tarefa de indexação não podem ser 100% precisas. O tempo real para concluir a tarefa depende dos fatores a seguir:

-   O tempo que leva para processar cada documento.
    Por exemplo,
uma visualização pode verificar o tipo de um documento primeiro
e só emitir novas entradas de índice para um tipo.
-   O tamanho dos documentos.
-   A carga de trabalho atual no cluster.

Você deve supor que esses fatores podem ser combinados para produzir imprecisão considerável em sua estimativa.

*Exemplo de como extrair o campo `changes_done` usando `jq`:*

```sh
curl ... | jq '.[] | select(.type=="search_indexer") | .changes_done'
```
{: codeblock}

## Monitorando a replicação
{: #monitoring-replication}

Para localizar todas as tarefas de replicação,
canalize a saída `curl` como `jq`
e filtre os documentos na matriz por seu campo de tipo.

Para facilitar a seleção das informações sobre um processo de replicação por meio da lista de tarefas ativas,
inicie o processo de replicação criando um documento no banco de dados `_replicator`
e configure seu campo `_id` para um valor conhecido.

*Exemplo de como localizar todas as tarefas de replicação, filtrando pelo tipo `replicação`:*

```sh
curl -s 'https://username:password@username.cloudant.com/_active_tasks' | jq '.[] | select(.type=="replication")'
```
{: codeblock}

*Exemplo de como localizar uma tarefa de replicação específica, filtrando por uma identidade de documento conhecida:*

```sh
curl ... | jq '.[] | select(.doc_id=="ID")'
```
{: codeblock}

*Exemplo de como localizar uma tarefa de replicação específica, filtrando por um `replication_id` conhecido:*

```sh
curl ... | jq '.[] | select(.replication_id=="ID")'
```
{: codeblock}

*Exemplo de resultado depois de procurar uma tarefa de replicação:*

```json
{
    "started_on": 1371094220,
    "source_seq": "62960-sakdjflksdfjsdlkafjalskdfjlsakfjlasdkjksald",
    "source": "",
    "revisions_checked": 12,
    "continuous": true,
    "doc_id": null,
    "doc_write_failures": 0,
    "docs_read": 12,
    "target": "",
    "type": "replication",
    "updated_on": 1371118477,
    "user": "username",
    "checkpointed_source_seq": "61764-dskfjalsfjsalkfjssadjfhasdfkjhsdkfhsdkf",
    "changes_pending": 1196,
    "pid": "<0.9955.4120>",
    "node": "dbcore@db7.meritage.cloudant.net",
    "docs_written": 12,
    "missing_revisions_found": 12,
    "replication_id": "asfksdlfkjsadkfjsdalkfjas+continuous+create_target"
}
```
{: codeblock}

## Resolução de problemas de tarefas paradas
{: #troubleshooting-stuck-tasks}

### Uma tarefa está presa?
{: #is-a-task-stuck-}

Para uma replicação
única, não contínua,
em que o banco de dados de origem não é atualizado significativamente durante a replicação,
o valor `changes_pending` informa quantos documentos permanecem para serem processados.
Isso significa que o valor `changes_pending` é um bom indicador de quando a replicação está para ser concluída.

Para uma replicação contínua,
você está mais interessado em como o número de documentos processados muda ao longo do tempo
e se o valor `changes_pending` aumentará.
Se `changes_pending` aumentar,
mas `revisions_checked` permanecer constante por um tempo,
a replicação provavelmente estará paralisada.
Se `changes_pending` aumentar
e `revisions_checked` também aumentar,
isso poderá indicar que a replicação não pode acompanhar o volume de dados incluído
ou atualizado
no banco de dados.

### O que fazer com uma tarefa presa?
{: #what-to-do-about-a-stuck-task-}

Para resolver uma replicação paralisada,
talvez você tenha que [cancelar o processo de replicação](/docs/services/Cloudant?topic=cloudant-replication-api#canceling-a-replication) e iniciá-lo novamente.

Se isso não ajudar,
a replicação poderá estar paralisada porque o usuário que acessa os bancos de dados de origem ou de destino
não tem permissões de gravação.

A replicação faz uso de [pontos de verificação](/docs/services/Cloudant?topic=cloudant-replication-guide#checkpoints), o que significa que o conteúdo que já está replicado e inalterado não precisará ser replicado novamente se a replicação for reiniciada.
{: note}

Se você tiver criado o processo de replicação criando um documento no banco de dados `_replicator`,
também poderá verificar o status da replicação lá.
