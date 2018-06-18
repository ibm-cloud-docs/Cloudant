---

copyright:
  years: 2017
lastupdated: "2017-11-02"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-05-22 -->

# Configurazione di {{site.data.keyword.cloudant_short_notm}} per il ripristino di emergenza in più regioni

La [guida al ripristino di emergenza di {{site.data.keyword.cloudant_short_notm}}](disaster-recovery-and-backup.html)
spiega che un modo per abilitare il ripristino di emergenza è quello di utilizzare la replica
{{site.data.keyword.cloudantfull}} per creare ridondanza in più regioni.

Puoi configurare la replica in {{site.data.keyword.cloudant_short_notm}} utilizzando una topologia 'attivo-attivo'
o 'attivo-passivo' tra i data center.

Il seguente diagramma mostra una configurazione tipica che
utilizza due account {{site.data.keyword.cloudant_short_notm}}
uno in ogni regioni:

![Esempio di architettura attivo-attivo](../images/active-active.png)

È utile ricordare che:

* All'interno di ogni data center,
  {{site.data.keyword.cloudant_short_notm}} offre già l'alta disponibilità
  memorizzando i dati in triplice copia su tre server.
* La replica si verifica a livello di database anziché a livello di account
  e deve essere configurata esplicitamente.
* {{site.data.keyword.cloudant_short_notm}} non fornisce alcuno SLA (Service Level Agreement)
  o certezze circa la latenza della replica.
* {{site.data.keyword.cloudant_short_notm}} non monitora le singole repliche.
  È consigliabile utilizzare la nostra strategia per individuare le repliche non riuscite e riavviarle.

## Prima di iniziare

> **Nota**: per una distribuzione attivo-attivo,
  è necessario adottare una strategia per la gestione dei conflitti.
  Pertanto, assicurati di capire come funzionino la [replica](../api/replication.html) e i
  [conflitti](mvcc.html#distributed-databases-and-conflicts)
  prima di considerare questa architettura.

Contatta il [supporto {{site.data.keyword.cloudant_short_notm}} ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](mailto:support@cloudant.com){:new_window}
se hai bisogno di aiuto su come modellare i dati per gestire efficacemente i conflitti.

## Panoramica

Nel seguente materiale
viene creata una replica bidirezionale.
Questa configurazione consente a due database di lavorare in una topologia attivo-attivo.

La configurazione presuppone che tu disponga di due account in regioni diverse:

* `myaccount-dc1.cloudant.com`
* `myaccount-dc2.cloudant.com`

Una volta attivati questi account,
la procedura di base è la seguente:

1. [Crea](#step-1-create-your-databases) una coppia di database peer negli account.
2. [Imposta](#step-2-create-an-api-key-for-your-replications) le chiavi API
  da utilizzare per le repliche tra questi database.
3. Concedi le autorizzazioni appropriate.
4. Imposta le repliche.
5. Verifica che le repliche funzionino come previsto.
6. Configura l'applicazione e l'infrastruttura per l'utilizzo attivo-attivo
  o attivo-passivo dei database.

## Passo 1: crea i tuoi database

[Crea i database](../api/database.html#create) tra cui vuoi eseguire la replica
all'interno di ciascun account.

In questo esempio,
viene creato un database chiamato `mydb`.

I nomi che vengono utilizzati per i database in questo esempio non sono importanti,
ma utilizzando lo stesso nome è più comprensibile.

```sh
curl https://myaccount-dc1.cloudant.com/mydb -XPUT -u myaccount-dc1
curl https://myaccount-dc2.cloudant.com/mydb -XPUT -u myaccount-dc2
```
{:codeblock}

## Passo 2: crea una chiave API per le tue repliche

È una buona idea utilizzare una [chiave API](../api/authorization.html#api-keys) per le repliche continue.
Il vantaggio è che se i dettagli del tuo account primario cambiano,
ad esempio dopo una reimpostazione della password,
le repliche possono continuare invariate.

Le chiavi API non sono correlate a un singolo account.
Questa caratteristica consente di creare una singola chiave API e di concedere
quindi autorizzazioni di database adeguate per entrambi gli account.

Ad esempio,
il seguente comando richiede una chiave API per l'account `myaccount-dc1`:

```sh
$ curl -XPOST https://myaccount-dc1.cloudant.com/_api/v2/api_keys -u myaccount-dc1
```
{:codeblock}

Una risposta positiva è simile al seguente esempio abbreviato:

```json
{
  "password": "YPN...Tfi",
  "ok": true,
  "key": "ble...igl"
}
```
{:codeblock}

> **Nota**: prendi attentamente nota della password.
  Non è possibile recuperare la password in seguito.

### Passo 3: concedi l'autorizzazione di accesso

[Concedi l'autorizzazione per la chiave API](../api/authorization.html#modifying-permissions)
per leggere e scrivere su entrambi i database.

Se vuoi replicare anche gli indici,
assegna le autorizzazioni di amministratore.

Utilizza il Dashboard {{site.data.keyword.cloudant_short_notm}}
o, in alternativa, consulta le informazioni sulle [autorizzazioni](../api/authorization.html)
per dettagli su come concedere le autorizzazioni in modo programmatico.

### Passo 4: imposta le repliche

Le repliche in {{site.data.keyword.cloudant_short_notm}} sono sempre unidirezionali:
da un database a un altro database.
Pertanto,
per replicare in entrambi i sensi tra due database,
sono richieste due repliche,
una per ogni direzione.

Viene generata una replica in ogni account
e utilizza la chiave API creata [in precedenza](#step-2-create-an-api-key-for-your-replications).

Per prima cosa,
crea una replica dal database `myaccount-dc1.cloudant.com/mydb` al
database `myaccount-dc2.cloudant.com/mydb`.

```sh
curl -XPOST 'https://myaccount-dc1.cloudant.com/_replicator'
	-u myaccount-dc1
	-H 'Content-type: application/json'
	-d '{ "_id": "mydb-myaccount-dc1-to-myaccount-dc2",
	"source": "https://ble...igl:YPN...Tfi@myaccount-dc1.cloudant.com/mydb",
	"target": "https://ble...igl:YPN...Tfi@myaccount-dc2.cloudant.com/mydb",
	"continuous": true
}'
```
{:codeblock}

Quindi,
crea una replica dal database `myaccount-dc2.cloudant.com/mydb` al
database `myaccount-dc1.cloudant.com/mydb`.

```sh
curl -XPOST 'https://myaccount-dc2.cloudant.com/_replicator'
	-u myaccount-dc2
	-H 'Content-type: application/json'
	-d '{ "_id": "mydb-myaccount-dc2-to-myaccount-dc1",
	"source": "https://ble...igl:YPN...Tfi@myaccount-dc2.cloudant.com/mydb",
	"target": "https://ble...igl:YPN...Tfi@myaccount-dc1.cloudant.com/mydb",
	"continuous": true
}'
```
{:codeblock}

> **Nota:** se questo passo non riesce perché il database `_replicator` non esiste,
  crea il database.

### Passo 5: verifica la tua replica

Verifica i processi di replica creando,
modificando ed
eliminando i documenti in entrambi i database.

Dopo ogni modifica in un database,
verifica che sia possibile vedere la modifica applicata anche nell'altro database.

### Passo 6: configura la tua applicazione

A questo punto,
i database sono impostati per rimanere sincronizzati tra di loro.

La decisione successiva è quella di scegliere se utilizzare i database in modo
[attivo-attivo](#active-active) o [attivo-passivo](#active-passive).

#### Attivo-attivo

In una configurazione attivo-attivo,
diverse istanze dell'applicazione possono scrivere in diversi
database.

Ad esempio,
l'applicazione 'A' può scrivere nel database `myaccount-dc1.cloudant.com/mydb`,
mentre l'applicazione 'B' può scrivere nel database `myaccount-dc2.cloudant.com/mydb`.

Questa configurazione offre diversi vantaggi:

- Il carico può essere distribuito su più account.
- Le applicazioni possono essere configurate per accedere a un account con minore
  latenza (non sempre il più vicino geograficamente).

Un'applicazione può essere impostata per comunicare con l'account
{{site.data.keyword.cloudant_short_notm}} "più vicino".
Per le applicazioni ospitate in DC1,
è opportuno impostarne l'URL {{site.data.keyword.cloudant_short_notm}}
su `"https://myaccount-dc1.cloudant.com/mydb"`.
Allo stesso modo,
per le applicazioni ospitate in DC2,
imposterai il loro URL {{site.data.keyword.cloudant_short_notm}} su `"https://myaccount-dc2.cloudant.com/mydb"`.

#### Attivo-passivo

In una configurazione attivo-passivo,
tutte le istanze di un'applicazione sono configurate per utilizzare un database primario.
Tuttavia,
l'applicazione può eseguire il failover sull'altro database di backup,
se le circostanze lo rendono necessario.
Il failover potrebbe essere implementato all'interno della logica dell'applicazione stessa,
utilizzando un programma di bilanciamento del carico
o mediante altri mezzi.

Un semplice test per stabilire se è necessario un failover potrebbe essere quello
di utilizzare l'endpoint del database principale come 'heartbeat'.
Ad esempio,
una semplice richiesta `GET` inviata all'endpoint del database principale normalmente restituisce i
[dettagli sul database](../api/database.html#getting-database-details).
Se non viene ricevuta alcuna risposta,
ciò potrebbe indicare che è necessario un failover.

#### Altre configurazioni

Potresti considerare altri approcci ibridi per la tua configurazione.

Ad esempio,
in una configurazione 'Write-Primary, Read-Replica',
tutte le scritture vanno in un database,
ma il carico di lettura viene diffuso tra le repliche.

### Passo 7: passi successivi

* Valuta la possibilità di monitorare le [repliche](../api/advanced_replication.html) tra i database.
  Utilizza i dati per determinare se la tua configurazione potrebbe essere ottimizzata ulteriormente.
*	Considera in che modo vengono distribuiti e aggiornati i documenti di progettazione e gli indici.
  Potrebbe essere un modo più efficiente per automatizzare queste attività.

## Failover tra le regioni {{site.data.keyword.cloudant_short_notm}}

Generalmente,
il processo di gestione di un failover tra regioni o data center viene gestito a livello superiore all'interno del tuo stack dell'applicazione,
ad esempio configurando le modifiche di failover al server delle applicazioni
o bilanciando il carico.

{{site.data.keyword.cloudant_short_notm}} non fornisce una funzione che ti permette
di gestire esplicitamente un failover o di reinstradare le richieste tra le regioni.
Questa restrizione è in parte per motivi tecnici
e in parte perché le condizioni in cui potrebbe accadere tendono ad essere specifiche dell'applicazione.
Ad esempio,
potresti voler forzare un failover in risposta a una metrica delle prestazioni personalizzata.

Tuttavia,
se stabilisci che hai bisogno della capacità di gestire i failover,
alcune opzioni possibili includono:

* Metti il tuo [proxy HTTP davanti a {{site.data.keyword.cloudant_short_notm}} ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/greenmangaming/cloudant-nginx){:new_window}.
  Configura l'applicazione per parlare con il proxy anziché con l'istanza {{site.data.keyword.cloudant_short_notm}}.
  Questa configurazione significa che l'attività di modifica delle istanze {{site.data.keyword.cloudant_short_notm}}
  utilizzate dalle applicazioni può essere gestita tramite una modifica alla configurazione proxy
  anziché una modifica alle impostazioni dell'applicazione.
  Molti proxy hanno la capacità di bilanciare il carico,
  in base ai controlli di integrità definiti dall'utente.
* Utilizza un programma di bilanciamento del carico globale come [Traffic Director ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://dyn.com/traffic-director/){:new_window} da indirizzare a {{site.data.keyword.cloudant_short_notm}}.
  Questa opzione richiede una definizione `CNAME` che indirizzi a
  diversi account {{site.data.keyword.cloudant_short_notm}}
   sulla base di un controllo di integrità o una regola di latenza.

## Ripristino da un failover

Se una singola istanza di {{site.data.keyword.cloudant_short_notm}} non è raggiungibile,
evita di reindirizzare il traffico verso di essa non appena diventa di nuovo disponibile.
Il motivo è che è richiesto un certo tempo per le attività
intensive come la sincronizzazione dello stato del database da un qualsiasi peer
e per garantire che gli indici siano aggiornati.

È utile disporre di un meccanismo per monitorare queste attività
per aiutare a determinare quando un database è in uno stato adeguato per servire il traffico di produzione.

Come guida,
un tipico elenco dei controlli da applicare comprende:

* [Repliche](#replications)
* [Indici](#indexes)

> **Nota:** se implementi il reinstradamento delle richieste o il failover in base a un test di integrità,
  potresti voler incorporare i controlli corrispondenti per evitare un reinstradamento prematuro
  a un'istanza del servizio che è ancora in fase di ripristino.

### Repliche

* Ci sono repliche in uno stato di errore?
* È necessario riavviare alcune repliche?
* Quante modifiche in sospeso sono ancora in attesa della replica nel database?

Sono disponibili ulteriori informazioni sul [monitoraggio dello stato di
replica](../api/advanced_replication.html#replication-status).

> **Nota:** se un database viene modificato continuamente,
  è improbabile che lo stato di replica sia 0.
  Devi decidere quale soglia di stato sia accettabile
  o rappresenti uno stato di errore.

### Indici

* Gli indici sono sufficientemente aggiornati?
  Controlla utilizzando l'endpoint [Attività in corso](../api/active_tasks.html).
* Verifica il livello di 'disponibilità dell'indice' inviando una query all'indice
  e decidendo se risponde entro un tempo accettabile.
