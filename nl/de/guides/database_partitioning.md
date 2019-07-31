---

copyright:
  years: 2019
lastupdated: "2019-06-12"

keywords: database shards, non-partitioned databases, partition key, global query, partition query, create partition database, create partition query index

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

<!-- Acrolinx: 2018-08-17 -->

# Datenbankpartitionierung
{: #database-partitioning}

{{site.data.keyword.cloudantfull}} unterstützt zwei Datenbanktypen:

- Partitionierte
- Nicht partitionierte

Eine _partitionierte_ Datenbank bietet erhebliche Leistungs- und Kostenvorteile; sie erfordert jedoch
das Festlegen einer logischen Partitionierung für Ihre Daten. Dies wird im folgenden Text näher erläutert. 

Alternativ kann eine _nicht partitionierte_ Datenbank erstellt werden. Dieser Datenbanktyp
ist möglicherweise leichter zu handhaben, da kein Partitionierungsschema definiert werden muss; es können jedoch
nur globale sekundäre Indizes erstellt werden.

{{site.data.keyword.cloudant_short_notm}} empfiehlt dringend die Verwendung einer partitionierten
Datenbank, um langfristig eine optimale Datenbankleistung zu erzielen, sofern das Datenmodell die logische
Partitionierung von Dokumenten zulässt.

Der Partitionierungstyp einer Datenbank wird beim Erstellen der Datenbank festgelegt.  Geben Sie
beim Erstellen der Datenbank durch den Abfragezeichenfolgeparameter `partitioned` an,
ob es sich um eine partitionierte Datenbank handelt. Der Parameter `partitioned` wird
standardmäßig auf `false` gesetzt, um die Abwärtskompatibilität zu gewährleisten.

Der Partitionierungstyp einer bestehenden Datenbank kann nicht geändert werden.

## Datenbankshards
{: #database-shards}

Beim Lesen dieses Dokuments sollten Sie mit dem
[Sharding-Konzept](/docs/services/Cloudant?topic=cloudant-how-is-data-stored-in-ibm-cloudant-#how-is-data-stored-in-ibm-cloudant-) in {{site.data.keyword.cloudant_short_notm}} vertraut sein.

## Nicht partitionierte Datenbanken
{: #non-partitioned-databases}

Eine nicht partitionierte Datenbank ist der ältere {{site.data.keyword.cloudant_short_notm}}-Datenbanktyp, den
Sie gegebenenfalls vom Arbeiten mit CouchDB oder {{site.data.keyword.cloudant_short_notm}} kennen.

In einer nicht partitionierten Datenbank werden Dokumente basierend auf einer Umsetzung ihrer
Dokument-IDs beliebig auf Shards verteilt. Das bedeutet, es besteht keine klar erkennbare
Beziehung zwischen einer Dokument-ID und der Shard, der das Dokument zugeordnet wird. Dokumente
mit ähnlichen Dokument-IDs werden nicht unbedingt im selben Shard platziert.

Eine nicht partitionierte Datenbank lässt nur globale Abfragen zu, die weiter
unten näher erläutert werden. 

## Partitionierte Datenbanken
{: #partitioned-databases-database-partitioning}

Die partitionierte Datenbank ist ein neuer {{site.data.keyword.cloudant_short_notm}}-Datenbanktyp. In einer
partitionierten Datenbank werden Dokumente durch einen _Partitionsschlüssel_ zu logischen Partitionen
zusammengefasst, der Bestandteil der Dokument-ID für Dokumente in partitionierten Datenbanken ist. Alle Dokumente werden einer Partition zugeordnet und vielen Dokumenten wird in der Regel
derselbe Partitionsschlüssel zugewiesen. Die primären JSON-Daten und Indizes einer Partition
werden an benachbarten Speicherorten platziert, um ein effizienteres Abfragen der Daten innerhalb
einer Partition zu ermöglichen.

In einer partitionierten Datenbank sind sowohl partitionierte als auch globale Abfragen möglich. Partitionierte
Abfragen nutzen das Datenlayout im Datenbankcluster, um eine höhere und besser skalierbare
Abfrageleistung zu erzielen. Darüber hinaus sind Partitionsabfragen häufig
kostengünstiger als globale Abfragen.

Da partitionierte Datenbanken sowohl globale Abfragen als auch Partitionsabfragen
unterstützen, empfiehlt {{site.data.keyword.cloudant_short_notm}} für neue Anwendungen
die Nutzung der Vorteile partitionierter Datenbanken.

## Was zeichnet einen guten Partitionsschlüssel aus?
{: #what-makes-a-good-partition-key-}

Wenn Sie beabsichtigen, die neue {{site.data.keyword.cloudant_short_notm}}-Funktion für *partitionierte Datenbanken* zu
nutzen, ist die Auswahl des Partitionsschlüssels von großer Bedeutung. Ein Partitionsschlüssel muss Folgendes aufweisen:

- Viele Werte: Viele kleine Partitionen sind besser als wenige große Partitionen.
- Engpässe vermeiden: Vermeiden Sie in Ihrem System einzelne Partitionen, die einen großen Anteil
  der Workload verarbeiten müssen. Wenn die Arbeitslast gleichmäßig auf die Partitionen verteilt wird,
  kann die Datenbank reibungsloser arbeiten.
- Wiederholung: Wenn jeder Partitionsschlüssel eindeutig ist, enthält jede Partition
  genau ein Dokument. Partitionierte Datenbanken bieten den größten Nutzen, wenn jede
  Partition eine größere Anzahl logisch zusammengehöriger Dokumente enthält.

Die folgenden Anwendungsfälle zeigen einige vorteilhafte und nachteilige Auswahlmöglichkeiten für Partitionsschlüssel auf.

| Anwendungsfall                   | Beschreibung                 | Partitionsschlüssel | Effektivität                                                                                                  |
|----------------------------|-----------------------------|---------------|------------------------------------------------------------------------------------------------------------------|
| E-Commerce-System - Bestellungen | Ein Dokument pro Bestellung     | Bestell-ID      | Neutral. Ein Dokument pro Partition ist akzeptabel, jedoch ohne die Vorteile von Partitionsabfragen.          |
| E-Commerce-System - Bestellungen | Ein Dokument pro Bestellung     | Benutzer-ID       | Gut. Alle Bestellungen eines Benutzers werden zusammen abgelegt.                                                             |
| E-Commerce-System - Bestellungen | Ein Dokument pro Bestellung      | Status        | Schlecht. Durch das Gruppieren von Bestellungen nach wenigen Statuswerten (vorläufig, bezahlt, erstattet, storniert) entsteht eine kleine Anzahl besonders umfangreicher Partitionen.  |
| Blogging-Plattform          | Ein Dokument pro Blogbeitrag | Ersteller-ID     | Gut. Solange es viele Ersteller gibt. Die Beiträge eines bestimmten Erstellers können problemlos abgefragt werden.                                     |
| IoT - Sensormesswerte      | Ein Dokument pro Messwert    | Geräte-ID     | Gut. Sofern viele Geräte vorhanden sind. Stellen Sie sicher, dass kein Gerät deutlich mehr Messwerte liefert als die übrigen Geräte. |
| IoT - Sensormesswerte      | Ein Dokument pro Messwert    | Datum          | Schlecht. Aktuelle Messwerte führen zu einer hohen Arbeitslast (Engpass) in der Partition für das aktuelle Datum.                                  |

Manche Anwendungsfälle bieten keinen effizienten Ansatz zum Festlegen eines Partitionsschlüssels.
In solchen Situationen ist wahrscheinlich eine nicht partitionierte Datenbank die bessere Wahl (z. B. eine
Datenbank der Benutzer, in der E-Mail-Adressen, in Hashwerte umgewandelte Kennwörter und die
Datumsangaben der letzten Anmeldungen gespeichert werden). Da keines dieser Felder einen
guten Ansatzpunkt für einen effizienten Partitionsschlüssel bietet, muss stattdessen eine
herkömmliche, nicht partitionierte Datenbank verwendet werden.

## Abfragen
{: #querying}

In diesem Abschnitt wird beschrieben, welche {{site.data.keyword.cloudant_short_notm}}-Abfragetypen
für globale Abfragen und für Partitionsabfragen verfügbar sind. Außerdem wird ein Überblick über die grundsätzliche
Vorgehensweise zum Auswählen des am besten geeigneten Abfrageverfahrens für jede erforderliche Abfrage in Ihrer Anwendung
gegeben.

### Globale Abfrage
{: #global-querying}

Sie können globale Abfragen für die folgenden Indextypen ausführen:

- {{site.data.keyword.cloudant_short_notm}}-Abfrage
- Ansichten
- Suche
- Geodaten

Beim Ausführen einer globalen Abfrage muss die Datenbank eine Scatter/Gather-Operation
für alle Daten in der Datenbank ausführen. Dazu gehören Anfragen an viele einzelne
Datenbankserver. Der API-Koordinationsknoten empfängt die Antworten von allen angefragten Servern
und fasst sie zu einer einzigen Antwort an den Client zusammen. Dabei werden gegebenenfalls
Daten zwischengespeichert und die Antwort an den Client wird verzögert, wenn beispielsweise
Daten sortiert werden müssen.

### Partitionsabfrage
{: #partition-querying}

Sie können Partitionsabfragen für die folgenden Indextypen ausführen:

- {{site.data.keyword.cloudant_short_notm}}-Abfrage
- Ansichten
- Suche

Beim Ausführen einer Partitionsabfrage kann die Datenbank gezielt Daten
innerhalb einer einzigen Partition abfragen. Da sich die Daten einer Partition
in genau einer Shard (mit drei Replikaten) befinden, kann der API-Koordinationsknoten
gezielt diejenigen Server abfragen, auf denen die Daten gehostet werden, anstatt
Antworten von zahlreichen Servern zusammenzufassen. Außerdem ist kein Zwischenspeichern
von Antworten erforderlich, da das Zusammenfassen einzelner Antworten entfällt. Dies führt dazu, dass
die Daten schneller zum Client gelangen.

Darüber hinaus muss mit zunehmender Größe der Datenbank auch die Anzahl der
Shards erhöht werden. Dadurch erhöht sich auch die Anzahl der Abfragen an
Server, auf denen Daten für globale Abfragen gehostet werden, die der
API-Koordinationsknoten verarbeiten muss. Bei Partitionsabfragen hat die Anzahl
der Shards jedoch keine Auswirkung auf die Anzahl der Server, die vom
API-Koordinationsknoten abgefragt werden müssen. Da die Anzahl der Abfragen
begrenzt wird, hat die Datenmenge (anders als bei globalen Abfragen) keine Auswirkung
auf die Abfragelatenz.

## Beispiel: Partitionierung von IoT-Messwertdaten
{: #example-partitioning-iot-reading-data}

Diese abstrakte Betrachtung soll durch ein konkretes Beispiel aus dem Internet der Dinge veranschaulicht werden. Angenommen,
{{site.data.keyword.cloudant_short_notm}} soll als Protokollierungstool für
Gerätemesswerte verwendet werden, die Sensormesswerte zu Elementen der Infrastruktur wie
Straßen oder Brücken bereitstellen.

Dabei wird von den folgenden Rahmenbedingungen ausgegangen:

- Hunderttausende von Geräten stellen Messwerte bereit.
- Jedes Gerät verfügt über eine eindeutige ID.
- Jedes Element der Infrastruktur verfügt über eine eindeutige ID.
- Die Geräte werden nicht zwischen den Elementen der Infrastruktur verschoben.
- Jedes Gerät meldet alle 10 Sekunden einen Messwert an {{site.data.keyword.cloudant_short_notm}}. Dieser Wert
    wird über einen Nachrichtenbus an {{site.data.keyword.cloudant_short_notm}} übergeben.

In einer nicht partitionierten Datenbank können Sie beispielsweise zulassen, dass {{site.data.keyword.cloudant_short_notm}}
Dokument-IDs generiert. Eine andere Möglichkeit besteht darin, Dokumente nach Geräte-ID und Zeitmarke zu benennen.

Mit dem zweiten Verfahren erhalten wir Dokument-IDs wie die folgende:

```
gerät-123456:20181211T11:13:24.123456Z
```

Die Zeitmarke kann auch auf einer Epoche basieren.

Bei Verwendung dieses Verfahrens können die Daten für jedes Gerät anhand der
partitionierten Indizes zwar effizient abgefragt werden, aber zum Erstellen von Ansichten
für mehrere Geräte (z. B. alle Geräte in einem bestimmten Element der Infrastruktur)
müssen globale Indizes verwendet werden.

Verwenden wir zur Veranschaulichung ein etwas komplexeres Szenario, in dem die Anwendung
Sensordaten für ein bestimmtes Element der Infrastruktur auslesen soll und nicht für einzelne
Geräte.

Da diese Anwendung eine effiziente Abfrage nach Infrastrukturelement
ermöglichen soll, ist es viel sinnvoller, die Daten nach Infrastrukturelementen
zu partitionieren und nicht nach ID. Auf diese Weise können alle Geräte
für ein bestimmtes Infrastrukturelement als eine Gruppe abgefragt werden.

Für die selten vorkommenden Abfragen nach Gerät bieten sich zwei Verfahren an:

1. Einen globalen Index erstellen und abfragen. Dieser Ansatz ist effektiver, wenn
    Abfragen für einzelne Geräte selten vorkommen und nicht wiederholt werden.
2. Einen globalen Index mit Zuordnung zwischen Gerät und Infrastruktur erstellen
    und Partitionsabfragen in der Infrastrukturpartition ausführen. Dies ist bei
    wiederholten Abfragen für bestimmte Geräte  sinnvoll, da die Zuordnung im Cache
    gespeichert werden kann (wir gehen davon aus, dass dies für unsere Anwendung
    zutrifft).

Werfen wir einen Blick auf die Funktionsweise. Dabei geht es um vier Dinge:

1. Langfristige Messwerte für ein Infrastrukturelement
1. Heutige Messwerte für ein Infrastrukturelement
1. Langfristige Messwerte für ein bestimmtes Gerät
1. Heutige Messwerte für ein bestimmtes Gerät

### Datenbank erstellen
{: #creating-the-database}

Wir verwenden eine Datenbank mit dem Namen `readings` und ein Konto mit dem Namen
`acme`. Um diese Datenbank als partitionierte Datenbank zu erstellen, übergeben Sie
`true` im Argument `partitioned` an die Datenbankerstellungsanforderung:

```
curl -XPUT 'https://acme.cloudant.com/readings?partitioned=true'
```

### Dokumentstruktur
{: #document-struture}

Definieren Sie zuerst ein einfaches Dokumentformat, das verwendet werden soll:

```json
{
    "deviceID": "device-123456",
    "infrastructureID": "bridge-9876",
    "ts": "20181211T11:13:24.123456Z",
    "reading": {
        "temperature": {"value": 12, "unit": "c"}
    }
}
```

Die Dokument-ID für dieses Dokument, das das auf einem Infrastrukturelement
basierende Partitionierungsschema verwendet, kann die Infrastruktur-ID als Partitionierungsschlüssel
enthalten sowie die Geräte-ID und die Zeitmarke als Dokumentschlüssel, wie nachfolgend gezeigt:

```
bridge-9876:device-123456-20181211T11:13:24.123456Z
```

### Indizes erstellen
{: #creating-indexes}

Für die oben erläuterten Abfragen sind zwei Indizes erforderlich: 

1. Ein globaler Index mit der Zuordnung von Geräte-ID zu Infrastruktur-ID
2. Ein partitionierter Index mit der Zuordnung von Geräte-IDs zu Messwerten

#### Globalen Ansichtsindex erstellen
{: #creating-a-global-view-index}

Ein Ansichtsindex ist die effizienteste Methode, um eine einfache Geräte-ID einer
Infrastruktur-ID zuzuordnen. Laden Sie zum Definieren der Zuordnung ein Entwurfsdokument
mit der Einstellung `false`  für `options.partitioned`
hoch, da es sich um einen globalen Index handelt. In einer reinen Zuordnungsfunktion
(`map`) ist dagegen größere Zurückhaltung in Bezug auf das Vorhandensein
von Feldern angebracht. Sie kann wie folgt lauten:

```json
{
    "_id": "_design/infrastructure-mapping",
    "options": {"partitioned": false},
    "views": {
        "by-device": {
            "map": "function(doc) { emit(doc.deviceID, doc.infrastructureID) }"
        }
    }
}
```

Wenn das oben angegebene Dokument in `./view.json` vorhanden ist, wird es
mit dem folgenden Befehl in die Datenbank hochgeladen: 

```
curl -XPOST https://acme.cloudant.com/readings -d @view.json
```

#### Partitionierten {{site.data.keyword.cloudant_short_notm}}-Abfrageindex erstellen
{: #creating-a-paritioned-ibm-cloudant-query-index}

Um die Messwerte für ein bestimmtes Gerät aus einer Partition zurückzugeben, kann ein
{{site.data.keyword.cloudant_short_notm}}-Abfrageindex verwendet werden. In diesem Fall übergeben wir mit `POST` eine Indexdefinition
an `_index`, die das Feld `partitioned` mit der Einstellung `true` enthält. 

Für Abfrageindexdefinitionen wird das Feld `partitioned` nicht in ein Objekt `options`
verschachtelt.
{: note}

Für unsere Abfragen benötigen wir zwei nach den folgenden Elementen partitionierte Indizes:

1. Nach Zeitmarke
2. Nach Geräte-ID und Zeitmarke

Die Definition der Partitionierung nach Zeitmarke lautet wie folgt:

```json
{
   "index": {
      "fields": [
         "ts"
      ]
   },
   "name": "timestamped-readings",
   "type": "json",
   "partitioned:" true
}
```

Wenn das oben angegebene Dokument `./query-index1.json` verwendet wird, laden Sie den
Index mit dem folgenden Befehl in die Datenbank hoch: 

```
curl -XPOST https://acme.cloudant.com/readings/_index -d @query-index1.json
```

Die Definition der Partitionierung nach Geräte-ID und Zeitmarke lautet wie folgt:

```json
{
   "index": {
      "fields": [
         "deviceID",
         "ts"
      ]
   },
   "name": "deviceID-readings",
   "type": "json",
   "partitioned:" true
}
```

Wenn das oben angegebene Dokument `./query-index2.json` verwendet wird, laden Sie den
Index mit dem folgenden Befehl in die Datenbank hoch: 

```
curl -XPOST https://acme.cloudant.com/readings/_index -d @query-index2.json
```

### Abfragen erstellen
{: #making-queries}

Insgesamt vier Abfragen sollen erstellt werden:

1. Langfristige Messwerte für ein Infrastrukturelement
1. Heutige Messwerte für ein Infrastrukturelement
1. Langfristige Messwerte für ein bestimmtes Gerät
1. Heutige Messwerte für ein bestimmtes Gerät

#### Alle Messwerte für ein Infrastrukturelement finden
{: #finding-all-readings-for-a-piece-of-infrastructure}

Da wir mit infrastrukturbasierten Partitionen arbeiten, kann `_all_docs` für eine
Partition verwendet werden. Mit dem folgenden Befehl können beispielsweise alle Messwerte für das Infrastrukturelement `bridge-1234`
abgefragt werden:

```
curl -XGET \
    'https://acme.cloudant.com/readings/_partition/bridge-1234/_all_docs?include_docs=true'
```

#### Kürzlich erstellte Messwerte für ein Infrastrukturelement finden
{: #finding-recent-readings-for-a piece-of-infrastructure}

In dieser Abfrage muss der partitionierte Index `timestamped-readings` verwendet
werden. Mit der folgenden Abfrage an die Partition können die Messwerte
für heute abgerufen werden:

_query.json, wenn heute der 13. Dezember 2018 ist:_

```json
{
    "selector": {
        "ts": { "$gte": "20181213"}
    }
}
```

Die Partition wird in den HTTP-Pfad eingebettet, wenn die Abfrage an {{site.data.keyword.cloudant_short_notm}} abgesetzt wird:

```
curl -XPOST \
    'https://acme.cloudant.com/readings/_partition/bridge-1234/_find' \
    -d @query.json
```

#### Infrastruktur-ID für ein Gerät finden
{: #finding-the-infrastructure-id-for-a-device}

Die beiden folgenden Abfragen müssen noch ausgeführt werden:

1. Langfristige Messwerte für ein bestimmtes Gerät
2. Heutige Messwerte für ein bestimmtes Gerät

Für diese beiden Abfragen müssen wir die Partition für die Geräte mithilfe des
globalen Index `by-device` finden. Anschließend können wir die Messwerte
aus der Partition abfragen. Zum Abfragen der Messwerte für einzelne Geräte wurde ein
globaler Index verwendet. Da die Zuordnung von Geräte-ID zu Infrastruktur-ID besonders
gut zum Zwischenspeichern geeignet ist (sie bleibt stets unverändert), erlaubt dieser
Ansatz die Verwendung der kostengünstigeren und effizienteren
Partitionsabfrage für die meisten Abfragen.

Die Verwendung eines globalen Index zum direkten Abfragen von Gerätemesswerten ist zwar besonders
effizient, wenn die Gerät/Infrastruktur-Zuordnung zwischengespeichert wird, sie eignet sich jedoch
nicht unbedingt für eine bestimmte Anwendung.

Um die relevante Partition für ein Gerät zu finden, fragen wird die Ansicht `by-device`
ab und übergeben dabei die Geräte-ID als Schlüssel:

```
curl -XGET \
  'https://acme.cloudant.com/readings/_design/infrastructure-mapping/_view/by-device?keys=["device-123456"]&limit=1'
```

Diese Abfrage gibt Folgendes zurück:

```json
{"total_rows":5,"offset":0,"rows":[
{
    "id":"bridge-9876:device-123456-20181211T11:13:24.123456Z",
    "key":"device-123456",
    "value":"bridge-9876"
}
]}
```

Der Partitionsschlüssel befindet sich im Feld `value` der enthaltenen Zeile:
`bridge-9876`.

#### Alle Ergebnisse für ein Gerät abfragen
{: #querying-for-all-results-for-a-device}

Um die Ergebnisse für ein Gerät abzurufen, setzen wir eine Partitionsabfrage für das Gerät
in der Partition `bridge-9876` ab. Dabei wird ein {{site.data.keyword.cloudant_short_notm}}-Standardabfrageselektor
verwendet wie beim Absetzen einer globalen Abfrage.

_query.json:_

```json
{
   "selector": {
      "deviceID": {
         "$eq": "device-123456"
      }
   }
}
```

Die Partition wird in den HTTP-Pfad eingebettet, wenn die Abfrage an {{site.data.keyword.cloudant_short_notm}} abgesetzt wird:

```
curl -XPOST \
    'https://acme.cloudant.com/readings/_partition/bridge-1234/_find' \
    -d @query.json
```

#### Kürzliche Ergebnisse für ein Gerät abfragen
{: #querying-for-recent-results-for-a-device}

Um die Ergebnisse für ein Gerät abzurufen, setzen wir eine Partitionsabfrage für das Gerät
in der Partition `bridge-9876` ab. Der Selektor ist zwar etwas komplexer, stimmt
aber dennoch mit einer funktional entsprechenden globalen Abfrage überein.

_query.json, wenn heute der 13. Dezember 2018 ist:_

```json
{
   "selector": {
      "deviceID": {
         "$eq": "device-123456"
      },
      "ts": {
         "$gte": "20181213"
      }
   }
}
```

Die Partition wird in den HTTP-Pfad eingebettet, wenn die Abfrage an {{site.data.keyword.cloudant_short_notm}} abgesetzt wird:

```
curl -XPOST \
    'https://acme.cloudant.com/readings/_partition/bridge-1234/_find' \
    -d @query.json
```
