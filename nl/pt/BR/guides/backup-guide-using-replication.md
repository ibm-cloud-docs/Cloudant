---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: incremental backups, create an incremental backup, restore a database, how to back up example, how to restore example

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

# Incrementais de replicação
{: #replication-incrementals}

Este guia contém orientação mais antiga ou 'descontinuada' sobre o backup do {{site.data.keyword.cloudantfull}}. Para obter orientação de backup atual,
veja o guia [Recuperação de desastre e backup](/docs/services/Cloudant?topic=cloudant-disaster-recovery-and-backup#disaster-recovery-and-backup).
{: deprecated}

Os backups de banco de dados protegem seus dados contra perda ou danos em potencial.
{: shortdesc}

É possível usar o recurso de replicação do {{site.data.keyword.cloudant_short_notm}} para criar um backup de banco de dados
e armazená-los em um cluster do {{site.data.keyword.cloudant_short_notm}}.
Será possível, em seguida, restaurar dados,
bancos de dados inteiros
ou documentos JSON específicos
desses backups em seu cluster de produção.

Usando a replicação do {{site.data.keyword.cloudant_short_notm}},
um backup de banco de dados armazena o conteúdo do banco de dados em um ponto de verificação.
É possível 'recuperar' para um ponto de verificação específico.
O ponto de verificação não é específico de um horário preciso.
Em vez disso,
é um registro do banco de dados de como era depois de mudanças específicas terem ocorrido durante o período de backup.
Dessa maneira,
um backup pode preservar o estado de seu banco de dados em um horário selecionado.

## Backups incrementais
{: #incremental-backups}

Se você for um cliente corporativo, um recurso de backup incremental diário estará disponível. Para obter mais informações, consulte [Recuperação de desastre e backup](/docs/services/Cloudant?topic=cloudant-disaster-recovery-and-backup#disaster-recovery-and-backup).

Se você não for um cliente corporativo
ou preferir criar seus próprios backups,
será possível usar o recurso de replicação do {{site.data.keyword.cloudant_short_notm}} para criar um backup de banco de dados.

Uma abordagem simples é replicar o banco de dados inteiro para um banco de dados de backup com data.
Esse método funciona e é fácil de executar.
Mas se você precisar de backups para múltiplos momentos,
como sete backups diários e quatro semanais,
deverá armazenar uma cópia completa do banco de dados em cada novo banco de dados de backup.
Uma cópia completa poderá requerer uso de disco significativo,
especialmente se o banco de dados for grande.

Como alternativa,
os backups incrementais são uma boa solução para armazenar
somente os documentos que mudaram desde o último backup.

O processo é simples.
Inicialmente,
você cria um backup do banco de dados inteiro.
Após o primeiro backup,
você executa backups 'incrementais' diários,
fazendo backup _somente_ do que tiver sido mudado no banco de dados desde o último backup.
Essa replicação se torna um backup diário.

É possível configurar o acionamento de um backup em intervalos regulares.
No entanto,
cada intervalo deve ser de 24 horas ou mais. Ou seja,
é possível executar backups diários, mas não backups de hora em hora.
{: note}

## Criando um backup incremental
{: #creating-an-incremental-backup}

Os backups incrementais salvam apenas as diferenças ou 'deltas' entre os backups.
A cada 24 horas,
o banco de dados de origem é replicado para um banco de dados de destino.

A replicação usa valores de sequência para identificar os documentos que foram mudados durante o período de 24 horas.
A operação de backup funciona usando a replicação para obter e armazenar um ponto de verificação.
Um ponto de verificação é outro documento com um nome interno.
A operação de backup cria o nome de uma combinação da data e do nome da tarefa de backup.
Esse nome facilita a identificação de pontos de verificação durante o processo de recuperação ou de acumulação.

Para criar um backup incremental,
execute as etapas a seguir:

1.  Localize o ID do documento de ponto de verificação da última replicação.
    Ele fica armazenado no campo `_replication_id` do documento de replicação
localizado no banco de dados `_replicator`.
2.  Abra o documento de ponto de verificação em `/$DATABASE/_local/$REPLICATION_ID`,
em que `$REPLICATION_ID` é o ID localizado na etapa anterior
e `$DATABASE` é o nome da origem ou do banco de dados de destino.
    O documento geralmente existe em ambos os bancos de dados,
mas pode existir apenas em um.
3.  Procure o campo `recorded_seq` do primeiro elemento
na matriz do histórico localizada no documento de ponto de verificação.
4.  Replique para o novo banco de dados de backup incremental,
    configurando o campo [`since_seq`](/docs/services/Cloudant?topic=cloudant-replication-api#the-since_seq-field)
    no documento de replicação para o valor do campo `recorded_seq` localizado na etapa anterior.

Por definição, o uso da opção `since_seq` efetua bypass do recurso de ponto de verificação normal. Somente use `since_seq` com cuidado. 
{: note}

## Restaurando um banco de dados
{: #restoring-a-database}

Para restaurar um banco de dados de backups incrementais,
você replicará cada backup incremental em um novo banco de dados,
começando com o incremento mais recente.

É possível iniciar com o backup mais antigo
e, em seguida, aplicar os backups subsequentes em ordem.
No entanto,
replicar do backup incremental mais recente primeiro é mais rápido
porque os documentos atualizados são gravados apenas no banco de dados de destino uma vez.
Todos os documentos anteriores a uma cópia já presente no novo banco de dados são ignorados.


## Um exemplo
{: #an-example}

Este exemplo mostra como:

1.  Configurar bancos de dados para usar o backup incremental.
2.  Executar um backup completo.
3.  Configurar e executar um backup incremental.
4.  Restaurar um backup.

### Constantes que são usadas aqui
{: #constants-that-are-used-here}

```sh
# save base URL and the content type in shell variables
$ url='https://$ACCOUNT:$PASSWORD@$ACCOUNT.cloudant.com'
$ ct='Content-Type: application-json'
```
{: codeblock}

Suponha que você precise fazer backup de um banco de dados.
Você deseja criar um backup completo na segunda-feira
e um backup incremental na terça-feira.

É possível usar os comandos `curl` e [`jq` ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://stedolan.github.io/jq/){: new_window}
para executar essas operações.
Na prática,
você poderia usar qualquer cliente HTTP.

### Etapa 1: verificar se você tem três bancos de dados
{: #step-1-check-that-you-have-three-databases}

Para este exemplo,
você requer três bancos de dados:

-   O banco de dados original,
contendo os dados dos quais você deseja fazer backup.
-   Dois bancos de dados incrementais,
para segunda-feira (`backup-monday`) e terça-feira (`backup-tuesday`).

_Exemplo mostrando como verificar se você tem três bancos de dados para usar neste exemplo, usando HTTP:_

```http
PUT /original HTTP/1.1
PUT /backup-monday HTTP/1.1
PUT /backup-tuesday HTTP/1.1
```
{: codeblock}

_Exemplo mostrando como verificar se você tem três bancos de dados para usar neste exemplo,
usando a linha de comandos:_

```sh
$ curl -X PUT "${url}/original"
$ curl -X PUT "${url}/backup-monday"
$ curl -X PUT "${url}/backup-tuesday"
```
{: codeblock}

### Etapa 2: criar o banco de dados `_replicator`
{: #step-2-create-the-_replicator-database}

Se ele não existir, crie o banco de dados `_replicator`.

*Criando o banco de dados `_replicator` usando HTTP:*

```http
PUT /_replicator HTTP/1.1
```
{: codeblock}

*Criando o banco de dados `_replicator` usando a linha de comandos:*

```sh
curl -X PUT "${url}/_replicator"
```
{: pre}

### Etapa 3: fazer backup do banco de dados inteiro (original)
{: #step-3-back-up-the-entire-original-database}

Na segunda-feira,
você deseja fazer backup de todos os dados pela primeira vez.
Crie esse backup replicando tudo do `original` para `backup-monday`.

_Executando um backup completo na segunda-feira usando HTTP:_

```http
PUT /_replicator/full-backup-monday HTTP/1.1
Content-Type: application/json
```
{: codeblock}

_Executando um backup completo na segunda-feira usando a linha de comandos:_

```sh
$ curl -X PUT "${url}/_replicator/full-backup-monday" -H "$ct" -d @backup-monday.json
# where backup-monday.json describes the backup.
```
{: codeblock}

_Documento JSON que descreve o backup completo:_
 
```json
{
    "_id": "full-backup-monday",
    "source": "${url}/original",
    "target": "${url}/backup-monday"
}
```
{: codeblock}

### Etapa 4: preparar o backup incremental parte 1 - Obter o ID de ponto de verificação
{: #step-4-prepare-incremental-backup-part-1-get-checkpoint-id}

Na terça-feira,
você deseja fazer um backup incremental,
em vez de outro backup completo.

Para iniciar o backup incremental,
você precisará de dois valores:

-   O ID do ponto de verificação.
-   [O valor `recorded_seq`](#step-5-prepare-incremental-backup-part-2-get-recorded_seq-value).

Esses valores identificam onde o último backup terminou
e determinam onde iniciar o próximo backup incremental.
Depois de obter esses valores, será possível executar o backup incremental.

Comece localizando o valor do ID de ponto de verificação.
Esse valor está armazenado no campo `_replication_id` do documento de replicação,
no banco de dados `_replicator`.

*Obtendo o ID do ponto de verificação para ajudar a localizar o valor `recorded_seq`, usando HTTP:*

```http
GET /_replicator/full-backup-monday HTTP/1.1
# Search for the value of _replication_id
```
{: codeblock}

*Obtendo o ID do ponto de verificação para ajudar a localizar o valor `recorded_seq`, usando a linha de comandos:*

```sh
replication_id=$(curl "${url}/_replicator/full-backup-monday" | jq -r '._replication_id')
```
{: pre}

### Etapa 5: preparar o backup incremental parte 2 - Obter o valor `recorded_seq`
{: #step-5-prepare-incremental-backup-part-2-get-recorded_seq-value}

Depois de obter o ID do ponto de verificação,
use-o para obter o valor `recorded_seq`.
Esse valor é localizado no primeiro elemento da matriz de histórico no documento `/_local/${replication_id}`,
dentro do banco de dados original.

Agora você tem o valor `recorded_seq`.
Esse valor identifica o último documento que foi replicado do banco de dados original.

*Obtendo o `recorded_seq` do banco de dados original usando HTTP:*

```http
GET /original/_local/${replication_id} HTTP/1.1
# Search for the first value of recorded_seq in the history array
```
{: codeblock}

*Obtendo o `recorded_seq` do banco de dados original usando a linha de comandos:*

```sh
recorded_seq=$(curl "${url}/original/_local/${replication_id}" | jq -r '.history[0].recorded_seq')
```
{: pre}

### Etapa 6: executar um backup incremental
{: #step-6-run-an-incremental-backup}

Agora que você tem o ID do ponto de verificação e `recorded_seq`,
poderá iniciar o backup incremental da terça-feira.
Esse backup replica todas as mudanças de documento feitas _desde_ a última replicação.

Quando a replicação for concluída,
você terá um backup incremental concluído.
O backup consiste em todos os documentos no banco de dados original
e pode ser restaurado recuperando o conteúdo dos bancos de dados `backup-monday` _e_ `backup-tuesday`.

_Executando o backup incremental da terça-feira usando HTTP:_

```http
PUT /_replicator/incr-backup-tuesday HTTP/1.1
Content-Type: application/json
```
{: codeblock}

_Executando o backup incremental da terça-feira usando a linha de comandos:_

```sh
curl -X PUT "${url}/_replicator/incr-backup-tuesday" -H "${ct}" -d @backup-tuesday.json
```
{: pre}

_Documento JSON que descreve o backup incremental da terça-feira:_
 
```json
{
    "_id": "incr-backup-tuesday",
    "source": "${url}/original",
    "target": "${url}/backup-tuesday",
    "since_seq": "${recorded_seq}"
}
```
{: codeblock}

### Etapa 7: restaurar o backup de segunda-feira
{: #step-7-restore-the-monday-backup}

Para restaurar de um backup,
você replica o backup completo inicial
e quaisquer backups incrementais
em um novo banco de dados.

Por exemplo,
para restaurar o estado da segunda-feira,
você replicaria do banco de dados `backup-monday`.

_Restaurando do banco de dados `backup-monday` usando HTTP:_

```sh
PUT /_replicator/restore-monday HTTP/1.1
Content-Type: application/json
```
{: codeblock}

_Restaurando do banco de dados `backup-monday` usando a linha de comandos:_

```sh
curl -X PUT "${url}/_replicator/restore-monday" -H "$ct" -d @restore-monday.json
```
{: pre}

_Documento JSON que descreve a restauração:_
 
```json
{
    "_id": "restore-monday",
    "source": "${url}/backup-monday",
    "target": "${url}/restore",
    "create_target": true  
}
```
{: codeblock}

### Etapa 8: restaurar o backup de terça-feira
{: #step-8-restore-the-tuesday-backup}

Para restaurar o banco de dados da terça-feira,
você primeiro replica de `backup-tuesday` e, em seguida, de `backup-monday`.

A ordem não é um erro tipográfico; a intenção realmente _é_restaurar a partir de terça-feira e _então_Segunda-feira.
{: tip}

É possível restaurar na sequência cronológica,
mas usando a ordem inversa.
Os documentos que foram atualizados na terça-feira precisam ser gravados no banco de dados de destino apenas uma vez.
Versões mais antigas do documento que estiverem armazenadas no banco de dados de segunda-feira são ignoradas.

_Restaurando o backup da terça-feira, obtendo as mudanças mais recentes primeiro, usando HTTP:_

```http
PUT /_replicator/restore-tuesday HTTP/1.1
Content-Type: application/json
```
{: codeblock}

_Restaurando o backup da terça-feira, obtendo as mudanças mais recentes primeiro, usando a linha de comandos:_

```sh
curl -X PUT "${url}/_replicator/restore-tuesday" -H "$ct" -d @restore-tuesday.json
```
{: pre}

_Documento JSON que solicita restauração do backup de terça-feira:_
 
```json
{
    "_id": "restore-tuesday",
    "source": "${url}/backup-tuesday",
    "target": "${url}/restore",
    "create_target": true  
}
```
{: codeblock}

_Conclua a recuperação restaurando o backup da segunda-feira por último usando HTTP:_

```http
PUT /_replicator/restore-monday HTTP/1.1
Content-Type: application/json
```
{: codeblock}

_Conclua a recuperação restaurando o backup da segunda-feira por último usando a linha de comandos:_

```http
curl -X PUT "${url}/_replicator/restore-monday" -H "$ct" -d @restore-monday.json
```
{: pre}

_Documento JSON que solicita restauração do backup de segunda-feira:_
 
```json
{
    "_id": "restore-monday",
    "source": "${url}/backup-monday",
    "target": "${url}/restore"
}
```
{: codeblock}

## Sugestões
{: #suggestions}

Embora as informações anteriores descrevam o processo de backup básico,
cada aplicativo precisa de seus próprios requisitos e estratégias para backups.
As sugestões a seguir podem ser úteis.

### Planejando backups
{: #scheduling-backups}

As tarefas de replicação podem aumentar significativamente a carga em um cluster.
Se você estiver fazendo backup de vários bancos de dados,
será melhor escalonar as tarefas de replicação para horários diferentes
ou para um horário em que o cluster estiver menos ocupado.

#### Mudando a prioridade de E/S de um backup
{: #changing-the-io-priority-of-a-backup}

É possível mudar a prioridade de tarefas de backup
ajustando o valor do campo `x-cloudant-io-priority` dentro do documento de replicação.

1.  Nos campos de origem e de destino, mude o objeto `headers`.
2.  No objeto headers,
mude o valor do campo `x-cloudant-io-priority` para `"low"`.

_Exemplo de documento JSON que configura a prioridade de E/S:_

```json
{
    "source": {
        "url": "https://user:pass@example.com/db",
        "headers": {
            "x-cloudant-io-priority": "low"
        }
    },
    "target": {
        "url": "https://user:pass@example.net/db",
        "headers": {
            "x-cloudant-io-priority": "low"
        }
    }
}
```
{: codeblock}

### Fazendo backup de documentos de design
{: #backing-up-design-documents}

Se você incluir documentos de design em seu backup,
os índices serão criados no destino de backup.
Essa prática desacelera o processo de backup e usa quantias desnecessárias de espaço em disco.
Se você não requerer índices em seu sistema de backup,
use uma função de filtro com suas replicações para filtrar documentos de design.
Também é possível usar essa função de filtro para excluir outros documentos não desejados.

### Fazendo backup de múltiplos bancos de dados
{: #backing-up-multiple-databases}

Se o seu aplicativo usar um banco de dados por usuário
ou permitir que cada usuário crie vários bancos de dados,
será necessário criar uma tarefa de backup para cada novo banco de dados.
Certifique-se de que suas tarefas de replicação não iniciem no mesmo horário.

## Precisa de ajuda?
{: #need-help-}

Replicação e backups podem ser complicados.
Se precisar de ajuda,
consulte o [Guia de replicação](/docs/services/Cloudant?topic=cloudant-replication-guide#replication-guide)
ou entre em contato com a
[equipe de suporte do {{site.data.keyword.cloudant_short_notm}} ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](mailto:support@cloudant.com){: new_window}.
