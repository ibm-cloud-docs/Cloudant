---

copyright:
  years: 2015, 2019
lastupdated: "2019-04-02"

keywords: create dedicated hardware plan instance, provision standard plan instance, cli, create credentials, list service credentials

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

# Instanz eines {{site.data.keyword.cloudant_short_notm}}-Plans für dedizierte Hardware unter {{site.data.keyword.cloud_notm}} erstellen und nutzen
{: #creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud}

In diesem Lernprogramm erfahren Sie, wie Sie eine Instanz eines {{site.data.keyword.cloudantfull}}-Plans für dedizierte Hardware erstellen, die das {{site.data.keyword.cloud}}-Dashboard verwendet. Außerdem erfahren Sie hier, wie Sie anschließend mindestens eine Standard-Plan-Instanz bereitstellen, die damit ausgeführt wird, indem Sie entweder den {{site.data.keyword.cloud_notm}}-Katalog oder die {{site.data.keyword.cloud_notm}}-CLI verwenden. 
{: shortdesc}

Durch das Erstellen einer Instanz für einen {{site.data.keyword.cloudant_short_notm}}-Plan für dedizierte Hardware wird eine {{site.data.keyword.cloudant_short_notm}}-Umgebung auf dedizierter Hardware bereitgestellt, die nur Sie verwenden können. Dabei wird im {{site.data.keyword.cloud_notm}}-Dashboard eine Serviceinstanz erstellt. Es ist jedoch nicht möglich, dass Sie direkt auf die Instanz des Plans für dedizierte Hardware zugreifen und Sie verfügen auch nicht über die zugehörigen
Serviceberechtigungsnachweise für diese Instanz. Um eine Instanz des {{site.data.keyword.cloudant_short_notm}}-Plans für dedizierte Hardware nach ihrer Erstellung verwenden zu können, müssen Sie mindestens eine Standard-Plan-Instanz unter dieser Instanz bereitstellen.

## Instanz des {{site.data.keyword.cloudant_short_notm}}-Plans für dedizierte Hardware erstellen
{: #creating-an-ibm-cloudant-dedicated-hardware-plan-instance}

1.  Melden Sie sich bei Ihrem {{site.data.keyword.cloud_notm}}-Konto an.<br/>
    Das {{site.data.keyword.cloud_notm}}-Dashboard finden Sie hier:
    [`https://cloud.ibm.com/` ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://cloud.ibm.com/){: new_window}.
    Nach der Authentifizierung mit Ihrem Benutzernamen und Ihrem Kennwort wird das
    {{site.data.keyword.cloud_notm}}-Dashboard angezeigt. Klicken Sie auf die Schaltfläche `Ressource erstellen`:<br/>
    ![{{site.data.keyword.cloud_notm}}-Dashboard](images/img0001.png)

2.  Klicken Sie im linken Menü auf `Datenbanken` und in der Liste der Datenbankservices auf `Cloudant`.<br/>
     ![{{site.data.keyword.cloud_notm}} {{site.data.keyword.cloudant_short_notm}}-Serviceauswahl](images/img0003.png)<br/>

3.  Wählen Sie den Plan für `dedizierte Hardware` in der Liste der Preisstrukturpläne unten auf der Seite aus:<br/>
    ![Preisstrukturpläne](/docs/services/Cloudant/tutorials/images/pricing_plan.png)
    
4.  Geben Sie oben auf der Seite die folgenden Parameter an: <br/>
    -   Geben Sie einen Servicenamen ein.<br/>
    -   Geben Sie die Region und den Standort an, in der bzw. an dem die Bereitstellung stattfinden soll.<br/>
    -   Wählen Sie eine Ressourcengruppe aus.</br>
    -   Fügen Sie einen Tag hinzu. 
    -   Wählen Sie einen Standort für die Bereitstellung aus.<br/>
    -   Wählen Sie als Antwort `Ja` oder `Nein` aus, wenn Sie gefragt werden, ob HIPAA erforderlich ist.<br/> 
    
    HIPAA gilt nur für Standorte in den Vereinigten Staaten. {{site.data.keyword.IBM}} kann eine Umgebung für einen Plan für dedizierte Hardware hinzufügen, um HIPAA-Kontrollmechanismen zu implementieren. Eine Umgebung wird nur nach Bestätigung einer BAA-Vereinbarung (BAA = Business Associate Agreement) bereitgestellt, die mit {{site.data.keyword.IBM_notm}} abgeschlossen wurde. Weitere Informationen finden Sie in [Unterstützte Einstellung für HIPAA aktivieren](https://cloud.ibm.com/docs/account/eu_hipaa_supported.html#enabling-the-hipaa-supported-setting) und in der Servicebeschreibung. Die Bereitstellung eines Clusters zum Verwalten von HIPAA-Daten kann mehr als die geschätzten fünf Tage in Anspruch nehmen.
    {: note}

    ![Dedizierte Hardware konfigurieren](/docs/services/Cloudant/tutorials/images/select_deployment_location.png)
        
5.  Klicken Sie auf die Schaltfläche `Erstellen`, um den Bereitstellungsprozess zu starten. <br/>

    Die Abrechnung erfolgt anteilmäßig pro Tag. Stellen Sie daher sicher, dass Sie die angegebene Umgebung kostenpflichtig bereitstellen möchten, bevor Sie auf die Schaltfläche **Erstellen** klicken.
    {: note}

    ![Dedizierte Hardware bereitstellen](/docs/services/Cloudant/tutorials/images/create_button_provision.png)

    Während der Bereitstellung wird ein sich drehendes Rad neben der Instanz in Ihrem {{site.data.keyword.cloud_notm}}-Dashboard angezeigt. Eine Anforderung zum Bereitstellen einer Instanz des Plans für dedizierte Hardware auf Bare Metal Server-Systemen wird gesendet. Die Bereitstellungszeit ist asynchron und kann bis zu fünf Tage dauern. 
    {: note}   

    ![Alternative Version der dedizierten Hardware bereitstellen](/docs/services/Cloudant/tutorials/images/create_button_provision2.png)
    
## Standard-Plan-Instanz in Umgebung mit dedizierter Hardware bereitstellen
{: #provisioning-a-standard-plan-instance-on-a-dedicated-hardware-environment}

1.  Melden Sie sich bei Ihrem {{site.data.keyword.cloud_notm}}-Konto an.<br/>
    Das {{site.data.keyword.cloud_notm}}-Dashboard finden Sie hier:
    [https://cloud.ibm.com/![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://cloud.ibm.com/){: new_window}.
    Nach der Authentifizierung mit Ihrem Benutzernamen und Ihrem Kennwort wird das
    {{site.data.keyword.cloud_notm}}-Dashboard angezeigt. Klicken Sie auf die Schaltfläche `Ressource erstellen`:<br/>
    ![{{site.data.keyword.cloud_notm}}-Dashboard](images/img0001.png)

2.  Klicken Sie im linken Menü auf `Datenbanken` und in der Liste der Datenbankservices auf `Cloudant`.<br/>
     ![{{site.data.keyword.cloud_notm}} {{site.data.keyword.cloudant_short_notm}}-Serviceauswahl](images/img0003.png)<br/>
    Die Seite zum Erstellen eines Service wird geöffnet.<br/>  

3.  Klicken Sie in den Preisstrukturplänen auf `Standard`. <br/>
    ![Standardpreisstrukturplan](/docs/services/Cloudant/tutorials/images/standard_pricing_plan.png)
    
    In einer Umgebung mit dedizierter Hardware kann keine Lite-Plan-Instanz bereitgestellt werden.
    {: tip}
    
4.  Geben Sie die folgenden Parameter ein: <br/>
    -   Geben Sie einen Servicenamen ein.<br/>
    -   Geben Sie die Region und den Standort an, in der bzw. an dem die Bereitstellung stattfinden soll. <br/>
    -   Wählen Sie eine Ressourcengruppe aus. </br>
    -   Fügen Sie einen Tag hinzu. 
    -   Wählen Sie eine Authentifizierungsmethode aus.</br>
    -   Wählen Sie eine Umgebung aus.</br>
    ![Standardinstanz konfigurieren](/docs/services/Cloudant/tutorials/images/select_environment.png)
    
5.  Klicken Sie auf die Schaltfläche `Erstellen`.<br/>
    Nach einigen Sekunden wird die Instanz in der ausgewählten Umgebung bereitgestellt.<br/>
    ![Standardinstanz bereitstellen](/docs/services/Cloudant/tutorials/images/create_button_provision_standard.png)
    
6.  Rufen Sie Ihren Serviceberechtigungsnachweis ab und greifen Sie auf das {{site.data.keyword.cloudant_short_notm}}-Dashboard zu wie bei einer {{site.data.keyword.cloudant_short_notm}}-Multi-Tenant-Instanz. 
    
    Weitere Informationen finden Sie im Abschnitt zur [Vorgehensweise beim Suchen Ihrer Serviceberechtigungsnachweise](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#locating-your-service-credentials){: new_window}. 
    
## Standard-Plan-Instanz in Umgebung mit dedizierter Hardware mit {{site.data.keyword.cloud_notm}}-CLI bereitstellen
{: #provisioning-a-standard-plan-instance-on-a-dedicated-hardware-environment-with-the-ibm-cloud-cli}

Um die {{site.data.keyword.cloud_notm}}-CLI verwenden zu können, müssen Sie angemeldet sein. Weitere Informationen zur Vorgehensweise bei der Anmeldung und zum Einrichten einer Zielressourcengruppe finden Sie im Abschnitt zur [Anmeldung bei Ihrem {{site.data.keyword.cloud_notm}}-Konto](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli#logging-in-to-your-ibm-cloud-account){: new_window}. 

Verwenden Sie das folgende Basisbefehlsformat, um eine {{site.data.keyword.cloudant_short_notm}}-Standard-Plan-Instanz in Ihrer Umgebung mit einem {{site.data.keyword.cloudant_short_notm}}-Plan für dedizierte Hardware zu erstellen:


Feld | Beschreibung
------|------------
`NAME`| Ein beliebiger Name, den Sie der Instanz zuweisen.
`SERVICE_NAME` | `cloudantnosqldb`
`PLAN_NAME` | Standard-Plan
`LOCATION` |  Der Standort, an dem Sie die Bereitstellung durchführen wollen, z. B. 'us-south', 'us-east' oder 'eu-gb'. 

Im Folgenden ist ein Beispielbefehl aufgeführt: 

```sh
ibmcloud resource service-instance-create NAME SERVICE_NAME SERVICE_PLAN_NAME LOCATION [-p, --parameters @JSON_FILE | JSON_STRING ]
```
{: codeblock}

{{site.data.keyword.cloudant_short_notm}}-Instanzen, die in Umgebungen mit dedizierter Hardware bereitgestellt werden, verfügen über zwei weitere Parameter:

Parameter | Beschreibung
----------|------------
`environment_crn` | Dieser Parameter muss auf den CRN der Instanz für den {{site.data.keyword.cloudant_short_notm}}-Plan für dedizierte Hardware gesetzt
werden. Sie können den CRN anhand des CLI-Beispielbefehls auf der Registerkarte 'Verwalten' der Instanz für den {{site.data.keyword.cloudant_short_notm}}-Plan für dedizierte Hardware im {{site.data.keyword.cloud_notm}}-Dashboard ermitteln. Alternativ hierzu können Sie den CRN auch mit dem Befehl `ibmcloud resource service-instance SERVICE_INSTANCE_NAME` bestimmen. 
`legacyCredentials` | Ein optionaler Parameter, der standardmäßig auf den Wert 'true' gesetzt ist und der angibt, ob die Instanz sowohl traditionelle Berechtigungsnachweise als auch IAM-Berechtigungsnachweise oder ausschließlich IAM-Berechtigungsnachweise verwendet. Weitere Einzelheiten zur Auswahl der Authentifizierungsmethode finden Sie im [IAM-Leitfaden ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-){: new_window}.

Im Folgenden ist ein Beispielbefehl aufgeführt: 

```sh
ibmcloud resource service-instance-create cloudant_on_ded_hardware_cli cloudantnosqldb standard us-south -p '{"environment_crn":"crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b43434444bb7e2abb0841ca25d28ee4c:301a3118-7678-4d99-b1b7-4d45cf5f7b29::","legacyCredentials":false}'
```
{: codeblock}

## Berechtigungsnachweise für Ihren {{site.data.keyword.cloudant_short_notm}}-Service erstellen
{: #creating-the-credentials-for-your-ibm-cloudant-service}

Anwendungen, die Zugriff auf Ihren {{site.data.keyword.cloudant_short_notm}}-Service erfordern,
müssen über die erforderlichen Berechtigungsnachweise verfügen.

Serviceberechtigungsnachweise sind wertvoll. Wenn Benutzer oder Anwendungen Zugriff auf die Berechtigungsnachweise haben, können sie die Serviceinstanz in beliebiger Weise nutzen. Sie können beispielsweise gefälschte Daten erstellen oder wertvolle Informationen löschen. Schützen Sie diese Berechtigungsnachweise sorgfältig.
{: important}

Weitere Informationen zu den Feldern, die in den Serviceberechtigungsnachweisen enthalten sind, finden Sie im [IAM-Leitfaden ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-){: new_window}.

Das Basisbefehlsformat zum Erstellen von Berechtigungsnachweisen für eine Serviceinstanz in {{site.data.keyword.cloud_notm}} lautet wie folgt:

```sh
ibmcloud resource service-key-create NAME ROLE_NAME --instance-name SERVICE_INSTANCE_NAME [--enable-internal-service-endpoint true]
```
{: pre}

Die Felder sind in der folgenden Tabelle beschrieben:

Feld | Beschreibung
------|------------
`NAME` | Der beliebige Name, den Sie den Serviceberechtigungsnachweisen zuordnen. 
`ROLE_NAME` | In diesem Feld ist momentan nur die Rolle 'Manager' zulässig.
`SERVICE_INSTANCE_NAME` | Der Name, den Sie Ihrer {{site.data.keyword.cloudant_short_notm}}-Instanz zuordnen.
`enable-internal-service-endpoint` | Ein optionales Feld zum Füllen des URL-Felds in den Serviceberechtigungsnachweisen mit einem internen Endpunkt für die Verbindung mit dem Service über das interne {{site.data.keyword.cloud_notm}}-Netz. Geben Sie dieses Feld nicht an, um die URL mit einem externen Endpunkt zu füllen, der allgemein zugänglich ist. Gilt nur für Instanzen des Standard-Plans, die in Umgebungen mit dedizierter Hardware bereitgestellt wurden, die interne Endpunkte unterstützen. Der Befehl verursacht einen Fehler des Typs 400, wenn die Umgebung keine internen Endpunkte unterstützt. 

Wenn Sie Berechtigungsnachweise für die Instanz `cs20170517a` eines
{{site.data.keyword.cloudant_short_notm}}-Service erstellen möchten (dabei ist `creds_for_cs20170517a` der Name der Berechtigungsnachweise), erstellen Sie diese Berechtigungsnachweise mit einem ähnlichen Befehl wie im folgenden Beispiel:

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

Wenn Sie Berechtigungsnachweise für die Instanz `cs20170517a` eines
{{site.data.keyword.cloudant_short_notm}}-Service erstellen möchten (dabei ist `creds_for_cs20170517a` der Name der Berechtigungsnachweise) und die URL mit dem internen Endpunkt füllen möchten, erstellen Sie diese Berechtigungsnachweise mit einem ähnlichen Befehl wie im folgenden Beispiel:

```sh
ibmcloud resource service-key-create creds_for_cs20170517a Manager --instance-name cs20170517a --enable-internal-service-endpoint true
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
Created At:    Tue Jan 02 19:58:38 UTC 2019
State:         active
Credentials:
               iam_apikey_name:          auto-generated-apikey-621ffde2-ea10-4318-b297-d6d849cec48a
               iam_role_crn:             crn:v1:bluemix:public:iam::::serviceRole:Manager
               url:                      https://2624fed5-e53e-41de-a85b-3c7d7636886f-bluemix.private.cloudantnosqldb.appdomain.cloud
               username:                 f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix
               apikey:                   XXXXX-XXXXXX_XXXXXXXXXXXXX-XXXXXXXXXXX
               host:                     2624fed5-e53e-41de-a85b-3c7d7636886f-bluemix.private.cloudantnosqldb.appdomain.cloud
               iam_apikey_description:   Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42116849bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3::
               iam_serviceid_crn:        crn:v1:bluemix:public:iam-identity::a/b42116849bb7e2abb0841ca25d28ee4c::serviceid:ServiceId-53f9e2a2-cdfb-4f90-b072-bfffafb68b3e
```
{: pre}

## Serviceberechtigungsnachweise für Ihren {{site.data.keyword.cloudant_short_notm}}-Service auflisten
{: #listing-the-service-credentials-for-your-ibm-cloudant-service}

Das Basisbefehlsformat zum Abrufen der Berechtigungsnachweise für eine Serviceinstanz
in {{site.data.keyword.cloud_notm}} lautet wie folgt:

```sh
ibmcloud resource service-key KEY_NAME
```
{: codeblock}

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
