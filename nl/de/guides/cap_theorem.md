---

copyright:
  years: 2015, 2017
lastupdated: "2017-01-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-01-24 -->

<div id="cap_theorem"></div>

<div id="consistency"></div>

# CAP-Theorem

Cloudant verwendet ein ['Eventually Consistent'-Modell ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://en.wikipedia.org/wiki/Eventual_consistency){:new_window}, d. h. ein Modell, das sukzessive Konsistenz realisiert. {:shortdesc}

Um zu verstehen, wie dieses Modell funktioniert und warum
es ein wesentlicher Teil der Arbeit mit Cloudant ist, führen Sie sich vor Augen,
was unter dem Begriff der Konsistenz verstanden wird. 

Konsistenz ist eine der vier ['ACID'-Eigenschaften ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://en.wikipedia.org/wiki/ACID){:new_window},
die erforderlich sind, damit Transaktionen in einer Datenbank zuverlässig verarbeitet und berichtet werden. 

Darüber hinaus ist Konsistenz eines der drei Attribute im
<a href="http://en.wikipedia.org/wiki/CAP_Theorem" target="_blank">CAP-Theorem <img src="../images/launch-glyph.svg" alt="Symbol für externen Link" title="Symbol für externen Link"></a>.
Diese Attribute sind neben Konsistenz (**C**onsistency) Verfügbarkeit (**A**vailability) und **P**artitionstoleranz.
Das Theorem besagt, dass es für ein verteiltes Computersystem wie Cloudant nicht möglich ist, drei Attribute _gleichzeitig_ zu garantieren:

-   Konsistenz, wobei alle Knoten zum selben Zeitpunkt dieselben Daten anzeigen. 
-   Verfügbarkeit, die garantiert, dass jede Anforderung eine Antwort empfängt, ob sie erfolgreich war oder fehlgeschlagen ist. 
-   Partitionstoleranz, wobei das System auch dann weiter arbeitet, wenn ein Teil des Systems ausfällt. 

Die Unmöglichkeit, alle drei Attribute gleichzeitig zu garantieren,
führt dazu, dass Cloudant das Attribut der Konsistenz nicht garantiert.
In einem Modell mit sukzessive erreichter Konsistenz wie Cloudant wird eine Aktualisierung in einem Teil des Systems
_irgendwann einmal_ auch von den anderen Teilen des Systems gesehen.
Mit der Weitergabe der Aktualisierung nähert sich das System dem Zustand der vollständigen Konsistenz an. 

Das Konzept der sukzessive erreichten Konsistenz ist unter Leistungsgesichtspunkten ein empfehlenswertes Modell.
Bei einem Modell für stärkere Konsistenz muss ein System darauf warten, dass
Aktualisierungen vollständig und erfolgreich weitergegeben wurden, bevor
eine Schreib- oder Aktualisierungsanforderung abgeschlossen werden kann.
Bei einem Modell mit sukzessive erreichter Konsistenz kann die Schreib-
oder Aktualisierungsanforderung praktisch sofort zurückgegeben werden, während
sich die Weitergabe der Änderungen im Hintergrund weiter vollzieht. 

Eine Datenbank kann sowohl aus theoretischen, als auch aus praktischen Gründen nur zwei dieser Attribute aufweisen.
Eine Datenbank, die Konsistenz und Verfügbarkeit priorisiert, ist einfach:
auf einem einzelnen Knoten wird eine einzelne Kopie Ihrer Daten gespeichert.
Aber dieses Modell ist schwer zu skalieren, weil Sie für den Knoten Upgrades ausführen müssen, um mehr Leistung zu erhalten, und nicht einfach zusätzliche Knoten verwenden können. Und selbst ein
unbedeutender Systemfehler kann dazu führen, dass ein System mit nur einem Knoten heruntergefahren wird,
wobei jeder Nachrichtenverlust mit erheblichem Datenverlust einhergeht.
Um stabil zu laufen, muss das System weiter entwickelt werden. 

## Kompromisse bei der Partitionstoleranz

Eine Datenbank, die Konsistenz und Partitionstoleranz priorisiert, nutzt eine
<a href="http://en.wikipedia.org/wiki/Master/slave_(technology)" target="_blank">Master/Slave-Konfiguration <img src="../images/launch-glyph.svg" alt="Symbol für externen Link" title="Symbol für externen Link"></a>,
bei der einer der vielen Knoten im System zum führenden Knoten gewählt wird.
Nur der führende Knoten kann Datenschreibvorgänge genehmigen,
während alle sekundären Knoten Daten aus dem führenden Knoten replizieren, um Lesevorgänge zu verarbeiten.
Wenn der führende Knoten die Verbindung zum Netz verliert
oder mit vielen anderen Knoten im System nicht kommunizieren kann,
wählen die restlichen Knoten einen neuen führenden Knoten.
Dieser Auswahlprozess unterscheidet sich zwischen Systemen und
kann zu [signifikanten Problemen ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://aphyr.com/posts/284-call-me-maybe-mongodb){:new_window} führen.

Cloudant priorisiert Verfügbarkeit und Partitionstoleranz durch den Einsatz einer Master/Master-Konfiguration,
sodass jeder Knoten sowohl Schreib- als auch Lesevorgänge für die eigenen Daten zulassen kann.
Mehrere Knoten enthalten Kopien der einzelnen Teile Ihrer Daten.
Jeder Knoten kopiert Daten anderer Knoten.
Wenn auf einen Knoten nicht mehr zugegriffen werden kann, können andere seine Funktion
übernehmen, während das Netz repariert wird.
Auf diese Weise gibt das System trotz Knotenausfalls Ihre Daten zeitnah zurück und behält die [sukzessive erreichte Konsistenz ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://en.wikipedia.org/wiki/Eventual_consistency){:new_window} bei.
Der Kompromiss, den Sie eingehen, wenn Sie der Konsistenz keine höchste Priorität einräumen, besteht darin, dass es eine Weile dauert, bis alle Knoten dieselben Daten anzeigen.
Dies hat zur Folge, dass manche Antworten möglicherweise alte Daten enthalten, während die neuen Daten noch im System weitergegeben werden. 

## Methode ändern

Eine konsistente Ansicht von Daten beizubehalten, ist logisch und einleuchtend, weil eine relationale Datenbank diese Arbeit für Sie übernimmt.
Die Erwartung ist, dass webbasierte Services, die mit diesen Datenbanksystemen interagieren, sich genauso verhalten.
Aber diese Erwartung kann nicht immer erfüllt werden.
Konsistenz ist keine Selbstverständlichkeit, und es dauert seine Zeit, die Methode zu ändern. 

Tatsächlich ist Konsistenz für viele Unternehmens-Cloud-Services gar nicht unerlässlich.
Große, stark ausgelastete Systeme schlagen mit hoher Wahrscheinlichkeit in Teilen fehl.
Eine Datenbank, bei deren Entwicklung Verfügbarkeit und sukzessive erreichte Konsistenz priorisiert wurden,
eignet sich deutlich besser, eine ununterbrochene Verfügbarkeit Ihrer Anwendung zu realisieren.
Um die Konsistenz von Anwendungsdaten kann sich im Anschluss gekümmert werden.
Wie Seth Gilbert und Nancy Lynch vom MIT
[feststellten ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://www.glassbeam.com/sites/all/themes/glassbeam/images/blog/10.1.1.67.6951.pdf){:new_window},
sind die realistischsten Systeme heute gezwungen, sich damit zufrieden zu geben, dass "meistens die meisten Daten" zurückgegeben werden. 

## Anwendungsverfügbarkeit versus Konsistenz im Unternehmen

Ein Blick auf beliebte webbasierte Systeme zeigt, dass Benutzer Hochverfügbarkeit erwarten
und dabei gerne Abstriche machen bezüglich der vollständigen Konsistenz von Daten, oftmals ohne
dies überhaupt zu realisieren. 

Viele Anwendungen führen Benutzer der Verfügbarkeit zuliebe an der Nase herum.
Denken Sie an Bankautomaten:
Inkonsistente Bankingdaten sind der Grund, warum Sie immer noch Ihr Konto überziehen können, ohne das zu bemerken.
Es ist kein realistischer Plan, eine konsistente Ansicht Ihres Kontostands im gesamten Bankingsystem abzubilden,
wenn dafür jeder Knoten im Netz angehalten werden und diese Zahl aufzeichnen muss, bevor die Prozesse weiterlaufen können.
Es ist wichtiger, das System hoch verfügbar zu machen.

Der Bankensektor hat dies bereits in den späten 80-ern verstanden,
aber viele IT-Unternehmen haben immer noch Schwierigkeiten damit, die Konsistenz der Verfügbarkeit zu opfern.
Denken Sie an die Anzahl von Supportanrufen, wenn Ihr Vertriebsteam keinen Zugriff auf die CRM-App hat.
Und jetzt überlegen Sie, ob es überhaupt auffallen würde, wenn eine Datenbankaktualisierung einige Sekunden braucht, um in der gesamten Anwendung angekommen zu sein. 

Verfügbarkeit sticht Konsistenz deutlicher als Sie vielleicht erwarten.
Onlinewarenkorbsysteme,
HTTP-Caches und DNS sind weitere Beispiele.
Organisationen müssen den Preis für Ausfallzeiten wie Frustration der Benutzer, Produktivitätsverluste und entgangene Geschäftschancen einkalkulieren. 

## Von der Theorie zur Umsetzung

Hochverfügbarkeit ist ein zentraler Aspekt für Cloudanwendungen.
Eine globale Datenbankkonsistenz wird auch bei zunehmender Skalierung weiterhin ein bedeutender Hemmschuh bleiben.
Hoch verfügbare Anwendungen müssen in ständigem Kontakt zu ihren Daten sein können, selbst wenn diese Daten nicht topaktuell sind.
Dies ist das Konzept einer sukzessive erreichten Konsistenz und Sorgen sind unberechtigt.
Im großen Ganzen ist es manchmal besser, Antworten zu geben, die nicht hundertprozentig richtig sind, als gar keine Antworten zu liefern. 

Unterschiedliche Datenbanksysteme verbergen die Komplexität des Abwägens zwischen Verfügbarkeit und Konsistenz auf unterschiedliche Weise, aber sie sind immer da. Cloudant-Database as a Service,
CouchDB und andere NoSQL-Datenbanken vertreten den Standpunkt, dass Entwickler diese Komplexitäten möglichst früh im Entwurfsprozess adressieren müssen.
Je früher diese grundlegende Arbeit erledigt wird, umso weniger negative Überraschungen sind zu erwarten, da Anwendungen ab dem ersten Tag skaliert werden können. 
