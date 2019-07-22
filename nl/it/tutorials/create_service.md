---

copyright:
  years: 2017, 2019
lastupdated: "2019-06-12"

keywords: create service instance, service credentials, locate service credentials

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

<!-- Acrolinx: 2018-09-19 -->

# Creazione di un'istanza {{site.data.keyword.cloudant_short_notm}} su {{site.data.keyword.cloud_notm}}
{: #creating-an-ibm-cloudant-instance-on-ibm-cloud}

Questa esercitazione mostra come creare un'istanza del servizio {{site.data.keyword.cloudantfull}}
utilizzando il dashboard {{site.data.keyword.cloud}}
e ti mostra dove trovare le informazioni essenziali per abilitare le tue applicazioni
ad utilizzare il database.
{: shortdesc} 

## Creazione di un'istanza del servizio
{: #creating-a-service-instance}

1.  Accedi al tuo account {{site.data.keyword.cloud_notm}}.<br/>
    Puoi trovare il dashboard {{site.data.keyword.cloud_notm}} all'indirizzo:
    [https://cloud.ibm.com/ ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://cloud.ibm.com/){: new_window}.
    Dopo l'autenticazione con i tuoi nome utente e password,
    ti viene presentato il dashboard {{site.data.keyword.cloud_notm}}. Fai clic sul pulsante `Crea risorsa`. <br/>
    ![{{site.data.keyword.cloud_notm}} - Dashboard](images/img0001.png)

2.  Fai clic su `Database` dal menu e su `Cloudant` dall'elenco dei servizi di database:<br/>
    ![{{site.data.keyword.cloud_notm}} - Servizi di database](images/img0003.png)<br/>

3.  Nella finestra di configurazione del servizio,
    immetti un nome del servizio. Verifica che il nome servizio, la regione/ubicazione, il gruppo di risorse e i metodi di autenticazione siano corretti. Aggiungi una tag se lo desideri. I metodi di autenticazione disponibili includono `Use only IAM` o `Use both legacy credentials and IAM`. Per ulteriori informazioni, vedi [metodi di autenticazione](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-){: new_window}. 
    In questo esempio, il nome del servizio è `Cloudant-o7`:<br/>
    ![{{site.data.keyword.cloudant_short_notm}} - Nome e credenziali del servizio](images/img0005.png)
    
Il team {{site.data.keyword.cloudant_short_notm}} ti consiglia di utilizzare i controlli di accesso IAM nell'autenticazione legacy {{site.data.keyword.cloudant_short_notm}} quando possibile.
{: important}

4.  Per impostazione predefinita, il servizio viene creato utilizzando il piano dei prezzi 'Lite', che è gratuito ma che viene fornito con il provisioning di una quantità fissa di archiviazione di dati e di capacità produttiva. Se hai un account {{site.data.keyword.cloud_notm}} a pagamento, puoi anche scegliere il piano 'Standard' a pagamento in modo da poter commutare la capacità produttiva fornita e ridimensionare l'utilizzo dei dati come necessario. Per ulteriori informazioni sui piani dei prezzi, vedi [Piani](/docs/services/Cloudant?topic=cloudant-ibm-cloud-public#plans){: new_window}. Per creare il servizio, fai clic sul pulsante `Crea`: <br/>
    ![Crea il nome e le credenziali del servizio {{site.data.keyword.cloudant_short_notm}}](images/img0006.png)

5.  Viene visualizzata una pagina del servizio,
    che conferma che il tuo nuovo servizio {{site.data.keyword.cloudant_short_notm}} è disponibile.
    Per creare le informazioni di connessione di cui ha bisogno la tua applicazione per connettersi al servizio,
    fai clic sulla scheda `Credenziali del servizio`:<br/>
    ![Creazione delle credenziali del servizio {{site.data.keyword.cloudant_short_notm}} ](images/img0007.png)

6.  Crea una nuova credenziale del servizio {{site.data.keyword.cloudant_short_notm}}:
  <br>a. Fai clic sul pulsante `Nuova credenziale`.
  <br>![Crea nuove credenziali del servizio](images/img0050.png)
  <br>b. Immetti un nome per la nuova credenziale nella finestra Aggiungi nuova credenziale. Vedi l'immagine.
  <br>c. Accetta il ruolo Gestore.
  <br>d. (Facoltativo) Crea un nuovo ID servizio o disponi che ne venga generato uno automaticamente per tuo conto. 
  <br>d. (Facoltativo) Aggiungi i parametri di configurazione incorporati. Nota: questo parametro attualmente non è utilizzato dalle credenziali del servizio {{site.data.keyword.cloudant_short_notm}} e ti invitiamo pertanto a ignorarlo. 
  <br>e. Fai clic sul pulsante `Aggiungi`. </br>
  <br>![Aggiungi una nuova credenziale del servizio](images/img0051.png)
  <br>La tua nuova credenziale viene visualizzata dopo la tabella.</br>
  <br>f. Fai clic su `Visualizza credenziali` sotto Azioni.
  <br>![Visualizza tutte le credenziali del servizio](images/img0052.png)

7.  Vengono visualizzati i dettagli per le credenziali del servizio:<br/>
    ![Le credenziali del servizio {{site.data.keyword.cloudant_short_notm}} ](images/img0009.png)

Le credenziali del servizio in questi esempi sono state definite quando è stato creato un servizio {{site.data.keyword.cloudant_short_notm}} dimostrativo su {{site.data.keyword.cloudant_short_notm}}. Le credenziali vengono riprodotte qui per mostrare come dovrebbero essere visualizzate nel dashboard. Tuttavia,
    il servizio dimostrativo {{site.data.keyword.cloudant_short_notm}} è stato rimosso,
    per cui queste credenziali non sono più valide;
    _devi_ fornire e utilizzare le tue proprie credenziali del servizio.
{: note}

## Le credenziali del servizio
{: #the-service-credentials}

Le credenziali del servizio sono importanti. Se un utente o un'applicazione ha accesso alle credenziali, può effettivamente fare qualsiasi cosa voglia con l'istanza del servizio. Ad esempio potrebbe creare dati fasulli o eliminare informazioni importanti. Proteggi queste credenziali attentamente.
    
Al momento del provisioning, {{site.data.keyword.cloudant_short_notm}} ha a disposizione due metodi di autenticazione, `Use only IAM` oppure `Use both legacy credentials and IAM`. Puoi vedere i dettagli relativi alle tue credenziali legacy solo se viene scelto il metodo `Use both legacy credentials and IAM`. Le credenziali vengono visualizzate nella scheda Credenziali del servizio per la tua istanza. Per ulteriori informazioni, consulta la [guida IAM](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-) e il documento [autenticazione legacy](/docs/services/Cloudant?topic=cloudant-authentication#authentication) per i dettagli sull'utilizzo dell'uno o dell'altro stile di autenticazione.

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

Per creare un'applicazione che possa accedere alla tua istanza del servizio,
hai bisogno di queste credenziali.

## Individuazione delle tue credenziali del servizio
{: #locating-your-service-credentials}

In qualsiasi momento,
puoi trovare le credenziali per un servizio associato al tuo account.

1.  Inizia accedendo a {{site.data.keyword.cloud_notm}}.
    Puoi trovare il dashboard {{site.data.keyword.cloud_notm}} all'indirizzo:
    [https://cloud.ibm.com/ ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://cloud.ibm.com/){: new_window}.
    Dopo l'autenticazione con i tuoi nome utente e password,
    ti viene presentato il dashboard {{site.data.keyword.cloud_notm}}:<br/>
    ![{{site.data.keyword.cloud_notm}} - Dashboard](images/img0001.png)

2.  In questo esempio,
    vogliamo trovare le credenziali del servizio per l'istanza del servizio {{site.data.keyword.cloudant_short_notm}}
    creata precedentemente in questa esercitazione,
    denominata `Cloudant-o7`. Fai clic sull'icona **Menu** > **Elenco risorse** e sulla riga corrispondente:<br/>
    ![Selezione del servizio {{site.data.keyword.cloudant_short_notm}} ](images/img0011.png)

3.  Per visualizzare le credenziali necessarie per accedere al servizio,
    fai clic su `Visualizza credenziali`:<br/>
    ![Visualizzazione delle credenziali del servizio {{site.data.keyword.cloudant_short_notm}} ](images/img0052.png)

4.  Vengono visualizzati i dettagli per le credenziali del servizio:<br/>
    ![Le credenziali del servizio {{site.data.keyword.cloudant_short_notm}} ](images/img0009.png)

Le credenziali del servizio in questi esempi sono state definite quando è stato creato un servizio {{site.data.keyword.cloudant_short_notm}} dimostrativo su {{site.data.keyword.cloudant_short_notm}}. Le credenziali vengono riprodotte qui per mostrare come dovrebbero essere visualizzate nel dashboard. Tuttavia,
    il servizio dimostrativo {{site.data.keyword.cloudant_short_notm}} è stato rimosso,
    per cui queste credenziali non sono più valide;
    _devi_ fornire e utilizzare le tue proprie credenziali del servizio.
{: note}

