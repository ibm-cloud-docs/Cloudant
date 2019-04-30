---

copyright:
  years: 2017, 2019
lastupdated: "2019-03-06"

keywords: legacy access controls, api keys, enable iam, provisioning, how to choose between iam and legacy credentials, making requests, required client libraries, actions, endpoints, map actions to iam roles

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

# {{site.data.keyword.cloud_notm}} IAM (Identity and Access Management)
{: #ibm-cloud-identity-and-access-management-iam-}

{{site.data.keyword.cloud}} Identity and Access Management fornisce un approccio unificato alla gestione di identità utente, servizi e controllo dell'accesso.
{: shortdesc}

## Introduzione
{: #introduction}

Questo documento descrive l'integrazione di {{site.data.keyword.cloudantfull}} con {{site.data.keyword.cloud_notm}} Identity and Access Management. Discute le differenze tra i controlli dell'accesso Legacy di {{site.data.keyword.cloudant_short_notm}} e i controlli dell'accesso di {{site.data.keyword.cloud_notm}} IAM. Guarda quindi ai vantaggi e agli svantaggi di ognuno di essi per aiutarti a decidere quali usare. Viene quindi trattata la modalità di utilizzo di IAM nelle librerie client di {{site.data.keyword.cloudant_short_notm}} tramite le chiamate HTTP. Si finisce quindi con una sezione di riferimento che descrive tutte le azioni e tutti i ruoli IAM disponibili in {{site.data.keyword.cloudant_short_notm}}.

Consulta una panoramica di [IAM ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://cloud.ibm.com/docs/iam/index.html#iamoverview){: new_window}, incluso come:

- Gestire ID utente e servizio.
- Gestire le credenziali disponibili.
- Utilizzare le politiche di accesso IAM che consentono e revocano l'accesso alle istanze del servizio {{site.data.keyword.cloudant_short_notm}}.

## Differenze tra i controlli dell'accesso {{site.data.keyword.cloudant_short_notm}} Legacy e IAM
{: #differences-between-ibm-cloudant-legacy-and-iam-access-controls}

La seguente sezione fornisce una breve panoramica delle differenze tra i meccanismi di controllo dell'accesso di {{site.data.keyword.cloudant_short_notm}} Legacy e {{site.data.keyword.cloud_notm}} IAM.

### {{site.data.keyword.cloud_notm}} Identity and Access Management
{: #ibm-cloud-identity-and-access-management}

- Gestione dell'accesso gestita centralmente in tutto {{site.data.keyword.cloud_notm}}.
- Consenti a un utente o a un servizio di accedere a molte risorse differenti utilizzando lo stesso insieme
  di credenziali (ad esempio, gli stessi nome utente/password o la stessa chiave API IAM).
- Alle chiavi API IAM è possibile concedere l'accesso alle funzioni di gestione dell'account, come la creazione di nuovi database.

### {{site.data.keyword.cloudant_short_notm}} Legacy
{: #ibm-cloudant-legacy}

- Unico per {{site.data.keyword.cloudant_short_notm}}.
- L'accesso a ogni istanza del servizio richiede una sua serie di credenziali.
- Utilizza l'autenticazione di base HTTP con credenziali che non sono associate a un singolo utente o servizio.
- Alle chiavi API {{site.data.keyword.cloudant_short_notm}} possono essere concesse le autorizzazioni solo a un livello di database.

### Note sulle chiavi API
{: #api-key-notes}

In questo documento, ovunque siano menzionate le chiavi API, ci si riferisce alle chiavi API IAM.
{{site.data.keyword.cloudant_short_notm}} Legacy ha anche un concetto di chiavi API e qualsiasi
discussione relativa alle credenziali o alle combinazioni nome utente/password di {{site.data.keyword.cloudant_short_notm}} Legacy
include anche le chiavi API {{site.data.keyword.cloudant_short_notm}}. 

## Abilitazione di IAM con {{site.data.keyword.cloudant_short_notm}}
{: #enabling-iam-with-ibm-cloudant}

A partire da fine luglio 2018, sono le nuove istanze del servizio {{site.data.keyword.cloudant_short_notm}} possono essere utilizzate con {{site.data.keyword.cloud_notm}} IAM.

Tutte le nuove istanze del servizio {{site.data.keyword.cloudant_short_notm}} sono abilitate a utilizzare IAM quando ne viene eseguito il provisioning. Facoltativamente, puoi anche abilitare il meccanismo di autenticazione legacy.  Quando esegui il provisioning di una nuova istanza {{site.data.keyword.cloudant_short_notm}} dal catalogo {{site.data.keyword.cloud_notm}}, scegli dai metodi di autenticazione disponibili:

1. **Use both legacy credentials and IAM**: questa modalità significa che per accedere all'account è possibile utilizzare sia le credenziali IAM che quelle Legacy. In particolare, entrambe le serie di credenziali IAM e Legacy sono fornite a tutte le applicazioni associate alle credenziali di account e servizio generate.
2. **Use only IAM**: questa modalità significa che solo le credenziali IAM vengono fornite tramite il bind di servizio e la generazione di credenziali.

### Chiavi API {{site.data.keyword.cloudant_short_notm}} e _Use only IAM_
{: #ibm-cloudant-api-keys-and-_use-only-iam_}

L'utilizzo di chiavi API {{site.data.keyword.cloudant_short_notm}} insieme a IAM è possibile ma **non è consigliato**. Questo consiglio viene dato perché le chiavi API {{site.data.keyword.cloudant_short_notm}} e le autorizzazioni non sono visibili o gestibili tramite l'interfaccia delle politiche IAM, rendendo impossibile una gestione olistica dell'accesso.

La scelta tra _Use only IAM_ o _Use both legacy credentials and IAM_ influenza:

1. Se le credenziali a livello di account {{site.data.keyword.cloudant_short_notm}} legacy sono disponibili per gestire i database e altre azioni a livello di account.
2. Lo stile delle credenziali fornite durante la generazione delle credenziali del servizio.

In particolare, è ancora possibile utilizzare le chiavi API {{site.data.keyword.cloudant_short_notm}} per gestire l'accesso al database. Queste credenziali devono essere generate e configurate utilizzando l'API HTTP.

### Provisioning utilizzando la riga di comando
{: #provisioning-by-using-the-command-line}

Quando esegui il provisioning di una nuova istanza {{site.data.keyword.cloudant_short_notm}} dalla riga di comando, fornisci un'opzione allo strumento `ic` utilizzando il parametro `-p` per abilitare o disabilitare le credenziali legacy per un account. L'opzione viene
passata in formato JSON ed è denominata `legacyCredentials`.

Per eseguire il provisioning di un'istanza come _Use only IAM_ (consigliato), esegui questo comando:

```sh
ic resource service-instance-create  "Instance Name" \
    cloudantnosqldb Standard us-south \
    -p {"legacyCredentials": false}
```

Per eseguire il provisioning di un'istanza come _Use both legacy credentials and IAM_, esegui questo comando:

```sh
ic resource service-instance-create  "Instance Name" \
    cloudantnosqldb Standard us-south \
    -p {"legacyCredentials": true}
```

### Esempi JSON di credenziali del servizio per ogni opzione
{: #service-credential-json-examples-for-each-option}

La scelta tra il controllo dell'accesso _Use only IAM_ e quello _Use both legacy credentials and IAM_
influenza la modalità in cui le credenziali vengono fornite alla tua applicazione quando viene eseguito il bind e la generazione di credenziali del servizio. Quando viene eseguita la generazione delle credenziali nell'interfaccia {{site.data.keyword.cloud_notm}}
IAM primaria, le chiavi API sono visualizzate in tale interfaccia quando vengono generate.

Puoi anche generare le credenziali dalla sezione Credenziali del servizio di una istanza del servizio. Generare le credenziali del servizio in questo modo crea un blob JSON di credenziali del servizio che può essere incollato nelle applicazioni con tutti i dettagli necessari per accedere all'istanza del servizio.

Questa sezione mostra come si presenta il JSON di credenziale del servizio e cosa significa ciascun valore.

Quando selezioni _Use only IAM_, le credenziali del servizio generate contengono solo valori IAM e hanno un aspetto simile al seguente esempio:

```json
{
  "apikey": "MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz",
  "iam_apikey_description": "Auto generated apikey during resource-key [...]",
  "iam_apikey_name": "auto-generated-apikey-050d21b5-5f[...]",
  "iam_role_crn": "crn:v1:bluemix:public:iam::::serviceRole:Manager",
  "iam_serviceid_crn": "crn:v1:staging:public:iam-identity::[...]",
  "url": "https://76838001-b883-444d-90d0-46f89e942a15-bluemix.cloudant.com",
  "username": "76838001-b883-444d-90d0-46f89e942a15-bluemix"
}
```

Ciascun valore nel precedente esempio JSON deve essere interpretato nel seguente modo:

- `apikey`: la chiave API IAM.
- `iam_apikey_description`: la descrizione della chiave API IAM.
- `iam_apikey_name`: l'ID della chiave API IAM.
- `iam_role_crn`: il ruolo IAM che ha la chiave API IAM.
- `iam_serviceid_crn`: il CRN dell'ID servizio.
- `url`: l'URL del servizio {{site.data.keyword.cloudant_short_notm}}.
- `username`: il nome account {{site.data.keyword.cloudant_short_notm}} interno.

Quando selezioni _Use both legacy credentials and IAM_, le credenziali del servizio generate contengono sia le credenziali IAM che quelle Legacy e hanno un aspetto simile al seguente esempio:

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

Ciascun valore nel precedente esempio JSON deve essere interpretato nel seguente modo:

- `apikey`: la chiave API IAM.
- `host`: il nome host del servizio {{site.data.keyword.cloudant_short_notm}}.
- `iam_apikey_description`: la descrizione della chiave API IAM.
- `iam_apikey_name`: l'ID della chiave API IAM.
- `iam_role_crn`: il ruolo IAM che ha la chiave API IAM.
- `iam_serviceid_crn`: il CRN dell'ID servizio.
- `password`: la password della credenziale {{site.data.keyword.cloudant_short_notm}} Legacy.
- `port`: la porta del servizio {{site.data.keyword.cloudant_short_notm}}.
- `url`: l'URL del servizio {{site.data.keyword.cloudant_short_notm}}, comprese le credenziali {{site.data.keyword.cloudant_short_notm}} Legacy incorporate.
- `username`: il nome utente della credenziale {{site.data.keyword.cloudant_short_notm}} Legacy.

## Devo usare _Use only IAM_ oppure _Use both legacy credentials and IAM_?
{: #should-i-use-_use-only-iam_-or-_use-both-legacy-credentials-and-iam_-}

Se possibile, è preferibile _Use only IAM_. I maggiori vantaggi per l'utilizzo di {{site.data.keyword.cloud_notm}} IAM includono:

- La gestione dell'accesso a {{site.data.keyword.cloudant_short_notm}} con gli strumenti standard di {{site.data.keyword.cloud_notm}} invece che
  con una combinazione di gestione delle credenziali specifica per {{site.data.keyword.cloud_notm}} e {{site.data.keyword.cloudant_short_notm}}.
- Le credenziali possono essere facilmente revocate e ruotate quando utilizzi {{site.data.keyword.cloud_notm}} IAM.

Di seguito è riportata un'ulteriore descrizione dei vantaggi e degli svantaggi di ciascun approccio.

### Vantaggi e svantaggi dei due meccanismi di controllo dell'accesso
{: #advantages-and-disadvantages-of-the-two-access-control-mechanisms}

Complessivamente, {{site.data.keyword.cloud_notm}} IAM è il modello di autenticazione consigliato. Tuttavia, tale approccio presenta degli
svantaggi; in particolar modo se hai un'applicazione esistente o non puoi utilizzare una libreria client supportata da {{site.data.keyword.cloudant_short_notm}}.

<table>

<tr>
<th id="mode">Modalità</th>
<th id="advantages">Vantaggi</th>
<th id="disadvantages">Svantaggi</th>
</tr>

<tr>
<td headers="mode">IAM</td>
<td headers="advantages" valign="top"><ul><li>Gestisci l'accesso per molti servizi utilizzando un'unica interfaccia. Revoca l'accesso a un utente globalmente.</li>
<li>Chiavi API a livello di account tramite gli ID servizio.</li>
<li>Credenziali facili da ruotare.</li>
<li>I log Activity Tracker acquisiscono singoli utenti e servizi.</li>
<li>IAM si federa con altri sistemi di identità, come i repository LDAP aziendali.</li></ul>
</td>
<td headers="disadvantages"><ul><li>Se non stai utilizzando le librerie supportate di {{site.data.keyword.cloudant_short_notm}}, sono probabilmente necessarie delle modifiche dell'applicazione per utilizzare le chiavi API e i token di accesso di IAM.</li>
<li>Nessuna autorizzazione a livello di database (finora).</li>
<li>Nessuna autorizzazione dettagliata (ad esempio lettore) (finora).</li>
<li>Alcuni endpoint non sono disponibili; vedi [Endpoint non disponibili](#unavailable-endpoints).</li>
<li>Nessun modo per specificare un database come "pubblico", ossia che non richiede un utente autorizzato per l'accesso.</li></ul>
</td>
</tr>

<tr>
<td headers="mode">Legacy</td>
<td headers="advantages">
<ul><li>Nessun bisogno di modificare le applicazioni o le dipendenze di libreria client esistenti.</li>
<li>Autorizzazioni a livello di database.</li>
<li>Ruoli dettagliati (lettore, scrittore).</li>
</ul>
</td>
<td headers="disadvantages">
<ul><li>Nessuna chiave API a livello di account; bisogna utilizzare le credenziali `root` per gestire i database.</li>
<li>Gestione separata delle credenziali {{site.data.keyword.cloudant_short_notm}} ed è pertanto impossibile ottenere una panoramica completa di tutto l'accesso all'interno dell'interfaccia centralizzata.</li>
<li>Rotazione delle credenziali difficile da implementare.</li>
</ul>
</td>
</tr>
</table>

## Effettuazione di richieste alle istanze utilizzando le credenziali IAM
{: #making-requests-to-instances-by-using-iam-credentials}

In questa sezione viene illustrato come utilizzare {{site.data.keyword.cloudant_short_notm}} con
le istanze del servizio utilizzando l'autenticazione e il controllo dell'accesso IAM. Utilizza i dettagli dall'esempio JSON di credenziali del servizio menzionato in precedenza.

{{site.data.keyword.cloud_notm}} IAM richiede che una chiave API IAM venga scambiata con un token di accesso a tempo limitato prima di effettuare una richiesta a una risorsa o a un servizio. Il token di accesso viene quindi incluso nell'intestazione HTTP `Authorization` al servizio. Quando il token di accesso scade, l'applicazione che lo utilizza deve gestire l'ottenimento di un nuovo token dal servizio token IAM. Per ulteriori informazioni, vedi la documentazione [Getting an {{site.data.keyword.cloud_notm}} IAM token by using an API key ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://cloud.ibm.com/docs/iam/apikey_iamtoken.html#iamtoken_from_apikey) per ulteriori dettagli.

Le librerie client ufficiali di {{site.data.keyword.cloudant_short_notm}} gestiscono l'ottenimento di un token da una chiave API per tuo conto. Se accedi a {{site.data.keyword.cloudant_short_notm}} direttamente utilizzando un client HTTP invece di una libreria client {{site.data.keyword.cloudant_short_notm}}, devi gestire lo scambio e l'aggiornamento di un token di accesso a tempo limitato utilizzando una chiave API IAM con il servizio token IAM. Dopo che un token scade, {{site.data.keyword.cloudant_short_notm}} restituisce un codice di stato HTTP `401`.

### Versioni della libreria client richieste
{: #required-client-library-versions}

Utilizza come minimo le seguenti versioni della libreria client con istanze del servizio {{site.data.keyword.cloudant_short_notm}} abilitate a IAM:

| Libreria | Consigliata |
| --- | --- |
| [java-cloudant](https://github.com/cloudant/java-cloudant) | 2.13.0+ |
| [nodejs-cloudant](https://github.com/cloudant/nodejs-cloudant) | 2.3.0+ |
| [python-cloudant](https://github.com/cloudant/python-cloudant) | 2.9.0+ |
| [couchbackup](https://github.com/cloudant/couchbackup/) | 2.3.1+ |
| [CDTDatastore](https://github.com/cloudant/cdtdatastore/) | 2.0.3+ |
| [sync-android](https://github.com/cloudant/sync-android/) | 2.2.0+ |

I seguenti frammenti di codice richiedono queste versioni.

### Java
{: #java}

Richiede [java-cloudant](https://github.com/cloudant/java-cloudant), 2.13.0+.

Utilizza il metodo `iamApiKey()` per creare un client database con una chiave API IAM:

```java
package com.mycompany.app;

import com.cloudant.client.api.ClientBuilder;
import com.cloudant.client.api.CloudantClient;


public class App
{
    public static void main( String[] args )
    {
        CloudantClient client = ClientBuilder
                .account("76838001-b883-444d-90d0-46f89e942a15-bluemix")
                .iamApiKey("MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz")
                .build();

        for (String db : client.getAllDbs()) {
            System.out.println(db);
        }
    }
}
```

### Node.js
{: #node.js}

Richiede [nodejs-cloudant](https://github.com/cloudant/nodejs-cloudant), 2.3.0+.

Utilizza il plug-in `iamauth` per creare un client database con una chiave API IAM:

```js
var Cloudant = require('@cloudant/cloudant');

var cloudant = new Cloudant({
  account: '76838001-b883-444d-90d0-46f89e942a15-bluemix',
  plugins: {
    iamauth: {
      iamApiKey: 'MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz'
    }
  }
});
cloudant.db.list(function(err, body) {
  body.forEach(function(db) {
    console.log(db);
  });
});
```

### Python
{: #python}

Richiede [python-cloudant](https://github.com/cloudant/python-cloudant), 2.9.0+.

Utilizza il metodo `Cloudant.iam(account_name, api_key, **kwargs)` per creare un client database con una chiave API IAM:

```python
from cloudant.client import Cloudant

client = Cloudant.iam(
    "76838001-b883-444d-90d0-46f89e942a15-bluemix",
    "MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz",
    connect=True
)
print client.all_dbs()
```

### Accesso utilizzando il client HTTP
{: #access-by-using-http-client}

{{site.data.keyword.cloud_notm}} IAM richiede che una chiave API IAM venga scambiata con un token di accesso a tempo limitato prima di effettuare una richiesta a una risorsa o a un servizio. Il token di accesso viene quindi incluso nell'intestazione HTTP `Authorization` al servizio. Quando il token di accesso scade, il cliente deve gestire l'ottenimento di un nuovo token dal servizio token IAM.

Come indicato in precedenza, l'utilizzo di {{site.data.keyword.cloud_notm}} IAM richiede che tu prima scambi una chiave API {{site.data.keyword.IBM_notm}} con un token di accesso a tempo limitato e che utilizzi quindi il token per eseguire l'autenticazione rispetto all'API {{site.data.keyword.cloudant_short_notm}}.

In Python, un esempio potrebbe presentarsi così:

```python
import time

import requests

API_KEY = "MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz"
ACCOUNT = "76838001-b883-444d-90d0-46f89e942a15-bluemix"

def get_access_token(api_key):
    """Retrieve an access token from the IAM token service."""
    token_response = requests.post(
        "https://iam.cloud.ibm.com/identity/token",
        data={
            "grant_type": "urn:ibm:params:oauth:grant-type:apikey",
            "response_type": "cloud_iam",
            "apikey": api_key
        },
        headers={
            "Accept": "application/json"
        }
    )
    if token_response.status_code == 200:
        print "Got access token from IAM"
        return token_response.json()['access_token']
    else:
        print token_response.status_code, token_response.json()
        return None

def main(api_key, account):
    access_token = None
    while True:
        if not access_token:
            access_token = get_access_token(api_key)

        if access_token:
            response = requests.get(
                "https://{0}.cloudant.com/_all_dbs".format(account),
                headers={
                    "Accept": "application/json",
                    "Authorization": "Bearer {0}".format(access_token)
                }
            )
            print "Got Cloudant response, status code", response.status_code
            if response.status_code == 401:
                print "Token has expired."
                access_token = None

        time.sleep(1)

if __name__ == "__main__":
    main(API_KEY, ACCOUNT)
```

## Riferimento
{: #reference}

Questa sezione contiene un elenco completo delle azioni IAM di {{site.data.keyword.cloudant_short_notm}} e quali azioni sono consentite per ogni ruolo del sistema IAM.

### Azioni di {{site.data.keyword.cloudant_short_notm}}
{: #ibm-cloudant-actions}

Azione | Descrizione
-------|------------
`cloudant.db.any` | Accesso a qualsiasi endpoint del database (quelli il cui percorso non inizia con `/_api`).
`cloudantnosqldb.sapi.dbsecurity` | Accesso a `/_api/v2/db/<path:db>/_security`.
`cloudantnosqldb.sapi.usercors` | Accesso a `/_api/v2/user/config/cors/`.
`cloudantnosqldb.sapi.apikeys` | Accesso a `/_api/v2/api_keys`.
`cloudantnosqldb.sapi.userinfo` | Accesso a `/_api/v2/user`.

#### Endpoint non disponibili
{: #unavailable-endpoints}

I seguenti endpoint non sono disponibili per le richieste autorizzate con IAM:

- Gestori di riscrittura HTTP: `/db/_design/design-doc/_rewrite/path`. <br>
I documenti di progettazione possono contenere gestori di riscrittura ma gli utenti non possono richiamarli.
- Aggiorna i gestori: `POST /{db}/_design/{ddoc}/_update/{func}`. <br>
I documenti di progettazione possono contenere funzioni di aggiornamento ma gli utenti non possono richiamarle.

### Associazione di azioni {{site.data.keyword.cloudant_short_notm}} a ruoli IAM
{: #mapping-of-ibm-cloudant-actions-to-iam-roles}

Solo i servizi e gli utenti del ruolo Gestore possono accedere ai dati {{site.data.keyword.cloudant_short_notm}}.

Ruolo | Azioni consentite
-----|----------------
Gestore | Tutte le azioni documentate.
Lettore | Nessuna.
Scrittore | Nessuna.

## Risoluzione dei problemi
{: #troubleshooting}
Se stai avendo problema a utilizzare IAM per eseguire l'autenticazione quando effettui richieste alla tua istanza del servizio {{site.data.keyword.cloudant_short_notm}}, verifica il tuo account come mostrato nella prossima sezione. 

### Assicurati che il tuo account sia abilitato a IAM
{: #ensure-your-account-is-iam-enabled}

Devi aprire un ticket di supporto per confermare che un'istanza del servizio è abilitata a IAM. 
