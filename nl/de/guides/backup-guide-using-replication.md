---

copyright:
  years: 2015, 2017
lastupdated: "2017-08-25"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-04-20 -->

<div id="back-up-your-data-using-replication"></div>

# Daten mithilfe von Replikation sichern

>	**Hinweis**: Dieser Leitfaden enthält ältere oder veraltete Informationen zur Cloudant-Sicherung.
	Aktuelle Informationen zu Sicherungen finden Sie im Leitfaden [Disaster-Recovery und Sicherung](disaster-recovery-and-backup.html).



Datenbanksicherungen schützen Ihre Daten vor Verlust oder Beschädigung.
{:shortdesc}

Sie können die Cloudant-Replikationsfunktionalität verwenden, um eine Datenbanksicherung zu erstellen
und sie in einem Cloudant-Cluster zu speichern.
Dann können Sie Daten, gesamte Datenbanken oder bestimmte JSON-Dokumente aus diesen Sicherungen
in Ihrem Produktionscluster wiederherstellen. 

Mithilfe der Cloudant-Replikation speichert eine Datenbanksicherung
den Inhalt Ihrer Datenbank in einem Prüfpunkt.
Es ist möglich, einen Rollback zu einem bestimmten Prüfpunkt durchzuführen.
Der Prüfpunkt ist nicht an einen bestimmten Zeitpunkt gebunden.
Stattdessen ist er eine Aufzeichnung der Datenbank, nachdem bestimmte
Änderungen während der Sicherungsphase vorgenommen wurden.
Auf diese Weise kann eine Sicherung den Zustand Ihrer Datenbank zu einem bestimmten Zeitpunkt beibehalten. 

## Inkrementelle Sicherungen

Wenn Sie ein Unternehmenskunde sind, ist eine tägliche inkrementelle Sicherungsfunktionalität [verfügbar](disaster-recovery-and-backup.html). 

Wenn Sie kein Unternehmenskunde sind oder lieber Ihre eigenen Sicherungen erstellen möchten,
können Sie die Cloudant-Replikationsfunktionalität verwenden, um eine Datenbanksicherung zu erstellen. 

Eine einfache Methode ist das Replizieren der gesamten Datenbank in eine Sicherungsdatenbank mit Datum.
Diese Methode funktioniert und ist simpel. Aber wenn Sie Sicherungen für diverse Zeitpunkte benötigen,
z. B. sieben tägliche und vier wöchentliche Sicherungen,
müssen Sie in jeder neuen Sicherungsdatenbank eine vollständige Kopie der Datenbank speichern.
Für eine vollständige Kopie wird eine große Menge Plattenspeicherplatz belegt,
insbesondere wenn Ihre Datenbank umfangreich ist. 

Als Alternative sind inkrementelle Sicherungen eine gute Lösung, um nur die Dokumente zu speichern, die sich seit der letzten Sicherung geändert haben. 

Der Prozess ist einfach. Sie müssen zunächst eine Sicherung der gesamten Datenbank erstellen.
Nach der ersten Sicherung führen Sie tägliche inkrementelle Sicherungen durch,
wobei _nur_ gesichert wird, was sich in der Datenbank seit der letzten Sicherung geändert hat.
Diese Replikation wird eine tägliche Sicherung. 

>   **Hinweis**: Sie können eine Sicherung so konfigurieren, dass sie in bestimmten Intervallen ausgelöst wird. 
    Die Intervalle müssen jedoch mindestens
    24 Stunden auseinander liegen.
    Mit anderen Worten: Sie können tägliche Sicherungen
    durchführen, aber keine stündlichen.

## Inkrementelle Sicherung erstellen

Inkrementelle Sicherungen sichern nur die Unterschiede, bzw. das Delta zwischen einzelnen Sicherungen.
Alle 24 Stunden wird die Quellendatenbank in eine Zieldatenbank repliziert. 

Die Replikation verwendet Sequenzwerte, um die während des 24-Stunden-Zeitraums geänderten Dokumente zu identifizieren. Die Sicherungsoperation funktioniert, indem sie Replikation nutzt, um einen Prüfpunkt abzurufen und zu speichern.
Ein Prüfpunkt ist ein anderes Dokument mit einem internen Namen.
Die Sicherungsoperation erstellt den Namen aus einer Kombination des Datums und des Namens der Sicherungstask. Anhand dieses Namens lassen sich Prüfpunkte während des Wiederherstellungs- oder Rollupprozesses einfacher ermitteln. 

Führen Sie die folgenden Schritte aus, um eine inkrementelle Sicherung zu erstellen: 

1.  Suchen Sie nach der ID des Prüfpunktdokuments für die letzte Replikation.
    Sie ist im Feld `_replication_id` des Replikationsdokuments in der Datenbank `_replicator` gespeichert. 
2.  Öffnen Sie das Prüfpunktdokument unter `/$DATABASE/_local/$REPLICATION_ID`,
    wobei `$REPLICATION_ID` die ID ist, die Sie im vorherigen Schritt abgerufen haben,
    und `$DATABASE` der Name der Quellen- oder Zieldatenbank.
    Das Dokument existiert üblicherweise in beiden Datenbanken, kann aber auch nur in einer zu finden sein. 
3.  Suchen Sie nach dem Feld `recorded_seq` des ersten Elements im Verlaufsarray, das im Prüfpunktdokument gefunden wird. 
4.  Replizieren Sie in die neue inkrementelle Sicherungsdatenbank,
    wobei Sie das Feld [`since_seq`](../api/replication.html#the-since_seq-field)
    im Replikationsdokument auf den Wert des Felds [`recorded_seq`](backup-guide.html#get-the-recorded_seq-value)
    setzen, den Sie im vorherigen Schritt ausfindig gemacht haben. 

>   **Hinweis**: Definitionsgemäß umgeht die Verwendung der Option `since_seq` das normale Prüfpunktverfahren. Verwenden Sie `since_seq` deshalb nur mit großer Vorsicht.  

## Datenbank wiederherstellen

Um eine Datenbank aus inkrementellen Sicherungen wiederherzustellen,
replizieren Sie jede inkrementelle Sicherung in eine neue Datenbank,
wobei Sie mit dem neuesten Inkrement beginnen. 

Sie können auch mit der ältesten Sicherung beginnen und anschließend der Reihe nach alle nachfolgenden Sicherungen ausführen.
Aber die Replikation der jüngsten inkrementellen Sicherung zuerst durchzuführen, geht schneller, weil aktualisierte Dokumente nur einmal in die Zieldatenbank geschrieben werden.
Alle Dokumente, die älter sind als eine bereits in der neuen Datenbank vorhandene Kopie, werden übersprungen. 


## Beispiel

Das vorliegende Beispiel veranschaulicht Folgendes: 

1.  Einrichten von Datenbanken für die Verwendung von inkrementellen Sicherungen. 
2.  Ausführen einer vollständigen Sicherung. 
3.  Einrichten und Ausführen einer inkrementellen Sicherung. 
4.  Wiederherstellen einer Sicherung. 

<div id="constants-used-in-this-guide"></div>

### Verwendete Konstanten

```sh
# Basis-URL und Inhaltstyp in Shellvariablen speichern
$ url='https://$ACCOUNT:$PASSWORD@$ACCOUNT.cloudant.com'
$ ct='Content-Type: application-json'
```
{:codeblock}

Angenommen, Sie müssen nur eine Datenbank sichern. Sie möchten eine vollständige Sicherung am Montag erstellen und eine inkrementelle Sicherung am Dienstag. 

Sie können die Befehle `curl` und [`jq` ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://stedolan.github.io/jq/){:new_window}
absetzen, um diese Operationen auszuführen.
In der Praxis können Sie jeden beliebigen HTTP-Client verwenden. 

<div id="step-1-check-you-have-three-databases"></div>

### Schritt 1: Stellen Sie sicher, dass Sie drei Datenbanken haben.

In diesem Beispiel benötigen Sie drei Datenbanken:

-   Die ursprüngliche Datenbank,
    in der sich die Daten befinden, die Sie sichern möchten. 
-   Zwei inkrementelle Datenbanken,
    eine für Montag (`backup-monday`) und eine für Dienstag (`backup-tuesday`). 

_Beispiel, wie Sie prüfen, ob Sie drei Datenbanken haben, unter Verwendung von HTTP:_

```http
PUT /original HTTP/1.1
PUT /backup-monday HTTP/1.1
PUT /backup-tuesday HTTP/1.1
```
{:codeblock}

_Beispiel, wie Sie prüfen, ob Sie drei Datenbanken haben,
über die Befehlszeile:_

```sh
$ curl -X PUT "${url}/original"
$ curl -X PUT "${url}/backup-monday"
$ curl -X PUT "${url}/backup-tuesday"
```
{:codeblock}

### Schritt 2: Erstellen Sie die Datenbank `_replicator`. 

Falls sie nicht vorhanden ist, erstellen Sie die Datenbank `_replicator`. 

_Erstellen der Datenbank `_replicator` unter Verwendung von HTTP:_

```http
PUT /_replicator HTTP/1.1
```
{:codeblock}

_Erstellen der Datenbank `_replicator` über die Befehlszeile:_

```sh
curl -X PUT "${url}/_replicator"
```
{:pre}

### Schritt 3: Sichern Sie die gesamte (ursprüngliche) Datenbank. 

Am Montag möchten Sie erstmalig eine Sicherung aller Ihrer Daten durchführen.
Erstellen Sie diese Sicherung, indem Sie alles von `original` nach `backup-monday` replizieren. 

_Ausführen einer vollständigen Sicherung am Montag unter Verwendung von HTTP:_

```http
PUT /_replicator/full-backup-monday HTTP/1.1
Content-Type: application/json
```
{:codeblock}

_Ausführen einer vollständigen Sicherung am Montag über die Befehlszeile:_

```sh
$ curl -X PUT "${url}/_replicator/full-backup-monday" -H "$ct" -d @backup-monday.json
# Dabei beschreibt backup-monday.json die Sicherung.
```
{:codeblock}

_JSON-Dokument, das die vollständige Sicherung beschreibt:_
 
```json
{
    "_id": "full-backup-monday",
    "source": "${url}/original",
    "target": "${url}/backup-monday"
}
```
{:codeblock}

<div id="step-4-get-checkpoint-id"></div>

### Schritt 4: Bereiten Sie Teil 1 der inkrementellen Sicherung vor - Prüfpunkt-ID abrufen. 

Am Dienstag möchten Sie eine statt
einer weiteren vollständigen Sicherung eine
inkrementelle Sicherung durchführen. 

Dafür benötigen Sie zwei Werte: 

-   Die Prüfpunkt-ID. 
-   [Den Wert `recorded_seq`](#step-5-prepare-incremental-backup-part-2-get-recorded_seq-value). 

Diese Werte geben an, wo die letzte Sicherung endete,
und legen fest, wo die inkrementelle Sicherung starten soll.
Wenn Sie diese Werte kennen, können Sie die inkrementelle Sicherung ausführen. 

Sie beginnen, indem Sie den Prüfpunkt-ID-Wert suchen.
Dieser Wert ist im Feld `_replication_id` des Replikationsdokuments
in der Datenbank `_replicator` gespeichert. 

_Abrufen der Prüfpunkt-ID, um den Wert `recorded_seq` ausfindig zu machen, unter Verwendung von HTTP:_

```http
GET /_replicator/full-backup-monday HTTP/1.1
# Nach dem Wert von _replication_id suchen
```
{:codeblock}

_Abrufen der Prüfpunkt-ID, um den Wert `recorded_seq` ausfindig zu machen, über die Befehlszeile:_

```sh
replication_id=$(curl "${url}/_replicator/full-backup-monday" | jq -r '._replication_id')
```
{:pre}

<div id="step-5-get-recorded_seq-value"></div>

### Schritt 5: Bereiten Sie Teil 2 der inkrementellen Sicherung vor - Wert `recorded_seq` abrufen. 

Nachdem Sie die Prüfpunkt-ID herausgefunden haben,
verwenden Sie sie, um den Wert `recorded_seq` abzurufen.
Dieser Wert befindet sich im ersten Element des Verlaufsarrays im Dokument `/_local/${replication_id}`
in der ursprünglichen Datenbank. 

Sie kennen jetzt den Wert `recorded_seq`.
Dieser Wert gibt das letzte Dokument an, das aus der ursprünglichen Datenbank repliziert wurde. 

_Abrufen des Werts `recorded_seq` aus der ursprünglichen Datenbank, unter Verwendung von HTTP:_

```http
GET /original/_local/${replication_id} HTTP/1.1
# Nach dem ersten Wert von recorded_seq im Verlaufsarray suchen
```
{:codeblock}

_Abrufen des Werts `recorded_seq` aus der ursprünglichen Datenbank, über die Befehlszeile:_

```sh
recorded_seq=$(curl "${url}/original/_local/${replication_id}" | jq -r '.history[0].recorded_seq')
```
{:pre}

### Schritt 6: Führen Sie eine inkrementelle Sicherung durch. 

Jetzt kennen Sie die Prüfpunkt-ID und den Wert `recorded_seq`
und können die für Dienstag geplante inkrementelle Sicherung starten. Diese Sicherung repliziert alle Dokumentänderungen _seit_ der letzten Replikation. 

Wenn die Replikation fertig ist, haben Sie eine abgeschlossene inkrementelle Sicherung.
Die Sicherung enthält sämtliche Dokumente in der ursprünglichen Datenbank und kann durch Abrufen des Inhalts der beiden Datenbanken `backup-monday` _und_ `backup-tuesday` wiederhergestellt werden. 

_Ausführen der für Dienstag geplanten inkrementellen Sicherung, unter Verwendung von HTTP:_

```http
PUT /_replicator/incr-backup-tuesday HTTP/1.1
Content-Type: application/json
```
{:codeblock}

_Ausführen der für Dienstag geplanten inkrementellen Sicherung, über die Befehlszeile:_

```sh
curl -X PUT "${url}/_replicator/incr-backup-tuesday" -H "${ct}" -d @backup-tuesday.json
```
{:pre}

_JSON-Dokument, das die für Dienstag geplante inkrementelle Sicherung beschreibt:_
 
```json
{
    "_id": "incr-backup-tuesday",
    "source": "${url}/original",
    "target": "${url}/backup-tuesday",
    "since_seq": "${recorded_seq}"
}
```
{:codeblock}

### Schritt 7: Stellen Sie die Sicherung vom Montag wieder her. 

Um eine Sicherung wiederherzustellen, replizieren Sie die ursprüngliche vollständige Sicherung
und alle inkrementellen Sicherungen in eine neue Datenbank. 

Um den Zustand vom Montag wiederherzustellen, würden Sie eine
Replikation aus der Datenbank `backup-monday` durchführen. 

_Wiederherstellung aus der Datenbank `backup-monday`, unter Verwendung von HTTP:_

```sh
PUT /_replicator/restore-monday HTTP/1.1
Content-Type: application/json
```
{:codeblock}

_Wiederherstellung aus der Datenbank `backup-monday`, über die Befehlszeile:_

```sh
curl -X PUT "${url}/_replicator/restore-monday" -H "$ct" -d @restore-monday.json
```
{:pre}

_JSON-Dokument, das die Wiederherstellung beschreibt:_
 
```json
{
    "_id": "restore-monday",
    "source": "${url}/backup-monday",
    "target": "${url}/restore",
    "create-target": true  
}
```
{:codeblock}

### Schritt 8: Stellen Sie Sicherung vom Dienstag wieder her. 

Um die Datenbank vom Dienstag wiederherzustellen,
führen Sie zuerst eine Replikation aus `backup-tuesday` und dann aus `backup-monday` durch. 

>   **Hinweis**: Die Reihenfolge ist kein Schreibfehler; 
    es _ist_ Absicht, erst den Zustand vom Dienstag und _dann_ vom Montag wiederherzustellen.

Sie können auch in chronologischer Reihenfolge wiederherstellen, aber indem Sie in umgekehrter Richtung vorgehen,
müssen Dokumente, die am Dienstag aktualisiert wurden, nur ein Mal in die Zieldatenbank geschrieben werden.
Ältere Versionen des Dokuments, die in der Datenbank vom Montag gespeichert sind, werden ignoriert. 

_Wiederherstellen der Sicherung vom Dienstag, jüngste Änderungen zuerst, unter Verwendung von HTTP:_

```http
PUT /_replicator/restore-tuesday HTTP/1.1
Content-Type: application/json
```
{:codeblock}

_Wiederherstellen der Sicherung vom Dienstag, jüngste Änderungen zuerst, über die Befehlszeile:_

```sh
curl -X PUT "${url}/_replicator/restore-tuesday" -H "$ct" -d @restore-tuesday.json
```
{:pre}

_JSON-Dokument, das die Wiederherstellung der Sicherung vom Dienstag anfordert:_
 
```json
{
    "_id": "restore-tuesday",
    "source": "${url}/backup-tuesday",
    "target": "${url}/restore",
    "create-target": true  
}
```
{:codeblock}

_Abschließen der Wiederherstellung, Sicherung vom Montag zuletzt, unter Verwendung von HTTP:_

```http
PUT /_replicator/restore-monday HTTP/1.1
Content-Type: application/json
```
{:codeblock}

_Abschließen der Wiederherstellung, Sicherung vom Montag zuletzt, über die Befehlszeile:_

```http
curl -X PUT "${url}/_replicator/restore-monday" -H "$ct" -d @restore-monday.json
```
{:pre}

_JSON-Dokument, das die Wiederherstellung der Sicherung vom Montag anfordert:_
 
```json
{
    "_id": "restore-monday",
    "source": "${url}/backup-monday",
    "target": "${url}/restore"
}
```
{:codeblock}

## Vorschläge

Die bisherigen Informationen haben sich auf den grundlegenden Sicherungsprozess bezogen,
aber jede Anwendung hat eigene Anforderungen und Strategien für Sicherungen.
Die folgenden Vorschläge können Hilfestellung leisten. 

### Sicherungen planen

Replikationsjobs können die Auslastung eines Clusters deutlich intensivieren.
Wenn Sie mehrere Datenbanken unterstützen,
empfehlen wir, die Replikationsjobs zu staffeln, d. h. zu unterschiedlichen Zeitpunkten auszuführen, oder sie zu einem Zeitpunkt auszuführen, an dem der Cluster weniger beschäftigt ist. 

#### Ein-/Ausgabe-Priorität einer Sicherung ändern

Sie können die Priorität von Sicherungsjobs ändern, indem Sie den Wert des Felds
`x-cloudant-io-priority` im Replikationsdokument anpassen. 

1.  Ändern Sie in den Quellen- und Zielfeldern das Objekt `headers`. 
2.  Ändern Sie im Objekt 'headers' den Wert des Felds `x-cloudant-io-priority` in `"low"`. 

_Beispiel eines JSON-Dokuments, das die Ein-/Ausgabe-Priorität festlegt:_

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
{:codeblock}

<div id="design-documents"></div>

### Entwurfsdokumente sichern

Wenn Sie Entwurfsdokumente in Ihre Sicherung einschließen,
werden Indizes auf dem Sicherungsziel erstellt.
Dies verlangsamt den Sicherungsprozess und belegt unnötig Plattenspeicherplatz.
Wenn Sie keine Indizes auf Ihrem Sicherungssystem benötigen,
verwenden Sie eine Filterfunktion mit Ihren Replikationen, um Entwurfsdokumente herauszufiltern.
Mit der Filterfunktion können Sie auch andere Dokumente ausschließen, die nicht gewünscht sind. 

### Mehrere Datenbanken sichern

Wenn Ihre Anwendung eine Datenbank pro Benutzer verwendet oder Benutzern ermöglicht, verschiedene Datenbanken zu erstellen,
müssen Sie für jede neue Datenbank einen Sicherungsjob erstellen.
Stellen Sie sicher, dass Ihre Replikationsjobs nicht gleichzeitig beginnen. 

## Brauchen Sie Hilfe?

Replikation und Sicherungen können heikel sein.
Wenn Sie nicht weiterkommen, lesen Sie den [Leitfaden zur Replikation](replication_guide.html)
oder wenden Sie sich an das
[IBM Cloudant-Support-Team ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](mailto:support@cloudant.com){:new_window}. 
