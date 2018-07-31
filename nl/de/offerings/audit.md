---

copyright:
  years: 2015, 2018
lastupdated: "2018-04-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2018-00-00 -->

# Prüfprotokollierung


Mit der Prüfprotokollierung werden die {{site.data.keyword.cloudantfull}}-Prinzipals aufgezeichnet, die auf die in {{site.data.keyword.cloudant_short_notm}} gespeicherten Daten zugegriffen haben. Für den gesamten HTTP-API-Zugriff auf {{site.data.keyword.cloudant_short_notm}} zeichnet die Funktion der Prüfprotokollierung die folgenden Daten jeder HTTP-Anforderung auf:

Informationen | Beschreibung
------------|------------
`Prinzipal` | Kontoberechtigungsnachweis, API-Schlüssel oder IBM Cloud-IAM-Berechtigungsnachweise.
`Aktion` | Die ausgeführte Aktion (z. B. Lesen eines Dokuments).
`Ressource` | Details zu Konten, Datenbanken und Dokumente, auf die zugegriffen oder die angefragt wurden.
`Zeitmarke` | Uhrzeit und Daten zum Ereignis. 

{{site.data.keyword.cloudant_short_notm}}-Prüfprotokolle können verwendet werden, um folgende Informationen zu erhalten:

- Auf welche Datenbanken und Dokumente zu welchem Zeitpunkt in welchem Konto von wem zugegriffen wurde.
- Welche Abfragen zu welchem Zeitpunkt von wem ausgeführt wurden.
- Auf was ein bestimmter Prinzipal oder Nutzer zu welchem Zeitpunkt zugegriffen hat, was er aktualisiert oder gelöscht hat.
- Welche Replikationsdokumente zu welchem Zeitpunkt erstellt oder gelöscht wurden.
{:shortdesc}

## Vorgehensweise beim Zugriff auf Prüfprotokolle für Ihr Konto

Um Zugriff auf die Prüfprotokolle für Ihr Konto anzufordern, wenden Sie sich an den {{site.data.keyword.cloudant_short_notm}}-Support. Der Support gewährt Ihnen Zugriff auf die gewünschten Prüfprotokolle.

Wenn Sie beim Support Unterstützung anfordern, stellen Sie Folgendes bereit:

- Das {{site.data.keyword.cloudant_short_notm}}-Konto, auf das sich die Anfrage bezieht.
- Den Zeitrahmen für die Prüfprotokolle (maximal ein Monat pro Support-Anforderung).
- Alle gewünschten Datenbanken, Dokumente oder Prinzipals.
