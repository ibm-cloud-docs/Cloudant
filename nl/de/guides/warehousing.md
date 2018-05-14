---

copyright:
  years: 2015, 2017
lastupdated: "2017-01-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# Data-Warehousing

Eine Datenbank ist unerlässlich zum Speichern von Daten.
Aber die Möglichkeit, diese Daten für Geschäftszwecke zu nutzen, macht eine Datenbank erst richtig wertvoll:
relevante Daten abrufen, schnell und einfach, und diese Daten in Ihren Anwendungen verarbeiten.
{:shortdesc}

Aber viele der Speicher-, Verarbeitungs- und Analysetasks, die Sie mit den Daten
ausführen, werden wiederholt in Ihren Anwendungen verwendet.
Oder es handelt sich um gute Beispiele für in der Branche eingesetzte Best Practices. 

Deshalb ist es sinnvoll, Standarddatenbankfunktionalitäten um zusätzliche Features
zu ergänzen, die Tasks wie Berichterstellung oder Analyse unterstützen. 

Fast 30 Jahre waren Data-Warehouses der Branchenstandard für Datenspeicherung,
Berichterstellung und Analysen, basierend auf relationaler Datenbanktechnologie.
Ganz allgemein ist
ein [Data-Warehouse ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://en.wikipedia.org/wiki/Data_warehouse){:new_window}:
ein zentrales Repository integrierter Daten aus einer oder mehreren Quellen.
Es speichert aktuelle und Protokolldaten.
Und es kann verwendet werden, um Analysen durchzuführen und Berichte zu erstellen für Fachkräfte im gesamten Unternehmen. 

Die Technologien, die Datenspeicherung, Berichterstellung und Analysen zugrunde liegen, sind in den letzten Jahren als Antwort auf einen Bedarf nach der Verarbeitung sogenannter
[Big Data ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://en.wikipedia.org/wiki/Big_data){:new_window} entstanden:
'Big Data' ist ein Begriff für Datensätze, die so groß oder so komplex sind, dass traditionelle Datenverarbeitungsanwendungen versagen. 

Gleichzeitig sorgen die Eigenschaften von Data-Warehouses und verwandten Produkten dafür,
dass der Einsatz von relationaler Datenbanktechnologie zur Aktivierung der Data-Warehouses gang und gäbe ist,
sogar für Big Data-Tasks. 

Es gibt viele Anwendungsfälle, die die Vorteile der Integration von Cloudant-Funktionalitäten deutlich aufzeigen,
z. B. in den folgenden Beispielen. 

## Daten verknüpfen

Das Verknüpfen von Daten aus mehreren Datenspeichern für eine domänenübergreifende Analyse
ist eine Task, die einfach und effizient mithilfe eines relationalen Data-Warehouse ausgeführt werden kann. 

Während ein Data-Warehouse geladen wird, werden Daten aus verschiedenen Quellen vorbereitet und in ein gemeinsames Format gebracht.
Datensätze werden in Tabellen gespeichert und es sind Operationen zum Verknüpfen dieser Tabellen für eine kombinierte Analyse verfügbar. 

Die Verknüpfung in einem relationalen Data-Warehouse durchzuführen, ist besonders sinnvoll,
wenn einige der Daten bereits in einer relationalen Darstellung vorhanden sind,
z. B. Masterdaten oder Referenzdaten. 

## Flexibilität

Cloudant-Datenbanken können Daten flexibel darstellen.
Sie erzwingen beispielsweise kein Schema während des Lese- oder Schreibvorgangs. 

Dagegen ist ein klar strukturiertes und rigoros umgesetztes Modell erforderlich für Berichterstellung und Analyse von Tasks. 

Ihre Dokumente sind in einer relationalen Datenbank verfügbar und Sie können Ihr Modell auf einem festen Satz von Tabellendefinitionen basieren.
Nur Dokumente, die mit dem Tabellenschema übereinstimmen, können geladen werden, während Abweichungen abgelehnt werden.
Sie können Ihre Modelle mit konsistenten Daten unter Verwendung eines festen relationalen Schemas trainieren. 

## Zusicherung der Datenintegrität

Data-Warehouses können Bedingungen verwenden, um die Datenintegrität zuzusichern. Beispiel: 

-   Es können keine zwei Datensätze denselben Primärschlüssel haben. 
-   Fremdschlüssel garantieren, dass Datensätze vollständig sind. 
-   Funktionen sind verfügbar, um Datensätze anhand von Geschäftsregeln zu überprüfen. 

Eindeutigkeit, Richtigkeit und Vollständigkeit sind unerlässlich für jeden Unternehmensservice.
Durch das Laden Ihrer Cloudant-Dokumente in ein Data-Warehouse lassen sich diese Anforderungen einfacher erfüllen. 

## Cloudant und Data-Warehousing

Data-Warehouses sind eine ausgereifte und wichtige Technologie.
Cloudant bietet eine enge Integration in relationale Data-Warehouses, wodurch Sie die Vorteile dieser Technologie nutzen können. 

In IBM Cloudant ist eine grundlegende Warehousing-Funktionalität integriert,
in Form von [MapReduce-Ansichten](../api/using_views.html),
die es Ihnen ermöglichen, eine Reihe von grundlegenden analytischen Tasks auszuführen. 

Für weitere erweiterte Warehousing-Tasks können Sie die vollständige Funktionalität nutzen, die vom IBM Cloud-basierten Warehousing-Service [IBM dashDB ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://www-01.ibm.com/software/data/dashdb/){:new_window} bereitgestellt wird. 

Wenn Sie IBM Cloudant verwenden,
haben Sie integrierten und einfachen Zugriff auf erweiterte Warehousing-Funktionen wie die folgenden: 

-   Anzeigen Ihrer JSON-Daten im relationalen Datenbankformat. 
-   Durchführen von SQL-basierten Abfragen Ihrer Daten. 
-   Erstellen von Analysen aus Ihren Daten. 

Diese erweiterten Warehousing-Funktionen werden durch Services wie IBM dashDB aktiviert,
das eine natürliche Ergänzung zu Cloudant ist. 

Alternativ können Sie Ihre Cloudant-Dokumente in den [IBM DB2 on Cloud](#ibm-db2-on-cloud)-Service laden,
wenn Sie nur einen relationalen Datenspeicher für Ihre Dokumente, ohne die Warehousing-Funktionen, benötigen. 

## IBM dashDB

IBM dashDB ist ein cloudbasierter Data-Warehouse-Service,
zweckgerichtet für Analysetasks.
dashDB eignet sich zwar besonders für Cloudant-JSON-Daten,
kann aber Daten aus vielen verschiedenen Quellen akzeptieren, indem
die Struktur der Daten beim Laden untersucht wird. 

Weitere Informationen finden Sie in der
[IBM dashDB Cloud Data Warehouse-Dokumentation ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/support/knowledgecenter/SS6NHC/com.ibm.swg.im.dashdb.kc.doc/welcome.html){:new_window}. 

## IBM DB2 on Cloud

[IBM DB2 on Cloud ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://console.ng.bluemix.net/catalog/services/ibm-db2-on-cloud){:new_window}
stellt Ihnen eine Datenbank in der globalen Cloudinfrastruktur von IBM SoftLayer® bereit.
Sie umfasst die vielfältigen Funktionen einer lokalen DB2-Bereitstellung, aber ohne die Kosten, die Komplexität und das Risiko einer selbstverwalteten Infrastruktur. 

Weitere Informationen finden Sie in der [IBM DB2 on Cloud-Dokumentation ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://console.ng.bluemix.net/docs/services/DB2OnCloud/index.html#DB2OnCloud){:new_window}. 

## Warehouse erstellen

Es gibt zwei Wege, ein Warehouse zu erstellen: 

1.  [Mit Cloudant ein dashDB-Warehouse erstellen](#use-cloudant-to-create-a-dashdb-warehouse)
2.  [Cloudant mit einem vorhandenen Warehouse verbinden](#connect-cloudant-to-an-existing-warehouse)

### dashDB-Warehouse mit Cloudant erstellen

Die einfachste Methode, ein Warehouse zu erstellen, ist, mit Cloudant eine dashDB-Warehouse-Instanz in Bluemix,
zu erstellen.
Klicken Sie dafür auf die Schaltfläche `Warehouse erstellen` in der Task `Warehouse` auf der Registerkarte `Integrationen` Ihres Cloudant-Dashboards. 

![Screenshot der Task "dashDB-Warehouse erstellen" im Cloudant-Dashboard](../images/createDashDBWH.png)

Wenn Sie nicht bereits bei Bluemix angemeldet sind,
werden Sie dazu aufgefordert. 

>   **Hinweis**: Standardmäßig
    erstellt Cloudant eine dashDB-Instanz unter Bluemix für Ihr Warehouse.

![Screenshot der Task "Bei Bluemix authentifizieren" im Cloudant-Dashboard](../images/authenticateToBluemix.png)

Sobald Sie sich authentifiziert haben, können Sie anfordern, dass eine neue dashDB-Instanz mithilfe Ihres Bluemix-Kontos erstellt wird.
Gehen Sie dazu wie folgt vor: 

1.  Geben Sie den Namen, den Sie für das Warehouse verwenden möchten im Feld `Name des Warehouse` ein. 
2.  Geben Sie den Namen Ihrer vorhandenen Datenbank in Cloudant im Feld `Datenquellen` ein. 
3.  Stellen Sie sicher, dass im Formular die Option `Neue dashDB-Instanz erstellen` aktiviert ist. 
4.  Klicken Sie auf die Schaltfläche `Warehouse erstellen`. 

![Screenshot der Task "Warehouse erstellen" im Cloudant-Dashboard](../images/createWarehouse.png)

### Verbinden von Cloudant mit einem vorhandenen Warehouse

Statt mit Cloudant die dashDB-Warehousedatenbank zu erstellen, können
Sie eine Verbindung zu einer vorhandenen dashDB-Instanz herstellen. 

Der Prozess ähnelt der [Verwendung von Cloudant zum Erstellen eines dashDB-Warehouse](#use-cloudant-to-create-a-dashdb-warehouse). Aber statt die Option
`Neue dashDB-Instanz erstellen` auszuwählen, markieren Sie die Option `dashDB-Serviceinstanz` und wählen das dashDB-Warehouse aus, das bereits in Bluemix vorhanden ist. 

![Screenshot der Task "Verbindung zu vorhandener dashDB-Instanz herstellen" im Cloudant-Dashboard](../images/existingDashDBInstance.png)

### DB2-Warehouse-Instanz verwenden

Wenn Sie dies vorziehen, können Sie statt mit dashDB auch eine Verbindung mit einer vorhandenen DB2-Warehouse-Instanz herstellen.
Wählen Sie dafür die Option `DB2` in Ihrem Cloudant-Dashboard aus. 

![Screenshot der Task "DB2-Warehouse erstellen" im Cloudant-Dashboard](../images/createDB2WH.png)

Wenn Sie eine Verbindung zu einer DB2-Instanz herstellen möchten, müssen Sie die folgenden Details angeben: 

-   Hostadresse. 
-   Portnummer. 
-   Datenbankname. 
-   Benutzer-ID für die Datenbank. 
-   Kennwort für die Benutzer-ID. 

>   **Hinweis**: Der Rest dieses Abschnitts bezieht sich auf dashDB als Warehouse-Instanz. 
    Die bereitgestellten Informationen gelten aber auch, wenn Sie eine Instanz von DB2 verwenden.
    Es ist auch ein Lernprogramm verfügbar, in dem beschrieben wird, wie
    [JSON-Daten aus Cloudant in dashDB geladen werden ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://developer.ibm.com/clouddataservices../dashdb/get/load-json-from-cloudant-database-in-to-dashdb/){:new_window},
    und gibt Beispiele für die Verwendung von DB2 als Warehousedatenbank.

## Warehouse-Schema

Wenn Sie erstmalig ein Warehouse in Cloudant erstellen,
erstellt dashDB das bestmögliche Schema für die Daten in der Datenbank
und sorgt dafür, dass alle Felder in Ihren JSON-Dokumenten einen entsprechenden
Eintrag im neuen Schema haben.
Optional können Sie beim Erstellen des Warehouse auswählen,
das [Schema manuell anzupassen](#customizing-the-warehouse-schema). 

Sobald das Schema erstellt ist, kann das Warehouse Ihre Daten in einem relationalen Format speichern.
Cloudant führt dann eine [Replikation](../api/replication.html) durch, um die Datenbankdokumente
erstmalig in das Warehouse zu laden, wodurch Sie Zugriff auf eine aktive Sammlung Ihrer Daten in der relationalen
dashDB-Datenbank haben. 

Im Laufe der Zeit kann sich Ihr Cloudant-Datenbankinhalt ändern.
Sie können das Schema eines vorhandenen Warehouse ändern. 

>   **Hinweis**: Wenn Sie das Schema eines vorhandenen Warehouse ändern, 
    müssen die Daten aus Ihrer Cloudant-Datenbank neu in die Warehousedatenbank repliziert werden.
    Tatsächlich führt das Ändern des Schemas zu einem erneuten erstmaligen Ladevorgang in das Warehouse.

## Mit Ihrem Warehouse arbeiten

Mit Cloudant-Warehousing können Sie herkömmliche SQL-Abfragen ausführen
und die Ergebnisse über die dashDB-Konsole anzeigen. 

![Screenshot des "dashDB-Dashboards" in Bluemix](../images/useDashDBdashboard.png)

Externe Anwendungen können mit den Daten auf dieselbe Weise interagieren wie mit allen anderen relationalen Datenbanken. 

Der Vorteil von dashDB ist, dass Sie andere Warehousing-Tasks ausführen können,
z. B. mehr Daten aus anderen Quellen laden und die Daten mit integrierten Analysetools analysieren.
DashDB unterstützt die
[Programmiersprache `'R'` ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://en.wikipedia.org/wiki/R_%28programming_language%29){:new_window}
und die Softwareumgebung für statistische Datenverarbeitung und Grafiken.
Das heißt, Sie haben Zugriff auf Algorithmen, mit denen Sie Datenbankanalysetasks wie lineare Regression,
K-Means-Clustering und geografisch-räumliche Analysen ausführen können. 

Mit dem Tool `RStudio` können Sie `'R'`-Scripts erstellen, die dann in dashDB hochgeladen und mit Ihren Daten ausgeführt werden. 

Weitere Informationen zur Arbeit mit dashDB finden Sie in der
[IBM dashDB Cloud Data Warehouse-Dokumentation ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/support/knowledgecenter/SS6NHC/com.ibm.swg.im.dashdb.kc.doc/welcome.html){:new_window}. 

## Daten und Struktur aktualisieren

Daten werden aus Cloudant mithilfe eines [Replikation](../api/replication.html)sprozesses in dashDB geladen.
Das heißt, wenn Ihre Cloudant-Daten aktualisiert oder geändert werden,
muss die Replikation der Dokumente in dashDB erneut ausgeführt werden, um
sicherzustellen, dass Ihre Analysetasks weiterhin mit möglichst aktuellen Daten arbeiten. 

Wie bei einer normalen Cloudant-Replikation auch,
werden Daten nur unidirektional übertragen:
für ein Warehouse findet die Übertragung von Cloudant nach dashDB statt.
Nach dem erstmaligen Laden von Daten abonniert das Warehouse Änderungen am Dateninhalt in der Cloudant-Datenbank.
Alle Änderungen werden von der Cloudant-Quelle in das dashDB-Ziel repliziert.
Warehousing ist also eine Art fortlaufender Replikation von Cloudant nach dashDB. 

Im Laufe der Zeit kann sich Ihre Cloudant-Datenbank auch strukturell verändern.
Beispielsweise durch Hinzufügen oder Entfernen von Feldern aus den JSON-Dokumenten.
Tritt dies ein, kann das vom Warehouse verwendete Schema ungültig werden, was dazu führt, dass Fehler berichtet werden, wenn neue Daten
von Cloudant nach dashDB repliziert werden. 

Eine Lösung für dieses Problem bietet die Funktion für
erneutes Scannen von Cloudant-Warehousing.
Sie scannt die Struktur der Cloudant-Datenbank erneut und bestimmt das
neue erforderliche Schema in dashDB.
Die alten Tabellen in dashDB, die während des vorherigen Scanvorgangs erstellt wurden, werden dann gelöscht. Neue Tabellen werden mithilfe des neuen Schemas erstellt und schließlich werden die aktuellen Cloudant-Daten nochmals neu geladen. 

Um die Funktion für erneutes Scannen zu nutzen,
müssen Sie zunächst sicherstellen, dass Ihr Warehouse nicht ausgeführt wird.
Gehen Sie dazu wie folgt vor: 

1.  Wählen Sie die Registerkarte `Integrationen` im Cloudant-Dashboard aus. 
2.  Suchen Sie nach dem Namen des Warehouse, das Sie erneut scannen möchten, auf der Registerkarte `Warehouse`: <br/>![Screenshot der Registerkarte "Warehouse" im Cloudant-Dashboard](../images/selectWarehouse.png)
3.  Klicken Sie auf den Namen des Warehouse. Es ist ein Link und wenn Sie darauf klicken, wird die Detailansicht des Warehouse geöffnet: <br/>![Screenshot der Warehouse-Detailansicht im Cloudant-Dashboard](../images/viewWarehouseDetail.png)
4.  Prüfen Sie den aktuellen Status des Warehouse.
    Ein rotierender grüner Kreis zeigt an, dass das Warehouse aktiv ist.
    Um das Warehouse zu stoppen, klicken Sie auf das Symbol
    `Datenbank stoppen` in der Spalte 'Aktionen': <br/>![Screenshot des Symbols "Warehousedatenbank stoppen" im Cloudant-Dashboard](../images/stopWarehouseDatabase.png)
5.  Wenn die Warehousedatenbank nicht ausgeführt wird,
    ist das Symbol `Erneut scannen` in der Spalte 'Aktion' aktiviert: <br/>![Screenshot des Symbols 'Erneut scannen' im Cloudant-Dashboard](../images/rescanIcon.png)

### Quellendatenbank erneut scannen

![Screenshot des Fensters, in dem Sie die Warehousequellendatenbank erneut scannen können](../images/rescanSource.png)

Wenn Sie auf das Symbol `Erneut scannen` klicken,
haben Sie zwei Möglichkeiten: 

-   Ein einfacher Scan Ihrer Datenbank.
    Dies ist die Standardaktion und sie ähnelt dem anfänglichen Scan Ihrer Datenbank, der ausgeführt
    wurde, als das Warehouse anfänglich erstellt wurde. 
-   Passen Sie das Warehouse-Schema an. 

Wenn Sie die Standardaktion in Form eines einfachen Neuscans auswählen,
wird Ihre Quellendatenbank untersucht und ein neues Warehousedatenbankschema wird generiert.
Sobald der Neuscan abgeschlossen ist, wird das Warehouse gestartet. 

Wenn Sie das Warehouse-Schema anpassen möchten,
aktivieren Sie das Kontrollkästchen `Schema anpassen`, bevor Sie auf
die Schaltfläche `Erneut scannen` klicken. 

![Screenshot der Anzeige 'Quelle erneut scannen', mit aktivierter Option 'Schema anpassen'](../images/rescanSource2.png)

Das Kontrollkästchen `Schema anpassen` aktiviert zwei Optionen. 

1.  Den verwendeten Erkennungsalgorithmus. 
2.  Den Stichprobenumfang. 

### Erkennungsalgorithmus

Die Standardoption für das erneute Scannen ist der Algorithmus `Union`.
Dieser verwendet alle Attribute in allen Cloudant-Datenbankdokumenten, die als Stichproben herangezogen werden,
um einen einzelnen Satz von Tabellen in der Warehousedatenbank zu erstellen.
Im Ergebnis können alle Cloudant-Datenbankdokumente in der Warehousedatenbank gespeichert werden,
aber in manchen Zeilen in der Datenbank bleiben einige Felder leer. 

Die alternative Option für das erneute Scannen ist der Algorithmus `Cluster`.
Dieser gibt Dokumente in der Cloudant-Datenbank an, die denselben Satz von Attributen aufweisen,
und erstellt dann Warehousedatenbank-Tabellenschemas. 

### Stichprobenumfang

Diese Option legt fest, wie viele Dokumente in der Cloudant-Datenbank als Teil der Ermittlung des Schemas überprüft werden.

Der Standardwert ist 10.000 Dokumente. 

Wenn Sie den Wert zu niedrig festlegen, besteht das Risiko, dass manche Cloudant-Dokumente Attribute haben, die nicht erkannt
und deshalb in der Warehousedatenbankstruktur nicht beachtet werden. 

Wenn Sie den Wert zu hoch festlegen, dauert der Scanvorgang zum Bestimmen
der Warehousedatenbankstruktur länger. 

### Nach dem erneuten Scannen

Das Warehouse wird nach dem erneuten Scannen der Cloudant-Datenbank nicht automatisch gestartet.
Stattdessen verbleibt es in einem Haltestatus, damit die Warehousedatenbank angepasst werden kann. 

## Warehouse-Schema anpassen

Es ist möglich, das automatisch
festgelegte Datenbankschema während des ursprünglichen Erstellungsprozesses des Warehouse
oder nach einem erneuten Scannen zu ändern.
Stellen Sie dafür sicher, dass Sie die Option `Schema anpassen` während des Erstellungsprozesses aktivieren: 

![Screenshot der Anzeige zur Erstellung eines Warehouse, mit aktivierter Option 'Schema anpassen'](../images/customizeSchema01.png)

Das Warehouse wird wie üblich in dashDB erstellt, aber nicht direkt gestartet.
Stattdessen haben Sie die Möglichkeit, das Schema anzupassen, bevor Sie fortfahren. 

Klicken Sie dazu auf den Link für Ihr Warehouse: 

![Screenshot der Schaltfläche 'In dashDB öffnen'](../images/openInDashDB.png)

In der resultierenden Anzeige gibt es eine Schaltfläche zum Anpassen des für Ihre Quellendatenbank verwendeten Schemas.
Wenn Sie den Mauszeiger über den Statusanzeiger bewegen, wird bestätigt, dass das Schema angepasst werden kann: 

![Screenshot der Schaltfläche '<source database name> anpassen'](../images/customizeSchema02.png)

Wenn Sie auf die Schaltfläche 'Anpassen' klicken, wird eine Anzeige geöffnet, in der Sie die Felder im Datenbankschema ändern können. 

![Screenshot der Anzeige 'Schema anpassen'](../images/customizeSchema03.png)

Klicken Sie auf die Schaltfläche `Erneut scannen`, um das Schema auf den Standardwert zurückzusetzen: 

![Screenshot der Schaltfläche 'Erneut scannen'](../images/customizeSchema04.png)

Wenn Sie mit dem Datenbankschema für das Warehouse zufrieden sind,
klicken Sie einfach auf die Schaltfläche `Ausführen`: 

![Screenshot der Schaltfläche 'Ausführen'](../images/customizeSchema05.png)

Das Schema wird gespeichert und das Warehouse gestartet. 

### Vorhandenes Warehouse-Schema anpassen

Falls das Datenbankschema für Ihr Warehouse bereits vorhanden ist,
können Sie es [anpassen](#keeping-the-data-and-structure-fresh). 

## Fehlerbehebung

Gelegentlich kann es bei der Verwendung der Warehousing-Funktion zu Fehlern kommen.
Informationen zu einigen dieser Fehler finden Sie weiter unten in diesem Thema. 

Zusätzlich finden Sie auch Informationen zu gängigen Fehlern oder Problemen
sowie Details zu deren Behebung unter [Stacküberlauf ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://stackoverflow.com/questions/tagged/cloudant+dashdb){:new_window}. 

Wenn Sie weitere Hilfe benötigen und keine Lösungen
unter 'Stacküberlauf' finden können, wenden Sie sich an den
[Cloudant-Support ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](mailto:support@cloudant.com){:new_window}. 

### Sichtbare Ausnahmen im Dashboard

Manchmal stellt das Warehouse eine
Fehlerbedingung fest.
Wenn Sie z. B. versuchen, ein Warehouse mithilfe einer
vorhandenen DB2-Datenbank zu erstellen, aber die korrekten Datenbankdetails
nicht eingegeben haben, kann das Warehouse nicht erfolgreich erstellt
werden. 

Wenn eine Fehlerbedingung vorhanden ist, wird der Status
des Warehouse in einen roten Kreis geändert, der darauf hinweist,
dass ein Problem Ihre Aufmerksamkeit erfordert: 

![Screenshot des Fehlerstatusanzeigers](../images/errorIndicator1.png)

Wenn Sie die Maus über den Indikator bewegen, werden weitere Informationen
eingeblendet: 

![Screenshot der Kurzinfo des Fehlerstatus](../images/errorIndicator2.png)

Wenn Sie auf den Anzeiger klicken, wird ein Fenster geöffnet, in dem weitere Details zu dem
Problem gegeben werden.
In diesem Beispiel waren die für die DB2-Verbindung eingegebenen Details nicht gültig: 

![Screenshot der Kurzinfo des Fehlerstatus](../images/errorIndicator3.png)

### Warnungen und Fehler

Änderungen in der Cloudant-Datenbank werden in der gesamten Warehousedatenbank repliziert.
Es ist möglich, dass eine Änderung nicht in das Warehouse oder das zugehörige Schema passt.
Probleme dieser Art werden erkannt und in der Tabelle `OVERFLOW` der Warehousedatenbank protokolliert. 

Wenn das Warehouse-Schema beispielsweise ein Feld `Movie_earnings_rank` vom Typ `VARCHAR` hat,
das bis zu 32 Zeichen lang sein kann, aber eine Änderung in der Cloudant-Datenbank Speicherplatz für 40 Zeichen benötigt,
kann das Feld überlaufen.
Dies würde einen Warnhinweis auslösen, auf den im Statussymbol des
Warehouse-Dashboards hingewiesen wird: 

![Screenshot eines Warnhinweises im Statussymbol](../images/overflowWarning.png)

In der angegebenen Überlauftabelle in der Warehousedatenbank
finden Sie weitere Details zu der Warnung: 

![Screenshot eines Details des Warnhinweises in der Überlauftabelle der Warehousedatenbank](../images/overflowWarningDetail.png)

In diesem Beispiel stellt die Warnung klar, dass im Feld `Movie_earnings_rank` des Cloudant-Dokuments mit der `_ID` `70f6284d2a395396dbb3a60b4cf1cac2` ein Wert abgeschnitten wurde. 

Es gibt zwei Lösungsmöglichkeiten: 

-   Korrigieren Sie das überlaufende Feld im Cloudant-Dokument. 
-   [Aktualisieren Sie das Warehouse-Schema](#customizing-the-warehouse-schema). 

Für welche Option Sie sich entscheiden, hängt davon ab, ob die zu langen Inhalte in dem Feld beabsichtigt sind oder nicht.
Wenn der zusätzliche Inhalt für Ihre Anwendung erforderlich ist,
müssen Sie das [Warehouse-Schema aktualisieren](#customizing-the-warehouse-schema), um die Warnbedingung aufzulösen. 

Ein bedeutenderes Problem ist, wenn ein ganz neues Feld in ein Dokument in der Cloudant-Datenbank eingefügt wird,
dieses Feld aber keine Entsprechung im Warehousedatenbankschema hat.
Dies führt zu einer Fehlerbedingung. 

Beispiel: Ein Dokument in der Cloudant-Datenbank wurde um ein Feld namens `my key`
erweitert, das nicht im Warehousedatenbankschema vorhanden ist: 

![Screenshot eines zusätzlichen Felds 'my key' in einem Dokument](../images/extraField.png)

Der Ergebnis ist eine Fehlerbedingung, auf die im Statussymbol des
Warehouse-Dashboards hingewiesen wird: 

![Screenshot einer Fehlernachricht im Statussymbol](../images/overflowError.png)

In der angegebenen Überlauftabelle in der Warehousedatenbank
finden Sie weitere Details zu dem Fehler: 

![Screenshot eines Details der Fehlernachricht in der Überlauftabelle der Warehousedatenbank](../images/overflowErrorDetail.png)

In diesem Beispiel macht der Fehler deutlich, dass ein Feld gefunden wurde,
das nicht vorhanden war, als das Warehousedatenbankschema erstellt wurde.
Das Feld selbst wurde im Cloudant-Dokument mit der `_ID` `70f6284d2a395396dbb3a60b4cf1cac2` gefunden. 

Es gibt zwei Lösungsmöglichkeiten: 

-   Entfernen Sie das zusätzliche Feld aus dem Cloudant-Dokument. 
-   [Aktualisieren Sie das Warehouse-Schema](#customizing-the-warehouse-schema). 

Für welche Option Sie sich entscheiden, hängt davon ab, ob das zusätzliche Feld beabsichtigt ist oder nicht.
Wenn das zusätzliche Feld für Ihre Anwendung erforderlich ist,
müssen Sie das [Warehouse-Schema aktualisieren](#customizing-the-warehouse-schema), um die Fehlerbedingung aufzulösen. 
