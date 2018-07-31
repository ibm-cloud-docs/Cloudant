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
{:tip: .tip}

<!-- Acrolinx: 2018-06-07 -->

# Preisstruktur
{: #pricing}

Mit {{site.data.keyword.cloudantfull}} können Sie die bereitgestellte Durchsatzkapazität nach oben und unten skalieren, die eine reservierte Anzahl von Suchvorgängen, Schreibvorgängen und Abfragen für jede einer Instanz zugewiesene Sekunde darstellt. Die Durchsatzkapazität ist die maximale Nutzungsstufe. Wenn Sie versuchen, die reservierte Kapazität zu überschreiten, erhalten Sie einen HTTP 429-Statuscode, der angibt, dass die Anwendung versucht, die bereitgestellte Durchsatzkapazität zu überschreiten. 


## Preisbeispiele 
{: #pricing-examples}

Nehmen wir an, Sie erstellen mit {{site.data.keyword.cloudant_short_notm}} eine mobile App und kennen Ihre benötigte Kapazität noch nicht. In diesem Fall empfehlen wir, mit der niedrigsten bereitgestellten Durchsatzkapazität zu beginnen und sie je nach Bedarf im Laufe der Zeit zu erhöhen, je nachdem, wie viel Kapazität Ihre Anwendung benötigt. {{site.data.keyword.cloudant_short_notm}}-Rechnungen werden anteilmäßig pro Stunde berechnet. Die Änderung der bereitgestellten Durchsatzkapazität verursacht keine Ausfallzeiten. 

Beispiel für die mobile App: Sie beginnen mit der minimalen bereitgestellten Durchsatzkapazität für den Standardplan, die 100 Suchvorgänge/Sek., 50 Schreibvorgänge/Sek. und 5 Abfragen/Sek. enthält. Die Kosten für diese Kapazität betragen 0,105 US-Dollar pro Stunde. Die 100 Suchvorgänge/Sek., 50 Schreibvorgänge/Sek. und 5 Abfragen/Sek. sind ein Block bereitgestellter Durchsatzkapazität. Wenn Sie nach oben (oder unten) skalieren müssen, können Sie diese Kapazitätsblöcke schrittweise skalieren. Unter der Voraussetzung, dass die Instanz weniger als die 20 GB Speicherkapazität hat, die im Standardplan enthalten ist, entstehen keine Speicherkosten. Auf der Registerkarte {{site.data.keyword.cloudant_short_notm}} Dashboard > Konto > Kapazität sieht die Einstellung für die bereitgestellte Durchsatzkapazität wie in diesem Screenshot aus:

![{{site.data.keyword.cloudant_short_notm}} Dashboard mit Registerkarte für die Kapazität](../images/cloudant-dashboard.png)

Der Kapazitätsschieberegler zeigt die Kosten pro Stunde der bereitgestellten Durchsatzkapazität von 100 Suchvorgängen/Sek., 50 Schreibvorgängen/Sek. und 5 Abfragen/Sek. in US-Dollar für 0,105 US-Dollar/Stunde an. Der Schieberegler zeigt Kosten pro Monat von etwa 76,65 US-Dollar an. Der monatliche Betrag ist eine Schätzung, die auf durchschnittliche 730 Stunden pro Monat basiert. Die Kosten pro Monat können leicht variieren, je nachdem, wie hoch die Anzahl der Stunden im Monat ist. 

Beispielgleichung: 

- 0,105 US-Dollar pro Stunde 1 Block von 100 Suchvorgängen/Sek., 50 Schreibvorgängen/Sek. und 5 Abfragen/Sek. bereitgestellter Durchsatzkapazität * 730 Stunden (ungefähre Anzahl an Stunden in einem Monat)
- Gesamtbetrag = 76,65 US-Dollar

Suchvorgänge, Schreibvorgänge und Abfragen können nicht unabhängig voneinander skaliert werden. Verwenden Sie den Schieberegler, um die Anzahl der Blöcke der bereitgestellten Durchsatzkapazität anhand der maximalen Anzahl von Suchvorgängen/Sek., Schreibvorgängen/Sek. oder Abfragen/Sek. auszuwählen, die für Ihre Anwendung erforderlich sind. Beispiel: Wenn Ihre Anwendung 1.000 Suchvorgänge pro Sekunde benötigt, wählen Sie mithilfe des Schiebereglers die Kapazität aus, die 1.000 Suchvorgänge/Sek., 500 Schreibvorgänge/Sek. und 50 Abfragen/Sek. anbietet, auch wenn Sie nicht die entsprechende Anzahl an Schreibvorgängen oder Abfragen brauchen.

![{{site.data.keyword.cloudant_short_notm}} Dashboard mit Registerkarte, auf der eine höhere Kapazität ausgewählt wurde](../images/cloudant-gran-tuning.png)

Wie schätzen Sie die Gesamtkosten für die bereitgestellte Durchsatzkapazität pro Monat mit 1.000 Suchvorgängen, 500 Schreibvorgängen und 50 Abfragen ein? 

- 0,105 US-Dollar pro Stunde 10 Blocks von 100 Suchvorgängen/Sek., 50 Schreibvorgängen/Sek. und 5 Abfragen/Sek. bereitgestellter Durchsatzkapazität * 730 Stunden (ungefähre Anzahl an Stunden in einem Monat)
- Alternativ zeigt der Schieberegler die bereitgestellte Durchsatzkapazität von 1.000 Suchvorgängen/Sek., 500 Schreibvorgängen/Sek. und 50 Abfragen/Sek. mit Kosten von 1,050 US-Dollar/Stunde * 730 Stunden an
- Gesamtbetrag = 766,50 US-Dollar

## Datennutzung 
{: #data-usage}

Wie sieht die Preisstruktur für Datenüberschreitungen aus?

Plan | Einschließlich Speicher | Überschreitungsgrenzwert
-----|------------------|--------------
Lite | 1 GB |  Ihr Konto wird so lange blockiert, neue Daten zu schreiben, bis Sie Daten löschen, um den Grenzwert unter 1 GB zu erreichen, oder bis Sie auf einen höheren Plan aufrüsten.
Standard | 20 GB | Weiterer Speicher kostet 0,0014 US-Dollar pro GB pro Stunde; dies entspricht etwa 1 US-Dollar/GB pro Monat.

Wie werden die Daten im {{site.data.keyword.cloud_notm}}-Nutzungsdashboard angezeigt?

Diese Ansicht zeigt die Gesamtsummen für die Nutzung an, die in diesem Monat angefallen ist, und zeigt daher nur die Kosten für den aktuellen Monat an. Die geschätzte Gesamtsumme spiegelt den bisherigen Rechnungsbetrag für den Monat wider. Am Ende des Monats sehen Sie Ihre durchschnittliche Kapazität für den Monat, die Ihre gesamte Monatsrechnung ist. Im Feld `STORAGE_MANAGED_PER_MONTH` wird nur der Betrag angezeigt, der über 20 GB liegt. Im folgenden Beispiel sehen Sie daher ungefähr insgesamt 40 GB Daten im Konto.  

![{{site.data.keyword.cloudant_short_notm}} Dashboard-Ansicht mit Nutzungsmetriken mit höherem Wert für STORAGE MANAGED PER MONTH](../images/usage-dashboard1.png)

Wenn Sie weniger als 20 GB Speicher verwenden, zeigt das Display 0 GB an, da Sie den Grenzwert nicht überschritten haben.
