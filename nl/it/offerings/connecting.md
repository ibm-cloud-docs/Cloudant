---

copyright:
  years: 2019
lastupdated: "2019-03-18"

keywords: endpoints, service credentials, authentication, ibm cloudant dashboard, curl, client libraries

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

# Connessione
{: #connecting}

Si accede a {{site.data.keyword.cloudantfull}} tramite un'API HTTP. Questo documento descrive le diverse parti che utilizzi per connetterti a {{site.data.keyword.cloudant_short_notm}}:
- Endpoint
- Credenziali del servizio
- Autenticazione
- Accesso al dashboard {{site.data.keyword.cloudant_short_notm}}
- Accesso programmatico a {{site.data.keyword.cloudant_short_notm}} tramite [curl ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://curl.haxx.se/){: new_window} o librerie client
{: shortdesc}

## Endpoint
{: #endpoints}

Si accede a {{site.data.keyword.cloudant_short_notm}} tramite gli endpoint dell'API HTTP. Gli endpoint relativi a un'istanza vengono
mostrati sia nel campo URL delle credenziali del servizio generate per l'istanza che nella scheda **Account** > **Impostazioni**
del dashboard {{site.data.keyword.cloudant_short_notm}}.

Tutti gli endpoint HTTP {{site.data.keyword.cloudant_short_notm}} devono essere accessibili su TLS, quindi devono essere preceduti da `https://`.

L'endpoint esterno esposto pubblicamente è:

`https://USERNAME.cloudant.com`

Tutte le istanze fornite dopo il 1° gennaio 2019 includono un endpoint di dominio appdomain.cloud. L'endpoint esterno esposto pubblicamente è:

`https://USERNAME.cloudantnosqldb.appdomain.cloud`

Gli endpoint interni vengono aggiunti a tutte le istanze distribuite negli ambienti Hardware dedicato forniti dopo il 1° gennaio 2010
fuori da un ambiente gestito dall'UE. L'endpoint di rete interno {{site.data.keyword.cloud_notm}} è: 

`https://USERNAME.private.cloudantnosqldb.appdomain.cloud`

Dove USERNAME è il nome dell'utente dell'istanza del servizio nell'URL. Questo campo funge anche da nome dell'utente amministratore
quando utilizzi l'autenticazione legacy {{site.data.keyword.cloudant_short_notm}}. Un esempio di USERNAME è
de810d0e-763f-46a6-ae88-50823dc85581-bluemix e l'endpoint esterno di esempio risultante sarebbe
de810d0e-763f-46a6-ae88-50823dc85581-bluemix.cloudantnosqldb.appdomain.cloud. 

## Credenziali del servizio
{: #service-credentials}

Per generare le credenziali del servizio per {{site.data.keyword.cloudant_short_notm}} tramite il dashboard {{site.data.keyword.cloud_notm}},
vedi l'esercitazione [Creazione di un'istanza {{site.data.keyword.cloudant_short_notm}} su {{site.data.keyword.cloud_notm}}](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-an-ibm-cloudant-instance-on-ibm-cloud). Per generare le credenziali del servizio
dalla CLI {{site.data.keyword.cloud_notm}}, vedi [Creazione delle credenziali per il tuo servizio
{{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli#creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli). 

Di seguito vengono riportate credenziali del servizio di esempio per un'istanza {{site.data.keyword.cloudant_short_notm}}:

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

Le credenziali del servizio includono i seguenti campi:

Campo | Scopo
------|--------
`username` | Il nome servizio dell'utente dell'istanza del servizio nell'URL. Questo campo funge anche da nome dell'utente amministratore. 
`password` | La password delle credenziali legacy obbligatoria alle applicazioni per accedere all'istanza del servizio. Questo campo viene visualizzato solo se viene scelta l'opzione `Use both legacy credentials and IAM`. 
`host` | Il nome host utilizzato dalle applicazioni per individuare l'istanza del servizio. Questo campo viene visualizzato solo se viene scelta l'opzione `Use both legacy credentials and IAM`. 
`port` | Il numero di porta HTTPS per l'accesso all'istanza del servizio sull'host. È 443 poiché solo l'accesso HTTPS è consentito da {{site.data.keyword.cloudant_short_notm}}. Questo campo viene visualizzato solo se viene scelta l'opzione `Use both legacy credentials and IAM`. 
`url`	| L'URL HTTPS per accedere all'istanza {{site.data.keyword.cloudant_short_notm}}. Se viene scelta l'opzione `Use both legacy credentials and IAM`. include anche il nome utente e la password legacy incorporati. 
`apikey` | La chiave API IAM. 
`iam_apikey_description` | La descrizione della chiave API IAM. 
`iam_apikey_name` | L'ID della chiave API IAM.
`iam_role_crn` | Il ruolo IAM che ha la chiave API IAM.
`iam_serviceid_crn`	| Il CRN dell'ID servizio.

## Autenticazione
{: #authentication-overview}

Al momento del provisioning, {{site.data.keyword.cloudant_short_notm}} ha a disposizione due metodi di autenticazione, `Use only IAM` oppure `Use both legacy credentials and IAM`. Puoi vedere i dettagli relativi alle tue credenziali legacy nelle
credenziali del servizio solo se è stato scelto il metodo di autenticazione `Use both legacy credentials and IAM`. Le credenziali vengono visualizzate nella scheda Credenziali del servizio per la tua istanza. Per ulteriori informazioni, consulta la [guida IAM](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-) e il documento [autenticazione legacy](/docs/services/Cloudant?topic=cloudant-authentication#authentication) per i dettagli sull'utilizzo dell'uno o dell'altro stile di autenticazione.
 
Il team {{site.data.keyword.cloudant_short_notm}} ti consiglia di utilizzare i controlli di accesso IAM per l'autenticazione quando possibile. Se stai utilizzando l'autenticazione legacy {{site.data.keyword.cloudant_short_notm}}, ti consigliamo di utilizzare le [chiavi API](/docs/services/Cloudant?topic=cloudant-authorization#api-keys){: new_window} invece delle credenziali a livello di account per l'accesso programmatico e i lavori di replica.
{: important}

## Dashboard {{site.data.keyword.cloudant_short_notm}}
{: #ibm-cloudant-dashboard}

Puoi aprire il dashboard {{site.data.keyword.cloudant_short_notm}} per la tua istanza andando alla scheda Manage della pagina dei
dettagli dell'istanza del dashboard {{site.data.keyword.cloud_notm}}. Puoi utilizzare il pulsante `Launch` o `Launch Cloudant Dashboard`
per aprire il dashboard in una nuova scheda del browser. Il dashboard {{site.data.keyword.cloudant_short_notm}} ti consente di eseguire le attività riportate di seguito: 

- Monitorare il tuo consumo corrente dell'istanza
- Eseguire CRUD (creazione, lettura, aggiornamento ed eliminazione) su indici, documenti e database {{site.data.keyword.cloudant_short_notm}}
- Configurare e visualizzare i lavori di replica
- Visualizzare le attività attive
- Visualizzare e aggiornare le informazioni sull'account come la capacità produttiva fornita, gli annunci, CORS e le impostazioni

## Accesso programmatico
{: #programmatic-access}

### Riga di comando (curl)
{: #command-line-curl-}

Puoi utilizzare il programma di utilità della riga di comando curl per accedere all'API HTTP {{site.data.keyword.cloudant_short_notm}}. 

Se utilizzi l'autenticazione legacy {{site.data.keyword.cloudant_short_notm}}, vedi la
[panoramica di riferimento API](/docs/services/Cloudant?topic=cloudant-api-reference-overview#api-reference-overview) per
dettagli sulla fornitura di un nome utente e di una password per accedere all'API {{site.data.keyword.cloudant_short_notm}} con curl
come mostrato negli esempi di riferimento API. 

Se utilizzi l'autenticazione IAM {{site.data.keyword.cloud_notm}}, devi innanzitutto ottenere un token IAM {{site.data.keyword.cloud_notm}} utilizzando una chiave API. Quindi, devi passare il token IAM all'istanza {{site.data.keyword.cloudant_short_notm}} per l'autenticazione. Vedi l'esercitazione [Passaggio di
un token IAM {{site.data.keyword.cloud_notm}} per l'autenticazione con un'API del servizio](https://cloud.ibm.com/docs/services/iam?topic=iam-iamapikeysforservices#token_auth){: new_window}. 

Non puoi utilizzare direttamente una chiave API IAM per eseguire l'autenticazione in {{site.data.keyword.cloudant_short_notm}}.
{: note}

### Librerie client
{: #client-libraries-overview}

{{site.data.keyword.cloudant_short_notm}} dispone di librerie client ufficiali per Java, Node.js, Python, Swift e Mobile. Per ulteriori informazioni,
vedi la [documentazione sulle librerie client](/docs/services/Cloudant?topic=cloudant-client-libraries#client-libraries) per accedere alle
librerie e vedi gli esempi per la connessione a un'istanza {{site.data.keyword.cloudant_short_notm}} da ciascuna di esse.  
