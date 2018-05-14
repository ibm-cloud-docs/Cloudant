---

copyright:
  years: 2017
lastupdated: "2017-05-02"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-05-02 -->

# Backup dei dati utilizzando CouchBackup

La natura distribuita di  {{site.data.keyword.cloudant}} fornisce una forma inerente al backup dei dati.
CouchBackup è uno strumento della riga di comando che ti fornisce  un modo più potente e flessibile per eseguire il backup dei dati.
{:shortdesc}

## Panoramica

I vantaggi distribuiti di {{site.data.keyword.cloudant_short_notm}} si ottengono utilizzando i cluster.
In un cluster,
i dati all'interno di un database vengono memorizzati in più copie.
Le copie sono distribuite su almeno tre server fisici separati.
L'utilizzo di cluster per l'archiviazione dei dati conferisce a {{site.data.keyword.cloudant_short_notm}}
caratteristiche inerenti all'alta disponibilità (HA, High Availability) e al ripristino di emergenza (DR, Disaster Recovery).
L'utilizzo dei cluster consente a {{site.data.keyword.cloudant_short_notm}} di tollerare la perdita di un nodo
dall'interno di un cluster senza perdere i dati.

Tuttavia,
anche con queste caratteristiche HA e DR,
ci sono altri casi di utilizzo in cui potresti volere un backup avanzato dei dati.

<div id="activepassive"></div>

### Interruzione del data center e ripristino di emergenza

La [replica continua](../api/replication.html#continuous-replication) tra i cluster è una buona soluzione al problema che si verifica quando
un cluster {{site.data.keyword.cloudant_short_notm}} non è completamente disponibile.
La replica continua è un modello 'attivo-passivo'.
La parte 'attiva' del modello è la replica continua.
La parte "passiva" del modello riconosce che la replica non è normalmente destinata a rispondere alle richieste delle applicazioni.
Invece,
la replica viene utilizzata principalmente come clone del database originale.
Se necessario,
i dati possono essere accessibili dal clone.
In alternativa,
i dati nel clone possono essere ripristinati altrove utilizzando la [replica](../api/replication.html).

>	**Nota:** il ripristino di un database di grandi dimensioni mediante la replica da un clone potrebbe richiedere molto tempo.

### Alta disponibilità, failover automatico e bilanciamento del carico geografico

Un'alternativa all'approccio ['attivo-passivo'](#activepassive) è quella in cui configuri due data center per utilizzare un modello 'attivo-attivo'.

In questo modello,
tutte le modifiche apportate a un database nel cluster A vengono replicate in un database nel cluster B.
Allo stesso modo,
tutte le modifiche apportate al database nel cluster B vengono replicate al database nel cluster A.

>	**Nota:** questo modello può essere impostato utilizzando il dashboard {{site.data.keyword.cloudant_short_notm}}.
Non richiede alcuna azione da parte del supporto {{site.data.keyword.cloudant_short_notm}}.

Con questo modello in uso,
puoi progettare le tue applicazioni del database per eseguire il 'failover' su uno dei cluster nel caso in cui vengano soddisfatti alcuni criteri di disponibilità.
Puoi definire i criteri di disponibilità come parte della tua progettazione dell'applicazione.

Nella progettazione dell'applicazione puoi anche includere il 'bilanciamento del carico' geografico.
Ad esempio,
un'applicazione client utilizzata in un'area geografica dovrebbe normalmente aspettarsi delle prestazioni migliori
quando l'applicazione accede a dati memorizzati all'interno di un cluster in un'area geografica 'vicina'.
La progettazione dell'applicazione client per identificare il cluster "più vicino" e connettersi ad esso per le query del database,
aiuterà le prestazioni dell'applicazione.

Un'esercitazione che spiega come impostare un ambiente applicativo a più regioni è disponibile
[qui![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://www.ibm.com/developerworks/cloud/library/cl-multi-region-bluemix-apps-with-cloudant-and-dyn-trs/index.html){:new_window}.

### Modifica accidentale o intenzionale dei dati

{{site.data.keyword.cloudant_short_notm}} non fornisce un meccanismo per creare un'istantanea del database.
Se hai bisogno di questo tipo di funzionalità,
ad esempio per facilitare il roll-back a livello di documento a uno stato noto precedente,
puoi ottenere lo stesso effetto in uno dei due seguenti modi:

1.	Utilizzando la replica. Esegui questa operazione replicando il database. Assicurati di registrare l'ID sequenza finale. In una pianificazione da te determinata, replica il database in un nuovo database. Avvia la replica dall'ultimo ID sequenza registrato. Mantenendo gli ID di sequenza per le repliche, puoi produrre l'effetto di un meccanismo di rollup. Il risultato è simile alla creazione di regolari istantanee 'settimanali' dalle istantanee 'giornaliere'. Una limitazione di questo approccio è che vengono replicate anche le revisioni dei documenti eliminati o rimossi definitivamente nonché i conflitti non risolti.

2.	Eseguendo il dump del contenuto del database in un file. Esistono diversi strumenti che possono essere utilizzati per il dump del contenuto del database in un file. Il file di dump risultante può essere memorizzato in un dispositivo o servizio orientato ai blocchi più conveniente. Una limitazione di tale approccio è che normalmente esegue il dump solo delle revisioni del documento correnti. Questa limitazione significa che i conflitti non risolti non sono inclusi.

La creazione di un dump del database è un modo efficace per abilitare una varietà di soluzioni di backup.
Pertanto,
il resto della discussione si concentra su questo approccio.

<!--
https://developer.ibm.com/clouddataservices/2016/03/22/simple-couchdb-and-cloudant-backup/

A useful approach is to have couchbackup's snapshots placed on the Bluemix Object Storage service, as described here:

https://developer.ibm.com/recipes/tutorials/object-storage-cloudant-backup/
-->
