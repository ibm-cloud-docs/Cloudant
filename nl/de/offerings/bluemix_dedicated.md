---

copyright:
  years: 2015, 2018
lastupdated: "2017-11-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-02-23 -->

# {{site.data.keyword.Bluemix_notm}} Dedicated

{{site.data.keyword.cloudantfull}} für Bluemix Dedicated ist ein
optionales kostenpflichtiges Add-on für eine Bluemix Dedicated-Umgebung. Der Preis für das optionale Add-on für
{{site.data.keyword.cloudant_short_notm}} Dedicated in Bluemix Dedicated wird nach der Hardwarekapazität
berechnet, die der Umgebung zugeordnet ist, und kann bei Ihrem zuständigen {{site.data.keyword.IBM}}
Außendienstmitarbeiter bestellt werden.  

Bluemix Dedicated-Kunden haben außerdem die Möglichkeit, {{site.data.keyword.cloudant_short_notm}} in Bluemix Public
über den syndizierten Katalog zu verwenden, einschließlich Lite-Plan- und Standardplaninstanzen. Dabei ist zu beachten, dass
Bluemix Dedicated-Benutzer den Plan für dedizierte Hardware aus dem Bluemix Public-Katalog nicht bestellen können.
Diese Benutzer sollten {{site.data.keyword.cloudant_short_notm}} Dedicated unter
Bluemix Dedicated nutzen, sofern dedizierte Hardware erforderlich ist.   

Der nachfolgende Screenshot zeigt ein Beispiel für einen {{site.data.keyword.Bluemix_notm}}-Katalog, in dem
die syndizierte {{site.data.keyword.Bluemix_notm}} Public-Version von {{site.data.keyword.cloudant_short_notm}} (links)
und die {{site.data.keyword.cloudant_short_notm}} Dedicated-Umgebung (rechts) hervorgehoben ist.  

![{{site.data.keyword.cloudant_short_notm}}-Katalog](../images/bluemix_catalog.png)

## Hardwarekapazität 

{{site.data.keyword.cloudant_short_notm}} in {{site.data.keyword.Bluemix_notm}} Dedicated wird mithilfe eines Teils
'{{site.data.keyword.Bluemix_notm}} Dedicated
{{site.data.keyword.cloudant_short_notm}} 1.6 TB Capacity' erworben, das eine {{site.data.keyword.cloudant_short_notm}}-Clusterumgebung
mit drei Datenbankknoten und zwei Lastausgleichsfunktionen beinhaltet. Jeder Datenbankknoten enthält
1,6 TB Speicherplatz auf SSD-Festplatten. Da alle Daten dreifach gespeichert werden, entspricht dies
einem eindeutigen Plattenspeicherplatz von 1,6 TB für den gesamten Cluster. Zum Erweitern der Umgebung können zusätzliche Teile '{{site.data.keyword.Bluemix_notm}} Dedicated
{{site.data.keyword.cloudant_short_notm}} 1.6 TB Capacity' gekauft werden, die den
{{site.data.keyword.cloudant_short_notm}}-Cluster jeweils um drei weitere Datenbankknoten
erweitern. Die Kunden können sich anstelle einer einzelnen Umgebung auch für mehrere
separate {{site.data.keyword.cloudant_short_notm}}-Umgebungen entscheiden.

## Positionen und Tenants 

Die {{site.data.keyword.cloudant_short_notm}} Dedicated-Umgebung innerhalb einer {{site.data.keyword.Bluemix_notm}} Dedicated-Umgebung
nutzt dedizierte Hardware, die ausschließlich dem betreffenden {{site.data.keyword.Bluemix_notm}} Dedicated-Kunden
zur Verfügung steht. Der Kunde kann in der jeweiligen Umgebung eine oder mehrere Instanzen von
{{site.data.keyword.cloudant_short_notm}} bereitstellen. Dabei nutzt jede Instanz von {{site.data.keyword.cloudant_short_notm}}
die zugrunde liegenden Hardwareressourcen, aus denen die {{site.data.keyword.cloudant_short_notm}}-Umgebung besteht. 

## Sicherheit, Verschlüsselung und Compliance 

Alle Pläne werden auf Servern mit einer Verschlüsselung gespeicherter Daten vom Typ [at-rest ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://en.wikipedia.org/wiki/Data_at_rest)
bereitgestellt. Der Zugriff erfolgt über die öffentliche Netzverbindung mit Verschlüsselung über HTTPS. Weitere Details finden Sie unter [Sicherheit ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://console.bluemix.net/docs/services/Cloudant/offerings/security.html#security){:new_window}.
IP-Whitelisting ist auf Anfrage beim {{site.data.keyword.cloudant_short_notm}}-Support erhältlich und gilt für
die gesamte {{site.data.keyword.cloudant_short_notm}}-Umgebung (d. h., nicht auf Instanzebene). 

Der Plan bietet auch die [Zertifizierung der Einhaltung von Sicherheitsbestimmungen ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://console.bluemix.net/docs/services/Cloudant/offerings/compliance.html#cloudant-security-compliance){:new_window}.
Compliance mit [HIPAA ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){:new_window}
wird auf Anforderung zur Verfügung gestellt; fordern Sie diese Compliance daher als Teil des Kaufprozesses bei einem {{site.data.keyword.IBM_notm}} Vertriebsbeauftragten an. 

## Hochverfügbarkeit, Disaster-Recovery und Sicherung 

Um in einem Rechenzentrum Hochverfügbarkeit und Disaster-Recovery bereitzustellen, werden alle Daten in dreifacher
Ausführung auf drei verschiedenen physischen Servern in einem Cluster gespeichert. Falls verfügbar, können Sie Konten an mehreren Standorten
einrichten und dann eine fortlaufende Datenreplikation nutzen, um Hochverfügbarkeit und Disaster-Recovery rechnungszentrumsübergreifend bereitzustellen. {{site.data.keyword.cloudant_short_notm}}-Daten werden nicht automatisch gesichert; es werden jedoch unterstützte Tools zum Erstellen von Sicherungen bereitgestellt. Im
Leitfaden für [Disaster-Recovery und Sicherung![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://console.bluemix.net/docs/services/Cloudant/guides/disaster-recovery-and-backup.html#disaster-recovery-and-backup){:new_window}
finden Sie Informationen zu allen Aspekten von Hochverfügbarkeit, Disaster-Recovery und Sicherung, um die Anforderungen für Ihre Anwendung zu erfüllen.
