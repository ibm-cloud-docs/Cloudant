---

copyright:
  years: 2017
lastupdated: "2017-07-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-07-12 -->

# Mudanças na quebra e no comportamento

Este documento resume as mudanças no comportamento para as liberações do Cloudant.
{:shortdesc}

## Incompatibilidade entre o CouchDB versão 1.6 e o Cloudant versão 2.0.0

-   Existe uma incompatibilidade entre a versão mais recente do Cloudant e o código base baseado no CouchDB 1.6. Na  
versão mais antiga do Cloudant, se você incluir um parâmetro de consulta ("reduce=false") no corpo da solicitação, o parâmetro
no corpo da solicitação será ignorado enquanto o parâmetro na URL de solicitação será respeitado. Em versões recentes do
Cloudant, o parâmetro de consulta ("reduce=false") no corpo da solicitação não é ignorado.

## Mensagem de erro revisada

- A mensagem de erro que ocorre ao tentar colocar um anexo de documento com uma revisão não existente mudou para um erro 409 com as informações a seguir:

	```
	{"error":"not_found","reason":"missing_rev"}
	```

## X-Frame-Options

A configuração `X-Frame-Options` é um cabeçalho de resposta que controla se uma resposta de HTTP poderá ser integrada em um `<frame>`, `<iframe>` ou `<object>`. Esse recurso de segurança ajuda a evitar clickjacking.

É possível configurar essa opção com base nas configurações de CORS. Se CORS estiver ativado, `X-Frame-Options` será ativado automaticamente e enviará o cabeçalho de resposta `X-Frame-Options: DENY`, por padrão. Se um cabeçalho do HOST de solicitação corresponder à URL listada na seção de origem de CORS, um cabeçalho de resposta `X-Frame-Options: ALLOW-FROM URL` será retornado.
 
Essa mudança pode afetar clientes que estejam acessando o banco de dados diretamente do navegador. Se você vir a mensagem de erro "X-Frame-Options: DENY"
e ela estiver interrompendo o seu serviço, o CORS deverá ser ativado, [Definindo a configuração do CORS](../api/cors.html#setting-the-cors-configuration). Depois de ativar o CORS, inclua o valor do cabeçalho do HOST enviado na solicitação
na lista de `origins` permitidas.

## Tarefas ativas

-   As entradas do indexador na resposta `_active_tasks` não relatam mais o campo `user`.
-   As entradas do indexador de procura na resposta `_active_tasks` não relatam mais o campo `user`.

## Visualizações

-   A normalização de valores de chaves do Unicode é consistente entre os resultados da visualização reduzida e não reduzida. Se a ordenação bruta for especificada em um documento de design, a ordem do resultado poderá mudar como resultado desta correção.
-   Ao consultar uma visualização ou um banco de dados `_all_docs`, será um erro especificar o parâmetro `keys` e qualquer um dos parâmetros `key`, `startkey` e `endkey`.
-   Será um erro passar os parâmetros `startkey` e `endkey` para uma visualização se for impossível a correspondência para qualquer linha. Por exemplo, quando o parâmetro `startkey` for maior que o parâmetro `endkey` para `descending=false` ou quando o parâmetro `startkey` for menor que o parâmetro `endkey` para `descending=true`, o Cloudant retornará o erro `400 Bad Request`.
-   Quando `dbcopy` estiver configurado em um documento de visualização, ele será transformado automaticamente no campo `options` em um documento de design. 

## Documentos de design

-   Validação mais rigorosa de documentos de design. Não se espera que essa validação cause problemas com documentos de design existentes, mas documentos de design malformados falham ao serem salvos.
-   As visualizações gravadas em um idioma não suportado respondem com um `error` de `unknown_query_language`. Anteriormente, a resposta era um `reason` de `unknown_query_language`.
-   Quando um redutor nulo for usado para colocar um documento de design de banco de dados, o sistema responderá com o motivo de erro de `'(null)'`; anteriormente ele retornava `((new String("null")))`.
-   Se `updates` for especificado em um documento de design, ele não deverá ter um valor nulo.

## Autenticação

-   Os metadados `_session` `authentication_handlers` não contêm mais `["delegated", "local"]`.

## Documentos do usuário

-   Valide a estrutura de documentos do usuário criados no banco de dados `_users`. Após o upgrade de DBNext, os documentos do usuário deverão obedecer aos requisitos de CouchdDB do ASF. Anteriormente, o Cloudant não validava a estrutura de documentos do usuário. 

## Replicação 

-   Os documentos do replicador preservam a última mensagem de erro no campo JSON `_replication_state_reason`. O campo permanecerá mesmo após as reinicializações da replicação e ficará no estado `triggered`. Essa mudança ajuda o código replicador a detectar e evitar a gravação do mesmo erro no documento repetidamente.
-   Um erro durante a replicação não atualiza o documento de replicação, a menos que o motivo do erro mude. Anteriormente, quando ocorria um erro durante a replicação, um loop infinito era iniciado gerando shards consideráveis.  

## Conjunto de resultados

-   O terminal `_db_updates` retorna um conjunto de resultados contendo uma chave chamada `db_name`. Anteriormente, ele retornava um conjunto de resultados com uma chave chamada `dbname`.
-   Configurar o comprimento máximo do ID do documento. Anteriormente, não era possível definir um comprimento máximo do ID do documento.

## `dbcopy`

- O recurso `dbcopy` pode causar problemas sob algumas circunstâncias.
As informações sobre o recurso foram removidas da documentação.
O uso de `dbcopy` é fortemente desencorajado.
