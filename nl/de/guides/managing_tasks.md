---

copyright:
  years: 2015, 2017
lastupdated: "2017-01-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# Tasks verwalten

Das Erstellen neuer Indizes aus vielen Daten bzw. das Replizieren einer umfangreichen Datenbank kann ziemlich lange dauern.
{:shortdesc}

Wie können Sie also feststellen, ob Ihre Tasks Fortschritte machen oder ob sie abgeschlossen wurden?
Der [Endpunkt `_active_tasks`](../api/active_tasks.html) liefert Informationen zu allen aktiven Tasks.
Wenn Sie jedoch viele Tasks starten, sind manche möglicherweise für eine spätere Ausführung geplant und werden erst unter `_active_tasks` angezeigt, wenn sie tatsächlich gestartet wurden. 

In diesem Leitfaden erfahren Sie, wie Sie mit dem Endpunkt `_active_tasks` Tasks mit langer Laufzeit überwachen können.
Der Befehl `curl` wird verwendet, um auf den Endpunkt zuzugreifen.
Der JSON-Befehlszeilenprozessor `jq` wird verwendet, um die JSON-Antwort zu verarbeiten. 

Da dies ein taskorientiertes Lernprogramm ist, werden nur die Bereiche abgedeckt, die zum Ausführen der Task relevant sind.
Umfassende Informationen zu den verfügbaren Optionen finden Sie in der [API-Referenz](../api/index.html). 

## Grundlegende Informationen zu 'curl' und 'jq'

Um alle aktiven Tasks abzurufen und die Ausgabe ansprechend zu formatieren,
rufen Sie Ihr Konto mithilfe von `curl` auf und leiten Sie die Ausgabe per Pipe an `jq` weiter. 

Mit `jq` können Sie eine Liste von Dokumenten nach ihren Feldwerten filtern.
Dies vereinfacht das Abrufen aller Replikationsdokumente oder der Details einer bestimmten Ansichtsindexierungstask.
Die [API-Referenz](../api/index.html) enthält weitere Informationen zu diesen Optionen. 

_Beispiel für das Abrufen und Formatieren einer Liste von aktiven Tasks_

```sh
curl 'https://username:password@username.cloudant.com/_active_tasks' | jq '.'
```
{:codeblock}

## Überwachung von Ansichts-Builds und Suchindizes

Ansichtsindizes werden neu erstellt, wenn ein Entwurfsdokument aktualisiert wird.
Eine Aktualisierung einer Ansicht löst die Neuerstellung aller Ansichten in dem Dokument aus. 

Suchindizes werden nur dann neu erstellt, wenn die zugehörige Indexfunktion geändert wird.
Für jeden erstellten Suchindex und für jedes Entwurfsdokument mit Ansichten, die geändert werden,
wird für jedes Replikat jedes Shards in einem Cluster eine neue Task erstellt. 

Wenn beispielsweise 24 Shards
mit je drei Replikaten vorhanden sind
und Sie aktualisieren zwei Suchindizes,
werden 24 x 3 x 2 = 144 Tasks ausgeführt. 

Um alle Ansichtsindexierungstasks zu finden,
leiten Sie die `curl`-Ausgabe über eine Pipe an `jq` weiter
und filtern die Dokumente im Array nach ihrem Typ.
Ein entsprechender Befehl kann für die Suchindexierungstasks ausgeführt werden. 

In beiden Fällen ist das Ergebnis der Suche nach einer Liste von Indexierungstasks eine Liste von JSON-Objekten:
eines für jede gefundene aktive Task. 

_Beispiel für das Suchen aller Indexierungstasks durch Filtern nach dem Typ `indexer`:_

```sh
curl -s 'https://username:password@username.cloudant.com/_active_tasks' | jq '.[] | select(.type=="indexer")'
```
{:codeblock}

_Beispiel für das Suchen aller Indexierungstasks durch Filtern nach dem Typ `search_indexer`:_

```sh
curl -s 'https://username:password@username.cloudant.com/_active_tasks' | jq '.[] | select(.type=="search_indexer")'
```
{:codeblock}

_Beispielergebnisse der Suche nach Ansichtsindexierungstasks:_

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
{:codeblock}

## Zeit bis zur Fertigstellung einer Task schätzen

Sie können die Zeit bis zur Fertigstellung der Indexierungstask schätzen,
indem Sie die Anzahl von vorgenommenen Änderungen (`changes_done`) mit der Gesamtzahl von Änderungen (`total_changes`) vergleichen.
Wenn `changes_done` sich um 250 pro Sekunde erhöht und `total_changes` 1.000.000 ist,
dauert die Task voraussichtlich 1.000.000 / 250 = 4.000 Sekunden, bzw. ca. 66 Minuten. 

>   **Hinweis**: Schätzungen der Zeit bis zur Fertigstellung einer Task sind nie hundertprozentig akkurat. 
    Die tatsächliche Zeit bis zur Fertigstellung der Task hängt von verschiedenen Faktoren ab,
    darunter:

-   Die Zeit für die Verarbeitung der einzelnen Dokumente.
    Beispielsweise kann eine Ansicht zuerst den Typ eines
    Dokuments prüfen und nur für einen bestimmten Typ neue
    Indexeinträge ausgeben. 
-   Die Größe der Dokumente. 
-   Die aktuelle Auslastung des Clusters. 

>   Gehen Sie davon aus, dass diese Faktoren zusammengenommen eine beträchtliche Abweichung von Ihrer Schätzung bedeuten können. 

_Beispiel für das Extrahieren des Felds `changes_done` mithilfe von `jq`:_

```sh
curl ... | jq '.[] | select(.type=="search_indexer") | .changes_done'
```
{:codeblock}

## Replikation überwachen

Um alle Replikationstasks zu finden,
leiten Sie die `curl`-Ausgabe über eine Pipe an `jq` weiter
und filtern Sie die Dokumente im Array nach ihrem Typ.


Um die Auswahl der Informationen zu einem Replikationsprozess aus der Liste aktiver Tasks zu vereinfachen,
starten Sie den Replikationsprozess, indem Sie ein Dokument in der Datenbank `_replicator` erstellen und das
zugehörige Feld `_id` auf einen bekannten Wert setzen. 

_Beispiel für das Suchen aller Replikationstasks durch Filtern nach dem Typ `replication`:_

```sh
curl -s 'https://username:password@username.cloudant.com/_active_tasks' | jq '.[] | select(.type=="replication")'
```
{:codeblock}

_Beispiel für die Suche nach einer bestimmten Replikationstask durch Filtern nach einer bekannten Dokument-ID:_

```sh
curl ... | jq '.[] | select(.doc_id=="ID")'
```
{:codeblock}

_Beispiel für die Suche nach einer bestimmten Replikationstask durch Filtern nach einer bekannten Replikations-ID (`replication_id`):_

```sh
curl ... | jq '.[] | select(.replication_id=="ID")'
```
{:codeblock}

_Beispielergebnis der Suche nach einer Replikationstask:_

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
{:codeblock}

## Fehlerbehebung

### Ist eine Task blockiert?

Für eine einmalige, nicht fortlaufende Replikation, bei der die Quellendatenbank
während der Replikation nicht drastisch aktualisiert wird, gibt der Wert `changes_pending` an,
wie viele Dokumente noch verarbeitet werden müssen.
Das bedeutet, dass der Wert `changes_pending` ein guter Indikator dafür ist, wann die Replikation voraussichtlich abgeschlossen wird. 

Bei einer fortlaufenden Replikation sind Sie eher daran interessiert, wie sich die Anzahl
der verarbeiteten Dokumente im Laufe der Zeit ändert und ob der Wert `changes_pending`
zunimmt.
Wenn `changes_pending` zunimmt, aber `revisions_checked` für längere Zeit konstant bleibt, ist die Replikation wahrscheinlich blockiert.
Wenn beide Werte, `changes_pending` und `revisions_checked` zunehmen,
kann dies darauf hinweisen, dass die Replikation nicht mit der Menge von Daten mithalten kann, die
der Datenbank hinzugefügt oder darin aktualisiert werden. 

### Was tun bei einer blockierten Task?

Um eine blockierte Replikation zu beheben,
müssen Sie möglicherweise den [Replikationsprozess abbrechen](../api/replication.html#cancelling-a-replication) und erneut starten. 

Wenn dies nicht hilft, wurde die Replikation möglicherweise blockiert, weil der Benutzer, der auf die Quellen-
und Zieldatenbanken zugreift, nicht über Schreibberechtigung verfügt. 

>   **Hinweis**: Replikation nutzt [Prüfpunkte](replication_guide.html#checkpoints).
Das heißt, der bereits replizierte und unveränderte Inhalt muss nicht erneut repliziert werden, wenn die Replikation erneut gestartet wird.

Wenn Sie den Replikationsprozess durch Erstellen eines Dokuments in der Datenbank `_replicator` gestartet haben,
können Sie den Status der Replikation auch dort prüfen. 
