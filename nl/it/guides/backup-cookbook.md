---

copyright:
  years: 2017, 2018
lastupdated: "2018-06-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-05-23 -->
<!-- Update backup-guide.md with with any changes. -->

# Backup e ripristino {{site.data.keyword.cloudant_short_notm}}

Questo cookbook fa parte della [guida al ripristino di emergenza di {{site.data.keyword.cloudantfull}}](disaster-recovery-and-backup.html).
Vale la pena iniziare da qui se sei alle prime armi e vuoi comprendere dove si colloca il
backup nel contesto delle altre funzionalità offerte da {{site.data.keyword.cloudant_short_notm}}
per supportare i requisiti di Ripristino di emergenza (DR,Disaster Recovery) e Alta disponibilità (HA, High Availability).

Anche se i dati vengono memorizzati in modo ridondante all'interno di un cluster {{site.data.keyword.cloudant_short_notm}},
è importante considerare ulteriori misure di backup.
Ad esempio,
l'archiviazione ridondante dei dati non protegge dagli errori che insorgono quando si modificano i dati.

## Introduzione a CouchBackup

{{site.data.keyword.cloudant_short_notm}} fornisce uno strumento supportato per il backup e il ripristino di istantanee.
Lo strumento si chiama CouchBackup
ed è open source.
È costituito da una libreria `node.js`
ed è [disponibile per l'installazione su npm ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")][npmpackage]{:new_window}.

Oltre alla libreria,
il pacchetto CouchBackup contiene due strumenti della riga di comando:

1. `couchbackup`, che esegue il dump dei dati JSON da un database a un file di testo di backup.
2. `couchrestore`, che ripristina i dati da un file di testo di backup a un database.

> **Avvertenza.** Gli strumenti CouchBackup hanno delle [limitazioni](#limitations).
{:tip}

## Backup dei tuoi dati {{site.data.keyword.cloudant_short_notm}}

Puoi eseguire un semplice backup utilizzando lo strumento `couchbackup`.
Per eseguire il backup di un database `animaldb` in un file di testo chiamato `backup.txt`,
puoi utilizzare un comando simile al seguente esempio:

```sh
couchbackup --url https://examples.cloudant.com --db animaldb > backup.txt
```
{:codeblock}

Il file [readme npm ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")][npmreadme]{:new_window} fornisce dettagli di altre opzioni,
tra cui:

* Variabili di ambiente per impostare i nomi del database e dell'URL.
* Utilizzo di un file di log per registrare l'avanzamento di un backup.
* La capacità di riprendere un backup interrotto.
  **Nota**: questa opzione è disponibile solo con il file di log per il backup interrotto.
  {:tip}
* Invio del file di testo di backup a un file di output denominato,
  piuttosto che reindirizzare l'output `stdout`.

> **Avvertenza.** Gli strumenti CouchBackup hanno delle [limitazioni](#limitations).
{:tip}

## Ripristino dei tuoi dati {{site.data.keyword.cloudant_short_notm}}

Per ripristinare i tuoi dati,
utilizza lo strumento `couchrestore`.
Usa `couchrestore` per importare il file di backup
in un nuovo database {{site.data.keyword.cloudant_short_notm}}.
Quindi,
assicurati di creare tutti gli indici prima che una qualsiasi applicazione tenti di utilizzare i dati ripristinati.

Ad esempio,
per ripristinare i dati di cui è stato eseguito il backup nell'esempio precedente:

```sh
couchrestore --url https://myaccount.cloudant.com --db newanimaldb < backup.txt
```
{:codeblock}

Il file [readme npm ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")][npmreadme]{:new_window} fornisce i dettagli di altre opzioni di ripristino.

> **Avvertenza.** Gli strumenti CouchBackup hanno delle [limitazioni](#limitations).
{:tip}

## Limitazioni

> **Avvertenza.** Gli strumenti CouchBackup hanno le seguenti limitazioni: 
{:tip}

* Gli strumenti non eseguono il backup delle impostazioni `_security`.
* Gli strumenti non eseguono il backup degli allegati.
* I backup non sono esattamente delle istantanee di un "preciso momento".
  Il motivo è che i documenti nel database vengono recuperati in batch,
  ma altre applicazioni potrebbero eseguire l'aggiornamento dei documenti nello stesso momento.
  Pertanto,
  i dati nel database possono cambiare tra i tempi in cui vengono letti i primi e gli ultimi batch.
* Il backup viene eseguito per le definizioni di indice contenute nei documenti di progettazione
  ma non viene eseguito per i contenuti degli indici.
  Questa limitazione indica che quando i dati vengono ripristinati
  gli indici devono essere ricostruiti.
  La ricostruzione potrebbe richiedere una notevole quantità di tempo,
  a seconda di quanti dati vengono ripristinati.

## Utilizzo degli strumenti

La [pagina npm ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")][npmpackage]{:new_window}
fornisce dettagli sull'utilizzo degli strumenti della riga di comando per il backup e ripristino dei dati.
I seguenti esempi mostrano come mettere questi dettagli in pratica
descrivendo l'utilizzo degli strumenti per specifiche attività.

Il pacchetto CouchBackup fornisce due modi per utilizzare le sue funzioni fondamentali.

* Gli strumenti della riga di comando possono essere incorporati nelle pipeline di comandi UNIX standard.
  Per molti scenari, è sufficiente
  una combinazione di `cron` e script di shell semplice dell'applicazione `couchbackup`.
* Una libreria utilizzabile da node.js.
  La libreria consente di creare e distribuire processi di backup più complessi,
  come determinare dinamicamente quali database devono essere sottoposti a backup.

Utilizza lo strumento di backup della riga di comando
o la libreria con il codice applicativo
per abilitare il backup dai database {{site.data.keyword.cloudant_short_notm}} come parte di situazioni più complicate,
Uno scenario utile è la pianificazione dei backup utilizzando `cron`
e il caricamento automatico dei dati in
[Cloud Object Storage ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://www-03.ibm.com/software/products/en/object-storage-public){:new_window}
per la conservazione a lungo termine.

## Esempi di script di riga comandi

Vengono rilevati spesso due requisiti:

* Salvataggio dello spazio su disco,
  ['comprimendo' il file di backup](#zipping-a-backup-file) non appena viene creato.
* Creazione automatica di un backup di un database, [a intervalli regolari](#hourly-or-daily-backups-using-cron).

### Compressione di un file di backup

Lo strumento `couchbackup` può scrivere un file di backup direttamente sul disco
o trasmettere il flusso del backup a `stdout`.
La trasmissione del flusso a `stdout` consente di trasformare i dati prima di essere scritti sul disco.
Questa funzionalità è utilizzata per comprimere i dati all'interno del flusso.

```sh
couchbackup --url "https://examples.cloudant.com" \
  --db "animaldb" | gzip > backup.gz
```
{:codeblock}

In questo esempio,
lo strumento `gzip` accetta i dati di backup direttamente tramite il suo `stdin`,
comprime i dati
e li emette tramite `stdout`.
Il flusso di dati compressi risultante viene quindi reindirizzato e scritto in un file denominato `backup.gz`.

Se il database richiede di fornire le credenziali di accesso,
utilizza un URL in formato `https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com`,
ad esempio:

```sh
couchbackup --url "https://$USERNAME:$PASSWORD@examples.cloudant.com" \
  --db "animaldb" | gzip > backup.gz
```
{:codeblock}

È semplice estendere la pipeline se vuoi trasformare i dati in altri modi.
Ad esempio,
potresti voler crittografare i dati prima che vengano scritti sul disco.
In alternativa,
potresti voler scrivere i dati direttamente in un servizio di archiviazione oggetti
utilizzando i relativi strumenti della riga di comando.

### Backup orari o giornalieri che utilizzano `cron`

Lo strumento di pianificazione `cron` può essere impostato per acquisire istantanee di dati a intervalli regolari

Un utile punto di partenza è ottenere `couchbackup` per scrivere un singolo backup su un file
dove il nome del file include la data e l'ora correnti,
come illustrato nel seguente esempio:

```sh
couchbackup --url "https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com" \
  --db "animaldb" > animaldb-backup-`date -u "+%Y-%m-%dT%H:%M:%SZ"`.bak
```
{:codeblock}

Dopo aver verificato che il comando funzioni correttamente,
è possibile inserirlo un 'lavoro CRON':

1.  Installa gli strumenti CouchBackup sul server in cui vuoi eseguire i backup.
2.  Crea una cartella in cui memorizzare i backup.
3.  Crea una 'voce cron' che descriva la frequenza del backup.

Puoi creare una voce cron utilizzando il comando `crontab -e`.
Consulta la tua documentazione di sistema per dettagli specifici sulle opzioni 'cron'.

Una voce cron per fare un backup giornaliero è simile al seguente esempio:

```sh
0 5 * * * couchbackup --url "https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com" --db "animaldb" > /path/to/folder/animaldb-backup-`date -u "+%Y-%m-%dT%H:%M:%SZ"`.bak
```
{:codeblock}

Questa voce cron crea un backup giornaliero alle 05.00.
Puoi modificare il modello cron per eseguire backup orari, giornalieri, settimanali o mensili a seconda delle necessità.

## Utilizzo di CouchBackup come libreria

Gli strumenti della riga di comando `couchbackup` e `couchrestore` sono dei wrapper attorno a una libreria
che può essere utilizzata nelle tue applicazioni node.js.

La libreria è utile per scenari più complessi,
ad esempio:

* Backup di più database in una sola attività.
  Puoi eseguire questo backup identificando tutti i database mediante la chiamata [`_all_dbs`](../api/database.html#get-databases)
  e quindi eseguendo un backup di ciascun database singolarmente.
* Le pipeline più lunghe aumentano il rischio di errori.
  Utilizzando la libreria CouchBackup,
  la tua applicazione può rilevare e risolvere qualsiasi errore non appena possibile.

Per ulteriori informazioni,
consulta la [pagina npm ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")][npmpackage]{:new_window}.

Il seguente esempio di script mostra come combinare la libreria `couchbackup`
con l'utilizzo di {{site.data.keyword.IBM}} Cloud Object Storage.
Questo codice illustra come utilizzare l'API S3 in più regioni per eseguire il backup di un database in un archivio oggetti:

> **Nota**: un prerequisito per il codice è quello di inizializzare l'oggetto client S3 per
  {{site.data.keyword.IBM_notm}} Cloud Object Storage seguendo
[queste istruzioni![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")][cosclient]{:new_window}.
{:tip}

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
{:codeblock}

## Altre opzioni del ripristino di emergenza

Torna alla [guida al ripristino di emergenza di {{site.data.keyword.cloudant_short_notm}}](disaster-recovery-and-backup.html)
per scoprire altre funzioni offerte da {{site.data.keyword.cloudant_short_notm}}
per una configurazione completa del ripristino di emergenza.

[npmpackage]: https://www.npmjs.com/package/@cloudant/couchbackup
[npmreadme]: https://github.com/cloudant/couchbackup/blob/master/README.md
[cosclient]: https://developer.ibm.com/recipes/tutorials/cloud-object-storage-s3-api-intro/
