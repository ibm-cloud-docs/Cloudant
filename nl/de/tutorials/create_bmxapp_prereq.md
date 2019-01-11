---

copyright:
  years: 2017, 2018
lastupdated: "2018-10-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:tip: .tip}

<!-- Acrolinx: 2017-05-10 -->

# Einfache {{site.data.keyword.cloud_notm}}-Anwendung für den Zugriff auf eine {{site.data.keyword.cloudant_short_notm}}-Datenbank erstellen: Voraussetzungen

In diesem Abschnitt des Lernprogramms wird die Voraussetzungen
für die Erstellung einer {{site.data.keyword.cloud}}-Anwendung beschrieben.
{:shortdesc}

## Voraussetzungen

Stellen Sie sicher, dass Sie die folgenden Ressourcen oder Informationen zur Hand haben, bevor Sie das Lernprogramm durcharbeiten.

### Python

In praktisch allen Entwicklungsszenarios ist es viel einfacher, wenn Sie eine aktuelle Installation der
[Python-Programmiersprache ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://www.python.org/){:new_window}
auf Ihrem System installiert haben.

Prüfen Sie dies, indem Sie den folgenden Befehl an einer Eingabeaufforderung ausführen:

```sh
python --version
```
{:pre}

Ihre Ausgabe wird ungefähr wie folgt aussehen:

```
Python 2.7.12
```
{:codeblock}

<div id="csi"></div>

### {{site.data.keyword.cloudant_short_notm}}-Serviceinstanz unter {{site.data.keyword.cloud_notm}}

Ein separates Lernprogramm für die Erstellung einer {{site.data.keyword.cloudantfull}}-Serviceinstanz namens `Cloudant Service 2017` ist [hier](create_service.html) verfügbar.

In diesem Lernprogramm wird davon ausgegangen, dass Sie bereits eine Serviceinstanz namens
`Cloudant Service 2017` erstellt haben.

### {{site.data.keyword.cloudant_short_notm}}-Datenbankanwendung

Ein separates Lernprogramm für die Erstellung einer eigenständigen Python-Anwendung für die Arbeit mit einer {{site.data.keyword.cloudant_short_notm}}-Serviceinstanz ist [hier](create_database.html) verfügbar.
Es stellt eine Reihe von Konzepten vor, die dabei helfen, das Erstellen und Befüllen einer {{site.data.keyword.cloudant_short_notm}}-Datenbank zu verstehen.

In diesem Lernprogramm wird davon ausgegangen, dass Sie diese Konzepte bereits kennen.

## Der nächste Schritt

Der nächste Schritt im Lernprogramm besteht darin, [die Anwendungsumgebung zu erstellen](create_bmxapp_appenv.html).
