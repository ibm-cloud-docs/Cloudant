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

<!-- Acrolinx: 2018-05-07 -->

# CouchApps

{{site.data.keyword.cloudantfull}} può ospitare dati di file non elaborati,
come le immagini,
e servirli su HTTP,
il che significa che può ospitare tutti i file statici necessari per eseguire un sito web
e ospitarli proprio come un server web.
{:shortdesc}

Poiché questi file saranno ospitati su {{site.data.keyword.cloudant_short_notm}},
JavaScript lato client potrà accedere ai database {{site.data.keyword.cloudant_short_notm}}.
Si dice che un'applicazione costruita in questo modo abbia un'architettura a due livelli,
costituita dal client - in genere un browser - e dal database.
Nella community CouchDB,
questa è chiamata CouchApp.

La maggior parte delle applicazioni web ha tre livelli:
il client,
il server
e il database.
Posizionare il server tra il client e il database può aiutare con l'autenticazione,
l'autorizzazione,
la gestione degli asset,
l'utilizzo vantaggioso di API web di terze parti,
la fornitura di endpoint particolarmente sofisticati
ecc.
Questa separazione consente una maggiore complessità senza combinare le preoccupazioni,
in modo che il tuo client possa preoccuparsi solo della presentazione dei dati
mentre il tuo database può concentrarsi sulla memorizzazione e sul servizio dei dati.

Le CouchApp brillano nella loro semplicità,
ma spesso un'applicazione web richiederà la potenza di un'architettura a 3 livelli.
Come scegliere quella appropriata?

## Una CouchApp è appropriata se...

-   Il tuo server ha fornito solo un'API a {{site.data.keyword.cloudant_short_notm}}.
-   Utilizzi l'[autenticazione basata su cookie](../api/authentication.html) di
    {{site.data.keyword.cloudant_short_notm}}.
-   Utilizzi i database [`_users` e `_security`](../api/authorization.html) di {{site.data.keyword.cloudant_short_notm}}
    per gestire gli utenti e le autorizzazioni.
-   Non hai bisogno di pianificare lavori CRON o altre attività regolari.

Per iniziare a utilizzare le CouchApp,
consulta [Gestione di applicazioni su {{site.data.keyword.cloudant_short_notm}} ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://cloudant.com/blog/app-management/){:new_window}.

## Un'applicazione a 3 livelli è appropriata se...

-   Hai bisogno di autorizzazioni più dettagliate rispetto a quelle consentite dal database
    `_security`.
-   Hai bisogno di un metodo di autenticazione diverso dall'autenticazione di base o dall'autenticazione dei cookie,
    come ad esempio Oauth o un sistema di accesso di terze parti.
-   Hai bisogno di pianificare attività al di fuori del client da eseguire regolarmente.

Puoi scrivere il tuo livello di server utilizzando le tecnologie più adatte alle tue
esigenze.
È [disponibile](../libraries/index.html) un elenco di librerie per lavorare con {{site.data.keyword.cloudant_short_notm}}.
