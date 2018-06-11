---

copyright:
  years: 2017, 2018
lastupdated: "2017-11-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# Criando um backup

Esse tutorial demonstra como usar o
utilitário de linha de comandos [CouchBackup ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.npmjs.com/package/@cloudant/couchbackup){:new_window}
para fazer backup e restaurar uma instância do CouchDB ou do {{site.data.keyword.cloudant_short_notm}}. O CouchBackup faz backup
do banco de dados em um arquivo. Se o banco de dados falhar, será possível usar o arquivo de backup para
restaurar as informações para um banco de dados existente. 
{:shortdesc}

## Antes de iniciar

Instale o CouchBackup executando o comando `install`. 

```sh
npm install -g @cloudant/couchbackup
```
{:codeblock}

## Criando um banco de dados

Crie um banco de dados `couchbackup-demo` de amostra
para uso neste tutorial.

1.  Crie um banco de dados executando este comando:
    
    ```sh
    curl https://username:password@myhost.cloudant.com/couchbackup-demo -X PUT
    ```
    {:codeblock}
    
2.  Revise os resultados.
    
    ```json
    {
      "ok": true
    }
    ```
    {:codeblock}

## Criando documentos no banco de dados

Os documentos criados neste exercício contêm os dados dos quais você
fará backup e restaurará em exercícios posteriores. 

1.  Copie o texto de amostra para um arquivo de dados chamado `bulkcreate.dat` para criar os cinco documentos.
    
    ```json
    {
        "docs": 
        [
            { 
                "_id": "doc1",
                "firstname": "Sally",
                "lastname": "Brown",
                "age": 16,
                "location": "New York City, NY"
            },
            { 
                "_id": "doc2",
                "firstname": "John",
                "lastname": "Brown",
                "age": 21,
                "location": "New York City, NY"
            },
            {
                "_id": "doc3",
                "firstname": "Greg",
                "lastname": "Greene",
                "age": 35,
                "location": "San Diego, CA"
            },
            {
                "_id": "doc4",
                "firstname": "Anna",
                "lastname": "Greene",
                "age": 44,
                "location": "Baton Rouge, LA"
            },
            {
                "_id": "doc5",
                "firstname": "Lois",
                "lastname": "Brown",
                "age": 33,
                "location": "Syracuse, NY"
            }
        ]
    }
    ```
    {:codeblock}
    
2.  Execute este comando para criar os documentos:
    
    ```sh
    curl https://username:password@myhost.cloudant.com/couchbackup-demo/_bulk_docs -X POST -H "Content-Type: application/json" -d \@bulkcreate.dat
    ```
    {:codeblock}
    
3.  Revise os resultados.
    
    ```json
    [
      {
        "ok": true,
        "id": "doc1",
        "rev": "1-57a08e644ca8c1bb8d8931240427162e"
      },
      {
        "ok": true,
        "id": "doc2",
        "rev": "1-bf51eef712165a9999a52a97e2209ac0"
      },
      {
        "ok": true,
        "id": "doc3",
        "rev": "1-9c9f9b893fcdd1cbe09420bc4e62cc71"
      },
      {
        "ok": true,
        "id": "doc4",
        "rev": "1-6aa4873443ddce569b27ab35d7bf78a2"
      },
      {
        "ok": true,
        "id": "doc5",
        "rev": "1-d881d863052cd9681650773206c0d65a"
      }
    ]
    ```
    {:codeblock}
    
## Configurando uma variável de ambiente

É possível usar variáveis de ambiente e opções de linha de comandos para especificar a
URL e o banco de dados para a instância do CouchDB ou do {{site.data.keyword.cloudant_short_notm}} que você deseja trabalhar
com o CouchBackup. 

Neste tutorial, configuramos o `COUCH_URL` e especificamos o banco de dados usando o parâmetro `--db`. 

Configure a variável de ambiente `COUCH_URL` para especificar a URL para a instância do CouchDB ou do {{site.data.keyword.cloudant_short_notm}}.

```sh
export COUCH_URL=https://username:password@myhost.cloudant.com
```
{:codeblock}

## Fazendo backup de um banco de dados

O utilitário CouchBackup faz backup do banco de dados em um arquivo de texto para preservar
seus dados e facilitar a restauração. 

1.  Execute o comando `couchbackup` para direcionar o conteúdo de seu banco de dados para um arquivo de texto. 
 
    ```sh
    couchbackup --db couchbackup-demo > couchbackup-demo-backup.txt
    ```
    {:codeblock}

2.  Revise os resultados. 
    
    ```sh
    
    ================================================================================
    Performing backup on https://****:****@myhost.cloudant.com/couchbackup-demo using configuration:
    {
        "bufferSize": 500,
        "log": "/var/folders/r7/vtctv4695hj_njxmr2hj4jyc0000gn/T/tmp-3132gHPWk9A9yGVe.tmp",
        "mode": "full",
        "parallelism": 5
    }
    ================================================================================
    Streaming changes to disk:
     batch 0
        couchbackup:backup written 0  docs:  5 Time 0.604 +0ms
        couchbackup:backup finished { total: 5 } +4ms
    ```
    {:codeblock}
    
3.  Verifique o diretório para ver se o arquivo `couchbackup-demo-backup.txt` foi criado. 
4.  Abra o arquivo e revise a lista de documentos submetidos a backup por meio do banco de dados.  
    
    ```json
    [
        {
          "_id": "doc2",
          "_rev": "1-2c5ee70689bb75af6f65b0335d1c92f4",
          "firstname": "John",
          "lastname": "Brown",
          "age": 21,
          "location": "New York City, NY",
          "_revisions": {
            "start": 1,
            "ids": [
              "2c5ee70689bb75af6f65b0335d1c92f4"
            ]
          }
        },
        {
          "_id": "doc3",
          "_rev": "1-f6055e3e09f215c522d45189208a1bdf",
          "firstname": "Greg",
          "lastname": "Greene",
          "age": 35,
          "location": "San Diego, CA",
          "_revisions": {
            "start": 1,
            "ids": [
              "f6055e3e09f215c522d45189208a1bdf"
            ]
          }
        },
        {
          "_id": "doc1",
          "_rev": "1-cce7796c7113c5498b07d8e11d7e0c12",
          "firstname": "Sally",
          "lastname": "Brown",
          "age": 16,
          "location": "New York City, NY",
          "_revisions": {
            "start": 1,
            "ids": [
              "cce7796c7113c5498b07d8e11d7e0c12"
            ]
          }
        },
        {
          "_id": "doc4",
          "_rev": "1-0923b723c62fe5c15531e0c33e015148",
          "firstname": "Anna",
          "lastname": "Greene",
          "age":44,
          "location": "Baton Rouge, LA",
          "_revisions": {
            "start": 1,
            "ids": [
              "0923b723c62fe5c15531e0c33e015148"
            ]
          }
        },
        {
            "_id": "doc5",
            "_rev": "1-19f7ecbc68090bc7b3aa4e289e363576",
            "firstname": "Lois",
            "lastname": "Brown",
            "age": 33,
            "location": "Syracuse, NY",
            "_revisions": {
                "start": 1,
                "ids": [
                  "19f7ecbc68090bc7b3aa4e289e363576"
                ]
            }
        }
    ]
    ```
    {:codeblock}

## Criando um arquivo de log

Um arquivo de log registra o progresso de seu backup. Com CouchBackup, você usará o parâmetro `--log`
para criar o arquivo de log. Também será possível utilizá-lo para reiniciar um backup de onde ele tiver parado
e especificar o nome do arquivo de saída. 

O comando `couchbackup` usa esses parâmetros para especificar o banco de dados,
o arquivo de log e a opção de continuação. 

*   `--db` = `couchbackup-demo`
*   `--log` = `couchbackup-demo.log`
*   `--resume` = `true`


1.  Execute o comando `couchbackup` para criar um arquivo de log. 
    
    ```sh
    couchbackup --db couchbackup-demo --log couchbackup-demo-backup.log > couchbackup-demo-backup-log.txt
    ```
    {:codeblock}
    
2.  Revise os resultados.
        
    ```sh
    
    ================================================================================
    Performing backup on https://****:****@myhost.cloudant.com/couchbackup-demo using configuration:
        {
          "bufferSize": 500,
          "log": "couchbackup-demo-backup.log",
          "mode": "full",
          "parallelism": 5
        }
    ================================================================================
    Streaming changes to disk:
     batch 0
        [{"_id":"doc2","_rev":"1-2c5ee70689bb75af6f65b0335d1c92f4",
            "firstname":"John","lastname":"Brown","age":21,
            "location":"New York City, NY",
            "_revisions":{"start":1,"ids":["2c5ee70689bb75af6f65b0335d1c92f4"]}},
        {"_id":"doc4","_rev":"1-0923b723c62fe5c15531e0c33e015148",
            "firstname":"Anna","lastname":"Greene","age":44,
            "location":"Baton Rouge, LA",
            "_revisions":{"start":1,"ids":["0923b723c62fe5c15531e0c33e015148"]}},
        {"_id":"doc1","_rev":"1-cce7796c7113c5498b07d8e11d7e0c12",
            "firstname":"Sally","lastname":"Brown","age":16,
            "location":"New York City, NY",
            "_revisions":{"start":1,"ids":["cce7796c7113c5498b07d8e11d7e0c12"]}},
        {"_id":"doc5","_rev":"1-19f7ecbc68090bc7b3aa4e289e363576",
            "firstname":"Lois","lastname":"Brown","age":33,
            "location":"Syracuse, NY",
            "_revisions":{"start":1,"ids":["19f7ecbc68090bc7b3aa4e289e363576"]}},
        {"_id":"doc3","_rev":"1-f6055e3e09f215c522d45189208a1bdf",
            "firstname":"Greg","lastname":"Greene","age":35,
            "location":"San Diego, CA",
            "_revisions":{"start":1,"ids":["f6055e3e09f215c522d45189208a1bdf"]}}]
                couchbackup:backup written 0  docs:  5 Time 0.621 +0ms
                couchbackup:backup finished { total: 5 } +4ms
    ```
    {:codeblock}

3.  Abra o arquivo de log `couchbackup-demo-backup.log` e revise as ações executadas
durante o backup ou a restauração.  
    
    ```sh
    :t batch0 [
        {"id":"doc1"},
        {"id":"doc5"},
        {"id":"doc3"},
        {"id":"doc4"},
        {"id":"doc2"}  ]
    :changes_complete 5-g1AAAAXkeJyl1MFNwzAUBmBDk
        RAnugEc4Nji2ImTnOgGsAH4-dkqVZoi1J5hA9gANoA
        NYAPYADaADUqMEYlBIWl7caTI-l7e_-xkhJDusINkD
        0FNLvQAIenDuKdUD2XWo7yvsskMZT7t53qaFbvXJYH
        t-Xw-GnYkGRcvNsM0lRwAydYsR23Oco2-GDWI0C1W2
        PFQFCYwKf2N7v-gAWtSd6168K2ufaksoQwD3dbx2wi
        aClJb8NBvQyVIk6Q-m6a0YWDRIw8NKA85M_Vo2IQe
        W_TEi0YIGiETLZlFZ3FqC068LqgBpHFQ30Vj3ucWv
        fRQYTAGwZbPO98oVnJVPAr3uoSTIGYcw3qYt4JvHHx
        b-WIpIqpwhYPu5Dsn35eyxNRI-c-9bArYwQ8OfqwcFY
        ghEdCSWib_J1fz2dZcdxcpAh2lpiW1zGheXM3XMsBY
        CcHonxO68GjenPxeyopyrXW86mg-HFz9NZiQh1FUhUefOhzMIg
    :d batch0
    ```
    {:codeblock}
    
##  Restaurando de um arquivo de texto de backup

No arquivo `couchbackup-demo-backup.txt`, será possível restaurar seus dados em um novo banco de dados vazio usando
o comando `couchrestore`. 

> **Nota**: a restauração de um backup será suportada apenas quando a restauração ocorrer em um banco de dados vazio. Se você excluir todos 
os documentos de um banco de dados, os registros de exclusão de documento ainda estarão presentes para propósitos de consistência de replicação. 
Isso significa que um banco de dados que contém apenas documentos excluídos não é considerado vazio e, portanto, não poderá ser usado
como o destino durante a restauração de um backup.

1.  (Pré-requisito) Crie um novo banco de dados vazio no qual seja possível restaurar seus dados.
    
    ```sh
    curl https://username:password@myhost.cloudant.com/couchbackup-demo-restore -X PUT
    ```
    {:codeblock}

2.  Execute o comando `couchrestore`.
    
    ```sh
    cat couchbackup-demo-backup.txt | couchrestore --db couchbackup-demo-restore
    ```
    {:codeblock}
    
3.  Revise os resultados. 
    
    ```sh
    
    ================================================================================
    Performing restore on https://****:****@myhost.cloudant.com/couchbackup-demo-restore using configuration:
    {
      "bufferSize": 500,
      "parallelism": 5
    }
    ================================================================================
      couchbackup:restore restored 5 +0ms
      couchbackup:restore finished { total: 5 } +1ms
    ```
    {:codeblock}

Agora você executou backup, restaurou um banco de dados e criou um arquivo de log. Veja a Documentação do {{site.data.keyword.cloudant_short_notm}}
para obter mais informações sobre o [recuperação de desastre e backup](../guides/disaster-recovery-and-backup.html#disaster-recovery-and-backup),
[configurando o {{site.data.keyword.cloudant_short_notm}} para recuperação de desastre de região cruzada](../guides/active-active.html#configuring-cloudant-for-cross-region-disaster-recovery)
e [backup e recuperação do {{site.data.keyword.cloudant_short_notm}}](../guides/backup-cookbook.html#cloudant-backup-and-recovery).  
