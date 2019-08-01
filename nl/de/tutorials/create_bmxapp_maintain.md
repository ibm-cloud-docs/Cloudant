---

copyright:
  years: 2017, 2019
lastupdated: "2019-06-12"

keywords: maintenance tasks, find application status, start application, stop application, upload application, diagnose problems, resolve problems, application log

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

<!-- Acrolinx: 2017-01-11 -->

# Einfache {{site.data.keyword.cloud_notm}}-Anwendung für den Zugriff auf eine {{site.data.keyword.cloudant_short_notm}}-Datenbank erstellen: Wartung und Fehlerbehebung
{: #creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting}

In diesem Lernprogramm erfahren Sie, wie Sie eine
{{site.data.keyword.cloud}}-Anwendung, die in Ihrer {{site.data.keyword.cloud_notm}}-Serviceinstanz gehostet ist, warten.
{: shortdesc}

## Grundlegende Anwendungswartungstasks ausführen
{: #performing-basic-application-maintenance-tasks}

In diesem Abschnitt des Lernprogramms wird erläutert, wie Sie Ihre Python-Anwendungen unter {{site.data.keyword.cloud_notm}} aktualisieren,
starten und stoppen.

### Status Ihrer Anwendung herausfinden
{: #finding-the-status-of-your-application}

Der Status von Anwendungen in Ihrer {{site.data.keyword.cloud_notm}}-Serviceinstanz wird im Dashboard angezeigt.

Im folgenden Beispiel wird die Anwendung `Cloudant CF app` nicht ausgeführt und hat den
Status `Gestoppt`:

![Screenshot des Dashboards für die Anwendung mit dem Status 'Gestoppt'](images/img0037.png)

### Anwendung starten
{: #starting-your-application}

Wenn Sie versuchen, die Lernprogrammanwendung zu starten, ohne zunächst die Beispieldatenbank des Lernprogramms zu löschen, kann die Anwendung nicht ordnungsgemäß
funktionieren. Die Anwendung versucht, zu starten, schlägt fehl, weil die Datenbank vorhanden ist,
    wird gestoppt und versucht dann erneut, zu starten usw. Beheben Sie dieses Problem, indem Sie die
    [Anwendung stoppen](#stopping-your-application)
    und dann die Beispieldatenbank des Lernprogramms löschen. Anschließend kann die Anwendung erfolgreich gestartet werden.
{: note}
    
Um eine gestoppte Anwendung zu starten, klicken Sie im Menü auf die Option `Starten`:<br/>
![Screenshot mit der Option 'Starten'](images/img0039.png)

### Anwendung stoppen
{: #stopping-your-application}

Um eine aktive Anwendung zu stoppen, klicken Sie im Menü auf die Option `Stoppen`:<br/>
![Screenshot mit der Option 'Stoppen'](images/img0041.png)

### Neue Version Ihrer Anwendung hochladen
{: #uploading-a-fresh-version-of-your-application}

Um eine neue Version Ihrer Anwendung hochzuladen,
befolgen Sie einfach den [Uploadprozess](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-uploading-the-application#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-uploading-the-application).
Die neue Version überschreibt die ältere Version der Anwendung.

Wenn die ältere Version der Anwendung bereits aktiv ist, wenn Sie mit dem Hochladen beginnen, dann stoppt {{site.data.keyword.cloud_notm}} automatisch zuerst die Ausführung der Anwendung.
{: tip}

## Probleme diagnostizieren und beheben
{: #diagnosing-and-resolving-problems}

In diesem Abschnitt des Lernprogramms finden Sie grundlegende Tipps zur Fehlerbehebung, die
es Ihnen erleichtern, Probleme zu erkennen, zu diagnostizieren und zu beheben, die beim
Entwickeln und Implementieren Ihrer ersten {{site.data.keyword.cloud_notm}}-Anwendungen auftreten können.

Eine gute Quelle für Ratschläge bezüglich Best Practices für die Erstellung von {{site.data.keyword.cloud_notm}}- oder Cloud Foundry-Anwendungen finden Sie unter [Considerations for Designing and Running an App in the Cloud ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://docs.cloudfoundry.org/devguide/deploy-apps/prepare-to-deploy.html){: new_window}.

Insbesondere der Vorschlag,
[Schreibvorgänge in das lokale Dateisystem zu vermeiden ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://docs.cloudfoundry.org/devguide/deploy-apps/prepare-to-deploy.html#filesystem){: new_window},
ist sinnvoll.

Zur Vereinfachung schreibt dieses Lernprogramm Inhalte in das lokale Dateisystem. Aber die Menge der Daten ist klein. Sie sind nicht dafür gedacht, dauerhaft erhalten zu bleiben,
    und sie sind nicht geschäftskritisch.
{: tip}

### Anwendungsprotokoll verwenden
{: #using-the-application-log}

Die nützlichste Ressource für die Diagnose und Behebung von Problemen mit
der {{site.data.keyword.cloud_notm}}-Anwendung ist die Protokolldatei.

Die Protokolldatei für eine {{site.data.keyword.cloud_notm}}-Anwendung finden Sie, indem Sie auf die Registerkarte `Protokolle` klicken, um die Informationsseite für die Protokollierung zu öffnen:<br/>
![Screenshot mit dem Link zur Informationsseite 'Protokolle'](images/img0042.png)

Wie bei den meisten Protokolldateien enthält ein {{site.data.keyword.cloud_notm}}-Anwendungsprotokoll Details dazu, welche Ereignisse wann und wo aufgetreten sind.

Das Protokoll gibt auch an, welche Komponenten an dem aufgezeichneten Ereignis beteiligt waren.
In der folgenden Tabelle sind Schlüsselkomponenten aufgeführt:

Bezeichnung der Komponente | Komponente
----------------|----------
`API`           | Cloud Foundry-System.
`APP`           | Ihre Anwendung.
`CELL`          | Container, in dem Ihre Anwendung in {{site.data.keyword.cloud_notm}} gespeichert ist.
`RTR`           | Netzkomponenten übertragen Nachrichten an oder von Ihrer Anwendung.

Der folgende Screenshot enthält beispielsweise eine Reihe von typischen Ereignissen:<br/>
![Screenshot mit indikativen Protokollinformationen](images/img0043.png)

Sehen Sie sich die Ereignisse an den folgenden Zeitpunkten an:

-   Um 1:56:56 PM wurde die Anwendung erfolgreich gestartet.
-   Um 1:58:43 PM hat das Netz eine einfache HTTP-Anforderung `GET /` empfangen.
-   Wenige Augenblicke später hat die Anwendung die HTTP-Anforderung empfangen und darauf geantwortet.
-   Um 2:13:46 PM wurde eine Anforderung empfangen, die Anwendung zu stoppen.
-   Um 2:13:48 PM hat die Anwendung den Stopp-Prozess abgeschlossen.

Die in diesem Lernprogramm beschriebene Anwendung ist absichtlich klein und unkompliziert gehalten.
Es wird beispielsweise kein Versuch unternommen, festzustellen, ob die Zieldatenbank vorhanden ist,
und falls ja, eine erneute Erstellung zu vermeiden.
Wenn Sie die Lernprogrammanwendung folglich mehr als einmal ausführen, ohne zunächst die Datenbank zu entfernen,
schlägt die Anwendung wiederholt fehl und wird neu gestartet.

Diesen Effekt sehen Sie im folgenden Screenshot:<br/>
![Screenshot mit Fehlerinformationen im Protokoll](images/img0044.png)

Um 2:31:23 PM hat die Anwendung ein Problem erkannt:<br/>
`"Database {0} already exists".format(dbname)`

Die übrigen Nachrichten sind typisch für alle Python-Anwendungen, die ein Problem feststellen.

Tatsächlich zeigt das Protokoll, welche Komponente ein Problem festgestellt hat,
und gibt möglichst viele Details.
Beheben Sie das Problem mithilfe der üblichen Prozeduren zur Fehlerbehebung in Anwendungen.

## Ende des Lernprogramms
{: #end-of-tutorial}

Das Lernprogramm ist abgeschlossen.
