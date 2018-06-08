---

copyright:
  years: 2017, 2018
lastupdated: "2017-11-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-01-10 -->

# Einfache {{site.data.keyword.Bluemix_notm}}-Anwendung für den Zugriff auf eine {{site.data.keyword.cloudant_short_notm}}-Datenbank erstellen

In diesem Lernprogramm erfahren Sie, wie Sie eine {{site.data.keyword.Bluemix}}-Anwendung erstellen, die die
[Python-Programmiersprache ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://www.python.org/){:new_window} verwendet, um
Zugriff auf eine {{site.data.keyword.cloudantfull}}-Datenbank zu erhalten, die in Ihrer {{site.data.keyword.Bluemix_notm}}-Serviceinstanz gehostet ist.
{:shortdesc}

## Kontext

Ein bedeutender Vorteil von {{site.data.keyword.Bluemix_notm}} ist, dass Sie Anwendungen in
{{site.data.keyword.Bluemix_notm}} selbst erstellen und implementieren.
Sie müssen keinen Server finden und warten, auf dem Ihre Anwendungen ausgeführt werden können.

Wenn Sie bereits eine {{site.data.keyword.cloudant_short_notm}}-Datenbankinstanz in {{site.data.keyword.Bluemix_notm}} verwenden,
ist es sinnvoll, Ihre Anwendungen ebenfalls dort zu installieren.

{{site.data.keyword.Bluemix_notm}}-Anwendungen werden typischerweise mithilfe von
[Cloud Foundry-Technologie ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://en.wikipedia.org/wiki/Cloud_Foundry){:new_window} erstellt.
Cloud Foundry bietet eine Platform as a Service-Funktion (PaaS), die den Prozess der Erstellung von Anwendungen, die in einer Cloud-Umgebung implementiert und ausgeführt werden können, vereinfacht.

[In einem anderen Lernprogramm](create_database.html) haben Sie erfahren, wie Sie eine eigenständige Python-Anwendung erstellen,
die eine {{site.data.keyword.cloudant_short_notm}}-Datenbankinstanz in {{site.data.keyword.Bluemix_notm}} verwendet.
In diesem Lernprogramm erstellen und richten Sie eine kleine Python-Anwendung ein, die in {{site.data.keyword.Bluemix_notm}} gehostet ist.
Die Anwendung stellt eine Verbindung mit Ihrer {{site.data.keyword.cloudant_short_notm}}-Datenbankinstanz her und
erstellt ein einzelnes, einfaches Dokument.

Der für jede Task spezifische Python-Code wird als Teil dieses Lernprogramms bereitgestellt.
Ein umfassendes Python-Programm, das ausreicht, um die einzelnen Konzepte zu veranschaulichen, wird
in dem Lernprogramm [hier](create_bmxapp_createapp.html#complete-listing) bereitgestellt.

Es wurde nicht versucht, einen _effizienten_ Python-Code für dieses Lernprogramm zu schreiben.
Unsere Absicht ist, Ihnen einfachen und leicht verständlichen Code zu zeigen,
den Sie anschließend für Ihre eigenen Anwendungen verwenden können.

Es war auch nicht unser Anliegen, alle möglichen Prüfungen oder Fehlerbedingungen zu besprechen.
Wir haben zwar wir einige Beispielprüfungen eingeschlossen, um bestimmte Techniken zu erläutern,
aber Sie sollten Ihre üblichen Best Practices einsetzen, um Warnungen oder Fehlerbedingungen zu prüfen
und zu verarbeiten, die in Ihren Anwendungen auftreten.

## Taskübersicht

Um eine funktionierende Python-Anwendung unter {{site.data.keyword.Bluemix_notm}}
zu erstellen, die auf eine {{site.data.keyword.cloudant_short_notm}}-Datenbankinstanz zugreift,
müssen Sie die folgenden Tasks ausführen:

-   [Erstellen einer Python-Anwendungsumgebung unter {{site.data.keyword.Bluemix_notm}}. ](create_bmxapp_appenv.html#creating)
-   [Sicherstellen, dass die Python-Anwendungsumgebung eine Verbindung mit einer {{site.data.keyword.cloudant_short_notm}}-Datenbankinstanz hat.](create_bmxapp_appenv.html#connecting)
-   [(Einmalige Task) Herunterladen und Installieren der Cloud Foundry- und {{site.data.keyword.Bluemix_notm}}-Befehlszeilentoolkits.](create_bmxapp_appenv.html#toolkits)
-   [Herunterladen der Starteranwendung.](create_bmxapp_appenv.html#starter)
-   [Anpassen der Starteranwendung, um Ihre eigene Anwendung für den Zugriff auf die {{site.data.keyword.cloudant_short_notm}}-Datenbankinstanz zu erstellen.](create_bmxapp_createapp.html#theApp)
-   [Hochladen und Testen Ihrer Anwendung.](create_bmxapp_upload.html#uploading)
-   [Ausführen grundlegender Anwendungspflegetasks.](create_bmxapp_maintain.html#maintenance)
-   [Diagnostizieren und Beheben von Problemen (Fehlerbehebung).](create_bmxapp_maintain.html#troubleshooting)

## Struktur des Lernprogramms

Das Lernprogramm besteht aus fünf Abschnitten:

1.  [Voraussetzungen](create_bmxapp_prereq.html)
2.  [Anwendungsumgebung](create_bmxapp_appenv.html)
3.  [Anwendung erstellen](create_bmxapp_createapp.html)
4.  [Anwendung hochladen und ausführen](create_bmxapp_upload.html)
5.  [Pflege und Fehlerbehebung Ihrer Anwendung](create_bmxapp_maintain.html)

## Der nächste Schritt

Starten Sie das Lernprogramm,
indem Sie die [Voraussetzungen prüfen](create_bmxapp_prereq.html).
