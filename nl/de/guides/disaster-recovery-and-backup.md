---

copyright:
  years: 2017, 2019
lastupdated: "2019-03-15"

keywords: types and levels of protection, data redundancy, cross-region redundancy, database backup and recovery

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

# Disaster-Recovery und Sicherung
{: #disaster-recovery-and-backup}

Ihre Daten sind wichtig und wertvoll.
Sie möchten Ihre Daten schützen,
um sicherzustellen, dass sie sicher, verfügbar und integer sind.
{{site.data.keyword.cloudantfull}} bietet verschiedene Möglichkeiten, Ihre Daten zu schützen und Ihre Anwendungen betriebsbereit zu halten.
{: shortdesc}

Einige dieser Schutzfunktionen sind automatisch.
Für andere Arten des Schutzes bietet {{site.data.keyword.cloudant_short_notm}} Ihnen
unterstützte Tools, die Ihnen dabei helfen, Ihre eigenen Hochverfügbarkeits- und Disaster-Recovery-Funktionen zu erstellen.

In diesem Dokument erhalten Sie eine Übersicht über die automatischen Funktionen und unterstützten Tools, die von {{site.data.keyword.cloudant_short_notm}} angeboten werden.

## Arten und Ebenen des Schutzes
{: #types-and-levels-of-protection}

Die Art des passenden Schutzes hängt von dem Problem ab, das Sie zu lösen versuchen.

Beispiel: Sie wünschen sich ein hohes Maß an Datenverfügbarkeit, damit Sie auch dann auf Ihre Daten zugreifen können,
wenn Teile der Hardware im System ausfallen.
Das ist eine Hochverfügbarkeitsanforderung.
Dabei geht es um die bestmögliche kontinuierliche Datenverfügbarkeit nach einem Hardwarefehler.
Verschiedene Hochverfügbarkeitsverfahren können ein unterschiedliches Ausmaß an Ausfällen abfangen, bevor Operationen betroffen sind.

Oder Sie suchen nach Wegen, schnell und einfach Daten zu sichern und wiederherzustellen.
Sie möchten beispielsweise nach einem schwerwiegenden oder umfangreichen Hardwarefehler
in der Lage sein, so schnell wie möglich alle Daten auf einem alternativen System verfügbar
zu machen.
Das ist eine Disaster-Recovery-Anforderung.
Von einem Disaster wird üblicherweise gesprochen, wenn eine Datenbank an einem oder an mehreren Standorten nicht mehr verfügbar ist.
So könnte ein Stromausfall dazu führen, dass alle Systeme in einem Datenbankcluster fehlschlagen.
Oder ein umfangreicher Ausfall in einem Netz kann dazu führen, dass Systeme in einem Cluster nicht mehr erreicht werden,
obwohl sie weiterhin ordnungsgemäß ausgeführt werden.

Die Lösung Ihrer Hochverfügbarkeits- oder Disaster-Recovery-Probleme beginnt oft mit dem Runterbrechen des Problems in generische Anforderungen.
Wenn Sie Ihre Anforderungen ermittelt haben, können Sie die passenden Tools und Funktionen einsetzen.
Zusammen können die Tools und Funktionen dann Ihre Hochverfügbarkeits- und Disaster-Recovery-Probleme beheben.

Verschiedene Tools und Funktionen bieten unterschiedliche Ebenen des Schutzes. Die einzelnen Funktionen können mehr oder weniger geeignet sein für Ihre spezifischen Hochverfügbarkeits- oder Disaster-Recovery-Probleme.
{: tip}

{{site.data.keyword.cloudant_short_notm}} stellt eine Auswahl an Tools und Funktionen für Ihre allgemeinen Anforderungen bereit:

1.	Datenredundanz in einer einzigen Region, oder auch [regionsweite automatische Datenredundanz](#in-region-automatic-data-redundancy).
2.	Regionsübergreifende Datenredundanz und Failover, oder auch [regionsübergreifende Redundanz für Disaster-Recovery](#cross-region-redundancy-for-disaster-recovery).
3.	Momentaufnahmesicherung mit Zeitangabe für punktuelle Wiederherstellung mithilfe von herkömmlicher [Datenbanksicherung und -wiederherstellung](#database-backup-and-recovery).

## Regionsweite automatische Datenredundanz
{: #in-region-automatic-data-redundancy}

In einem einzelnen {{site.data.keyword.cloudant_short_notm}}-Konto werden Daten mithilfe
von internen und automatischen Prozessen dreifach gesichert.
Sie müssen nichts tun, um diese interne Datenreplikation zu aktivieren.

Eine regionsweite Datenredundanz ermöglicht einen Hochverfügbarkeitsschutz.
Insbesondere bietet die regionsweite Datenredundanz Schutz für Ihre Daten vor Hardwareausfällen innerhalb der Region.
Wenn eine Hardwareeinheit innerhalb der Region ausfällt,
ist lediglich die Kopie Ihrer Daten, die auf dieser Einheit gespeichert war, nicht mehr verfügbar.
Ihre Anwendungen können weiter verwendet werden, weil {{site.data.keyword.cloudant_short_notm}} Anforderungen automatisch
an die Kopien Ihrer Daten weiterleitet, die auf anderen Hardwareeinheiten innerhalb der Region weiterhin
verfügbar sind.
Währenddessen erkennt die automatische Überwachung des Systems den Ausfall der Hardwareeinheit und stößt Maßnahmen zur Wiederherstellung der vollständigen Redundanz an.

{{site.data.keyword.cloudant_short_notm}}-Konten befinden sich in einer einzigen Region.
Das heißt, dass alle Daten, die Sie in Ihrem Konto speichern, auf verschiedenen Servern gesichert werden, die alle in dieser Region gehostet sind.

Regionsweite automatische Datenredundanz beschränkt sich auf:

1.	Das Bereitstellen von Schutz in nur einer einzigen Region.
2.	Das Verwalten aktueller Daten.

Wenn Sie über die einzelne Region, die Ihrem Konto zugeordnet ist, hinaus Schutz bereitstellen möchten,
verwenden Sie die [regionsübergreifende Redundanz für Disaster-Recovery](#cross-region-redundancy-for-disaster-recovery).

Wenn Sie die Historie Ihrer Daten schützen möchten, z. B. für eine Prüfung der Änderungen, die durch Anwendungen an Daten vorgenommen werden,
verwenden Sie Momentaufnahmen, die von [Datenbanksicherungs- und wiederherstellungstools](#database-backup-and-recovery) erstellt werden.

Zusammenfassend lässt sich sagen, dass eine regionsweite Datenredundanz Hochverfügbarkeitsfunktionalität ermöglicht, indem eine Toleranz für Fehler, die einzelne Systeme innerhalb der Region betreffen, eingebaut wird.

## Regionsübergreifende Redundanz für Disaster-Recovery
{: #cross-region-redundancy-for-disaster-recovery}

Mit der {{site.data.keyword.cloudant_short_notm}}-Replikationsfunktion können Sie eine flexible Disaster-Recovery-Funktion in Ihre Anwendungen integrieren.
Die Hauptmethode, Disaster-Recovery zu aktivieren, ist der Einsatz von {{site.data.keyword.cloudant_short_notm}}-Replikation, um regionsübergreifende Redundanz einzurichten.
In der Folge kann Ihre Anwendung Situationen abfangen, in denen eine oder mehrere Regionen nicht verfügbar sind.

Die grundlegenden Schritte beim Erstellen von regionsübergreifender Redundanz sind:

1.  Erstellen von {{site.data.keyword.cloudant_short_notm}}-Konten in mindestens zwei Regionen.
2.  Bedarfsgerechtes Erstellen von Datenbanken in den einzelnen Regionen.
3.  Einrichten von bidirektionalen fortlaufenden Replikationen zwischen den entsprechenden Datenbanken in den einzelnen Konten für Datenbanken, die mit regionsübergreifender Redundanz gespeichert werden müssen.
4.  Entwerfen und Implementieren Ihrer Anwendungen, damit Datenanforderungen abhängig davon weitergeleitet werden, ob Ihre Umgebung eine Aktiv/Passiv- oder Aktiv/Aktiv-Konfiguration hat.
  Ein detaillierter Leitfaden zu dieser Konfiguration ist [verfügbar](/docs/services/Cloudant?topic=cloudant-configuring-ibm-cloudant-for-cross-region-disaster-recovery#configuring-ibm-cloudant-for-cross-region-disaster-recovery).

Wenn Sie Ihre Anwendungen für die Arbeit mit Daten aus verschiedenen Regionen konzipieren, beachten Sie die folgenden Punkte:

* Anwendungen können Anforderungen an die Datenbank senden, die in nächster Entfernung zu ihrem physischen Standort gehostet sind.
  Die Nutzung der räumlichen Nähe kann Netzlatenz reduzieren und Antwortzeiten verbessern.
  Diese Konfiguration wird als Aktiv/Aktiv-Methode bezeichnet.
  Sie zeichnet sich durch die gleichzeitige Verwendung mehrerer Kopien von Daten aus.
  Anwendungen, die mit einer Aktiv/Aktiv-Konfiguration arbeiten, müssen über eine
  [Konfliktlösungsstrategie](/docs/services/Cloudant?topic=cloudant-document-versioning-and-mvcc#distributed-databases-and-conflicts) verfügen, um Probleme aufgrund mehrerer Kopien von Daten zu vermeiden.
* Standardmäßig können Anwendungen Daten aus einer einzelnen Region abrufen.
  Falls die Region nicht verfügbar ist,
  kann die Anwendung zu einer anderen Region wechseln und Daten daraus abfragen.
  Diese Konfiguration wird als Aktiv/Passiv-Methode bezeichnet.
  Sie zeichnet sich durch die aktive Verwendung nur jeweils einer Gruppe von Daten zu jedem beliebigen Zeitpunkt aus.
* Eine Anwendung kann eine hybride Konfiguration einsetzen,
  in der ein einzelnes Konto für alle Datenschreibanforderungen verwendet wird und
  andere Standorte exklusiv für Leseanforderung verwendet werden.
  Diese Konfiguration wird als Aktiv/Aktiv-Konfiguration für Lesevorgänge betrachtet.
* In einem Störungsszenario muss Ihre Anwendung Datenanforderungen weiterleiten, um auf die Konten zuzugreifen,
  die in den Regionen gehostet sind, die noch online sind.
  Das heißt, Ihre Anwendung muss den Verlust einer Region erkennen und dann Datenanforderungen weiterleiten können.

Zusammenfassend lässt sich sagen, dass regionsübergreifende Redundanz im Grunde eine Hochverfügbarkeitsfunktion ist,
aber bei Ausfällen Verwendung findet, die eine ganze Region betreffen.
Aber die Konfiguration Ihrer Anwendung für die reibungslose Zusammenarbeit mit Konfigurationen mit regionsübergreifender Redundanz implementiert eine echte Disaster-Recovery-Funktionalität.
Der Grund ist, dass die Anwendungen weiterarbeiten können, wenn die Daten in einer Region für einen gewissen Zeitraum nicht verfügbar sind.
{{site.data.keyword.cloudant_short_notm}}-Replikation stellt Datensynchronisierung zwischen Regionen sicher.
Ihre Anwendungen müssen jedoch einen Failover durchführen können auf Kopien Ihrer Daten, die in anderen Regionen gespeichert sind.

## Datenbanksicherung und -wiederherstellung
{: #database-backup-and-recovery}

[Regionsweite automatische Datenredundanz](#in-region-automatic-data-redundancy) bietet Anwendungen hochverfügbaren Zugriff auf Daten.
[Regionsübergreifende Redundanz für Disaster-Recovery](#cross-region-redundancy-for-disaster-recovery) bietet Anwendungen die Möglichkeit der Disaster-Recovery.
Dabei konzentrieren sich beide Funktionalitäten jedoch darauf, nur die _aktuelle_ Kopie Ihrer Daten zu verwalten.

In der Praxis machen Menschen und Anwendungen Fehler und ändern Daten in unbeabsichtigter Weise.
Die Anwendungen selbst können einen gewissen Schutz implementieren, aber nicht alle unerwünschten Änderungen abfangen.
In diesem Fall ist es nützlich, Daten eines früheren Zeitpunkts wiederherstellen zu können.
Datenbanksicherungen unterstützen diese Anforderung.

Neben dem Schutz Ihrer Daten mit Hochverfügbarkeits- und Disaster-Recovery-Funktionen können Sie einen regelmäßigen Speicherauszug Ihrer Datenbankdaten an einen separaten Speicherort in Erwägung ziehen.
Stellen Sie sicher, dass Sie die Sicherungen auf Ihre Vollständigkeit und Richtigkeit prüfen.

{{site.data.keyword.cloudant_short_notm}} unterstützt Tools, mit denen Sie einen Speicherauszug der JSON-Inhalte in Datenbanken
in einer Datei durchführen und später aus diesen Dateien Datenbanken wiederherstellen können.

Die von {{site.data.keyword.cloudant_short_notm}} unterstützten Tools helfen Ihnen bei Folgendem:

*	Sichern vollständiger Datenbanken in eine Datei,
die sich für die weitere Verarbeitung und Sicherung an einem anderen	Standort eignet.
*	Wiederherstellen vollständiger Datenbanken aus einem früheren Zustand, der in Ihrer Sicherungsdatei enthalten ist.

Die von {{site.data.keyword.cloudant_short_notm}} unterstützten Tools haben die folgenden Einschränkungen: 
{: tip}

*	`_security`-Einstellungen werden von den Tools nicht gesichert.
*	Anhänge werden von den Tools nicht gesichert.
*	Sicherungen sind keine präzisen zeitpunktgesteuerten Momentaufnahmen.
	Der Grund dafür ist, dass die Dokumente in der Datenbank in Stapeln abgerufen werden,
  aber andere Anwendungen zur gleichen Zeit Dokumente aktualisieren können.
	Deshalb können sich die Daten in der Datenbank zwischen dem Lesen des ersten und letzten Stapels ändern.
*	In Indexdefinitionen enthaltene Entwurfsdokumente werden gesichert,
	aber wenn Daten wiederhergestellt werden, müssen die Indizes neu erstellt werden.
	Diese Neuerstellung kann abhängig von der Menge der wiederherzustellenden Daten lange dauern.

## Nächste Schritte für Ihre Datenschutzstrategien
{: #next-steps-with-your-data-protection-strategies}

Sie können Anwendungen entwickeln, die auf grundlegenden {{site.data.keyword.cloudant_short_notm}}-Funktionen und
unterstützten Tools basieren, um komplexere Datenschutzstrategien zu ermöglichen.

Beispielszenarios:

*	Wiederherstellen einzelner Dokumente aus früheren Status.
*	Speichern mehrerer älterer Dokumentstatus, um auch sehr alte Daten wiederherstellen zu können.
*	Migrieren älterer Daten in einen günstigeren Speicher, für eine kosteneffiziente Aufbewahrung.

Die Sicherungstools bestehen aus einer Open-Source-Node.js-Befehlszeilenanwendung und -Bibliothek.
Diese ist [unter NPM ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://www.npmjs.com/package/@cloudant/couchbackup){: new_window} verfügbar.

Ideen und Beispiele für die Integration der Tools in Ihre Datenschutzstrategie finden Sie im [Cookbook zur Sicherung](/docs/services/Cloudant?topic=cloudant-ibm-cloudant-backup-and-recovery#ibm-cloudant-backup-and-recovery).
