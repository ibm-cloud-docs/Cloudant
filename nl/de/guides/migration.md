---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: curl and jq basics, monitor view builds and search indexes, estimate time to complete task, monitor replication, troubleshooting

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

<!-- Acrolinx: 2018-08-14 -->

# Migration auf {{site.data.keyword.cloudant_short_notm}} unter {{site.data.keyword.cloud_notm}} durchführen
{: #migrating-to-ibm-cloudant-on-ibm-cloud}

Das DBaaS-Angebot (Database as a Service) von [{{site.data.keyword.cloudantfull}} ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/cloud/cloudant){: new_window} bietet einen JSON-Dokumentspeicher, der in Multi-Tenant-Clustern ausgeführt wird. Der Service steht für eine Vielzahl von Standorten zur Verfügung und zeichnet sich durch kalkulierbare Kosten, gute Skalierbarkeit und ein Service-Level-Agreement (SLA) aus.

Im vorliegenden Dokument wird beschrieben, wie die Migration von einem der folgenden Pläne auf eine Instanz eines {{site.data.keyword.cloudant_short_notm}}-Lite-Plans oder -Standard-Plans unter {{site.data.keyword.cloud_notm}} durchgeführt wird:

Plan | Beschreibung
-----|------------
{{site.data.keyword.cloudant_short_notm}} Enterprise | Dedizierte Single-Tenant-Cluster.
{{site.data.keyword.cloudant_short_notm}}-Plan für gemeinsame Nutzung | Ein traditioneller nutzungsabhängiger {{site.data.keyword.cloudant_short_notm}}-Multi-Tenant-Service. Der `cloudant.com`-Plan für gemeinsame Nutzung wurde im März 2018 vom Vertrieb zurückgezogen. Der {{site.data.keyword.cloudant_short_notm}}-Plan für gemeinsame Nutzung wird seit Oktober 2016 nicht mehr zur Durchführung neuer Anmeldungen unterstützt und wird im vierten Quartal 2018 vom Vertrieb zurückgezogen.
{{site.data.keyword.cloudant_localfull}} | Die Selbsthosting-Paketinstallation von {{site.data.keyword.cloudant_short_notm}}.
Apache CouchDB | Die Selbsthosting-Open-Source-Datenbank, auf der {{site.data.keyword.cloudant_short_notm}} basiert.

## Welche Vorteile bieten der {{site.data.keyword.cloudant_short_notm}}-Lite-Plan und -Standard-Plan?
{: #what-are-the-benefits-of-the-ibm-cloudant-lite-and-standard-plans-}

Der Standard-Plan ermöglicht Ihnen die *Reservierung von Durchsatzkapazität* für Ihren Datenbankservice. Dies bedeutet, dass Sie angeben können, welches Durchsatzvolumen Ihre Anwendungsdatenbank benötigt, um den Anforderungen Ihres Systems gerecht zu werden. Der Standard-Plan berechnet auch die Menge an Speicher, die Sie verwenden. Die Kapazität wird mithilfe der folgenden Metriken gemessen:

Metrik | Beschreibung
-------|------------
Lesevorgänge pro Sekunde | Die Geschwindigkeit, mit der einfache Dokumentabrufoperationen ausgeführt werden, z. B. das Abrufen eines Dokuments anhand seiner ID (`_id`) oder Abfragen in einer partitionierten Datenbank anhand eines Partitionsschlüssels.
Schreibvorgänge pro Sekunde | Die Geschwindigkeit, mit der Daten in die Datenbank geschrieben werden. Als Schreibvorgänge zählen API-Aufrufe, die zur Dokumenterstellung, zur Dokumentaktualisierung oder Dokumentlöschung dienen.
Globale Abfragen pro Sekunde | Die Geschwindigkeit, mit der die Datenbank mithilfe globaler Indizes abgefragt wird. Dazu greifen Sie normalerweise auf den Endpunkt `_find` zu oder verwenden sekundäre MapReduce-, Such- oder georäumliche Indizes.
Speicher | Die Menge an Plattenspeicherplatz, die von Ihren JSON-Daten sowie den entsprechenden Anhängen und sekundären Indizes belegt wird.

Der Lite-Plan stellt zum Beispiel 20 Lesevorgänge pro Sekunde, 10 Schreibvorgänge pro Sekunde, 5 globale Abfragen pro Sekunde und 1 GB Speicher kostenlos zur Verfügung. Dieser Plan eignet sich ideal, wenn Sie das Produkt auf seine Tauglichkeit für Ihre Zwecke prüfen wollen oder auch in der Produktentwicklungsphase. Wenn Ihre Anwendung die Phase der Qualitätssicherung oder die Produktionsreife erreicht, müssen Sie auf den Standard-Plan umstellen, um die Instanz zu skalieren. Die geringste Kapazität des Standard-Plans umfasst 100 Lesevorgänge pro Sekunde, 50 Schreibvorgänge pro Sekunde, 5 globale Abfragen pro Sekunde und 20 GB Speicher (zusätzlicher Speicher wird pro GB abgerechnet). Die Kosten belaufen sich auf 76,65 US-Dollar pro Monat. 

Mithilfe des Schiebereglers im {{site.data.keyword.cloudant_short_notm}}-Dashboard können Sie eine geringere oder höhere Kapazität für Ihren {{site.data.keyword.cloudant_short_notm}}-Service reservieren, wenn dies erforderlich wird:

![Schieberegler](../images/migrate2.gif)

Der Betrag, um den Sie die Durchsatzkapazität ändern können, ist auf maximal 10 Einheiten pro Änderung beschränkt (siehe hierzu den Punkt für das Änderungslimit auf dem Schieberegler), wobei pro Stunde maximal eine Änderung durchgeführt werden kann. Reduzierungen unterliegen keiner Größenbeschränkung, allerdings muss ein bestimmtes Zeitlimit beachtet werden.
{: tip}

Ihnen wird die höchste Kapazität berechnet, die innerhalb eines Zeitfensters von einer Stunde ausgewählt wird. Ihr Datenbankdurchsatz kann nach oben skaliert werden, um saisonale Bedarfsspitzen abzufangen. Ebenso kann der Datenbankdurchsatz in Zeiten geringerer Auslastung nach unten skaliert werden. Ihre monatliche Rechnung bleibt jedoch jederzeit kalkulierbar. Upgrades werden automatisch durchgeführt und Ihr SLA definiert einen Wert von [99,95% ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://www-03.ibm.com/software/sla/sladb.nsf/sla/bm?OpenDocument){: new_window}.


Wenn Sie Ihr Kontingent an Suchvorgängen, Schreibvorgängen und globalen Abfragen pro Sekunde überschreiten, reagiert die {{site.data.keyword.cloudant_short_notm}}-API mit einer Antwort des Typs `HTTP 429 too many requests` (zu viele Anforderungen). Möglicherweise wiederholt Ihre Anwendung die Anforderung zu einem späteren Zeitpunkt. In den offiziellen Bibliotheken steht eine Option zur Wiederholung solcher Anforderungen mit einer exponentiellen Aussetzung zur Verfügung. 

## Welchen {{site.data.keyword.cloudant_short_notm}}-Plan verwende ich?
{: #which-type-of-ibm-cloudant-plan-do-i-have-}

Wenn Sie {{site.data.keyword.cloudant_short_notm}} verwenden, rufen Sie das {{site.data.keyword.cloud_notm}}-Dashboard auf und klicken Sie auf **Menüsymbol** > **Ressourcenliste**, um alle Serviceinstanzen anzuzeigen. 

![Cloud-Dash](../images/ibmclouddashboard.png)

Sie können auch eine Drilldown-Operation für eine bestimmte Instanz ausführen und die Registerkarte 'Plan' aufrufen, um weitere Informationen anzuzeigen. {{site.data.keyword.cloudant_short_notm}}-Instanzen mit dem veralteten gemeinsam genutzten Plan verfügen nicht über einen hervorgehobenen Plan. Eine Instanz für den {{site.data.keyword.cloudant_short_notm}}-Standard-Plan wird wie folgt dargestellt: 

![Standard-Dash](../images/ibmcloud_instance_standard_plan.png)

Sie können auch das {{site.data.keyword.cloudant_short_notm}}-Dashboard öffnen und auf die Registerkarte **Konto** klicken. Im folgenden Beispiel wird ein Lite-Plan dargestellt:

![Lite-Plan](../images/migrate1.png)

Wenn Sie mit einem traditionellen `cloudant.com`-Konto arbeiten, können Sie sich beim {{site.data.keyword.cloudant_short_notm}}-Dashboard anmelden und die Registerkarte 'Konto' aufrufen. Ein traditioneller gemeinsam genutzter `cloudant.com`-Plan verfügt über eine Registerkarte 'Nutzung' mit Diagrammen und den geschätzten Abrechnungskosten für den aktuellen Monat. Im Folgenden ist ein Beispiel aufgeführt:

![Gemeinsam genutzter Plan](../images/cloudantcom_sharedplan_usage.png)

Ein `cloudant.com`-Unternehmensbenutzer in einem dedizierten Cluster verfügt auf der Registerkarte 'Konto' nicht über die Registerkarte 'Nutzung'. Im Folgenden ist ein Beispiel aufgeführt:

![Plan für Unternehmen](../images/cloudantcom_enterpriseplan_account.png)

Wenn die Registerkarte 'Konto' bereits anzeigt, dass Sie mit dem Standard-Plan arbeiten, dann müssen Sie die restlichen Informationen nicht lesen. Sie arbeiten bereits mit einem gebührenpflichtigen {{site.data.keyword.cloudant_short_notm}}-Service, der auf einer SLA-Vereinbarung (Service Level Agreement) basiert. Es ist keine weitere Aktion erforderlich.

## Migration von {{site.data.keyword.cloudant_short_notm}} Lite auf {{site.data.keyword.cloudant_short_notm}} Standard durchführen
{: #migrating-from-ibm-cloudant-lite-to-ibm-cloudant-standard}

Führen Sie die folgenden Schritte aus, um eine Migration vom kostenlosen Lite-Plan zum Standard-Plan durchzuführen: 

1.  Rufen Sie das {{site.data.keyword.cloud_notm}}-Dashboard auf.
2.  Navigieren Sie zu **Menüsymbol** > **Ressourcenliste**, um alle Serviceinstanzen anzuzeigen. 
3.  Wählen Sie die {{site.data.keyword.cloudant_short_notm}}-Instanz aus, die migriert werden soll. 
4.  Wählen Sie die Registerkarte **Plan** im Menü aus.  
5.  Wählen Sie in der Liste der Preisstrukturpläne das Kontrollkästchen **Standard** aus.
![Lite](../images/migrate3.png)
6.  Klicken Sie auf **Upgrade**.
Alle vorhandenen Daten werden für Sie aufbewahrt.

Passen Sie Ihre Kapazität mithilfe des Schiebereglers für die Durchsatzkapazität an, um die Kapazität abhängig von Ihrem individuellen Bedarf zu erhöhen oder zu reduzieren.
{: tip} 
 
Nun haben Sie alle Vorbereitungen abgeschlossen!

## Migration aller anderen Komponenten auf den {{site.data.keyword.cloudant_short_notm}}-Lite-Plan oder -Standard-Plan durchführen
{: #migrating-everything-else-to-ibm-cloudant-lite-or-standard-plan}

Die Migration von gemeinsam genutzten Plänen oder Plänen für Unternehmen auf einen {{site.data.keyword.cloudant_short_notm}}-Lite-Plan oder -Standard-Plan umfasst die folgenden Tasks, die in den hier aufgeführten Schritten beschrieben werden. 

Eine Instanz für einen gemeinsam genutzten Plan kann nicht direkt in eine Lite-Plan- oder Standard-Plan-Instanz geändert werden. Zur Migration müssen Sie eine neue Lite-Plan- oder Standard-Plan-Instanz erstellen und die Daten der Instanz für den gemeinsam genutzten Plan auf die neue Instanz replizieren. 
{: tip}

### Schritt 1: Anmeldung bei {{site.data.keyword.cloud_notm}} durchführen
{: #step-1-sign-up-for-ibm-cloud}

Wenn Sie sich noch nicht angemeldet haben, dann führen Sie nun die [Anmeldung für ein {{site.data.keyword.cloud_notm}}-Konto ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/cloud/){: new_window} durch.  

### Schritt 2: {{site.data.keyword.cloudant_short_notm}}-Instanz erstellen
{: #step-2-create-an-ibm-cloudant-instance}

Nach der Anmeldung bei Ihrem {{site.data.keyword.cloud_notm}}-Konto müssen Sie einen {{site.data.keyword.cloudant_short_notm}}-Service hinzufügen. Klicken Sie auf die Schaltfläche `Ressource erstellen` im Dashboard und dann auf `Datenbanken` und `Cloudant`. Weitere Informationen hierzu finden Sie im Abschnitt mit der [Vorgehensweise zum Erstellen einer {{site.data.keyword.cloudant_short_notm}}-Instanz unter {{site.data.keyword.cloud_notm}}](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-an-ibm-cloudant-instance-on-ibm-cloud). 

![Hinzufügen einer {{site.data.keyword.cloudant_short_notm}}-Instanz](../tutorials/images/img0003.png)

### Schritt 3: Bereitschaft Ihrer Anwendung für {{site.data.keyword.cloudant_short_notm}} ermitteln
{: #step-3-find-out-whether-your-application-is-ready-for-ibm-cloudant}

Wenn Sie eine Umstellung von einem {{site.data.keyword.cloudant_short_notm}} Enterprise-Service oder einem gemeinsam genutzten {{site.data.keyword.cloudant_short_notm}}-Plan durchführen wollen, dann müssen Sie nochmals die Nutzungsdaten Ihrer Anwendung für {{site.data.keyword.cloudant_short_notm}} aufrufen, um sicherzustellen, dass die Anwendung bereit zum Arbeiten mit den Kapazitätslimits des Standard-Plans ist. Weitere Informationen hierzu finden Sie im Abschnitt zur [Funktionsweise der {{site.data.keyword.cloudant_short_notm}}-API](/docs/services/Cloudant?topic=cloudant-ibm-cloud-public#provisioned-throughput-capacity). Insbesondere müssen Sie sich vergewissern, dass Ihre Anwendung eine HTTP-Antwort vom Typ
`429: Zu viele Anforderungen` verarbeiten kann, wenn Ihre bereitgestellte Durchsatzkapazität überschritten wird. 

Die Wiederholung von Anforderungen, auf die eine Antwort vom Typ `429` ausgegeben wurde, ist im Fall gelegentlicher Datenverkehrsspitzen akzeptabel, die die Kapazität Ihres Plans überschreiten. Wenn der Anwendungsdatenverkehr regelmäßig zur Generierung von Antworten des Typs `429` führt, besteht eine hohe Wahrscheinlichkeit, dass Sie ein Upgrade auf einen größeren Plan durchführen müssen.

Außerdem sollten Sie beachten, dass die maximale Einzeldokumentgröße unter {{site.data.keyword.cloudant_short_notm}} 1 MB beträgt und dass Sie eine Nachricht vom Typ
`413: Anforderungsentität zu groß` erhalten, wenn das Limit überschritten wird. Weitere Informationen hierzu finden Sie im Abschnitt zur [Größenbegrenzung für Anforderungen und Dokumente](/docs/services/Cloudant?topic=cloudant-ibm-cloud-public#request-and-document-size-limits). 

### Schritt 4: Daten vom alten auf den neuen Service migrieren 
{: #step-4-migrate-data-from-the-old-service-to-the-new-service}

Richten Sie die fortlaufende Replikation vom vorhandenen Service auf Ihr {{site.data.keyword.cloudant_short_notm}}-Konto ein. Weitere Informationen zur Vorgehensweise beim Einrichten und Überwachen von Replikationstasks finden Sie im [Leitfaden zur Replikation](/docs/services/Cloudant?topic=cloudant-replication-api#replication-api) und in der [API-Dokumentation](/docs/services/Cloudant?topic=cloudant-ibm-cloudant-basics#ibm-cloudant-basics).

Alternativ hierzu können Sie sich auch mit dem Tool [`couchreplicate`](https://www.npmjs.com/package/couchreplicate) vertraut machen. Hierbei handelt es sich um ein Befehlszeilendienstprogramm, das die Koordinierung der Datenübertragung von einem {{site.data.keyword.cloudant_short_notm}}-Konto auf ein anderes vereinfacht. Es dient zur Einrichtung mehrerer Replikationsjobs zwischen dem Quellen- und dem Zielkonto und stellt sicher, dass nur eine geeignete Anzahl von Replikationsjobs gleichzeitig ausgeführt werden. Wenn Sie Hunderte von Datenbanken replizieren müssen, dann erleichtert `couchreplicate` die Koordination der Replikationsjobs.

![`couchreplicate`](https://raw.githubusercontent.com/glynnbird/couchreplicate/HEAD/img/couchreplicate.gif)

Überprüfen Sie, ob alle Daten auf den neuen Service repliziert werden und dass die Indizes erstellt werden.

### Schritt 5: Erforderliche Tests durchführen
{: #step-5-testing}

Führen Sie Lade- und Funktionstests für Ihre Anwendung durch, um vor der Migration auf die Produktionsumgebung sicherzustellen, dass keine Probleme vorliegen.

### Schritt 6: Sind Sie bereit zur Umstellung auf die neue Instanz?
{: #step-6-ready-to-move-to-the-new-instance-}

Wenn Sie zum Umstellen auf die neue Instanz bereit sind, aktualisieren Sie Ihre Anwendung, damit die neue Konto-URL und die neuen Berechtigungsnachweise für die {{site.data.keyword.cloudant_short_notm}}-Instanz verwendet werden. Weitere Informationen zur Vorgehensweise beim Abrufen der Serviceberechtigungsnachweise für eine {{site.data.keyword.cloudant_short_notm}}-Instanz finden Sie im [Bereitstellungslernprogramm](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-an-ibm-cloudant-instance-on-ibm-cloud).

### Schritt 7: Alten Service inaktivieren
{: #step-7-turn-off-the-old-service}

 Nachdem Ihre Anwendung vollständig auf die {{site.data.keyword.cloudant_short_notm}}-Lite-Instanz oder -Standard-Instanz migriert wurde, können Sie die alte Instanz für den {{site.data.keyword.cloudant_short_notm}}-Plan für gemeinsame Nutzung über die {{site.data.keyword.cloud_notm}}-Konsole löschen, um sicherzustellen, dass Ihnen dieser Service nicht weiter in Rechnung gestellt wird.

## FAQs - Häufig gestellte Fragen
{: #faq-frequently-asked-questions}

Die häufig gestellte Fragen (FAQs = Frequently Asked Questions) werden von der {{site.data.keyword.cloudant_short_notm}}-Organisation veröffentlicht, um {{site.data.keyword.IBM_notm}}-Kunden die Migration auf eine {{site.data.keyword.cloudant_short_notm}}-Lite-Plan-Instanz oder -Standard-Plan-Instanz unter
{{site.data.keyword.cloud_notm}} zu erleichtern.

## Kann ich meine Daten vorab sichern?
{: #can-i-back-up-my-data-before-doing-anything-}

{{site.data.keyword.cloudant_short_notm}} empfiehlt die Verwendung des Dienstprogramms [couchbackup](/docs/services/Cloudant?topic=cloudant-ibm-cloudant-backup-and-recovery#ibm-cloudant-backup-and-recovery), um Daten auf die Platte zu
exportieren. [{{site.data.keyword.cloud_notm}}-Objektspeicher ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/cloud/object-storage){: new_window} ist eine kosteneffiziente, skalierbare Lösung zum Speichern der exportierten Dateien.  

## Kann ich meine `username.cloudant.com`-Domäne beibehalten und auf den neuen Service unter {{site.data.keyword.cloudant_short_notm}} umleiten?
{: #can-i-keep-my-username-cloudant-com-domain-and-redirect-it-to-the-new-service-on-ibm-cloudant-}

Nein, es ist nicht möglich, Ihre Domäne beizubehalten. Sie müssen die Aktualisierung Ihrer Anwendungen zur Verwendung der neuen Konto-URL und der entsprechenden Berechtigungsnachweise einplanen, die für die {{site.data.keyword.cloudant_short_notm}}-Instanzen generiert werden.

## Wenn kann ich kontaktieren, wenn ich Fragen habe?
{: #who-do-i-contact-if-i-have-questions-}

Wenden Sie sich an den [{{site.data.keyword.cloudant_short_notm}}-Support](mailto:support@cloudant.com) oder öffnen Sie ein Ticket im {{site.data.keyword.cloudant_short_notm}}-Dashboard, wenn Sie Fragen zur Migration haben. Der {{site.data.keyword.cloudant_short_notm}}-Support stellt Ihnen gerne weitere Einzelheiten zur Verfügung.
