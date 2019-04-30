---

copyright:
  years: 2017, 2019
lastupdated: "2019-03-19"

keywords: create applications, deploy applications, create simple application

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

# Einfache {{site.data.keyword.cloud_notm}}-Anwendung für den Zugriff auf eine {{site.data.keyword.cloudant_short_notm}}-Datenbank erstellen
{: #creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database}

In diesem Lernprogramm erfahren Sie, wie Sie eine {{site.data.keyword.cloud}}-Anwendung erstellen, die die
[Python-Programmiersprache ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://www.python.org/){: new_window} verwendet, um
Zugriff auf eine {{site.data.keyword.cloudantfull}}-Datenbank zu erhalten, die in Ihrer {{site.data.keyword.cloud_notm}}-Serviceinstanz gehostet ist.
{: shortdesc}

## Vorteile von {{site.data.keyword.cloud_notm}}
{: #advantages-of-ibm-cloud}

Ein bedeutender Vorteil von {{site.data.keyword.cloud}} ist, dass Sie Anwendungen in
{{site.data.keyword.cloud_notm}} selbst erstellen und implementieren.
Sie müssen keinen Server finden und warten, auf dem Ihre Anwendungen ausgeführt werden können.

Wenn Sie bereits eine {{site.data.keyword.cloudant_short_notm}}-Datenbankinstanz in {{site.data.keyword.cloud_notm}} verwenden, ist es sinnvoll, Ihre Anwendungen ebenfalls dort zu installieren.

{{site.data.keyword.cloud_notm}}-Anwendungen werden typischerweise mithilfe von
[Cloud Foundry-Technologie ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://en.wikipedia.org/wiki/Cloud_Foundry){: new_window} erstellt.
Cloud Foundry bietet eine Platform as a Service-Funktion (PaaS), die den Prozess der Erstellung von Anwendungen, die in einer Cloud-Umgebung implementiert und ausgeführt werden können, vereinfacht.

[In einem anderen Lernprogramm](/docs/services/Cloudant?topic=cloudant-creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud#creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud) haben Sie erfahren, wie Sie eine eigenständige Python-Anwendung erstellen, die eine {{site.data.keyword.cloudant_short_notm}}-Datenbankinstanz in {{site.data.keyword.cloud_notm}} verwendet.
In diesem Lernprogramm erstellen und richten Sie eine kleine Python-Anwendung ein, die in {{site.data.keyword.cloud_notm}} gehostet ist.
Die Anwendung stellt eine Verbindung mit Ihrer {{site.data.keyword.cloudant_short_notm}}-Datenbankinstanz her und
erstellt ein einzelnes, einfaches Dokument.

Der für jede Task spezifische Python-Code wird als Teil dieses Lernprogramms bereitgestellt.
Ein umfassendes Python-Programm, das ausreicht, um die einzelnen Konzepte zu veranschaulichen, wird
in dem Lernprogramm [hier](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-code#complete-python-program) bereitgestellt.

Es wurde nicht versucht, einen _effizienten_ Python-Code für dieses Lernprogramm zu schreiben.
Unsere Absicht ist, Ihnen einfachen und leicht verständlichen Code zu zeigen,
den Sie anschließend für Ihre eigenen Anwendungen verwenden können.

Es war auch nicht unser Anliegen, alle möglichen Prüfungen oder Fehlerbedingungen zu besprechen.
Wir haben zwar wir einige Beispielprüfungen eingeschlossen, um bestimmte Techniken zu erläutern,
aber Sie sollten Ihre üblichen Best Practices einsetzen, um Warnungen oder Fehlerbedingungen zu prüfen
und zu verarbeiten, die in Ihren Anwendungen auftreten.

## Taskübersicht
{: #task-overview}

Um eine funktionierende Python-Anwendung unter {{site.data.keyword.cloud_notm}} zu erstellen, die auf eine {{site.data.keyword.cloudant_short_notm}}-Datenbankinstanz zugreift, müssen Sie die folgenden Tasks ausführen:

-   [Erstellen einer Python-Anwendungsumgebung unter {{site.data.keyword.cloud_notm}}. ](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#creating-an-ibm-cloud-application-environment)
-   [Sicherstellen, dass die Python-Anwendungsumgebung eine Verbindung mit einer {{site.data.keyword.cloudant_short_notm}}-Datenbankinstanz hat.](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#connecting-ibm-cloud-applications-and-services)
-   [(Einmalige Task) Herunterladen und Installieren der Cloud Foundry- und {{site.data.keyword.cloud_notm}}-Befehlszeilentoolkits.](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#the-cloud-foundry-and-ibm-cloud-command-toolkits)
-   [Herunterladen der Starteranwendung.](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#the-starter-application)
-   [Anpassen der Starteranwendung, um Ihre eigene Anwendung für den Zugriff auf die {{site.data.keyword.cloudant_short_notm}}-Datenbankinstanz zu erstellen.](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-code#the-application-code)
-   [Hochladen und Testen Ihrer Anwendung.](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-uploading-the-application#uploading-the-application)
-   [Ausführen grundlegender Anwendungspflegetasks.](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting)
-   [Diagnostizieren und Beheben von Problemen (Fehlerbehebung).](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting#diagnosing-and-resolving-problems)

## Struktur des Lernprogramms
{: #tutorial-structure}

Das Lernprogramm besteht aus fünf Abschnitten:

1.  [Voraussetzungen](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites)
2.  [Anwendungsumgebung](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment)
3.  [Anwendung erstellen](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-code#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-code)
4.  [Anwendung hochladen und ausführen](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-uploading-the-application#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-uploading-the-application)
5.  [Pflege und Fehlerbehebung Ihrer Anwendung](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting)

Starten Sie das Lernprogramm, indem Sie
die [Voraussetzungen prüfen](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites).
