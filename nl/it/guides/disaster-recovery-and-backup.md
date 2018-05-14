---

copyright:
  years: 2017
lastupdated: "2017-07-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-05-10 -->

# Ripristino di emergenza e backup

I tuoi dati sono importanti e preziosi.
Vuoi proteggere i tuoi dati
per assicurarti che siano sicuri,
disponibili
e che mantengano l'integrità.
Cloudant fornisce diversi modi per proteggere i tuoi dati e contribuire a mantenere operative le tue applicazioni.
{:shortdesc}

Alcune di queste funzioni di protezione sono automatiche.
Per le altre forme di protezione,
Cloudant ti offre degli strumenti supportati che
ti consentono di creare le tue proprie funzionalità di alta disponibilità e di ripristino di emergenza.

Questo documento fornisce una panoramica delle funzionalità automatiche e degli strumenti supportati offerti da Cloudant.

## Tipi e livelli di protezione

Il tipo di protezione che potresti volere dipende dal problema che stai tentando di risolvere.

Ad esempio,
potresti desiderare di avere un alto livello di disponibilità dei dati in modo che tu possa ancora accedere ai tuoi dati
anche se una quantità limitata di hardware all'interno del sistema presenta un malfunzionamento.
Questo è un requisito di 'Alta disponibilità' (HA).
Ciò significa fornire la massima disponibilità continua dei dati possibile dopo un errore hardware.
Tecniche diverse di alta disponibilità tollerano diversi livelli di errore prima che le operazioni vengano influenzate.

In alternativa,
potresti desiderare di disporre di modi semplici e rapidi di backup e ripristino dei dati.
Ad esempio,
dopo un errore hardware grave o esteso,
vuoi essere in grado di rendere tutti i dati disponibili su un sistema alternativo
il più rapidamente possibile.
Questo è un requisito di 'Ripristino di emergenza' (DR).
Per emergenza qui si intende che un database non è più disponibile in una o più posizioni.
Ad esempio,
un'interruzione dell'alimentazione potrebbe causare un errore in tutti i sistemi in un cluster di database.
In alternativa,
un errore di rete su larga scala potrebbe significare che i sistemi in un cluster non possono essere contattati,
anche se continuano a funzionare correttamente.

Affrontare i requisiti HA o DR inizia spesso semplificando il problema in requisiti più generici.
Quando identifichi i tuoi requisiti,
puoi applicare gli strumenti e le funzioni che consentono di risolvere esigenze generiche.
Quando messi insieme,
gli strumenti e le funzioni possono quindi soddisfare i requisiti HA o DR.

>	**Nota**: strumenti e funzioni differenti forniscono diversi livelli di protezione.
	Le diverse funzioni potrebbero essere più o meno adatte per il tuo specifico requisito HA o DR.

Cloudant fornisce una serie di strumenti e funzioni che soddisfano i requisiti generali:

1.	Ridondanza dei dati all'interno di una singola regione, nota anche come [Ridondanza automatica dei dati in una regione](#in-region-automatic-data-redundancy).
2.	Ridondanza dei dati e failover in più regioni, nota anche come [Ridondanza in più regioni per il ripristino di emergenza](#cross-region-redundancy-for-disaster-recovery).
3.	Backup delle istantanee di un preciso momento per il ripristino temporizzato, utilizzando il 'tradizionale' [Backup e ripristino del database](#database-backup-and-recovery).

## Ridondanza automatica dei dati in una regione

All'interno di un singolo account Cloudant,
i dati vengono memorizzati in triplice copia utilizzando processi interni ed automatici.
Non devi fare nulla per abilitare questa replica interna dei dati.

La ridondanza dei dati in una regione abilita la protezione ad alta disponibilità.
Nello specifico,
la ridondanza dei dati in una regione fornisce protezione per i tuoi dati in caso di errori hardware all'interno della regione.
Quando si verifica un errore in un'unità hardware all'interno della regione,
non sarà più disponibile solo la copia dei tuoi dati memorizzata in tale unità.
Le applicazioni restano utilizzabili perché Cloudant instrada automaticamente le richieste alle copie dei tuoi dati
che sono ancora disponibili sulle altre unità hardware nella regione.
Nel frattempo,
il monitoraggio automatico dei sistemi rileva l'errore dell'unità hardware,
richiedendo l'azione e il successivo ripristino della ridondanza completa.

Gli account Cloudant si trovano all'interno di una singola regione.
Questa caratteristica significa che tutti i dati memorizzati all'interno del tuo account vengono memorizzati su server separati,
ognuno dei quali è ospitato all'interno di quella singola regione.

La ridondanza automatica dei dati in una regione è limitata a:

1.	Fornire protezione solo in una singola regione.
2.	Mantenere i dati correnti.

Per fornire protezione in più di una singola regione associata al tuo account,
utilizza [Ridondanza in più regioni per il ripristino di emergenza](#cross-region-redundancy-for-disaster-recovery).

Per fornire protezione per la 'cronologia' dei tuoi dati,
ad esempio per abilitare il controllo delle modifiche apportate ai dati dalle applicazioni,
utilizza le istantanee dei dati che vengono create dagli strumenti di [Backup e ripristino del database](#database-backup-and-recovery).

In sintesi,
la ridondanza dei dati in una regione abilita la funzionalità di alta disponibilità
fornendo la tolleranza agli errori che riguardano singoli sistemi all'interno della regione.

## Ridondanza in più regioni per il ripristino di emergenza

La funzione di replica di Cloudant ti aiuta a creare una funzionalità di ripristino di emergenza flessibile nelle tue applicazioni.
Il modo principale per abilitare il ripristino di emergenza è quello di utilizzare la replica Cloudant per creare ridondanza in più regioni.
Il risultato è che la tua applicazione è in grado di tollerare la situazione in cui una o più regioni non sono disponibili.

I passi di base per creare la ridondanza in più regioni sono:

1.  Crea gli account Cloudant in due o più regioni.
2.  Crea i database in ogni regione, come necessario.
3.  Per i database che devono essere memorizzati con la ridondanza in più regioni, imposta le repliche continue bidirezionali tra i database corrispondenti in ogni account.
4.  Progetta e implementa le tue applicazioni in modo che le richieste di dati vengano instradate a seconda che il tuo ambiente sia una configurazione Attivo-Passivo o Attivo-Attivo.
  È [disponibile](active-active.html) una guida dettagliata per questa impostazione.

Quando progetti le tue applicazioni per lavorare con i dati in più regioni,
tieni conto dei seguenti punti:

* Le applicazioni possono inviare richieste al database ospitato più vicino alla loro posizione fisica.
  Questo utilizzo di prossimità può ridurre la latenza della rete e migliorare i tempi di risposta.
  Questa configurazione è indicata come metodo 'Attivo-Attivo'.
  È caratterizzata dall'utilizzo simultaneo di più copie di dati.
  Le applicazioni che funzionano all'interno di una configurazione attivo-attivo devono avere
  una [strategia per la gestione dei conflitti](mvcc.html#distributed-databases-and-conflicts) per evitare problemi con più copie di dati.
* Le applicazioni possono richiedere dati da una singola regione per impostazione predefinita.
  Se la regione non è disponibile,
  l'applicazione può passare alla richiesta di dati da un'altra regione.
  Questa configurazione è indicata come metodo 'Attivo-Passivo'.
  È caratterizzata dall'uso attivo di una sola serie di dati alla volta.
* Un'applicazione potrebbe utilizzare una configurazione ibrida,
  in cui viene utilizzato un singolo account per tutte le richieste di scrittura di dati
  e altre posizioni sono utilizzate esclusivamente per le richieste di sola lettura.
  Questa configurazione è considerata Attivo-Attivo per le letture.
* In uno scenario di emergenza,
  la tua applicazione deve reinstradare le richieste di dati per accedere agli account
  ospitati nelle regioni che sono ancora in linea.
  Questo requisito indica che la tua applicazione deve essere in grado di rilevare la perdita di una regione
  e di reinstradare le richieste di dati.

In sintesi,
la ridondanza in più regioni è simile alla funzionalità di alta disponibilità
ma si applica agli errori che interessano un'intera regione.
Tuttavia,
la configurazione delle tue applicazioni per funzionare correttamente con le configurazioni di ridondanza in più regioni fornisce una vera funzionalità di ripristino di emergenza.
Il motivo è che le applicazioni possono continuare a funzionare anche se i dati in una regione non sono disponibili per un certo tempo.
La replica Cloudant aiuta a garantire la sincronizzazione dei dati tra le regioni.
Tuttavia,
le tue applicazioni devono essere in grado di eseguire il 'failover' sulle copie dei tuoi dati memorizzate nelle altre regioni.

## Backup e ripristino del database

[La ridondanza automatica dei dati in una regione](#in-region-automatic-data-redundancy) fornisce alle applicazioni l'accesso ad alta disponibilità ai dati.
[La ridondanza in più regioni per il ripristino di emergenza](#cross-region-redundancy-for-disaster-recovery) fornisce alle applicazioni dei mezzi di ripristino di emergenza.
Tuttavia,
entrambe queste funzionalità si concentrano sul mantenimento dell'accesso solo alla copia _corrente_ dei tuoi dati.

In pratica,
le persone e le applicazioni possono commettere errori e modificare i dati in modo non intenzionale.
Le applicazioni stesse possono implementare una certa protezione,
ma a volte passano delle modifiche non desiderate.
In questo caso,
è utile essere in grado di ripristinare i dati da un punto precedente nel tempo.
I backup del database supportano questo requisito.

Oltre a proteggere i tuoi dati con le funzioni di alta disponibilità e ripristino di emergenza,
valuta la possibilità di eseguire il dump dei tuoi dati del database in una posizione separata a intervalli
periodici e regolari.
Assicurati di controllare e verificare i backup per essere sicuro che siano completi e corretti.

Cloudant supporta strumenti che consentono il dump del contenuto JSON nei database a un file
e il successivo ripristino dei database da questi file.

In particolare,
gli strumenti supportati da Cloudant ti aiutano a:

*	Eseguire il backup di database completi in un file,
	adatto per un'ulteriore elaborazione e archiviazione esterna.
*	Ripristinare database completi da uno stato precedente contenuto nel tuo file di backup.

<strong style="color:red;">Avvertenza.</strong> Gli strumenti supportati da Cloudant hanno le seguenti limitazioni: 

*	Gli strumenti non eseguono il backup delle impostazioni `_security`.
*	Gli strumenti non eseguono il backup degli allegati.
*	I backup non sono esattamente delle istantanee di un "preciso momento".
	Il motivo è che i documenti nel database vengono recuperati in batch,
  ma altre applicazioni potrebbero eseguire l'aggiornamento dei documenti nello stesso momento.
	Pertanto,
  i dati nel database possono cambiare tra i tempi in cui vengono letti i primi e gli ultimi batch.
*	Viene eseguito il backup delle definizioni di indice contenute nei documenti di progettazione,
	ma quando i dati vengono ripristinati è necessario ricostruire gli indici.
	Questa ricostruzione potrebbe richiedere una notevole quantità di tempo,
	a seconda di quanti dati vengono ripristinati.

<div id="conclusion"></div>

## Passi successivi

Puoi sviluppare applicazioni che si basano sulle funzioni Cloudant di base e sugli strumenti supportati
per abilitare strategie di protezione dei dati più complesse.

Gli scenari di esempio includono:

*	Ripristino di singoli documenti da stati precedenti.
*	Memorizzazione di più stati del documento precedenti, per consentire ripristini da momenti del passato.
*	Migrazione di dati obsoleti nell'archiviazione più economica per una conservazione più conveniente.

Gli strumenti di backup sono costituiti da una libreria e un'applicazione della riga di comando node.js open source.
Sono disponibili [su NPM ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://www.npmjs.com/package/@cloudant/couchbackup){:new_window}.

Per idee ed esempi che illustrano come integrare gli strumenti nella tua strategia di protezione dei dati,
vedi la [guida al backup Cookbook](backup-cookbook.html).
