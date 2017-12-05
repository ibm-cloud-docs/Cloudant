---

copyright:
  years: 2015, 2017
lastupdated: "2017-08-25"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-03-16 -->

# Cloudant-Angebote

## Database as a Service

Cloudant ist eine gehostete und umfassend verwaltete Database as a Service (DBaaS).
Sie wurde von Grund auf neu erstellt für globale Skalierung, ununterbrochene Ausführung und die Bearbeitung einer großen Vielfalt an Datentypen wie [JSON](../basics/index.html#json)-,
[Volltext](../api/cloudant_query.html#creating-an-index)- und [geografisch-räumlichen](../api/cloudant-geo.html) Daten.
Cloudant ist ein Speicher für operative Daten, der optimiert wurde für die Bearbeitung von gleichzeitig ablaufenden Lese- und Schreiboperationen und der Hochverfügbarkeit und Datenpermanenz ermöglicht. 

Er bietet eine [HTTP-API](../basics/index.html#http-api) für die Arbeit mit Ihren [JSON](../basics/index.html#json)-Daten und 24-Stunden-Betriebsunterstützung sowie -Wartung.
Cloudant basiert auf [Apache CouchDB ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://couchdb.apache.org/){:new_window}
und wird in Form verschiedener dedizierter und installierter Multi-Tenant-Services bereitgestellt. 

>   **Hinweis**: Alle Währungswerte in diesem Dokument sind in US-Dollar ($) angegeben. 

Das Cloudant DBaaS-Angebot ist unter [https://cloudant.com/ ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://cloudant.com/){:new_window} abrufbar.
Das Angebot gibt es als [gemeinsam genutzten Plan](#shared-plan)
oder als [(dedizierten) Plan für Unternehmen](#enterprise-plan). 

Cloudant ist auch als [IBM Bluemix-Service](bluemix.html) verfügbar. 

>	**Hinweis:** Die Cloudant-Angebote [Gemeinsam genutzter Plan](#shared-plan) und [(Dedizierter) Plan für Unternehmen](#enterprise-plan) sind nicht im Rahmen des [IBM Bluemix-Service](bluemix.html) verfügbar. 

### Gemeinsam genutzter Plan

Mit dem gemeinsam genutzten Cloudant-Plan haben Sie Zugriff auf alle Cloudant DBaaS-Funktionen, die über einen gemeinsam genutzten bzw. einen Muli-Tenant-Cluster bereitgestellt werden. 

Der Preis ist abhängig von Ihrer monatlichen Nutzung.
Es werden keine Gebühren erhoben, wenn Ihre monatliche Nutzung unter 50,00 US-Dollar bleibt (Stand August 2016). 

Weitere Informationen finden Sie unter [Preisdetails ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://cloudant.com/product/pricing/){:new_window}. 

### Plan für Unternehmen

Mit dem Cloudant DBaaS-Plan für Unternehmen haben Sie Zugriff auf alle Cloudant DBaaS-Funktionen, die über einen dedizierten Single-Tenant-Cluster bereitgestellt werden. 

Dieser Plan sichert Ihnen Datenbankleistung und Verfügbarkeitszeit zu, indem dedizierte DBaaS-Clusters oder an verschiedenen Hostingstandorten verfügbare Hardware eingesetzt werden. 

Weitere Informationen finden Sie unter [Preisdetails ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://cloudant.com/product/pricing/){:new_window}. 

## Cloudant Local

[IBM Cloudant Data Layer Local Edition (Cloudant Local) ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/support/knowledgecenter/SSTPQH_1.0.0/com.ibm.cloudant.local.doc/SSTPQH_1.0.0_welcome.html){:new_window}
ist eine lokal installierte Version des Cloudant-Angebots Database as a Service (DBaaS). 

Cloudant Local bietet Ihnen dieselben grundlegenden Funktionen wie das umfassende Single-Tenant-Angebot von Cloudant,
wird aber in Ihrem eigenen Rechenzentrum gehostet. 

Eine detailliertere Übersicht über Cloudant Local ist
[verfügbar ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://www-01.ibm.com/support/knowledgecenter/SSTPQH_1.0.0/com.ibm.cloudant.local.install.doc/topics/clinstall_cloudant_local_overview.html?lang=en-us){:new_window}.
Das
[IBM Knowledge Center ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://www-01.ibm.com/support/knowledgecenter/SSTPQH_1.0.0/com.ibm.cloudant.local.doc/SSTPQH_1.0.0_welcome.html?lang=en){:new_window}
liefert Informationen zu vielen Aspekten von Cloudant Local,
darunter die folgenden: 

-   [Installation und Konfiguration ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://www.ibm.com/support/knowledgecenter/SSTPQH_1.0.0/com.ibm.cloudant.local.install.doc/topics/clinstall_extract_install_cloudant_local.html?lang=en){:new_window}. 
-   [Verwaltungstasks ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://www-01.ibm.com/support/knowledgecenter/SSTPQH_1.0.0/com.ibm.cloudant.local.install.doc/topics/clinstall_maintenance_tasks_overview.html?lang=en){:new_window}. 
-   [Replikationsparameter optimieren ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://www-01.ibm.com/support/knowledgecenter/SSTPQH_1.0.0/com.ibm.cloudant.local.install.doc/topics/clinstall_tuning_parameters_replication_cases.html?lang=en){:new_window}. 

## [Sicherheit](security.html)

Dank Datenzugriffssteuerungs-,
Verschlüsselungs- und
Datensicherungsfunktionen können Kunden im Bereich Finanzdienstleistungen,
Behörden, E-Commerce, Telekommunikation, Gesundheitswesen und anderen
sicherheitsorientierten Branchen von {{site.data.keyword.cloudantfull}} profitieren. 

## [Compliance](compliance.html)

{{site.data.keyword.cloudant_short_notm}} bietet ein vertrauenswürdiges und sicheres Clouddatenbanksystem.
Der Service basiert auf ausgezeichneten Branchenstandards,
darunter ISO 27001:2013. 

Weitere Details zu {{site.data.keyword.cloudant_short_notm}}-Datenschutz und -Governance [sind verfügbar](dataprivacygovernance.html). 
