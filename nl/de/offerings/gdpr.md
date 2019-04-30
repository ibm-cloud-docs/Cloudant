---

copyright:
  years: 2018, 2019
lastupdated: "2019-03-18"

keywords: audit access ibm cloudant, supported classifications of personal data, personal data, sensitive personal data, restrictions on processing, encrypt data, data locations, service security, delete data

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

# Datenschutz-Grundverordnung (DSGVO)
{: #general-data-protection-regulation-gdpr-}

Mit der DSGVO (Datenschutz-Grundverordnung) soll in der gesamten EU ein harmonisierter Rechtsrahmen
für den Datenschutz geschaffen werden, in dem Bürger wieder die Kontrolle über ihre personenbezogenen Daten übernehmen,
während gleichzeitig denen, die diese Daten an einem beliebigen Standort weltweit hosten und 'verarbeiten' strikte Regeln auferlegt werden. Die Verordnung führt zudem Regeln in Bezug auf den freien Datenverkehr innerhalb und außerhalb der EU ein. 

Mit der [Datenschutz-Grundverordnung ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://www.eugdpr.org/){: new_window}
können sich {{site.data.keyword.cloudantfull}}-Kunden darauf verlassen, dass das
{{site.data.keyword.cloudant_short_notm}}-Team mit den neuen Datenschutzstandards und -gesetzen
vertraut ist und diese einhält.
Darüber hinaus bietet {{site.data.keyword.IBM}} umfassende Lösungssuites,
die Unternehmen unterschiedlicher Größe dabei unterstützen,
eigene interne Datengovernanceanforderungen zu erfüllen.

## Informationen zur auditfähigen Steuerung des Zugriffs auf {{site.data.keyword.cloudant_short_notm}}
{: #how-do-i-audit-access-to-ibm-cloudant-}

Informationen zur Protokollierung finden Sie in [Prüfprotokollierung](/docs/services/Cloudant?topic=cloudant-audit-logging#audit-logging){: new_window}. 

## Unterstützte Klassifizierungen personenbezogener Daten
{: #supported-classifications-of-personal-data}

Die folgenden Kategorien personenbezogener Daten werden im Rahmen der DSGVO von {{site.data.keyword.cloudant_short_notm}}
unterstützt:

**Personenbezogene Daten**, wie zum Beispiel:
 * Identität/Personenstand
 * Privatleben
 * Berufsleben
 * Standortdaten
 * Verbindungs-/Gerätedaten

**Sensible personenbezogene Daten**, beschränkt auf:
  * Für Gesundheitsdaten gelten zusätzliche Bedingungen, die in der [Servicebeschreibung für dedizierte {{site.data.keyword.cloudant_short_notm}}-Cluster ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://www-03.ibm.com/software/sla/sladb.nsf/pdf/6756-04/$file/i126-6756-04_05-2018_en_US.pdf){: new_window} und in der Servicebeschreibung für zusätzliche [{{site.data.keyword.cloud}}-Services ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://www-03.ibm.com/software/sla/sladb.nsf/pdf/6627-04/$file/i126-6627-04_04-2018_en_US.pdf){: new_window} behandelt werden.

Wenn Sie Gesundheitsdaten speichern, *müssen* Sie die folgenden Tasks ausführen:
 - {{site.data.keyword.cloudant_short_notm}} benarichtigen, bevor Daten erfasst werden.
 - Einen mit HIPAA konformen dedizierten Cluster anfordern.

Weitere Informationen zu den unterstützten Klassifizierungen personenbezogener Daten finden Sie im
[Data Sheet Addendum (DSA) unter '2. Personenbezogene Daten' ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/software/reports/compatibility/clarity-reports/report/html/softwareReqsForProduct?deliverableId=2EBB5860B34311E7A9EB066095601ABB){: new_window}.

## Personenbezogene Daten
{: #data-about-me}

{{site.data.keyword.cloudant_short_notm}} erfasst bestimmte Daten über die Nutzer
und stellt damit einen Verantwortlichen für diese personenbezogenen Daten dar. Die von {{site.data.keyword.cloudant_short_notm}} erfassten Daten sind vom jeweiligen Kontotyp abhängig.

Wenn Sie über einen {{site.data.keyword.cloudant_short_notm}} Dedicated Cluster/{{site.data.keyword.cloudant_short_notm}} Enterprise Cluster verfügen,
erfassen wir Ihre personenbezogenen Daten und gelten somit als Verantwortlicher
für Ihre Daten im Sinne der DSGVO. 
Wenn Sie über einen {{site.data.keyword.cloudant_short_notm}} Dedicated Cluster/{{site.data.keyword.cloudant_short_notm}} Enterprise Cluster verfügen,
erfassen wir die folgendenden Daten:

 * Name
 * E-Mail-Adresse

Die von {{site.data.keyword.cloudant_short_notm}} erfassten Daten können über das {{site.data.keyword.cloudant_short_notm}}-Dashboard angezeigt und aktualisiert werden.

Wenn Sie über ein von {{site.data.keyword.cloud_notm}} (mit dedizierter Instanz) bereitgestelltes Konto verfügen,
erfasst {{site.data.keyword.cloudant_short_notm}} _keine_ der oben angeführten personenbezogenen Daten. Diese Daten werden von {{site.data.keyword.cloud_notm}} gespeichert.

{{site.data.keyword.cloudant_short_notm}} verarbeitet in begrenztem Umfang personenbezogene Daten des Kunden während der Ausführung des Service und nutzt sie zur Optimierung
der Benutzerschnittstelle. In {{site.data.keyword.cloudant_short_notm}} werden E-Mail-Adressen bei Bedarf zur Kontaktaufnahme mit den Kunden verwendet. Auch bei der Überwachung
der Kundeninteraktionen mit dem {{site.data.keyword.cloudant_short_notm}}-Dashboard werden von {{site.data.keyword.cloudant_short_notm}} personenbezogene Daten verarbeitet.

### Einschränkung der Verarbeitung
{: #restriction-of-processing}

Daten zu Dashboardinteraktionen werden von {{site.data.keyword.cloudant_short_notm}} an Segment gesendet. Es ist möglich, bei {{site.data.keyword.cloudant_short_notm}} eine Einschränkung dieser Verarbeitung personenbezogener Kundendaten über eine [{{site.data.keyword.cloudant_short_notm}} Support-Anfrage](mailto:support@cloudant.com) anzufordern. Nach Erhalt
einer solchen Anfrage löscht {{site.data.keyword.cloudant_short_notm}} die Daten des Kunden, die an Segment
gesendet wurden, und verhindert das Senden weiterer Daten. {{site.data.keyword.cloudant_short_notm}} muss jedoch
dedizierte Kunden weiterhin per E-Mail kontaktieren können und bietet eine Schnittstelle für Kunden an, um diese Daten
entweder direkt oder über die Kundenkonfiguration ihrer Kontaktdetails über die zugehörigen
{{site.data.keyword.cloud_notm}}-Kontodetails auf dem neuesten Stand zu halten.

## Verschlüsselung der {{site.data.keyword.cloudant_short_notm}}-Datenbank
{: #is-our-ibm-cloudant-database-encrypted-}

Alle Cluster verfügen über ein verschlüsseltes Dateisystem (Verschlüsselung ruhender Daten), das Linux Unified Key Setup (LUKS) verwendet. Die Daten in der Datenbank
sind für unsere Operations- und Support-Teams (siehe unten) sichtbar.

Sie müssen sensible Daten, die für {{site.data.keyword.cloudant_short_notm}} nicht einsehbar sein sollen,
verschlüsseln oder anderweitig schützen (pseudonymisieren), bevor Sie sie an uns senden. Verwenden Sie keine personenbezogenen Daten als Dokument-ID
(`_id`) in Ihren URLs (z. B. `https://$ACCOUNT.cloudant.com/$DATABASE/$DOCUMENT_ID`), da diese Angaben stets sichtbar sind und in die Zugriffsprotokolle geschrieben werden.

## Datenspeicherstandorte
{: #data-locations}

Standorte, an denen {{site.data.keyword.cloudant_short_notm}} personenbezogene Daten verarbeitet, werden über DSA
zur Verfügung gestellt und regelmäßig aktualisiert.

Weitere Informationen zu den Datenspeicherstandorten finden Sie im
[DSA unter '7. {{site.data.keyword.IBM_notm}} Standorte für das Hosting und die Verarbeitung' ![Symbol für externenLink](../images/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/software/reports/compatibility/clarity-reports/report/html/softwareReqsForProduct?deliverableId=2EBB5860B34311E7A9EB066095601ABB){: new_window}.


## Servicesicherheit
{: #service-security}

### {{site.data.keyword.cloudant_short_notm}} sicher verwenden
{: #using-ibm-cloudant-securely}

Als Nutzer von {{site.data.keyword.cloudant_short_notm}} sollten Sie Folgendes tun:

 * Verwenden Sie die CORS-Standardkonfiguration, um einen nicht erwarteten Zugriff zu verhindern.
 * Verwenden Sie API-Schlüssel, wann immer möglich, sodass Komponenten über Zugriff 'mit möglichst niedriger Berechtigungsstufe' in Verbindung mit dem Prüfprotokoll verfügen. Mit diesem Verfahren wissen Sie, wer auf welche Daten zugreift.
 * Verschlüsseln oder schützen (pseudonymisieren) Sie sensible Daten, die für {{site.data.keyword.cloudant_short_notm}} unsichtbar bleiben müssen.

### Physische Sicherheitsmaßnahmen und Sicherheitsmaßnahmen für die Umgebung
{: #physical-and-environmental-security-measures}

Die physische Sicherheit unserer Rechenzentren übernehmen unsere Infrastrukturanbieter: {{site.data.keyword.cloud}},
AWS und 21Vianet. Alle besitzen extern geprüfte Zertifizierungen für ihre physische Sicherheit. Weitere Details
zu den physischen Sicherheitsmaßnahmen in den Rechenzentren werden von {{site.data.keyword.cloudant_short_notm}} nicht bereitgestellt.

Die physische Sicherheit der von unseren Mitarbeitern genutzten Bürostandorte wird von der {{site.data.keyword.IBM_notm}} Corporation übernommen. 
Zertifizierungsdetails und Beglaubigungsberichte (d. h. ISO und SOC2) können dem Kunden auf Anfrage zur Verfügung gestellt werden.

### Technische und organisatorische Maßnahmen
{: #technical-and-organisational-measures}

Technische und organisatorische Maßnahmen werden von {{site.data.keyword.cloudant_short_notm}} eingesetzt,
um die Sicherheit personenbezogener Daten zu gewährleisten. {{site.data.keyword.cloudant_short_notm}} verfügt über extern geprüfte Zertifizierungen für die von {{site.data.keyword.cloudant_short_notm}} eingesetzten Kontrollmechanismen. 
Zertifizierungsdetails und Beglaubigungsberichte (d. h. ISO und SOC2) können dem Kunden auf Anfrage zur Verfügung gestellt werden.

### Servicezugriff auf Daten
{: #service-access-to-data}

Mitarbeiter des Operations- und Support-Teams von {{site.data.keyword.cloudant_short_notm}} verfügen über
Zugriff auf Kundendaten und können bei Routineoperationen darauf zugreifen. Dieser Zugriff erfolgt nur nach Bedarf, um den Service zu betreiben und zu unterstützen. 
Darüber hinaus ist der Zugriff auf den *begründeten Informationsbedarf* beschränkt und wird protokolliert, überwacht und geprüft.

## Daten löschen
{: #deletion-of-data}

### Dokument löschen
{: #deleting-a-document}

Wenn ein Dokument gelöscht wird, erstellt die Datenbank einen 'Tombstone' (eine Markierung für ein gelöschtes Objekt). Die Informationen,
die ein Tombstone enthält, sind davon abhängig, auf welche Weise das Dokument gelöscht wird:

 - Bei einem Aufruf `DELETE` enthält der Tombstone die Felder `_id`, `_rev` und `_deleted`.
 - Wird der Löschvorgang durchgeführt, indem das Dokument mit dem Feld `_deleted: true` aktualisiert
und `PUT` oder `POST` verwendet wird, enthält der Tombstone die Daten des Dokumenthauptteils. Diese Vorgehensweise
kann unter bestimmten Umständen nützlich sein, z. B., wenn die Gründe für das Löschen des Dokuments im zugehörigen Tombstone aufgezeichnet werden.

Weitere Informationen zum Löschen von Tombstones finden Sie in [Einfaches Entfernen von Tombstone-Dokumenten](/docs/services/Cloudant?topic=cloudant-documents#tombstone-documents){: new_window}.

### Entfernen eines gelöschtes Dokuments
{: #when-is-a-deleted-document-removed-}

Die Komprimierung wird automatisch ausgeführt und entfernt regelmäßig alte (gelöschte oder andere) Revisionen aus der Datenbank,
indem nur 'Leaf'-Revisionen in eine neue Datei geschrieben werden. Die Angaben für `_id` und `_rev` werden
von {{site.data.keyword.cloudant_short_notm}} in einem Verlaufsprotokoll dokumentiert, um die Replikation zu ermöglichen. Alte Dokumenthauptteile werden jedoch nicht gespeichert.

{{site.data.keyword.cloudant_short_notm}} macht die CouchDB-Komprimierungs-API nicht zugänglich.
{: tip}

Es kann von {{site.data.keyword.cloudant_short_notm}} nicht garantiert werden, dass eine Datenbank in einem bestimmten Zeitraum komprimiert wird. 
Die Komprimierung wird im Speichertier als Hintergrundprozess ausgeführt
und Datenbanken werden kontinuierlich komprimiert. Eine Garantie, dass die Daten betroffen sind, die Sie soeben gelöscht/geändert haben,
kann nicht gegeben werden.

{{site.data.keyword.cloudant_short_notm}} akzeptiert Anforderungen hinsichtlich des *Rechts auf Vergessen*
über den [{{site.data.keyword.IBM_notm}} Datenschutzbeauftragten (Data Privacy Officer, DPO) ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://w3-03.ibm.com/ibm/privacy/index.html){: new_window}. 
Wenn eine Anforderung hinsichtlich des *Rechts auf Vergessen* über den {{site.data.keyword.IBM_notm}} Datenschutzbeauftragten gestellt wird,
wird diese von {{site.data.keyword.cloudant_short_notm}} verifiziert; anschließend wird die Datenbankkomprimierung explizit ausgelöst und sichergestellt, dass die Komprimierung erfolgt ist.
Am Ende dieses Prozesses bleibt als einzige Version des Dokuments der zugehörige Tombstone erhalten
(`_id`, `_rev`, `_deleted` sowie alle Felder, die Ihre Anwendung hier einbezieht).

### Tombstones entfernen
{: #removal-of-tombstones}

{{site.data.keyword.cloudant_short_notm}} kann bei Bedarf alle Referenzen und Daten für ein Dokument
vollständig entfernen. Diese Aufgabe ist ein vom Operator verwalteter Prozess, der als Bereinigung bezeichnet wird. Bevor eine Bereinigung von Dokumenten angefordert wird, muss Klarheit darüber bestehen,
dass bereinigte Dokumente nach Abschluss des Prozesses von {{site.data.keyword.cloudant_short_notm}}
*nicht wiederhergestellt* werden können.

Die CouchDB-Bereinigungs-API wird von {{site.data.keyword.cloudant_short_notm}} nicht unterstützt.
{: tip}

Im Rahmen der DSGVO ist eine Bereinigung nur erforderlich, wenn personenbezogene Daten in einer Dokument-ID verwendet werden. In einer `_id`
sollten aus zahlreichen Gründen keine personenbezogenen Daten gespeichert werden.
Es gibt jedoch einige wenige Ausnahmen (z. B. eine eindeutige E-Mail-Adresse). Die Daten sollten möglichst verschlüsselt oder pseudonymisiert werden,
sodass sie von {{site.data.keyword.cloudant_short_notm}} nicht gelesen werden können.

Wenn ein Dokument aufgrund einer Anforderung hinsichtlich des *Rechts auf Vergessen* entfernt werden muss:

1. Senden Sie eine Anforderung an den [{{site.data.keyword.IBM_notm}} Datenschutzbeauftragten ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://w3-03.ibm.com/ibm/privacy/index.html){: new_window}, in der Sie angeben, dass bestimmte `_id`-Dokumentwerte bereinigt werden sollen. Geben Sie auch den Grund hierfür an.
1. Nach Erhalt der formellen Anforderung durch den {{site.data.keyword.IBM_notm}} Datenschutzbeauftragten verifizieren die Mitarbeiter des
{{site.data.keyword.cloudant_short_notm}}-Operations-Teams die Anforderung, um zu bestätigen, dass die `id` personenbezogene Daten enthält. Es werden von {{site.data.keyword.cloudant_short_notm}} keine Daten bereinigt, deren `_id` keine personenbezogenen Daten enthält. 
1. {{site.data.keyword.cloudant_short_notm}} löst den Bereinigungsvorgang aus, um die angeforderten Daten dauerhaft zu entfernen.

Dieser Prozess ist nur für Löschanforderungen in Notfällen (z. B. für das *Recht auf Vergessen*) vorgesehen
und darf nicht als langfristige Lösung eingesetzt werden. Wenn in Ihrer Anwendung bewusst personenbezogene Daten in Dokument-IDs verwendet werden,
muss sie so geändert werden, dass diese personenbezogenen Daten pseudonymisiert oder aus den Dokument-IDs entfernt werden. Für eine regelmäßige Bereinigung steht das {{site.data.keyword.cloudant_short_notm}}-Operations-Team nicht zur Verfügung. 
Deshalb lehnt {{site.data.keyword.cloudant_short_notm}} die folgenden Bereinigungsanforderungen ab:

1. Eine Anforderung einer regelmäßigen Bereinigung, zum Beispiel *alle 30 Tage*.
1. Eine Anforderung für mehr als 100 Dokumente.

Selbst bei einer Bereinigung kann es vorkommen, dass personenbezogene Daten im Feld `_id`
an anderen unerwünschten Stellen (z. B. in den {{site.data.keyword.cloudant_short_notm}}-Protokollen) auftauchen.
Deshalb sollten personenbezogene Daten in diesen Feldern vermieden werden. 
Es besteht für {{site.data.keyword.cloudant_short_notm}} ein geschäftsbezogener Grund, dass diese Protokolle von uns gespeichert werden.
Protokollzeilen, die `_id`-Dokumentwerte enthalten, werden daher nicht entfernt.

### Löschen einer Datenbank
{: #what-about-deleting-a-database-}

Wenn eine Datenbank gelöscht wird, wird sie für bis zu 48 Stunden in einen Papierkorb verschoben.
Danach wird sie aus dem Dateisystem entfernt. Das {{site.data.keyword.cloudant_short_notm}}-Team erstellt *keine* Sicherungskopien Ihrer Datenbanken.
Diese Aufgabe fällt in den *Verantwortungsbereich des Kunden*. Sie müssen daher sicherstellen,
dass alle Kopien Ihrer Datenbank aus Ihrem System entfernt werden. Weitere Informationen finden Sie in
[{{site.data.keyword.cloudant_short_notm}} - Sicherung und Wiederherstellung](/docs/services/Cloudant?topic=cloudant-ibm-cloudant-backup-and-recovery#ibm-cloudant-backup-and-recovery){: new_window}. 

Wenn Sie weitere Unterstützung benötigen, wenden Sie sich an den
[{{site.data.keyword.cloudant_short_notm}} Support ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](mailto:support@cloudant.com).

