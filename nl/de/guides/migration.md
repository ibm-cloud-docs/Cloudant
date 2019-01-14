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

<!-- Acrolinx: 2018-08-14 -->

# Migration auf {{site.data.keyword.cloudant_short_notm}} unter {{site.data.keyword.cloud_notm}} durchführen
 
Das DBaaS-Angebot (Database as a Service) von [{{site.data.keyword.cloudantfull}}](https://www.ibm.com/cloud/cloudant) bietet einen JSON-Dokumentspeicher, der in Multi-Tenant-Clustern ausgeführt wird. Der Service steht für eine Vielzahl von Standorten zur Verfügung und zeichnet sich durch kalkulierbare Kosten, gute Skalierbarkeit und ein Service-Level-Agreement (SLA) aus.

Im vorliegenden Dokument wird beschrieben, wie die Migration von einem der folgenden Pläne auf eine Instanz eines {{site.data.keyword.cloudant_short_notm}}-Lite-Plans oder -Standard-Plans unter {{site.data.keyword.cloud_notm}} durchgeführt wird:

Plan | Beschreibung
-----|------------
{{site.data.keyword.cloudant_short_notm}} Enterprise | Dedizierte Single-Tenant-Cluster.
{{site.data.keyword.cloudant_short_notm}}-Plan für gemeinsame Nutzung | Ein traditioneller nutzungsabhängiger {{site.data.keyword.cloudant_short_notm}}-Multi-Tenant-Service. Der `cloudant.com`-Plan für gemeinsame Nutzung wurde im März 2018 vom Vertrieb zurückgezogen. Der {{site.data.keyword.cloudant_short_notm}}-Plan für gemeinsame Nutzung wird seit Oktober 2016 nicht mehr zur Durchführung neuer Anmeldungen unterstützt und wird im vierten Quartal 2018 vom Vertrieb zurückgezogen.
{{site.data.keyword.cloudant_localfull}} | Die Selbsthosting-Paketinstallation von {{site.data.keyword.cloudant_short_notm}}.
Apache CouchDB | Die Selbsthosting-Open-Source-Datenbank, auf der {{site.data.keyword.cloudant_short_notm}} basiert.

## Welche Vorteile bieten der {{site.data.keyword.cloudant_short_notm}}-Lite-Plan und -Standard-Plan?

Der Standard-Plan ermöglicht Ihnen die *Reservierung von Durchsatzkapazität* für Ihren Datenbankservice. Dies bedeutet, dass Sie angeben können, welches Durchsatzvolumen Ihre Anwendungsdatenbank benötigt, um den Anforderungen Ihres Systems gerecht zu werden. Der Standard-Plan berechnet auch die Menge an Speicher, die Sie verwenden. Die Kapazität wird mithilfe der folgenden Metriken gemessen:

Metrik | Beschreibung
-------|------------
Suchvorgänge pro Sekunde | Die Geschwindigkeit, mit der einfache Dokumentabrufoperationen ausgeführt werden, z. B. das Abrufen eines Dokuments anhand seiner ID (`_id`).
Schreibvorgänge pro Sekunde | Die Geschwindigkeit, mit der Daten in die Datenbank geschrieben werden. Als Schreibvorgänge zählen API-Aufrufe, die zur Dokumenterstellung, zur Dokumentaktualisierung oder Dokumentlöschung dienen.
Abfragen pro Sekunde |Die Geschwindigkeit, mit der die Datenbank abgefragt wird. Dazu greifen Sie normalerweise auf den Endpunkt `_find` zu oder verwenden die sekundären
MapReduce-Indizes.
Speicher | Die Menge an Plattenspeicherplatz, die von Ihren JSON-Daten sowie den entsprechenden Anhängen und sekundären Indizes belegt wird.

Der Lite-Plan bietet z. B. 20 Suchvorgänge pro Sekunde, 10 Schreibvorgänge pro Sekunde, 5 Abfragen pro Sekunde und 1 GB kostenlosen Speicher. Dieser Plan eignet sich ideal, wenn Sie das Produkt auf seine Tauglichkeit für Ihre Zwecke prüfen wollen oder auch in der Produktentwicklungsphase. Wenn Ihre Anwendung Produktionsreife erreicht, dann müssen Sie auf den Standard-Plan umstellen. Das kleinste Paket des Standard-Plans besteht aus 100 Suchvorgängen pro Sekunde, 50 Schreibvorgängen pro Sekunde, 5 Abfragen pro Sekunde sowie 20 GB an Speicher (zusätzlicher Speicher wird pro GB berechnet). Die Kosten belaufen sich auf ca. 76,65 USD pro Monat. 

Mithilfe des Schiebereglers im {{site.data.keyword.cloudant_short_notm}}-Dashboard können Sie eine geringere oder höhere Kapazität für Ihren {{site.data.keyword.cloudant_short_notm}}-Service reservieren, wenn dies erforderlich wird:

![Schieberegler](../images/migrate2.gif)

Der Betrag, um den Sie die Durchsatzkapazität ändern können, ist auf maximal 10 Einheiten pro Änderung beschränkt (siehe hierzu den Punkt für das Änderungslimit auf dem Schieberegler), wobei pro Stunde maximal eine Änderung durchgeführt werden kann. Reduzierungen unterliegen keiner Größenbeschränkung, allerdings muss ein bestimmtes Zeitlimit beachtet werden.
{: tip}

Ihnen wird die höchste Kapazität berechnet, die innerhalb eines Zeitfensters von einer Stunde ausgewählt wird. Ihr Datenbankdurchsatz kann nach oben skaliert werden, um saisonale Bedarfsspitzen abzufangen. Ebenso kann der Datenbankdurchsatz in Zeiten geringerer Auslastung nach unten skaliert werden. Ihre monatliche Rechnung bleibt jedoch jederzeit kalkulierbar. Upgrades werden automatisch durchgeführt und Ihr SLA definiert einen Wert von [99,95%](http://www-03.ibm.com/software/sla/sladb.nsf/sla/bm-6627-03).

Wenn Sie Ihr Kontingent an Suchvorgängen, Schreibvorgängen und Abfragen pro Sekunde überschreiten, dann reagiert der {{site.data.keyword.cloudant_short_notm}}-Cluster mit einer Antwort des Typs `HTTP 429`. Möglicherweise wiederholt Ihre Anwendung die Anforderung zu einem späteren Zeitpunkt. In den offiziellen Bibliotheken steht eine Option zur Wiederholung solcher Anforderungen mit einer exponentiellen Aussetzung zur Verfügung. 

## Welchen {{site.data.keyword.cloudant_short_notm}}-Plan verwende ich?

Wenn Sie mit {{site.data.keyword.cloudant_short_notm}} arbeiten, dann werden im {{site.data.keyword.cloud_notm}}-Dashboard alle {{site.data.keyword.cloudant_short_notm}}-Instanzen sowie eine Spalte für den jeweiligen Plan angezeigt. Der Lite-Plan, der Standard-Plan und der Plan für dedizierte Hardware werden speziell ausgewiesen. Jede {{site.data.keyword.cloudant_short_notm}}-Instanz, für die der Name des gemeinsam genutzten dedizierten Plans angegeben ist, ist Teil einer dedizierten {{site.data.keyword.cloudant_short_notm}}-Umgebung und nicht Teil des öffentlichen gemeinsam genutzten Plans. Jede {{site.data.keyword.cloudant_short_notm}}-Instanz, für die in dieser Spalte ein Name eines gemeinsam genutzten Plans angegeben ist oder für die dort kein Planname angegeben wurde, verwendet den veralteten gemeinsam genutzten Plan. Im folgenden Beispiel verwenden die Instanzen 'Cloudant NoSQL DB-ix' und 'Cloudant_NewConsole' einen veralteten gemeinsam genutzten Plan.  

![Cloud-Dash](../images/ibmclouddashboard.png)

Sie können auch eine Drilldown-Operation in eine bestimmte Instanz durchführen und die Registerkarte 'Plan' aufrufen. {{site.data.keyword.cloudant_short_notm}}-Instanzen mit dem veralteten gemeinsam genutzten Plan verfügen nicht über einen hervorgehobenen Plan. Eine Instanz für den {{site.data.keyword.cloudant_short_notm}}-Standard-Plan wird wie folgt dargestellt: 

![Standard-Dash](../images/ibmcloud_instance_standard_plan.png)

Sie können auch das {{site.data.keyword.cloudant_short_notm}}-Dashboard öffnen und auf die Registerkarte **Konto** klicken. Im folgenden Beispiel wird ein Lite-Plan dargestellt:

![Lite-Plan](../images/migrate1.png)

Wenn Sie mit einem traditionellen `cloudant.com`-Konto arbeiten, können Sie sich beim {{site.data.keyword.cloudant_short_notm}}-Dashboard anmelden und die Registerkarte 'Konto' aufrufen. Ein traditioneller gemeinsam genutzter `cloudant.com`-Plan verfügt über eine Registerkarte 'Nutzung' mit Diagrammen und den geschätzten Abrechnungskosten für den aktuellen Monat. Im Folgenden ist ein Beispiel aufgeführt:

![Gemeinsam genutzter Plan](../images/cloudantcom_sharedplan_usage.png)

Ein `cloudant.com`-Unternehmensbenutzer in einem dedizierten Cluster verfügt auf der Registerkarte 'Konto' nicht über die Registerkarte 'Nutzung'. Im Folgenden ist ein Beispiel aufgeführt:

![Plan für Unternehmen](../images/cloudantcom_enterpriseplan_account.png)

Wenn die Registerkarte 'Konto' bereits anzeigt, dass Sie mit dem Standard-Plan arbeiten, dann müssen Sie die restlichen Informationen nicht lesen. Sie arbeiten bereits mit einem gebührenpflichtigen {{site.data.keyword.cloudant_short_notm}}-Service, der auf einer SLA-Vereinbarung (Service Level Agreement) basiert. Es ist keine weitere Aktion erforderlich.

## Migration von {{site.data.keyword.cloudant_short_notm}} Lite auf {{site.data.keyword.cloudant_short_notm}} Standard durchführen

Führen Sie die folgenden Schritte aus, um eine Migration vom kostenlosen Lite-Plan zum Standard-Plan durchzuführen: 

1.  Rufen Sie das {{site.data.keyword.cloud_notm}}-Dashboard auf.
2.  Wählen Sie die {{site.data.keyword.cloudant_short_notm}}-Instanz aus, die migriert werden soll. 
3.  Wählen Sie die Registerkarte **Plan** in der linken Navigation aus. 
4.  Wählen Sie in der Liste der Preisstrukturpläne das Kontrollkästchen **Standard** aus.
![Lite](../images/migrate3.png)
5.  Klicken Sie unten auf der Seite auf **Upgrade**.
Alle vorhandenen Daten werden für Sie aufbewahrt.

Passen Sie Ihre Kapazität mithilfe des Schiebereglers für die Durchsatzkapazität an, um die Kapazität abhängig von Ihrem individuellen Bedarf zu erhöhen oder zu reduzieren.
{: tip} 
 
Nun haben Sie alle Vorbereitungen abgeschlossen!

## Migration aller anderen Komponenten auf den {{site.data.keyword.cloudant_short_notm}}-Lite-Plan oder -Standard-Plan durchführen

Die Migration von gemeinsam genutzten Plänen oder Plänen für Unternehmen auf einen {{site.data.keyword.cloudant_short_notm}}-Lite-Plan oder -Standard-Plan umfasst die folgenden Tasks, die in den hier aufgeführten Schritten beschrieben werden. 

Eine Instanz für einen gemeinsam genutzten Plan kann nicht direkt in eine Lite-Plan- oder Standard-Plan-Instanz geändert werden. Zur Migration müssen Sie eine neue Lite-Plan- oder Standard-Plan-Instanz erstellen und die Daten der Instanz für den gemeinsam genutzten Plan auf die neue Instanz replizieren.
{: tip}

### Schritt 1: Anmeldung bei {{site.data.keyword.cloud_notm}} durchführen

Wenn Sie sich noch nicht angemeldet haben, dann führen Sie nun die [Anmeldung für ein {{site.data.keyword.cloud_notm}}-Konto](https://www.ibm.com/cloud/) durch. 

### Schritt 2: {{site.data.keyword.cloudant_short_notm}}-Instanz erstellen

Nach der Anmeldung bei Ihrem {{site.data.keyword.cloud_notm}}-Konto müssen Sie einen {{site.data.keyword.cloudant_short_notm}}-Service hinzufügen. Klicken Sie auf die Schaltfläche `Ressource erstellen` im Dashboard und dann auf `Datenbanken` und `Cloudant`. Weitere Informationen hierzu finden Sie im Abschnitt mit der [Vorgehensweise zum Erstellen einer {{site.data.keyword.cloudant_short_notm}}-Instanz unter {{site.data.keyword.cloud_notm}}](../tutorials/create_service.html#creating-an-ibm-cloudant-instance-on-ibm-cloud). 

![Hinzufügen einer {{site.data.keyword.cloudant_short_notm}}-Instanz](../tutorials/images/img0003.png)

### Schritt 3: Bereitschaft Ihrer Anwendung für {{site.data.keyword.cloudant_short_notm}} ermitteln

Wenn Sie eine Umstellung von einem {{site.data.keyword.cloudant_short_notm}} Enterprise-Service oder einem gemeinsam genutzten {{site.data.keyword.cloudant_short_notm}}-Plan durchführen wollen, dann müssen Sie nochmals die Nutzungsdaten Ihrer Anwendung für {{site.data.keyword.cloudant_short_notm}} aufrufen, um sicherzustellen, dass die Anwendung bereit zum Arbeiten mit den Kapazitätslimits des Standard-Plans ist. Weitere Informationen hierzu finden Sie im Abschnitt zur [Funktionsweise der {{site.data.keyword.cloudant_short_notm}}-API](../offerings/bluemix.html#provisioned-throughput-capacity). Insbesondere müssen Sie sich vergewissern, dass Ihre Anwendung eine HTTP-Antwort vom Typ
`429: Zu viele Anforderungen` verarbeiten kann, wenn Ihre bereitgestellte Durchsatzkapazität überschritten wird. 

Die Wiederholung von Anforderungen, auf die eine Antwort vom Typ `429` ausgegeben wurde, ist im Fall gelegentlicher Datenverkehrsspitzen akzeptabel, die die Kapazität Ihres Plans überschreiten. Wenn der Anwendungsdatenverkehr regelmäßig zur Generierung von Antworten des Typs `429` führt, besteht eine hohe Wahrscheinlichkeit, dass Sie ein Upgrade auf einen größeren Plan durchführen müssen.

Außerdem sollten Sie beachten, dass die maximale Einzeldokumentgröße unter {{site.data.keyword.cloudant_short_notm}} 1 MB beträgt und dass Sie eine Nachricht vom Typ
`413: Anforderungsentität zu groß` erhalten, wenn das Limit überschritten wird. Weitere Informationen hierzu finden Sie im Abschnitt zur [Größenbegrenzung für Anforderungen und Dokumente](../offerings/bluemix.html#request-and-document-size-limits). 

### Schritt 4: Daten vom alten auf den neuen Service migrieren 

Richten Sie die fortlaufende Replikation vom vorhandenen Service auf Ihr {{site.data.keyword.cloudant_short_notm}}-Konto ein. Weitere Informationen zur Vorgehensweise beim Einrichten und Überwachen von Replikationstasks finden Sie im [Leitfaden zur Replikation](../guides/replication_guide.html#replication) und in der [API-Dokumentation](../api/replication.html#replication).

Alternativ hierzu können Sie sich auch mit dem Tool [`couchreplicate`](https://www.npmjs.com/package/couchreplicate) vertraut machen. Hierbei handelt es sich um ein Befehlszeilendienstprogramm, das die Koordinierung der Datenübertragung von einem {{site.data.keyword.cloudant_short_notm}}-Konto auf ein anderes vereinfacht. Es dient zur Einrichtung mehrerer Replikationsjobs zwischen dem Quellen- und dem Zielkonto und stellt sicher, dass nur eine geeignete Anzahl von Replikationsjobs gleichzeitig ausgeführt werden. Wenn Sie Hunderte von Datenbanken replizieren müssen, dann erleichtert `couchreplicate` die Koordination der Replikationsjobs.

![`couchreplicate`](https://raw.githubusercontent.com/glynnbird/couchreplicate/HEAD/img/couchreplicate.gif)

Überprüfen Sie, ob alle Daten auf den neuen Service repliziert werden und dass die Indizes erstellt werden.

### Schritt 5: Erforderliche Tests durchführen

Führen Sie Lade- und Funktionstests für Ihre Anwendung durch, um vor der Migration auf die Produktionsumgebung sicherzustellen, dass keine Probleme vorliegen.

### Schritt 6: Sind Sie bereit zur Umstellung auf die neue Instanz?

Wenn Sie bereit für die Umstellung Ihres Systems auf die neue Instanz sind, dann sollten Sie Ihre Anwendung aktualisieren, damit sie die neue Konto-URL und die neuen Berechtigungsnachweise für die {{site.data.keyword.cloudant_short_notm}}-Instanz verwendet. Weitere Informationen zur Vorgehensweise beim Abrufen der Serviceberechtigungsnachweise für eine {{site.data.keyword.cloudant_short_notm}}-Instanz finden Sie im [Bereitstellungslernprogramm](../tutorials/create_service.html#creating-a-cloudant-instance-on-bluemix).

### Schritt 7: Alten Service inaktivieren

 Nachdem Ihre Anwendung vollständig auf die {{site.data.keyword.cloudant_short_notm}}-Lite-Instanz oder -Standard-Instanz migriert wurde, können Sie die alte Instanz für den {{site.data.keyword.cloudant_short_notm}}-Plan für gemeinsame Nutzung über die {{site.data.keyword.cloud_notm}}-Konsole löschen, um sicherzustellen, dass Ihnen dieser Service nicht weiter in Rechnung gestellt wird.

## FAQs - Häufig gestellte Fragen

Die häufig gestellte Fragen (FAQs = Frequently Asked Questions) werden von der {{site.data.keyword.cloudant_short_notm}}-Organisation veröffentlicht, um {{site.data.keyword.IBM_notm}}-Kunden die Migration auf eine {{site.data.keyword.cloudant_short_notm}}-Lite-Plan-Instanz oder -Standard-Plan-Instanz unter
{{site.data.keyword.cloud_notm}} zu erleichtern.

## Kann ich meine Daten vorab sichern?

{{site.data.keyword.cloudant_short_notm}} empfiehlt die Verwendung des Dienstprogramms [couchbackup](../guides/backup-cookbook.html#cloudant-nosql-db-backup-and-recovery), um Daten auf die Platte zu
exportieren. [{{site.data.keyword.cloud_notm}} Object Storage](https://www.ibm.com/cloud/object-storage) ist eine kostengünstige und skalierbare Lösung zum Speichern exportierter Dateien. 

## Kann ich meine `username.cloudant.com`-Domäne beibehalten und auf den neuen Service unter {{site.data.keyword.cloudant_short_notm}} umleiten?

Nein, es ist nicht möglich, Ihre Domäne beizubehalten. Sie müssen die Aktualisierung Ihrer Anwendungen zur Verwendung der neuen Konto-URL und der entsprechenden Berechtigungsnachweise einplanen, die für die {{site.data.keyword.cloudant_short_notm}}-Instanzen generiert werden.

## Wenn kann ich kontaktieren, wenn ich Fragen habe?

Wenden Sie sich an den [{{site.data.keyword.cloudant_short_notm}}-Support](mailto:support@cloudant.com) oder öffnen Sie ein Ticket im {{site.data.keyword.cloudant_short_notm}}-Dashboard, wenn Sie Fragen zur Migration haben. Der {{site.data.keyword.cloudant_short_notm}}-Support stellt Ihnen gerne weitere Einzelheiten zur Verfügung.
