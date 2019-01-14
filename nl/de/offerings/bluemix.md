---

copyright:
  years: 2015, 2018
lastupdated: "2018-10-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:tip: .tip}

<!-- Acrolinx: 2017-05-10 -->

# {{site.data.keyword.cloud_notm}} Public
{: #ibm-cloud-public}

{{site.data.keyword.cloudantfull}} Public ist das {{site.data.keyword.cloudant_short_notm}}-Angebot mit dem
größten Funktionsumfang, das bevorzugt aktualisiert und mit neuen Funktionen ausgestattet wird. Die Preisstruktur basiert
auf Ihrem Durchsatz- und Speicherbedarf und eignet sich daher für jede erforderliche Auslastung. 

Der kostenfreie [Lite-Plan](#lite-plan) enthält eine feste Durchsatzkapazität und Datenmenge für Entwicklungs- und Evaluierungszwecke. Außerdem wird ein gebührenpflichtiger [Standard-Plan](#standard-plan) angeboten, der eine konfigurierbare Durchsatzkapazität sowie eine skalierbare Preisstruktur für den Datenspeicher bietet, die an Ihre wechselnden Anwendungserfordernisse angepasst werden können. Darüber hinaus wird ein optionaler [Plan für dedizierte Hardware](#dedicated-hardware-plan)
mit einer zusätzlichen monatlichen Gebühr angeboten, um einzelne oder mehrere Ihrer Standard-Plan-Instanzen in einer
Umgebung mit dedizierter Hardware auszuführen. Die Umgebung mit dedizierter Hardware steht Ihnen zur ausschließlichen Verwendung zur Verfügung. Wenn eine Instanz eines Plans für dedizierte Hardware an einem Standort in den USA bereitgestellt wird, können Sie optional eine mit [HIPAA ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){:new_window} konforme Konfiguration auswählen.

In der folgenden Tabelle werden die bereitgestellte Durchsatzkapazität und der konfigurierte Plattenspeicherplatz für den Lite-Plan und verschiedene Standard-Pläne aufgelistet:

<div id="maxtable"></div>

<table>

<tr>
<th id="capacity-config-plan">Plan</th><th id="lite">Lite</th><th id="standard" colspan='4'>Standard</th>
</tr>
<tr>
<th id="base-priceperhour" headers="capacity-config-plan">Grundpreis (pro Stunde)</td>
<td headers="lite base-priceperhour">$ 0,00</td>
<td headers="standard base-priceperhour" colspan='4'>Siehe <a href="../offerings/pricing.html#pricing" target="_blank">Preisdetails <img src="../images/launch-glyph.svg" alt="Symbol für externen Link" title="Symbol für externen Link"></a>.</td>
</tr>
<tr>
<th id="provisionedthroughputcapacity-lookupspersecond" headers="capacity-config-plan">Bereitgestellte Durchsatzkapazität (Suchvorgänge pro Sekunde)</td>
<td headers="lite provisionedthroughputcapacity-lookupspersecond-lite">20</td>
<td headers="standard provisionedthroughputcapacity-lookupspersecond">100</td>
<td headers="standard provisionedthroughputcapacity-lookupspersecond">1.000</td>
<td headers="standard provisionedthroughputcapacity-lookupspersecond">5.000</td>
<td headers="standard provisionedthroughputcapacity-lookupspersecond">20.000</td>
</tr>
<tr>
<th id="provisionedthroughputcapacity-writespersecond" headers="capacity-config-plan">Bereitgestellte Durchsatzkapazität (Schreibvorgänge pro Sekunde)</td>
<td headers="lite provisionedthroughputcapacity-writespersecond">10</td>
<td headers="standard provisionedthroughputcapacity-writespersecond">50</td>
<td headers="standard provisionedthroughputcapacity-writespersecond">500</td>
<td headers="standard provisionedthroughputcapacity-writespersecond">2.500</td>
<td headers="standard provisionedthroughputcapacity-writespersecond">10.000</td>
</tr>
<tr>
<th id="provisionedthroughputcapacity-queriespersecond" headers="capacity-config-plan">Bereitgestellte Durchsatzkapazität (Abfragen pro Sekunde)</td>
<td headers="lite provisionedthroughputcapacity-queriespersecond">5</td>
<td headers="standard provisionedthroughputcapacity-queriespersecond">5</td>
<td headers="standard provisionedthroughputcapacity-queriespersecond">50</td>
<td headers="standard provisionedthroughputcapacity-queriespersecond">250</td>
<td headers="standard provisionedthroughputcapacity-queriespersecond">1.000</td>
</tr>
<tr>
<th id="diskspaceincluded" headers="capacity-config-plan">Inbegriffener Plattenspeicherplatz</td>
<td headers="lite diskspaceincluded">1 GB</td>
<td headers="standard diskspaceincluded" colspan='4'>20 GB</td>
</tr>
<tr>
<th id="diskoveragepergbhour" headers="capacity-config-plan">Plattenüberschreitung (pro GB/Stunde)</td>
<td headers="lite diskoveragepergbhour">Nicht verfügbar</td>
<td headers="standard diskoveragepergbhour" colspan='4'>Siehe <a href="../offerings/pricing.html#pricing" target="_blank">Preisdetails <img src="../images/launch-glyph.svg" alt="Symbol für externen Link" title="Symbol für externen Link"></a>.</td>
</tr>

</table>

## Pläne
{: #plans}

Sie können auswählen, welcher Plan genutzt werden soll, wenn Sie
[Ihre {{site.data.keyword.cloudant_short_notm}}-Serviceinstanz bereitstellen](#provisioning-a-cloudant-nosql-db-instance-on-ibm-cloud).
Standardmäßig ist der [Lite-Plan](#lite-plan) ausgewählt.

![{{site.data.keyword.cloudant_short_notm}} - Auswahl des Serviceinstanzplans](../images/lite_pricing_plan.png)

### Lite-Plan
{: #lite-plan}

Der Lite-Plan ist kostenlos und wurde zu Entwicklungs- und Evaluierungszwecken entworfen. Er umfasst die vollständige Funktionalität von {{site.data.keyword.cloudant_short_notm}}, die Lite-Plan-Instanzen verfügen jedoch nur über eine begrenzte Menge an bereitgestellter Durchsatzkapazität und einen begrenzten Datenspeicher. Die bereitgestellte Durchsatzkapazität ist auf 20 Suchvorgänge pro Sekunde, 10 Schreibvorgänge pro Sekunde, 5 Abfragen pro Sekunde und eine Datenspeicherkapazität von maximal 1 GB beschränkt. 

Die Speicherbelegung wird täglich geprüft. Wenn Sie Ihren Speichergrenzwert von 1 GB überschreiten, erhalten Anforderungen an die {{site.data.keyword.cloudant_short_notm}}-Instanz den Statuscode '402' mit der Fehlermeldung, dass das Datennutzungskontingent für das Konto
überschritten wurde. Außerdem werden Sie in dieser Meldung darüber informiert, dass ein Upgrade auf einen gebührenpflichtigen Plan erforderlich ist.
Es wird außerdem ein entsprechendes Banner im {{site.data.keyword.cloudant_short_notm}}-Dashboard angezeigt. Sie können weiterhin Daten lesen und löschen. Wenn Sie neue Daten schreiben möchten, haben Sie jedoch zwei Möglichkeiten. Als Erstes können Sie ein Upgrade auf einen gebührenpflichtigen [Standard-Plan](#standard-plan) durchführen, durch das die Begrenzung für Schreiboperationen sofort aufgehoben wird. Alternativ hierzu können Sie auch Daten löschen, sodass der insgesamt belegte Speicherplatz unter das Limit von 1 GB fällt. Anschließend müssen Sie die Ausführung der nächsten täglichen Speicherprüfung für Ihre Instanz abwarten, damit Sie wieder Schreiboperationen ausführen können. 

Wenn Sie mehr als 1 GB an Daten speichern möchten oder wenn Sie die bereitgestellte Durchsatzkapazität skalieren möchten, dann müssen Sie Ihr System auf den [Standard-Plan](#standard-plan) umstellen.

Pro {{site.data.keyword.cloud_notm}}-Konto können Sie eine {{site.data.keyword.cloudant_short_notm}}-Lite-Plan-Instanz verwenden. Wenn Sie bereits über eine Lite-Plan-Instanz verfügen, dann wird für jeden Versuch, eine weitere Lite-Plan-Instanz zu erstellen oder eine Standard-Plan-Instanz in einen Lite-Plan umzuwandeln, eine Nachricht ähnlich der folgenden ausgegeben: "Es ist nur eine Instanz eines Lite-Plans pro Service zulässig. Zur Erstellung einer neuen Instanz müssen Sie entweder
Ihre vorhandene Lite-Plan-Instanz löschen oder einen gebührenpflichtigen Plan auswählen."
{: tip}

### Standard-Plan
{: #standard-plan}

Der {{site.data.keyword.cloudant_short_notm}}-Standard-Plan steht für alle gebührenpflichtigen {{site.data.keyword.cloud}}-Konten entweder als nutzungsabhängige Lösung oder als Abonnement zur Verfügung und kann zur Anpassung an die Anforderungen Ihrer Anwendung skaliert werden. Die Preisgestaltung des Standard-Plans basiert auf zwei Faktoren, und zwar auf der bereitgestellten Durchsatzkapazität, die zugeordnet wird, und auf dem Datenvolumen, das in der Instanz gespeichert werden kann. 

Die Preisstruktur wird stündlich bewertet, wobei eine anfängliche Durchsatzkapazität von 100 Suchvorgängen/Sekunde, 50 Schreibvorgängen/Sekunde und 5 Abfragen/Sekunde zu einem Anfangspreis von 0,105 Dollar/Stunde berechnet wird. Sie können die bereitgestellte Durchsatzkapazität in Schritten von 100 Suchvorgängen/Sekunde, 50 Schreibvorgängen/Sekunde und 5 Abfragen/Sekunde im {{site.data.keyword.cloudant_short_notm}}-Dashboard nach oben oder unten anpassen. Die Kosten werden für die bereitgestellte Durchsatzkapazität berechnet, die zugeordnet wurde, und nicht auf Basis des gemessenen Anforderungsvolumens. Der Standard-Plan umfasst 20 GB Datenspeicher. Wenn Sie mehr als 20 GB speichern, wird Ihnen eine definierte Summe pro GB und pro Stunde berechnet. 

Beispiele zur Kostenschätzung finden Sie in den Informationen zur Preisstruktur bei unterschiedlichen Kapazitäten und in unterschiedlichen Währungen im {{site.data.keyword.cloud_notm}}-Preisrechner sowie in den Informationen zur [Preisstruktur](../offerings/pricing.html#pricing){:new_window}.

### Plan für dedizierte Hardware
{: #dedicated-hardware-plan}

Eine Instanz für einen {{site.data.keyword.cloudant_short_notm}}-Plan für dedizierte Hardware stellt eine {{site.data.keyword.cloudant_short_notm}}-Bare-Metal-Umgebung dar, die zur alleinigen Nutzung durch Ihre {{site.data.keyword.cloudant_short_notm}}-Standard-Plan-Instanzen zur Verfügung gestellt wird. Eine Umgebung mit einem {{site.data.keyword.cloudant_short_notm}}-Plan für dedizierte Hardware kann in einem beliebigen [{{site.data.keyword.IBM}} Rechenzentrum ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/cloud-computing/bluemix/data-centers) bereitgestellt werden. Dieser Plan ist für
die HIPAA-Konformität erforderlich und muss bei der Bereitstellung ausgewählt werden. Darüber hinaus können Benutzer einer Umgebung mit einem {{site.data.keyword.cloudant_short_notm}}-Plan für dedizierte Hardware das IP-Whitelisting sowie vom Kunden verwaltete BYOK-Verschlüsselungsschlüssel mit IBM Key Protect bereitstellen. 

Sie können einzelne oder auch mehrere Standard-Plan-Instanzen bereitstellen. Die Umgebung mit dedizierter Hardware wird bedarfsorientiert auf Basis der Kapazitäten und Daten angepasst, die von den Standard-Plan-Instanzen belegt werden. Hierbei handelt es sich um eine zusätzliche Option, die zu den Nutzungspreisen für die
{{site.data.keyword.cloudant_short_notm}}-Standard-Plan-Instanzen mit einem Festpreis hinzugerechnet wird. Die Abrechnung wird in täglichen Zeitabständen anteilsmäßig bewertet, wobei eine Mindestlaufzeit von einem Monat für die Umgebung in Rechnung gestellt wird. Die Bereitstellung eines {{site.data.keyword.cloudant_short_notm}}-Plans für dedizierte Hardware verläuft asynchron und kann 5-7 Werktage in Anspruch nehmen. Zur Erstellung einer Instanz für einen {{site.data.keyword.cloudant_short_notm}}-Plan für dedizierte Hardware und zur Bereitstellung einer Standard-Plan-Instanz für diesen Plan müssen Sie die Anweisungen im Lernprogramm zur [Erstellung und Nutzung einer Instanz für einen {{site.data.keyword.cloudant_short_notm}}-Plan für dedizierte Hardware unter {{site.data.keyword.cloud_notm}} ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](../tutorials/create_dedicated_hardware_plan.html#creating-and-leveraging-a-cloudant-dedicated-hardware-plan-instance-on-bluemix){:new_window} befolgen. 

Der Plan für dedizierte Hardware steht für dedizierte {{site.data.keyword.cloud_notm}}-Kunden nicht zur Verfügung. Der Plan für dedizierte Hardware steht nur für {{site.data.keyword.cloud_notm}} Public-Kunden zur Verfügung.
{: tip}

## Bereitgestellte Durchsatzkapazität
{: #provisioned-throughput-capacity}

Die Bereitstellung des Durchsatzes wird in Form eines dieser Arten von Ereignissen ermittelt und gemessen:

1.	Ein Suchvorgang, bei dem es sich um einen Lesevorgang
    eines bestimmten Dokuments handelt, auf der Basis der `_id` des Dokuments.
2.	Ein Schreibvorgang, bei dem es sich um das Erstellen,
    Ändern oder Löschen eines einzelnen Dokuments handelt,
    oder um ein beliebiges Update aufgrund einer Indexerstellung.
3.	Eine Abfrage, bei der es sich um einen der {{site.data.keyword.cloudant_short_notm}}-Abfrageendpunkte handelt, einschließlich der folgenden Typen:
	-	Primärindex ([`_all_docs`](../api/database.html#get-documents))
	-	MapReduce-Ansicht ([`_view`](../api/creating_views.html#using-views))
	-	Suchindex ([`_search`](../api/search.html#queries))
	-	Geografisch-räumlicher Index ([`_geo`](../api/cloudant-geo.html#querying-a-cloudant-geo-index))
	-	{{site.data.keyword.cloudant_short_notm}} Query ([`_find`](../api/cloudant_query.html#finding-documents-using-an-index))

Die Messung des Durchsatzes ist eine einfache Zählung der Anzahl von Ereignissen jedes Typs,
pro Sekunde, wobei die Sekunde ein _gleitendes_ Fenster ist.
Wenn Ihr Konto die Anzahl von Durchsatzereignissen überschreitet, die für den Plan bereitgestellt werden,
werden Anforderungen so lange zurückgewiesen, bis die Anzahl von Ereignissen im gleitenden Fenster
die festgelegte Anzahl nicht mehr überschreitet.
Vielleicht hilft es Ihnen, sich vorzustellen, dass das gleitende 1-Sekunden-Fenster ein fortlaufender Zeitraum von 1.000 Millisekunden ist.

Der Standard-Plan wird beispielsweise für 200 Suchvorgänge pro Sekunde bereitgestellt. Ihr Konto stellt möglicherweise während eines fortlaufenden Zeitraums von 1.000 Millisekunden (1 Sekunde) maximal 200 Suchanforderungen. Nachfolgende Suchanforderungen, die während des gleitenden 1.000-Millisekunden-Zeitraums gestellt werden,
werden abgelehnt, bis die Anzahl von Suchanforderungen in diesem Zeitraum wieder auf weniger als 200 sinkt.

Wenn eine Anforderung abgelehnt wird, weil die Anzahl von Ereignissen überschritten ist,
empfangen Anwendungen eine Antwort [`429` Too Many Requests](../api/http.html#429).

Aktuelle Versionen der unterstützten Clientbibliotheken (für [Java](../libraries/supported.html#java),
[Node.js](../libraries/supported.html#node-js) und [Python](../libraries/supported.html#python)) unterstützen Sie bei der Verarbeitung einer `429`-Antwort.
Beispiel: Die Java-Bibliothek gibt die Antwort [`TooManyRequestsException` ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://static.javadoc.io/com.cloudant/cloudant-client/2.5.1/com/cloudant/client/org/lightcouch/TooManyRequestsException.html){:new_window} aus.

Standardmäßig versuchen die unterstützten Clientbibliotheken nicht automatisch, eine Anforderung zu wiederholen, wenn eine `429`-Antwort empfangen wird.

Es ist sinnvoller, sicherzustellen, dass Ihre Anwendung `429`-Antworten korrekt verarbeitet.
Denn die Anzahl von erneuten Versuchen ist begrenzt. Ein regelmäßiges Überschreiten der Anzahl von Anforderungen ist ein starker Indikator, dass ein Wechsel zu einer anderen Plankonfiguration angebracht ist.

Wenn Sie eine vorhandene Anwendung portieren, kann die Antwort `429` möglicherweise nicht verarbeitet werden. Als Teil der Migrationsverifizierung prüfen Sie, dass Ihre Anwendung `429`-Antworten korrekt verarbeitet.
{: tip}

Zusammenfassend lässt sich sagen, dass Sie sicherstellen müssen, dass Ihre Anwendung eine [`429`](../api/http.html#429)-Antwort korrekt verarbeiten kann.

<div id="servicetier"></div>

### Kapazität anzeigen und ändern
{: #viewing-and-changing-capacity}

Sie finden die Details der Durchsatzkapazität in den für Ihr Konto verfügbaren Plänen.
Sie können die gewünschte Ebene der Bereitstellung auf der Registerkarte 'Konto' im Dashboard Ihres {{site.data.keyword.cloudant_short_notm}}-Kontos
auswählen.

![Dashboard des Kontos](../images/cloudant_capacity.png)

Um zu einer anderen Durchsatzkapazität zu wechseln,wählen Sie die gewünschte Bereitstellung aus und klicken Sie auf `Aktualisieren`. Sie werden aufgefordert, die Änderung zu bestätigen, und daran erinnert, dass es bis zu 24 Stunden dauern kann, bis sie wirksam wird.

![Dashboard des Kontos](../images/cloudant_capacity_change.png)

Der Umfang der Kapazitätserhöhung ist auf zehn Einheiten (1000 Suchvorgänge/Sekunde, 500 Schreibvorgänge/Sekunde und 50 Abfragen/Sekunde) pro Änderung begrenzt. Bei der Reduzierung bestehen keine Beschränkungen in Bezug auf die Anzahl der Einheiten. Alle Kapazitätsänderungen (Erhöhungen oder Reduzierungen) können nur einmal pro Stunde durchgeführt werden. Wenn Sie mehr Kapazität benötigen, als über das {{site.data.keyword.cloudant_short_notm}}-Dashboard bereitgestellt wird, dann wenden Sie sich an den [{{site.data.keyword.cloudant_short_notm}}-Support ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](mailto:support@cloudant.com){:new_window}.
{: tip}

<div id="throughput"></div>

### Nutzung überwachen 
{: #monitoring-usage}

Informationen zu Ihrer Nutzung finden Sie im Teilfenster 'Aktuelle Operationen' der Registerkarte 'Überwachung' in Ihrem {{site.data.keyword.cloudant_short_notm}}-Dashboard. 

![Nutzung im Dashboard überwachen](../images/cloudant_usage.png)

Dort finden Sie Details wie Ihr aktueller [Durchsatz](#provisioned-throughput-capacity) und die Menge der [gespeicherten Daten](#disk-space-included).

Dank der Überwachung können Sie ermitteln, dass eine Änderung an der Bereitstellung in Ihrem Plan ratsam sein könnte.
Wenn Sie beispielsweise regelmäßig die maximale Anzahl von Datenbanksuchvorgängen erreichen,
können Sie die Bereitstellung im [Teilfenster 'Service'](#servicetier) auf der Registerkarte 'Konto' des Dashboards ändern.

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

Das Überschreiten eines Grenzwerts führt zu einer [413-Antwort](../api/http.html#413).

Es wird empfohlen, binäre Anlagen oder große JSON-Blobs im Objektspeicher zu speichern und eine Verknüpfung zum Speicherort in einem {{site.data.keyword.cloudant_short_notm}} JSON-Dokument zu speichern.   

Beim Replizieren werden Dokumente oder Anlagen, die diese Grenzwerte überschreiten, nicht in die Zieldatenbank repliziert. Weitere Informationen darüber, wie Sie Replikationsfehler erkennen können, finden Sie [hier](../api/replication.html#replication-errors).

## Positionen und Tenants
{: #locations-and-tenancy}

Alle Lite- und Standard-Pläne werden standardmäßig in Multi-Tenant-Umgebungen
bereitgestellt. Als Teil Ihrer Planauswahl können Sie eine der folgenden {{site.data.keyword.cloud_notm}} Public-Regionen auswählen:

-   USA (Osten)
-   Vereinigte Staaten (Süden)
-   Großbritannien
-   Sydney
-   Deutschland&Dagger;
-   Asiatisch-pazifischer Raum - Norden (Tokio)

Instanzen eines Plans für dedizierte Hardware können an den meisten Standorten der
[{{site.data.keyword.IBM_notm}} Rechenzentren ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/cloud-computing/bluemix/data-centers) bereitgestellt werden.
Eine aktuelle Liste der verfügbaren Standorte enthält das Dropdown-Menü im {{site.data.keyword.cloud_notm}}-Katalog.

&Dagger;Alle {{site.data.keyword.cloudant_short_notm}}-Instanzen, die in der {{site.data.keyword.cloud_notm}} Public-Region Deutschland bereitgestellt werden, werden in EU-verwalteten Umgebungen bereitgestellt. Das {{site.data.keyword.cloudant_short_notm}}-Konto oder der API-Schlüssel, das bzw. der außerhalb einer EU-verwalteten Umgebung generiert wird, kann keinen Zugriff auf eine EU-verwaltete {{site.data.keyword.cloudant_short_notm}}-Instanz gewähren.

## Authentifizierungsmethoden
{: #authentication-methods}

Auf {{site.data.keyword.cloudant_short_notm}} wird über eine HTTP-API zugegriffen. Wenn der API-Endpunkt dies erfordert, wird der Benutzer für jede
HTTPS-Anforderung authentifiziert, die {{site.data.keyword.cloudant_short_notm}} empfängt. Während der Bereitstellung stehen die Authentifizierungsmethoden 'Traditionelle Berechtigungsnachweise und IAM-Berechtigungsnachweise verwenden' und 'Nur IAM verwenden' zur Verfügung. Weitere Informationen hierzu finden Sie im [IAM-Leitfaden](../guides/iam.html){:new_window} oder in einer früheren Version des [Dokuments für
die Authentifizierungs-API](../api/authentication.html){:new_window}.

Nach der Bereitstellung einer {{site.data.keyword.cloudant_short_notm}}-Instanz finden Sie die Details zur Verbindungs-URL und zur IAM-Autorisierung bei der Generierung neuer Berechtigungsnachweise auf der Registerkarte 'Serviceberechtigungsnachweise' im {{site.data.keyword.cloud_notm}}-Dashboard. Wenn Sie diese Option während der Bereitstellung auswählen, dann werden auch der traditionelle {{site.data.keyword.cloudant_short_notm}}-Benutzername sowie das entsprechende Kennwort eingebunden.


## Hochverfügbarkeit, Disaster-Recovery und Sicherung
{: #high-availability-disaster-recovery-and-backup}

Um in einem Rechenzentrum Hochverfügbarkeit und Disaster-Recovery bereitzustellen, werden alle Daten in dreifacher
Ausführung auf drei verschiedenen physischen Servern in einem Cluster gespeichert. Sie können Konten in mehreren Rechenzentren einrichten
und dann eine fortlaufende Datenreplikation nutzen, um Hochverfügbarkeit und Disaster-Recovery rechenzentrumsübergreifend
bereitzustellen. {{site.data.keyword.cloudant_short_notm}}-Daten werden nicht automatisch gesichert; es werden jedoch unterstützte Tools zum Erstellen von Sicherungen bereitgestellt. Im Leitfaden für
[Disaster-Recovery und Sicherung ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://console.bluemix.net/docs/services/Cloudant/guides/disaster-recovery-and-backup.html#disaster-recovery-and-backup)
finden Sie Informationen zu allen Aspekten von Hochverfügbarkeit, Disaster-Recovery und Sicherung, um die Anforderungen für Ihre Anwendung zu erfüllen. 

## Support
{: #support}

Support für Serviceinstanzen von Standard-Plänen und dedizierten Plänen ist optional.
Er wird nach Erwerb des *{{site.data.keyword.cloud_notm}}-Standard-Supports* bereitgestellt. Für Lite-Pläne wird kein Support angeboten.

Weitere Informationen zu den Support-Plänen finden Sie in den [{{site.data.keyword.cloud_notm}}-Standard-Support-Plänen ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/cloud/support#944376){:new_window}. Weitere Informationen zum Support finden Sie im [{{site.data.keyword.IBM_notm}} Support-Leitfaden ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/support/home/pages/support-guide/){:new_window}.

Die für {{site.data.keyword.cloudant_short_notm}} verwendeten Support-Systeme bieten keine Funktionen zum Schutz von Inhalten, die Informationen zur Krankenkasse, zum Gesundheitszustand, zu geschützten gesundheitlichen Daten oder Daten enthalten, die weiterführenden gesetzlichen Bestimmungen unterliegen. Der Kunde darf solche Daten nicht eingeben oder bereitstellen.
{: tip}

## {{site.data.keyword.cloudant_short_notm}}-Instanz unter {{site.data.keyword.cloud_notm}} bereitstellen
{: #provisioning-a-cloudant-nosql-db-instance-on-ibm-cloud}

Sie können eine Instanz für einen {{site.data.keyword.cloudant_short_notm}}-Lite-Plan oder -Standard-Plan unter {{site.data.keyword.cloud_notm}} auf zwei Arten bereitstellen:

- Mithilfe des Dashboards. Ein Lernprogramm, das den Prozess beschreibt, können Sie [hier ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://console.bluemix.net/docs/services/Cloudant/tutorials/create_service.html#creating-a-cloudant-instance-on-bluemix){:new_window} abrufen.
- Mithilfe des Cloud Foundry-Befehlstools. Ein Lernprogramm, das den Prozess beschreibt, können Sie [hier ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://console.bluemix.net/docs/services/Cloudant/tutorials/create_service_cli.html#creating-a-cloudant-instance-on-bluemix-using-the-cloud-foundry-tools){:new_window} abrufen.
 
Um eine Instanz eines {{site.data.keyword.cloudant_short_notm}}-Plans für dedizierte Hardware zu erstellen und zu nutzen, rufen Sie das Lernprogramm mit der Beschreibung des Prozesses [hier ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://console.bluemix.net/docs/services/Cloudant/tutorials/create_dedicated_hardware_plan.html#creating-and-leveraging-a-cloudant-dedicated-hardware-plan-instance-on-bluemix){:new_window} auf und führen Sie es aus.




