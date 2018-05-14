---

copyright:
  years: 2015, 2018
lastupdated: "2017-11-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-02-23 -->

# {{site.data.keyword.Bluemix_notm}} dedicato

{{site.data.keyword.cloudantfull}} per (Bluemix dedicato) è
un componente aggiuntivo facoltativo acquistabile per un ambiente Bluemix dedicato. Il componente aggiuntivo facoltativo per
{{site.data.keyword.cloudant_short_notm}} dedicato in Bluemix dedicato è valutato in base alla capacità dell'hardware
assegnata all'ambiente e può essere acquistato contattando il tuo responsabile delle vendite {{site.data.keyword.IBM}}.  

I clienti di Bluemix dedicato possono anche scegliere di utilizzare {{site.data.keyword.cloudant_short_notm}} in Bluemix pubblico
attraverso il catalogo diffuso, incluse le istanze del piano Lite e Standard. Nota che
gli utenti di Bluemix dedicato non possono acquistare il piano hardware dedicato dal
catalogo Bluemix pubblico e devono utilizzare {{site.data.keyword.cloudant_short_notm}} dedicato su
Bluemix dedicato nel caso in cui sia richiesto l'hardware dedicato.   

La seguente schermata mostra un esempio di catalogo {{site.data.keyword.Bluemix_notm}} che evidenzia la versione diffusa da {{site.data.keyword.Bluemix_notm}} pubblico
di {{site.data.keyword.cloudant_short_notm}} (a sinistra) e l'ambiente di {{site.data.keyword.cloudant_short_notm}} dedicato (a destra).  

![{{site.data.keyword.cloudant_short_notm}} - Catalogo](../images/bluemix_catalog.png)

## Capacità hardware 

{{site.data.keyword.cloudant_short_notm}} all'interno di {{site.data.keyword.Bluemix_notm}} dedicato viene acquistato tramite una parte di 'capacità di 1,6 TB per {{site.data.keyword.cloudant_short_notm}}
in {{site.data.keyword.Bluemix_notm}} dedicato', che include un ambiente cluster {{site.data.keyword.cloudant_short_notm}}
costituito da tre nodi di database e due programmi di bilanciamento del carico. Ogni nodo di database
contiene 1,6 TB su SSD e, poiché tutti i dati sono memorizzati in triplice copia, questo
equivale a 1,6 TB di spazio disco unico nel cluster. L'espansione di un ambiente
può essere ottenuta acquistando parti aggiuntive di 'capacità di 1,6 TB per {{site.data.keyword.cloudant_short_notm}}
in {{site.data.keyword.Bluemix_notm}} dedicato', che possono essere utilizzate per espandere il
cluster {{site.data.keyword.cloudant_short_notm}} in multipli di tre nodi di database. I clienti possono anche
scegliere di avere più ambienti {{site.data.keyword.cloudant_short_notm}} separati piuttosto che
espandere un singolo ambiente.

## Ubicazioni e locazione 

L'ambiente {{site.data.keyword.cloudant_short_notm}} dedicato all'interno di un ambiente {{site.data.keyword.Bluemix_notm}} dedicato si trova sull'hardware
designato per l'uso esclusivo da parte dei clienti di {{site.data.keyword.Bluemix_notm}} dedicato. Il cliente può eseguire il provisioning
di una o più istanze di {{site.data.keyword.cloudant_short_notm}} in un dato ambiente e ogni istanza di {{site.data.keyword.cloudant_short_notm}}
condivide le risorse hardware sottostanti che costituiscono l'ambiente {{site.data.keyword.cloudant_short_notm}}. 

## Sicurezza, crittografia e conformità 

Tutti i piani vengono forniti sui server con la crittografia del disco [inattiva
![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://en.wikipedia.org/wiki/Data_at_rest). L'accesso avviene tramite la connessione alla rete pubblica e crittografato
mediante HTTPS. Per ulteriori dettagli, vedi [Sicurezza ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://console.bluemix.net/docs/services/Cloudant/offerings/security.html#security){:new_window}.
La whitelist IP è disponibile su richiesta al supporto {{site.data.keyword.cloudant_short_notm}} e si applicherà
all'intero ambiente {{site.data.keyword.cloudant_short_notm}} e non al livello di istanza. 

Il piano offre anche la [Certificazione di conformità![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://console.bluemix.net/docs/services/Cloudant/offerings/compliance.html#cloudant-security-compliance){:new_window}.
La conformità [HIPAA ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){:new_window}
è disponibile su richiesta, quindi richiedila durante il processo di acquisto con un rappresentante delle vendite {{site.data.keyword.IBM_notm}}. 

## Alta disponibilità, ripristino di emergenza e backup 

Per fornire alta disponibilità (HA) e ripristino di emergenza (DR) all'interno di un data center, tutti i dati vengono archiviati in triplice copia
in tre server fisici separati in un cluster. Quando disponibili, puoi eseguire il provisioning degli account in più ubicazioni,
quindi utilizzare la replica continua dei dati per fornire HA/DR ai vari data center. Il backup dei dati {{site.data.keyword.cloudant_short_notm}} non viene eseguito
automaticamente, ma vengono forniti strumenti supportati per gestire i backup. Consulta la guida
[Ripristino di emergenza e backup ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://console.bluemix.net/docs/services/Cloudant/guides/disaster-recovery-and-backup.html#disaster-recovery-and-backup){:new_window}
per esplorare tutte le considerazioni su HA, DR e backup per soddisfare i requisiti dell'applicazione.
