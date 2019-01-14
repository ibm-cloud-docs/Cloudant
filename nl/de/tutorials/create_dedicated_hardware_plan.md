---

copyright:
  years: 2015, 2018
lastupdated: "2018-10-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:tip: .tip}

<!-- Acrolinx: 2017-05-10 -->


# Instanz eines {{site.data.keyword.cloudant_short_notm}}-Plans für dedizierte Hardware unter {{site.data.keyword.cloud_notm}} erstellen und nutzen

In diesem Lernprogramm erfahren Sie, wie Sie eine Instanz eines {{site.data.keyword.cloudantfull}}-Plans für dedizierte Hardware erstellen, die das {{site.data.keyword.cloud}}-Dashboard verwendet. Außerdem erfahren Sie hier, wie Sie anschließend mindestens eine Standard-Plan-Instanz bereitstellen, die damit ausgeführt wird, indem Sie entweder den {{site.data.keyword.cloud_notm}}-Katalog oder die {{site.data.keyword.cloud_notm}}-CLI verwenden. 

Durch das Erstellen einer Instanz für einen {{site.data.keyword.cloudant_short_notm}}-Plan für dedizierte Hardware wird eine {{site.data.keyword.cloudant_short_notm}}-Umgebung auf dedizierter Hardware bereitgestellt, die nur Sie verwenden können. Dabei wird im {{site.data.keyword.cloud_notm}}-Dashboard eine Serviceinstanz erstellt. Es ist jedoch nicht möglich, dass Sie direkt auf die Instanz des Plans für dedizierte Hardware zugreifen und Sie verfügen auch nicht über die zugehörigen
Serviceberechtigungsnachweise für diese Instanz. Um eine Instanz des {{site.data.keyword.cloudant_short_notm}}-Plans für dedizierte Hardware nach ihrer Erstellung verwenden zu können, müssen Sie mindestens eine Standard-Plan-Instanz unter dieser Instanz bereitstellen.

## Instanz des {{site.data.keyword.cloudant_short_notm}}-Plans für dedizierte Hardware erstellen

1.  Melden Sie sich bei Ihrem {{site.data.keyword.cloud_notm}}-Konto an.<br/>
    Das {{site.data.keyword.cloud_notm}}-Dashboard finden Sie hier:
    [http://bluemix.net ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://bluemix.net){:new_window}.
    Nach der Authentifizierung mit Ihrem Benutzernamen und Ihrem Kennwort wird das {{site.data.keyword.cloud_notm}}-Dashboard geöffnet:<br/>
    ![{{site.data.keyword.cloud_notm}}-Dashboard](images/img0001.png)

2.  Klicken Sie auf die Schaltfläche `Ressource erstellen`:<br/>
    ![{{site.data.keyword.cloud_notm}} - Schaltfläche 'Ressource erstellen'](images/img0002.png)<br/>
    
3.  Weitere Informationen finden Sie im {{site.data.keyword.cloud_notm}}-Katalog und den verfügbaren Services. Klicken Sie auf die Kategorie `Datenbanken`.
    ![{{site.data.keyword.cloud_notm}}-Katalog](images/img0000.png)

4.  Klicken Sie auf den {{site.data.keyword.cloudant_short_notm}}-Service:<br/>
    ![{{site.data.keyword.cloud_notm}} {{site.data.keyword.cloudant_short_notm}}-Serviceauswahl](images/img0003.png)<br/>
    Die Seite zum Erstellen eines Service wird geöffnet.

5.  Wählen Sie den Plan für `dedizierte Hardware` in der Liste der Preisstrukturpläne unten auf der Seite aus:<br/>
    ![Preisstrukturpläne](../tutorials/images/pricing_plan.png)
    
6.  Geben Sie oben auf der Seite die folgenden Parameter an: <br/>
    -   Geben Sie einen Servicenamen ein.<br/>
    -   Geben Sie die Region und den Standort an, in der bzw. an dem die Bereitstellung stattfinden soll.<br/>
    -   Wählen Sie eine Ressourcengruppe aus.</br>
    -   Wählen Sie einen Standort für die Bereitstellung aus.<br/>
    -   Wählen Sie als Antwort `Ja` oder `Nein` aus, wenn Sie gefragt werden, ob HIPAA erforderlich ist.<br/>
   
    HIPAA gilt nur für Standorte in den Vereinigten Staaten. {{site.data.keyword.IBM}} kann einen dedizierten Cluster oder einen Bare-Metal-Cluster bereitstellen, um die HIPAA-Kontrollmechanismen zu implementieren. Ein Cluster wird nur nach Bestätigung einer BAA (Business Associate Agreement; Geschäftspartnervereinbarung) bereitgestellt, die mit {{site.data.keyword.IBM_notm}} abgeschlossen wurde. Diese Vereinbarung wird in den Servicebeschreibungsbedingungen beschrieben. Die Bereitstellung eines Clusters zum Verwalten von HIPAA-Daten kann mehr als die geschätzten fünf Tage in Anspruch nehmen.
    {: tip}
    
    Standard-Plan-Instanzen werden in derselben Region und im selben Bereich bereitgestellt und eingerichtet.
    {: tip}

    ![Dedizierte Hardware konfigurieren](../tutorials/images/select_deployment_location.png)
        
7.  Klicken Sie auf die Schaltfläche `Erstellen`, um den Bereitstellungsprozess zu starten.<br/>

    Die Abrechnung erfolgt anteilmäßig pro Tag. Stellen Sie daher sicher, dass Sie die angegebene Umgebung kostenpflichtig bereitstellen möchten, bevor Sie auf die Schaltfläche **Erstellen** klicken.
    {: tip}

    ![Dedizierte Hardware bereitstellen](../tutorials/images/create_button_provision.png)

    Während der Bereitstellung wird ein sich drehendes Rad neben der Instanz in Ihrem {{site.data.keyword.cloud_notm}}-Dashboard angezeigt. Eine Anforderung zum Bereitstellen einer Instanz des Plans für dedizierte Hardware auf Bare Metal Server-Systemen wird gesendet. Die Bereitstellungszeit ist asynchron und kann bis zu fünf Tage dauern.
    {: tip}   

    ![Alternative Version der dedizierten Hardware bereitstellen](../tutorials/images/create_button_provision2.png)
    
## Standard-Plan-Instanz in Umgebung mit dedizierter Hardware bereitstellen

1.  Melden Sie sich bei Ihrem {{site.data.keyword.cloud_notm}}-Konto an.<br/>
    Das {{site.data.keyword.cloud_notm}}-Dashboard finden Sie hier:
    [http://bluemix.net ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://bluemix.net){:new_window}.
    Nach der Authentifizierung mit Ihrem Benutzernamen und Ihrem Kennwort wird das {{site.data.keyword.cloud_notm}}-Dashboard geöffnet:<br/>
    ![{{site.data.keyword.cloud_notm}}-Dashboard](images/img0001.png)

2.  Klicken Sie auf die Schaltfläche `Ressource erstellen`:<br/>
    ![{{site.data.keyword.cloud_notm}}-Ressource erstellen](images/img0002.png)<br/>
    Eine Liste der verfügbaren Services, die unter {{site.data.keyword.cloud_notm}} verfügbar sind, wird angezeigt.

3.  Klicken Sie auf die Kategorie `Datenbanken` und wählen Sie den Service `Cloudant` aus:<br/>
    ![{{site.data.keyword.cloud_notm}} {{site.data.keyword.cloudant_short_notm}}-Serviceauswahl](images/img0003.png)</br>
    Die Seite zum Erstellen eines Service wird geöffnet.<br/>  

4.  Klicken Sie in den Preisstrukturplänen auf `Standard`. <br/>
    ![Standardpreisstrukturplan](../tutorials/images/standard_pricing_plan.png)
    
    In einer Umgebung mit dedizierter Hardware kann keine Lite-Plan-Instanz bereitgestellt werden.
    {: tip}
    
5.  Geben Sie die folgenden Parameter ein: <br/>
    -   Geben Sie einen Servicenamen ein.<br/>
    -   Geben Sie die Region und den Standort an, in der bzw. an dem die Bereitstellung stattfinden soll.<br/>
    -   Wählen Sie eine Ressourcengruppe aus.</br>
    -   Wählen Sie eine Authentifizierungsmethode aus.</br>
    -   Wählen Sie eine Umgebung aus.</br>
    ![Standardinstanz konfigurieren](../tutorials/images/select_environment.png)
    
6.  Klicken Sie auf die Schaltfläche `Erstellen`.<br/>
    Nach einigen Sekunden wird die Instanz in der ausgewählten Umgebung bereitgestellt.<br/>
    ![Standardinstanz bereitstellen](../tutorials/images/create_button_provision_standard.png)
    
7.  Rufen Sie Ihren Serviceberechtigungsnachweis ab und greifen Sie auf das {{site.data.keyword.cloudant_short_notm}}-Dashboard zu wie bei einer {{site.data.keyword.cloudant_short_notm}}-Multi-Tenant-Instanz. 
    
    Weitere Informationen finden Sie im Abschnitt zur [Vorgehensweise beim Suchen Ihrer Serviceberechtigungsnachweise](../tutorials/create_service.html#locating-your-service-credentials){:new_window}. 
    
## Standard-Plan-Instanz in Umgebung mit dedizierter Hardware mit {{site.data.keyword.cloud_notm}}-CLI bereitstellen

Um die {{site.data.keyword.cloud_notm}}-CLI verwenden zu können, müssen Sie angemeldet sein. Weitere Informationen zur Vorgehensweise bei der Anmeldung und zum Einrichten einer Zielressourcengruppe finden Sie im Abschnitt zur [Anmeldung bei Ihrem {{site.data.keyword.cloud_notm}}-Konto](create_service_cli.html#logging-in-to-your-ibm-cloud-account){:new_window}. 

Verwenden Sie das folgende Basisbefehlsformat, um eine {{site.data.keyword.cloudant_short_notm}}-Standard-Plan-Instanz in Ihrer Umgebung mit einem {{site.data.keyword.cloudant_short_notm}}-Plan für dedizierte Hardware zu erstellen:


Feld | Beschreibung
------|------------
`NAME`| Ein beliebiger Name, den Sie der Instanz zuweisen.
`SERVICE_NAME` | `cloudantnosqldb`
`PLAN_NAME` | Standard-Plan
`LOCATION` | Der Standort, an dem Sie die Bereitstellung durchführen wollen, z. B. 'us-south', 'us-east' oder 'eu-gb'. 

Im Folgenden ist ein Beispielbefehl aufgeführt: 

```sh
ibmcloud resource service-instance-create NAME SERVICE_NAME SERVICE_PLAN_NAME LOCATION [-p, --parameters @JSON_FILE | JSON_STRING ]
```

{{site.data.keyword.cloudant_short_notm}}-Instanzen, die in Umgebungen mit dedizierter Hardware bereitgestellt werden, verfügen über zwei weitere Parameter:

Parameter | Beschreibung
----------|------------
`environment_crn` | Dieser Parameter muss auf den CRN der Instanz für den {{site.data.keyword.cloudant_short_notm}}-Plan für dedizierte Hardware gesetzt
werden. Sie können den CRN anhand des CLI-Beispielbefehls auf der Registerkarte 'Verwalten' der Instanz für den {{site.data.keyword.cloudant_short_notm}}-Plan für dedizierte Hardware im {{site.data.keyword.cloud_notm}}-Dashboard ermitteln. Alternativ hierzu können Sie den CRN auch mit dem Befehl `ibmcloud resource service-instance SERVICE_INSTANCE_NAME` bestimmen. 
`legacyCredentials` | Ein optionaler Parameter, der standardmäßig auf den Wert 'true' gesetzt ist und der angibt, ob die Instanz sowohl traditionelle Berechtigungsnachweise als auch IAM-Berechtigungsnachweise oder ausschließlich IAM-Berechtigungsnachweise verwendet. Weitere Einzelheiten zur Auswahl der Authentifizierungsmethode finden Sie im [IAM-Leitfaden ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](../guides/iam.html#ibm-cloud-identity-and-access-management-iam-){:new_window}.

Im Folgenden ist ein Beispielbefehl aufgeführt: 

```sh
ibmcloud resource service-instance-create cloudant_on_ded_hardware_cli cloudantnosqldb standard us-south -p '{"environment_crn":"crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b43434444bb7e2abb0841ca25d28ee4c:301a3118-7678-4d99-b1b7-4d45cf5f7b29::","legacyCredentials":false}'
```
     
