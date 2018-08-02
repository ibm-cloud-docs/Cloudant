---

copyright:
  years: 2015, 2018
lastupdated: "2018-06-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# Dokumentversionssteuerung und MVCC

Mit [Multiversion Concurrency Control (MVCC) ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://en.wikipedia.org/wiki/Multiversion_concurrency_control){:new_window}
stellen {{site.data.keyword.cloudantfull}}-Datenbanken sicher, dass alle Knoten in einem Datenbankcluster nur die [aktuelle Version](../api/document.html) eines Dokuments enthalten.
{:shortdesc}

Da {{site.data.keyword.cloudant_short_notm}}-Datenbanken [sukzessive konsistent](cap_theorem.html) sind,
ist dies notwendig, um Inkonsistenzen zwischen Knoten infolge einer Synchronisierung veralteter Dokumente zu vermeiden.

Multiversion Concurrency Control (MVCC) ermöglicht gleichzeitigen Lese- und Schreibzugriff auf eine {{site.data.keyword.cloudant_short_notm}}-Datenbank.
MVCC ist eine Form von [Optimistic Concurrency ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://en.wikipedia.org/wiki/Optimistic_concurrency_control){:new_window}.
Sie beschleunigt sowohl das Lesen als auch das Schreiben von Operationen in {{site.data.keyword.cloudant_short_notm}}-Datenbanken, weil es
keinen Grund für Datenbanksperren gibt.
MVCC ermöglicht auch eine Synchronisierung zwischen {{site.data.keyword.cloudant_short_notm}}-Datenbankknoten.

## Revisionen

Jedes Dokument in einer {{site.data.keyword.cloudant_short_notm}}-Datenbank hat ein Feld `_rev`, in dem die zugehörige Revisionsnummer angegeben ist.

Eine Revisionsnummer wird Ihren Dokumenten vom Server hinzugefügt, wenn Sie diese einfügen oder ändern.
Die Nummer ist in der Serverantwort enthalten, wenn Sie Änderungen vornehmen oder ein Dokument lesen.
Der Wert `_rev` setzt sich aus einer Kombination eines einzelnen Zählers und eines Hashwerts des Dokuments zusammen.

Die zwei Hauptzwecke der Revisionsnummer sind:

1.  Bestimmen, welche Dokumente zwischen Servern repliziert werden müssen.
2.  Bestätigen, dass ein Client versucht, die aktuelle Version eines Dokuments zu ändern.

Sie müssen die frühere Revisionsnummer (`_rev`) angeben, wenn Sie ein [Dokument aktualisieren](../api/document.html#update),
sonst schlägt Ihre Anforderung fehl und gibt einen [409-Fehler](../api/http.html#409) zurück.

>   **Hinweis**: `_rev` sollte nicht verwendet werden, um ein System zur Versionssteuerung zu erstellen.
    Es handelt sich um einen internen Wert, der vom Server verwendet wird.
    Außerdem sind ältere Revisionen eines Dokuments transient
    und werden deshalb regelmäßig gelöscht.

Sie können eine bestimmte Revision mithilfe des zugehörigen `_rev`-Werts abfragen,
ältere Revisionen werden jedoch regelmäßig von einem Prozess namens
[Datenverdichtung ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://en.wikipedia.org/wiki/Data_compaction){:new_window} gelöscht.
Eine Konsequenz der Verdichtung ist, dass Sie nicht davon ausgehen können, eine erfolgreiche Antwort zu empfangen,
wenn Sie eine bestimmte Dokumentrevision unter Angabe von `_rev` abfragen, um den Verlauf der Revisionen Ihres Dokuments abzurufen.
Wenn Sie einen Versionsverlauf Ihrer Dokumente benötigen,
sollten Sie für jede Revision [ein neues Dokument erstellen](../api/document.html#documentCreate).

## Verteilte Datenbanken und Konflikte

Verteilte Datenbanken arbeiten ohne konstante Verbindung zur Hauptdatenbank unter {{site.data.keyword.cloudant_short_notm}},
die selbst ebenfalls verteilt ist, deshalb können Aktualisierungen, die auf derselben früheren Version basieren,
trotzdem in Konflikt zueinander stehen.

Um Konflikte zu finden, fügen Sie beim Abrufen eines Dokuments den Abfrageparameter [`conflicts=true`](../api/database.html#get-changes) hinzu.
Die Antwort enthält ein Array `_conflicts` mit allen in Konflikt stehenden Revisionen.

Schreiben Sie eine Ansicht, um Konflikte für mehrere Dokumente in einer Datenbank zu finden.

Die folgende 'map'-Funktion ist ein Beispiel, das alle in Konflikt stehenden Revisionen für jedes Dokument mit einem Konflikt ausgibt.

_Beispiel einer 'map'-Funktion zum Suchen von Dokumenten mit einem Konflikt:_

```javascript
function (doc) {
    if (doc._conflicts) {
        emit(null, [doc._rev].concat(doc._conflicts));
    }
}
```
{:codeblock}

Sie können diese Ansicht regelmäßig abfragen und Konflikte bei Bedarf lösen,
oder Sie können die Ansicht nach jeder Replikation abfragen.

## Vorgehensweise beim Lösen von Konflikten

Sobald Sie einen Konflikt gefunden haben,
können Sie ihn in 4 Schritten lösen.

1.  [Abrufen](#get-conflicting-revisions) der in Konflikt stehenden Revisionen.
2.  [Zusammenführen](#merge-the-changes) der Revisionen in Ihrer Anwendung oder Befragen des Benutzers nach seinen Präferenzen.
3.  [Hochladen](#upload-the-new-revision) der neuen Revision.
4.  [Löschen](#delete-old-revisions) alter Revisionen.

Sehen wir uns ein Beispiel dafür an.
Angenommen, Sie haben eine Datenbank mit Produkten für einen Onlineshop.
Die erste Version eines Dokuments kann dem folgenden Beispiel ähneln:

```json
{
    "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "1-7438df87b632b312c53a08361a7c3299",
    "name": "Samsung Galaxy S4",
    "description": "",
    "price": 650
}
```
{:codeblock}

Da das Dokument noch keine Beschreibung hat,
kann ein Benutzer eine hinzufügen:

_Zweite Version des Dokuments, erstellt durch Hinzufügen einer Beschreibung:_

```json
{
    "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "2-61ae00e029d4f5edd2981841243ded13",
    "name": "Samsung Galaxy S4",
    "description": "Latest smartphone from Samsung",
    "price": 650
}
```
{:codeblock}

Zur gleichen Zeit setzt ein anderer Benutzer, der mit einer replizierten Datenbank arbeitet, den Preis herab:

_Eine andere Revision, die mit der vorherigen aufgrund von unterschiedlichen `price`-Werten in Konflikt steht:_

```json
{
    "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "2-f796915a291b37254f6df8f6f3389121",
    "name": "Samsung Galaxy S4",
    "description": "",
    "price": 600
}
```
{:codeblock}

Die beiden Datenbanken werden dann repliziert.
Die Abweichungen in den Dokumentversionen führen zu einem Konflikt.

### Konfliktrevisionen abrufen

Sie können Dokumente mit Konflikten mithilfe der Option `conflicts=true` ermitteln.

_Beispiel für das Suchen von Dokumenten mit Konflikten:_

```http
http://$ACCOUNT.cloudant.com/products/$_ID?conflicts=true
```
{:codeblock}

_Beispielantwort mit Konfliktrevisionen, die sich auf Dokumente auswirken:_

```json
{
    "_id":"74b2be56045bed0c8c9d24b939000dbe",
    "_rev":"2-f796915a291b37254f6df8f6f3389121",
    "name":"Samsung Galaxy S4",
    "description":"",
    "price":600,
    "_conflicts":["2-61ae00e029d4f5edd2981841243ded13"]
}
```
{:codeblock}

Die Version mit dem geänderten Preis wurde beliebig ausgesucht als aktuelle Version des Dokuments und auf den Konflikt mit einer anderen Version wird hingewiesen, indem die ID dieser anderen Version im Array `_conflicts` angegeben wird.
In den meisten Fällen hat dieses Array nur ein Element, aber es kann viele Konfliktrevisionen geben.

### Änderungen zusammenführen

Um mithilfe eines Vergleichs der Revisionen zu sehen, was geändert wurde,
ruft Ihre Anwendung alle Versionen aus der Datenbank ab.

_Beispielbefehle zum Abrufen aller Versionen eines Dokuments aus der Datenbank:_

```http
http://$ACCOUNT.cloudant.com/products/$_ID
http://$ACCOUNT.cloudant.com/products/$_ID?rev=2-61ae00e029d4f5edd2981841243ded13
http://$ACCOUNT.cloudant.com/products/$_ID?rev=1-7438df87b632b312c53a08361a7c3299
```
{:codeblock}

Da sich die in Konflikt stehenden Änderungen auf verschiedene Felder des Dokuments beziehen,
können sie einfach zusammengeführt werden.

Für komplexere Konflikte sind unter Umständen andere
Lösungsstrategien erforderlich:

*   Zeitbasiert: Verwenden Sie die erste oder die letzte Bearbeitung.
*   Benutzereingriff: Berichten Sie Konflikte an Benutzer und lassen Sie sie entscheiden, welche Lösung die passende ist.
*   Hoch entwickelte Algorithmen: beispielsweise 3-Wege-Zusammenführungen von Textfeldern.

Ein praktisches Beispiel für die Implementierung einer Zusammenführung von Änderungen finden Sie in
[diesem Projekt mit Beispielcode ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/glynnbird/deconflict){:new_window}.

### Neue Revision hochladen

Der nächste Schritt besteht darin, ein Dokument zu erstellen, in dem die Konflikte gelöst sind, und die Datenbank damit zu aktualisieren.

_Ein Beispieldokument, das Änderungen aus den zwei Konfliktrevisionen zusammenführt:_

```json
{
    "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "3-daaecd7213301a1ad5493186d6916755",
    "name": "Samsung Galaxy S4",
    "description": "Latest smartphone from Samsung",
    "price": 600
}
```
{:codeblock}

### Alte Revisionen löschen

Schließlich löschen Sie die alten Revisionen, indem Sie eine `DELETE`-Anforderung an die URLs mit der zu löschenden Revision senden.

_Beispielanforderung zum Löschen einer alten Dokumentrevision, unter Verwendung von HTTP:_

```http
DELETE https://$ACCOUNT.cloudant.com/products/$_ID?rev=2-61ae00e029d4f5edd2981841243ded13
```
{:codeblock}

_Beispielanforderung zum Löschen einer alten Dokumentrevision, über die Befehlszeile:_

```sh
curl "https://$ACCOUNT.cloudant.com/products/$_ID?rev=2-f796915a291b37254f6df8f6f3389121" -X DELETE
```
{:codeblock}

An diesem Punkt sind die Konflikte, die sich auf das Dokument auswirken, gelöst.
Sie können dies überprüfen, indem Sie das Dokument erneut mit `GET` abrufen, wobei der Parameter
`conflicts` auf `true` gesetzt ist.
