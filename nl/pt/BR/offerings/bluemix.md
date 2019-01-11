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

# {{site.data.keyword.cloud_notm}} Público
{: #ibm-cloud-public}

O {{site.data.keyword.cloudantfull}} Public é a oferta mais rica em recursos do {{site.data.keyword.cloudant_short_notm}},
recebendo atualizações e novos recursos primeiro. A precificação baseia-se em
seu rendimento e requisitos de armazenamento, tornando-a adequada para qualquer
carga necessária. 

O [plano Lite](#lite-plan) grátis inclui uma quantidade fixa de
capacidade de rendimento e dados para propósitos de desenvolvimento e avaliação. O [plano Standard](#standard-plan) pago oferece capacidade de rendimento
provisionada configurável e precificação de armazenamento de dados que escala à medida que os requisitos de seu aplicativo
mudam.  Um [plano Hardware dedicado](#dedicated-hardware-plan) opcional também está disponível por uma
taxa mensal adicional para executar uma ou mais de suas instâncias do plano Padrão
em um ambiente de hardware dedicado. O ambiente de hardware dedicado
é para seu uso exclusivo e, se uma instância do plano Dedicated
Hardware for provisionada
dentro de um local dos EUA, será possível selecionar opcionalmente uma configuração compatível com o [HIPAA ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){:new_window}.

A tabela a seguir resume a capacidade de rendimento provisionada e
a configuração de espaço em disco para o plano Lite e alguns exemplos
para o plano Standard:

<div id="maxtable"></div>

<table>

<tr>
<th id="capacity-config-plan">Plano</th><th id="lite">Lite</th><th id="standard" colspan='4'>Padrão</th>
</tr>
<tr>
<th id="base-priceperhour" headers="capacity-config-plan">Preço base (por hora)</td>
<td headers="lite base-priceperhour">US$ 0,00</td>
<td headers="standard base-priceperhour" colspan='4'>Consulte <a href="../offerings/pricing.html#pricing" target="_blank">detalhes de precificação <img src="../images/launch-glyph.svg" alt="Ícone de link externo" title="Ícone de link externo"></a>.</td>
</tr>
<tr>
<th id="provisionedthroughputcapacity-lookupspersecond" headers="capacity-config-plan">Capacidade de rendimento provisionado (Consultas por segundo)</td>
<td headers="lite provisionedthroughputcapacity-lookupspersecond-lite">20</td>
<td headers="standard provisionedthroughputcapacity-lookupspersecond">100</td>
<td headers="standard provisionedthroughputcapacity-lookupspersecond">1.000</td>
<td headers="standard provisionedthroughputcapacity-lookupspersecond">5.000</td>
<td headers="standard provisionedthroughputcapacity-lookupspersecond">20.000</td>
</tr>
<tr>
<th id="provisionedthroughputcapacity-writespersecond" headers="capacity-config-plan">Capacidade de rendimento provisionado (Gravações por segundo)</td>
<td headers="lite provisionedthroughputcapacity-writespersecond">10</td>
<td headers="standard provisionedthroughputcapacity-writespersecond">50</td>
<td headers="standard provisionedthroughputcapacity-writespersecond">500</td>
<td headers="standard provisionedthroughputcapacity-writespersecond">2.500</td>
<td headers="standard provisionedthroughputcapacity-writespersecond">10.000</td>
</tr>
<tr>
<th id="provisionedthroughputcapacity-queriespersecond" headers="capacity-config-plan">Capacidade de rendimento provisionado (Consultas por segundo)</td>
<td headers="lite provisionedthroughputcapacity-queriespersecond">5</td>
<td headers="standard provisionedthroughputcapacity-queriespersecond">5</td>
<td headers="standard provisionedthroughputcapacity-queriespersecond">50</td>
<td headers="standard provisionedthroughputcapacity-queriespersecond">250</td>
<td headers="standard provisionedthroughputcapacity-queriespersecond">1.000</td>
</tr>
<tr>
<th id="diskspaceincluded" headers="capacity-config-plan">Espaço em disco incluído</td>
<td headers="lite diskspaceincluded">1 GB</td>
<td headers="standard diskspaceincluded" colspan='4'>20 GB</td>
</tr>
<tr>
<th id="diskoveragepergbhour" headers="capacity-config-plan">Disco excedente (por GB/hora)</td>
<td headers="lite diskoveragepergbhour">Não está disponível</td>
<td headers="standard diskoveragepergbhour" colspan='4'>Consulte <a href="../offerings/pricing.html#pricing" target="_blank">detalhes de precificação <img src="../images/launch-glyph.svg" alt="Ícone de link externo" title="Ícone de link externo"></a>.</td>
</tr>

</table>

## Planos
{: #plans}

É possível selecionar qual plano usar quando você [fornece sua instância de serviço do {{site.data.keyword.cloudant_short_notm}}](#provisioning-a-cloudant-nosql-db-instance-on-ibm-cloud).
Por padrão,
o [plano Lite](#lite-plan) é selecionado.

![{{site.data.keyword.cloudant_short_notm}} seleção de plano da instância de serviço](../images/lite_pricing_plan.png)

### Plano Lite
{: #lite-plan}

O plano Lite é gratuito e é projetado para propósitos de desenvolvimento e avaliação. A funcionalidade completa do {{site.data.keyword.cloudant_short_notm}} está incluída, mas as instâncias de plano Lite possuem uma quantia fixa de capacidade de rendimento provisionada e armazenamento de dados. A capacidade de rendimento provisionada é fixada em 20 consultas/s, 10 gravações/s e 5 consultas/s e o armazenamento de dados é limitado em 1 GB. 

O uso de armazenamento é verificado diariamente. Se você exceder seu limite de armazenamento de 1 GB, as solicitações para a instância do {{site.data.keyword.cloudant_short_notm}} receberão um código de status 402 com a mensagem de erro "A conta excedeu sua cota de uso de dados. Será necessário fazer upgrade para um plano pago".
Um banner também aparecerá no Painel do {{site.data.keyword.cloudant_short_notm}}. Ainda será possível ler e excluir dados. No entanto, para gravar novos dados, você tem duas opções. Primeiro, é possível fazer upgrade para um [plano Padrão](#standard-plan) pago que remove a limitação de gravação imediatamente. Como alternativa, é possível excluir dados para que o armazenamento total seja classificado abaixo do limite de 1 GB e aguarde até que a próxima verificação de armazenamento diária seja executada para que sua instância permita gravações novamente. 

Se desejar armazenar mais de 1 GB de dados ou ser capaz de escalar a capacidade de rendimento provisionada, mude para o [plano Padrão](#standard-plan).

Você está limitado a uma instância de plano {{site.data.keyword.cloudant_short_notm}} Lite por conta {{site.data.keyword.cloud_notm}}. Se você já tiver uma instância do plano Lite, qualquer tentativa de criar uma nova instância do plano Lite ou de mudar uma instância do plano Padrão para um plano Lite retornará a mensagem "Só é possível ter uma instância de um plano Lite por serviço. Para criar uma nova instância, exclua a instância do plano de Lite existente ou selecione um plano pago."
{: tip}

### Plano padrão
{: #standard-plan}

O plano {{site.data.keyword.cloudant_short_notm}} Padrão está disponível para todas as contas pagas do {{site.data.keyword.cloud}}, como pagar por uso ou assinatura e é escalado para atender às necessidades de seu aplicativo. O plano Padrão é precificado com base em dois fatores: a capacidade de rendimento provisionada que é alocada e a quantidade de dados que são armazenados na instância. 

A precificação é rateada de hora em hora com uma capacidade de rendimento provisionada inicial de 100 consultas/s, 50 gravações/s e 5 consultas/s iguais a um custo inicial de 0,105 USD/hora. É possível alternar a capacidade de rendimento provisionada para cima ou para baixo em incrementos de 100 consultas/s, 50 gravações/s e 5 consultas/s no Painel do {{site.data.keyword.cloudant_short_notm}}. Os custos são calculados para a capacidade de rendimento provisionada que está alocada e não no volume medido de solicitações. O plano Padrão inclui 20 GB de armazenamento de dados. Se você armazenar mais de 20 GB,
será cobrado um custo definido por GB por hora. 

Consulte a Calculadora de precificação {{site.data.keyword.cloud_notm}} para precificação em diferentes capacidades e moedas e as informações de [precificação](../offerings/pricing.html#pricing){:new_window} para obter exemplos para estimar custos.

### Plano de hardware dedicado
{: #dedicated-hardware-plan}

Uma instância de plano de Hardware dedicado do {{site.data.keyword.cloudant_short_notm}} é um ambiente {{site.data.keyword.cloudant_short_notm}} bare metal que é provisionado para o uso exclusivo de suas instâncias de plano {{site.data.keyword.cloudant_short_notm}} Padrão. Um ambiente de plano de Hardware dedicado do {{site.data.keyword.cloudant_short_notm}} pode ser provisionado em qualquer data center [{{site.data.keyword.IBM}} ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/cloud-computing/bluemix/data-centers). Esse plano é necessário para
conformidade com HIPAA e deve ser selecionado no tempo de fornecimento. Além disso, os usuários de um ambiente do plano de Hardware dedicado do {{site.data.keyword.cloudant_short_notm}} podem empregar chaves de criptografia gerenciadas pelo cliente da lista de desbloqueio de IP e de bring-your-own-key (BYOK) com o IBM Key Protect. 

É possível fornecer uma ou mais instâncias de plano Padrão e o ambiente de Hardware dedicado é expandido ou diminuído conforme necessário com base na capacidade e nos dados que são usados pelas instâncias de plano Padrão. É um preço fixo complementar para a precificação de consumo de instâncias do plano {{site.data.keyword.cloudant_short_notm}} Padrão. O faturamento é rateado diariamente e há uma duração mínima de 1 mês a ser cobrada pelo ambiente. O fornecimento de um plano de Hardware dedicado do {{site.data.keyword.cloudant_short_notm}} é assíncrono e pode levar de 5 a 7 dias úteis. Para criar uma instância de plano de Hardware dedicado do {{site.data.keyword.cloudant_short_notm}} e provisionar uma instância de plano Padrão nela, siga o tutorial [Criando e aproveitando uma instância de plano de Hardware dedicado do {{site.data.keyword.cloudant_short_notm}} no {{site.data.keyword.cloud_notm}} ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](../tutorials/create_dedicated_hardware_plan.html#creating-and-leveraging-a-cloudant-dedicated-hardware-plan-instance-on-bluemix){:new_window}. 

O plano de Hardware dedicado não está disponível para clientes do {{site.data.keyword.cloud_notm}} Dedicated. O plano de Hardware dedicado só está disponível para clientes do {{site.data.keyword.cloud_notm}} Public.
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
É possível selecionar o nível de fornecimento que você deseja usar, por meio da guia Conta de seu painel de conta {{site.data.keyword.cloudant_short_notm}}.

![Account dashboard](../images/cloudant_capacity.png)

Para mover para uma capacidade de rendimento diferente, selecione o fornecimento
desejado e, em seguida, clique em `Atualizar`. Você é solicitado a confirmar a mudança
e lembrado de que a mudança de fornecimento pode levar até 24 horas para ser concluída.

![Account dashboard](../images/cloudant_capacity_change.png)

O tamanho do aumento de capacidade é limitado a 10 unidades (1000 consultas/segundo, 500 gravações/segundo e 50 consultas/segundo) por mudança. As diminuições não são limitadas pelo número de unidades. Qualquer mudança de capacidade, um aumento ou uma diminuição, é limitada a uma vez por hora. Se você precisar de mais capacidade do que está disponível no painel do {{site.data.keyword.cloudant_short_notm}}, entre em contato com o [suporte do {{site.data.keyword.cloudant_short_notm}}![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](mailto:support@cloudant.com){:new_window}.
{: tip}

<div id="throughput"></div>

### Monitorando o uso 
{: #monitoring-usage}

As informações sobre seu uso estão disponíveis na área de janela Operações atuais da guia Monitoramento no painel do {{site.data.keyword.cloudant_short_notm}}. 

![Monitorando o uso no painel](../images/cloudant_usage.png)

Os detalhes são fornecidos lá,
ilustrando seu [rendimento](#provisioned-throughput-capacity) atual
e a quantidade de [dados armazenados](#disk-space-included).

O monitoramento ajuda a reconhecer que uma mudança no fornecimento em seu plano pode ser aconselhável.
Por exemplo, se você atingir frequentemente o número máximo de consultas do banco de dados, será possível modificar o fornecimento por meio da [Área de janela de serviço](#servicetier) na guia Conta do painel.

## Uso de dados
{: #data-usage}

### Espaço em disco incluído
{: #disk-space-included}

Esse valor é a capacidade de armazenamento que é incluída no plano.
Ele é usado para o armazenamento de dados e de índice.

### Excedente de disco
{: #disk-overage}

Todos os planos Padrão e Lite incluem espaço em disco, que é usado para dados JSON, anexos e índices. Todos os planos Padrão e Lite são monitorados para o espaço em disco usado. Quando você usa mais dados do que o plano aloca, é possível esperar que as condições descritas na tabela a seguir se apliquem:

<table>

<tr>
<th id="disk-overage-plan">Plano</th><th id="description">Descrição</th>
</tr>
<tr>
<th headers="standard-plan">Padrão</td>
<td headers="description"><p>
<ul><li>Se a conta usar mais do que a quantidade de armazenamento que é alocada em sua configuração de plano, ela será considerada como 'estouro'. O estouro faz com que a conta seja faturada pelo preço indicado para cada GB extra usado além da alocação do plano.</li>
<li>O dinheiro extra que deve ser pago, para usar mais espaço em disco do que o fornecido no plano, é chamado de 'excedente'. Um excedente é calculado de hora em hora.</li></ul></p></td>
</tr>
<tr>
<th headers="lite-plan">Lite</td>
<td headers="description"><p>
<ul><li>O uso do disco é limitado no plano Lite. Depois de atingir o limite, não é possível gravar novos dados. Para gravar novos dados, deve-se fazer upgrade para o plano Padrão ou excluir dados e aguardar até que a próxima verificação seja executada para que sua conta seja reativada.</p>
</li></ul></td>
</tr>
</table>

Por exemplo, suponha que seu plano Padrão aumente o uso de disco para 107 GB por meio dia (12 horas). Essa mudança significa que sua instância causou um estouro de 87 GB além da alocação do plano de 20 GB,
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
é possível escolher entre as regiões do {{site.data.keyword.cloud_notm}} Public a seguir:

-   USEast
-   Sul dos EUA
-   Reino Unido
-   Sydney
-   Alemanha&Dagger;
-   AP Norte (Tóquio)

As instâncias do plano Hardware dedicado podem ser implementadas na maioria
dos [locais de data center do {{site.data.keyword.IBM_notm}} ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/cloud-computing/bluemix/data-centers). 
Consulte o menu suspenso no catálogo do {{site.data.keyword.cloud_notm}} para uma lista atualizada de locais disponíveis.

&Dagger;Todas as instâncias do {{site.data.keyword.cloudant_short_notm}} que são implementadas por meio da
região Alemanha do {{site.data.keyword.cloud_notm}} Public
são implementadas em ambientes gerenciados pela UE. Não se pode conceder acesso a uma instância do
{{site.data.keyword.cloudant_short_notm}} gerenciada pela UE a qualquer conta ou chave de API do {{site.data.keyword.cloudant_short_notm}}
que é gerada fora de um ambiente gerenciado pela UE.

## Métodos de Autenticação
{: #authentication-methods}

O {{site.data.keyword.cloudant_short_notm}} é acessado usando uma API HTTPS. No local que o terminal da API requerer, o usuário será autenticado para cada pedido de HTTPS que o {{site.data.keyword.cloudant_short_notm}} receber. Durante o fornecimento, os métodos de autenticação disponíveis incluem 'Usar as credenciais anteriores e o IAM' ou 'Usar apenas o IAM'. Para obter mais informações, consulte o [Guia do IAM](../guides/iam.html){:new_window} ou o [Documento da API de autenticação](../api/authentication.html){:new_window} anterior.

Após o fornecimento de uma instância do {{site.data.keyword.cloudant_short_notm}}, a URL de conexão e os detalhes de autorização do IAM podem ser localizados ao gerar novas credenciais na guia Credenciais de serviço do painel do {{site.data.keyword.cloud_notm}}. Se você escolher esta opção durante o fornecimento, o nome do usuário e senha anteriores do {{site.data.keyword.cloudant_short_notm}} também serão incluídos.


## Alta disponibilidade, recuperação de desastre e backup
{: #high-availability-disaster-recovery-and-backup}

Para fornecer alta disponibilidade (HA) e recuperação de desastre (DR) em um data center, todos os dados são armazenados em triplicidade em três servidores físicos separados em um cluster. É possível provisionar contas em múltiplos data centers
e, em seguida, usar a replicação de dados contínua para fornecer HA/DR nos data centers. Os dados do {{site.data.keyword.cloudant_short_notm}} não são submetidos a backup automaticamente, mas as ferramentas suportadas são fornecidas para manipular backups. Revise o
[guia de Recuperação de desastre e backup ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://console.bluemix.net/docs/services/Cloudant/guides/disaster-recovery-and-backup.html#disaster-recovery-and-backup)
para explorar todas as considerações sobre HA, DR e backup para atender aos seus requisitos de aplicativo. 

## Suporte
{: #support}

O suporte para as instâncias de serviço dos planos Padrão e Dedicado é opcional.
Ele é fornecido comprando o *{{site.data.keyword.cloud_notm}}Suporte Padrão*. O suporte não está disponível para o plano Lite.

Para obter mais informações sobre os planos de suporte, consulte os [ {{site.data.keyword.cloud_notm}} Planos de suporte Padrão ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/cloud/support#944376){:new_window}. Para obter mais informações sobre suporte, consulte o [ guia de suporte do {{site.data.keyword.IBM_notm}}![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/support/home/pages/support-guide/){:new_window}.

Os sistemas de suporte usados para o {{site.data.keyword.cloudant_short_notm}} não oferecem recursos para a proteção do conteúdo que contém Informações de saúde, dados de saúde, Informação protegida de saúde ou dados que estão sujeitos a requisitos regulamentares adicionais. Como tal, o Cliente não deve inserir nem fornecer tais dados.
{: tip}

## Fornecendo uma instância do {{site.data.keyword.cloudant_short_notm}} no {{site.data.keyword.cloud_notm}}
{: #provisioning-a-cloudant-nosql-db-instance-on-ibm-cloud}

É possível provisionar uma instância do plano Lite ou Standard do {{site.data.keyword.cloudant_short_notm}} no {{site.data.keyword.cloud_notm}} de duas maneiras:

- Usando o painel. Um tutorial que descreve o processo está disponível [aqui ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://console.bluemix.net/docs/services/Cloudant/tutorials/create_service.html#creating-a-cloudant-instance-on-bluemix){:new_window}.
- Usando a ferramenta de comando do Cloud Foundry. Um tutorial que descreve o processo está disponível [aqui ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://console.bluemix.net/docs/services/Cloudant/tutorials/create_service_cli.html#creating-a-cloudant-instance-on-bluemix-using-the-cloud-foundry-tools){:new_window}.
 
Para criar e alavancar uma instância do plano Dedicated
Hardware do {{site.data.keyword.cloudant_short_notm}}, siga o tutorial que descreve o processo [aqui ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://console.bluemix.net/docs/services/Cloudant/tutorials/create_dedicated_hardware_plan.html#creating-and-leveraging-a-cloudant-dedicated-hardware-plan-instance-on-bluemix){:new_window}.




