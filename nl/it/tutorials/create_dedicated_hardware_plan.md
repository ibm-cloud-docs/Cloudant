---

copyright:
  years: 2015, 2018
lastupdated: "2017-11-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-02-23 -->

# Creazione e utilizzo di un'istanza del piano hardware dedicato {{site.data.keyword.cloudant_short_notm}} su {{site.data.keyword.Bluemix_notm}}

Questa esercitazione illustra come creare un'istanza del piano hardware dedicato {{site.data.keyword.cloudantfull}}
utilizzando il dashboard {{site.data.keyword.Bluemix}} e mostra come eseguire il provisioning successivo di una o
più istanze del piano Standard da eseguire su di esso. 

La creazione di un'istanza del piano hardware dedicato {{site.data.keyword.cloudant_short_notm}} comporta il provisioning
di un ambiente {{site.data.keyword.cloudant_short_notm}} sull'hardware dedicato unicamente per utilizzo personale. Un'istanza
del servizio viene creata nel dashboard {{site.data.keyword.Bluemix_notm}}, ma nota che non puoi
accedere direttamente all'istanza del piano hardware dedicato e non avrai
alcuna credenziale per tale servizio. Puoi utilizzare un'istanza del piano hardware dedicato {{site.data.keyword.cloudant_short_notm}}
dopo averlo creato eseguendo su di esso il provisioning di una o più istanze del piano
Standard.

## Creazione di un'istanza del piano hardware dedicato {{site.data.keyword.cloudant_short_notm}}

1.  Accedi al tuo account {{site.data.keyword.Bluemix_notm}}.<br/>
    Il dashboard {{site.data.keyword.Bluemix_notm}} può essere trovato all'indirizzo:
    [http://bluemix.net ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://bluemix.net){:new_window}.
    Dopo l'autenticazione con i tuoi nome utente e password,
    ti viene presentato il dashboard {{site.data.keyword.Bluemix_notm}}:<br/>
    ![{{site.data.keyword.Bluemix_notm}} dashboard](images/img0001.png)

2.  Fai clic sul link `Catalogo`:<br/>
    ![{{site.data.keyword.Bluemix_notm}} link catalogo](images/img0002.png)<br/>
    Viene visualizzato un elenco dei servizi disponibili in {{site.data.keyword.Bluemix_notm}}.

3.  Fai clic sulla voce `Data & Analytics` nell'intestazione `Servizi` :<br/>
    ![{{site.data.keyword.Bluemix_notm}} servizi Data & Analytics](images/img0003.png)<br/>
    Viene visualizzato un elenco dei servizi Data & Analytics
    disponibili in {{site.data.keyword.Bluemix_notm}}.

4.  Fai clic sul servizio {{site.data.keyword.cloudant_short_notm}}:<br/>
    ![{{site.data.keyword.Bluemix_notm}} Selezione servizio {{site.data.keyword.cloudant_short_notm}} ](images/img0004.png)<br/>
    Viene visualizzata la pagina per la creazione di un servizio. 

5.  Seleziona il piano hardware `Dedicated Hardware` dall'elenco di piani dei prezzi in fondo alla pagina:<br/>
    ![Piani dei prezzi](../tutorials/images/pricing_plan.png)
    
6.  Compila i seguenti parametri nella parte superiore della pagina: <br/>
    -   Immetti un nome di servizio.<br/>
    -   Specifica la regione e lo spazio per la distribuzione.<br/>
    -   Seleziona un'ubicazione per la distribuzione.<br/>
    -   Rispondi sì o no alla domanda se è necessario HIPAA. Nota che HIPAA è valido solo per le ubicazioni degli Stati Uniti.<br/> 
     
    **Nota**: la distribuzione e il provisioning delle istanze del piano Standard vengono eseguiti nella stessa regione e nello stesso spazio.    
    ![Configura l'hardware dedicato](../tutorials/images/select_deployment_location.png)<br/>
    Inizia il processo di provisioning. 
    
7.  Fai clic sul pulsante `Crea` per iniziare il provisioning dalla parte inferiore della pagina. <br/>
    **Nota**: la fatturazione è ripartita proporzionalmente tutti i giorni, quindi assicurati di voler eseguire il provisioning e
    il pagamento di un ambiente prima di fare clic sul pulsante **Crea**.<br/>
    ![Esegui il provisioning dell'hardware dedicato](../tutorials/images/create_button_provision.png)<br/>
    **Nota**: durante il provisioning, nel tuo dashboard {{site.data.keyword.Bluemix_notm}}
    viene visualizzata una rotella che gira accanto all'istanza. Viene inviata una richiesta per eseguire il provisioning di un'istanza del piano hardware dedicato su server
    bare metal. Il tempo di provisioning è asincrono e può richiedere fino a 5 giorni.
    ![Esegui il provisioning di una versione alternativa dell'hardware dedicato](../tutorials/images/create_button_provision2.png)<br/>
    
## Provisioning di un'istanza del piano Standard su un ambiente hardware dedicato

1.  Accedi al tuo account {{site.data.keyword.Bluemix_notm}}.<br/>
    Il dashboard {{site.data.keyword.Bluemix_notm}} può essere trovato all'indirizzo:
    [http://bluemix.net ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://bluemix.net){:new_window}.
    Dopo l'autenticazione con i tuoi nome utente e password,
    ti viene presentato il dashboard {{site.data.keyword.Bluemix_notm}}:<br/>
    ![{{site.data.keyword.Bluemix_notm}} dashboard](images/img0001.png)

2.  Fai clic sul link `Catalogo`:<br/>
    ![{{site.data.keyword.Bluemix_notm}} link catalogo](images/img0002.png)<br/>
    Viene visualizzato un elenco dei servizi disponibili in {{site.data.keyword.Bluemix_notm}}.

3.  Fai clic sulla voce `Data & Analytics` nell'intestazione `Servizi` :<br/>
    ![{{site.data.keyword.Bluemix_notm}} servizi Data & Analytics](images/img0003.png)<br/>
    Viene visualizzato un elenco dei servizi Data & Analytics
    disponibili in {{site.data.keyword.Bluemix_notm}}.

4.  Fai clic sul servizio {{site.data.keyword.cloudant_short_notm}}:<br>
    ![{{site.data.keyword.Bluemix_notm}} Selezione servizio {{site.data.keyword.cloudant_short_notm}} ](images/img0004.png)<br/>
    Viene visualizzata la pagina per la creazione di un servizio.  

5.  Fai clic su `Standard` dai piani dei prezzi nella parte inferiore della pagina. <br/>
    **Nota**: non puoi eseguire il provisioning di un'istanza del piano Lite su un ambiente hardware dedicato.<br/>
    ![Piano dei prezzi Standard](../tutorials/images/standard_pricing_plan.png)
    
6.  Compila i parametri nella parte superiore della pagina immettendo un nome di servizio, un nome di credenziale e così via,
    come faresti per un'istanza del piano Standard. Decidi se eseguire il provisioning sull'ambiente a più tenant regionale
    predefinito o sull'ambiente hardware dedicato che hai fornito utilizzando il menu a discesa `Seleziona ambiente`.<br/>
    ![Configura l'istanza standard](../tutorials/images/select_environment.png)
    
7.  Fai clic sul pulsante `Crea` nella parte inferiore della pagina.<br/>
    Dopo alcuni secondi, viene eseguito il provisioning dell'istanza sull'ambiente che hai selezionato.<br/>
    ![Esegui provisioning dell'istanza standard](../tutorials/images/create_button_provision_standard.png)
    
8.  Ottieni le tue credenziali del servizio e accedi al dashboard {{site.data.keyword.cloudant_short_notm}} come faresti per un'istanza {{site.data.keyword.cloudant_short_notm}} a più tenant.
    Ulteriori informazioni su come individuare le tue credenziali del servizio sono disponibili [qui ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://console.bluemix.net/docs/services/Cloudant/tutorials/create_service.html#locating-your-service-credentials){:new_window}. 
     
