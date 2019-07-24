---

copyright:
  years: 2017, 2019
lastupdated: "2019-06-12"

keywords: couchbackup, back up your data, restore data, limitations, use the tools, use couchbackup as a library

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

# Backup e recuperação do {{site.data.keyword.cloudant_short_notm}}
{: #ibm-cloudant-backup-and-recovery}

Este cookbook faz parte do [Guia de recuperação de desastre do {{site.data.keyword.cloudantfull}}](/docs/services/Cloudant?topic=cloudant-disaster-recovery-and-backup#disaster-recovery-and-backup).
Valerá a pena começar por aí se você for iniciante no assunto e quiser entender onde o backup se encaixa
com os outros recursos oferecidos pelo {{site.data.keyword.cloudant_short_notm}}
para suportar os requisitos de Recuperação de desastre (DR) e de Alta disponibilidade (HA).

Embora os dados sejam armazenados de forma redundante em um cluster do {{site.data.keyword.cloudant_short_notm}},
é importante considerar medidas de backup extras.
Por exemplo,
o armazenamento de dados redundante não protege contra erros quando os dados são mudados.

## Introduzindo o CouchBackup
{: #introducing-couchbackup}

O {{site.data.keyword.cloudant_short_notm}} fornece uma ferramenta suportada para backup e restauração de captura instantânea.
A ferramenta chama-se CouchBackup
e é um software livre.
Ela é uma biblioteca `node.js` e é possível instalá-la no [npm ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")][npmpackage]{: new_window}.

Além da biblioteca,
o pacote CouchBackup contém duas ferramentas de linha de comandos:

1. `couchbackup`, que faz dump dos dados JSON de um banco de dados para um arquivo de texto de backup.
2. `couchrestore`, que restaura dados de um arquivo de texto de backup para um banco de dados.

As ferramentas CouchBackup têm [limitações](#limitations).
{: important}

## Fazendo backup de seus dados do {{site.data.keyword.cloudant_short_notm}}
{: #backing-up-your-ibm-cloudant-data}

É possível fazer um backup simples usando a ferramenta `couchbackup`.
Para fazer backup do banco de dados `animaldb` para um arquivo de texto chamado `backup.txt`,
será possível usar um comando semelhante ao exemplo a seguir:

```sh
couchbackup --url https://examples.cloudant.com --db animaldb > backup.txt
```
{: codeblock}

O [leia-me do npm ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")][npmreadme]{: new_window} detalha outras opções,
incluindo:

* Variáveis de ambiente para configurar os nomes do banco de dados e a URL.
* O uso de um arquivo de log para registrar o progresso de um backup.
* A capacidade de continuar um backup interrompido.

  Esta opção está disponível apenas com o arquivo de log para o backup interrompido.
  {: note}

* O envio do arquivo de texto de backup para um arquivo de saída nomeado,
em vez de redirecionar a saída `stdout`.

As ferramentas CouchBackup têm [limitações](#limitations).
{: important}

## Restaurando os seus dados do {{site.data.keyword.cloudant_short_notm}}
{: #restoring-your-ibm-cloudant-data}

Para restaurar seus dados,
use a ferramenta `couchrestore`.
Use `couchrestore` para importar o arquivo de backup
para um novo banco de dados {{site.data.keyword.cloudant_short_notm}}.
Em seguida,
assegure-se de construir todos os índices antes de qualquer aplicativo tentar usar os dados restaurados.

Por exemplo,
para restaurar os dados que foram submetidos a backup no exemplo anterior:

```sh
couchrestore --url https://myaccount.cloudant.com --db newanimaldb < backup.txt
```
{: codeblock}

O [leia-me do npm ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")][npmreadme]{: new_window} fornece detalhes de outras opções de restauração.

As ferramentas CouchBackup têm [limitações](#limitations).
{: important}

## Limitações
{: #limitations}

As ferramentas CouchBackup têm as limitações a seguir: 
{: important}

* As configurações `_security` não são submetidas a backup pelas ferramentas.
* Os anexos não são submetidos a backup pelas ferramentas.
* Os backups não são capturas instantâneas do "momento" precisamente exatas.
  O motivo é que os documentos no banco de dados são recuperados em lotes,
mas outros aplicativos podem estar atualizando documentos ao mesmo tempo.
  Portanto,
os dados no banco de dados podem mudar entre as vezes em que o primeiro e último lotes são lidos.
* As definições do índice mantidas em documentos de design são submetidas a backup,
mas o conteúdo dos índices não é submetido a backup.
  Essa limitação significa que quando os dados são restaurados,
os índices devem ser reconstruídos.
  A reconstrução pode levar um período de tempo considerável,
dependendo da quantidade de dados restaurada.

## Usando as ferramentas
{: #using-the-tools}

A [página do npm ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")][npmpackage]{: new_window}
detalha as informações básicas de uso das ferramentas de linha de comandos para backup e restauração de dados.
Os exemplos a seguir mostram como colocar esses detalhes em prática
descrevendo o uso das ferramentas para tarefas específicas.

O pacote CouchBackup fornece duas maneiras de usar suas funções principais.

* As ferramentas de linha de comandos podem ser integradas aos pipelines de comando padrão do UNIX.
  Para muitos cenários,
uma combinação de `cron` e shell script simples do aplicativo `couchbackup` é suficiente.
* Uma biblioteca utilizável por meio de node.js.
  A biblioteca permite que os processos de backup mais complicados sejam criados e implementados,
como determinar dinamicamente quais bancos de dados devem ser submetidos a backup.

Use a ferramenta de backup da linha de comandos
ou a biblioteca com código do aplicativo
para ativar o backup de bancos de dados {{site.data.keyword.cloudant_short_notm}} como parte de situações mais complicadas.
Um cenário útil é planejar backups usando `cron`
e fazer upload de dados automaticamente para o
[Cloud Object Storage ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/cloud/object-storage/solutions?mhq=object%20storage%20public&mhsrc=ibmsearch_a){: new_window}
para retenção de longo prazo.

## Exemplos de script da linha de comandos
{: #command-line-scripting-examples}

Dois requisitos são frequentemente encontrados:

* Economia de espaço em disco
ao ['compactar com zip' o arquivo de backup](#compressing-a-backup-file) conforme ele é criado.
* A criação de um backup de um banco de dados automaticamente em [intervalos regulares](#hourly-or-daily-backups-that-use-cron-).

### Compactando um arquivo de backup
{: #compressing-a-backup-file}

A ferramenta `couchbackup` pode gravar um arquivo de backup no disco diretamente
ou transmitir o backup para `stdout`.
O fluxo para `stdout` permite que os dados sejam transformados antes de serem gravados no disco.
Esse recurso é usado para compactar dados dentro do fluxo.

```sh
couchbackup --url "https://examples.cloudant.com" \
  --db "animaldb" | gzip > backup.gz
```
{: codeblock}

Neste exemplo,
a ferramenta `gzip` aceita os dados de backup diretamente de seu `stdin`,
compacta os dados
e os emite por meio de `stdout`.
O fluxo de dados compactados resultante é então redirecionado e gravado em um arquivo chamado `backup.gz`.

Se o banco de dados requerer que você forneça credenciais de acesso,
use uma URL no formato `https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com`,
por exemplo:

```sh
couchbackup --url "https://$USERNAME:$PASSWORD@examples.cloudant.com" \
  --db "animaldb" | gzip > backup.gz
```
{: codeblock}

A ampliação do pipeline será direta se você quiser transformar os dados em outras maneiras.
Por exemplo,
talvez você queira criptografar os dados antes de eles serem gravados no disco.
Como alternativa,
talvez você queira gravar os dados diretamente em um serviço de armazenamento de objeto
usando suas ferramentas de linha de comandos.

### Backups de hora em hora ou diários que usam `cron`
{: #hourly-or-daily-backups-that-use-cron-}

A ferramenta de planejamento `cron` pode ser configurada para tirar capturas instantâneas de dados em intervalos regulares

Um ponto de início útil é fazer com que `couchbackup` grave um único backup em um arquivo,
em que o nome do arquivo inclui a data e hora atuais,
conforme mostrado no exemplo a seguir:

```sh
couchbackup --url "https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com" \
  --db "animaldb" > animaldb-backup-`date -u "+%Y-%m-%dT%H:%M:%SZ"`.bak
```
{: codeblock}

Depois de verificar o comando para assegurar-se de que ele funciona corretamente,
ele poderá ser inserido em uma 'tarefa cron':

1.  Instale as ferramentas CouchBackup no servidor no qual você deseja executar os backups.
2.  Crie uma pasta para armazenar os backups.
3.  Crie uma 'entrada cron' que descreva a frequência do backup.

É possível criar uma entrada cron usando o comando `crontab -e`.
Consulte a documentação do sistema para obter detalhes específicos sobre as opções de 'cron'.

Uma entrada cron para executar um backup diário é semelhante ao exemplo a seguir:

```sh
0 5 * * * couchbackup --url "https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com" --db "animaldb" > /path/to/folder/animaldb-backup-`date -u "+%Y-%m-%dT%H:%M:%SZ"`.bak
```
{: codeblock}

Essa entrada cron cria um backup diário às 5h.
É possível modificar o padrão de cron para executar backups de hora em hora, diariamente, semanalmente ou mensalmente, conforme necessário.

## Usando CouchBackup como uma biblioteca
{: #using-couchbackup-as-a-library}

As ferramentas de linha de comandos `couchbackup` e `couchrestore` são wrappers em torno de uma biblioteca
que podem ser usados em seus próprios aplicativos node.js.

A biblioteca é útil para cenários mais complicados,
por exemplo:

* Fazer backup de vários bancos de dados em uma tarefa.
  Você poderia executar esse backup identificando todos os bancos de dados usando a chamada [`_all_dbs`](/docs/services/Cloudant?topic=cloudant-databases#get-a-list-of-all-databases-in-the-account)
e, em seguida, executando um backup de cada banco de dados individualmente.
* Pipelines mais longos aumentam o risco de erros.
  Ao usar a biblioteca CouchBackup,
seu aplicativo pode detectar e tratar qualquer erro na primeira oportunidade.

Para obter mais informações,
veja a [página do npm ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")][npmpackage]{: new_window}.

A amostra de script a seguir mostra como combinar a biblioteca `couchbackup`
com uso do {{site.data.keyword.IBM}} Cloud Object Storage.
Esse código ilustra como você poderia usar a API da Região cruzada S3 para fazer backup de um banco de dados em um armazenamento de objeto.

Um pré-requisito para o código é inicializar o objeto do cliente S3 para o {{site.data.keyword.IBM_notm}} Cloud Object Storage seguindo as instruções em [{{site.data.keyword.cloud_notm}} Object Storage - Introdução à API do S3 ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")][cosclient]{: new_window}.
{: note}

```javascript
/*
  Backup directly from Cloudant to an S3 bucket via a stream.
  @param {string} couchHost - URL of database root
  @param {string} couchDatabase - backup source database
  @param {object} s3Client - S3 client object
  @param {string} s3Bucket - Destination S3 bucket (must exist)
  @param {string} s3Key - Destination object's key (shouldn't exist)
  @param {boolean} shallow - Whether to use couchbackup's shallow mode
  @returns {Promise}
*/
function backupToS3(sourceUrl, s3Client, s3Bucket, s3Key, shallow) {
  return new Promise((resolve, reject) => {
    debug('Setting up S3 upload to ${s3Bucket}/${s3Key}');

    // A pass through stream that has couchbackup's output
    // written to it and it then read by the S3 upload client.
    // It has a 10MB internal buffer.
    const streamToUpload = new stream.PassThrough({highWaterMark: 10485760});

    // Set up S3 upload.
    const params = {
      Bucket: s3Bucket,
      Key: s3Key,
      Body: streamToUpload
    };
    s3Client.upload(params, function(err, data) {
      debug('S3 upload done');
      if (err) {
        debug(err);
        reject(new Error('S3 upload failed'));
        return;
      }
      debug('S3 upload succeeded');
      debug(data);
      resolve();
    }).httpUploadProgress = (progress) => {
      debug('S3 upload progress: ${progress}');
    };

    debug('Starting streaming data from ${sourceUrl}');
    couchbackup.backup(
      sourceUrl,
      streamToUpload,
      (err, obj) => {
        if (err) {
          debug(err);
          reject(new Error('CouchBackup failed with an error'));
          return;
        }
        debug('Download from ${sourceUrl} complete.');
        streamToUpload.end();  // must call end() to complete S3 upload.
        // resolve() is called by the S3 upload
      }
    );
  });
}
```
{: codeblock}

## Outras opções de recuperação de desastre
{: #other-disaster-recovery-options}

Retorne ao [Guia de recuperação de desastre do {{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant?topic=cloudant-disaster-recovery-and-backup#disaster-recovery-and-backup)
para descobrir sobre os outros recursos que o {{site.data.keyword.cloudant_short_notm}}
oferece para uma configuração de recuperação de desastre integral.

[npmpackage]: https://www.npmjs.com/package/@cloudant/couchbackup
[npmreadme]: https://github.com/cloudant/couchbackup/blob/master/README.md
[cosclient]: https://developer.ibm.com/recipes/tutorials/cloud-object-storage-s3-api-intro/
