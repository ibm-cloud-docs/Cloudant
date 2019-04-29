---

copyright:
  years: 2015, 2019
lastupdated: "2019-03-18"

keywords: hardware capacity, location, tenancy, security, encryption, compliance, high availability, disaster recovery, backup

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

# {{site.data.keyword.cloud_notm}} Dedicated
{: #ibm-cloud-dedicated}

{{site.data.keyword.cloudantfull}} für {{site.data.keyword.cloud}} Dedicated ist ein optionales kostenpflichtiges Add-on für eine {{site.data.keyword.cloud_notm}} Dedicated-Umgebung. Der Preis für das optionale Add-on für {{site.data.keyword.cloudant_short_notm}} Dedicated in {{site.data.keyword.cloud_notm}} Dedicated wird nach der Hardwarekapazität berechnet, die der Umgebung zugeordnet ist, und kann bei Ihrem zuständigen {{site.data.keyword.IBM}} Außendienstmitarbeiter bestellt werden.  
{: shortdesc}

{{site.data.keyword.cloud_notm}} Dedicated-Kunden haben außerdem die Möglichkeit, {{site.data.keyword.cloudant_short_notm}} in {{site.data.keyword.cloud_notm}} Public einschließlich der Lite-Plan- und Standard-Plan-Instanzen über den syndizierten Katalog zu verwenden. Dabei ist zu beachten, dass {{site.data.keyword.cloud_notm}} Dedicated-Benutzer den Plan für dedizierte Hardware aus dem {{site.data.keyword.cloud_notm}} Public-Katalog nicht bestellen können. Diese Benutzer sollten {{site.data.keyword.cloudant_short_notm}} Dedicated unter {{site.data.keyword.cloud_notm}} Dedicated nutzen, sofern dedizierte Hardware erforderlich ist.   

Der nachfolgende Screenshot zeigt ein Beispiel für einen {{site.data.keyword.cloud_notm}}-Katalog, in dem
die syndizierte {{site.data.keyword.cloud_notm}} Public-Version von {{site.data.keyword.cloudant_short_notm}} (links)
und die {{site.data.keyword.cloudant_short_notm}} Dedicated-Umgebung (rechts) hervorgehoben ist.  

![{{site.data.keyword.cloudant_short_notm}}-Katalog](../images/bluemix_catalog.png)

## Hardwarekapazität 
{: #hardware-capacity}

{{site.data.keyword.cloudant_short_notm}} in {{site.data.keyword.cloud_notm}} Dedicated wird mithilfe eines Teils
'{{site.data.keyword.cloud_notm}} Dedicated
{{site.data.keyword.cloudant_short_notm}} 1.6 TB Capacity' erworben, das eine {{site.data.keyword.cloudant_short_notm}}-Clusterumgebung
mit drei Datenbankknoten und zwei Load Balancers (Lastausgleichsfunktionen) beinhaltet. Jeder Datenbankknoten enthält
1,6 TB Speicherplatz auf SSD-Festplatten. Da alle Daten dreifach gespeichert werden, entspricht dies
einem eindeutigen Plattenspeicherplatz von 1,6 TB für den gesamten Cluster. Zum Erweitern der Umgebung können zusätzliche Teile '{{site.data.keyword.cloud_notm}} Dedicated
{{site.data.keyword.cloudant_short_notm}} 1.6 TB Capacity' gekauft werden, die den
{{site.data.keyword.cloudant_short_notm}}-Cluster jeweils um drei weitere Datenbankknoten
erweitern. Die Kunden können sich anstelle einer einzelnen Umgebung auch für mehrere
separate {{site.data.keyword.cloudant_short_notm}}-Umgebungen entscheiden.

## Positionen und Tenants in einer dedizierten Umgebung
{: #locations-and-tenancy-in-a-dedicated-environment}

Die {{site.data.keyword.cloudant_short_notm}} Dedicated-Umgebung innerhalb einer {{site.data.keyword.cloud_notm}} Dedicated-Umgebung nutzt dedizierte Hardware, die ausschließlich dem betreffenden {{site.data.keyword.cloud_notm}} Dedicated-Kunden zur Verfügung steht. Der Kunde kann in der jeweiligen Umgebung eine oder mehrere Instanzen von
{{site.data.keyword.cloudant_short_notm}} bereitstellen. Dabei nutzt jede Instanz von {{site.data.keyword.cloudant_short_notm}}
die zugrunde liegenden Hardwareressourcen, aus denen die {{site.data.keyword.cloudant_short_notm}}-Umgebung besteht. 

## Sicherheit, Verschlüsselung und Compliance 
{: #security-encryption-and-compliance}

Alle Pläne werden auf Servern mit einer Verschlüsselung gespeicherter Daten vom Typ [at-rest ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://en.wikipedia.org/wiki/Data_at_rest)
bereitgestellt. Der Zugriff erfolgt über die öffentliche Netzverbindung mit Verschlüsselung über HTTPS. Weitere Details finden Sie unter [Sicherheit ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](/docs/services/Cloudant?topic=cloudant-security#security){: new_window}. 
IP-Whitelisting ist auf Anfrage beim {{site.data.keyword.cloudant_short_notm}}-Support erhältlich und gilt für
die gesamte {{site.data.keyword.cloudant_short_notm}}-Umgebung (d. h., nicht auf Instanzebene).  

Der Plan bietet auch die [Zertifizierung der Einhaltung von Sicherheitsbestimmungen ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](/docs/services/Cloudant?topic=cloudant-compliance#compliance){: new_window}. 

Compliance mit [HIPAA ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){: new_window}
wird auf Anforderung zur Verfügung gestellt; fordern Sie diese Compliance daher als Teil des Kaufprozesses bei einem {{site.data.keyword.IBM_notm}} Vertriebsbeauftragten an. 

## Hochverfügbarkeit, Disaster-Recovery und Sicherung 
{: #high-availability-disaster-recovery-and-backup}

Um in einem Rechenzentrum Hochverfügbarkeit und Disaster-Recovery bereitzustellen, werden alle Daten in dreifacher
Ausführung auf drei verschiedenen physischen Servern in einem Cluster gespeichert. Falls verfügbar, können Sie Konten an mehreren Standorten
einrichten und dann eine fortlaufende Datenreplikation nutzen, um Hochverfügbarkeit und Disaster-Recovery rechnungszentrumsübergreifend bereitzustellen. {{site.data.keyword.cloudant_short_notm}}-Daten werden nicht automatisch gesichert; es werden jedoch unterstützte Tools zum Erstellen von Sicherungen bereitgestellt. Im
Leitfaden für [Disaster-Recovery und Sicherung![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](/docs/services/Cloudant?topic=cloudant-disaster-recovery-and-backup#disaster-recovery-and-backup){: new_window}
finden Sie Informationen zu allen Aspekten von Hochverfügbarkeit, Disaster-Recovery und Sicherung, um die Anforderungen für Ihre Anwendung zu erfüllen.
