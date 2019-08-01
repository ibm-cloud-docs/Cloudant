---

copyright:
  years: 2017, 2019
lastupdated: "2019-06-12"

keywords: dbaas data protection, top-tier physical platforms, secure access control, data loss, corruption

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

# Sicherheit
{: #security}


## {{site.data.keyword.cloudant_short_notm}} DBaaS-Datenschutz und -Sicherheit
{: #ibm-cloudant-dbaas-data-protection-and-security}

Der Schutz von Anwendungsdaten für umfangreiche webbasierte und mobile Apps kann komplex sein,
insbesondere bei verteilten und NoSQL-Datenbanken.

Einerseits wird der Aufwand für die Verwaltung Ihrer Datenbanken reduziert,
damit diese kontinuierlich ausgeführt und skaliert werden können, andererseits stellt {{site.data.keyword.cloudantfull}} auch sicher, dass Ihre Daten dabei sicher und geschützt bleiben.
{: shortdesc}

## Physische Systeme auf höchster Ebene
{: #top-tier-physical-platforms}

Die {{site.data.keyword.cloudant_short_notm}} DBaaS wird physisch bei einem der größten
Anbieter von Cloudinfrastrukturen gehostet, z. B. {{site.data.keyword.cloud}} und Amazon.
Deshalb sind Ihre Daten durch Netz- und physische Sicherheitsmaßnahmen geschützt, die von diesen Anbietern eingesetzt werden. Dazu zählen unter anderem die folgenden:

- Zertifizierungen: Compliance mit SSAE16, SOC2 Typ 1, ISAE 3402, ISO 27001, CSA und anderen Standards.
- Zugriffs- und Identitätsmanagement.
- Allgemeine physische Sicherheit von Rechenzentren und Network Operations Center-Überwachung.
- Abschottung der Server.
- Mit {{site.data.keyword.cloudant_short_notm}} können Sie unter den verschiedenen Anbietern auswählen oder wechseln, wenn sich Ihre SLAs und Kostenanforderungen ändern.

Weitere Details zu den Zertifizierungen finden Sie unter [Informationen zur Compliance](/docs/services/Cloudant?topic=cloudant-compliance#compliance).
{: tip}

## Sichere Zugriffssteuerung
{: #secure-access-control}

{{site.data.keyword.cloudant_short_notm}} verfügt über eine Vielzahl integrierter Sicherheitsfunktionen, mit denen Sie den Zugriff auf Daten steuern können:

Funktion | Beschreibung
--------|------------
Authentifizierung | Auf {{site.data.keyword.cloudant_short_notm}} wird über eine HTTP-API zugegriffen. Wenn der API-Endpunkt dies erfordert, wird der Benutzer für jede
HTTPS-Anforderung authentifiziert, die {{site.data.keyword.cloudant_short_notm}} empfängt. {{site.data.keyword.cloudant_short_notm}} unterstützt sowohl traditionelle Zugriffssteuerungsmechanismen als auch IAM-Zugriffssteuerungsmechanismen. Weitere Informationen hierzu finden Sie im [IAM-Leitfaden](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-){: new_window} oder in einer früheren Version des [Dokuments für
die Authentifizierungs-API](/docs/services/Cloudant?topic=cloudant-authentication#authentication){: new_window}.
Autorisierung | {{site.data.keyword.cloudant_short_notm}} unterstützt sowohl traditionelle Zugriffssteuerungsmechanismen als auch IAM-Zugriffssteuerungsmechanismen. Das {{site.data.keyword.cloudant_short_notm}}-Team empfiehlt die Verwendung der IAM-Zugriffssteuerung für die Authentifizierung, falls möglich. Wenn Sie die traditionelle {{site.data.keyword.cloudant_short_notm}}-Authentifizierung verwenden, wird die Verwendung von [API-Schlüsseln](/docs/services/Cloudant?topic=cloudant-authorization#api-keys){: new_window} anstelle von Berechtigungsnachweisen für den programmgesteuerten Zugriff und für Replikationsjobs empfohlen. Weitere Informationen hierzu finden Sie im [IAM-Leitfaden](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-){: new_window} oder in der früheren Version des [Dokuments für die Berechtigungs-API](/docs/services/Cloudant?topic=cloudant-authentication#authentication){: new_window} und in einer früheren Version des [Dokuments für die Berechtigungs-API](/docs/services/Cloudant?topic=cloudant-authorization#authorization){: new_window}.
Verschlüsselung für ruhende Daten | Alle in einer {{site.data.keyword.cloudant_short_notm}}-Instanz gespeicherten ruhenden Daten werden verschlüsselt. Wenn Sie für die Verschlüsselung ruhender Daten BYOK (Bring-Your-Own-Key) benötigen, kann diese Funktion mit {{site.data.keyword.cloud_notm}} Key Protect aktiviert
werden. {{site.data.keyword.cloudant_short_notm}} unterstützt diese Funktion für neue Instanzen des {{site.data.keyword.cloudant_short_notm}}-Plans für dedizierte Hardware, die in allen Regionen bereitgestellt werden. Erstellen Sie zunächst eine Instanz des Plans für dedizierte Hardware über den {{site.data.keyword.cloud_notm}}-Katalog. Senden
Sie anschließend ein Support-Ticket ab. Unser Support-Team koordiniert dann den Abruf der Verschlüsselungsschlüssel für ruhende Daten Ihrer neuen Instanz für den Plan für dedizierte Hardware, die über Ihre Key Protect-Instanz verwaltet werden.
Inflight-Verschlüsselung | Alle Zugriffe auf {{site.data.keyword.cloudant_short_notm}} werden mit HTTPS verschlüsselt.
TLS | Es wird empfohlen, TLS 1.2 oder 1.3 für den gesamten Zugriff auf {{site.data.keyword.cloudant_short_notm}} zu verwenden. (***Im Juni 2019 wird die {{site.data.keyword.cloudant_short_notm}}-Unterstützung für die Verwendung älterer Versionen (TLS 1.0 und 1.1) eingestellt und es wird nur noch TLS 1.2 oder höher unterstützt.***) Das von {{site.data.keyword.cloudant_short_notm}} für HTTPS-Verbindungen verwendete Zertifikat wird von einer allgemein anerkannten Zertifizierungsstelle signiert, die von allen Browsern, Betriebssystemen und anderen Softwaresystemen wie Java Development Kit (JDK) vorab anerkannt wird. Wir verpflichten uns, immer ein gültiges (nicht abgelaufenes) TLS-Zertifikat zu veröffentlichen, das von einer allgemein anerkannten Zertifizierungsstelle signiert ist. Wir können Änderungen jedoch nicht mit den Kunden abstimmen und verpflichten uns nicht, stets bei DigiCert zu bleiben. Um einen unterbrechungsfreien Zugriff auf den {{site.data.keyword.cloudant_short_notm}}-Service zu gewährleisten, wird den Kunden dringend davon abgeraten, das aktuelle Zertifikat zu fixieren, das bei Gefährdungen ersetzt werden oder seine Gültigkeit verlieren kann. Stattdessen wird empfohlen, dass Kunden die Standardzertifikatpakete für ihre Betriebssysteme und Browser verwenden, die auch bei Zertifikatänderungen weiterhin die Sicherheit des Service aufrecht erhalten.
Endpunkte | Für alle {{site.data.keyword.cloudant_short_notm}}-Instanzen werden externe Endpunkte bereitgestellt, die öffentlich zugänglich sind. Außerdem enthalten alle nach dem 1. Januar 2019 bereitgestellten dedizierten Hardwareumgebungen interne Endpunkte für alle in ihnen bereitgestellten Standard-Plan-Instanzen. Durch die Verwendung interner Endpunkte können Kunden die Verbindung zu einer {{site.data.keyword.cloudant_short_notm}}-Instanz über das interne {{site.data.keyword.cloud}}-Netz herstellen, um Upstream-Anwendungsdatenverkehr im öffentlichen Netz und Bandbreitengebühren zu vermeiden. Weitere Informationen zum Aktivieren von Serviceendpunkten für Ihr {{site.data.keyword.cloud}}-Konto finden Sie in der [Dokumentation für Serviceendpunkte](https://cloud.ibm.com/docs/services/service-endpoint/getting-started.html#about){:new_window}.
IP-Whitelisting | {{site.data.keyword.cloudant_short_notm}}-Kunden, die mit einer dedizierten {{site.data.keyword.cloudant_short_notm}}-Umgebung arbeiten, können IP-Adressen auf eine Whitelist setzen, um so den Zugriff auf die dort angegebenen Server und Benutzer einzuschränken. Das IP-Whitelisting steht für {{site.data.keyword.cloud_notm}} Public-Lite-Pläne und -Standard-Pläne, die in Multi-Tenant-Umgebungen bereitgestellt werden, nicht zur Verfügung. Öffnen Sie ein Support-Ticket, um IP-Whitelists für eine bestimmte Gruppe von IP-Adressen oder bestimmte Bereiche von IP-Adressen anzufordern. Beachten Sie hierbei, dass die IP-Whitelists sowohl für die {{site.data.keyword.cloudant_short_notm}}-API als auch für das entsprechende Dashboard gelten. Achten Sie deshalb darauf, alle IP-Adressen für Administratoren einzubinden, die direkt auf das {{site.data.keyword.cloudant_short_notm}}-Dashboard zugreifen müssen. 
CORS | Aktivieren Sie die CORS-Unterstützung für bestimmte Domänen über das {{site.data.keyword.cloudant_short_notm}}-Dashboard oder die API. Weitere Informationen finden Sie in der [CORS-API-Dokumentation](/docs/services/Cloudant?topic=cloudant-cors#cors){:new_window}.

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
Redundante und dauerhafte Datenspeicherung | Standardmäßig speichert {{site.data.keyword.cloudant_short_notm}} drei Kopien jedes Dokuments auf drei verschiedenen Knoten
in einem Cluster auf Platte. Dies stellt sicher, dass
es immer eine funktionierende Kopie Ihrer Daten gibt, unabhängig von Ausfällen.
Datenreplikation und Export | Sie können Ihre Datenbanken fortlaufend zwischen
Clustern in verschiedenen Rechenzentren oder in einen lokalen {{site.data.keyword.cloudant_short_notm}} Local-Cluster
bzw. nach Apache CouchDB replizieren. Eine andere Option ist, Daten aus
  {{site.data.keyword.cloudant_short_notm}} (im JSON-Format)
  an andere Standorte oder in andere Quellen (z. B. Ihre eigenen Rechenzentren) zu exportieren, um zusätzliche Datenredundanz zu erzielen.
