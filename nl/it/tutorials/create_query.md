---

copyright:
  years: 2017, 2019
lastupdated: "2019-06-12"

keywords: create database, create documents, create index, create query, run query, fields, operators

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

<!-- Acrolinx: 2017-05-10 -->

# Creazione di una query {{site.data.keyword.cloudant_short_notm}}
{: #creating-an-ibm-cloudant-query}

Questa esercitazione illustra come creare un database, popolarlo
con documenti, creare un indice e utilizzare l'indice per eseguire la query del database.
{: shortdesc}

Vengono forniti esercizi sia per la ![Icona Riga di comando](../images/CommandLineIcon.png) _Riga di comando_
che per il ![Icona Dashboard](../images/DashboardIcon.png) _Dashboard {{site.data.keyword.cloud}}_. Gli
esercizi per il dashboard {{site.data.keyword.cloud_notm}} ti forniscono un esempio visivo di ogni attività. Puoi seguire i link
nell'esercitazione per ulteriori informazioni.

Per iniziare, crea il database `query-demo` e alcuni documenti che contengono
i dati per queste esercitazioni.

## Premesse
{: ##assumptions}

Prima di cominciare, segui queste istruzioni per preparare l'esercitazione:

1.  [Crea un account {{site.data.keyword.cloud_notm}} ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://cloud.ibm.com/registration){: new_window}.
2.  Accedi al
  [dashboard {{site.data.keyword.cloud_notm}} ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://cloud.ibm.com/catalog/services/cloudant){: new_window}.
3.  [Crea una istanza {{site.data.keyword.cloudant_short_notm}} su {{site.data.keyword.cloud_notm}}](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-a-service-instance).
4.  (Facoltativo) [Crea un alias acurl](/docs/services/Cloudant?topic=cloudant-authorized-curl-acurl-#authorized-curl-acurl-) per rendere più facile e veloce eseguire i comandi dalla riga di comando.
5.  Sostituisci la variabile `$ACCOUNT` nei comandi inclusi negli esercizi con il nome utente che utilizzi per accedere al dashboard {{site.data.keyword.cloudant_short_notm}}.
  Se decidi di non configurare `acurl`,
  utilizza il seguente URL invece di quello fornito negli esercizi:
  ``` sh
  curl https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com/query-demo
  ```
  {: codeblock}

## Creazione di un database `query-demo`
{: #creating-the-query-demo-database}

In questa sezione, crea `query-demo` [database](/docs/services/Cloudant?topic=cloudant-databases#create-database) che è il
database che utilizziamo in questa esercitazione.

In questa esercitazione, utilizziamo l'alias `acurl` invece del comando `curl`. L'alias `acurl` viene creato utilizzando la procedura illustrata in [Curl autorizzato: `acurl`](/docs/services/Cloudant?topic=cloudant-authorized-curl-acurl-#authorized-curl-acurl-). Se preferisci utilizzare il comando `curl`
  o un altro metodo per richiamare gli endpoint API,
  sostituisci il tuo comando nell'esercitazione,
  insieme ai parametri richiesti dal tuo comando,
  come il nome utente e la password.
{: tip}

![Icona riga di comando](../images/CommandLineIcon.png) _Riga di comando_

1.  Crea un database eseguendo questo comando:
  ``` sh
  acurl https://$ACCOUNT.cloudant.com/query-demo -X PUT
  ```
  {: codeblock}
2.  Controlla i risultati:
  ```json
  {
    "ok": true
    }
  ```
  {: codeblock}

![Icona Dashboard](../images/DashboardIcon.png) _Dashboard {{site.data.keyword.cloud_notm}}_

1.  Apri l'istanza del servizio {{site.data.keyword.cloudant_short_notm}} che hai creato.
2.  Nella pagina del servizio {{site.data.keyword.cloudant_short_notm}}, fai clic su **Launch**.
    Viene aperta la scheda Databases.
    
  ![Scheda Databases](../images/tabs.png)
4.  Fai clic su **Create Database**.
5.  Immetti `query-demo` e fai clic su **Create**.

  Viene automaticamente aperto il database `query-demo`.

## Creazione di documenti nel database
{: #creating-documents-in-the-database}

I [documenti](/docs/services/Cloudant?topic=cloudant-documents#documents)
che crei in questo esercizio contengono i dati che utilizzi per eseguire la query del database `query-demo` nei successivi esercizi.

![Icona riga di comando](../images/CommandLineIcon.png) _Riga di comando_

1.  Copia il testo di esempio in un file di dati denominato `bulkcreate.dat` per creare cinque documenti:
  ```json
  {
    "docs": 
        [
      {
        "_id": "doc1",
                "firstname": "Sally",
                "lastname": "Brown",
                "age": 16,
                "location": "New York City, NY"
      },
      {
        "_id": "doc2",
                "firstname": "John",
                "lastname": "Brown",
                "age": 21,
                "location": "New York City, NY"
      },
      {
        "_id": "doc3",
                "firstname": "Greg",
                "lastname": "Greene",
                "age": 35,
                "location": "San Diego, CA"
      },
      {
        "_id": "doc4",
                "firstname": "Anna",
                "lastname": "Greene",
                "age": 44,
                "location": "Baton Rouge, LA"
      },
      {
        "_id": "doc5",
                "firstname": "Lois",
                "lastname": "Brown",
                "age": 33,
                "location": "Syracuse, NY"
            }
    ]
  }
  ```
  {: codeblock}

2.  Esegui questo comando per creare i documenti:
  ```sh
  acurl https://$ACCOUNT.cloudant.com/query-demo/_bulk_docs -X POST -H "Content-Type: application/json" -d \@bulkcreate.dat
  ```
  {: codeblock}

Nota che il simbolo '`@`', utilizzato per indicare che i dati vengono inclusi in un file, viene identificato dal nome fornito.
{: tip}

3.  Controlla i risultati:
  ```json
  [
    {
      "ok": true,
        "id": "doc1",
        "rev": "1-57a08e644ca8c1bb8d8931240427162e"
    },
    {
      "ok": true,
        "id": "doc2",
        "rev": "1-bf51eef712165a9999a52a97e2209ac0"
    },
    {
      "ok": true,
        "id": "doc3",
        "rev": "1-9c9f9b893fcdd1cbe09420bc4e62cc71"
    },
    {
      "ok": true,
        "id": "doc4",
        "rev": "1-6aa4873443ddce569b27ab35d7bf78a2"
    },
    {
      "ok": true,
        "id": "doc5",
        "rev": "1-d881d863052cd9681650773206c0d65a"
      }
  ]
  ```
  {: codeblock}

![Icona Dashboard](../images/DashboardIcon.png) _Dashboard {{site.data.keyword.cloud_notm}}_

1.  Fai clic su **`+`** e seleziona **New Doc**. Viene aperta la finestra 'New Document'.
2.  Per creare un documento, copia il seguente testo di esempio e sostituisci il testo nel nuovo documento.

  _Primo documento di esempio_:
  ```json
  {
    "firstname": "Sally",
    "lastname": "Brown",
    "age": 16,
    "location": "New York City, NY",
    "_id": "doc1"
  }
  ```
  {: codeblock}

3.  Ripeti il passo 2 per aggiungere i rimanenti documenti al database.

  _Secondo documento di esempio_:
  ```json
  {
    "firstname": "John",
    "lastname": "Brown",
    "age": 21,
    "location": "New York City, NY",
    "_id": "doc2"
  }
  ```
  {: codeblock}

  _Terzo documento di esempio_:
  ```json
  {
    "firstname": "Greg",
    "lastname": "Greene",
    "age": 35,
    "location": "San Diego, CA",
    "_id": "doc3"
  }
  ```
  {: codeblock}

  _Quarto documento di esempio_:
  ```json
  {
    "firstname": "Anna",
    "lastname": "Greene",
    "age": 44,
    "location": "Baton Rouge, LA",
    "_id": "doc4"
  }
  ```
  {: codeblock}

  _Quinto documento di esempio_:
  ```json
  {
    "firstname": "Lois",
    "lastname": "Brown",
    "age": 33,
    "location": "New York City, NY",
    "_id": "doc5"
  }
  ```
  {: codeblock}

  Il database `query-demo` è stato popolato con cinque record. Puoi vedere i record dalla vista Table nella seguente acquisizione di schermo:

  ![Documenti di esempio](../images/docs1.png)     

## Creazione di un indice per eseguire la query del database
{: #creating-an-index-to-query-the-database}

{{site.data.keyword.cloudant_short_notm}} fornisce viste e indici per eseguire query del database. Una vista esegue una query salvata nel database
e il risultato viene denominato serie di risultati. Quando invii una query nella vista, essa ricerca
la serie di risultati. Un indice è un modo di strutturare i dati che migliorano il tempo di richiamo.

In questa esercitazione, utilizziamo {{site.data.keyword.cloudant_short_notm}} Query che utilizza la sintassi di query di stile Mongo per ricercare i documenti utilizzando gli operatori logici. La query {{site.data.keyword.cloudant_short_notm}} è una combinazione di una vista e un indice di ricerca.

Quando utilizzi {{site.data.keyword.cloudant_short_notm}} Query, il programma di pianificazione di query esamina il selettore (la tua query) per determinare l'indice corretto tra cui scegliere. Se non trova un indice adatto, utilizza l'indice speciale `_all_docs` che ricerca i documenti in base all'ID. Nello scenario peggiore, restituisce tutti i documenti per ID (scansione completa della tabella). Nella memoria, filtriamo i documenti in base al selettore, che è il motivo per cui, anche senza un indice, puoi ancora eseguire la query con vari campi. Le scansioni complete della tabella sono costose e ti consigliamo di creare un indice. Vedi una descrizione dei diversi tipi di indici nel seguente elenco:

*	Indice primario - ricerca un documento o un elenco di documenti per ID.  
*	[Vista](/docs/services/Cloudant?topic=cloudant-views-mapreduce#views-mapreduce) – ricerca le informazioni nel database che corrispondono ai criteri di ricerca che hai specificato, come conteggi, somme, medie e altre funzioni matematiche. I criteri che puoi ricercare sono specificati nella definizione della vista. Le viste utilizzano il paradigma MapReduce.
*	[Indice di ricerca](/docs/services/Cloudant?topic=cloudant-search#search) – ricerca uno o più campi, grandi quantità di testo o utilizza i caratteri jolly, la ricerca fuzzy o facet con [Lucene Query Parser Syntax ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://lucene.apache.org/core/4_3_0/queryparser/org/apache/lucene/queryparser/classic/package-summary.html#Overview){: new_window}.

Se non è disponibile alcun indice definito che corrisponde alla query specificata, {{site.data.keyword.cloudant_short_notm}} utilizza l'indice `_all_docs`.
{: tip}


![Icona riga di comando](../images/CommandLineIcon.png) _Riga di comando_

1.  Copia i seguenti dati JSON di esempio in un file denominato `query-index.dat`.
  ```json
{
	"index": {
		"fields": [
			"age",
			"lastname"
		],
		"partial_filter_selector": {
			"age": {
				"$gte": 30
			},
			"lastname": {
				"$eq": "Greene"
			}
		}
	},
  		"ddoc": "partial-index",
		"type": "json"
}
  ```
  {: codeblock}

2.  Esegui il seguente comando per creare un indice:
  ```sh
  acurl https://$ACCOUNT.cloudant.com/query-demo/_index -X POST -H "Content-Type: application/json" -d \@query-index.dat
  ```
  {: codeblock}

3.  Controlla i risultati:
  ```json
  {
    "result":"created",
    "id":"_design/752c7031f3eaee0f907d18e1424ad387459bfc1d",
    "name":"query-index"
  }
  ```
  {: codeblock}



![Icona Dashboard](../images/DashboardIcon.png) _Dashboard {{site.data.keyword.cloud_notm}}_

1.  Fai clic su **`+` > Query Indexes** sulla scheda **All Documents** o **Design Documents**.
2.  Incolla i seguenti dati JSON di esempio nel campo **Index**:
  ```json
  {
	"index": {
		"fields": [
			"age",
			"lastname"
		],
		"partial_filter_selector": {
			"age": {
				"$gte": 30
			},
			"lastname": {
				"$eq": "Greene"
			}
		}
	},
  		"ddoc": "partial-index",
		"type": "json"
  }
  ```
  {: codeblock}

  L'indice è stato creato. Puoi vedere l'indice nella seguente acquisizione di schermo:

  ![Indice query](../images/query-index1.png)



## Creazione di una query
{: #creating-a-query}

Le query ti permettono di estrarre i tuoi dati da {{site.data.keyword.cloudant_short_notm}}. Un
[query](/docs/services/Cloudant?topic=cloudant-query#query) ben scritta può restringere la ricerca
e includere solo i dati che desideri.

Questo esercizio ti mostra come scrivere ed eseguire una query semplice, una query con due campi
e una query con due [operatori](/docs/services/Cloudant?topic=cloudant-query#operators).
Esegui la query con un operatore specificando almeno un campo e il suo valore corrispondente.
La query utilizza quindi questo valore per ricercare delle corrispondenze nel database.

Per tutto tranne che per la query più semplice, aggiungi JSON al file dei dati ed eseguita dalla riga di comando.

### Esecuzione di una query semplice
{: #running-a-simple-query}

Questo esempio illustra come la query {{site.data.keyword.cloudant_short_notm}} utilizza `query-index` per trovare
`lastname` e filtra i risultati nella memoria per trovare `firstname`.   

![Icona riga di comando](../images/CommandLineIcon.png) _Riga di comando_

1.  Copia i seguenti dati JSON di esempio in un file di dati denominato `query1.dat`.
  ```json
    {
      "selector": {
            "lastname" : "Greene",
            "firstname" : "Anna"            
         }        
    }       
  ```    
  {: codeblock}

2.  Esegui il seguente comando per eseguire la query per il database:
  ```sh
  acurl https://$ACCOUNT.cloudant.com/query-demo/_find -X POST -H "Content-Type: application/json" -d \@query1.dat
  ```
  {: codeblock}

3.  Controlla i risultati della query:
  ```json
  {
    "docs": [
      {
        "_id":"doc4",
        "_rev":"3-751ab049e8b5dd1ba045cea010a33a72",
            "firstname":"Anna",
            "lastname":"Greene",
            "age":44,
            "location":"Baton Rouge, LA"
      }
    ]
  }
  ```
  {: codeblock}

![Icona Dashboard](../images/DashboardIcon.png) _Dashboard {{site.data.keyword.cloud_notm}}_

1.  Fai clic sulla scheda **Query**.
2.  Copia e incolla il seguente JSON di esempio nella finestra della query {{site.data.keyword.cloudant_short_notm}}:
  ```json
   {
      "selector": {
            "lastname" : "Greene",
            "firstname" : "Anna"            
         }        
   }
  ```
  {: codeblock}

3.  Fai clic su **Run Query**.

  Vengono visualizzati i risultati della query. Puoi vederli dalla vista Table nella seguente acquisizione di schermo:

  ![Risultato query 1](../images/dashboard_query1_results.png)

### Esecuzione di una query con due campi
{: #running-a-query-with-two-fields}

Questo esempio utilizza due campi per trovare chiunque si chiama `Brown` che vive in `New York City, NY`.

Descriviamo la ricerca utilizzando un'[espressione 'selector'](/docs/services/Cloudant?topic=cloudant-query#selector-syntax)
che è simile al seguente esempio:
```json
  {
    "selector": {
      "lastname": "Brown",
      "location": "New York City, NY"
    }
  }
```
{: codeblock}

Possiamo personalizzare i risultati per soddisfare i nostri bisogni
aggiungendo ulteriori dettagli nell'espressione del selettore.
Il parametro `fields` specifica i campi da includere con i risultati. Nel nostro esempio,
i risultati includono il nome, il cognome e l'ubicazione. I risultati sono ordinati per nome
in ordine ascendente in base ai valori nel parametro `sort`.
Gli ulteriori dettagli sono simili al seguente esempio:
```json
{
  ...
  "fields" : [
    "firstname",
      "lastname",
      "location"
  ]
}
```  
{: codeblock}

![Icona riga di comando](../images/CommandLineIcon.png) _Riga di comando_

1.  Copia il JSON di esempio in un file di dati denominato `query2.dat`.
  ```json
  {
    "selector": {
      "lastname": "Brown",
      "location": "New York City, NY"
    },
    "fields" : [
     "firstname",
     "lastname",
     "location"
  ]
  }
  ```
  {: codeblock}

2.  Esegui il seguente comando per eseguire la query per il database:
  ```sh
  acurl https://$ACCOUNT.cloudant.com/query-demo/_find -X POST -H "Content-Type: application/json" -d \@query2.dat
  ```
  {: codeblock}

3.  Controlla i risultati della query:
  ```json
  {
    "docs": [
      {
        "firstname": "Sally",
        "lastname": "Brown",
        "location": "New York City, NY"
      },
      {
        "firstname": "John",
        "lastname": "Brown",
        "location": "New York City, NY"
      },
      {
        "firstname": "Lois",
        "lastname": "Brown",
        "location": "New York City, NY"
      }
    ]
  }
  ```
  {: codeblock}

![Icona Dashboard](../images/DashboardIcon.png) _Dashboard {{site.data.keyword.cloud_notm}}_

1.  Fai clic sulla scheda **Query**.
2.  Copia e incolla il seguente JSON di esempio nella finestra della query {{site.data.keyword.cloudant_short_notm}}:
  ```json
  {
    "selector": {
      "lastname": "Brown",
      "location": "New York City, NY"
    },
    "fields": [
      "firstname",
      "lastname",
      "location"
    ] 
  }
  ```
  {: codeblock}

3.  Fai clic su **Run Query**.

  Vengono visualizzati i risultati della query. Puoi vederli dalla vista Table nella seguente acquisizione di schermo:

  ![Risultati query 2](../images/dashboard_query2_results.png)

### Esecuzione di una query con operatori
{: #running-a-query-with-operators}

In questo esempio, gli operatori `$eq` (uguale) e `$gt` (maggiore di) sono utilizzati per ricercare
documenti che contengono il cognome `Greene` e un'età maggiore di `30`.

Utilizziamo un'espressione selettore come il seguente esempio:
```json
{
  "selector": {
    "age": {
      "$gt": 30
    },
    "lastname": {
      "$eq": "Greene"
    }
  }
}
``` 
{: codeblock}

I risultati sono ordinati per età in ordine crescente in base ai valori specificati nel parametro `sort`.

```json
    "sort": [
      {
        "age": "asc"   
      }
    ] 
```  
{: codeblock}

![Icona riga di comando](../images/CommandLineIcon.png) _Riga di comando_

1.  Copia il seguente JSON di esempio in un file denominato `query3.dat`.
  ```json
  {
   "selector": {
      "age": {
         "$gt": 30
      },
      "lastname": {
         "$eq": "Greene"
      }
   },
    "fields": [
      "age",
      "firstname"
   ],
    "sort": [
      {
         "age": "asc"   
      }
   ],
   "use_index": "_design/partial-index"
  }
  ```
  {: codeblock}

2. Esegui questa query
  ```sh
  acurl https://$ACCOUNT.cloudant.com/query-demo/_find -X POST -H "Content-Type: application/json" -d \@query3.dat
  ```
  {: codeblock}

3.  Controlla i risultati della query:
  ```json
  {"docs":[
     {"age":35,"firstname":"Greg"},
     {"age":44,"firstname":"Anna"}
   ],
  "bookmark": "g1AAAABCeJzLYWBgYMpgSmHgKy5JLCrJTq2MT8lPzkzJBYqzAFkmIDkOmFwOSHWiDkiSzb0oNTUvNSsLAEsmEeQ"
  }
  ```
  {: codeblock}

![Icona Dashboard](../images/DashboardIcon.png) _Dashboard {{site.data.keyword.cloud_notm}}_

1.  Fai clic sulla scheda **Query**.
2.  Copia e incolla il seguente JSON di esempio nella finestra della query {{site.data.keyword.cloudant_short_notm}}:
  ```json
  {
   "selector": {
      "age": {
         "$gt": 30
      },
      "lastname": {
         "$eq": "Greene"
      }
   },
    "fields": [
      "age",
      "firstname"
   ],
    "sort": [
      {
         "age": "asc"   
      }
   ],
   "use_index": "_design/partial-index"
  }
  ```
  {: codeblock}

3.  Fai clic su **Run Query**.

  Vengono visualizzati i risultati della query. Puoi vederli dalla vista Table nella seguente acquisizione di schermo:

  ![Risultati query 3](../images/dashboard_query3_results.png)

Per ulteriori informazioni su {{site.data.keyword.cloudant_short_notm}}, consulta la [documentazione {{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant?topic=cloudant-overview#overview).
