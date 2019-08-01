---

copyright:
  years: 2017, 2019
lastupdated: "2019-06-12"

keywords: legacy access controls, api keys, enable iam, provisioning, how to choose between iam and legacy credentials, making requests, required client libraries, actions, endpoints, map actions to iam roles

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

# {{site.data.keyword.cloud_notm}} Identity and Access Management (IAM)
{: #ibm-cloud-identity-and-access-management-iam-}

{{site.data.keyword.cloud}} Identity and Access Management (IAM) bietet einen einheitlichen Ansatz zur Verwaltung von Benutzeridentitäten,
Services und der Zugriffssteuerung.
{: shortdesc}

## Einführung
{: #introduction}

In diesem Dokument wird die Integration von {{site.data.keyword.cloudantfull}} mit {{site.data.keyword.cloud_notm}} Identity and
Access Management beschrieben. Des Weiteren werden hier die Unterschiede zwischen den traditionellen Zugriffssteuerungsmechanismen von {{site.data.keyword.cloudant_short_notm}} und den {{site.data.keyword.cloud_notm}} IAM-Zugriffssteuerungsmechanismen erläutert. Anschließend werden die Vor- und Nachteile der verschiedenen Konzepte gegenübergestellt,
um Ihnen die Entscheidung darüber, welches sich für den Einsatz auf Ihrem System am besten eignet, zu erleichtern. Als Nächstes wird die Vorgehensweise zur Verwendung von IAM in den
{{site.data.keyword.cloudant_short_notm}}-Clientbibliotheken und über HTTP-Aufrufe diskutiert. Zum Abschluss folgt ein Referenzabschnitt, in dem alle IAM-Aktionen
und -Rollen beschrieben werden, die in {{site.data.keyword.cloudant_short_notm}} zur Verfügung stehen.

Sie erhalten einen Übersicht zu [IAM ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://cloud.ibm.com/docs/iam/index.html#iamoverview){: new_window} einschließlich einer Beschreibung zur Ausführung der folgenden Schritte:

- Verwaltung von Benutzer- und Service-IDs.
- Verwaltung der verfügbaren Berechtigungsnachweise.
- Verwendung der IAM-Zugriffsrichtlinien, mit denen der Zugriff auf die {{site.data.keyword.cloudant_short_notm}}-Serviceinstanzen erteilt und entzogen werden kann.

## Unterschiede zwischen traditionellen {{site.data.keyword.cloudant_short_notm}}-Zugriffssteuerungsmechanismen und den IAM-Zugriffssteuerungsmechanismen
{: #differences-between-ibm-cloudant-legacy-and-iam-access-controls}

Im folgenden Abschnitt finden Sie eine kurze Übersicht zu den Unterschieden zwischen den traditionellen {{site.data.keyword.cloudant_short_notm}}-Zugriffssteuerungsmechanismen und den {{site.data.keyword.cloud_notm}} IAM-Zugriffssteuerungsmechanismen.

### {{site.data.keyword.cloud_notm}} Identity and Access Management
{: #ibm-cloud-identity-and-access-management}

- Zentral verwaltetes Zugriffsmanagement für {{site.data.keyword.cloud_notm}}.
- Zugriffsmöglichkeit für Benutzer oder Services auf zahlreiche unterschiedliche Ressourcen mithilfe der gleichen Gruppe von
  Berechtigungsnachweisen (z. B. Benutzername/Kennwort oder IAM-API-Schlüssel).
- IAM-API-Schlüsseln kann der Zugriff auf die Kontomanagementfunktionen (z. B. zum Erstellen neuer Datenbanken)
  erteilt werden.

### Traditionelle Version von {{site.data.keyword.cloudant_short_notm}}
{: #ibm-cloudant-legacy}

- Nur für {{site.data.keyword.cloudant_short_notm}}.
- Für den Zugriff auf die verschiedenen Serviceinstanzen sind eigene Berechtigungsnachweisgruppen erforderlich.
- Verwendung der HTTP-Basisauthentifizierung mit Berechtigungsnachweisen, die nicht an einen bestimmten Benutzer oder Service
  gebunden sind.
- {{site.data.keyword.cloudant_short_notm}}-API-Schlüsseln können nur Berechtigungen auf Datenbankebene erteilt werden.

### Hinweise zu API-Schlüsseln
{: #api-key-notes}

Im vorliegenden Dokument bezieht sich die Verwendung des Begriffs 'API-Schlüssel' auf die IAM-API-Schlüssel.
Die traditionelle Version von {{site.data.keyword.cloudant_short_notm}}verfügt ebenfalls über ein Konzept für API-Schlüssel. Die Verwendung des Begriffs 'traditionelle {{site.data.keyword.cloudant_short_notm}}-Berechtigungsnachweise'
oder 'Kombinationen aus Benutzername und Kennwort' schließt auch {{site.data.keyword.cloudant_short_notm}}-API-Schlüssel mit ein. 

## IAM mit {{site.data.keyword.cloudant_short_notm}} aktivieren
{: #enabling-iam-with-ibm-cloudant}

Nur neue {{site.data.keyword.cloudant_short_notm}}-Serviceinstanzen können mit der {{site.data.keyword.cloud_notm}} IAM-Version von Ende Juli 2018 verwendet werden.

Alle neuen {{site.data.keyword.cloudant_short_notm}}-Serviceinstanzen können IAM verwenden, wenn dieses Produkt bereitgestellt wird. Optional können Sie auch die traditionellen Authentifizierungsmechanismen aktivieren.  Wenn Sie eine neue {{site.data.keyword.cloudant_short_notm}}-Instanz aus dem {{site.data.keyword.cloud_notm}}-Katalog bereitstellen, dann wählen Sie eine der verfügbaren Authentifizierungsmethoden aus:

1. **Traditionelle Berechtigungsnachweise und IAM-Berechtigungsnachweise verwenden**: In diesem Modus können sowohl IAM-Berechtigungsnachweise als auch traditionelle Berechtigungsnachweise verwendet werden, um auf das Konto zuzugreifen. Sowohl IAM-Berechtigungsnachweisgruppen als auch traditionelle Berechtigungsnachweisgruppen werden für alle Anwendungen bereitgestellt, die über eine Bindung zum Konto und den generierten Serviceberechtigungsnachweisen verfügen.
2. **Nur IAM verwenden**: In diesem Modus werden ausschließlich IAM-Berechtigungsnachweise über die Servicebindung und die Berechtigungsnachweisgenerierung bereitgestellt.

### {{site.data.keyword.cloudant_short_notm}}-API-Schlüssel und _Nur IAM verwenden_
{: #ibm-cloudant-api-keys-and-_use-only-iam_}

Die Verwendung von {{site.data.keyword.cloudant_short_notm}}-API-Schlüsseln zusammen mit IAM ist zwar möglich, wird jedoch **nicht empfohlen**. Diese Empfehlung wird deshalb ausgesprochen, weil {{site.data.keyword.cloudant_short_notm}}-API-Schlüssel und die entsprechenden Berechtigungen nicht in der IAM-Richtlinienschnittstelle angezeigt werden können und auch nicht über diese Schnittstelle verwaltet werden können, wodurch ein ganzheitliches Zugriffsmanagement nicht möglich ist.

Die Auswahl des Modus _Nur IAM verwenden_ oder _Traditionelle Berechtigungsnachweise und IAM-Berechtigungsnachweise verwenden_ wirkt sich auf folgende Bereiche aus:

1. Auf die Verfügbarkeit traditioneller {{site.data.keyword.cloudant_short_notm}}-Berechtigungsnachweise auf Kontoebene, mit denen Aktionen für Datenbanken und
    weitere Aktionen auf Kontoebene verwaltet werden können.
2. Auf den Stil der Berechtigungsnachweise, die während der Generierung der Serviceberechtigungsnachweise bereitgestellt werden.

Insbesondere ist festzuhalten, dass {{site.data.keyword.cloudant_short_notm}}-API-Schlüssel weiterhin zum Verwalten des Datenbankzugriffs eingesetzt werden
können. Diese Berechtigungsnachweise müssen über die HTTP-API generiert und konfiguriert werden.

### Bereitstellung über die Befehlszeile
{: #provisioning-by-using-the-command-line}

Wenn Sie eine neue {{site.data.keyword.cloudant_short_notm}}-Instanz über die Befehlszeile bereitstellen, dann müssen Sie eine Option für das Tool `ic`
angeben. Hierzu wird der Parameter `-p` verwendet, mit dem die traditionellen Berechtigungsnachweise für ein Konto aktiviert oder inaktiviert werden können. Die Option wird im JSON-Format übergeben und trägt die Bezeichnung `legacyCredentials`.

Führen Sie den folgenden Befehl aus, um eine Instanz unter Verwendung des Modus _Nur IAM verwenden_ (empfohlen) bereitzustellen:

```sh
ic resource service-instance-create  "Instance Name" \
    cloudantnosqldb Standard us-south \
    -p {"legacyCredentials": false}
```

Führen Sie den folgenden Befehl aus, um eine Instanz unter Verwendung des Modus _Traditionelle Berechtigungsnachweise und IAM-Berechtigungsnachweise verwenden_ bereitzustellen:

```sh
ic resource service-instance-create  "Instance Name" \
    cloudantnosqldb Standard us-south \
    -p {"legacyCredentials": true}
```

### JSON-Beispiele für Serviceberechtigungsnachweise für beide Optionen
{: #service-credential-json-examples-for-each-option}

Die Entscheidung für den Zugriffssteuerungsmodus _Nur IAM verwenden_ oder den Zugriffssteuerungsmodus _Traditionelle Berechtigungsnachweise und IAM-Berechtigungsnachweise verwenden_ wirkt sich darauf aus, wie Berechtigungsnachweise an Ihre Anwendung übergeben werden, wenn Serviceberechtigungsnachweise gebunden und generiert
werden. Werden die Berechtigungsnachweise in der primären {{site.data.keyword.cloud_notm}} IAM-Schnittstelle generiert, dann werden die
API-Schlüssel während der Generierung in dieser Schnittstelle angezeigt.

Sie können Berechtigungsnachweise auch über den Abschnitt 'Serviceberechtigungsnachweise' einer
Serviceinstanz generieren. Durch die Verwendung dieser Methode bei der Generierung von Serviceberechtigungsnachweisen wird ein JSON-BLOB für Serviceberechtigungsnachweise erstellt, das mit allen Details, die für den Zugriff auf die Serviceinstanz erforderlich sind, in Anwendungen eingefügt werden kann.

In diesem Abschnitt wird gezeigt, wie das JSON-Element für die Serviceberechtigungsnachweise dargestellt wird und welche Bedeutung die einzelnen Werte haben.

Wenn Sie _Nur IAM verwenden_ auswählen, dann enthalten die generierten Serviceberechtigungsnachweise nur IAM-Werte und werden wie folgt
dargestellt:

```json
{
  "apikey": "MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz",
  "iam_apikey_description": "Auto generated apikey during resource-key [...]",
  "iam_apikey_name": "auto-generated-apikey-050d21b5-5f[...]",
  "iam_role_crn": "crn:v1:bluemix:public:iam::::serviceRole:Manager",
  "iam_serviceid_crn": "crn:v1:staging:public:iam-identity::[...]",
  "url": "https://76838001-b883-444d-90d0-46f89e942a15-bluemix.cloudant.com",
  "username": "76838001-b883-444d-90d0-46f89e942a15-bluemix"
}
```

Die einzelnen Werte im hier angegebenen JSON-Beispiel haben folgende Bedeutung:

- `apikey`: Der IAM-API-Schlüssel.
- `iam_apikey_description`: Die Beschreibung des IAM-API-Schlüssels.
- `iam_apikey_name`: Die ID des IAM-API-Schlüssels.
- `iam_role_crn`: Die IAM-Rolle, die dem IAM-API-Schlüssel zugeordnet wurde.
- `iam_serviceid_crn`: Der CRN der Service-ID.
- `url`: Die {{site.data.keyword.cloudant_short_notm}}-Service-URL.
- `username`: Der interne {{site.data.keyword.cloudant_short_notm}}-Kontoname.

Wenn Sie _Traditionelle Berechtigungsnachweise und IAM-Berechtigungsnachweise verwenden_ auswählen, dann enthalten die generierten Serviceberechtigungsnachweise sowohl IAM-Berechtigungsnachweise als auch traditionelle Berechtigungsnachweise und werden wie folgt dargestellt:

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

Die einzelnen Werte im hier angegebenen JSON-Beispiel haben folgende Bedeutung:

- `apikey`: Der IAM-API-Schlüssel.
- `host`: Der Hostname des {{site.data.keyword.cloudant_short_notm}}-Service.
- `iam_apikey_description`: Die Beschreibung des IAM-API-Schlüssels.
- `iam_apikey_name`: Die ID des IAM-API-Schlüssels.
- `iam_role_crn`: Die IAM-Rolle, die dem IAM-API-Schlüssel zugeordnet wurde.
- `iam_serviceid_crn`: Der CRN der Service-ID.
- `password`: Das Kennwort für die traditionellen {{site.data.keyword.cloudant_short_notm}}-Berechtigungsnachweise.
- `port`: Der {{site.data.keyword.cloudant_short_notm}}-Service-Port.
- `url`: Die {{site.data.keyword.cloudant_short_notm}}-Service-URL einschließlich der eingebetteten traditionellen {{site.data.keyword.cloudant_short_notm}}-Berechtigungsnachweise.
- `username`: Der Benutzername für die traditionellen {{site.data.keyword.cloudant_short_notm}}-Berechtigungsnachweise.

## Soll ich _Nur IAM verwenden_ oder _Traditionelle Berechtigungsnachweise und IAM-Berechtigungsnachweise verwenden_ benutzen?
{: #should-i-use-_use-only-iam_-or-_use-both-legacy-credentials-and-iam_-}

Sofern möglich, sollten Sie _Nur IAM verwenden_ benutzen. Die Verwendung von {{site.data.keyword.cloud_notm}} IAM bietet die folgenden Vorteile:

- Management des Zugriffs auf {{site.data.keyword.cloudant_short_notm}} mithilfe der {{site.data.keyword.cloud_notm}}-Standardtools anstatt mit einer Kombination
  aus {{site.data.keyword.cloud_notm}}-spezifischen und {{site.data.keyword.cloudant_short_notm}}-spezifischen Tools für das Berechtigungsnachweismanagement.
- Berechtigungsnachweise können auf einfache Weise widerrufen oder turnusmäßig gewechselt werden, wenn Sie mit {{site.data.keyword.cloud_notm}} IAM arbeiten.

Im Folgenden werden weitere Vor- und Nachteile der beiden Ansätze erläutert.

### Vor- und Nachteile der beiden Zugriffssteuerungsmechanismen
{: #advantages-and-disadvantages-of-the-two-access-control-mechanisms}

Insgesamt lässt sich festhalten, dass {{site.data.keyword.cloud_notm}} IAM das empfohlene Authentifizierungsmodell darstellt. Allerdings birgt dieser Ansatz auch Nachteile. Dies gilt insbesondere dann, wenn bereits eine Anwendung vorhanden ist oder wenn Sie keine von {{site.data.keyword.cloudant_short_notm}} unterstützte Clientbibliothek verwenden können.

<table>
<caption style="caption-side:top">Tabelle 1. Vor- und Nachteile der beiden Zugriffssteuerungsmechanismen</caption>
<thead>
<tr>
<th id="mode">Modus</th>
<th id="advantages">Vorteile</th>
<th id="disadvantages">Nachteile</th>
</tr>
</thead>
<tr>
<td headers="mode">IAM-Modus</td>
<td headers="advantages" valign="top"><ul><li>Zugriffsmanagement für zahlreiche Services über eine Schnittstelle. Möglichkeit zum globalen Entziehen des Zugriffs für einen Benutzer.</li>
<li>API-Schlüssel auf Kontoebene über Service-IDs.</li>
<li>Einfacher turnusmäßiger Wechsel der Berechtigungsnachweise.</li>
<li>Activity Tracker-Protokolle zur Erfassung einzelner Personen und Services.</li>
<li>Föderation von IAM mit anderen Identitätssystemen wie z. B. den LDAP-Repositorys von Unternehmen.</li></ul>
</td>
<td headers="disadvantages"><ul><li>Wenn Sie nicht mit den von {{site.data.keyword.cloudant_short_notm}} unterstützten Bibliotheken arbeiten, dann müssen voraussichtlich Anwendungsänderungen durchgeführt werden, um die API-Schlüssel und Zugriffstokens von IAM verwenden zu können.</li>
<li>Noch keine Berechtigungen auf Datenbankebene.</li>
<li>Nichtverfügbarkeit bestimmter Endpunkte (siehe [Nicht verfügbare Endpunkte](#unavailable-endpoints)).</li>
<li>Keine Möglichkeit zur Angabe einer Datenbank als 'öffentlich', sodass für den Zugriff kein autorisierter Benutzer erforderlich ist.</li></ul>
</td>
</tr>

<tr>
<td headers="mode">Traditioneller Modus</td>
<td headers="advantages">
<ul><li>Keine Notwendigkeit zum Ändern vorhandener Anwendungen oder Clientbibliotheksabhängigkeiten.</li>
<li>Berechtigungen auf Datenbankebene.</li>
</ul>
</td>
<td headers="disadvantages">
<ul><li>Keine API-Schlüssel auf Kontoebene. Zur Verwaltung der Datenbanken müssen Rootberechtigungsnachweise (`root`) verwendet werden.</li>
<li>Separates Management von {{site.data.keyword.cloudant_short_notm}}-Berechtigungsnachweisen, sodass kein vollständiger Überblick über den gesamten Zugriff in einer zentralen Schnittstelle besteht.</li>
<li>Schwierige Implementierung des turnusmäßigen Wechsels der Berechtigungsnachweise.</li>
</ul>
</td>
</tr>
</table>

## Anforderungen an Instanzen mithilfe von IAM-Berechtigungsnachweisen absetzen
{: #making-requests-to-instances-by-using-iam-credentials}

Im vorliegenden Abschnitt wird beschrieben, wie {{site.data.keyword.cloudant_short_notm}} mit Serviceinstanzen verwendet werden kann, indem die IAM-Authentifizierung und -Zugriffssteuerung eingesetzt wird. Dabei wird auf die Details aus dem JSON-Beispiel für Serviceberechtigungsnachweise Bezug genommen, das bereits dargestellt
wurde.

Bei {{site.data.keyword.cloud_notm}} IAM muss ein IAM-API-Schlüssel gegen ein Zugriffstoken mit zeitlich begrenzter Gültigkeit ausgetauscht werden, bevor eine Anforderung an eine Ressource oder einen Service abgesetzt werden kann. Das Zugriffstoken wird daraufhin in den HTTP-Header für die Berechtigung (`Authorization`) des Service eingebunden. Wenn das Zugriffstoken abläuft, muss die konsumierende Anwendung über den IAM-Token-Service ein neues Token anfordern. Weitere Einzelheiten hierzu finden Sie in der Dokumentation zum [Anfordern eines {{site.data.keyword.cloud_notm}} IAM-Tokens mit einem API-Schlüssel ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://cloud.ibm.com/docs/iam/apikey_iamtoken.html#iamtoken_from_apikey).

Die offiziellen {{site.data.keyword.cloudant_short_notm}}-Clientbibliotheken dienen zum Anfordern eines Tokens über einen API-Schlüssel. Wenn Sie direkt über einen HTTP-Client auf {{site.data.keyword.cloudant_short_notm}} zugreifen und nicht über eine {{site.data.keyword.cloudant_short_notm}}-Clientbibliothek, dann müssen Sie den Austausch und die Aktualisierung eines Zugriffstokens mit zeitlich begrenzter Gültigkeit mithilfe eines IAM-API-Schlüssels über den IAM-Token-Service durchführen. Nach Ablauf eines Tokens gibt {{site.data.keyword.cloudant_short_notm}} den HTTP-Statuscode `401` zurück.

### Erforderliche Clientbibliotheksversionen
{: #required-client-library-versions}

Für IAM-fähige {{site.data.keyword.cloudant_short_notm}}-Serviceinstanzen benötigen Sie mindestens die folgenden Versionen der Clientbibliothek:

<table>
<caption style="caption-side:top">Tabelle 2. Empfohlene Clientbibliotheksversion</caption>
<thead>
<tr>
<th id="library">Bibliothek</th>
<th id="recommended">Empfohlen</th>
</tr>
</thead>
<tr>
<td headers="library"><a href="https://github.com/cloudant/java-cloudant" target="_blank">java-cloudant <img src="../images/launch-glyph.svg" alt="Symbol für externen Link" title="Symbol für externen Link"></a></td>
<td headers="recommended">2.13.0+</td>
</tr>

<tr>
<td headers="library"><a href="https://github.com/cloudant/nodejs-cloudant" target="_blank">nodejs-cloudant <img src="../images/launch-glyph.svg" alt="Symbol für externen Link" title="Symbol für externen Link"></a></td>
<td headers="recommended">2.3.0+</td>
</tr>

<tr>
<td headers="library"><a href="https://github.com/cloudant/python-cloudant" target="_blank">python-cloudant <img src="../images/launch-glyph.svg" alt="Symbol für externen Link" title="Symbol für externen Link"></a></td>
<td headers="recommended">2.9.0+</td>
</tr>

<tr>
<td headers="library"><a href="https://github.com/cloudant/couchbackup/" target="_blank">couchbackup <img src="../images/launch-glyph.svg" alt="Symbol für externen Link" title="Symbol für externen Link"></a></td>
<td headers="recommended">2.3.1+</td>
</tr>

<tr>
<td headers="library"><a href="https://github.com/cloudant/cdtdatastore/" target="_blank">CDTDatastore <img src="../images/launch-glyph.svg" alt="Symbol für externen Link" title="Symbol für externen Link"></a></td>
<td headers="recommended">2.0.3+</td>
</tr>

<tr>
<td headers="library"><a href="https://github.com/cloudant/sync-android/" target="_blank">sync-android <img src="../images/launch-glyph.svg" alt="Symbol für externen Link" title="Symbol für externen Link"></a></td>
<td headers="recommended">2.2.0+</td>
</tr>
</table>

Für die folgenden Code-Snippets sind diese Versionen erforderlich.

### Java
{: #java-iam}

Erfordert [java-cloudant ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/cloudant/java-cloudant){: new_window}, 2.13.0+. 

Verwenden Sie die Methode `iamApiKey()`, um einen Datenbankclient mit einem IAM-API-Schlüssel zu erstellen:

```java
package com.mycompany.app;

import com.cloudant.client.api.ClientBuilder;
import com.cloudant.client.api.CloudantClient;


public class App
{
    public static void main( String[] args )
    {
        CloudantClient client = ClientBuilder
                .account("76838001-b883-444d-90d0-46f89e942a15-bluemix")
                .iamApiKey("MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz")
                .build();

        for (String db : client.getAllDbs()) {
            System.out.println(db);
        }
    }
}
```

### Node.js
{: #node.js}

Erfordert [nodejs-cloudant ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/cloudant/nodejs-cloudant){: new_window}, 2.3.0+. 

Verwenden Sie das Plug-in für `iamauth`, um einen Datenbankclient mit einem IAM-API-Schlüssel zu erstellen:

```js
var Cloudant = require('@cloudant/cloudant');

var cloudant = new Cloudant({
  account: '76838001-b883-444d-90d0-46f89e942a15-bluemix',
  plugins: {
    iamauth: {
      iamApiKey: 'MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz'
    }
  }
});
cloudant.db.list(function(err, body) {
  body.forEach(function(db) {
    console.log(db);
  });
});
```

### Python
{: #python}

Erfordert [python-cloudant ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/cloudant/python-cloudant){: new_window}, 2.9.0+. 

Verwenden Sie die Methode `Cloudant.iam(account_name, api_key, **kwargs)`, um einen Datenbankclient mit einem IAM-API-Schlüssel zu erstellen:

```python
from cloudant.client import Cloudant

client = Cloudant.iam(
    "76838001-b883-444d-90d0-46f89e942a15-bluemix",
    "MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz",
    connect=True
)
print client.all_dbs()
```

### Zugriff über HTTP-Client durchführen
{: #access-by-using-http-client}

Bei {{site.data.keyword.cloud_notm}} IAM muss ein IAM-API-Schlüssel gegen ein Zugriffstoken mit zeitlich begrenzter Gültigkeit ausgetauscht werden, bevor eine Anforderung an eine Ressource oder einen Service abgesetzt werden kann. Daraufhin wird das Zugriffstoken in den HTTP-Header für die Berechtigung (`Authorization`) des Service eingebunden. Läuft die Gültigkeit des Zugriffstokens ab, dann muss der Kunde über den IAM-Token-Service ein neues Token anfordern.

Wie bereits erwähnt, ist zur Verwendung von {{site.data.keyword.cloud_notm}} IAM zuerst der Austausch eines {{site.data.keyword.IBM_notm}}-API-Schlüssels gegen ein Zugriffstoken mit zeitlich begrenzter Gültigkeit erforderlich. Anschließend wird das Token zur Authentifizierung bei der {{site.data.keyword.cloudant_short_notm}}-API verwendet.

Im Folgenden ist ein Python-Beispiel aufgeführt:

```python
import time

import requests

API_KEY = "MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz"
ACCOUNT = "76838001-b883-444d-90d0-46f89e942a15-bluemix"

def get_access_token(api_key):
    """Retrieve an access token from the IAM token service."""
    token_response = requests.post(
        "https://iam.cloud.ibm.com/identity/token",
        data={
            "grant_type": "urn:ibm:params:oauth:grant-type:apikey",
            "response_type": "cloud_iam",
            "apikey": api_key
        },
        headers={
            "Accept": "application/json"
        }
    )
    if token_response.status_code == 200:
        print "Got access token from IAM"
        return token_response.json()['access_token']
    else:
        print token_response.status_code, token_response.json()
        return None

def main(api_key, account):
    access_token = None
    while True:
        if not access_token:
            access_token = get_access_token(api_key)

        if access_token:
            response = requests.get(
                "https://{0}.cloudant.com/_all_dbs".format(account),
                headers={
                    "Accept": "application/json",
                    "Authorization": "Bearer {0}".format(access_token)
                }
            )
            print "Got Cloudant response, status code", response.status_code
            if response.status_code == 401:
                print "Token has expired."
                access_token = None

        time.sleep(1)

if __name__ == "__main__":
    main(API_KEY, ACCOUNT)
```

## Referenz
{: #reference}

In diesem Abschnitt ist eine vollständige Liste der IAM-Aktionen von {{site.data.keyword.cloudant_short_notm}} enthalten. Außerdem erhalten Sie hier Informationen zu den für die einzelnen IAM-Systemrollen zulässigen Aktionen.

### {{site.data.keyword.cloudant_short_notm}}-Aktionen
{: #ibm-cloudant-actions}

In den folgenden Tabellen werden die verfügbaren IAM-Aktionen und -Rollen beschrieben.  

<table>
<caption style="caption-side:top">Tabelle 3. Beschreibungen der verfügbaren Aktion</caption>
<thead>
<tr>
<th id="action">Aktion</th>
<th id="description">Beschreibung</th>
</tr>
</thead>

<tr>
<td headers="action"><code>cloudant.db.any</code></td>
<td headers="description">Zugriff auf alle Datenbankendpunkte (deren Pfad nicht mit der Zeichenfolge `/_api` beginnt).</td>
</tr>

<tr>
<td headers="action"><code>cloudantnosqldb.sapi.dbsecurity</code></td>
<td headers="description">Zugriff auf `/_api/v2/db/<path:db>/_security`.</td>
</tr>

<tr>
<td headers="action"><code>cloudantnosqldb.sapi.usercors</code></td>
<td headers="description">Zugriff auf `/_api/v2/user/config/cors/`.</td>
</tr>

<tr>
<td headers="action"><code>cloudantnosqldb.sapi.apikeys</code></td>
<td headers="description">Zugriff auf `/_api/v2/api_keys`.</td>
</tr>

<tr>
<td headers="action"><code>cloudantnosqldb.sapi.userinfo</code></td>
<td headers="description">Zugriff auf `/_api/v2/user`.</td>
</tr>
</table>
</br>
Für eine differenzierte Berechtigung bieten wir die Rollen 'Manager', 'Leseberechtigter' und 'Schreibberechtigter' an. </br>

<table>
<caption style="caption-side:top">Tabelle 4. Aktionen nur für Manager</caption>
<thead>
<tr>
<th id="method">Methode</th>
<th id="endpoint">Endpunkt</th>
<th id="action-name">Aktionsname</th>
<th id="role">Rolle</th>
</tr>
</thead>

<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/</code></td>
<td headers="action-name">cloudantnosqldb.db.meta-info</td>
<td headers="role">Manager</td>
</tr>

<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/_active_tasks</code></td>
<td headers="action-name">cloudantnosqldb.account.active-tasks</td>
<td headers="role">Manager</td>
</tr>

<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/_replicator</code></td>
<td headers="action-name">cloudantnosqldb.replication.status</td>
<td headers="role">Manager</td>
</tr>

<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/_replicator/$DOC</code></td>
<td headers="action-name">cloudantnosqldb.replication.status</td>
<td headers="role">Manager</td>
</tr>

<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/_scheduler/jobs</code></td>
<td headers="action-name">cloudantnosqldb.replication.status</td>
<td headers="role">Manager</td>
</tr>

<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/_scheduler/docs</code></td>
<td headers="action-name">cloudantnosqldb.replication.status</td>
<td headers="role">Manager</td>
</tr>

<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/_replicate</code></td>
<td headers="action-name">cloudantnosqldb.replication.write</td>
<td headers="role">Manager</td>
</tr>

<tr>
<td headers="method"><code>PUT/DELETE</code></td>
<td headers="endpoint"><code>/_replicator</code></td>
<td headers="action-name">cloudantnosqldb.replication.write</td>
<td headers="role">Manager</td>
</tr>

<tr>
<td headers="method"><code>PUT/DELETE</code></td>
<td headers="endpoint"><code>/_replicator/$DOC</code></td>
<td headers="action-name">cloudantnosqldb.replication.write</td>
<td headers="role">Manager</td>
</tr>

<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/_up</code></td>
<td headers="action-name">cloudantnosqldb.account.up</td>
<td headers="role">Manager</td>
</tr>

<tr>
<td headers="method"><code>PUT</code></td>
<td headers="endpoint"><code>/$DB/</code></td>
<td headers="action-name">cloudantnosqldb.database.create</td>
<td headers="role">Manager</td>
</tr>

<tr>
<td headers="method"><code>DELETE</code></td>
<td headers="endpoint"><code>/$DB/</code></td>
<td headers="action-name">cloudantnosqldb.database.delete</td>
<td headers="role">Manager</td>
</tr>

<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/$DB/_design_docs/queries</code></td>
<td headers="action-name">cloudantnosqldb.index.read</td>
<td headers="role">Manager</td>
</tr>

<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID/_geo_info</code></td>
<td headers="action-name">cloudantnosqldb.index.read</td>
<td headers="role">Manager</td>
</tr>

<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID/_info/$FURTHER_PATH_PARTS</code></td>
<td headers="action-name">cloudantnosqldb.index.read</td>
<td headers="role">Manager</td>
</tr>

<tr>
<td headers="method"><code>GET</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID/_search_disk_size/$FURTHER_PATH_PARTS</code></td>
<td headers="action-name">cloudantnosqldb.index.read</td>
<td headers="role">Manager</td>
</tr>

<tr>
<td headers="method"><code>GET</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID/_search_info/$FURTHER_PATH_PARTS</code></td>
<td headers="action-name">cloudantnosqldb.index.read</td>
<td headers="role">Manager</td>
</tr>

<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/$DB/_index/$FURTHER_PATH_PARTS</code></td>
<td headers="action-name">cloudantnosqldb.index.read</td>
<td headers="role">Manager</td>
</tr>

<tr>
<td headers="method"><code>GET</code></td>
<td headers="endpoint"><code>/$DB/_design_docs</code></td>
<td headers="action-name">cloudantnosqldb.index.read</td>
<td headers="role">Manager</td>
</tr>

<tr>
<td headers="method"><code>GET</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID</code></td>
<td headers="action-name">cloudantnosqldb.index.read</td>
<td headers="role">Manager</td>
</tr>

<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID/$ATTACHMENT</code></td>
<td headers="action-name">cloudantnosqldb.index.read</td>
<td headers="role">Manager</td>
</tr>

<tr>
<td headers="method"><code>PUT</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID</code></td>
<td headers="action-name">cloudantnosqldb.index.write</td>
<td headers="role">Manager</td>
</tr>

<tr>
<td headers="method"><code>COPY</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID</code></td>
<td headers="action-name">cloudantnosqldb.index.write</td>
<td headers="role">Manager</td>
</tr>

<tr>
<td headers="method"><code>DELETE</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID</code></td>
<td headers="action-name">cloudantnosqldb.index.write</td>
<td headers="role">Manager</td>
</tr>

<tr>
<td headers="method"><code>PUT</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID/$ATTACHMENT</code></td>
<td headers="action-name">cloudantnosqldb.index.write</td>
<td headers="role">Manager</td>
</tr>

<tr>
<td headers="method"><code>DELETE</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID/$ATTACHMENT</code></td>
<td headers="action-name">cloudantnosqldb.index.write</td>
<td headers="role">Manager</td>
</tr>

<tr>
<td headers="method"><code>POST/DELETE</code></td>
<td headers="endpoint"><code>/$DB/_index/$FURTHER_PATH_PARTS</code></td>
<td headers="action-name">cloudantnosqldb.index.write</td>
<td headers="role">Manager</td>
</tr>

<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/$DB/_missing_revs</code></td>
<td headers="action-name">cloudantnosqldb.database.missing-revs</td>
<td headers="role">Manager</td>
</tr>

<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/$DB/_missing_revs</code></td>
<td headers="action-name">cloudantnosqldb.database.missing-revs</td>
<td headers="role">Manager</td>
</tr>

<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/$DB/_revs_diff</code></td>
<td headers="action-name">cloudantnosqldb.database.revs-diff</td>
<td headers="role">Manager</td>
</tr>

<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/$DB/_security</code></td>
<td headers="action-name">cloudantnosqldb.database-security.read</td>
<td headers="role">Manager</td>
</tr>

<tr>
<td headers="method"><code>PUT</code></td>
<td headers="endpoint"><code>/$DB/_security</code></td>
<td headers="action-name">cloudantnosqldb.database-security.write</td>
<td headers="role">Manager</td>
</tr>

<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/$DB/_shards</code></td>
<td headers="action-name">cloudantnosqldb.database.shards</td>
<td headers="role">Manager</td>
</tr>

<tr>
<td headers="method"><code>COPY</code></td>
<td headers="endpoint"><code>/$DB/$DOC_ID</code></td>
<td headers="action-name">cloudantnosqldb.document.copy</td>
<td headers="role">Manager</td>
</tr>

<tr>
<td headers="method"><code>GET</code></td>
<td headers="endpoint"><code>/_membership</code></td>
<td headers="action-name">cloudantnosqldb.cluster-membership.read</td>
<td headers="role">Manager</td>
</tr>

<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/$DB/_ensure_full_commit</code></td>
<td headers="action-name">cloudantnosqldb.database.ensure-full-commit</td>
<td headers="role">Manager</td>
</tr>
</table>

</br>

<table>
<caption style="caption-side:top">Tabelle 5. Aktionen für Manager und Schreibberechtigte</caption>
<thead>
<tr>
<th id="method">Methode</th>
<th id="endpoint">Endpunkt</th>
<th id="action-name">Aktionsname</th>
<th id="role">Rolle</th>
</tr>
</thead>

<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/_uuids</code></td>
<td headers="action-name">cloudantnosqldb.account.uuids</td>
<td headers="role">Manager, Schreibberechtigter</td>
</tr>

<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/$DB/</code></td>
<td headers="action-name">cloudantnosqldb.document.write</td>
<td headers="role">Manager, Schreibberechtigter</td>
</tr>

<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/$DB/_bulk_docs</code></td>
<td headers="action-name">cloudantnosqldb.document.write</td>
<td headers="role">Manager, Schreibberechtigter</td>
</tr>

<tr>
<td headers="method"><code>PUT</code></td>
<td headers="endpoint"><code>/$DB/$DOC_ID</code></td>
<td headers="action-name">cloudantnosqldb.document.write</td>
<td headers="role">Manager, Schreibberechtigter</td>
</tr>

<tr>
<td headers="method"><code>DELETE</code></td>
<td headers="endpoint"><code>/$DB/$DOC_ID</code></td>
<td headers="action-name">cloudantnosqldb.document.write</td>
<td headers="role">Manager, Schreibberechtigter</td>
</tr>

<tr>
<td headers="method"><code>PUT</code></td>
<td headers="endpoint"><code>/$DB/$DOC_ID/$ATTACHMENT</code></td>
<td headers="action-name">cloudantnosqldb.document.write</td>
<td headers="role">Manager, Schreibberechtigter</td>
</tr>

<tr>
<td headers="method"><code>DELETE</code></td>
<td headers="endpoint"><code>/$DB/$DOC_ID/$ATTACHMENT</code></td>
<td headers="action-name">cloudantnosqldb.document.write</td>
<td headers="role">Manager, Schreibberechtigter</td>
</tr>

<tr>
<td headers="method"><code>PUT/DELETE</code></td>
<td headers="endpoint"><code>/$DB/_local/$DOC_ID</code></td>
<td headers="action-name">cloudantnosqldb.document-local.write</td>
<td headers="role">Manager, Schreibberechtigter</td>
</tr>

<tr>
<td headers="method"><code>COPY</code></td>
<td headers="endpoint"><code>/$DB/_local/$DOC_ID</code></td>
<td headers="action-name">cloudantnosqldb.document-local.copy</td>
<td headers="role">Manager, Schreibberechtigter</td>
</tr>
</table>

</br>

<table>
<caption style="caption-side:top">Tabelle 6. Aktionen für Manager, Schreibberechtigte und Leseberechtigte</caption>
<thead>
<tr>
<th id="method">Methode</th>
<th id="endpoint">Endpunkt</th>
<th id="action-name">Aktionsname</th>
<th id="role">Rolle</th>
</tr>
</thead>
<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/_iam_session</code></td>
<td headers="action-name">cloudantnosqldb.iam-session.read</td>
<td headers="role">Manager, Schreibberechtigter, Leseberechtigter</td>
</tr>

<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/_iam_session</code></td>
<td headers="action-name">cloudantnosqldb.iam-session.write</td>
<td headers="role">Manager, Schreibberechtigter, Leseberechtigter</td>
</tr>
<tr>
<td headers="method"><code>DELETE</code></td>
<td headers="endpoint"><code>/_iam_session</code></td>
<td headers="action-name">cloudantnosqldb.iam-session.delete</td>
<td headers="role">Manager, Schreibberechtigter, Leseberechtigter</td>
</tr>
<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/_session</code></td>
<td headers="action-name">cloudantnosqldb.session.read</td>
<td headers="role">Manager, Schreibberechtigter, Leseberechtigter</td>
</tr>
<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/_session</code></td>
<td headers="action-name">cloudantnosqldb.session.write</td>
<td headers="role">Manager, Schreibberechtigter, Leseberechtigter</td>
</tr>
<tr>
<td headers="method"><code>DELETE</code></td>
<td headers="endpoint"><code>/_session</code></td>
<td headers="action-name">cloudantnosqldb.session.delete</td>
<td headers="role">Manager, Schreibberechtigter, Leseberechtigter</td>
</tr>
<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/_all_dbs</code></td>
<td headers="action-name">cloudantnosqldb.account.all-dbs</td>
<td headers="role">Manager, Schreibberechtigter, Leseberechtigter</td>
</tr>
<tr>
<td headers="method"><code>GET</code></td>
<td headers="endpoint"><code>/_db_updates</code></td>
<td headers="action-name">cloudantnosqldb.account.db-updates</td>
<td headers="role">Manager, Schreibberechtigter, Leseberechtigter</td>
</tr>
<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/_dbs_info</code></td>
<td headers="action-name">cloudantnosqldb.account.dbs-info</td>
<td headers="role">Manager, Schreibberechtigter, Leseberechtigter</td>
</tr>
<tr>
<td headers="method"><code>GET</code></td>
<td headers="endpoint"><code>/$DB/</code></td>
<td headers="action-name">cloudantnosqldb.database.info</td>
<td headers="role">Manager, Schreibberechtigter, Leseberechtigter</td>
</tr>
<tr>
<td headers="method"><code>GET/POST</code></td>
<td headers="endpoint"><code>/$DB/_all_docs</code></td>
<td headers="action-name">cloudantnosqldb.database.all-docs</td>
<td headers="role">Manager, Schreibberechtigter, Leseberechtigter</td>
</tr>
<tr>
<td headers="method"><code>GET/POST</code></td>
<td headers="endpoint"><code>/$DB/_changes</code></td>
<td headers="action-name">cloudantnosqldb.database.changes</td>
<td headers="role">Manager, Schreibberechtigter, Leseberechtigter</td>
</tr>
<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/$DB/$DOC_ID</code></td>
<td headers="action-name">cloudantnosqldb.document.read</td>
<td headers="role">Manager, Schreibberechtigter, Leseberechtigter</td>
</tr>
<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/$DB/$DOC_ID/$ATTACHMENT</code></td>
<td headers="action-name">cloudantnosqldb.document.read</td>
<td headers="role">Manager, Schreibberechtigter, Leseberechtigter</td>
</tr>
<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/$DB/_bulk_get</code></td>
<td headers="action-name">cloudantnosqldb.document.read</td>
<td headers="role">Manager, Schreibberechtigter, Leseberechtigter</td>
</tr>

<tr>
<td headers="method"><code>GET/POST</code></td>
<td headers="endpoint"><code>/_search_analyze</code></td>
<td headers="action-name">cloudantnosqldb.query.execute</td>
<td headers="role">Manager, Schreibberechtigter, Leseberechtigter</td>
</tr>
<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/$DB/_all_docs/queries</code></td>
<td headers="action-name">cloudantnosqldb.query.execute</td>
<td headers="role">Manager, Schreibberechtigter, Leseberechtigter</td>
</tr>
<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID/_geo/$FURTHER_PATH_PARTS</code></td>
<td headers="action-name">cloudantnosqldb.query.execute</td>
<td headers="role">Manager, Schreibberechtigter, Leseberechtigter</td>
</tr>
<tr>
<td headers="method"><code>GET/POST</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID/_list/$FURTHER_PATH_PARTS</code></td>
<td headers="action-name">cloudantnosqldb.query.execute</td>
<td headers="role">Manager, Schreibberechtigter, Leseberechtigter</td>
</tr>
<tr>
<td headers="method"><code>GET/POST</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID/_search/$FURTHER_PATH_PARTS</code></td>
<td headers="action-name">cloudantnosqldb.query.execute</td>
<td headers="role">Manager, Schreibberechtigter, Leseberechtigter</td>
</tr>
<tr>
<td headers="method"><code>GET/POST</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID/_show/$FURTHER_PATH_PARTS</code></td>
<td headers="action-name">cloudantnosqldb.query.execute</td>
<td headers="role">Manager, Schreibberechtigter, Leseberechtigter</td>
</tr>
<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID/_view/$VIEW/queries</code></td>
<td headers="action-name">cloudantnosqldb.query.execute</td>
<td headers="role">Manager, Schreibberechtigter, Leseberechtigter</td>
</tr>
<tr>
<td headers="method"><code>GET/POST</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID/_view/$FURTHER_PATH_PARTS</code></td>
<td headers="action-name">cloudantnosqldb.query.execute</td>
<td headers="role">Manager, Schreibberechtigter, Leseberechtigter</td>
</tr>
<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/$DB/_explain/$FURTHER_PATH_PARTS</code></td>
<td headers="action-name">cloudantnosqldb.query.execute</td>
<td headers="role">Manager, Schreibberechtigter, Leseberechtigter</td>
</tr>
<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/$DB/_find/$FURTHER_PATH_PARTS</code></td>
<td headers="action-name">cloudantnosqldb.query.execute</td>
<td headers="role">Manager, Schreibberechtigter, Leseberechtigter</td>
</tr>
<tr>
<td headers="method"><code>GET</code></td>
<td headers="endpoint"><code>/$DB/_local_docs</code></td>
<td headers="action-name">cloudantnosqldb.document-local.read</td>
<td headers="role">Manager, Schreibberechtigter, Leseberechtigter</td>
</tr>
<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/$DB/_local_docs/queries</code></td>
<td headers="action-name">cloudantnosqldb.document-local.read</td>
<td headers="role">Manager, Schreibberechtigter, Leseberechtigter</td>
</tr>
<tr>
<td headers="method"><code>GET</code></td>
<td headers="endpoint"><code>/$DB/_local/$DOC_ID</code></td>
<td headers="action-name">cloudantnosqldb.document-local.read</td>
<td headers="role">Manager, Schreibberechtigter, Leseberechtigter</td>
</tr>
</table>

</br>

#### Nicht verfügbare Endpunkte
{: #unavailable-endpoints}

Die folgenden Endpunkte stehen für Anforderungen, die mit IAM autorisiert wurden, nicht zur Verfügung:

- HTTP-Rewrite-Handler: `/db/_design/design-doc/_rewrite/path`. <br>
Obwohl Entwurfsdokumente möglicherweise Rewrite-Handler enthalten, können diese von Benutzern nicht aufgerufen werden.
- Update-Handler: `POST /{db}/_design/{ddoc}/_update/{func}`. <br>
Obwohl Entwurfsdokumente möglicherweise Update-Funktionen enthalten, können diese von Benutzern nicht aufgerufen werden.

### Zuordnung zwischen {{site.data.keyword.cloudant_short_notm}}-Aktionen und IAM-Rollen herstellen
{: #mapping-of-ibm-cloudant-actions-to-iam-roles}

Nur Benutzer, denen die Rolle 'Manager' zugeordnet wurde, sowie die entsprechenden Services können auf {{site.data.keyword.cloudant_short_notm}}-Daten zugreifen.

<table>
<caption style="caption-side:top">Tabelle 7. Zulässigen Aktionen zugeordnete Rollen</caption>
<thead>
<tr>
<th id="role">Rolle</th>
<th id="allowed-action">Zulässige Aktion</th>
</tr>
</thead>

<tr>
<td headers="role">Manager</td>
<td headers="allowed-action">Alle dokumentierten Aktionen</td>
</tr>

<tr>
<td headers="role">Leseberechtigter</td>
<td headers="allowed-action">Keine</td>
</tr>

<tr>
<td headers="role">Schreibberechtigter</td>
<td headers="allowed-action">Keine</td>
</tr>
</table>

## Fehlerbehebung
{: #troubleshooting}
Wenn in Ihrem System Probleme bei der Authentifizierung mit IAM  auftreten, während Sie Anforderungen an Ihre {{site.data.keyword.cloudant_short_notm}}-Serviceinstanz
absetzen, überprüfen Sie Ihr Konto, wie im nächsten Abschnitt angegeben.

### IAM-Fähigkeit Ihres Kontos sicherstellen
{: #ensure-your-account-is-iam-enabled}

Im Abschnitt 'Übersicht' des IBM Cloudant-Dashboards finden Sie unter den Bereitstellungsdetails Angaben zur Authentifizierungsmethode. Ihre verfügbaren Authentifizierungsmethoden sind dort aufgelistet.  
