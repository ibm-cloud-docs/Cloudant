---

copyright:
  years: 2017, 2019
lastupdated: "2019-03-19"

keywords: python, create service instance, create stand-alone python application

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

# Einfache {{site.data.keyword.cloud_notm}}-Anwendung für den Zugriff auf eine {{site.data.keyword.cloudant_short_notm}}-Datenbank erstellen: Voraussetzungen
{: #creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites}

In diesem Abschnitt des Lernprogramms wird die Voraussetzungen
für die Erstellung einer {{site.data.keyword.cloud}}-Anwendung beschrieben.
{: shortdesc}

## Voraussetzungen
{: #prerequisites}

Stellen Sie sicher, dass Sie die folgenden Ressourcen oder Informationen zur Hand haben, bevor Sie das Lernprogramm durcharbeiten.

### Python
{: #python-create-bmxapp-prereq}

In praktisch allen Entwicklungsszenarios ist es viel einfacher, wenn Sie eine aktuelle Installation der
[Python-Programmiersprache ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://www.python.org/){: new_window}
auf Ihrem System installiert haben.

Prüfen Sie dies, indem Sie den folgenden Befehl an einer Eingabeaufforderung ausführen:

```sh
python --version
```
{: pre}

Ihre Ausgabe wird ungefähr wie folgt aussehen:

```
Python 2.7.12
```
{: codeblock}

### {{site.data.keyword.cloudant_short_notm}}-Serviceinstanz unter {{site.data.keyword.cloud_notm}}
{: #an-ibm-cloudant-service-instance-on-ibm-cloud}

Ein separates Lernprogramm für die Erstellung einer {{site.data.keyword.cloudantfull}}-Serviceinstanz mit dem Namen
`Cloudant-o7` ist [hier](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-an-ibm-cloudant-instance-on-ibm-cloud) verfügbar.

In diesem Lernprogramm wird davon ausgegangen, dass Sie bereits eine Serviceinstanz mit dem
Namen `Cloudant-o7` erstellt haben.

### {{site.data.keyword.cloudant_short_notm}}-Datenbankanwendung
{: #an-ibm-cloudant-database-application}

Ein separates Lernprogramm für die Erstellung einer eigenständigen Python-Anwendung für die Arbeit mit einer {{site.data.keyword.cloudant_short_notm}}-Serviceinstanz ist [hier](/docs/services/Cloudant?topic=cloudant-creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud#creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud) verfügbar.
Es stellt eine Reihe von Konzepten vor, die dabei helfen, das Erstellen und Befüllen einer {{site.data.keyword.cloudant_short_notm}}-Datenbank zu verstehen.

In diesem Lernprogramm wird davon ausgegangen, dass Sie diese Konzepte bereits kennen.

Der nächste Schritt im Lernprogramm besteht darin, [die Anwendungsumgebung zu erstellen](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment).
