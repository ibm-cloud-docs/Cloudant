---

copyright:
  years: 2017
lastupdated: "2017-10-27"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-05-23 -->
<!-- Update backup-guide.md with with any changes. -->

# {{site.data.keyword.cloudant_short_notm}}-Sicherung und -Wiederherstellung

Dieses Cookbook ist Teil des [{{site.data.keyword.cloudantfull}}-Leitfadens zur Disaster-Recovery](disaster-recovery-and-backup.html).
Beginnen Sie hier, wenn Sie mit der Thematik noch nicht besonders vertraut sind und verstehen möchten, wie Sicherungen mit den anderen Funktionen, die {{site.data.keyword.cloudant_short_notm}} bietet,
zusammenarbeiten, um Disaster-Recovery- (DR) und Hochverfügbarkeitsanforderungen (HA) zu unterstützen.

Obwohl Daten redundant in einem {{site.data.keyword.cloudant_short_notm}}-Cluster gespeichert werden,
ist es wichtig, zusätzliche Sicherungsmaßnahmen in Betracht zu ziehen.
Redundanter Datenspeicher schützt beispielsweise nicht vor Fehlern beim Ändern von Daten.

## Einführung in CouchBackup

{{site.data.keyword.cloudant_short_notm}} stellt ein unterstütztes Tool für Momentaufnahmesicherungen und -wiederherstellungen bereit.
Dieses Open-Source-Tool heißt CouchBackup.
Es handelt sich um eine `node.js`-Bibliothek und kann [unter npm ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")][npmpackage]{:new_window} installiert werden.

Neben der Bibliothek enthält das CouchBackup-Paket zwei Befehlszeilentools:

1. `couchbackup`, das einen Speicherauszug von JSON-Daten aus einer Datenbank in einer Sicherungstextdatei erstellt.
2. `couchrestore`, das Daten aus einer Sicherungstextdatei in einer Datenbank wiederherstellt.

<strong style="color:red;">Achtung!</strong> Die CouchBackup-Tools haben [Einschränkungen](#limitations).

## {{site.data.keyword.cloudant_short_notm}}-Daten sichern

Sie können eine einfache Sicherung mithilfe des Tools `couchbackup` durchführen.
Um die `animaldb`-Datenbank in einer Textdatei namens `backup.txt` zu sichern,
können Sie einen Befehl ähnlich dem folgenden absetzen:

```sh
couchbackup --url https://examples.cloudant.com --db animaldb > backup.txt
```
{:codeblock}

Der Befehl [npm readme ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")][npmreadme]{:new_window} liefert Details zu weiteren Optionen,
darunter die folgenden:

* Umgebungsvariablen zum Festlegen der Namen von Datenbank und URL.
* Protokolldateien zum Aufzeichnen des Fortschritts einer Sicherung.
* Möglichkeit, eine unterbrochene Sicherung fortzusetzen.
  **Hinweis**: Diese Option ist nur mit der Protokolldatei der nicht unterbrochenen Sicherung verfügbar.
* Senden der Sicherungstextdatei an eine angegebene Ausgabedatei,
  statt Weiterleiten der `stdout`-Ausgabe.

<strong style="color:red;">Achtung!</strong> Die CouchBackup-Tools haben [Einschränkungen](#limitations).

## {{site.data.keyword.cloudant_short_notm}}-Daten wiederherstellen

Zum Wiederherstellen Ihrer Daten verwenden Sie das Tool `couchrestore`.
Verwenden Sie `couchrestore`, um die Sicherungsdatei in eine neue {{site.data.keyword.cloudant_short_notm}}-Datenbank zu importieren.
Stellen Sie dann sicher, dass Sie alle Indizes erstellt haben, bevor eine Anwendung versucht, die wiederhergestellten Daten zu verwenden.

Gehen Sie beispielsweise wie folgt vor, um die Daten, die in dem früheren Beispiel gesichert wurden, wiederherzustellen:

```sh
couchrestore --url https://myaccount.cloudant.com --db newanimaldb < backup.txt
```
{:codeblock}

Der Befehl [npm readme ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")][npmreadme]{:new_window} liefert Details über andere Wiederherstellungsoptionen.

<strong style="color:red;">Achtung!</strong> Die CouchBackup-Tools haben [Einschränkungen](#limitations).

## Einschränkungen

<strong style="color:red;">Achtung!</strong> Die CouchBackup-Tools haben die folgenden Einschränkungen: 

* `_security`-Einstellungen werden von den Tools nicht gesichert.
* Anhänge werden von den Tools nicht gesichert.
* Die Sicherungen sind keine präzisen zeitpunktgesteuerten Momentaufnahmen.
  Der Grund dafür ist, dass die Dokumente in der Datenbank in Stapeln abgerufen werden,
  aber andere Anwendungen zur gleichen Zeit Dokumente aktualisieren können.
  Deshalb können sich die Daten in der Datenbank zwischen dem Lesen des ersten und letzten Stapels ändern.
* Indexdefinitionen, die in Entwurfsdokumenten enthalten sind, werden gesichert, aber der Inhalt der Indizes wird nicht gesichert.
  Diese Einschränkung bedeutet, dass die Indizes erneut erstellt werden müssen, wenn Daten wiederhergestellt werden.
  Das Neuerstellen kann abhängig davon, wie viele Daten wiederhergestellt werden, ziemlich lange dauern.

## Tools verwenden

Der Befehl [npm page ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")][npmpackage]{:new_window}
gibt die Grundlagen der Verwendung der Befehlszeilentools zum Sichern und Wiederherstellen von Daten im Detail an.
Die folgenden Beispiele zeigen, wie diese Details in die Praxis umgesetzt werden können, indem die Verwendung der Tools für bestimmte Tasks beschrieben wird.

Das CouchBackup-Paket bietet zwei Möglichkeiten zur Verwendung seiner Kernfunktionen.

* Die Befehlszeilentools können in standardmäßige UNIX-Befehlpipelines eingebettet werden.
  In vielen Szenarios ist eine Kombination von `cron` und einfachem Shell-Scripting der Anwendung `couchbackup` ausreichend.
* Eine Bibliothek, die von Node.js verwendet werden kann.
  Die Bibliothek lässt zu, dass kompliziertere Sicherungsprozesse erstellt und implementiert werden können, z. B. das dynamische Bestimmen, welche Datenbanken gesichert werden müssen.

Verwenden Sie entweder das Befehlszeilen-Sicherungstool oder die Bibliothek mit Anwendungscode,
um Sicherungen aus {{site.data.keyword.cloudant_short_notm}}-Datenbanken als Teil komplexerer Situationen zuzulassen.
Ein nützliches Szenario ist das Planen von Sicherungen mithilfe von `cron` und das automatische Hochladen von Daten in den
[Cloudobjektspeicher ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://www-03.ibm.com/software/products/en/object-storage-public){:new_window}
für eine langfristige Aufbewahrung.

## Beispiele für das Befehlszeilenscripting

Zwei Voraussetzungen müssen häufig erfüllt werden:

* Einsparen von Plattenspeicherplatz
  durch [Zippen der Sicherungsdatei](#zipping-a-backup-file) während ihrer Erstellung.
* Automatisches Erstellen von Datenbanksicherungen [in regelmäßigen Abständen](#hourly-or-daily-backups-using-cron).

### Sicherungsdatei komprimieren

Das Tool `couchbackup` kann eine Sicherungsdatei direkt auf Platte schreiben
oder die Sicherung in `stdout` streamen.
Beim Streaming in `stdout` können Daten umgewandelt werden, bevor sie auf Platte geschrieben werden.
Diese Funktionalität wird zum Komprimieren von Daten innerhalb des Streams verwendet.

```sh
couchbackup --url "https://examples.cloudant.com" \
  --db "animaldb" | gzip > backup.gz
```
{:codeblock}

In diesem Beispiel übernimmt das Tool `gzip` die Sicherungsdaten direkt aus `stdin`,
komprimiert sie und gibt sie in `stdout` wieder aus.
Der resultierende komprimierte Datenstrom wird dann in eine Datei namens `backup.gz` umgeleitet und geschrieben.

Wenn die Datenbank es erfordert, dass Sie Zugriffsberechtigungsnachweise angeben,
verwenden Sie eine URL im Format `https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com`, z. B.:

```sh
couchbackup --url "https://$USERNAME:$PASSWORD@examples.cloudant.com" \
  --db "animaldb" | gzip > backup.gz
```
{:codeblock}

Eine logische Konsequenz, wenn Sie die Daten auf andere Weise umwandeln wollen, ist es, die Pipeline zu erweitern.
Sie möchten beispielsweise die Daten verschlüsseln, bevor sie auf Platte geschrieben werden.
Alternativ können Sie die Daten direkt in einen Objektspeicherservice schreiben, mithilfe der zugehörigen Befehlszeilentools.

### Stündliche oder tägliche Sicherungen, die `cron` verwenden

Das Planungstool `cron` kann so konfiguriert werden, dass es in regelmäßigen Abständen Momentaufnahmen von Daten macht.

Ein sinnvoller Ausgangspunkt ist es, `couchbackup` anzuweisen, eine einzelne Sicherung in eine Datei zu schreiben,
wobei der Dateiname das aktuelle Datum und die aktuelle Uhrzeit enthält, wie im folgenden Beispiel gezeigt:

```sh
couchbackup --url "https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com" \
  --db "animaldb" > animaldb-backup-`date -u "+%Y-%m-%dT%H:%M:%SZ"`.bak
```
{:codeblock}

Nachdem Sie den Befehl geprüft und festgestellt haben, dass er ordnungsgemäß funktioniert,
kann er in einen Cron-Job eingegeben werden:

1.  Installieren Sie die CouchBackup-Tools auf dem Server, der die Sicherungen durchführen soll.
2.  Erstellen Sie einen Ordner zum Speichern der Sicherungen.
3.  Erstellen Sie einen Cron-Eintrag, der angibt, wie häufig die Sicherung durchgeführt werden soll.

Sie können einen Cron-Eintrag mithilfe des Befehls `crontab -e` erstellen.
Informieren Sie sich in der Systemdokumentation über bestimmte Details der Cron-Optionen.

Ein Cron-Eintrag für eine tägliche Sicherung sieht wie folgt aus:

```sh
0 5 * * * couchbackup --url "https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com" --db "animaldb" > /path/to/folder/animaldb-backup-`date -u "+%Y-%m-%dT%H:%M:%SZ"`.bak
```
{:codeblock}

Dieser Cron-Eintrag erstellt eine tägliche Sicherung um 05:00 Uhr.
Sie können das Cron-Muster bei Bedarf ändern, um stündliche, tägliche, wöchentliche oder monatliche Sicherungen durchzuführen.

## CouchBackup als Bibliothek

Die Befehlszeilentools `couchbackup` und `couchrestore` sind Wrapper um eine Bibliothek herum,
die Sie in Ihren eigenen Node.js-Anwendungen verwendet können.

Die Bibliothek kann in komplexeren Szenarios wie den folgenden hilfreich sein:

* Sichern verschiedener Datenbanken in einer Task.
  Sie können diese Sicherung ausführen, indem Sie alle Datenbanken mithilfe des [`_all_dbs`](../api/database.html#get-databases)-Aufrufs ermitteln und dann jede Datenbank einzeln sichern.
* Längere Pipelines erhöhen das Fehlerrisiko.
  Mithilfe der CouchBackup-Bibliothek kann Ihre Anwendung alle Fehler bei frühester Gelegenheit erkennen und adressieren.

Weitere Informationen finden Sie auf der [npm-Seite ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")][npmpackage]{:new_window}.

Das folgende Beispielscript zeigt, wie die Bibliothek `couchbackup` unter Verwendung von {{site.data.keyword.IBM}} Cloud-Objektspeicher kombiniert werden kann.
Dieser Code stellt dar, wie Sie die regionsübergreifende S3-API zum Sichern einer Datenbank in einem Objektspeicher verwenden können.

> **Hinweis**: Eine Voraussetzung für den Code ist die Initialisierung des S3-Clientobjekts für
  {{site.data.keyword.IBM_notm}} Cloud-Objektspeicher anhand
[dieser Anweisungen ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")][cosclient]{:new_window}.

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

    // Ein zu durchlaufender Datenstrom, in den die Ausgabe von
    // couchbackup geschrieben wird und der dann vom S3-Upload-Client gelesen wird.
    // Er verfügt über einen internen Puffer von 10 MB.
    const streamToUpload = new stream.PassThrough({highWaterMark: 10485760});

    // Konfigurieren Sie den S3-Upload.
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

## Andere Disaster-Recovery-Optionen

Kehren Sie zum [{{site.data.keyword.cloudant_short_notm}}-Leitfaden zur Disaster-Recovery](disaster-recovery-and-backup.html)
zurück und lernen Sie die anderen Features kennen, die {{site.data.keyword.cloudant_short_notm}}
für die Konfiguration einer vollständigen Disaster-Recovery bietet.

[npmpackage]: https://www.npmjs.com/package/@cloudant/couchbackup
[npmreadme]: https://github.com/cloudant/couchbackup/blob/master/README.md
[cosclient]: https://developer.ibm.com/recipes/tutorials/cloud-object-storage-s3-api-intro/
