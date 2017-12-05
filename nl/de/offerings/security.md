---

copyright:
  years: 2017
lastupdated: "2017-07-13"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-04-28 -->

# Sicherheit

## Cloudant DBaaS-Datenschutz und -Sicherheit

Der Schutz von Anwendungsdaten für umfangreiche webbasierte und mobile Apps kann komplex sein,
insbesondere bei verteilten und NoSQL-Datenbanken. 

Einerseits wird der Aufwand für die Verwaltung Ihrer Datenbanken reduziert,
damit diese kontinuierlich ausgeführt und skaliert werden können, andererseits stellt {{site.data.keyword.cloudantfull}} auch sicher, dass Ihre Daten dabei sicher und geschützt bleiben. 

## Physische Plattformen auf höchster Ebene

Die {{site.data.keyword.cloudant_short_notm}} DBaaS wird physisch bei einem der größten
Anbieter von Cloudinfrastrukturen gehostet, z. B. {{site.data.keyword.BluSoftlayer_full}} und Amazon.
Deshalb sind Ihre Daten durch Netz- und physische Sicherheitsmaßnahmen geschützt, die von diesen Anbietern eingesetzt werden. Dazu zählen unter anderem die folgenden: 

- Zertifizierungen: Compliance mit SSAE16, SOC2 Typ 1, ISAE 3402, ISO 27001, CSA und anderen Standards. 
- Zugriffs- und Identitätsmanagement.
- Allgemeine physische Sicherheit von Rechenzentren und Network Operations Center-Überwachung. 
- Abschottung der Server. 
- Mit {{site.data.keyword.cloudant_short_notm}} können Sie unter den verschiedenen Anbietern auswählen oder wechseln, wenn sich Ihre SLAs und Kostenanforderungen ändern. 

> **Hinweis:** Weitere Details zu den Zertifizierungen finden Sie unter [Informationen zur Compliance](compliance.html).

## Sichere Zugriffssteuerung

In {{site.data.keyword.cloudant_short_notm}} sind eine Vielzahl von Sicherheitsfunktionen integriert,
mit denen Sie den Zugriff auf Daten steuern können: 

- Authentifizierung: Auf {{site.data.keyword.cloudant_short_notm}} wird
  über eine HTTP-API zugegriffen.
  Wenn der API-Endpunkt dies erfordert, wird der Benutzer für jede
  HTTPS- oder HTTP-Anforderung authentifiziert, die
  {{site.data.keyword.cloudant_short_notm}} empfängt. 
- Autorisierung: Bestimmten Datenbanken Lese-, Schreib- und Adminberechtigungen erteilen. 
- Inflight-Verschlüsselung: Alle Zugriffe auf
  {{site.data.keyword.cloudant_short_notm}} werden mithilfe von HTTPS verschlüsselt. 
- Verschlüsselung gespeicherter Daten: Daten, die in
  {{site.data.keyword.cloudant_short_notm}} auf Platte gespeichert sind, können verschlüsselt werden. 
  > **Hinweis**: Daten, die in einer {{site.data.keyword.Bluemix_notm}} {{site.data.keyword.cloudant_short_notm}}-Instanz gespeichert sind, werden immer verschlüsselt. 
- API-Zugriff: Auf {{site.data.keyword.cloudant_short_notm}} wird programmgesteuert
  mithilfe einer API über sicheres HTTP (HTTPS) zugegriffen.
  API-Schlüssel können über das {{site.data.keyword.cloudant_short_notm}}-Dashboard generiert werden. 
- IP-Whitelisting: {{site.data.keyword.cloudant_short_notm}}-Kunden in dedizierten Umgebungen
  können IP-Adressen einer Whitelist hinzufügen, um den Zugriff nur angegebenen Servern und Benutzern zu gewähren. 
- CORS: Aktivieren Sie CORS-Unterstützung für bestimmte Domänen über das
  {{site.data.keyword.cloudant_short_notm}}-Dashboard. 

## Schutz vor Datenverlust oder Beschädigung

{{site.data.keyword.cloudant_short_notm}} enthält eine Reihe von Funktionen,
die Ihnen dabei helfen, Datenqualität und Verfügbarkeit aufrecht zu erhalten: 

- Redundante und dauerhafte Datenspeicherung: Standardmäßig speichert {{site.data.keyword.cloudant_short_notm}} drei Kopien jedes Dokuments auf drei verschiedenen Knoten in einem Cluster auf Platte. Dies stellt sicher, dass
es immer eine funktionierende Kopie Ihrer Daten gibt, unabhängig von Ausfällen. 
- Datenreplikation und Export: Sie können Ihre Datenbanken fortlaufend zwischen
  Clustern in verschiedenen Rechenzentren oder in ein lokales Cloudant Local-Cluster bzw nach Apache CouchDB replizieren.
  Eine andere Option ist, Daten aus
  {{site.data.keyword.cloudant_short_notm}} (im JSON-Format)
  an andere Standorte oder in andere Quellen (z. B. Ihre eigenen Rechenzentren) zu exportieren, um zusätzliche Datenredundanz zu erzielen. 
