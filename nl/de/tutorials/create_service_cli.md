---

copyright:
  years: 2017, 2019
lastupdated: "2019-06-12"

keywords: identify, api endpoints, log in, select ibm cloudant plan, create ibm cloudant service, create credentials, list service credentials, use ibm cloudant service instance, delete service credentials, delete service instance

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

<!-- Acrolinx: 2018-08-20 -->

# {{site.data.keyword.cloudant_short_notm}}-Instanz unter {{site.data.keyword.cloud_notm}} mit {{site.data.keyword.cloud_notm}}-CLI erstellen
{: #creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli}

In diesem Lernprogramm erfahren Sie, wie Sie eine {{site.data.keyword.cloudantfull}}-Serviceinstanz unter {{site.data.keyword.cloud}} mithilfe der {{site.data.keyword.cloud_notm}}-CLI erstellen.
{: shortdesc}

## Vorbereitende Schritte für dieses Lernprogramm 
{: #before-you-start-this-tutorial}

Bevor Sie dieses Lernprogramm starten können, müssen Sie zuerst die {{site.data.keyword.cloud_notm}}-CLI-Entwicklertools installieren. Weitere Informationen zur Installation der Tools finden Sie im Lernprogramm mit der [Einführung in die {{site.data.keyword.cloud_notm}}-CLI ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://cloud.ibm.com/docs/cli?topic=cloud-cli-ibmcloud-cli#overview){: new_window}.

## {{site.data.keyword.cloud_notm}}-API-Endpunkt angeben
{: #identifying-the-ibm-cloud-api-endpoint}

Geben Sie den Ziel-API-Endpunkt für Ihre {{site.data.keyword.cloud_notm}}-Befehle an:

```sh
ibmcloud api https://api.ng.bluemix.net
```
{: codeblock}

Das Ergebnis bestätigt, dass Sie den Endpunkt korrekt angegeben haben:

```sh
Setting api endpoint to https://api.ng.bluemix.net...
OK

API endpoint: https://api.ng.bluemix.net (API version: 2.54.0)
Not logged in. Use 'ibmcloud login' to log in.
```
{: pre}

## Bei Ihrem {{site.data.keyword.cloud_notm}}-Konto anmelden
{: #logging-in-to-your-ibm-cloud-account}

Im folgenden Beispiel wird der Anmeldeprozess beschrieben. Wenn Sie eine föderierte Benutzer-ID verwenden, dann ist es wichtig, dass Sie Ihr System auf die Benutzung eines Einmalkenncodes (`ibmcloud login --sso`) umstellen oder einen API-Schlüssel (`ibmcloud --apikey key oder @key_file`) zur Authentifizierung verwenden. Weitere Informationen zur Vorgehensweise bei der Anmeldung über die CLI finden Sie im Abschnitt zu den
[allgemeinen CLI-Befehlen (ibmcloud) ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://cloud.ibm.com/docs/cli/reference/ibmcloud?topic=cloud-cli-ibmcloud_cli#ibmcloud_login){: new_window} unter `ibmcloud login`. 

1.  Starten Sie den Anmeldeprozess für
  ihr {{site.data.keyword.cloud_notm}}-Konto mithilfe des folgenden Befehls:
  
  ```sh
  ibmcloud login
  ```
  {: codeblock}
  
  {{site.data.keyword.cloud_notm}} antwortet mit einer Erinnerung an den aktuellen
  API-Endpunkt und fragt dann nach der E-Mail-Adresse für Ihr Konto:
  
  ```sh
  API endpoint: https://api.ng.bluemix.net
  
  Email>
  ```
  {: pre}

2.  Geben Sie die E-Mail-Adresse Ihres Kontos und anschließend Ihr Kennwort ein:

  ```sh
  API endpoint: https://api.ng.bluemix.net
  
  Email> J.Doe@email.com
  
  Password>
  ```
  {: pre}
  
  {{site.data.keyword.cloud_notm}} validiert Ihre Details  und fasst dann die Informationen zu Ihrer Anmeldesitzung zusammen:

  ```sh
  API endpoint: https://api.ng.bluemix.net
  
  Email> J.Doe@email.com
  
  Password> 
  Authenticating...
  OK
  
  Targeted account J DOE's Account (707...a32)
  
  Targeted org J.Doe@email.com
  
  Targeted space dev
  
  API endpoint:   https://api.ng.bluemix.net (API version: 2.54.0)
  Region:         us-south
  User:           j.doe@email.com
  Account:        J DOE's Account (707...a32)
  Org:            J.Doe@email.com
  Space:          dev
  ```
  {: pre}

3.  Sie sind jetzt bei Ihrem {{site.data.keyword.cloud_notm}}-Konto angemeldet.

## {{site.data.keyword.cloudant_short_notm}}-Plan für Ihren Service auswählen
{: #choosing-the-ibm-cloudant-plan-for-your-service}

Detaillierte Informationen zur Verwendung des {{site.data.keyword.cloudant_short_notm}}-Lite-Plans oder -Standard-Plans finden Sie im Abschnitt zu den [Plänen](/docs/services/Cloudant?topic=cloudant-ibm-cloud-public#plans) in der Dokumentation.
{: pre}

## {{site.data.keyword.cloudant_short_notm}}-Service erstellen
{: #creating-the-ibm-cloudant-service}

{{site.data.keyword.cloudant_short_notm}} verwendet anstelle von Cloud Foundry-Organisationen und -Bereichen zur Bereitstellung neuer Instanzen entsprechende Ressourcengruppen. {{site.data.keyword.cloudant_short_notm}}-Instanzen, die in der Vergangenheit bereitgestellt wurden, können weiterhin in Cloud Foundry-Organisationen und -Bereichen bereitgestellt werden. Weitere Informationen hierzu finden Sie im Leitfaden zur [Zusammenarbeit von {{site.data.keyword.cloudant_short_notm}} mit {{site.data.keyword.cloud_notm}}-Ressourcengruppen![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](/docs/services/Cloudant?topic=cloudant-how-does-ibm-cloudant-work-with-ibm-cloud-resource-groups-#how-does-ibm-cloudant-work-with-ibm-cloud-resource-groups-){: new_window}.

Als Erstes müssen Sie die Zielressourcengruppe und die Region festlegen. Die entsprechende Vorgehensweise wird im Abschnitt zu den [allgemeinen CLI-Befehlen (ibmcloud) ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://cloud.ibm.com/docs/cli/reference/ibmcloud?topic=cloud-cli-ibmcloud_cli#ibmcloud_target){: new_window} unter `ibmcloud target` beschrieben. Verwenden Sie das folgende Befehlsformat:

```sh
ibmcloud target [-r REGION_NAME] [-g RESOURCE_GROUP]
```

Führen Sie den folgenden Befehl aus, um eine Liste der Regionen abzurufen:

```sh
ibmcloud regions
```

Führen Sie den folgenden Befehl aus, um eine Liste der Ressourcengruppen abzurufen: 

```sh
ibmcloud resource groups
```

Verwenden Sie als Nächstes in {{site.data.keyword.cloud_notm}} das folgende Basisbefehlsformat, um eine Serviceinstanz zu erstellen:

```sh
ibmcloud resource service-instance-create NAME SERVICE_NAME|SERVICE_ID SERVICE_PLAN_NAME|SERVICE_PLAN_ID LOCATION [-p, --parameters @JSON_FILE | JSON_STRING ]
```
{: pre}

Die Felder sind in der folgenden Tabelle beschrieben: 


Feld | Beschreibung
------|------------
`NAME` | Der beliebige Name, den Sie der Instanz zuordnen. 
`SERVICE_NAME` | `cloudantnosqldb`
`PLAN_NAME` | Der Lite-Plan oder der Standard-Plan.
`LOCATION` | Der Standort, an dem Sie die Bereitstellung durchführen wollen: Asiatisch-pazifischer Raum (Norden), Deutschland, Global, Sydney, Vereinigtes Königreich, Vereinigte Staaten (Osten) oder Vereinigte Staaten (Süden). 
`legacyCredentials` | Der Standardwert ist 'true'. Dieses Feld gibt an, ob die Instanz sowohl traditionelle Berechtigungsnachweise als auch IAM-Berechtigungsnachweise oder ausschließlich IAM-Berechtigungsnachweise verwendet. 

Weitere Informationen zur Auswahl der Authentifizierungsmethode finden Sie im [IAM-Leitfaden](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-){: new_window}. Das {{site.data.keyword.cloudant_short_notm}}-Team empfiehlt die Verwendung der IAM-Zugriffssteuerung anstelle der traditionellen {{site.data.keyword.cloudant_short_notm}}-Authentifizierung, soweit möglich.
{: important}

Im vorliegenden Beispiel soll eine Instanz eines {{site.data.keyword.cloudant_short_notm}}-Service mithilfe des `Lite`-Plans erstellt werden, wobei der Instanzname `cs20170517a` und der Standort 'us-south' (Vereinigte Staaten (Süden)) lautet und ausschließlich IAM-Berechtigungsnachweise verwendet werden. Sie erstellen diese Instanz mithilfe des folgenden Befehls:

```sh
ibmcloud resource service-instance-create cs20170517a cloudantnosqldb lite us-south -p '{"legacyCredentials": false}'
```
{: codeblock}

Nachdem die Serviceinstanz erstellt wurde,
antwortet {{site.data.keyword.cloud_notm}} mit einer Nachricht ähnlich dem folgenden Beispiel:

```sh
Creating service instance cs20170517a in resource group default of account John Does's Account as j.doe@email.com...
OK
Service instance cs20170517a was created.
Name          Location   State    Type               Tags
cs20170517a   us-south   active   service_instance  
```
{: pre}

## Berechtigungsnachweise für Ihren {{site.data.keyword.cloudant_short_notm}}-Service erstellen
{: #creating-credentials-for-your-ibm-cloudant-service}

Anwendungen, die Zugriff auf Ihren {{site.data.keyword.cloudant_short_notm}}-Service erfordern,
müssen über die erforderlichen Berechtigungsnachweise verfügen.

Serviceberechtigungsnachweise sind wertvoll. Wenn Benutzer oder Anwendungen Zugriff auf die Berechtigungsnachweise haben, können sie die Serviceinstanz in beliebiger Weise nutzen. Sie können beispielsweise gefälschte Daten erstellen oder wertvolle Informationen löschen. Schützen Sie diese Berechtigungsnachweise sorgfältig.
{: important}

Weitere Informationen zu den Feldern, die in den Serviceberechtigungsnachweisen enthalten sind, finden Sie im [IAM-Leitfaden](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-){: new_window}.

Das Basisbefehlsformat zum Erstellen von Berechtigungsnachweisen für eine Serviceinstanz in {{site.data.keyword.cloud_notm}} lautet wie folgt:

```sh
ibmcloud resource service-key-create NAME ROLE_NAME --instance-name SERVICE_INSTANCE_NAME
```
{: pre}

Die Felder sind in der folgenden Tabelle beschrieben:

Feld | Beschreibung
------|------------
`NAME` | Der beliebige Name, den Sie den Serviceberechtigungsnachweisen zuordnen. 
`ROLE_NAME` | In diesem Feld ist momentan nur die Rolle 'Manager' zulässig.
`SERVICE_INSTANCE_NAME` | Der Name, den Sie Ihrer {{site.data.keyword.cloudant_short_notm}}-Instanz zuordnen. 

Wenn Sie Berechtigungsnachweise für die Instanz `cs20170517a` eines
{{site.data.keyword.cloudant_short_notm}}-Service erstellen wollen, wobei der Name der Berechtigungsnachweise `creds_for_cs20170517a` lautet, erstellen Sie diese Berechtigungsnachweise mithilfe des folgenden Befehls:

```sh
ibmcloud resource service-key-create creds_for_cs20170517a Manager --instance-name cs20170517a
```
{: codeblock}

Nachdem Sie die Anforderung zum Erstellen von Berechtigungsnachweisen für die Serviceinstanz empfangen haben,
antwortet {{site.data.keyword.cloud_notm}} mit einer Nachricht ähnlich dem folgenden Beispiel:

```sh
Erstellen von Serviceschlüssel in Ressourcengruppe default von Konto John Doe als john.doe@email.com...
OK
Serviceschlüssel crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a wurde erstellt.
                  
Name:          creds_for_cs20170517a
ID:            crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a   
Erstellt am:   Di 18. Sep 19:58:38 UTC 2018
Status:        aktiv
Berechtigungsnachweise:
               iam_apikey_name:          auto-generated-apikey-621ffde2-ea10-4318-b297-d6d849cec48a
               iam_role_crn:             crn:v1:bluemix:public:iam::::serviceRole:Manager
               url:                      https://f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix:5811381f6daff7255b288695c3544be63f550e975bcde46799473e69c7d48d61@f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix.cloudant.com
               username:                 f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix
               port:                     443
               apikey:                   XXXXX-XXXXXX_XXXXXXXXXXXXX-XXXXXXXXXXX
               host:                     f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix.cloudant.com
               iam_apikey_description:   Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42116849bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3::
               iam_serviceid_crn:        crn:v1:bluemix:public:iam-identity::a/b42116849bb7e2abb0841ca25d28ee4c::serviceid:ServiceId-53f9e2a2-cdfb-4f90-b072-bfffafb68b3e
               password:                 581138...7d48d61 
```
{: pre}

## Serviceberechtigungsnachweise für Ihren {{site.data.keyword.cloudant_short_notm}}-Service abrufen
{: #retrieving-the-service-credentials-for-your-ibm-cloudant-service}

Das Basisbefehlsformat zum Abrufen der Berechtigungsnachweise für eine Serviceinstanz
in {{site.data.keyword.cloud_notm}} lautet wie folgt:

```sh
ibmcloud resource service-key KEY_NAME
```
{: pre}

Im vorliegenden Beispiel sollen Berechtigungsnachweise für die Instanz `cs20170517a` eines {{site.data.keyword.cloudant_short_notm}}-Service abgerufen werden, wobei der Name der Berechtigungsnachweise `creds_for_cs20170517a` lautet. Sie rufen die Berechtigungsnachweise mit dem im folgenden Beispiel dargestellten Befehl ab:

```sh
ibmcloud resource service-key creds_for_cs20170517b
```
{: codeblock}

Nachdem Sie die Anforderung zum Abrufen von Berechtigungsnachweisen für die Serviceinstanz empfangen haben,
antwortet {{site.data.keyword.cloud_notm}} mit einer Nachricht ähnlich dem folgenden (abgekürzten) Beispiel:

```sh
Abrufen von Serviceschlüssel in Ressourcengruppe default von Konto John Doe als john.doe@email.com...
OK
Serviceschlüssel crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a wurde erstellt.
                  
Name:          creds_for_cs20170517a
ID:            crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a   
Erstellt am:   Di 18. Sep 19:58:38 UTC 2018
Status:        aktiv
Berechtigungsnachweise:
               iam_apikey_name:          auto-generated-apikey-621ffde2-ea10-4318-b297-d6d849cec48a
               iam_role_crn:             crn:v1:bluemix:public:iam::::serviceRole:Manager
               url:                      https://f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix:5811381f6daff7255b288695c3544be63f550e975bcde46799473e69c7d48d61@f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix.cloudant.com
               username:                 f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix
               port:                     443
               apikey:                   XXXXX-XXXXXX_XXXXXXXXXXXXX-XXXXXXXXXXX
               host:                     f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix.cloudant.com
               iam_apikey_description:   Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42116849bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3::
               iam_serviceid_crn:        crn:v1:bluemix:public:iam-identity::a/b42116849bb7e2abb0841ca25d28ee4c::serviceid:ServiceId-53f9e2a2-cdfb-4f90-b072-bfffafb68b3e
               password:                 581138...7d48d61 
```
{: pre}

## {{site.data.keyword.cloudant_short_notm}}-Serviceinstanz verwenden
{: #using-your-ibm-cloudant-service-instance}

Nun haben Sie die folgenden Tasks abgeschlossen:

1.  Erstellung einer {{site.data.keyword.cloudant_short_notm}}-Serviceinstanz in {{site.data.keyword.cloud_notm}}.
2.  Erstellung von Berechtigungsnachweisen für die {{site.data.keyword.cloudant_short_notm}}-Serviceinstanz.
3.  Abruf der Serviceinstanzberechtigungsnachweise, damit diese für Ihre Anwendung verwendet werden können.

Weitere Informationen finden Sie im Lernprogramm zum [Erstellen und Füllen einer einfachen {{site.data.keyword.cloudant_short_notm}}-Datenbank unter {{site.data.keyword.cloud_notm}}](/docs/services/Cloudant?topic=cloudant-creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud#context){: new_window}. In diesem Lernprogramm wird gezeigt, wie eine {{site.data.keyword.cloudant_short_notm}}-Serviceinstanz aus einer Python-Anwendung mithilfe von traditionellen Berechtigungsnachweisen verwendet werden
kann. Denken Sie daran, die Berechtigungsnachweise zu ersetzen, die Sie in diesem Lernprogramm erstellt haben.

## (Optional) Abschließende Bereinigung
{: #-optional-tidying-up-afterward}

Die folgende kurze Liste mit Befehlen kann hilfreich sein, wenn Sie Ihre Entwicklungsumgebung aufräumen möchten.

### Serviceberechtigungsnachweise löschen
{: #deleting-service-credentials}

Verwenden Sie den folgenden Befehl, um eine Gruppe von Serviceberechtigungsnachweisen zu löschen:

```sh
ibmcloud resource service-key-delete KEY_NAME
```
{: pre}

Verwenden Sie z. B. den folgenden Befehl, um die Berechtigungsnachweise mit dem Namen `creds_for_cs20170517a` zu löschen:

```sh
ibmcloud resource service-key-delete creds_for_cs20170517a
```
{: pre}

### Serviceinstanz löschen
{: #deleting-a-service-instance}

Verwenden Sie den folgenden Befehl, um eine Serviceinstanz zu löschen:

```sh
ibmcloud resource service-instance-delete SERVICE_INSTANCE_NAME
```
{: pre}

Um beispielsweise die Instanz `cs20170517a` eines {{site.data.keyword.cloudant_short_notm}}-Service zu löschen, können Sie den folgenden Befehl verwenden:

```sh
ibmcloud resource service-instance-delete cs20170517a
```
{: pre}

