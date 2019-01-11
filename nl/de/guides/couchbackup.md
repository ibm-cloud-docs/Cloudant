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

<!-- Acrolinx: 2017-05-02 -->

# Daten mithilfe von CouchBackup sichern

Das verteilte Wesen von {{site.data.keyword.cloudant}} stellt eine inhärente Art der Datensicherung bereit.
CouchBackup ist ein Befehlszeilentool, das Ihnen eine leistungsfähigere und flexiblere Methode bietet, Ihre Daten zu sichern.
{:shortdesc}

## Übersicht

Die verteilten Vorteile von {{site.data.keyword.cloudant_short_notm}} werden mithilfe von Clustern realisiert.
In einem Cluster werden Daten in einer Datenbank in mehreren Kopien gespeichert.
Die Kopien werden auf mindestens drei getrennte physische Server verteilt.
Die Verwendung von Clustern bei der Datenspeicherung stattet {{site.data.keyword.cloudant_short_notm}}
mit inhärenten Hochverfügbarkeits- und Disaster-Recovery-Merkmalen aus.
Mithilfe von Clustern kann {{site.data.keyword.cloudant_short_notm}} den Verlust eines Knotens
innerhalb des Clusters auffangen, ohne Daten zu verlieren.

Aber selbst mit diesen Hochverfügbarkeits- und Disaster-Recovery-Merkmalen
gibt es Anwendungsfälle, bei denen wir zu einer erweiterten Datensicherung raten würden.

<div id="activepassive"></div>

### Rechenzentrumsausfall und Disaster-Recovery

Eine [fortlaufende Replikation](../api/replication.html#continuous-replication) zwischen Clustern ist eine gute Lösung für das Problem, dass ein {{site.data.keyword.cloudant_short_notm}}-Cluster nicht vollständig verfügbar ist.
Die fortlaufende Replikation ist ein 'Aktiv/Passiv'-Modell.
Der aktive Teil des Modells ist die kontinuierliche Replikation.
Den passiven Teil des Modells gibt es, weil das Replikat üblicherweise nicht auf Anforderungen von Anwendungen reagiert.
Stattdessen wird das Replikat hauptsächlich als Klon der ursprünglichen Datenbank genutzt.
Bei Bedarf kann auf die Daten über den Klon zugegriffen werden.
Alternativ können die Daten im Klon mithilfe der [Replikation](../api/replication.html) an einem anderen Ort wiederhergestellt werden.

>	**Hinweis:** Das Wiederherstellen einer umfangreichen Datenbank durch Replikation aus einem Klon kann lange dauern.

### Hochverfügbarkeit, automatischer Failover und Geo-Lastausgleich

Als Alternative zur [Aktiv/Passiv](#activepassive)-Methode können Sie zwei Rechenzentren für die Verwendung eines Aktiv/Aktiv-Modells konfigurieren.

In diesem Modell werden alle Änderungen, die an einer Datenbank in Cluster A vorgenommen werden, in eine Datenbank im Cluster B repliziert.
Entsprechend werden alle Änderungen, die an der Datenbank in Cluster B vorgenommen werden, in die Datenbank in Cluster A repliziert.

>	**Hinweis:** Dieses Modell kann mithilfe des {{site.data.keyword.cloudant_short_notm}}-Dashboards eingerichtet werden.
Der {{site.data.keyword.cloudant_short_notm}}-Support muss nicht aktiv werden.

Mit diesem Modell können Sie Ihre Datenbankanwendungen für einen Failover auf einen der Cluster konfigurieren, vorausgesetzt, bestimmte Verfügbarkeitskriterien sind erfüllt.
Sie können die Verfügbarkeitskriterien als Teil Ihres Anwendungsdesigns definieren.

Sie können auch einen geografischen Lastausgleich in Ihr Anwendungsdesign einschließen.
Beispielsweise würde eine Clientanwendung, die in einer geografischen Region verwendet wird, üblicherweise eine bessere Leistung erwarten,
wenn die Anwendung auf Daten zugreift, die in einem Cluster in einer naheliegenden geografischen Region gespeichert sind.
Die Clientanwendung so zu konfigurieren, dass sie den nächstgelegenen Cluster erkennt und für Datenbankabfragen eine Verbindung damit herstellt,
würde die Anwendungsleistung optimieren.

Ein Lernprogramm zum Einrichten einer Anwendungsumgebung mit mehreren Regionen finden Sie
[hier ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://www.ibm.com/developerworks/cloud/library/cl-multi-region-bluemix-apps-with-cloudant-and-dyn-trs/index.html){:new_window}.

### Versehentliche oder böswillige Datenänderung

{{site.data.keyword.cloudant_short_notm}} stellt keinen Mechanismus zum Erstellen einer Momentaufnahme Ihrer Datenbank bereit.
Wenn Sie diese Funktionalität benötigen, beispielsweise um einen Rollback auf Dokumentebene durchzuführen, haben Sie folgende Möglichkeiten:

1.	Replikation. Erzielen Sie denselben Effekt, indem Sie die Datenbank replizieren. Stellen Sie sicher, dass Sie sich die finale Sequenz-ID notieren. Replizieren Sie die Datenbank zu einem Zeitpunkt Ihrer Wahl in eine neue Datenbank. Starten Sie die Replikation ab der zuletzt aufgezeichneten Sequenz-ID. Indem Sie die Sequenz-IDs für die Replikationen aufbewahren, können Sie den Effekt eines Rollup-Mechanismus erzeugen. Das Ergebnis entspräche dem Erstellen regulärer wöchentlicher Momentaufnahmen aus täglichen Momentaufnahmen. Eine bekannte Einschränkung dieser Methode ist, dass auch gelöschte oder Tombstone-Dokumentrevisionen ebenso wie nicht gelöste Konflikte repliziert werden.

2.	Speicherauszug der Datenbankinhalte in eine Datei. Dafür stehen diverse Tools zur Verfügung. Die resultierende Speicherauszugsdatei kann auf einem günstigeren blockorientierten Gerät oder in einem Service gespeichert werden. Eine bekannte Einschränkung dieser Methode ist, dass üblicherweise nur die aktuellen Dokumentrevisionen in einem Speicherauszug berücksichtigt werden. Diese Einschränkung bedeutet, dass nicht gelöste Konflikte nicht enthalten sind.

Das Erstellen eines Datenbankspeicherauszugs ist eine effektive Methode, eine Reihe von Sicherungslösungen zu aktivieren.
Deshalb konzentriert sich der Rest dieser Diskussion auf diese Methode.

<!--
https://developer.ibm.com/clouddataservices/2016/03/22/simple-couchdb-and-cloudant-backup/

A useful approach is to have couchbackup's snapshots placed on the {{site.data.keyword.cloud}} Object Storage service, as described here:

https://developer.ibm.com/recipes/tutorials/object-storage-cloudant-backup/
-->
