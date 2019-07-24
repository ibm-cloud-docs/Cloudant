---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

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

# Creazione e utilizzo di un'istanza del piano {{site.data.keyword.cloudant_short_notm}} Hardware dedicato su {{site.data.keyword.cloud_notm}}
{: #creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud}

Questa esercitazione illustra come creare un'istanza del piano {{site.data.keyword.cloudantfull}} Hardware dedicato che utilizza il dashboard {{site.data.keyword.cloud}} e come eseguire successivamente il provisioning di una o più istanze del piano Standard da eseguire su di essa utilizzando il catalogo {{site.data.keyword.cloud_notm}} oppure la CLI {{site.data.keyword.cloud_notm}}. 
{: shortdesc}

La creazione di un'istanza del piano Hardware dedicato {{site.data.keyword.cloudant_short_notm}} comporta il provisioning
di un ambiente {{site.data.keyword.cloudant_short_notm}} sull'hardware dedicato unicamente per il tuo utilizzo esclusivo. Un'istanza
del servizio viene creata nel dashboard {{site.data.keyword.cloud_notm}} ma non puoi
accedere direttamente all'istanza del piano Hardware dedicato e non avrai
alcuna credenziale del servizio per essa. Puoi utilizzare un'istanza del piano hardware {{site.data.keyword.cloudant_short_notm}} dedicato
dopo che è stata creata eseguendo su di essa il provisioning di una o più istanze del piano
Standard.

## Creazione di un'istanza del piano hardware {{site.data.keyword.cloudant_short_notm}} dedicato
{: #creating-an-ibm-cloudant-dedicated-hardware-plan-instance}

1.  Accedi al tuo account {{site.data.keyword.cloud_notm}}.<br/>
    Puoi trovare il dashboard {{site.data.keyword.cloud_notm}} all'indirizzo:
    [`https://cloud.ibm.com/ ` ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://cloud.ibm.com/){: new_window}.
    Dopo l'autenticazione con i tuoi nome utente e password,
    ti viene presentato il dashboard {{site.data.keyword.cloud_notm}}. Fai clic sul pulsante `Crea risorsa`:<br/>
    ![{{site.data.keyword.cloud_notm}} - Dashboard](images/img0001.png)

2.  Fai clic su `Database` dal menu e su `Cloudant` dall'elenco dei servizi di database.<br/>
     ![{{site.data.keyword.cloud_notm}} {{site.data.keyword.cloudant_short_notm}} - Selezione del servizio](images/img0003.png)<br/>

3.  Seleziona il piano `Hardware dedicato` dall'elenco di piani dei prezzi:<br/>
    ![Piani dei prezzi](images/pricing_plan.png)
    
4.  Compila i seguenti parametri: <br/>
    -   Immetti un nome servizio.<br/>
    -   Specifica la regione/ubicazione dove vuoi eseguire la distribuzione. La regione/ubicazione sarà una delle sei principali regioni {{site.data.keyword.cloud_notm}} in cui vuoi distribuire l'istanza. L'ubicazione fisica effettiva dell'istanza è dettata dal parametro di ubicazione descritto nel seguente elenco.<br/>
    -   Seleziona un gruppo di risorse.</br>
    -   Aggiungi una tag. 
    -   Seleziona un'ubicazione per la distribuzione. Questa ubicazione è l'ubicazione fisica dell'istanza, che può essere qualsiasi ubicazione {{site.data.keyword.cloud_notm}}, incluse le principali regioni e le ubicazioni al di fuori delle principali regioni. Per ulteriori informazioni, vedi [Data center globali {{site.data.keyword.IBM}} ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/cloud/data-centers/){:new_window}.<br/>
    -   Seleziona `yes` o `no` per rispondere se è richiesto HIPAA.<br/> 
    
    HIPAA è valido solo per le ubicazioni degli Stati Uniti. {{site.data.keyword.IBM}} può eseguire il provisioning di un ambiente del piano Hardware dedicato per implementare i controlli HIPAA. Il provisioning di un ambiente può essere eseguito solo alla conferma di un BAA (Business Associate Agreement) stabilito con {{site.data.keyword.IBM_notm}}. Per ulteriori dettagli, vedi [Abilitazione dell'impostazione supportata HIPAA](https://cloud.ibm.com/docs/account/eu_hipaa_supported.html#enabling-the-hipaa-supported-setting) e i termini della descrizione del servizio. Il provisioning di un cluster per gestire i dati HIPAA può richiedere più tempo rispetto al periodo stimato di 5 giorni.
    {: note}

    ![Configura l'hardware dedicato](images/select_deployment_location.png)
        
5.  Fai clic sul pulsante `Crea` per avviare il processo di provisioning. <br/>

    La fatturazione è ripartita proporzionalmente tutti i giorni, quindi assicurati di voler eseguire il provisioning e
    il pagamento di un ambiente prima di fare clic sul pulsante **Crea**.
    {: note}

    ![Esegui il provisioning dell'hardware dedicato](images/create_button_provision.png)

    Durante il provisioning, nel tuo dashboard {{site.data.keyword.cloud_notm}}
    viene visualizzata una rotella che gira accanto all'istanza. Viene inviata una richiesta per eseguire il provisioning di un'istanza del piano Hardware dedicato su server
    bare metal. Il tempo di provisioning è asincrono e può richiedere fino a 5 giorni. 
    {: note}   

    ![Provisioning della versione alternativa dell'hardware dedicato](images/create_button_provision2.png)
    
## Provisioning di un'istanza del piano Standard su un ambiente Hardware dedicato
{: #provisioning-a-standard-plan-instance-on-a-dedicated-hardware-environment}

1.  Accedi al tuo account {{site.data.keyword.cloud_notm}}.<br/>
    Puoi trovare il dashboard {{site.data.keyword.cloud_notm}} all'indirizzo:
    [https://cloud.ibm.com/ ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://cloud.ibm.com/){: new_window}.
    Dopo l'autenticazione con i tuoi nome utente e password,
    ti viene presentato il dashboard {{site.data.keyword.cloud_notm}}. Fai clic sul pulsante `Crea risorsa`:<br/>
    ![{{site.data.keyword.cloud_notm}} - Dashboard](images/img0001.png)

2.  Fai clic su `Database` dal menu e su `Cloudant` dall'elenco dei servizi di database.<br/>
     ![{{site.data.keyword.cloud_notm}} {{site.data.keyword.cloudant_short_notm}} - Selezione del servizio](images/img0003.png)<br/>
    Viene visualizzata la pagina per la creazione di un servizio.<br/>  

3.  Fai clic su `Standard` dai piani dei prezzi. <br/>
    ![Piano dei prezzi Standard](images/standard_pricing_plan.png)
    
    Non puoi eseguire il provisioning di un'istanza del piano Lite in un ambiente Hardware dedicato.
    {: tip}
    
4.  Compila i seguenti parametri: <br/>
    -   Immetti un nome servizio.<br/>
    -   Specifica la regione/ubicazione dove vuoi eseguire la distribuzione. <br/>
    -   Seleziona un gruppo di risorse.</br>
    -   Aggiungi una tag. 
    -   Seleziona un metodo di autenticazione.</br>
    -   Seleziona un ambiente, che è dove verrà distribuita l'istanza del piano Standard. Eventuali istanze dell'ambiente Hardware dedicato distribuite nell'account verranno visualizzate nell'elenco a discesa, se disponibili.</br>
    ![Configura l'istanza standard](images/select_environment.png)
    
5.  Fai clic sul pulsante `Crea`.<br/>
    Dopo alcuni secondi, viene eseguito il provisioning dell'istanza sull'ambiente che hai selezionato.<br/>
    ![Esegui provisioning dell'istanza standard](images/create_button_provision_standard.png)
    
6.  Ottieni le tue credenziali del servizio e accedi al dashboard {{site.data.keyword.cloudant_short_notm}} come faresti per un'istanza {{site.data.keyword.cloudant_short_notm}} a più tenant. 
    
    Per ulteriori informazioni, vedi la sezione relativa alla [modalità di individuazione delle tue credenziali del servizio](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#locating-your-service-credentials){: new_window}. 
    
## Provisioning di un'istanza del piano Standard in un ambiente Hardware dedicato con la CLI {{site.data.keyword.cloud_notm}}
{: #provisioning-a-standard-plan-instance-on-a-dedicated-hardware-environment-with-the-ibm-cloud-cli}

Per utilizzare la CLI {{site.data.keyword.cloud_notm}}, devi aver eseguito l'accesso. Per ulteriori informazioni su come eseguire l'accesso e impostare un gruppo di risorse di destinazione, vedi [Accesso al tuo account {{site.data.keyword.cloud_notm}}](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli#logging-in-to-your-ibm-cloud-account){: new_window}. 

Per creare un'istanza del piano {{site.data.keyword.cloudant_short_notm}} Standard nel tuo ambiente del piano {{site.data.keyword.cloudant_short_notm}} Hardware dedicato, il formato del comando di base è il seguente:


Campo | Descrizione
------|------------
`NAME`| Un nome arbitrario da te assegnato all'istanza.
`SERVICE_NAME` | `cloudantnosqldb`
`PLAN_NAME` | Piano Standard
`LOCATION` |  L'ubicazione dove desideri eseguire la distribuzione, ad esempio us-south, us-east oppure eu-gb. 

Vedi il seguente comando di esempio: 

```sh
ibmcloud resource service-instance-create NAME SERVICE_NAME SERVICE_PLAN_NAME LOCATION [-p, --parameters @JSON_FILE | JSON_STRING ]
```
{: codeblock}

Le istanze {{site.data.keyword.cloudant_short_notm}} distribuite in ambienti Hardware dedicato prendono altri due parametri:

Parametro | Descrizione
----------|------------
`environment_crn` | Questo parametro deve essere impostato sul CRN dell'istanza del piano {{site.data.keyword.cloudant_short_notm}} Hardware dedicato. Puoi determinare qual è il CRN consultando il comando CLI di esempio nella scheda Gestisci dell'istanza del piano {{site.data.keyword.cloudant_short_notm}} Hardware dedicato nel dashboard {{site.data.keyword.cloud_notm}}. In alternativa, puoi determinare qual è il CRN utilizzando il comando `ibmcloud resource service-instance SERVICE_INSTANCE_NAME`. 
`legacyCredentials` | Un parametro facoltativo che assume come valore predefinito true e indica se l'istanza utilizza sia le credenziali legacy che quelle IAM oppure solo le credenziali IAM. Consulta la [guida IAM](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-) per ulteriori dettagli sulla scelta di un metodo di autenticazione.

Vedi il seguente comando di esempio: 

```sh
ibmcloud resource service-instance-create cloudant_on_ded_hardware_cli cloudantnosqldb standard us-south -p '{"environment_crn":"crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b43434444bb7e2abb0841ca25d28ee4c:301a3118-7678-4d99-b1b7-4d45cf5f7b29::","legacyCredentials":false}'
```
{: codeblock}

## Creazione delle credenziali per il tuo servizio {{site.data.keyword.cloudant_short_notm}}
{: #creating-the-credentials-for-your-ibm-cloudant-service}

Le applicazioni che devono accedere al tuo servizio {{site.data.keyword.cloudant_short_notm}}
devono disporre delle credenziali necessarie.

Le credenziali del servizio sono importanti. Se un utente o un'applicazione ha accesso alle credenziali, può effettivamente fare qualsiasi cosa voglia con l'istanza del servizio. Ad esempio potrebbe creare dati fasulli o eliminare informazioni importanti. Proteggi queste credenziali attentamente.
{: important}

Per ulteriori informazioni sui campi inclusi nelle credenziali del servizio, consulta la [guida IAM](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-).

Il formato del comando di base per creare le credenziali per un'istanza del servizio in
{{site.data.keyword.cloud_notm}} è il seguente:

```sh
ibmcloud resource service-key-create NAME ROLE_NAME --instance-name SERVICE_INSTANCE_NAME [-p '{"service-endpoints":"internal"}]
```
{: pre}

I campi sono descritti nella seguente tabella:

Campo | Descrizione
------|------------
`NAME` | Nome arbitrario da te assegnato alle credenziali del servizio. 
`ROLE_NAME` | Questo campo attualmente consente solo il ruolo Gestore.
`SERVICE_INSTANCE_NAME` | Il nome da te assegnato alla tua istanza {{site.data.keyword.cloudant_short_notm}}.
`service-endpoints` | Un parametro facoltativo per popolare il campo url nelle credenziali del servizio con un endpoint interno per connettersi al servizio mediante la rete interna {{site.data.keyword.cloud_notm}}. Ometti questo parametro per popolare l'url con un endpoint esterno pubblicamente accessibile. Si applica solo alle istanze del piano Standard distribuite in ambienti Hardware dedicato che supportano gli endpoint interni. Il comando genererà un errore 400 se l'ambiente non supporta gli endpoint interni. 

Se vuoi creare delle credenziali per l'istanza `cs20170517a` di un servizio
{{site.data.keyword.cloudant_short_notm}} (dove il nome per le credenziali è `creds_for_cs20170517a`),
crea queste credenziali utilizzando un comando simile al seguente esempio:

```sh
ibmcloud resource service-key-create creds_for_cs20170517a Manager --instance-name cs20170517a
```
{: codeblock}

Dopo aver ricevuto la richiesta per creare le credenziali per l'istanza del servizio,
{{site.data.keyword.cloud_notm}} risponde con un messaggio simile al seguente esempio:

```sh
Creating service key in resource group default of account John Does's Account as john.doe@email.com...
OK
Service key crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a was created.
                  
Name:          creds_for_cs20170517a
ID:            crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a
Created At:    Tue Sep 18 19:58:38 UTC 2018
State:         active
Credentials:
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

Se desideri creare delle credenziali per l'istanza `cs20170517a` di un servizio
{{site.data.keyword.cloudant_short_notm}} (dove il nome per le credenziali è `creds_for_cs20170517a`)
e vuoi popolare l'url con l'endpoint interno, crea queste credenziali utilizzando un comando simile al seguente esempio:

```sh
ibmcloud resource service-key-create creds_for_cs20170517a Manager --instance-name cs20170517a -p '{"service-endpoints":"internal"}'
```
{: codeblock}

Dopo aver ricevuto la richiesta per creare le credenziali per l'istanza del servizio,
{{site.data.keyword.cloud_notm}} risponde con un messaggio simile al seguente esempio:

```sh
Creating service key in resource group default of account John Does's Account as john.doe@email.com...
OK
Service key crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a was created.
                  
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

## Elenco delle credenziali per il tuo servizio {{site.data.keyword.cloudant_short_notm}}
{: #listing-the-service-credentials-for-your-ibm-cloudant-service}

Il formato del comando di base per richiamare le credenziali per un'istanza del servizio in
{{site.data.keyword.cloud_notm}} è il seguente:

```sh
ibmcloud resource service-key KEY_NAME
```
{: codeblock}

In questo esempio, vogliamo richiamare le credenziali per l'istanza `cs20170517a` di un servizio {{site.data.keyword.cloudant_short_notm}}
(dove il nome per le credenziali è `creds_for_cs20170517a`); richiami le credenziali utilizzando un comando simile al seguente esempio:

```sh
ibmcloud resource service-key creds_for_cs20170517b
```
{: codeblock}

Dopo aver ricevuto la richiesta per richiamare le credenziali per l'istanza del servizio,
{{site.data.keyword.cloud_notm}} risponde con un messaggio simile al seguente esempio (abbreviato):

```sh
Retrieving service key in resource group default of account John Does's Account as john.doe@email.com...
OK
Service key crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a was created.
                  
Name:          creds_for_cs20170517a
ID:            crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a
Created At:    Tue Sep 18 19:58:38 UTC 2018
State:         active
Credentials:
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
