---

copyright:
  years: 2015, 2019
lastupdated: "2019-03-15"

keywords: find conflicts, resolve conflicts, merge changes, upload new revision, delete revision

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

<!-- Acrolinx: 2018-05-07 -->

# Konflikte
{: #conflicts}

Wenn in verteilten Datenbanken gegebenenfalls Kopien der Daten an mehreren Positionen
gespeichert werden, können die Kenndaten des Netzes und/oder das Systems dafür sorgen, dass
Dokumentänderungen an einer Position nicht sofort in andere Teile der Datenbank übernommen oder repliziert
werden können.

Mit anderen Worten: Wenn unabhängige Aktualisierungen an verschiedenen Dokumentkopien
vorgenommen werden, kann dies zu abweichenden Einschätzungen (Konflikten) führen, welche
Kopie den aktuellen und gültigen Inhalt des Dokuments enthält.

{{site.data.keyword.cloudantfull}} unterstützt die Vermeidung von Konflikten durch Warnungen vor potenziellen Problemen.
Zu diesem Zweck wird die [Antwort `409`](/docs/services/Cloudant?topic=cloudant-http#http-status-codes) für eine problematische Aktualisierungsanforderung zurückgegeben.
Eine solche Antwort `409` wird jedoch möglicherweise nicht empfangen, wenn die Datenbankaktualisierung in
einem System angefordert wird, das gegenwärtig nicht mit dem Netz verbunden ist.
Wenn sich die Datenbank beispielsweise auf einem mobilen Gerät befindet, das vorübergehend
vom Internet getrennt ist, kann in diesem Zeitraum nicht geprüft werden, ob
weitere Aktualisierungen vorgenommen wurden, die zu Konflikten führen können.

Wenn Sie ein Dokument anfordern, für das möglicherweise ein Konflikt besteht,
wird das betreffende Dokument von {{site.data.keyword.cloudant_short_notm}} wie erwartet zurückgegeben.
Die Version des Dokuments wird jedoch durch einen internen Algorithmus bestimmt,
der verschiedene Faktoren berücksichtigt. Sie sollten beispielsweise nicht davon ausgehen,
dass immer die aktuellste Version des Dokuments zurückgegeben wird.

Wenn Sie keine Konfliktprüfung durchführen oder keine Konfliktverarbeitung
einrichten, zeigt Ihre {{site.data.keyword.cloudant_short_notm}}-Datenbank
möglicherweise die folgenden Verhaltensweisen:

* Immer mehr Inkonsistenzen im Dokumentinhalt durch die Zunahme von Dokumentkonflikten
* Zunahme der Datenbankgröße, da alle betroffenen Dokumente aufbewahrt werden müssen, bis die Konflikte behoben sind
* Geringere Leistung durch den erhöhten Verarbeitungsaufwand für Anforderungen in {{site.data.keyword.cloudant_short_notm}}, um bei Konflikten die 'optimale' Dokumentversion zu ermitteln

Die folgenden empfohlenen Vorgehensweisen können dabei helfen,
den geeigneten Zeitpunkt für die Erkennung und Behebung von Konflikte zu identifizieren:

<table>
<tr>
<th>Anwendungsmerkmal</th>
<th>Häufigkeit der Dokumentaktualisierung</th>
<th>Konfliktprüfung beim Abrufen?</th>
<th>Konfliktprüfung beim Aktualisieren?</th>
</tr>
<tr>
<td>Ständige Verbindung zum Netz (z. B. bei einem Server).</td>
<td>Häufig</td>
<td>Ja</td>
<td>-</td>
</tr>
<tr>
<td>Ständige Verbindung zum Netz.</td>
<td>Gelegentlich</td>
<td>-</td>
<td>Ja</td>
</tr>
<tr>
<td>Häufige, jedoch nicht ständige Verbindung zum Netz (z. B. bei einem Laptop).</td>
<td>Häufig</td>
<td>-</td>
<td>Ja</td>
</tr>
<tr>
<td>Häufige, jedoch nicht ständige Verbindung zum Netz.</td>
<td>Gelegentlich</td>
<td>-</td>
<td>Ja</td>
</tr>
<tr>
<td>Gelegentliche Verbindung zum Netz (z. B. bei einem Tablet-Computer).</td>
<td>Häufig</td>
<td>-</td>
<td>Ja</td>
</tr>
</table>

## Konflikte erkennen
{: #finding-conflicts}

Um Konflikte zu erkennen, die sich auf ein Dokument auswirken können,
fügen Sie beim Abrufen eines Dokuments den Abfrageparameter `conflicts=true` hinzu.
Das resultierende Dokument enthält ein Array `_conflicts`
mit einer Liste aller Revisionen, für die Konflikte bestehen.

> Beispiel einer 'map'-Funktion zum Erkennen von Dokumentkonflikten:

```
function (doc) {
  if (doc._conflicts) {
    emit(null, [doc._rev].concat(doc._conflicts));
    }
}
```

Schreiben Sie eine [Ansicht](/docs/services/Cloudant?topic=cloudant-views-mapreduce#views-mapreduce), um Konflikte für
mehrere Dokumente in einer Datenbank zu finden.
Mithilfe einer 'map'-Funktion wie im vorliegenden Beispiel können Sie alle Revisionen
für jedes Dokument finden, für die ein Konflikt besteht.

Wenn eine solche Ansicht verfügbar ist, kann sie verwendet
werden, um Konflikte bei Bedarf zu finden und zu lösen.
Alternativ können Sie die Ansicht nach jeder Replikation abfragen,
um Konflikte sofort zu erkennen und zu Lösen.

## Vorgehensweise beim Lösen von Konflikten
{: #how-to-resolve-conflicts}

Sobald Sie einen Konflikt gefunden haben, können Sie ihn mit den folgenden 4 Schritten lösen:

1.	[Abrufen](#get-conflicting-revisions) der in Konflikt stehenden Revisionen.
2.	[Zusammenführen](#merge-the-changes) der Revisionen in Ihrer Anwendung oder Befragen des Benutzers nach seinen Präferenzen
3.	[Hochladen](#upload-the-new-revision) der neuen Revision.
4.	[Löschen](#delete-old-revisions) alter Revisionen

> Beispieldokument - erste Revision

```json
{
  "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "1-7438df87b632b312c53a08361a7c3299",
    "name": "Samsung Galaxy S4",
    "description": "",
    "price": 650
}
```

Sehen wir uns ein Beispiel dafür an.
Angenommen, Sie haben eine Datenbank mit Produkten für einen Onlineshop.
Die erste Version eines Dokuments kann dem angegebenen Beispiel ähneln:

> Zweite Version (erste Revision) des Dokuments, in der eine Beschreibung hinzugefügt wird:

```json
{
  "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "2-61ae00e029d4f5edd2981841243ded13",
    "name": "Samsung Galaxy S4",
    "description": "Latest smartphone from Samsung",
    "price": 650
}
```

Da das Dokument noch nicht über eine Beschreibung verfügt, kann ein Benutzer
eine Beschreibung hinzufügen.

> _Alternative_ zweite Version, in der andere Preissenkungsdaten als in der ersten Dokumentversion eingeführt werden.

```json
{
  "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "2-f796915a291b37254f6df8f6f3389121",
    "name": "Samsung Galaxy S4",
    "description": "",
    "price": 600
}
```

Zur gleichen Zeit setzt ein anderer Benutzer, der mit einer replizierten Datenbank arbeitet, den Preis herab.
Diese Änderung wird in der ersten Dokumentversion vorgenommen.
Die Preissenkungsänderung 'kennt' daher nicht die geänderte Beschreibung.

Beim späteren Replizieren der beiden Datenbanken ist möglicherweise
nicht eindeutig klar, welche der beiden verschiedenen Dokumentversionen korrekt ist.
Ein Konfliktszenario ist entstanden.

## Konfliktrevisionen abrufen
{: #get-conflicting-revisions}

Um alle Konfliktrevisionen für ein Dokument zu finden, rufen Sie das
Dokument wie gewohnt ab und fügen Sie dabei den Parameter `conflicts=true`
ein, wie im folgenden Beispiel gezeigt:

`http://ACCOUNT.cloudant.com/products/$_ID?conflicts=true`


> Beispielantwort für Dokumentabruf mit Konfliktrevisionen:

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

Wenn für das Dokument Konflikte bestehen, erhalten Sie eine Antwort ähnlich
wie im vorliegenden Beispiel, die auf der geänderten Beschreibung oder der Preisänderung
basiert.

Die Version mit dem geänderten Preis wurde _beliebig_ als aktuelle Version des Dokuments ausgewählt.
Sie sollten nicht davon ausgehen, dass die zuletzt aktualisierte Dokumentversion als neueste Version für die Konfliktlösung eingestuft wird.

Im vorliegenden Beispiel wird von einem Konflikt zwischen dem abgerufenen Dokument mit
dem `_rev`-Wert `2-f796915a291b37254f6df8f6f3389121` und einem
anderen Dokument mit dem `_rev`-Wert `2-61ae00e029d4f5edd2981841243ded13` ausgegangen.
Die Details für das Dokument mit bestehendem Konflikt sind im Array `_conflicts` aufgeführt.

Obwohl das Array häufig nur ein einziges Element enthält,
können mehrere Konfliktrevisionen vorhanden sein, die alle in dem Array
aufgelistet werden.

## Änderungen zusammenführen
{: #merge-the-changes}

Ihre Anwendung muss alle potenziellen Änderungen identifizieren und
abgleichen, indem die korrekten und gültigen Aktualisierungen zu einer
einzigen, konfliktfreien Dokumentversion zusammengeführt werden.

Um mithilfe eines Vergleichs der Revisionen zu ermitteln, was geändert wurde,
muss Ihre Anwendung alle Versionen aus der Datenbank abrufen.
Wie bereits zuvor erläutert, beginnen wir mit dem Abrufen eines Dokuments
und der Details aller in Konflikt stehenden Versionen.
Zu diesem Zweck wird ein Befehl ähnlich dem folgenden abgesetzt, der
ebenfalls das Array `_conflicts` anfordert:

`http://$ACCOUNT.cloudant.com/products/$_ID?conflicts=true
`

Diese Abfrage liefert eine aktuelle Version des Dokuments, die gespeichert wird,
_und_ eine Liste aller weiteren, in Konflikt stehenden Dokumente, die ebenfalls
abgerufen werden müssen, zum Beispiel `...rev=2-61ae00e029d4f5edd2981841243ded13`
und `...rev=1-7438df87b632b312c53a08361a7c3299`.
Jede dieser weiteren, in Konflikt stehenden Versionen wird ebenfalls abgerufen und
gespeichert, wie im folgenden Beispiel gezeigt:

  `http://$ACCOUNT.cloudant.com/products/$_ID?rev=2-61ae00e029d4f5edd2981841243ded13`
  `http://$ACCOUNT.cloudant.com/products/$_ID?rev=1-7438df87b632b312c53a08361a7c3299`

Sobald alle in Konflikt stehenden Versionen eines Dokuments zur Verfügung stehen,
kann mit der Konfliktlösung begonnen werden.

In dem zuvor verwendeten Szenario bestanden Unterschiede zwischen den Dokumentversionen
in verschiedenen Feldern des Dokuments, die ohne großen Aufwand zusammengeführt werden konnten.

Komplexere Konflikte erfordern wahrscheinlich einen größeren Analyseaufwand.
Als Hilfsmittel können Sie auf verschiedene Konfliktlösungsstrategien wie die folgenden
zurückgreifen:

*	Zeitbasiert: Ein einfacher Test, um die zuerst oder zuletzt ausgeführte Bearbeitung zu ermitteln.
*	Benutzerbewertung: Die Konflikte werden den Benutzern gemeldet, damit sie über die beste Lösung entscheiden.
*	Hoch entwickelte Zusammenführungsalgorithmen: Solche Algorithmen werden häufig in [Systemen zur Versionssteuerung](https://en.wikipedia.org/wiki/Merge_%28version_control%29) verwendet. Ein Beispiel hierfür ist die 3-Wege-Zusammenführung ([3-way merge](https://en.wikipedia.org/wiki/Merge_%28version_control%29#Three-way_merge)).

Ein praktisches Beispiel für die Implementierung dieser Änderungen finden Sie in [diesem Projekt mit Beispielcode](https://github.com/glynnbird/deconflict).

## Neue Revision hochladen
{: #upload-the-new-revision}

> Finale Revision nach dem Auflösen und Zusammenführen der Änderungen aus den vorherigen, in Konflikt stehenden Revisionen.

```json
{
  "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "3-daaecd7213301a1ad5493186d6916755",
    "name": "Samsung Galaxy S4",
    "description": "Latest smartphone from Samsung",
    "price": 600
}
```

Nach dem Bewerten und Auflösen der Konflikte erstellen Sie ein
Dokument, das die aktuellen und verbindlichen Daten enthält.
Dieses aktuelle Dokument wird in die Datenbank hochgeladen.

## Alte Revisionen löschen
{: #delete-old-revisions}

> Beispielanforderungen zum Löschen alter Revisionen.

```http
DELETE http://$ACCOUNT.cloudant.com/products/$_ID?rev=2-61ae00e029d4f5edd2981841243ded13

DELETE http://$ACCOUNT.cloudant.com/products/$_ID?rev=2-f796915a291b37254f6df8f6f3389121
```

Der abschließende Schritt ist das Löschen der alten Revisionen.
Zu diesem Zweck setzen Sie eine Anforderung `DELETE` ab, in der
die zu löschenden Revisionen angegeben sind.

Nach dem Löschen der älteren Versionen eines Dokuments werden die
zugehörigen Konflikte für das Dokument als gelöst (behoben) markiert.
Sie können überprüfen, dass keine Konflikte mehr bestehen, indem Sie das
Dokument erneut anfordern und dabei den Parameter `conflicts` auf 'true'
setzen, [wie oben dargestellt](#finding-conflicts).
