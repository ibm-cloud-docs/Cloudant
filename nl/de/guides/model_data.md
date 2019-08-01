---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: immutable data, pre-calculate results, de-normalise data, avoid conflicts, conflict resolution

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

# Fünf Tipps zum Modellieren Ihrer zu skalierenden Daten
{: #five-tips-for-modeling-your-data-to-scale}

In diesem Artikel werden die feineren Aspekte der Modellierung Ihrer Anwendungsdaten besprochen, damit diese auch stark skaliert genutzt werden können.
{: shortdesc}

*(Dieser Leitfaden basiert auf dem Blog-Artikel von Mike Rhodes: ["My top 5 tips for modeling your data to scale" ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://cloudant.com/blog/my-top-5-tips-for-modeling-your-data-to-scale/), der ursprünglich am 17. Dezember 2013 veröffentlicht wurde.)*

Die Art, wie Sie Daten unter {{site.data.keyword.cloudantfull}} modellieren, wirkt sich beträchtlich darauf aus, wie Ihre Anwendung skaliert werden kann. Unser zugrunde liegendes Datenmodell unterscheidet sich grundlegend von einem relationalen Modell. Wenn dieser Unterschied
nicht berücksichtigt wird, können Leistungsprobleme die Folge sein.

Wie immer umfasst eine erfolgreiche Modellierung das Erzielen einer Balance zwischen Benutzerfreundlichkeit und gewünschter Leistung.

Lassen Sie uns beginnen.

## Unveränderliche Daten in Betracht ziehen
{: #consider-immutable-data}

Wenn Sie Änderungen mit einer Rate von einmal pro Sekunde oder schneller vornehmen,
ziehen Sie in Betracht, Ihre Dokumente unveränderlich zu machen. Dies reduziert die Gefahr, Konfliktdokumente zu erstellen, beträchtlich.

Wenn Sie umgekehrt ein gegebenes Dokument weniger als einmal alle zehn Sekunden aktualisieren,
wird ein Datenmodell zur lokalen Aktualisierung - d. h., es werden vorhandene Dokumente aktualisiert -
Ihren Anwendungscode deutlich vereinfachen.

Normalerweise erfordern Datenmodelle auf Basis von unveränderlichen Daten die Verwendung von Ansichten,
um die Dokumente zusammenzufassen, die den aktuellen Status ausmachen. Da Ansichten vorab berechnet werden,
sollte sich dies nicht negativ auf die Anwendungsleistung auswirken.

## Gründe, warum Sie nicht veränderbare Daten berücksichtigen sollten 
{: #why-this-helps-you-consider-immutable-data}

Der `https://$ACCOUNT.cloudant.com/`-Schnittstelle liegt eine verteilte Datenbank zugrunde. 
Im Cluster werden Dokumente in einer Anzahl von Shards gruppiert, die zusammen die Datenbank bilden. Diese Shards werden dann über Knoten im Cluster verteilt. Auf diese Weise
können Datenbanken mit vielen Terabyte unterstützt werden.

Zusätzlich zum Splitting einer Datenbank in Shards haben alle Shards standardmäßig drei
Kopien oder auch Shard-Replikate, die sich alle auf unterschiedlichen Knoten des Datenbankclusters befinden. 
Auf diese Weise kann die Datenbank weiterhin Anforderungen verarbeiten, wenn ein Knoten fehlschlägt. Das Speichern
eines Dokuments umfasst also das Schreiben auf drei Knoten. Das heißt, wenn an einem Dokument gleichzeitig
zwei Aktualisierungen vorgenommen werden, kann eine Untergruppe von Knoten die erste Aktualisierung akzeptieren
und eine andere Untergruppe die zweite. Wenn das Cluster diese Abweichung erkennt, kombiniert es die Dokumente
auf dieselbe Weise wie es die Replikation für gleichzeitig ablaufende Aktualisierungen tut, nämlich indem
ein Konflikt erstellt wird.

Konfliktdokumente wirken sich negativ auf die Leistung aus. Im folgenden Text finden Sie Informationen zu den Gründen.
Ein Muster für viele gleichzeitig ablaufende lokale Aktualisierungen erhöht auch die Wahrscheinlichkeit, dass Schreibvorgänge
abgelehnt werden, weil es sich bei dem angegebenen Parameter `_rev` nicht um den erwarteten handelt. Dies wiederum
zwingt Ihre Anwendung, einen neuen Versuch zu starten, und verzögert so die Verarbeitung.

Wir haben festgestellt, dass dieses Konfliktdokument-Szenario sehr viel wahrscheinlicher eintritt,
wenn Aktualisierungen häufiger als einmal pro Sekunde vorgenommen werden, empfehlen aber zur Sicherheit bereits bei Aktualisierungen, die häufiger als einmal alle zehn Sekunden vorgenommen werden, unveränderliche Dokumente
zu verwenden.

## Ansichten anstelle von Suchindizes für die Vorberechnung von Ergebnissen verwenden
{: #use-views-to-pre-calculate-results-rather-than-as-search-indexes}

Statt Ansichten als überbewertete Suchindizes zu verwenden ("alle Dokumente von `person` abrufen"), können Sie versuchen,
die Datenbank für Sie arbeiten zu lassen. Statt beispielsweise alle zehntausend Personendokumente
abzurufen, um die Gesamtarbeitsstunden zu berechnen, verwenden Sie eine Ansicht mit einem Verbundschlüssel, um
dies mithilfe der integrierten 'reduce'-Funktion `_sum` nach Jahr, Monat, Tag und Stunde vorab zu berechnen. 
Sie ersparen Ihrer Anwendung Arbeit und ermöglichen der Datenbank, viele kleine Anforderungen zu verarbeiten,
statt große Mengen an Daten von Platte zu lesen und in einer einzelnen Anforderung zu verarbeiten.

## Gründe, warum Sie Ansichten für die Vorberechnung von Ergebnissen verwenden sollten
{: #why-this-helps-you-use-views-to-pre-calculate-results}

Es ist ganz einfach. Erstens werden sowohl 'map'- als auch 'reduce'-Funktionen vorab berechnet. Das heißt,
die Frage nach dem Ergebnis einer 'reduce'-Funktion ist eine kostengünstige Operation, insbesondere im Vergleich zu den
immens vielen Ein-/Ausgabe-Operationen, die zum Streamen von Hunderten oder sogar Tausenden von Dokumenten aus dem Plattenspeicher
erforderlich sind.

Auf einer niedrigeren Ebene spielt sich Folgendes ab: Wenn ein Knoten eine Ansichtsanforderung empfängt, fragt er die Knoten, auf denen die Shard-Replikate
für die Datenbank der Ansicht gespeichert sind, nach den Ergebnissen der Ansichtsanforderung für die Dokumente in den einzelnen Shards ab. Wenn er die Antworten empfängt
(es zählt die erste für jedes Shard-Replikat), kombiniert der Knoten, der die Ansichtsanforderung verarbeitet, die Ergebnisse und streamt das finale Ergebnis an den Client. 
Je mehr Dokumente beteiligt sind, umso länger dauert es für jedes Replikat, die Ergebnisse von Platte und über das Netz zu streamen. Hinzu kommt, dass der Knoten, der die Anforderung verarbeitet,
deutlich mehr Arbeit damit hat, die Ergebnisse aus jedem Datenbankshard zu kombinieren.

Insgesamt ist das Ziel, dass eine Ansichtsanforderung die minimale Menge an Daten von jedem Shard benötigt,
dass die Zeit für den Datentransit möglichst kurz ist und dass die Ansichtsanforderung zu einem finalen Ergebnis kombiniert wird. Der Einsatz
von Ansichten zur Vorabberechnung von zusammengefassten Daten ist eine Möglichkeit, dieses Ziel zu realisieren. So wird die
Zeit, die Ihre Anwendung auf den Anschluss der Anforderung wartet, verkürzt.

## Denormalisieren Ihrer Daten
{: #de-normalise-your-data}

In relationalen Datenbanken ist das Normalisieren von Daten häufig die effizienteste Methode, Daten zu speichern. 
Das ist sehr sinnvoll, wenn Sie JOINs verwenden können, um auf einfache Weise Daten aus mehreren Tabellen zu kombinieren. 
In {{site.data.keyword.cloudant_short_notm}} benötigen Sie mit höherer Wahrscheinlichkeit eine HTTP-GET-Anforderung für die
einzelnen Daten, d. h. indem Sie die Anzahl von Anforderungen reduzieren, die erforderlich sind, um ein umfassendes Bild
Ihrer modellierten Entität zu zeichnen, können Sie Ihren Benutzern schneller Informationen bereitstellen.

Mithilfe von Ansichten können Sie viele der Vorteile von normalisierten Daten für sich nutzen und gleichzeitig
die denormalisierte Version aus Gründen der Effizienz beibehalten.

Beispiel: In einem relationalen Schema stellen Sie Tags üblicherweise in einer eigenen Tabelle dar und
verwenden eine verbundene Tabelle, um Tags mit ihren zugehörigen Dokumenten zu verbinden, was eine schnelle Suche nach allen
Dokumenten mit einem bestimmten Tag ermöglicht.

In {{site.data.keyword.cloudant_short_notm}} würden Sie Tags in einer Liste in jedem Dokument speichern. Dann würden Sie eine Ansicht verwenden, um
die Dokumente mit einem bestimmten Tag abzurufen, indem Sie [jeden Tag als Schlüssel in der 'map'-Funktion in Ihrer Ansicht ausgeben](/docs/services/Cloudant?topic=cloudant-views-mapreduce#views-mapreduce). 
Die Abfrage der Ansicht nach einem bestimmten Schlüssel liefert anschließend alle Dokumente mit diesem Tag.

## Gründe, warum das Denormalisieren Ihrer Daten hilft
{: #why-this-helps-you-de-normalize-your-data}

Es läuft alles auf die Anzahl von HTTP-Anforderungen hinaus, die Ihre Anwendung stellt. Das Öffnen von HTTP-Verbindungen - insbesondere HTTPS - ist mit Kosten verbunden und auch wenn das Wiederverwenden von Verbindungen die
Situation schon verbessert, wird vor allem das Stellen weniger Anforderungen die Rate, mit der Ihre Anwendung Daten verarbeiten kann, beschleunigen.

Ein positiver Nebeneffekt ist, dass denormalisierte Dokumente und vorab berechnete Ansichten in vielen Fällen ermöglichen, dass Sie den
Wert, den Ihre Anwendung benötigt, vorab generieren können statt während der Ausführung der Abfrage.

## Konflikte mit differenzierteren Dokumenten vermeiden
{: #avoid-conflicts-by-using-finer-grained-documents}

Der folgende Rat widerspricht in gewisser Weise dem Vorschlag, Ihre Daten zu denormalisieren: Verwenden Sie
differenzierte Dokumente, um die Wahrscheinlichkeit von Konflikten aufgrund gleichzeitig ausgeführter Änderungen zu senken. 
Das bedeutet im Grunde nicht anderes, als Ihre Daten zu normalisieren. Es gilt, den Mittelweg zu finden zwischen dem Reduzieren der
Anzahl von HTTP-Anforderungen und dem Vermeiden von Konflikten.

Beispiel: Eine Krankenakte mit einer Liste von Operationen:

```json
{
    "_id": "Joe McIllness",
    "operations": [
        { "surgery": "heart bypass" },
        { "surgery": "lumbar puncture" }
    ]
}
```
{: codeblock}

Wenn Joe das Pech hat, mehrere Operationen gleichzeitig über sich ergehen lassen zu müssen, führen die
vielen gleichzeitig vorgenommenen Aktualisierungen an einem Dokument wahrscheinlich zu Konfliktdokumenten, wie zuvor beschrieben.
Es ist besser, die Operationen in einzelne Dokumente runterzubrechen, die auf das Personendokument von Joe verweisen,
und mithilfe einer Ansicht zusammengehörige Aspekte miteinander zu verknüpfen. Für jede Operation würden Sie Dokumente wie die folgenden beiden Beispiele
hochladen:

```json
{
    "type": "operation",
    "patient": "Joe McIllness",
    "surgery": "heart bypass"
}
```
{: codeblock}

```json
{
    "type": "operation",
    "patient": "Joe McIllness",
    "surgery": "lumbar puncture"
}
```
{: codeblock}

Die Ausgabe des Felds `"patient"` als Schlüssel in Ihrer Ansicht ließe dann die Abfrage aller
Operationen für einen bestimmten Patienten zu. Auch hier werden Ansichten verwendet, um ein Gesamtbild einer
bestimmten Entität aus verschiedenen Dokumenten zu erstellen, wodurch die Anzahl von HTTP-Anforderungen auch dann
niedrig bleibt, wenn die Daten für eine einzelne modellierte Entität aufgeteilt wurden.

## Gründe, warum dies Konflikte vermeidet
{: #why-this-helps-you-avoid-conflicts}

Indem Sie Konfliktdokumente vermeiden, beschleunigen Sie viele Operationen in Ihren {{site.data.keyword.cloudant_short_notm}}-Datenbanken. 
Grund dafür ist, dass es einen Prozess gibt, der die aktuell entscheidende Revision ermittelt, die immer verwendet wird, wenn das Dokument gelesen wird: einzelne Dokumentabrufe, Aufrufe mit `include_docs=true`, Ansichtserstellung usw.

Die entscheidende Revision ist eine bestimmte Revision aus der Gesamtbaumstruktur des Dokuments. Machen Sie sich bewusst, dass
Dokumente in {{site.data.keyword.cloudant_short_notm}} tatsächlich Baumstrukturen von Revisionen sind. Ein beliebiger, aber deterministischer Algorithmus
wählt eines der nicht gelöschten Blätter dieser Baumstruktur aus, wenn das Dokument angefordert wird. Größere Baumstrukturen mit vielen Ästen brauchen länger für die Verarbeitung als eine
Dokumentbaumstruktur mit keinen oder wenigen Ästen: jedem Ast muss gefolgt werden, um herauszufinden, ob es sich um einen Kandidaten für die entscheidende Revision handeln könnte. Potenzielle Kandidaten müssen dann
verglichen werden, um die endgültige Entscheidung zu treffen.

{{site.data.keyword.cloudant_short_notm}} verarbeitet eine kleine Anzahl von Ästen offensichtlich problemlos,
schließlich basiert Replikation auf dem Konzept, dass Dokumente verzweigt werden, um das Löschen von Daten zu vermeiden.
Aber wenn ein pathologisches Maß erreicht wird, insbesondere wenn die Konflikte nicht gelöst werden, wird das Verfolgen
der einzelnen Äste einer Dokumentbaumstruktur zeitaufwändig und speicherintensiv.

## Integrierte Konfliktlösung
{: #build-in-conflict-resolution}

In einem sukzessive konsistenten System wie {{site.data.keyword.cloudant_short_notm}} lassen sich Konflikte nicht vermeiden. Dies ist
der Preis für Skalierbarkeit und Datenausfallsicherheit. 

Ihre Daten so zu strukturieren, dass die Konfliktlösung schnell ist und keine Hilfe durch den
Bediener erfordert, unterstützt den reibungslosen Betrieb Ihrer Datenbanken. Die Fähigkeit, Konflikte
automatisch zu lösen, ohne dass Ihre Benutzer einbezogen werden müssen, wird deren Erfahrung deutlich
verbessern und hoffentlich den Supportaufwand Ihrer Organisation reduzieren.

Wie Sie dies realisieren, ist sehr anwendungsspezifisch, aber wir können Ihnen ein paar Tipps geben:

-   Vermeiden Sie nach Möglichkeit Invarianten in Dokumentfeldern. Dies macht es viel wahrscheinlicher, dass
    eine einfache Zusammenführungsoperation, die das geänderte Feld aus den einzelnen Konfliktdokumentrevisionen verwendet, ausreicht. Der Anwendungscode ist einfacher und leistungsfähiger.
-   Lassen Sie eigenständige Dokumente zu. Wenn Sie weitere Dokumente abrufen müssen, um die beste Lösung zu ermitteln,
    erhöht sich die Latenz bei der Konfliktlösung. Es besteht auch die Möglichkeit, dass die Version der anderen Dokumente, die Sie abrufen,
    nicht konsistent ist mit Ihrem Dokument, was eine fehlerfreie Konfliktlösung schwierig macht. Und was, wenn die anderen Dokumente ebenfalls Konflikte aufweisen?

## Gründe, warum dies die Integration einer Konfliktlösung unterstützt 
{: #why-this-helps-you-build-in-conflict-resolution}

Wie zuvor beschrieben, lasten Dokumente mit vielen Konflikten die Datenbank sehr aus. Die Integration
einer Funktion zur frühen Konfliktlösung ist eine große Unterstützung beim Vermeiden einer pathologisch hohen Anzahl von Konfliktdokumenten.

## Zusammenfassung
{: #summary}

Diese Tipps zeigen verschiedene Arten, wie sich Modelldaten auf die Leistung Ihrer Anwendung auswirken. Der Datenspeicher von {{site.data.keyword.cloudant_short_notm}} hat einige charakteristische
Merkmale, auf die Sie achten müssen und die Sie für sich nutzen können, um sicherzustellen, dass die
Datenbankleistung mit dem Wachstum Ihrer Anwendung skaliert wird. Wir verstehen, dass ein Wechsel verwirrend sein kann, deshalb stehen wir Ihnen immer mit Rat und Tat zur Seite.

Lesen Sie auch diese Diskussion über das
[Datenmodell für Foundbite ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://cloudant.com/blog/foundbites-data-model-relational-db-vs-nosql-on-cloudant/){: new_window}
oder sehen Sie sich dieses [Beispiel von unseren Freunden bei Twilio ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://www.twilio.com/blog/2013/01/building-a-real-time-sms-voting-app-part-3-scaling-node-js-and-couchdb.html){: new_window} an. 

