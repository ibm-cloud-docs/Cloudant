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

# Zugehörige Dokumente in {{site.data.keyword.cloudant_short_notm}} gruppieren

Herkömmlicherweise werden E-Commerce-Systeme mit relationalen Datenbanken erstellt.
Diese Datenbanken verwenden üblicherweise eine Reihe von verknüpften Tabellen zur Aufzeichnung von Umsätzen, Kundendetails, gekauften Produkten und Informationen zur Zustellungsverfolgung.
Relationale Datenbanken bieten hohe Konsistenz, d. h. Anwendungsentwickler können für ihre Anwendungen die Vorteile der Datenbank nutzen,
darunter die Verwendung von Joins zwischen Sammlungen, Aufzählungen zum Aufzeichnen des Status eines Objekts sowie Datenbanktransaktionen, die atomare Operationen gewährleisten.

{{site.data.keyword.cloudantfull}} gibt der Verfügbarkeit Priorität gegenüber der Konsistenz.
Eine hochverfügbare, fehlertolerante, verteilte Datenbank wird sukzessive konsistent.
Dies hat den Vorteil, dass der Einkaufsservice des Kunden immer verfügbar und skalierbar genug ist,
um mehrere parallel stattfindende Einkaufsvorgänge von Kunden abzuwickeln.
Das heißt, Ihre Anwendung kann von den Stärken von {{site.data.keyword.cloudant_short_notm}} profitieren und das Tool nicht nur als relationale Datenbank nutzen.

In diesem Abschnitt werden einige Faktoren besprochen, die bei der Erstellung eines
E-Commerce-Systems eine Rolle spielen, das die Stärken von {{site.data.keyword.cloudant_short_notm}} für sich nutzt,
mit Konzepten, die für viele andere Fachgebiete gelten:

-   Verwendung mehrerer Dokumente zum Darstellen des Status eines Einkaufs,
    statt regelmäßige Aktualisierung eines einzelnen Dokuments.
-   Speichern von Kopien von zugehörigen Objekten in einer bestimmten Reihenfolge, statt sie zu einer anderen Sammlung hinzuzufügen.
-   Erstellen von Ansichten zum Sortieren von Dokumenten nach `order_id`, um den aktuellen Status eines Einkaufs wiederzugeben.

Sie können beispielsweise ein Dokument `purchase` erstellen, das Details wie die sortierten Artikel, Kundeninformationen, Kosten und Zustellinformationen enthält.

_Beispieldokument für einen Einkauf:_

```json
{
    "_id": "023f7a21dbe8a4177a2816e4ad1ea27e",
    "type": "purchase",
    "order_id": "320afa89017426b994162ab004ce3383",
    "basket": [
        {
            "product_id": "A56",
            "title": "Adele - 25",
            "category": "Audio CD",
            "price": 8.33,
            "tax": 0.2,
            "quantity": 2
        },
        {
            "product_id": "B32",
            "title": "The Lady In The Van - Alan Bennett",
            "category": "Paperback book",
            "price": 3.49,
            "tax": 0,
            "quantity": 2
        }
    ],
    "account_id": "985522332",
    "delivery": {
        "option": "Next Day",
        "price": 2.99,
        "address": {
            "street": "17 Front Street",
            "town": "Middlemarch",
            "postcode": "W1A 1AA"
        }
    },
    "pretax" : 20.15,
    "tax" : 3.32,
    "total": 26.46
}
```
{:codeblock}

Dieses Dokument liefert genug Daten zu einem Einkaufsdatensatz, um eine Zusammenfassung einer Bestellung auf einer Webseite anzugeben oder in einer E-Mail,
ohne zusätzliche Datensätze abrufen zu müssen.
Insbesondere die folgenden Details sind wichtig:

-   Der Einkaufskorb enthält Referenz-IDs (`product_id`) auf eine Produktdatenbank, die an einer anderen Stelle gespeichert ist.
-   Der Einkaufskorb dupliziert manche der Produktdaten in diesem Datensatz,
    um den Status der eingekauften Artikel an der Datenkasse aufzuzeichnen.
-   Das Dokument enthält keine Felder, die den Status der Bestellung markieren.
    Zusätzliche Dokumente würden später hinzugefügt werden, um Zahlungen und Lieferungen nachzuverfolgen.
-   Die Datenbank generiert automatisch beim Einfügen des Dokuments in die Datenbank eine Dokumenten-ID (`_id`).
-   Eine eindeutige ID (`order_id`) wird mit jedem Einkaufsdatensatz bereitgestellt, auf den später Bezug genommen werden kann. 
 
Wenn der Kunde eine Bestellung platziert, wird typischerweise
zu dem Zeitpunkt, als er auf der Website in die Check-out-Phase eintritt,
ein Bestellungsdatensatz ähnlich dem vorherigen Beispiel erzeugt. 

## Eindeutige IDs generieren

In einer relationalen Datenbank werden die sequenziellen, autoinkrementellen Zahlen oft verwendet,
aber in verteilten Datenbanken, in denen Daten über ein Cluster von Servern verteilt sind, werden längere
eindeutige IDs verwendet, um sicherzustellen, dass Dokumente mit ihrer eigenen eindeutigen ID gespeichert werden.

Um eindeutige IDs für die Verwendung in Ihrer Anwendung zu erstellen, z. B. eine
`order_id`, rufen Sie den Endpunkt [`GET _uuids`](../api/advanced.html#-get-_uuids-)
in der {{site.data.keyword.cloudant_short_notm}}-API auf.
Die Datenbank generiert eine ID für Sie.
Derselbe Endpunkt kann zum Generieren mehrerer IDs verwendet werden, indem ein Parameter `count` hinzugefügt wird, z. B. `/_uuids?count=10`.

## Aufzeichnen von Zahlungen

Wenn der Kunde erfolgreich seine Artikel kauft,
werden zusätzliche Datensätze zur Datenbank hinzugefügt, um die Bestellung aufzuzeichnen.

_Beispiel eines Zahlungsdatensatzes:_

```json
{
    "_id": "bf70c30ea5d8c3cd088fef98ad678e9e",
    "type": "payment",
    "account_id": "985522332",
    "order_id": "320afa89017426b994162ab004ce3383",
    "value": 6.46,
    "method": "credit card",
    "payment_reference": "AB9977G244FF2F667"
}
...
{
    "_id": "12c0ea6cd3d2c6e3b1d34442aea6a2d9",
    "type": "payment",
    "account_id": "985522332",
    "order_id": "320afa89017426b994162ab004ce3383",
    "value": 20.00,
    "method": "voucher",
    "payment_reference": "Q88775662377224"
}
```
{:codeblock}

Im vorherigen Beispiel hat der Kunde mit einer Kreditkarte bezahlt und einen Gutschein eingelöst.
Die Summe der beiden Zahlungen ergibt den Betrag der Bestellung.
Jede Zahlung wurde als separates Dokument in {{site.data.keyword.cloudant_short_notm}} geschrieben.

Sie könnten den Status einer Bestellung einsehen, indem Sie eine Ansicht mit allem, das Sie über eine `order_id` wissen, erstellen.
Die Ansicht würde ein Hauptbuch mit den folgenden Informationen aktivieren: 

-   Gesamteinkaufssummen als positive Zahlen.
-   Zahlungen gegen das Konto als negative Zahlen.

Eine 'map'-Funktion könnte verwendet werden, um die erforderlichen Werte zu ermitteln.

_Beispiel einer 'map'-Funktion zum Suchen nach Gesamteinkaufs- und Zahlungswerten:_ 

```javascript
function (doc) {
    if (doc.type === 'purchase') {
        emit(doc.order_id, doc.total);
    } else {
        if (doc.type === 'payment') {
            emit(doc.order_id, -doc.value);
        }
    }
}
```
{:codeblock}

Mithilfe der integrierten ['reduce'-Funktion `_sum`](../api/creating_views.html#built-in-reduce-functions)
können Sie eine Ausgabe in Form eines Hauptbuchs von Zahlungsereignissen erzeugen.

_Beispiel für die Verwendung der integrierten 'reduce'-Funktion `_sum`, abgefragt mit `?reduce=false`:_

```json
{
    "total_rows":3,"offset":0,"rows":[
        {
            "id":"320afa89017426b994162ab004ce3383",
            "key":"985522332",
            "value":26.46
        },
        {
            "id":"320afa89017426b994162ab004ce3383",
            "key":"985522332",
            "value":-20
        },
        {
            "id":"320afa89017426b994162ab004ce3383",
            "key":"985522332",
            "value":-6.46
        }
    ]
}
```
{:codeblock}

Alternativ könnten Sie Gesamtwerte nach `order_id` erzeugen.

_Beispiel von nach `order_id` gruppierten Gesamtsummen, mit `?group_level=1`:_

```json
{
    "rows":[
        {
            "key":"320afa89017426b994162ab004ce3383",
            "value":0
        }
    ]
}
```
{:codeblock}

Da die Ansicht im vorherigen Beispiel für den Bestellwert '0' zurückgibt, zeigt das Ergebnis an, dass die Bestellung vollständig bezahlt wurde.
Der positive Wert des Einkaufsauftrags wird durch die negativen Zahlungsbeträge ausgeglichen.
Das Aufzeichnen von Ereignissen in Form von separaten Dokumenten (eins für die Bestellung und eins für jede Zahlung)
hat sich in {{site.data.keyword.cloudant_short_notm}} bewährt, da es Konflikte vermeidet, die entstehen können,
wenn mehrere Prozesse dasselbe Dokument gleichzeitig ändern.

## Zusätzliche Dokumente hinzufügen

Sie könnten weitere separate Dokumente zur Datenbank hinzufügen, um die folgenden Statusänderungen aufzuzeichnen, während die Bestellung bereitgestellt und versendet wird:

-   Versandbenachrichtigungen.
-   Empfangsbestätigungen.
-   Rückerstattungen.

Wenn die Daten eingehen, schreibt {{site.data.keyword.cloudant_short_notm}} separate in
jedes Dokument.
Deshalb ist es nicht erforderlich, das zentrale Einkaufsdokument zu ändern.

## Vorteile des Speicherns von Bestellungen mit {{site.data.keyword.cloudant_short_notm}}

Das Speichern von Bestellinformationen mit {{site.data.keyword.cloudant_short_notm}} macht ein Bestellsystem
hoch verfügbar und skalierbar, d. h. Sie können große Mengen von Daten und viele parallele Zugriffe verarbeiten.
Durch das Modellieren der Daten in separate Dokumente, die nur einmal geschrieben werden,
wird sichergestellt, dass zwischen Dokumenten nie Konflikte auftreten, z. B. bei einem gleichzeitigen
Zugriff auf dasselbe Dokument durch separate Prozesse.

Außerdem können Dokumente Kopien von Daten enthalten, die in anderen Sammlungen vorhanden sind,
um verbundene Daten mit einem Fremdschlüssel darzustellen.
Beispielsweise bei der Aufzeichnung des Status eines Einkaufskorbs zum Zeitpunkt des Einkaufs.
Auf diese Weise kann der Status einer Bestellung durch einen einzelnen Aufruf der {{site.data.keyword.cloudant_short_notm}}-Ansicht abgerufen werden, die Dokumente mit Bezug auf `order_id` gruppiert.
