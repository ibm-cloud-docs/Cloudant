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

# Prezzi
{: #pricing}

{{site.data.keyword.cloudantfull}} consente la regolazione per ampliare o ridurre la propria capacità produttiva fornita, che è un numero riservato di ricerche, scritture e query ogni secondo assegnato a un'istanza. Il livello di capacità produttiva è il livello di utilizzo massimo. Se provi a superare la capacità riservata, ottieni un codice di stato HTTP 429 che indica che l'applicazione sta provando a superare la sua franchigia di capacità produttiva fornita.


## Esempi di prezzi 
{: #pricing-examples}

Supponiamo che stai creando un'applicazione mobile con {{site.data.keyword.cloudant_short_notm}} e non conosci ancora la capacità di cui potresti avere bisogno. In questo caso, ti consigliamo di iniziare con la capacità produttiva fornita più bassa e aumentarla come richiesto dall'utilizzo della tua applicazione nel corso del tempo. {{site.data.keyword.cloudant_short_notm}} esegue una fatturazione a base proporzionale oraria e la modifica della capacità produttiva fornita non comporta tempi di inattività. 

Per l'esempio di applicazione mobile, inizi con una capacità produttiva minima per il piano Standard che è 100 ricerche/secondo, 50 scritture/secondo e 5 query/secondo. Il costo per questa capacità è  $0,105 all'ora. Le 100 ricerche/secondo, le 50 scritture/secondo e le 5 query/secondo sono un blocco di capacità produttiva fornita. Quando hai bisogno di ampliare (o ridurre), puoi farlo in incrementi di questi blocchi di capacità. Presumendo che l'istanza abbia meno dei 20 GB di archiviazione che sono inclusi nel piano Standard, non si incorre in alcun costo di archiviazione. Nella scheda
del Dashboard {{site.data.keyword.cloudant_short_notm}} > Account > Capacità, l'impostazione di capacità produttiva fornita si presenta simile a questa acquisizione di schermo:

![{{site.data.keyword.cloudant_short_notm}} - scheda Capacità del dashboard](../images/cloudant-dashboard.png)

Il dispositivo di scorrimento della capacità mostra il costo orario della capacità produttiva fornita di 100 ricerche/secondo, 50 scritture/secondo e 5 query/secondo in dollari statunitensi di $0,105/ora. Il dispositivo di scorrimento mostra un costo approssimativo al mese di $76,65. L'importo mensile è una stima basata su una media di 730 ore al mese. Il costo in qualsiasi mese più essere leggermente differente, a seconda del numero di ore nel mese.

Equazione di esempio: 

- $0,105 all'ora di 1 blocco di capacità produttiva fornita di 100 ricerche/secondo, 50 scritture/secondo e 5 query/secondo * 730 ore (ore approssimative in un mese)
- Totale = $76,65

Ricerche, scritture e query non possono essere ridimensionate indipendentemente. Utilizza il dispositivo di scorrimento per selezionare il numero di blocchi di capacità produttiva fornita in base al limite massimo di ricerche/secondo, scritture/secondo o query/secondo per la tua applicazione. Ad esempio, se la tua applicazione richiede 1.000 ricerche al secondo, utilizza il dispositivo di scorrimento per selezionare la capacità che offre 1000 ricerche/secondo, 500 scritture/secondo e 50 query/secondo, anche se non hai bisogno del numero corrispondente di scritture o query.

![{{site.data.keyword.cloudant_short_notm}} - scheda Capacità del dashboard con più capacità selezionata](../images/cloudant-gran-tuning.png)

Come stimare il costo totale per la capacità produttiva fornita al mese di 1.000 ricerche, 500 scritture e 50 query? 

- $0,105 all'ora di 10 blocchi di capacità produttiva fornita di 100 ricerche/secondo, 50 scritture/secondo e 5 query/secondo * 730 ore (ore approssimative in un mese)
- In alternativa, il dispositivo di scorrimento ti mostra che la capacità produttiva fornita di 1000 ricerche/secondo, 500 scritture/secondo e 50 query/secondo costa $1,050/ora * 730 ore
- Totale = $766,50

## Utilizzo dei dati 
{: #data-usage}

Come funzionano i prezzi per l'eccedenza dati?

Piano | Archiviazione inclusa | Limite eccedenza
-----|------------------|--------------
Lite | 1 GB |  Al tuo account non è consentito scrivere nuovi dati finché non elimini abbastanza dati da essere sotto al limite di 1 GB o esegui l'upgrade a un piano superiore.
Standard | 20 GB | Dell'archiviazione aggiuntiva costa $0,0014 per GB all'ora, che è circa $1/GB al mese.

Come vengono visualizzati i dati nel dashboard di utilizzo di {{site.data.keyword.cloud_notm}}?

Questa vista mostra i totali per l'utilizzo che sono maturati durante questo mese e, pertanto, mostra solo i costi per il mese fino a questo momento. Il totale stimato riflette la fattura fino a questo momento per il mese. Per la fine del mese, vedi la tua capacità media per il mese, che è la tua fattura mensile totale. Il campo `STORAGE_MANAGED_PER_MONTH` mostra solo la quantità superiore ai 20 GB inclusi; quindi, nel seguente esempio, vedi circa 40 GB di dati in totale nell'account.  

![{{site.data.keyword.cloudant_short_notm}} Vista delle metriche di utilizzo del dashboard con STORAGE_MANAGED_PER_MONTH più elevato](../images/usage-dashboard1.png)

Quando utilizzi meno di 20 GB di archiviazione, la visualizzazione mostra 0 GB poiché non hai superato il limite.
