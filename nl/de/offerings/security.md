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

# Sicherheit
{: #security}

## {{site.data.keyword.cloudant_short_notm}} DBaaS-Datenschutz und -Sicherheit
{: #ibm-cloudant-dbaas-data-protection-and-security}

Der Schutz von Anwendungsdaten für umfangreiche webbasierte und mobile Apps kann komplex sein,
insbesondere bei verteilten und NoSQL-Datenbanken.

Einerseits wird der Aufwand für die Verwaltung Ihrer Datenbanken reduziert,
damit diese kontinuierlich ausgeführt und skaliert werden können, andererseits stellt {{site.data.keyword.cloudantfull}} auch sicher, dass Ihre Daten dabei sicher und geschützt bleiben.
{:shortdesc}

## Physische Plattformen auf höchster Ebene
{: #top-tier-physical-platforms}

Die {{site.data.keyword.cloudant_short_notm}} DBaaS wird physisch bei einem der größten
Anbieter von Cloudinfrastrukturen gehostet, z. B. {{site.data.keyword.cloud}} und Amazon.
Deshalb sind Ihre Daten durch Netz- und physische Sicherheitsmaßnahmen geschützt, die von diesen Anbietern eingesetzt werden. Dazu zählen unter anderem die folgenden:

- Zertifizierungen: Compliance mit SSAE16, SOC2 Typ 1, ISAE 3402, ISO 27001, CSA und anderen Standards.
- Zugriffs- und Identitätsmanagement.
- Allgemeine physische Sicherheit von Rechenzentren und Network Operations Center-Überwachung.
- Abschottung der Server.
- Mit {{site.data.keyword.cloudant_short_notm}} können Sie unter den verschiedenen Anbietern auswählen oder wechseln, wenn sich Ihre SLAs und Kostenanforderungen ändern.

Weitere Details zu den Zertifizierungen finden Sie unter [Informationen zur Compliance](compliance.html).
{:tip}

## Sichere Zugriffssteuerung
{: #secure-access-control}

{{site.data.keyword.cloudant_short_notm}} verfügt über eine Vielzahl integrierter Sicherheitsfunktionen, mit denen Sie den Zugriff auf Daten steuern können:

Funktion | Beschreibung
--------|------------
Authentifizierung | Auf {{site.data.keyword.cloudant_short_notm}} wird über eine HTTP-API zugegriffen. Wenn der API-Endpunkt dies erfordert, wird der Benutzer für jede
HTTPS-Anforderung authentifiziert, die {{site.data.keyword.cloudant_short_notm}} empfängt. {{site.data.keyword.cloudant_short_notm}} unterstützt sowohl traditionelle Zugriffssteuerungsmechanismen als auch IAM-Zugriffssteuerungsmechanismen. Weitere Informationen hierzu finden Sie im [IAM-Leitfaden](../guides/iam.html){:new_window} oder in einer früheren Version des [Dokuments für
die Authentifizierungs-API](../api/authentication.html){:new_window}.
Autorisierung | {{site.data.keyword.cloudant_short_notm}} unterstützt sowohl traditionelle Zugriffssteuerungsmechanismen als auch IAM-Zugriffssteuerungsmechanismen. Weitere Informationen hierzu finden Sie im [IAM-Leitfaden](../guides/iam.html){:new_window} und in einer früheren Version des
[Dokuments für die Berechtigungs-API](../api/authorization.html){:new_window}.
Inflight-Verschlüsselung | Alle Zugriffe auf {{site.data.keyword.cloudant_short_notm}} werden mit HTTPS verschlüsselt.
Verschlüsselung für ruhende Daten | Alle in einer {{site.data.keyword.cloudant_short_notm}}-Instanz gespeicherten ruhenden Daten werden verschlüsselt. Wenn Sie für die Verschlüsselung ruhender Daten BYOK (Bring-Your-Own-Key) benötigen, kann diese Funktion mit {{site.data.keyword.cloud_notm}} Key Protect aktiviert
werden. {{site.data.keyword.cloudant_short_notm}} unterstützt diese Funktion für neue Instanzen des {{site.data.keyword.cloudant_short_notm}}-Plans für dedizierte Hardware, die in allen Regionen bereitgestellt werden. Erstellen Sie zunächst eine Instanz des Plans für dedizierte Hardware über den {{site.data.keyword.cloud_notm}}-Katalog. Senden
Sie anschließend ein Support-Ticket ab. Unser Support-Team koordiniert dann den Abruf der Verschlüsselungsschlüssel für ruhende Daten Ihrer neuen Instanz für den Plan für dedizierte Hardware, die über Ihre Key Protect-Instanz verwaltet werden. 
IP-Whitelisting | {{site.data.keyword.cloudant_short_notm}}-Kunden, die mit einer dedizierten {{site.data.keyword.cloudant_short_notm}}-Umgebung arbeiten, können IP-Adressen auf eine Whitelist setzen, um so den Zugriff auf die dort angegebenen Server und Benutzer einzuschränken. Das IP-Whitelisting steht für {{site.data.keyword.cloud_notm}} Public-Lite-Pläne und -Standard-Pläne, die in Multi-Tenant-Umgebungen bereitgestellt werden, nicht zur Verfügung. Öffnen Sie ein Support-Ticket, um IP-Whitelists für eine bestimmte Gruppe von IP-Adressen oder bestimmte Bereiche von IP-Adressen anzufordern. Beachten Sie hierbei, dass die IP-Whitelists sowohl für die {{site.data.keyword.cloudant_short_notm}}-API als auch für das entsprechende Dashboard gelten. Achten Sie deshalb darauf, alle IP-Adressen für Administratoren einzubinden, die direkt auf das {{site.data.keyword.cloudant_short_notm}}-Dashboard zugreifen müssen.
CORS |Aktivieren Sie CORS-Unterstützung für bestimmte Domänen über das {{site.data.keyword.cloudant_short_notm}}-Dashboard.

<!--
> **Note**: Your data is visible to the {{site.data.keyword.cloudant_short_notm}} 
> worldwide team. If you don’t 
> want our team to see your data, encrypt it before sending it to 
> {{site.data.keyword.IBM_notm}}, and avoid leaking 
> data into your document `_id` and any attachment file names. In addition, 
> when you send personal data, you must use HTTPS to ensure that it is sent securely. 
> HTTP is no longer supported.  

> **Warning**: You are responsible for verifying that 
> {{site.data.keyword.cloudant_short_notm}} can be used to store 
> your data. You must also make sure that your data does not violate applicable 
> data protection laws or any regulations that require security measures 
> beyond those specified in the {{site.data.keyword.cloudant_short_notm}} 
> system requirements and {{site.data.keyword.cloud_notm}} Services terms. You must 
> verify that the security requirements are appropriate for any personal data 
> that is processed. If you are unsure, or intend to store data that is 
> beyond the scope of the {{site.data.keyword.cloudant_short_notm}} terms and conditions, 
> you must get approval from {{site.data.keyword.IBM_notm}} to ensure that it is 
> appropriate for {{site.data.keyword.cloudant_short_notm}} to store your data.
-->

## Schutz vor Datenverlust oder Beschädigung
{: #protection-against-data-loss-or-corruption}

{{site.data.keyword.cloudant_short_notm}} enthält eine Reihe von Funktionen,
die Ihnen dabei helfen, Datenqualität und Verfügbarkeit aufrecht zu erhalten:

Funktion | Beschreibung
--------|------------
Redundante und dauerhafte Datenspeicherung |Standardmäßig speichert {{site.data.keyword.cloudant_short_notm}} drei Kopien jedes Dokuments auf drei verschiedenen Knoten
in einem Cluster auf Platte. Dies stellt sicher, dass
es immer eine funktionierende Kopie Ihrer Daten gibt, unabhängig von Ausfällen.
Datenreplikation und Export |Sie können Ihre Datenbanken fortlaufend zwischen
Clustern in verschiedenen Rechenzentren oder in einen lokalen {{site.data.keyword.cloudant_short_notm}} Local-Cluster
bzw. nach Apache CouchDB replizieren. Eine andere Option ist, Daten aus
  {{site.data.keyword.cloudant_short_notm}} (im JSON-Format)
  an andere Standorte oder in andere Quellen (z. B. Ihre eigenen Rechenzentren) zu exportieren, um zusätzliche Datenredundanz zu erzielen.
