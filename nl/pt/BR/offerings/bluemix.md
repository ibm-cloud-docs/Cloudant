---

copyright:
  years: 2015, 2018
lastupdated: "2018-06-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2018-06-05 -->

# {{site.data.keyword.Bluemix_notm}} Público
{: #ibm-cloud-public}

O {{site.data.keyword.cloudantfull}} Public é a oferta mais rica em recursos do {{site.data.keyword.cloudant_short_notm}},
recebendo atualizações e novos recursos primeiro. A precificação baseia-se em
seu rendimento e requisitos de armazenamento, tornando-a adequada para qualquer
carga necessária. 

O [plano Lite](#lite-plan) grátis inclui uma quantidade fixa de
capacidade de rendimento e dados para propósitos de desenvolvimento e avaliação. O [plano Standard](#standard-plan) pago oferece capacidade de rendimento
provisionada configurável e precificação de armazenamento de dados que escala à medida que os requisitos de seu aplicativo
mudam. Um [plano Hardware dedicado](#dedicated-hardware-plan) opcional também está disponível por uma
taxa mensal adicional para executar uma ou mais de suas instâncias do plano Padrão
em um ambiente de hardware dedicado. O ambiente de hardware dedicado
é para seu uso exclusivo e, se uma instância do plano Dedicated
Hardware for provisionada
dentro de um local dos EUA, será possível selecionar opcionalmente uma configuração compatível com o [HIPAA ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){:new_window}.

A tabela a seguir resume a capacidade de rendimento provisionada e
a configuração de espaço em disco para o plano Lite e alguns exemplos
para o plano Standard:

<div id="maxtable"></div>

<table border='1'>

<tr>
<th id="plans">Planos</th><th id="lite">Lite</th><th id="standard" colspan='4'>Padrão</th>
</tr>
<tr>
<th id="base-priceperhour" headers="plans">Preço base (por hora)</td>
<td headers="lite base-priceperhour">US$ 0,00</td>
<td headers="standard base-priceperhour" colspan='4'>Consulte <a href="../offerings/pricing.html#pricing" target="_blank">detalhes de precificação <img src="../images/launch-glyph.svg" alt="Ícone de link externo" title="Ícone de link externo"></a>.</td>
</tr>
<tr>
<th id="provisionedthroughputcapacity-lookupspersecond" headers="plans">Capacidade de rendimento provisionado (Consultas por segundo)</td>
<td headers="lite provisionedthroughputcapacity-lookupspersecond-lite">20</td>
<td headers="standard provisionedthroughputcapacity-lookupspersecond">100</td>
<td headers="standard provisionedthroughputcapacity-lookupspersecond">1.000</td>
<td headers="standard provisionedthroughputcapacity-lookupspersecond">5.000</td>
<td headers="standard provisionedthroughputcapacity-lookupspersecond">20.000</td>
</tr>
<tr>
<th id="provisionedthroughputcapacity-writespersecond" headers="plans">Capacidade de rendimento provisionado (Gravações por segundo)</td>
<td headers="lite provisionedthroughputcapacity-writespersecond">10</td>
<td headers="standard provisionedthroughputcapacity-writespersecond">50</td>
<td headers="standard provisionedthroughputcapacity-writespersecond">500</td>
<td headers="standard provisionedthroughputcapacity-writespersecond">2.500</td>
<td headers="standard provisionedthroughputcapacity-writespersecond">10.000</td>
</tr>
<tr>
<th id="provisionedthroughputcapacity-queriespersecond" headers="plans">Capacidade de rendimento provisionado (Consultas por segundo)</td>
<td headers="lite provisionedthroughputcapacity-queriespersecond">5</td>
<td headers="standard provisionedthroughputcapacity-queriespersecond">5</td>
<td headers="standard provisionedthroughputcapacity-queriespersecond">50</td>
<td headers="standard provisionedthroughputcapacity-queriespersecond">250</td>
<td headers="standard provisionedthroughputcapacity-queriespersecond">1.000</td>
</tr>
<tr>
<th headers="diskspaceincluded" headers="plans">Espaço em disco incluído</td>
<td headers="lite diskspaceincluded">1 GB</td>
<td headers="standard diskspaceincluded" colspan='4'>20 GB</td>
</tr>
<tr>
<th headers="diskoveragepergbhour" headers="plans">Disco excedente (por GB/hora)</td>
<td headers="lite diskoveragepergbhour">Não está disponível</td>
<td headers="standard diskoveragepergbhour" colspan='4'>Consulte <a href="../offerings/pricing.html#pricing" target="_blank">detalhes de precificação <img src="../images/launch-glyph.svg" alt="Ícone de link externo" title="Ícone de link externo"></a>.</td>
</tr>

</table>

## Planos
{: #plans}

É possível selecionar qual plano usar ao
[provisionar sua instância de serviço do {{site.data.keyword.cloudant_short_notm}}](#provisioning-a-cloudant-instance-on-bluemix).
Por padrão,
o [plano Lite](#lite-plan) é selecionado.

![{{site.data.keyword.cloudant_short_notm}} seleção de plano da instância de serviço](../images/fb87416a.png)

### Plano Lite
{: #lite-plan}

O plano Lite é grátis,
mas limita a um máximo de 1 GB de armazenamento de dados.
Os limites também se aplicam à capacidade de rendimento provisionado para pesquisas,
gravações e consultas. 

O uso de armazenamento é verificado diariamente. Se você exceder seu limite de armazenamento, as solicitações de HTTP para a conta receberão um
código de status 402 com a mensagem de erro "A conta excedeu sua cota de uso de dados. Será necessário fazer upgrade para um plano pago".
Um banner também aparece no painel do {{site.data.keyword.cloudant_short_notm}} para informá-lo. Ainda será possível ler e excluir dados. No entanto, para gravar novos dados,
deve-se fazer upgrade para uma conta paga ou excluir dados e aguardar até que a próxima verificação seja executada para sua conta ser reativada. 

Se você quiser armazenar mais de um GB de dados
ou ter uma capacidade de rendimento maior,
mova para o [plano Padrão](#standard-plan).

### Plano padrão
{: #standard-plan}

O plano Padrão inclui 20 GB de armazenamento de dados.
Se você armazenar mais de 20 GB,
será cobrado um custo definido por GB por hora.
Consulte as informações de [precificação](../offerings/pricing.html#pricing){:new_window} para o custo atual.
No plano Padrão,
também será possível mudar a quantia de capacidade de rendimento provisionado para pesquisas,
gravações
e consultas.

### Plano de hardware dedicado
{: #dedicated-hardware-plan}

Como alternativa, é possível executar suas instâncias do plano Standard em um ambiente de hardware dedicado
em qualquer data center [{{site.data.keyword.IBM}} ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/cloud-computing/bluemix/data-centers)
para uma taxa mensal. Você compra um único plano de hardware dedicado para um local específico
e pode provisionar uma ou mais instâncias do plano Standard nele. Esse plano é necessário para
conformidade com HIPAA e deve ser selecionado no tempo de fornecimento. 

O plano Dedicated
Hardware não está disponível para clientes do {{site.data.keyword.Bluemix_notm}} Dedicated e está disponível apenas para clientes do {{site.data.keyword.Bluemix_notm}} Public.
{: tip}

## Capacidade de rendimento provisionada
{: #provisioned-throughput-capacity}

A provisão de rendimento é identificada e medida como um dos tipos de eventos a seguir:

1.	Uma consulta,
que é uma leitura de um documento específico,
com base no `_id` do documento.
2.	Uma gravação,
que é a criação,
a modificação
ou a exclusão de um documento individual
ou qualquer atualização devido a uma construção de índice.
3.	Uma consulta,
    que é uma solicitação que é feita para um dos terminais de consulta do {{site.data.keyword.cloudant_short_notm}},
    incluindo os tipos a seguir:
	-	Índice primário ([`_all_docs`](../api/database.html#get-documents))
	-	Visualização MapReduce ([`_view`](../api/creating_views.html#using-views))
	-	Índice de procura ([`_search`](../api/search.html#queries))
	-	Índice geoespacial ([`_geo`](../api/cloudant-geo.html#querying-a-cloudant-geo-index))
	-	{{site.data.keyword.cloudant_short_notm}} Query ([`_find`](../api/cloudant_query.html#finding-documents-using-an-index))

A medida de rendimento é uma contagem simples do número de eventos de cada tipo,
por segundo,
em que o segundo é uma janela _deslizante_.
Se a sua conta exceder o número de eventos de rendimento provisionados para o plano,
as solicitações serão rejeitadas até que o número de eventos dentro da janela deslizante
não mais exceda o número provisionado.
Pode ajudar a pensar na janela deslizante de 1 segundo como sendo qualquer período consecutivo de 1.000 milissegundos.

Por exemplo, o plano Standard é provisionado para 200 consultas por segundo. Sua conta pode ter um máximo de 200 solicitações de consulta durante um período consecutivo de 1.000 milissegundos (1 segundo). As solicitações subsequentes de consultas feitas durante o período deslizante de 1.000 milissegundos
serão rejeitadas até que o número de solicitações de consultas nesse período caia para menos de 200 novamente.

Quando uma solicitação é rejeitada porque o número de eventos foi excedido,
os aplicativos recebem uma resposta [`429` Muitas solicitações](../api/http.html#429).

As versões recentes das bibliotecas de clientes suportados (para as linguagens [Java](../libraries/supported.html#java),
[Node.js](../libraries/supported.html#node-js)
e [Python](../libraries/supported.html#python)) ajudam a manipular uma resposta `429`.
Por exemplo,
a biblioteca Java gera uma resposta
[`TooManyRequestsException` ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://static.javadoc.io/com.cloudant/cloudant-client/2.5.1/com/cloudant/client/org/lightcouch/TooManyRequestsException.html){:new_window}.

Por padrão,
as bibliotecas de clientes suportados não tentarão novamente uma solicitação
automaticamente quando uma resposta `429` for recebida.

É melhor assegurar-se de que seu aplicativo manipule respostas `429` corretamente.
O motivo é que o número de novas tentativas é limitado;
transgredir regularmente o número de solicitações é um forte indicador
para mover para uma configuração de plano diferente.

Se você estiver transportando um aplicativo existente, ele poderá não ser capaz de lidar com uma resposta `429`. Como parte de sua verificação de migração,
verifique se o seu aplicativo manipula respostas `429` corretamente.
{: tip}

Em resumo,
deve-se assegurar que seu aplicativo seja capaz de manipular uma resposta [`429`](../api/http.html#429) corretamente.

<div id="servicetier"></div>

### Visualizando e mudando a capacidade
{: #viewing-and-changing-capacity}

É possível ver detalhes da capacidade de rendimento nos planos disponíveis para sua conta.
É possível selecionar o nível de fornecimento que você deseja usar
por meio da guia Conta do Painel de sua conta do {{site.data.keyword.cloudant_short_notm}}.

![Painel da Conta](../images/cloudant_capacity.png)

Para mover para uma capacidade de rendimento diferente, selecione o fornecimento
desejado e, em seguida, clique em `Atualizar`. Você é solicitado a confirmar a mudança
e lembrado de que a mudança de fornecimento pode levar até 24 horas para ser concluída.

![Painel da Conta](../images/cloudant_capacity_change.png)

<div id="throughput"></div>

### Monitorando o uso 
{: #monitoring-usage}

As informações sobre seu uso estão disponíveis na área de janela Operações atuais da guia Monitoramento no Painel do {{site.data.keyword.cloudant_short_notm}}. 

![Monitorando o uso no painel](../images/cloudant_usage.png)

Os detalhes são fornecidos lá,
ilustrando seu [rendimento](#provisioned-throughput-capacity) atual
e a quantidade de [dados armazenados](#disk-space-included).

O monitoramento ajuda a reconhecer que uma mudança no fornecimento em seu plano pode ser aconselhável.
Por exemplo,
se você frequentemente aproximar o número máximo de consultas de banco de dados,
será possível modificar o fornecimento por meio da [área de janela Serviço](#servicetier) na guia Conta do Painel.

## Uso de dados
{: #data-usage}

### Espaço em disco incluído
{: #disk-space-included}

Esse valor é a capacidade de armazenamento que é incluída no plano.
Ele é usado para o armazenamento de dados e de índice.

### Excedente de disco
{: #disk-overage}

Todas as instâncias de serviço dos planos Padrão e Lite são monitoradas para espaço usado em disco.
Se a conta usar mais que a quantia de armazenamento fornecida na configuração do plano,
ela será considerada como 'estouro'.
O estouro faz com que a conta seja faturada pelo preço indicado para cada GB extra usado além da alocação do plano.

A quantia extra de dinheiro que deve-se pagar por usar mais espaço em disco do que é fornecido no plano é chamado um 'excedente'.
O excedente é calculado de hora em hora.
Não é possível estourar o espaço em disco disponível no plano Lite.

Por exemplo,
suponha que sua instância de plano Padrão aumente o uso de disco para 107 GB por meio dia (12 horas).
Essa mudança significa que sua instância causou um estouro de 87 GB além da alocação do plano de 20 GB,
por 12 horas.
Portanto,
você será faturado por uma cobrança excedente com base em 87 GB x 12 horas = 1.044 GB de horas para esse espaço extra.

O excedente é calculado usando o número máximo de GB além da alocação do plano durante uma hora específica dentro do ciclo de faturamento.

### Exemplo de excedente de disco
{: #disk-overage-example}

Suponha que você inicie um mês de 30 dias com uma instância de serviço do plano Padrão que use 9 GB de armazenamento.
Em seguida,
seu armazenamento aumenta para 21,5 GB por 15 minutos durante a hora, iniciando às 2h do dia 3.
A instância cai de volta para 9,5 GB pelos próximos 10 minutos da hora 2h
e, em seguida, aumenta para 108 GB pelos próximos 25 minutos da hora 2h.
Finalmente,
sua instância conclui a hora e certamente o restante do mês, caindo para 28 GB.

Esse padrão significa que o número máximo de GB além da alocação do plano era 88 GB durante a hora 2 do dia 3.
Para a hora 3h do dia 3
e para o resto do mês,
sua instância era de 8 GB além da alocação do plano.

Portanto,
para a hora 2h do dia 3,
a sua conta incluirá um excedente com base em 88 GB x 1 hora = 88 GB horas.

Para a hora 3h do dia 3 até o final do dia 3,
sua conta incluirá um excedente com base em 8 GB x 21 horas = 168 GB horas.

Para a hora 0h do dia 4 até o final do mês (de 30 dias),
sua conta incluirá um excedente com base em 8 GB x 24 horas x 27 dias = 5184 GB horas.

A conta do excedente total para o mês é baseada em um total de 88 + 168 + 5184 = 5440 GB horas.

## Limites de solicitação e de tamanho do documento
{: #request-and-document-size-limits}

Os documentos e solicitações JSON do {{site.data.keyword.cloudant_short_notm}} têm os
limites de tamanho máximo a seguir: 

Limite | Tamanho Máximo
------|-------------
Tamanho do Documento Individual | 1 MB
Tamanho de Conexão Única | 10 MB
Tamanho do Corpo da Solicitação | 11 MB

Exceder qualquer um desses limites resulta em uma [resposta 413](../api/http.html#413).

É recomendado que você armazene anexos binários, ou blobs JSON grandes,
no armazenamento de objetos e salve um link para o local em um documento JSON do {{site.data.keyword.cloudant_short_notm}}.   

Ao replicar, documentos ou anexos maiores do que esses limites não serão
replicados para o banco de dados de destino. Mais informações sobre como detectar erros de
replicação estão disponíveis [aqui](../api/replication.html#replication-errors).

## Locais e ocupação
{: #locations-and-tenancy}

Por padrão, todos os planos Lite e Padrão são implementados em ambientes de
diversos locatários. Como parte da seleção de seu plano,
é possível escolher entre as regiões do {{site.data.keyword.Bluemix_notm}} Public a seguir:

-   USEast
-   Sul dos EUA
-   Reino Unido
-   Sydney
-   Alemanha&Dagger;

As instâncias do plano Hardware dedicado podem ser implementadas na maioria
dos [locais de data center do {{site.data.keyword.IBM_notm}} ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/cloud-computing/bluemix/data-centers). 
Consulte o menu suspenso no catálogo do {{site.data.keyword.Bluemix_notm}} para uma lista atualizada de locais disponíveis.

&Dagger;Todas as instâncias do {{site.data.keyword.cloudant_short_notm}} que são implementadas por meio da
região Alemanha do {{site.data.keyword.Bluemix_notm}} Public
são implementadas em ambientes gerenciados pela UE. Não se pode conceder acesso a uma instância do
{{site.data.keyword.cloudant_short_notm}} gerenciada pela UE a qualquer conta ou chave API do {{site.data.keyword.cloudant_short_notm}}
que é gerada fora de um ambiente gerenciado pela UE.

## Segurança, criptografia e conformidade
{: #security-encryption-and-compliance}

Todos os planos são fornecidos em servidores com
criptografia de disco [inativa ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://en.wikipedia.org/wiki/Data_at_rest){:new_window}.
O acesso é criptografado por meio de uma conexão de rede usando HTTPS.
Para obter mais detalhes,
veja [Segurança do {{site.data.keyword.Bluemix_notm}} ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://console.bluemix.net/docs/services/Cloudant/offerings/security.html#security){:new_window}.

Os planos também oferecem
[Certificação de conformidade de segurança ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://cloudant.com/product/cloudant-features/cloudant-compliance/){:new_window}.
A conformidade [HIPAA ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){:new_window}
requer um [ambiente Dedicado](#dedicated-hardware-plan),
portanto, solicite esse ambiente como parte do [processo de fornecimento](#provisioning-a-cloudant-instance-on-bluemix).

<div id="byok"></div>

Se você precisar trazer sua própria chave (BYOK) para criptografia inativa, essa criptografia será ativada usando o
{{site.data.keyword.cloud}} Key Protect. O {{site.data.keyword.cloudant_short_notm}} suporta esse recurso para novas instâncias do {{site.data.keyword.cloudant_short_notm}}
[plano Dedicated
Hardware](https://console.bluemix.net/docs/services/Cloudant/offerings/bluemix.html#ibm-cloud-public)
que são implementadas em todas as regiões. Primeiro, crie uma instância do plano Dedicated
Hardware usando o catálogo do [{{site.data.keyword.cloud_notm}}](https://console.bluemix.net/catalog/). Em seguida, envie
um chamado de suporte, e nossa equipe de suporte coordenará obtendo as chaves de criptografia inativa de sua nova instância
do Dedicated
Hardware que são gerenciadas por sua instância do Key Protect.

## Alta disponibilidade, recuperação de desastre e backup
{: #high-availability-disaster-recovery-and-backup}

Para fornecer alta disponibilidade (HA) e recuperação de desastre (DR) em um data center, todos os dados são armazenados em triplicidade em três servidores físicos separados em um cluster. É possível provisionar contas em múltiplos data centers
e, em seguida, usar a replicação de dados contínua para fornecer HA/DR nos data centers. Os dados do {{site.data.keyword.cloudant_short_notm}} não são submetidos a backup automaticamente, mas as ferramentas suportadas são  
fornecidas para manipular backups. Revise o
[guia de Recuperação de desastre e backup ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://console.bluemix.net/docs/services/Cloudant/guides/disaster-recovery-and-backup.html#disaster-recovery-and-backup)
para explorar todas as considerações sobre HA, DR e backup para atender aos seus requisitos de aplicativo. 

## Suporte
{: #support}

O suporte para as instâncias de serviço dos planos Padrão e Dedicado é opcional.
Ele é fornecido comprando o "Suporte padrão do {{site.data.keyword.Bluemix}}".
O suporte não está disponível para o plano Lite.

Uma calculadora de precificação para o suporte Padrão do {{site.data.keyword.Bluemix_notm}} está disponível
[aqui ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://console.ng.bluemix.net/?direct=classic/#/pricing/cloudOEPaneId=pricing&paneId=pricingSheet){:new_window}.
Informações sobre os detalhes do Acordo de Nível de Serviço (SLA) do Suporte estão disponíveis
[aqui ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://www-03.ibm.com/software/sla/sladb.nsf/pdf/6606-08/$file/i126-6606-08_05-2016_en_US.pdf){:new_window}.

## Fornecendo uma instância do {{site.data.keyword.cloudant_short_notm}} no {{site.data.keyword.Bluemix_notm}}
{: #provisioning-a-cloudant-nosql-db-instance-on-ibm-cloud}

É possível provisionar uma instância do plano Lite ou Standard do {{site.data.keyword.cloudant_short_notm}} no {{site.data.keyword.Bluemix}} de duas maneiras:

- Usando o Painel. Um tutorial que descreve o processo está disponível [aqui ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://console.bluemix.net/docs/services/Cloudant/tutorials/create_service.html#creating-a-cloudant-instance-on-bluemix){:new_window}.
- Usando a ferramenta de comando do Cloud Foundry. Um tutorial que descreve o processo está disponível [aqui ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://console.bluemix.net/docs/services/Cloudant/tutorials/create_service_cli.html#creating-a-cloudant-instance-on-bluemix-using-the-cloud-foundry-tools){:new_window}.
 
Para criar e alavancar uma instância do plano Dedicated
Hardware do {{site.data.keyword.cloudant_short_notm}}, siga o tutorial que descreve o processo [aqui ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://console.bluemix.net/docs/services/Cloudant/tutorials/create_dedicated_hardware_plan.html#creating-and-leveraging-a-cloudant-dedicated-hardware-plan-instance-on-bluemix){:new_window}.




