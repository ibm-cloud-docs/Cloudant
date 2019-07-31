---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: standard plan, lite plan, dedicated hardware plan, event type, provisioned throughput capacity, consumption, capacity, monitor usage, data usage, size limits, locations, tenancy, authentication methods, high availability, disaster recovery, backup, support

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

# Pläne & Bereitstellung
{: #ibm-cloud-public}

{{site.data.keyword.cloudantfull}} Public ist das {{site.data.keyword.cloudant_short_notm}}-Angebot mit dem
größten Funktionsumfang, das bevorzugt aktualisiert und mit neuen Funktionen ausgestattet wird. Die Preisstruktur basiert auf der
bereitgestellten Durchsatzkapazität und dem belegten Datenspeicher und eignet sich daher für jede erforderliche
Auslastung. 
{: shortdesc}

Der kostenfreie [Lite-Plan](#lite-plan) enthält eine feste Durchsatzkapazität und Datenmenge für Entwicklungs- und Evaluierungszwecke. Außerdem wird ein gebührenpflichtiger [Standard-Plan](#standard-plan) angeboten, der eine konfigurierbare Durchsatzkapazität sowie eine skalierbare Preisstruktur für den Datenspeicher bietet, die an Ihre wechselnden Anwendungserfordernisse angepasst werden können.  Darüber hinaus wird ein optionaler [Plan für dedizierte Hardware](#dedicated-hardware-plan)
mit einer zusätzlichen monatlichen Gebühr angeboten, um einzelne oder mehrere Ihrer Standard-Plan-Instanzen in einer
Umgebung mit dedizierter Hardware auszuführen. Die Umgebung mit dedizierter Hardware steht Ihnen zur ausschließlichen Verwendung zur Verfügung. Wenn eine Instanz eines Plans für dedizierte Hardware an einem Standort in den USA bereitgestellt wird, können Sie optional eine mit [HIPAA ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){: new_window} konforme Konfiguration auswählen.

## Pläne
{: #plans}

Sie können auswählen, welcher Plan genutzt werden soll, wenn Sie
[Ihre {{site.data.keyword.cloudant_short_notm}}-Serviceinstanz bereitstellen](#provisioning-a-cloudant-nosql-db-instance-on-ibm-cloud).
Standardmäßig ist der [Lite-Plan](#lite-plan) ausgewählt.

![{{site.data.keyword.cloudant_short_notm}} - Auswahl des Serviceinstanzplans](../images/lite_pricing_plan.png)

### Lite-Plan
{: #lite-plan}

Der Lite-Plan ist kostenlos und wurde zu Entwicklungs- und Evaluierungszwecken entworfen. Er umfasst die vollständige Funktionalität von {{site.data.keyword.cloudant_short_notm}}, die Lite-Plan-Instanzen verfügen jedoch nur über eine begrenzte Menge an bereitgestellter Durchsatzkapazität und einen begrenzten Datenspeicher. Die bereitgestellte Durchsatzkapazität ist auf 20 Lesevorgänge pro Sekunde, 10 Schreibvorgänge pro Sekunde, 5 globale Abfragen pro Sekunde und eine Datenspeicherkapazität von maximal 1 GB beschränkt. 

Die Speicherbelegung wird täglich geprüft. Wenn Sie Ihren Speichergrenzwert von 1 GB überschreiten, erhalten Anforderungen an die {{site.data.keyword.cloudant_short_notm}}-Instanz den Statuscode '402' mit der Fehlermeldung, dass das Datennutzungskontingent für das Konto
überschritten wurde. Außerdem werden Sie in dieser Meldung darüber informiert, dass ein Upgrade auf einen gebührenpflichtigen Plan erforderlich ist.
Es wird außerdem ein entsprechendes Banner im {{site.data.keyword.cloudant_short_notm}}-Dashboard angezeigt. Sie können weiterhin Daten lesen und löschen. Wenn Sie neue Daten schreiben möchten, haben Sie jedoch zwei Möglichkeiten. Als Erstes können Sie ein Upgrade auf einen gebührenpflichtigen [Standard-Plan](#standard-plan) durchführen, durch das die Begrenzung für Schreiboperationen sofort aufgehoben wird. Alternativ hierzu können Sie auch Daten löschen, sodass der insgesamt belegte Speicherplatz unter das Limit von 1 GB fällt. Anschließend müssen Sie die Ausführung der nächsten täglichen Speicherprüfung für Ihre Instanz abwarten, damit Sie wieder Schreiboperationen ausführen können. 

Wenn Sie mehr als 1 GB an Daten speichern möchten oder wenn Sie die bereitgestellte Durchsatzkapazität skalieren möchten, dann müssen Sie Ihr System auf den [Standard-Plan](#standard-plan) umstellen.

Pro {{site.data.keyword.cloud_notm}}-Konto können Sie eine {{site.data.keyword.cloudant_short_notm}}-Lite-Plan-Instanz verwenden. Wenn Sie bereits über eine Lite-Plan-Instanz verfügen, dann wird für jeden Versuch, eine weitere Lite-Plan-Instanz zu erstellen oder eine Standard-Plan-Instanz in einen Lite-Plan umzuwandeln, eine Nachricht ähnlich der folgenden ausgegeben: "Es ist nur eine Instanz eines Lite-Plans pro Service zulässig. Zur Erstellung einer neuen Instanz müssen Sie entweder
Ihre vorhandene Lite-Plan-Instanz löschen oder einen gebührenpflichtigen Plan auswählen." 
{: note}

### Standard-Plan
{: #standard-plan}

Der {{site.data.keyword.cloudant_short_notm}}-Standard-Plan steht für alle gebührenpflichtigen {{site.data.keyword.cloud}}-Konten entweder als nutzungsabhängige Lösung oder als Abonnement zur Verfügung und kann zur Anpassung an die Anforderungen Ihrer Anwendung skaliert werden. Die Preisgestaltung des Standard-Plans basiert auf zwei Faktoren, und zwar auf der bereitgestellten Durchsatzkapazität, die zugeordnet wird, und auf dem Datenvolumen, das in der Instanz gespeichert werden kann. 

Die Preisstruktur wird stündlich bewertet, wobei eine anfängliche Durchsatzkapazität von 100 Lesevorgängen/Sek., 50 Schreibvorgängen/Sek. und 5 globalen Abfragen/Sek. zu einem Anfangspreis von 0,105 US-Dollar/Stunde berechnet wird. Sie können die bereitgestellte Durchsatzkapazität in Schritten von 100 Lesevorgängen/Sek., 50 Schreibvorgängen/Sek. und 5 globalen Abfragen/Sek im {{site.data.keyword.cloudant_short_notm}}-Dashboard erhöhen bzw. reduzieren. Die Kosten werden für die bereitgestellte Durchsatzkapazität berechnet, die zugeordnet wurde, und nicht auf Basis des gemessenen Anforderungsvolumens. Der Standard-Plan umfasst 20 GB Datenspeicher. Wenn Sie mehr als 20 GB speichern, wird Ihnen eine definierte Summe pro GB und pro Stunde berechnet. 

Beispiele zur Kostenschätzung finden Sie in den Informationen zur Preisstruktur bei unterschiedlichen Kapazitäten und in unterschiedlichen Währungen im {{site.data.keyword.cloud_notm}}-Preisrechner sowie in den Informationen zur [Preisstruktur](/docs/services/Cloudant?topic=cloudant-pricing#pricing){: new_window}.

### Plan für dedizierte Hardware
{: #dedicated-hardware-plan}

Eine Instanz für einen {{site.data.keyword.cloudant_short_notm}}-Plan für dedizierte Hardware stellt eine {{site.data.keyword.cloudant_short_notm}}-Bare-Metal-Umgebung dar, die zur alleinigen Nutzung durch Ihre {{site.data.keyword.cloudant_short_notm}}-Standard-Plan-Instanzen zur Verfügung gestellt wird. Eine Umgebung mit einem {{site.data.keyword.cloudant_short_notm}}-Plan für dedizierte Hardware kann in beliebigen [{{site.data.keyword.IBM}} Global Data Centers ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/cloud/data-centers/){:new_window} bereitgestellt werden. Dieser Plan ist für
die HIPAA-Konformität erforderlich und muss bei der Bereitstellung ausgewählt werden. Benutzer einer Umgebung mit einem {{site.data.keyword.cloudant_short_notm}}-Plan für dedizierte Hardware können das IP-Whitelisting sowie vom Kunden verwaltete BYOK-Verschlüsselungsschlüssel mit {{site.data.keyword.IBM_notm}} Key Protect bereitstellen. Außerdem enthalten alle nach dem 1. Januar 2019 bereitgestellten Umgebungen für dedizierte Hardware außerhalb EU-verwalteter Umgebungen interne Endpunkte für alle in ihnen bereitgestellten Instanzen des Standard-Plans. Durch die Verwendung interner Endpunkte können Kunden die Verbindung zu einer {{site.data.keyword.cloudant_short_notm}}-Instanz über das interne {{site.data.keyword.cloud}}-Netz herstellen, um Upstream-Anwendungsdatenverkehr im öffentlichen Netz und Bandbreitengebühren zu vermeiden. Weitere Informationen zum Aktivieren von Serviceendpunkten für Ihr {{site.data.keyword.cloud}}-Konto finden Sie in der [Dokumentation für Serviceendpunkte![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://cloud.ibm.com/docs/services/service-endpoint/getting-started.html#about){:new_window}.

Sie können einzelne oder auch mehrere Standard-Plan-Instanzen bereitstellen. Die Umgebung mit dedizierter Hardware wird bedarfsorientiert auf Basis der Kapazitäten und Daten angepasst, die von den Standard-Plan-Instanzen belegt werden. Für eine Instanz eines {{site.data.keyword.cloudant_short_notm}}-Plans für dedizierte Hardware wird ein Festpreis zu den Nutzungspreisen für die auf der dedizierten Hardware bereitgestellten Standard-Plan-Instanzen addiert. Die Abrechnung wird in täglichen Zeitabständen anteilsmäßig bewertet, wobei eine Mindestlaufzeit von einem Monat für die Umgebung in Rechnung gestellt wird. Die Bereitstellung eines {{site.data.keyword.cloudant_short_notm}}-Plans für dedizierte Hardware verläuft asynchron und kann 5-7 Werktage in Anspruch nehmen. Zur Erstellung einer Instanz für einen {{site.data.keyword.cloudant_short_notm}}-Plan für dedizierte Hardware und zur Bereitstellung einer Standard-Plan-Instanz für diesen Plan müssen Sie die Anweisungen im Lernprogramm zur [Erstellung und Nutzung einer Instanz für einen {{site.data.keyword.cloudant_short_notm}}-Plan für dedizierte Hardware unter {{site.data.keyword.cloud_notm}}](/docs/services/Cloudant?topic=cloudant-creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud#creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud) befolgen. 

Der Plan für dedizierte Hardware steht für dedizierte {{site.data.keyword.cloud_notm}}-Kunden nicht zur Verfügung. Der Plan für dedizierte Hardware steht nur für {{site.data.keyword.cloud_notm}} Public-Kunden zur Verfügung.
{: important}

## Ereignistypen
{: #event-types}

Die Bereitstellung des Durchsatzes wird in Form eines dieser Arten von Ereignissen ermittelt und gemessen:

1.	_Lesevorgänge_ (reads),
    (früher als Suchvorgänge bezeichnet), zu denen Folgendes gehört:
    1. Ein Lesevorgang in einem bestimmten Dokument,
    basierend auf der Kennung (`_id`) des Dokuments.
    2. Eine _partitionierte_ Abfrage, d. h. eine Abfrage
        für einen {{site.data.keyword.cloudant_short_notm}}-Abfrageendpunkt
        im Namensbereich `_partition` innerhalb des Anforderungspfads,
        einschließlich der folgenden Typen:
        -	Primärindex ([`_all_docs`](/docs/services/Cloudant?topic=cloudant-databases#get-documents))
        -	MapReduce-Ansicht ([`_view`](/docs/services/Cloudant?topic=cloudant-using-views#using-views))
        -	Suchindex ([`_search`](/docs/services/Cloudant?topic=cloudant-search#queries))
        -	{{site.data.keyword.cloudant_short_notm}} Query ([`_find`](/docs/services/Cloudant?topic=cloudant-query#finding-documents-by-using-an-index))
    
Die Anzahl der von einer Partitionsabfrageanforderung genutzten Lesevorgänge variiert
        entsprechend den zurückgegebenen Ergebnissen.
2.	_Schreibvorgänge_ (writes), zu denen das
    Erstellen,
    Ändern oder
    Löschen einzelner Dokumente gehört.
3.	_Globale Abfragen_ (global queries) für globale Indizes (früher als Abfragen bezeichnet),
        d. h. Anfragen an einen {{site.data.keyword.cloudant_short_notm}}-Abfrageendpunkt
        **außerhalb** des Namensbereichs `_partition`,
    einschließlich der folgenden Typen:
	-	Primärindex ([`_all_docs`](/docs/services/Cloudant?topic=cloudant-databases#get-documents))
	-	MapReduce-Ansicht ([`_view`](/docs/services/Cloudant?topic=cloudant-using-views#using-views))
	-	Suchindex ([`_search`](/docs/services/Cloudant?topic=cloudant-search#queries))
	-	Geografisch-räumlicher Index ([`_geo`](/docs/services/Cloudant?topic=cloudant-cloudant-nosql-db-geospatial#querying-a-cloudant-nosql-db-geo-index))
	-	{{site.data.keyword.cloudant_short_notm}} Query ([`_find`](/docs/services/Cloudant?topic=cloudant-query#finding-documents-by-using-an-index))


## Bereitgestellte Durchsatzkapazität
{: #provisioned-throughput-capacity}

Die Durchsatzbereitstellung wird in Form von Ereignissen der folgenden Operationstypen
identifiziert und gemessen: _Read_ (Lesevorgang), _Write_ (Schreibvorgang), _Global Query_ (globale Abfrage).

Die Messung des Durchsatzes ist eine einfache Zählung der Anzahl von Ereignissen jedes Typs,
pro Sekunde, wobei die Sekunde ein _gleitendes_ Fenster ist.
Wenn Ihr Konto die Anzahl von Durchsatzereignissen überschreitet, die für den Plan bereitgestellt werden,
werden Anforderungen so lange zurückgewiesen, bis die Anzahl von Ereignissen im gleitenden Fenster
die festgelegte Anzahl nicht mehr überschreitet.
Vielleicht hilft es Ihnen, sich vorzustellen, dass das gleitende 1-Sekunden-Fenster ein fortlaufender Zeitraum von 1.000 Millisekunden ist.

Der Standard-Plan wird beispielsweise für 200 Lesevorgänge pro Sekunde bereitgestellt. In Ihrem Konto können während eines fortlaufenden Zeitraums von 1.000 Millisekunden (1 Sekunde) maximal 200 Lesevorgänge ausgeführt werden. Nachfolgende Leseanforderungen während des gleitenden 1.000-Millisekunden-Zeitraums
werden abgelehnt, bis die Anzahl der Leseereignisse in diesem Zeitraum wieder auf weniger als 200 sinkt.

Wenn eine Anforderung abgelehnt wird, weil die Anzahl von Ereignissen überschritten ist,
empfangen Anwendungen eine Antwort [`429` Too Many Requests](/docs/services/Cloudant?topic=cloudant-http#http-status-codes).

Aktuelle Versionen der unterstützten Clientbibliotheken (für [Java](/docs/services/Cloudant?topic=cloudant-supported-client-libraries#java-supported),
[Node.js](/docs/services/Cloudant?topic=cloudant-supported-client-libraries#node-js-supported) und [Python](/docs/services/Cloudant?topic=cloudant-supported-client-libraries#python-supported)) unterstützen Sie bei der Verarbeitung einer `429`-Antwort. Beispiel: Die Java-Bibliothek gibt die Antwort [`TooManyRequestsException` ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://static.javadoc.io/com.cloudant/cloudant-client/2.5.1/com/cloudant/client/org/lightcouch/TooManyRequestsException.html){: new_window} aus.

Standardmäßig versuchen die unterstützten Clientbibliotheken nicht automatisch, eine Anforderung zu wiederholen, wenn eine `429`-Antwort empfangen wird.

Es ist sinnvoller, sicherzustellen, dass Ihre Anwendung `429`-Antworten korrekt verarbeitet.
Denn die Anzahl von erneuten Versuchen ist begrenzt. Ein regelmäßiges Überschreiten der Anzahl von Anforderungen ist ein starker Indikator, dass ein Wechsel zu einer anderen Plankonfiguration angebracht ist.

Wenn Sie eine vorhandene Anwendung portieren, kann die Antwort `429` möglicherweise nicht verarbeitet werden. Als Teil der Migrationsverifizierung prüfen Sie, dass Ihre Anwendung `429`-Antworten korrekt verarbeitet.
{: note}

Zusammenfassend lässt sich sagen, dass Sie sicherstellen müssen, dass Ihre Anwendung eine [`429`](/docs/services/Cloudant?topic=cloudant-http#http-status-codes)-Antwort korrekt verarbeiten kann.

### Nutzung von Leseoperationen durch partitionierte Abfragen
{: #consumption-of-lookup-operations-by-partitioned-queries}

Die Anzahl der von partitionierten Abfrageanforderungen genutzten Leseoperationen
variiert entsprechend den zurückgegebenen Ergebnissen. Die Nutzung basiert auf zwei Achsen:

1. Die Anzahl der gelesenen Zeilen aus dem Index, der an der Abfrage beteiligt ist
1. Die Anzahl der Dokumente aus der Datenbank, die gegebenenfalls während der
    Ausführung der Abfrage gelesen werden.
    
#### `_all_docs`, Anzeige- und Suchabfragen

Jeder aus dem Index gelesene Block mit 100 Zeilen belegt 1 Leseoperation. Jedes Dokument,
das beim Ausführen einer Abfrage aus der Datenbank gelesen wird, belegt zusätzlich eine Leseeinheit.

Die Anzahl der aus  dem Index gelesenen Zeilen entspricht der Anzahl der zurückgegebenen
Ergebnisse. Dokumente aus der Datenbank werden nur gelesen, wenn `include_docs=true` als
Abfragezeichenfolgeparameter in der Abfrageanforderung übergeben wird.

Die nachfolgende Tabelle enthält Beispiele für die Kosten.

| Anzahl der Ergebnisse | Dokumente einbeziehen | Gesamtlesenutzung | Nutzung für gelesene Zeilen | Nutzung für gelesene Dokumente |
|--------------|----------------|-------------|---------------------| --- |
| 199      | Nein     | **2** | 2 | 0 |
| 199      | Ja     | **201** | 2 | 199 |
| 301      | Nein     | **4** | 4 | 0 |
| 301      | Ja     | **305** | 4 | 301 |

Eine reduzierte Verwendung von `include_docs=true` ist der Schlüssel zum Reduzieren der Lesenutzung
für partitionierte `_all_docs`-, Ansichts- und Suchabfragen.

#### {{site.data.keyword.cloudant_short_notm}}-Abfrage

Bei {{site.data.keyword.cloudant_short_notm}}-Abfrageanforderungen bezieht sich die Anzahl der genutzten Leseoperationen
für Indexzeilen auf die gelesenen Zeilen aus dem zugrunde liegenden Index _vor_ dem Herausfiltern
von Teilen des Selektors, die der Index nicht erfüllen kann.
Anders ausgedrückt: Der Wert für gelesene Zeilen (d. h. für genutzte Leseeinheiten) kann größer
sein als die Anzahl der Ergebnisse, die Sie empfangen.

Darüber hinaus muss die {{site.data.keyword.cloudant_short_notm}}-Abfrage das Dokument für jede aus dem zugrunde liegenden
Index zurückgegebene Zeile lesen, um weitere Filtervorgänge auszuführen, die für
den an die Abfrage übergebenen Selektor erforderlich sind.

| Anzahl der Ergebnisse | Anzahl der vom Index zurückgegebenen Zeilen | Gesamtlesenutzung | Nutzung für gelesene Zeilen | Nutzung für gelesene Dokumente |
|--------------|----------------|-------------|---------------------| --- |
| 5      | 199     | **201** | 2 | 199 |
| 199      | 199     | **201** | 2 | 199 |
| 5      | 301     | **305** | 4 | 301 |
| 301      | 301     | **305** | 4 | 301 |

Die Verwendung geeigneter Indizes ist der Schlüssel zum Reduzieren der Lesenutzung für partitionierte
{{site.data.keyword.cloudant_short_notm}}-Abfragen.

### Kapazität anzeigen und ändern
{: #viewing-and-changing-capacity}

Sie finden die Details der Durchsatzkapazität in den für Ihr Konto verfügbaren Plänen.
Sie können die gewünschte Ebene der Bereitstellung auf der Registerkarte 'Konto' im Dashboard Ihres {{site.data.keyword.cloudant_short_notm}}-Kontos
auswählen.

![Dashboard des Kontos](../images/cloudant_capacity.png)

Um zu einer anderen Durchsatzkapazität zu wechseln, wählen Sie die gewünschte Bereitstellung aus und klicken Sie auf `Aktualisieren`. Sie werden aufgefordert, die Änderung zu bestätigen, und daran erinnert, dass es bis zu 24 Stunden dauern kann, bis sie wirksam wird.

![Dashboard des Kontos](../images/cloudant_capacity_change.png)

Der Umfang der Kapazitätserhöhung ist auf 10 Einheiten (1000 Lesevorgänge/Sek., 500 Schreibvorgänge/Sek. und 50 globale Abfragen/Sek.) pro Änderung begrenzt. Bei der Reduzierung bestehen keine Beschränkungen in Bezug auf die Anzahl der Einheiten. Alle Kapazitätsänderungen (Erhöhungen oder Reduzierungen) können nur einmal pro Stunde durchgeführt werden. Wenn Sie mehr Kapazität benötigen, als über das {{site.data.keyword.cloudant_short_notm}}-Dashboard bereitgestellt wird, dann wenden Sie sich an den [{{site.data.keyword.cloudant_short_notm}}-Support ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](mailto:support@cloudant.com){: new_window}.
{: note}

### Nutzung überwachen 
{: #monitoring-usage}

Informationen zu Ihrer Nutzung finden Sie im Teilfenster 'Aktuelle Operationen' der Registerkarte 'Überwachung' in Ihrem {{site.data.keyword.cloudant_short_notm}}-Dashboard. 

![Nutzung im Dashboard überwachen](../images/cloudant_usage.png)

Dort finden Sie Details wie Ihr aktueller [Durchsatz](#provisioned-throughput-capacity) und die Menge der [gespeicherten Daten](#disk-space-included).

Dank der Überwachung können Sie ermitteln, dass eine Änderung an der Bereitstellung in Ihrem Plan ratsam sein könnte.
Wenn Sie beispielsweise häufig die maximale Anzahl von Datenbanklesevorgängen erreichen,
können Sie die Bereitstellung im [Teilfenster 'Kapazität'](#viewing-and-changing-capacity) auf der Registerkarte 'Konto' des Dashboards ändern.

## Datennutzung
{: #data-usage}

### Inbegriffener Plattenspeicherplatz
{: #disk-space-included}

Dieser Wert ist die im Plan enthaltene Speicherkapazität.
Sie gilt für den Datenspeicher und den Indexspeicher.

### Plattenüberschreitung
{: #disk-overage}

Alle Standard- und Lite-Pläne umfassen Plattenspeicherplatz, der für JSON-Daten sowie die entsprechenden Anhänge und Indizes verwendet wird. Alle Standard- und Lite-Pläne werden auf die Plattenspeicherbelegung überwacht. Wenn Sie ein höheres Datenvolumen nutzen, als in Ihrem Plan zugeordnet wurde, dann gelten die in der folgenden Tabelle
aufgeführten Bedingungen:

<table>

<tr>
<th id="disk-overage-plan">Plan</th><th id="description">Beschreibung</th>
</tr>
<tr>
<th headers="standard-plan">Standard</td>
<td headers="description"><p>
<ul><li>Wenn das Konto mehr Speicherplatz als in Ihrer Plankonfiguration vorgesehen belegt, wird der Speicher als 'überlaufend' betrachtet. Bei einem Überlauf wird dem Konto der angegebene Preis für jedes zusätzliche GB in Rechnung gestellt.</li>
<li>Der zusätzliche Geldbetrag, den Sie für die Verwendung von mehr Plattenspeicherplatz bezahlen müssen, als im Plan vorgesehen ist, wird als Überschreitung bezeichnet. Die Überschreitung wird auf stündlicher Basis berechnet.</li></ul></p></td>
</tr>
<tr>
<th headers="lite-plan">Lite</td>
<td headers="description"><p>
<ul><li>Für Lite-Pläne ist die Plattenbelegung begrenzt. Nachdem Sie die Obergrenze erreicht haben, können keine weiteren Daten mehr geschrieben werden. Um weitere Daten in den Speicher schreiben zu können, müssen Sie entweder ein Upgrade auf den Standard-Plan durchführen oder Daten löschen und bis zur nächsten Überprüfung Ihres Kontos warten, damit es reaktiviert wird.</p>
</li></ul></td>
</tr>
</table>

Angenommen, dass in Ihrem Standard-Plan die Plattenbelegung für einen halben Tag (12 Stunden) auf 107 GB erhöht wird. Diese Änderung bedeutet, dass Ihre Instanz für 12 Stunden einen Überlauf von 87 GB zusätzlich zu den im Plan vorgesehenen 20 GB verursacht hat.
Ihnen würde eine Überschreitungsgebühr basierend auf 87 GB x 12 Stunden = 1044 GB-Stunden für den zusätzlichen Speicherplatz in Rechnung gestellt.

Die Überschreitung wird mithilfe der maximalen Anzahl von GB zusätzlich zu den im Plan zugeordneten GB während einer bestimmten Stunde im Rechnungsstellungszyklus berechnet.

### Beispiel für Plattenüberschreitung
{: #disk-overage-example}

Angenommen, Sie starten einen Monat mit 30 Tagen mit einer Serviceinstanz eines Standard-Plans, die 9 GB Speicher verwendet.
Dann erhöht sich Ihr Speicherbedarf um 21,5 GB für 15 Minuten während der Stunde 02:00 an Tag 3.
Die Instanz fällt zurück auf 9,5 GB für die nächsten 10 Minuten der Stunde 02:00 und steigt dann auf 108 GB für die nächsten 25 Minuten der Stunde 02:00.
Schließlich beendet die Instanz diese Stunden und den Rest des Monats bei einem
Wert von 28 GB.

Dieses Muster bedeutet, dass die maximale Anzahl von GB, die über die im Plan zugeordneten GB hinausging, während der Stunde ab 02:00 Uhr an Tag 3 bei 88 GB lag.
Für die Stunde 03:00 an Tag 3 und für den Rest des Monats belegte Ihre Instanz 8 GB mehr als im Plan zugeordnet.

Deshalb würde für die Stunde 02:00 an Tag 3 eine Überschreitung von 88 GB x 1 Stunde = 88 GB-Stunden berechnet werden.

Für die Stunde 03:00 von Tag 3 bis zum Ende von Tag 3 würde eine Überschreitung von 8 GB x 21 Stunden = 168 GB-Stunden berechnet werden.

Für die Stunde 00:00 von Tag 4 bis zum Ende des Monats (30 Tage) würde eine Überschreitung von 8 GB x 24 Stunden x 27 Tagen = 5184 GB-Stunden berechnet werden.

Die Gesamtrechnung für die monatliche Überschreitung wird wie folgt berechnet: 88 + 168 + 5184 = 5440 GB-Stunden.

## Größenbegrenzung für Anfragen und Dokumente
{: #request-and-document-size-limits}

Die Größe von JSON-Dokumenten und Anfragen von {{site.data.keyword.cloudant_short_notm}} ist wie folgt beschränkt: 

Grenzwert | Maximale Größe
------|-------------
Größe einer einzelnen Datei | 1 MB
Größe eines einzelnen Anhangs | 10 MB
Größe des Anforderungshauptteils | 11 MB

Das Überschreiten eines Grenzwerts führt zu einer [413-Antwort](/docs/services/Cloudant?topic=cloudant-http#http-status-codes).

Es wird empfohlen, binäre Anlagen oder große JSON-Blobs im Objektspeicher zu speichern und eine Verknüpfung zum Speicherort in einem {{site.data.keyword.cloudant_short_notm}} JSON-Dokument zu speichern.   

Beim Replizieren werden Dokumente oder Anlagen, die diese Grenzwerte überschreiten, nicht in die Zieldatenbank repliziert. Weitere
Informationen darüber, wie Sie Replikationsfehler erkennen können, finden Sie unter [Replikationsfehler](/docs/services/Cloudant?topic=cloudant-replication-api#replication-errors).

## Positionen und Tenants
{: #locations-and-tenancy}

Alle Lite- und Standard-Pläne werden standardmäßig in Multi-Tenant-Umgebungen
bereitgestellt. Als Teil Ihrer Planauswahl können Sie eine der folgenden {{site.data.keyword.cloud_notm}} Public-Regionen auswählen:

-   Washington DC
-   Dallas
-   London
-   Sidney
-   Frankfurt&Dagger;
-   Tokio

Instanzen eines Plans für dedizierte Hardware können an den meisten Standorten der
[{{site.data.keyword.IBM_notm}} Rechenzentren ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/cloud/data-centers/) bereitgestellt werden. 
Eine aktuelle Liste der verfügbaren Standorte enthält das Dropdown-Menü im {{site.data.keyword.cloud_notm}}-Katalog.

&Dagger;Alle {{site.data.keyword.cloudant_short_notm}}-Instanzen, die in der
{{site.data.keyword.cloud_notm}} Public-Region Frankfurt bereitgestellt werden,
werden in von der EU verwalteten Umgebungen bereitgestellt. Das {{site.data.keyword.cloudant_short_notm}}-Konto oder der API-Schlüssel, das bzw. der außerhalb einer EU-verwalteten Umgebung generiert wird, kann keinen Zugriff auf eine EU-verwaltete {{site.data.keyword.cloudant_short_notm}}-Instanz gewähren.

## Authentifizierungsmethoden
{: #authentication-methods}

Auf {{site.data.keyword.cloudant_short_notm}} wird über eine HTTP-API zugegriffen. Wenn der API-Endpunkt dies erfordert, wird der Benutzer für jede
HTTPS-Anforderung authentifiziert, die {{site.data.keyword.cloudant_short_notm}} empfängt. Während der Bereitstellung stehen die Authentifizierungsmethoden `Traditionelle Berechtigungsnachweise und IAM-Berechtigungsnachweise verwenden` und `Nur IAM verwenden` zur Verfügung. Weitere Informationen hierzu finden Sie im [IAM-Leitfaden](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-) oder in einer früheren Version des [Dokuments für
die Authentifizierungs-API](/docs/services/Cloudant?topic=cloudant-authentication#authentication).

Nach der Bereitstellung einer {{site.data.keyword.cloudant_short_notm}}-Instanz finden Sie die Details zur Verbindungs-URL und zur IAM-Autorisierung bei der Generierung neuer Berechtigungsnachweise auf der Registerkarte 'Serviceberechtigungsnachweise' im {{site.data.keyword.cloud_notm}}-Dashboard. Wenn Sie diese Option während der Bereitstellung auswählen, dann werden auch der traditionelle {{site.data.keyword.cloudant_short_notm}}-Benutzername sowie das entsprechende Kennwort eingebunden.

Das {{site.data.keyword.cloudant_short_notm}}-Team empfiehlt die Verwendung der IAM-Zugriffssteuerung für die Authentifizierung, falls möglich. Wenn Sie die traditionelle {{site.data.keyword.cloudant_short_notm}}-Authentifizierung verwenden, wird die Verwendung von [API-Schlüsseln](/docs/services/Cloudant?topic=cloudant-authorization#api-keys){: new_window} anstelle von Berechtigungsnachweisen für den programmgesteuerten Zugriff und für Replikationsjobs empfohlen. 
{: important}

## Hochverfügbarkeit, Disaster-Recovery und Sicherung in einem Rechenzentrum
{: #high-availability-disaster-recovery-and-backup-in-a-data-center}

Um in einem Rechenzentrum Hochverfügbarkeit und Disaster-Recovery bereitzustellen, werden alle Daten in dreifacher
Ausführung auf drei verschiedenen physischen Servern in einem Cluster gespeichert. Sie können Konten in mehreren Rechenzentren einrichten
und dann eine fortlaufende Datenreplikation nutzen, um Hochverfügbarkeit und Disaster-Recovery rechenzentrumsübergreifend
bereitzustellen. {{site.data.keyword.cloudant_short_notm}}-Daten werden nicht automatisch gesichert; es werden jedoch unterstützte Tools zum Erstellen von Sicherungen bereitgestellt. Im
Leitfaden für [Disaster-Recovery und Sicherung](/docs/services/Cloudant?topic=cloudant-authorization#api-keys)
finden Sie Informationen zu allen Aspekten von Hochverfügbarkeit, Disaster-Recovery und Sicherung, um die Anforderungen für Ihre Anwendung zu erfüllen. 

## {{site.data.keyword.cloud_notm}} Support
{: #ibm-cloud-support}

Support für Serviceinstanzen von Standard-Plänen und dedizierten Plänen ist optional.
Er wird nach Erwerb des *{{site.data.keyword.cloud_notm}}-Standard-Supports* bereitgestellt. Für Lite-Pläne wird kein Support angeboten.

Weitere Informationen zu den Support-Plänen finden Sie in den [{{site.data.keyword.cloud_notm}}-Standard-Support-Plänen ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/cloud/support#944376){: new_window}. Weitere Informationen zum Support finden Sie im [{{site.data.keyword.IBM_notm}} Support-Leitfaden ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/support/home/pages/support-guide/){: new_window}.

Die für {{site.data.keyword.cloudant_short_notm}} verwendeten Support-Systeme bieten keine Funktionen zum Schutz von Inhalten, die Informationen zur Krankenkasse, zum Gesundheitszustand, zu geschützten gesundheitlichen Daten oder Daten enthalten, die weiterführenden gesetzlichen Bestimmungen unterliegen. Der Kunde darf solche Daten nicht eingeben oder bereitstellen.
{: note}

## {{site.data.keyword.cloudant_short_notm}}-Instanz unter {{site.data.keyword.cloud_notm}} bereitstellen
{: #provisioning-a-cloudant-nosql-db-instance-on-ibm-cloud}

Sie können eine Instanz für einen {{site.data.keyword.cloudant_short_notm}}-Lite-Plan oder -Standard-Plan unter {{site.data.keyword.cloud_notm}} auf zwei Arten bereitstellen:

- Mithilfe des Dashboards. Weitere Informationen finden Sie im Lernprogramm [{{site.data.keyword.cloudant_short_notm}}-Instanz unter {{site.data.keyword.cloud_notm}} erstellen![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-an-ibm-cloudant-instance-on-ibm-cloud){: new_window}, in dem der Prozess beschrieben wird.
- Mithilfe des Cloud Foundry-Befehlstools. Weitere Informationen finden Sie im Lernprogramm [{{site.data.keyword.cloudant_short_notm}}-Instanz unter {{site.data.keyword.cloud_notm}} mit {{site.data.keyword.cloud_notm}}-CLI erstellen![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli#creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli){: new_window}, in dem der Prozess beschrieben wird.
 
Um eine Instanz eines {{site.data.keyword.cloudant_short_notm}}-Plans für dedizierte Hardware zu erstellen und zu nutzen, rufen Sie das Lernprogramm mit der Beschreibung des Prozesses [Instanz eines {{site.data.keyword.cloudant_short_notm}}-Plans für dedizierte Hardware unter {{site.data.keyword.cloud_notm}} erstellen und nutzen![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](/docs/services/Cloudant?topic=cloudant-creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud#creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud){: new_window} auf und führen Sie es aus.






