---

copyright:
  years: 2015, 2017
lastupdated: "2017-01-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-01-24 -->

<div id="cap_theorem"></div>

<div id="consistency"></div>

# Teorema CAP

Cloudant utilizza un modello di ['consistenza eventuale' ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://en.wikipedia.org/wiki/Eventual_consistency){:new_window}.
{:shortdesc}

Per comprendere come funzioni questo modello
e perché sia una parte essenziale dell'utilizzo di Cloudant,
è importante sapere cosa si intende per consistenza.

La consistenza è una delle quattro proprietà ['ACID' ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://en.wikipedia.org/wiki/ACID){:new_window}
necessarie affinché le transazioni all'interno di un database vengano elaborate e riportate in modo affidabile.

Inoltre,
la consistenza è uno dei tre attributi nel
teorema <a href="http://en.wikipedia.org/wiki/CAP_Theorem" target="_blank">'CAP'
<img src="../images/launch-glyph.svg" alt="Icona link esterno" title="Icona link esterno"></a>.
Gli attributi sono consistenza (**C**onsistency),
disponibilità (**A**vailability) e tolleranza di partizione (**P**artition tolerance).
Il teorema afferma che non è possibile per un sistema informatico distribuito come Cloudant
fornire _simultaneamente_ questi tre attributi:

-   Consistenza,
    dove tutti i nodi vedono gli stessi dati nello stesso momento.
-   Disponibilità,
    che garantisce che ogni richiesta riceva una risposta su ciò che è riuscito o non riuscito.
-   Tolleranza di partizione,
    dove il sistema continua a funzionare nonostante perdite o errori di una parte del sistema.

L'impossibilità di garantire tutti e tre gli attributi contemporaneamente
significa che Cloudant non garantisce l'attributo Consistenza.
In un modello di consistenza eventuale,
come Cloudant,
un aggiornamento apportato a una parte del sistema viene _eventualmente_ visto dalle altre parti del sistema.
Man mano che l'aggiornamento si propaga,
il sistema 'converge' verso la consistenza completa.

La consistenza eventuale è utile per le prestazioni.
Con un forte modello di consistenza,
un sistema deve attendere che gli aggiornamenti siano propagati completamente e correttamente
prima che una richiesta di scrittura o aggiornamento possa essere completata.
Con un modello di consistenza eventuale,
la richiesta di scrittura o aggiornamento può tornare quasi immediatamente,
mentre la propagazione attraverso il sistema continua 'dietro le quinte".

Un database può esporre solo due di questi tre attributi sia per ragioni teoriche che pratiche.
Un database che privilegia la consistenza e la disponibilità è semplice:
un singolo nodo memorizza una singola copia dei tuoi dati.
Ma questo modello è difficile da scalare in quanto per ottenere maggiori prestazioni devi aggiornare il nodo
anziché utilizzare nodi aggiuntivi.
Inoltre,
anche un minimo errore di sistema può arrestare un sistema a singolo nodo
mentre una qualsiasi perdita di messaggi indica una perdita di dati significativi.
Per resistere,
il sistema deve diventare più sofisticato.

## Compromessi nella tolleranza di partizione

Un database che privilegia la consistenza e la tolleranza di partizione di solito utilizza
un'impostazione <a href="http://en.wikipedia.org/wiki/Master/slave_(technology)" target="_blank">master-slave <img src="../images/launch-glyph.svg" alt="Icona link esterno" title="Icona link esterno"></a>,
dove
un nodo dei molti nel sistema è eletto come coordinatore.
Solo il coordinatore può approvare le scritture dei dati,
mentre tutti i nodi secondari replicano i dati dal coordinatore per gestire le letture.
Se il coordinatore perde la connessione alla rete
o non può comunicare con molti dei nodi del sistema,
i rimanenti eleggono un nuovo coordinatore.
Questo processo di elezione differisce tra i sistemi
e può essere fonte di [problemi significativi ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://aphyr.com/posts/284-call-me-maybe-mongodb){:new_window}.

Cloudant privilegia la disponibilità e la tolleranza di partizione adoperando un'impostazione master-master,
in modo tale che ogni nodo possa accettare le scritture e le letture della sua parte di dati.
Più nodi contengono copie di ogni parte dei tuoi dati.
Ogni nodo copia i dati con altri nodi.
Se un nodo diventa inaccessibile,
gli altri nodi possono servire al suo posto mentre la rete si ricollega.
Così,
il sistema restituisce i dati in modo tempestivo nonostante l'errore arbitrario del nodo
e mantiene la [consistenza eventuale ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://en.wikipedia.org/wiki/Eventual_consistency){:new_window}.
Il compromesso di trascurare la consistenza assoluta è che ci vuole del tempo affinché tutti i nodi vedano gli stessi dati.
Di conseguenza,
alcune risposte potrebbero contenere dati obsoleti mentre i nuovi dati si propagano attraverso il sistema.

## Modifica dell'approccio

La gestione di una vista coerente dei dati è logica e facile da capire
perché un database relazionale svolge questo compito per te.
L'aspettativa è che i servizi basati sul web che interagiscono con i sistemi di database si comportino in questo modo.
Ma questa aspettativa non significa che funzionino così.
La consistenza non è un dato di fatto
e ci vuole un po' di lavoro per modificare l'approccio.

In effetti,
la consistenza non è necessariamente indispensabile per molti servizi cloud aziendali.
Con i grandi sistemi ampiamente
utilizzati esiste un'elevata probabilità che una parte del sistema generi degli errori.
Un database progettato intorno alla necessità di privilegiare la disponibilità e la consistenza eventuale
è più adatto a mantenere la tua applicazione in linea.
La consistenza dei dati applicativi può essere affrontata a posteriori.
Come Seth Gilbert e Nancy Lynch del MIT
[concludono ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://www.glassbeam.com/sites/all/themes/glassbeam/images/blog/10.1.1.67.6951.pdf){:new_window},
"la maggior parte dei sistemi reali di oggi sono costretti a restituire 'la maggior parte dei dati nella maggior parte dei casi.'"

## Disponibilità dell'applicazione contro la consistenza nell'azienda

Uno sguardo ai più comuni servizi basati sul web dimostra che le persone prevedono già l'alta disponibilità
e scambiano felicemente questa disponibilità per dati con consistenza eventuale,
spesso senza rendersi conto che lo stanno facendo.

Molte applicazioni fuorviano gli utenti in nome della disponibilità.
Considera i bancomat:
i dati bancari inconsistenti sono il motivo per cui è ancora possibile spendere più soldi senza rendersene conto.
Non è realistico presentare una vista consistente del saldo del tuo conto in tutto il sistema bancario
se ogni nodo della rete deve arrestare e registrare questa cifra prima che le operazioni continuino.
È meglio rendere il sistema altamente disponibile.

L'industria bancaria lo ha rivelato nel 1980,
ma molte organizzazioni IT si preoccupano ancora di sacrificare la consistenza per il bene della disponibilità.
Pensa al numero di chiamate di supporto effettuate quando il tuo team di vendita non può accedere all'applicazione CRM.
Ora considera se questi si fossero resi conto che servono pochi secondi per propagare un aggiornamento di
database nell'applicazione.

La disponibilità prevale sulla consistenza di più di quanto tu possa immaginare.
I sistemi di shopping online,
le cache HTTP
e i DNS sono alcuni esempi.
Le organizzazioni devono considerare il costo dei tempi di inattività, come la frustrazione degli utenti,
la perdita di produttività e
le opportunità perse.

## Dalla teoria alla realizzazione

Affrontare l'alta disponibilità è di vitale importanza per le applicazioni cloud.
Altrimenti,
la consistenza del database globale rimane un ostacolo importante man mano lo ridimensioni.
Le applicazioni altamente disponibili devono mantenere un contatto costante con i propri dati,
anche se questi dati non sono più aggiornati.
Questo è il concetto di consistenza eventuale
e non c'è niente da temere.
Su larga scala,
a volte è meglio servire risposte anche se non perfettamente corrette piuttosto che non servirle affatto.

I sistemi di database nascondono le complessità della disponibilità rispetto alla consistenza in modi diversi,
ma sono sempre presenti.
La valutazione che viene fatta da Cloudant database-as-a-service,
insieme a CouchDB e altri database NoSQL,
è che è meglio richiedere agli sviluppatori di affrontare queste complessità all'inizio del processo di progettazione.
Facendo il duro lavoro in anticipo,
ridurrai le sorprese perché le applicazioni sono pronte a ridimensionarsi dal primo giorno.
