---

copyright:
  years: 2017, 2018
lastupdated: "2017-11-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-05-04 -->

# O que há de novo no {{site.data.keyword.cloudant_short_notm}}

Mantenha-se atualizado com as mudanças e atualizações para o {{site.data.keyword.cloudantfull}}.
{:shortdesc}

## Hardware dedicado

Uma nova [instância de serviço dedicado](bluemix.html#dedicated-plan) está disponível.

## Compilação 6233

- Introduz um novo Planejador de replicação.
  Além dos benefícios de desempenho e dos terminais adicionais,
o planejador muda a maneira com que o status de replicação é monitorado e relatado.
  Especificamente,
a gravação de atualizações de status em um documento de replicação não é mais suportado.
  Para obter mais informações sobre essa mudança importante,
veja detalhes sobre o [planejador de replicação](../api/advanced_replication.html#the_replication_scheduler).
  Entre em contato com o suporte do {{site.data.keyword.cloudant_short_notm}} abrindo um chamado usando o Painel do {{site.data.keyword.cloudant_short_notm}} se você tiver quaisquer perguntas ou interesses.

## Compilação 6069

- Anteriormente, uma tarefa de replicação que travava por algum motivo resultava em uma atualização no documento de replicação,
seguido de uma nova tentativa de iniciar uma nova replicação.
  Sob algumas circunstâncias,
esse comportamento poderia continuar indefinidamente: muitas duplicatas da mesma mensagem de erro.
  Uma correção foi introduzida para que o documento de replicação não fosse atualizado, a menos que o motivo do erro tivesse mudado.
- Se o documento de design destinado a especificar um índice geoespacial for inválido,
uma tentativa de recuperar informações sobre o índice usando
o [terminal `_geo_info`](../api/cloudant-geo.html#obtaining-information-about-a-cloudant-geo-index)
resultará em uma resposta [HTTP `404`](http.html#404).
- Incluído suporte para o operador [`$allmatch`](../api/cloudant_query.html#the-allmatch-operator).

## Compilação 5834

- O comprimento máximo de um `id` de documento é agora 7.168 caracteres (7k).

## Compilação 5728

- O {{site.data.keyword.cloudant_short_notm}} é mais tolerante com documentos do usuário malformados armazenados no banco de dados `_users`.
  Os documentos do usuário devem ser estruturados e preenchidos para obedecer aos
[Requisitos de CouchDB do Apache Software Foundation ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://docs.couchdb.org/en/2.0.0/intro/security.html#users-documents){:new_window}.

## Compilação 5638

-   Introduz os novos parâmetros de consulta "stable" e "update" para visualizações.
-   O replicador não tentará mais para sempre se não puder gravar pontos de verificação no banco de dados de origem.

## Compilação 5421

-	Os feeds de mudança suportam filtros baseados em visualização.
-	Os feeds de mudança suportam o filtro `_doc_ids`.
-	As solicitações de `POST` são suportadas para `_changes`.
-	`_all_docs` e `_changes` suportam o parâmetro `attachments=true`.
-	Suporte para os recursos do banco de dados `_users` do CouchDB 1.6, incluindo hashing do lado do servidor de senhas quando documentos são criados no banco de dados `_users`.
-	O terminal `/_bulk_get` para reduzir o número de solicitações usadas na replicação para clientes móveis.
-	Os metadados do documento de design contêm um campo `update pending`.
-	O {{site.data.keyword.cloudant_short_notm}} Query não retornará mais um erro se nenhum índice válido existir.

### Mudanças na quebra/comportamento

Tarefas ativas

-   As entradas do indexador na resposta `_active_tasks` não relatam mais o campo `user`.
-   As entradas do indexador de procura na resposta `_active_tasks` não relatam mais o campo `user`.

Visualizações

-   A normalização de valores de chaves do Unicode é consistente entre os resultados da visualização reduzida e não reduzida. Se a ordenação bruta for especificada em um documento de design, a ordem do resultado poderá mudar como resultado desta correção.
-   Ao consultar uma visualização ou um banco de dados `_all_docs`, será um erro especificar o parâmetro `keys` e qualquer um dos parâmetros `key`, `startkey` e `endkey`.
-   Será um erro passar os parâmetros `startkey` e `endkey` para uma visualização se for impossível a correspondência para qualquer linha. Por exemplo, quando o `startkey` for maior que o parâmetro `endkey` para `descending=false` ou quando o parâmetro `startkey` for menor que o parâmetro `endkey` para `descending=true`, o {{site.data.keyword.cloudant_short_notm}} retornará o erro `400 Bad Request`.
-   Quando `dbcopy` estiver configurado em um documento de visualização, ele será transformado automaticamente no campo `options` em um documento de design. 

Documentos de design

-   Validação mais rigorosa de documentos de design. Não se espera que essa validação cause problemas com documentos de design existentes, mas documentos de design malformados falham ao serem salvos.
-   As visualizações gravadas em um idioma não suportado respondem com um `error` de `unknown_query_language`. Anteriormente, a resposta era um `reason` de `unknown_query_language`.
-   Quando um redutor nulo for usado para colocar um documento de design de banco de dados, o sistema responderá com o motivo de erro de `'(null)'`; anteriormente ele retornava `((new String("null")))`.
-   Se `updates` for especificado em um documento de design, ele não deverá ter um valor nulo.

Autenticação

-   Os metadados `_session` `authentication_handlers` não contêm mais `["delegated", "local"]`.

Documentos do usuário

-   Valide a estrutura de documentos do usuário criados no banco de dados `_users`. Após o upgrade de DBNext, os documentos do usuário deverão obedecer aos requisitos de CouchdDB do ASF. Anteriormente, o {{site.data.keyword.cloudant_short_notm}} não validava a estrutura de documentos do usuário. 

Replicação 

-   Os documentos do replicador preservam a última mensagem de erro no campo JSON `_replication_state_reason`. O campo permanecerá mesmo após as reinicializações da replicação e ficará no estado `triggered`. Essa mudança ajuda o código replicador a detectar e evitar a gravação do mesmo erro no documento repetidamente.
-   Um erro durante a replicação não atualiza o documento de replicação, a menos que o motivo do erro mude. Anteriormente, quando ocorria um erro durante a replicação, um loop infinito era iniciado gerando shards consideráveis.  

Conjunto de resultados

-   O terminal `_db_updates` retorna um conjunto de resultados contendo uma chave chamada `db_name`. Anteriormente, ele retornava um conjunto de resultados com uma chave chamada `dbname`.
-   Configurar o comprimento máximo do ID do documento. Anteriormente, não era possível definir um comprimento máximo do ID do documento.

`dbcopy`

- O recurso `dbcopy` pode causar problemas sob algumas circunstâncias.
  As informações sobre o recurso foram removidas da documentação.
  O uso de `dbcopy` é fortemente desencorajado.
