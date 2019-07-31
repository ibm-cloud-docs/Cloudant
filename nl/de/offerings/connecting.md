---

copyright:
  years: 2019
lastupdated: "2019-06-12"

keywords: endpoints, service credentials, authentication, ibm cloudant dashboard, curl, client libraries, IP whitelisting

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

<!-- Acrolinx: 2018-07-02 -->

# Verbindungen herstellen
{: #connecting}

{{site.data.keyword.cloudantfull}} wird über eine HTTP-API aufgerufen. In diesem Dokument werden die verschiedenen Elemente beschrieben, die Sie zum Verbinden mit {{site.data.keyword.cloudant_short_notm}} verwenden:
- Endpunkte
- Serviceberechtigungsnachweise
- Authentifizierung
- {{site.data.keyword.cloudant_short_notm}}-Dashboard aufrufen
- Programmgesteuerter Zugriff auf {{site.data.keyword.cloudant_short_notm}} über den Befehl [curl ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://curl.haxx.se/){: new_window} oder über Clientbibliotheken 
{: shortdesc}

## Endpunkte
{: #endpoints}

Auf {{site.data.keyword.cloudant_short_notm}} wird über HTTP-API-Endpunkte zugegriffen. Die Endpunkte für eine Instanz
werden im URL-Feld der Serviceberechtigungsnachweise angezeigt, die für die Instanz generiert wurden, und in der
Registerkarte **Konto** > **Einstellungen** im
{{site.data.keyword.cloudant_short_notm}}-Dashboard.

Auf alle {{site.data.keyword.cloudant_short_notm}}-HTTP-Endpunkte muss über TLS zugegriffen werden, d. h. das Präfix `https://` muss vorangestellt werden.

Der allgemein zugängliche Endpunkt ist:

`https://BENUTZERNAME.cloudant.com`

Alle nach dem 1. Januar 2019 bereitgestellten Instanzen enthalten einen Domänenendpunkt 'appdomain.cloud'. Der allgemein
zugängliche Endpunkt ist:

`https://BENUTZERNAME.cloudantnosqldb.appdomain.cloud`

Interne Endpunkte werden zu allen in dedizierten Hardwareumgebungen bereitgestellten Instanzen hinzugefügt, die nach dem 1. Januar 2019
außerhalb der von der Europäischen Union verwalteten Umgebung bereitgestellt wurden. Der interne {{site.data.keyword.cloud_notm}}-Netzendpunkt ist:

`https://BENUTZERNAME.private.cloudantnosqldb.appdomain.cloud`

Dabei ist BENUTZERNAME der Servicename des Benutzers der Serviceinstanz in der URL. Dieses Feld dient auch als
Administratorbenutzername, wenn die traditionelle {{site.data.keyword.cloudant_short_notm}}-Authentifizierung
verwendet wird. Ein Beispiel für BENUTZERNAME ist
de810d0e-763f-46a6-ae88-50823dc85581-bluemix und der resultierende externe Beispielendpunkt
ist de810d0e-763f-46a6-ae88-50823dc85581-bluemix.cloudantnosqldb.appdomain.cloud. 

Weitere Informationen zum Blockieren der Konnektivität zu öffentlichen Netzen per IP-Whitelisting finden Sie unter [Sichere Zugriffssteuerung](https://cloud.ibm.com/docs/services/Cloudant?topic=cloudant-security#secure-access-control).
{: note}

## Serviceberechtigungsnachweise
{: #service-credentials}

Informationen zum Generieren von Serviceberechtigungsnachweisen für {{site.data.keyword.cloudant_short_notm}} über das {{site.data.keyword.cloud_notm}}-Dashboard
enthält das Lernprogramm [{{site.data.keyword.cloudant_short_notm}}-Instanz unter {{site.data.keyword.cloud_notm}} erstellen](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-an-ibm-cloudant-instance-on-ibm-cloud). Informationen zum Generieren von Serviceberechtigungsnachweisen über
die {{site.data.keyword.cloud_notm}}-CLI finden Sie unter [Berechtigungsnachweise für Ihren {{site.data.keyword.cloudant_short_notm}}-Service
generieren](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli#creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli). 

Beispielserviceberechtigungsnachweise für eine {{site.data.keyword.cloudant_short_notm}}-Instanz:

```json
{
  "apikey": "MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz",
  "host": "76838001-b883-444d-90d0-46f89e942a15-bluemix.cloudant.com",
  "iam_apikey_description": "Auto generated apikey during resource-key [...]",
  "iam_apikey_name": "auto-generated-apikey-050d21b5-5f[...]",
  "iam_role_crn": "crn:v1:bluemix:public:iam::::serviceRole:Manager",
  "iam_serviceid_crn": "crn:v1:staging:public:iam-identity::[...]",
  "password": "8fb6a16b48903e87b769e7f4968521e85c2394ed8f0e69b2769e56dcb27d2e76",
  "port": 443,
  "url": "https://<username>:<password>@76838001-b883-444d-90d0-46f89e942a15-bluemix.cloudant.com",
  "username": "76838001-b883-444d-90d0-46f89e942a15-bluemix"
}
```
{: codeblock}

Die Serviceberechtigungsnachweise beinhalten die folgenden Felder:

Feld | Zweck
------|--------
`username` | Der Servicename des Benutzers der Serviceinstanz in der URL. Dieses Feld dient auch als Administratorbenutzername. 
`password` | Das Kennwort für die traditionellen Berechtigungsnachweise, das für Anwendungen für den Zugriff auf die Serviceinstanz benötigt wird. Dieses Feld wird nur angezeigt, wenn die Option `Traditionelle Berechtigungsnachweise und IAM-Berechtigungsnachweise verwenden` ausgewählt wird. 
`host` | Von Anwendungen verwendeter Hostname zum Suchen der Serviceinstanz. Dieses Feld wird nur angezeigt, wenn die Option `Traditionelle Berechtigungsnachweise und IAM-Berechtigungsnachweise verwenden` ausgewählt wird. 
`port` | Die HTTPS-Portnummer für den Zugriff auf die Serviceinstanz auf dem Host. Sie lautet '443', da von {{site.data.keyword.cloudant_short_notm}} nur der HTTPS-Zugriff zugelassen wird. Dieses Feld wird nur angezeigt, wenn die Option `Traditionelle Berechtigungsnachweise und IAM-Berechtigungsnachweise verwenden` ausgewählt wird. 
`url`	| Die HTTPS-URL für den Zugriff auf die {{site.data.keyword.cloudant_short_notm}}-Instanz. Wenn die Option `Traditionelle Berechtigungsnachweise und IAM-Berechtigungsnachweise verwenden` ausgewählt wird, dann umfasst sie auch den eingebetteten traditionellen Benutzernamen und das zugehörige Kennwort. 
`apikey` | Der IAM-API-Schlüssel. 
`iam_apikey_description` | Die Beschreibung des IAM-API-Schlüssels. 
`iam_apikey_name` | Die ID des IAM-API-Schlüssels.
`iam_role_crn` | Die IAM-Rolle, die dem IAM-API-Schlüssel zugeordnet wurde.
`iam_serviceid_crn`	| Der CRN der Service-ID.

## Authentifizierung
{: #authentication-overview}

{{site.data.keyword.cloudant_short_notm}} verfügt während der Bereitstellung über zwei Authentifizierungsmethoden, und zwar `Nur IAM verwenden` und `Traditionelle Berechtigungsnachweise und IAM-Berechtigungsnachweise verwenden`. Die Details zu Ihren traditionellen Berechtigungsnachweisen können
in den Serviceberechtigungsnachweisen nur angezeigt werden, wenn die Authentifizierungsmethode `Traditionelle Berechtigungsnachweise und IAM-Berechtigungsnachweise verwenden` ausgewählt wird. Die Berechtigungsnachweise werden auf der Registerkarte 'Serviceberechtigungsnachweise' Ihrer Instanz angezeigt. Weiterführende detaillierte Informationen zur Verwendung der beiden Authentifizierungsoptionen finden Sie im
[IAM-Leitfaden](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-) und im Dokument zur [traditionellen Authentifizierung](/docs/services/Cloudant?topic=cloudant-authentication#authentication).
 
Das {{site.data.keyword.cloudant_short_notm}}-Team empfiehlt die Verwendung der IAM-Zugriffssteuerung für die Authentifizierung, falls möglich. Wenn Sie die traditionelle {{site.data.keyword.cloudant_short_notm}}-Authentifizierung verwenden, wird die Verwendung von [API-Schlüsseln](/docs/services/Cloudant?topic=cloudant-authorization#api-keys){: new_window} anstelle von Berechtigungsnachweisen für den programmgesteuerten Zugriff und für Replikationsjobs empfohlen. 
{: important}

## {{site.data.keyword.cloudant_short_notm}}-Dashboard
{: #ibm-cloudant-dashboard}

Sie können das {{site.data.keyword.cloudant_short_notm}}-Dashboard öffnen, indem Sie die Seite mit Instanzdetails
auf der Registerkarte 'Verwalten' im {{site.data.keyword.cloud_notm}}-Dashboard öffnen. Verwenden Sie entweder die
Schaltfläche `Starten` oder die Schaltfläche `Cloudant-Dashboard starten`,
um das dashboard in einer neuen Browserregisterkarte zu öffnen. Mit dem {{site.data.keyword.cloudant_short_notm}}-Dashboard können Sie die folgenden Tasks ausführen:

- Ihre aktuelle Nutzung der Instanz überwachen
- CRUD-Aktionen (CRUD = Create, Read, Update, Delete; Erstellen, Lesen, Aktualisieren, Löschen) für {{site.data.keyword.cloudant_short_notm}}-Datenbanken, -Dokumente und -Indizes ausführen
- Replikationsjobs einrichten und anzeigen
- Aktive Tasks anzeigen
- Kontoinformationen wie bereitgestellte Durchsatzkapazität, Ankündigungen, CORS und Einstellungen aktualisieren

## Programmgesteuerter Zugriff
{: #programmatic-access}

### Befehlszeile (curl)
{: #command-line-curl-}

Sie können das Befehlszeilendienstprogramm 'curl' verwenden, um auf die {{site.data.keyword.cloudant_short_notm}}-HTTPS-API zuzugreifen. 

Wenn Sie die traditionelle {{site.data.keyword.cloudant_short_notm}}-Authentifizierung verwenden, finden Sie in [API-Referenz - Übersicht](/docs/services/Cloudant?topic=cloudant-api-reference-overview#api-reference-overview) Details zum Angeben eines Benutzernamens mit Kennwort für den Zugriff auf die {{site.data.keyword.cloudant_short_notm}}-API über 'curl', wie in den Beispielen der API-Referenz gezeigt.

Wenn Sie die {{site.data.keyword.cloud_notm}}-IAM-Authentifizierung verwenden, müssen Sie zuerst mithilfe eines API-Schlüssels ein {{site.data.keyword.cloud_notm}}-IAM-Token abrufen. Übergeben Sie anschließend zum Authentifizieren das IAM-Token an die {{site.data.keyword.cloudant_short_notm}}-Instanz. Weitere Informationen finden Sie im Lernprogramm [Übergeben
eines {{site.data.keyword.cloud_notm}}-IAM-Tokens zum Authentifizieren bei der API eines Service ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://cloud.ibm.com/docs/services/iam?topic=iam-iamapikeysforservices#token_auth){: new_window}. 

Sie können sich mit einem IAM-API-Schlüssel direkt bei {{site.data.keyword.cloudant_short_notm}} authentifizieren.
{: note}

### Clientbibliotheken
{: #client-libraries-overview}

{{site.data.keyword.cloudant_short_notm}} verfügt über offizielle Clientbibliotheken für Java, Node.js, Python, Swift und Mobile. In der [Dokumentation für Clientbibliotheken](/docs/services/Cloudant?topic=cloudant-client-libraries#client-libraries) finden Sie weitere Informationen zum Aufrufen der Bibliotheken sowie Beispiele zum Verbinden mit einer {{site.data.keyword.cloudant_short_notm}}-Instanz
über die einzelnen Bibliotheken. 
