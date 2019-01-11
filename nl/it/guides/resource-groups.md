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

# Come funziona {{site.data.keyword.cloudant_short_notm}} con i gruppi di risorse {{site.data.keyword.cloud_notm}}?

A partire dal 16 luglio 2018, il provisioning delle nuove istanze risorsa {{site.data.keyword.cloudantfull}} è stato eseguito nei gruppi di risorsa invece che negli spazi Cloud Foundry. Questo documento copre le domande comuni ricevute dal supporto {{site.data.keyword.cloudant_short_notm}} su questa transizione.

## Come migro un'istanza esistente a un gruppo di risorse?

Per migrare un'istanza {{site.data.keyword.cloudant_short_notm}} da uno spazio Cloud Foundry a un gruppo di risorse, vedi [Migrazione di applicazioni e istanze del servizio Cloud Foundry a un gruppo di risorse](https://console.bluemix.net/docs/resources/instance_migration.html#migrate){:new_window}.

Puoi migrare le istanze {{site.data.keyword.cloudant_short_notm}} nei seguenti piani:

- Lite
- Standard
- Hardware dedicato

## Quanto tempo di inattività si verifica quando migri un'istanza a un gruppo di risorse?

Non c'è alcun tempo di inattività durante il processo di migrazione.

## Perché alcune istanze hanno un'organizzazione e uno spazio e altre no?

A partire dal 16 luglio 2018, il provisioning delle nuove istanze è stato eseguito nei gruppi di risorsa invece che negli spazi Cloud Foundry. Le istanze risorsa di cui era stato eseguito il provisioning prima di questa data hanno un'organizzazione e uno spazio Cloud Foundry associati. Le istanze di cui viene eseguito il provisioning dopo questa data saranno invece associate a un gruppo di risorse.

## Perché non posso creare nuove istanze del piano Standard sulle mie istanze Hardware dedicato?

Delle nuove istanze del piano Standard viene eseguito il provisioning in gruppi di risorse. Per eseguire il provisioning di queste istanze in un'istanza Hardware dedicato, quest'ultima deve prima essere migrata in un gruppo di risorse.

Per ulteriori informazioni su come effettuare questa operazione, consulta [Migrazione di applicazioni e istanze del servizio Cloud Foundry a un gruppo di risorse](https://console.bluemix.net/docs/resources/instance_migration.html#migrate){:new_window}.

Dopo essere stata migrata a un gruppo di risorse, l'istanza Hardware dedicato è visualizzata nel menu a discesa Ubicazione quando si esegue il provisioning di piani Standard.

## Come devo eseguire la migrazione delle mie istanze Hardware dedicato e delle istanze del piano Standard su di esse ospitate?

In teoria, le istanze possono essere migrate ai gruppi di risorse in qualsiasi ordine. In pratica, consigliamo di rispettare il seguente ordine per le istanze Hardware dedicato e le istanze del piano Standard su di esse ospitate:

1. Migra le istanze Hardware dedicato a un gruppo di risorse. Ciò consente la creazione di nuove istanze del piano Standard sull'Hardware dedicato.
2. Migra le istanze Standard.

Le istanze del piano Lite e le istanze del piano Standard non ospitate su Hardware dedicato possono essere migrate in qualsiasi momento.
{: tip}
