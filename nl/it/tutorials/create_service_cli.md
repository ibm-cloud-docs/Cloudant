---

copyright:
  years: 2017, 2019
lastupdated: "2019-03-19"

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

# Creazione di un'istanza {{site.data.keyword.cloudant_short_notm}} su {{site.data.keyword.cloud_notm}} utilizzando la CLI {{site.data.keyword.cloud_notm}}
{: #creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli}

Questa esercitazione illustra come creare un'istanza del servizio {{site.data.keyword.cloudantfull}} su {{site.data.keyword.cloud}} utilizzando la CLI {{site.data.keyword.cloud_notm}}.
{: shortdesc}

## Prima di iniziare questa esercitazione 
{: #before-you-start-this-tutorial}

Per seguire questa esercitazione, devi prima installare gli strumenti per gli sviluppatori della CLI {{site.data.keyword.cloud_notm}}. Per ulteriori informazioni sull'installazione degli strumenti, consulta l'esercitazione [Introduzione alla CLI {{site.data.keyword.cloud_notm}} ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://cloud.ibm.com/docs/cli?topic=cloud-cli-ibmcloud-cli#overview){: new_window}.

## Identificazione dell'endpoint API {{site.data.keyword.cloud_notm}}
{: #identifying-the-ibm-cloud-api-endpoint}

Specifica l'endpoint API di destinazione per i tuoi comandi {{site.data.keyword.cloud_notm}}:

```sh
ibmcloud api https://api.ng.bluemix.net
```
{: codeblock}

Il risultato conferma che hai identificato correttamente l'endpoint.

```sh
Setting api endpoint to https://api.ng.bluemix.net...
OK

API endpoint:   https://api.ng.bluemix.net (API version: 2.54.0)
Not logged in. Use 'ibmcloud login' to log in.
```
{: pre}

## Accesso al tuo account {{site.data.keyword.cloud_notm}}
{: #logging-in-to-your-ibm-cloud-account}

Il seguente esempio descrive il processo di accesso. Se stai utilizzando un ID utente federato, è importante che passi a un passcode monouso (`ibmcloud login --sso`) o che utilizzi una chiave API (`ibmcloud --apikey key oppure @key_file`) per eseguire l'autenticazione. Per ulteriori informazioni su come eseguire l'accesso utilizzando la CLI, vedi [Comandi generali della CLI (ibmcloud)![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://cloud.ibm.com/docs/cli/reference/ibmcloud?topic=cloud-cli-ibmcloud_cli#ibmcloud_login){: new_window} sotto `ibmcloud login`. 

1.  Avvia il processo di accesso per il tuo
  account {{site.data.keyword.cloud_notm}} utilizzando il seguente comando:
  
  ```sh
  ibmcloud login
  ```
  {: codeblock}
  
  {{site.data.keyword.cloud_notm}} risponde ricordandoti dell'endpoint
  API attuale e chiede l'indirizzo email del tuo account:
  
  ```sh
  API endpoint: https://api.ng.bluemix.net
  
  Email>
  ```
  {: pre}

2.  Immetti l'indirizzo email del tuo account e immetti quindi la tua password:

  ```sh
  API endpoint: https://api.ng.bluemix.net
  
  Email> J.Doe@email.com
  
  Password>
  ```
  {: pre}
  
  {{site.data.keyword.cloud_notm}} convalida i tuoi dettagli e riepiloga le informazioni sulla tua sessione di accesso:

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

3.  Hai ora eseguito l'accesso al tuo account {{site.data.keyword.cloud_notm}}.

## Scelta del piano {{site.data.keyword.cloudant_short_notm}} per il tuo servizio
{: #choosing-the-ibm-cloudant-plan-for-your-service}

Vedi la sezione [Piani ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](/docs/services/Cloudant?topic=cloudant-ibm-cloud-public#plans){: new_window} della documentazione per i dettagli sull'utilizzo del piano {{site.data.keyword.cloudant_short_notm}} Lite o Standard.
{: pre}

## Creazione del servizio {{site.data.keyword.cloudant_short_notm}}
{: #creating-the-ibm-cloudant-service}

{{site.data.keyword.cloudant_short_notm}} utilizza i gruppi di risorse per il provisioning di nuove istanze invece delle organizzazioni e degli spazi Cloud Foundry. Le istanze {{site.data.keyword.cloudant_short_notm}} di cui è stato eseguito il provisioning in passato possono ancora essere distribuite nelle organizzazioni e negli spazi Cloud Foundry. Per ulteriori informazioni, consulta la guida [How does IBM Cloudant work with IBM Cloud Resource Groups? ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](/docs/services/Cloudant?topic=cloudant-how-does-ibm-cloudant-work-with-ibm-cloud-resource-groups-#how-does-ibm-cloudant-work-with-ibm-cloud-resource-groups-){: new_window}.

Innanzitutto, imposta il tuo gruppo di risorse e la tua regione di destinazione come mostrato in [Comandi generali della CLI (ibmcloud) ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://cloud.ibm.com/docs/cli/reference/ibmcloud?topic=cloud-cli-ibmcloud_cli#ibmcloud_target){: new_window} sotto `ibmcloud target` utilizzando il seguente formato:

```sh
ibmcloud target [-r REGION_NAME] [-g RESOURCE_GROUP]
```

Per un elenco di queste regioni, esegui questo comando:

```sh
ibmcloud regions
```

Per un elenco di gruppi di risorse, esegui questo comando: 

```sh
ibmcloud resource groups
```

Quindi, per creare un'istanza del servizio, il formato del comando di base in {{site.data.keyword.cloud_notm}} è il seguente:

```sh
ibmcloud resource service-instance-create NAME SERVICE_NAME|SERVICE_ID SERVICE_PLAN_NAME|SERVICE_PLAN_ID LOCATION [-p, --parameters @JSON_FILE | JSON_STRING ]
```
{: pre}

I campi sono descritti nella seguente tabella: 


Campo | Descrizione
------|------------
`NAME` | Nome arbitrario da te assegnato all'istanza. 
`SERVICE_NAME` | `cloudantnosqldb`
`PLAN_NAME` | Piano Lite o piano Standard.
`LOCATION` | L'ubicazione dove vuoi eseguire la distribuzione: Asia Pacifico Nord, Germania, Globale, Sydney, Regno Unito, Stati Uniti Est o Stati Uniti Sud. 
`legacyCredentials` | L'impostazione predefinita è true. Questo campo indica se l'istanza utilizza sia le credenziali legacy che quelle IAM oppure solo le credenziali IAM. 

Per ulteriori informazioni sulla scelta di un metodo di autenticazione, consulta la [guida IAM](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-){: new_window}. Il team {{site.data.keyword.cloudant_short_notm}} ti consiglia di utilizzare i controlli di accesso IAM nell'autenticazione legacy {{site.data.keyword.cloudant_short_notm}} quando possibile.
{: important}

In questo esempio, vogliamo creare un'istanza di un servizio {{site.data.keyword.cloudant_short_notm}} utilizzando il piano `Lite` (dove il nome istanza è `cs20170517a` nell'ubicazione Stati Uniti Sud e utilizza solo le credenziali IAM); crei questa istanza utilizzando un comando simile al seguente esempio:

```sh
ibmcloud resource service-instance-create cs20170517a cloudantnosqldb lite us-south -p '{"legacyCredentials": false}'
```
{: codeblock}

Dopo aver creato l'istanza del servizio, {{site.data.keyword.cloud_notm}}
risponde con un messaggio simile al seguente esempio:

```sh
Creating service instance cs20170517a in resource group default of account John Does's Account as j.doe@email.com...
OK
Service instance cs20170517a was created.
Name          Location   State    Type               Tags
cs20170517a   us-south   active   service_instance  
```
{: pre}

## Creazione delle credenziali per il tuo servizio {{site.data.keyword.cloudant_short_notm}}
{: #creating-credentials-for-your-ibm-cloudant-service}

Le applicazioni che devono accedere al tuo servizio {{site.data.keyword.cloudant_short_notm}}
devono disporre delle credenziali necessarie.

Le credenziali del servizio sono importanti. Se un utente o un'applicazione ha accesso alle credenziali, può effettivamente fare qualsiasi cosa voglia con l'istanza del servizio. Ad esempio potrebbe creare dati fasulli o eliminare informazioni importanti. Proteggi queste credenziali attentamente.
{: important}

Per ulteriori informazioni sui campi inclusi nelle credenziali del servizio, consulta la [guida IAM](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-){: new_window}.

Il formato del comando di base per creare le credenziali per un'istanza del servizio in
{{site.data.keyword.cloud_notm}} è il seguente:

```sh
ibmcloud resource service-key-create NAME ROLE_NAME --instance-name SERVICE_INSTANCE_NAME
```
{: pre}

I campi sono descritti nella seguente tabella:

Campo | Descrizione
------|------------
`NAME` | Nome arbitrario da te assegnato alle credenziali del servizio. 
`ROLE_NAME` | Questo campo attualmente consente solo il ruolo Gestore.
`SERVICE_INSTANCE_NAME` | Il nome da te assegnato alla tua istanza {{site.data.keyword.cloudant_short_notm}}. 

Se vuoi creare delle credenziali per l'istanza `cs20170517a` di un servizio
{{site.data.keyword.cloudant_short_notm}} (dove il nome per le credenziali è `creds_for_cs20170517a`), crei tali credenziali utilizzando un comando simile al seguente esempio:

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

## Richiamo delle credenziali del servizio per il tuo servizio {{site.data.keyword.cloudant_short_notm}}
{: #retrieving-the-service-credentials-for-your-ibm-cloudant-service}

Il formato del comando di base per richiamare le credenziali per un'istanza del servizio in
{{site.data.keyword.cloud_notm}} è il seguente:

```sh
ibmcloud resource service-key KEY_NAME
```
{: pre}

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

## Utilizzo della tua istanza del servizio {{site.data.keyword.cloudant_short_notm}}
{: #using-your-ibm-cloudant-service-instance}

Ora hai terminato con le seguenti attività:

1.  Creato un'istanza del servizio {{site.data.keyword.cloudant_short_notm}} in
  {{site.data.keyword.cloud_notm}}.
2.  Creato le credenziali per l'istanza del servizio {{site.data.keyword.cloudant_short_notm}}.
3.  Richiamato le credenziali dell'istanza del servizio, in modo che possano essere utilizzate dalla tua applicazione.

Per ulteriori informazioni, consulta l'esercitazione [Creazione e popolamento di un database {{site.data.keyword.cloudant_short_notm}} semplice su {{site.data.keyword.cloud_notm}}](/docs/services/Cloudant?topic=cloudant-creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud#context){: new_window} che ti mostra come utilizzare un'istanza del servizio {{site.data.keyword.cloudant_short_notm}} da un'applicazione Python utilizzando le credenziali legacy. Ricorda di sostituire le credenziali che hai creato in questa esercitazione.

## (Facoltativo) Riordino successivo
{: #-optional-tidying-up-afterward}

Il seguente breve elenco di comandi potrebbe essere utile per riordinare il tuo ambiente di sviluppo.

### Eliminazione delle credenziali del servizio
{: #deleting-service-credentials}

Per eliminare una serie di credenziali del servizio,
utilizza un comando come il seguente:

```sh
ibmcloud resource service-key-delete KEY_NAME
```
{: pre}

Ad esempio, per eliminare le credenziali denominate `creds_for_cs20170517a`, utilizza un comando come il seguente:

```sh
ibmcloud resource service-key-delete creds_for_cs20170517a
```
{: pre}

### Eliminazione di un'istanza del servizio
{: #deleting-a-service-instance}

Per eliminare un'istanza del servizio, utilizza un comando come il seguente:

```sh
ibmcloud resource service-instance-delete SERVICE_INSTANCE_NAME
```
{: pre}

Ad esempio, per eliminare l'istanza,
`cs20170517a` di un servizio
{{site.data.keyword.cloudant_short_notm}},
utilizza un comando come il seguente:

```sh
ibmcloud resource service-instance-delete cs20170517a
```
{: pre}

