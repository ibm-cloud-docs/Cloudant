---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: principal, action, resource, timestamp, access audit logs

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

# Prüfprotokollierung
{: #audit-logging}

Mit der Prüfprotokollierung werden die {{site.data.keyword.cloudantfull}}-Prinzipals aufgezeichnet, die auf die in {{site.data.keyword.cloudant_short_notm}} gespeicherten Daten zugegriffen haben. Für den gesamten HTTP-API-Zugriff auf {{site.data.keyword.cloudant_short_notm}} zeichnet die Funktion der Prüfprotokollierung die folgenden Daten jeder HTTP-Anforderung auf:

Informationen | Beschreibung
------------|------------
`Prinzipal` | Kontoberechtigungsnachweis, API-Schlüssel oder IBM Cloud-IAM-Berechtigungsnachweise.
`Aktion` | Die ausgeführte Aktion (z. B. Lesen eines Dokuments).
`Ressource` | Details zu Konten, Datenbanken und Dokumente, auf die zugegriffen oder die angefragt wurden.
`Zeitmarke` | Uhrzeit und Daten zum Ereignis. 
{: shortdesc}

{{site.data.keyword.cloudant_short_notm}}-Prüfprotokolle können verwendet werden, um folgende Informationen zu erhalten:

- Auf welche Datenbanken und Dokumente zu welchem Zeitpunkt in welchem Konto von wem zugegriffen wurde.
- Welche Abfragen zu welchem Zeitpunkt von wem ausgeführt wurden.
- Auf was ein bestimmter Prinzipal oder Nutzer zu welchem Zeitpunkt zugegriffen hat, was er aktualisiert oder gelöscht hat.
- Welche Replikationsdokumente zu welchem Zeitpunkt erstellt oder gelöscht wurden.


## Vorgehensweise beim Zugriff auf Prüfprotokolle für Ihr Konto
{: #how-to-access-audit-logs-for-your-account}

Um Zugriff auf die Prüfprotokolle für Ihr Konto anzufordern, wenden Sie sich an den {{site.data.keyword.cloudant_short_notm}}-Support. Der Support stellt eine Kopie der Prüfprotokolle bereit, die für Sie von Interesse sind.

Wenn Sie beim Support Unterstützung anfordern, stellen Sie Folgendes bereit:

- Das {{site.data.keyword.cloudant_short_notm}}-Konto, auf das sich die Anfrage bezieht.
- Den Zeitrahmen für die Prüfprotokolle (maximal ein Monat pro Support-Anforderung).
- Alle gewünschten Datenbanken, Dokumente oder Prinzipals.
