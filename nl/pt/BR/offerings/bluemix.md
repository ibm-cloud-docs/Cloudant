---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: standard plan, lite plan, dedicated hardware plan, event type, provisioned throughput capacity, consumption, capacity, monitor usage, data usage, size limits, locations, tenancy, authentication methods, high availability, disaster recovery, backup, support

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

# Planos e fornecimento
{: #ibm-cloud-public}

O {{site.data.keyword.cloudantfull}} Public é a oferta mais rica em recursos do {{site.data.keyword.cloudant_short_notm}},
recebendo atualizações e novos recursos primeiro. A precificação é baseada na
capacidade de rendimento fornecida alocada e no armazenamento de dados usado, tornando-a adequada para qualquer
carregamento necessário. 
{: shortdesc}

O [plano Lite](#lite-plan) grátis inclui uma quantidade fixa de
capacidade de rendimento e dados para propósitos de desenvolvimento e avaliação. O [plano Standard](#standard-plan) pago oferece capacidade de rendimento
provisionada configurável e precificação de armazenamento de dados que escala à medida que os requisitos de seu aplicativo
mudam.  Um [plano Hardware dedicado](#dedicated-hardware-plan) opcional também está disponível por uma
taxa mensal adicional para executar uma ou mais de suas instâncias do plano Padrão
em um ambiente de hardware dedicado. O ambiente de hardware dedicado
é para seu uso exclusivo e, se uma instância do plano Dedicated
Hardware for provisionada
dentro de um local dos EUA, será possível selecionar opcionalmente uma configuração compatível com o [HIPAA ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){: new_window}.

## Planos
{: #plans}

É possível selecionar qual plano usar quando você [fornece sua instância de serviço do {{site.data.keyword.cloudant_short_notm}}](#provisioning-a-cloudant-nosql-db-instance-on-ibm-cloud).
Por padrão,
o [plano Lite](#lite-plan) é selecionado.

![{{site.data.keyword.cloudant_short_notm}} seleção de plano da instância de serviço](../images/lite_pricing_plan.png)

### Plano Lite
{: #lite-plan}

O plano Lite é gratuito e é projetado para propósitos de desenvolvimento e avaliação. A funcionalidade completa do {{site.data.keyword.cloudant_short_notm}} está incluída, mas as instâncias de plano Lite possuem uma quantia fixa de capacidade de rendimento provisionada e armazenamento de dados. A capacidade de rendimento fornecida é fixada em 20 leituras/s, 10 gravações/s e 5 consultas globais/s e o armazenamento de dados é limitado a 1 GB. 

O uso de armazenamento é verificado diariamente. Se você exceder seu limite de armazenamento de 1 GB, as solicitações para a instância do {{site.data.keyword.cloudant_short_notm}} receberão um código de status 402 com a mensagem de erro "A conta excedeu sua cota de uso de dados. Será necessário fazer upgrade para um plano pago".
Um banner também aparecerá no Painel do {{site.data.keyword.cloudant_short_notm}}. Ainda será possível ler e excluir dados. No entanto, para gravar novos dados, você tem duas opções. Primeiro, é possível fazer upgrade para um [plano Padrão](#standard-plan) pago que remove a limitação de gravação imediatamente. Como alternativa, é possível excluir dados para que o armazenamento total seja classificado abaixo do limite de 1 GB e aguarde até que a próxima verificação de armazenamento diária seja executada para que sua instância permita gravações novamente. 

Se desejar armazenar mais de 1 GB de dados ou ser capaz de escalar a capacidade de rendimento provisionada, mude para o [plano Padrão](#standard-plan).

Você está limitado a uma instância de plano {{site.data.keyword.cloudant_short_notm}} Lite por conta {{site.data.keyword.cloud_notm}}. Se você já tiver uma instância do plano Lite, qualquer tentativa de criar uma nova instância do plano Lite ou de mudar uma instância do plano Padrão para um plano Lite retornará a mensagem "Só é possível ter uma instância de um plano Lite por serviço. Para criar uma nova instância, exclua a instância do plano de Lite existente ou selecione um plano pago." 
{: note}

### Plano padrão
{: #standard-plan}

O plano {{site.data.keyword.cloudant_short_notm}} Padrão está disponível para todas as contas pagas do {{site.data.keyword.cloud}}, como pagar por uso ou assinatura e é escalado para atender às necessidades de seu aplicativo. O plano Padrão é precificado com base em dois fatores: a capacidade de rendimento provisionada que é alocada e a quantidade de dados que são armazenados na instância. 

A precificação é rateada por hora com uma capacidade de rendimento fornecida inicial de 100 leituras/s, 50 gravações/s e 5 consultas globais/s iguais a um custo inicial de US$ 0,105/hora. É possível aumentar ou diminuir a capacidade de rendimento fornecida em incrementos de 100 leituras/s, 50 gravações/s e 5 consultas globais/s no painel do {{site.data.keyword.cloudant_short_notm}}. Os custos são calculados para a capacidade de rendimento fornecida que está alocada e não está no volume medido de solicitações. O plano Padrão inclui 20 GB de armazenamento de dados. Se você armazenar mais de 20 GB,
será cobrado um custo definido por GB por hora. 

Consulte a Calculadora de precificação {{site.data.keyword.cloud_notm}} para precificação em diferentes capacidades e moedas e as informações de [precificação](/docs/services/Cloudant?topic=cloudant-pricing#pricing){: new_window} para obter exemplos para estimar custos.

### Plano Dedicated Hardware
{: #dedicated-hardware-plan}

Uma instância de plano de Hardware dedicado do {{site.data.keyword.cloudant_short_notm}} é um ambiente {{site.data.keyword.cloudant_short_notm}} bare metal que é provisionado para o uso exclusivo de suas instâncias de plano {{site.data.keyword.cloudant_short_notm}} Padrão. Um ambiente do plano Dedicated Hardware do {{site.data.keyword.cloudant_short_notm}} pode ser provisionado em qualquer [data center global do {{site.data.keyword.IBM}} ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/cloud/data-centers/){:new_window}. Esse plano é necessário para
conformidade com HIPAA e deve ser selecionado no tempo de fornecimento. Os usuários de um {{site.data.keyword.cloudant_short_notm}}ambiente de plano de hardware Dedicado podem empregar as chaves de criptografia gerenciadas pelo cliente (BYOK) de lista de desbloqueio de IP e de sua própria chave (BYOK) com o {{site.data.keyword.IBM_notm}}Protetor de Chave. Além disso, os ambientes de Dedicated Hardware provisionados após 1º de janeiro de 2019 fora dos ambientes gerenciados pela UE incluem terminais internos para todas as instâncias do plano Standard implementadas neles. O uso de terminais internos permite que os clientes se conectem a uma instância do {{site.data.keyword.cloudant_short_notm}} por meio da rede interna do {{site.data.keyword.cloud}} para evitar que o tráfego de aplicativos de envio de dados entre na rede pública, incorrendo em encargos de largura da banda. Para obter mais informações, consulte a [documentação de Terminal em serviço ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://cloud.ibm.com/docs/services/service-endpoint/getting-started.html#about){:new_window} para obter mais detalhes sobre a ativação de terminais em serviço para a sua conta do {{site.data.keyword.cloud}}.

É possível fornecer uma ou mais instâncias de plano Padrão e o ambiente de Hardware dedicado é expandido ou diminuído conforme necessário com base na capacidade e nos dados que são usados pelas instâncias de plano Padrão. Uma instância do plano do {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware tem um preço fixo que é uma adição à precificação de consumo de qualquer instância do plano Standard implementada nele. O faturamento é rateado diariamente e há uma duração mínima de 1 mês a ser cobrada pelo ambiente. O fornecimento de um plano de Hardware dedicado do {{site.data.keyword.cloudant_short_notm}} é assíncrono e pode levar de 5 a 7 dias úteis. Para criar uma instância do plano Dedicated Hardware do {{site.data.keyword.cloudant_short_notm}} e provisionar uma instância do plano Standard nela, siga o tutorial [Criando e aproveitando uma instância do plano Dedicated Hardware do {{site.data.keyword.cloudant_short_notm}} no {{site.data.keyword.cloud_notm}}](/docs/services/Cloudant?topic=cloudant-creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud#creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud). 

O plano de Hardware dedicado não está disponível para clientes do {{site.data.keyword.cloud_notm}} Dedicated. O plano de Hardware dedicado só está disponível para clientes do {{site.data.keyword.cloud_notm}} Public.
{: important}

## Tipos de evento
{: #event-types}

A provisão de rendimento é identificada e medida como um dos tipos de eventos a seguir:

1.	_Leituras_,
(anteriormente chamadas de consultas) que são:
    1. Uma leitura de um documento específico,
com base no `_id` do documento.
    2. Uma consulta _particionada_,
que é uma solicitação feita para um terminal de consulta do {{site.data.keyword.cloudant_short_notm}}
no namespace `_partition` no caminho da solicitação, incluindo os tipos a seguir:
        -	Índice primário ([`_all_docs`](/docs/services/Cloudant?topic=cloudant-databases#get-documents))
        -	Visualização MapReduce ([`_view`](/docs/services/Cloudant?topic=cloudant-using-views#using-views))
        -	Índice de procura ([`_search`](/docs/services/Cloudant?topic=cloudant-search#queries))
        -	{{site.data.keyword.cloudant_short_notm}} Query ([`_find`](/docs/services/Cloudant?topic=cloudant-query#finding-documents-by-using-an-index))
    
        O número de operações de leitura consumidas por uma solicitação de consulta particionada
varia de acordo com os resultados retornados.
2.	_Gravações_,
que são criação,
modificação
ou exclusão de documentos individuais.
3.	_Consultas globais_ para índices globais (anteriormente chamadas de consultas),
que são solicitações feitas para um terminal de consulta do {{site.data.keyword.cloudant_short_notm}}
**não** dentro do namespace `_partition`,
incluindo os tipos a seguir:
	-	Índice primário ([`_all_docs`](/docs/services/Cloudant?topic=cloudant-databases#get-documents))
	-	Visualização MapReduce ([`_view`](/docs/services/Cloudant?topic=cloudant-using-views#using-views))
	-	Índice de procura ([`_search`](/docs/services/Cloudant?topic=cloudant-search#queries))
	-	Índice geoespacial ([`_geo`](/docs/services/Cloudant?topic=cloudant-cloudant-nosql-db-geospatial#querying-a-cloudant-nosql-db-geo-index))
	-	{{site.data.keyword.cloudant_short_notm}} Query ([`_find`](/docs/services/Cloudant?topic=cloudant-query#finding-documents-by-using-an-index))


## Capacidade de rendimento provisionada
{: #provisioned-throughput-capacity}

A provisão de rendimento é identificada e medida como eventos do seguinte
tipos de operação: _Leitura_, _Gravação_, _Consulta Global_.

A medida de rendimento é uma contagem simples do número de eventos de cada tipo,
por segundo,
em que o segundo é uma janela _deslizante_.
Se a sua conta exceder o número de eventos de rendimento provisionados para o plano,
as solicitações serão rejeitadas até que o número de eventos dentro da janela deslizante
não mais exceda o número provisionado.
Pode ajudar a pensar na janela deslizante de 1 segundo como sendo qualquer período consecutivo de 1.000 milissegundos.

Por exemplo, o plano Standard é fornecido para 200 leituras por segundo. Sua conta pode consumir um máximo de 200 eventos de leitura durante um período consecutivo de 1.000 milissegundos (1 segundo). As solicitações de leitura subsequentes feitas durante o período de 1.000 milissegundos
são rejeitadas até que o número de eventos de leitura nesse período caia para menos de 200 novamente.

Quando uma solicitação é rejeitada porque o número de eventos foi excedido,
os aplicativos recebem uma resposta [`429` Muitas solicitações](/docs/services/Cloudant?topic=cloudant-http#http-status-codes).

As versões recentes das bibliotecas de clientes suportados (para as linguagens [Java](/docs/services/Cloudant?topic=cloudant-supported-client-libraries#java-supported),
[Node.js](/docs/services/Cloudant?topic=cloudant-supported-client-libraries#node-js-supported)
e [Python](/docs/services/Cloudant?topic=cloudant-supported-client-libraries#python-supported)) ajudam a manipular uma resposta `429`. Por exemplo,
a biblioteca Java gera uma resposta
[`TooManyRequestsException` ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://static.javadoc.io/com.cloudant/cloudant-client/2.5.1/com/cloudant/client/org/lightcouch/TooManyRequestsException.html){: new_window}.

Por padrão,
as bibliotecas de clientes suportados não tentarão novamente uma solicitação
automaticamente quando uma resposta `429` for recebida.

É melhor assegurar-se de que seu aplicativo manipule respostas `429` corretamente.
O motivo é que o número de novas tentativas é limitado;
transgredir regularmente o número de solicitações é um forte indicador
para mover para uma configuração de plano diferente.

Se você estiver transportando um aplicativo existente, ele poderá não ser capaz de lidar com uma resposta `429`. Como parte de sua verificação de migração,
verifique se o seu aplicativo manipula respostas `429` corretamente.
{: note}

Em resumo,
deve-se assegurar que seu aplicativo seja capaz de manipular uma resposta [`429`](/docs/services/Cloudant?topic=cloudant-http#http-status-codes) corretamente.

### Consumo de operações de leitura por consultas particionadas
{: #consumption-of-lookup-operations-by-partitioned-queries}

As solicitações de consulta particionadas consomem um número variável de operações de leitura
dependendo dos resultados retornados. O consumo é baseado em dois eixos:

1. O número de linhas lidas do índice envolvido na consulta.
1. O número de documentos lidos por meio do banco de dados, se houver, durante a execução
da consulta.
    
#### `_all_docs`, visualização e consultas de procura

Cada bloco de 100 linhas lidas do índice consome 1 operação de leitura. Além disso,
cada documento lido por meio do banco de dados durante a execução de uma consulta
consome 1 unidade de leitura.

O número de linhas lidas do índice é o mesmo que o número de resultados
retornados. Os documentos são lidos somente do banco de dados quando `include_docs=true` é
passado como um parâmetro de sequência de consultas durante a solicitação de consulta.

Os custos de exemplo são mostrados na tabela a seguir.

| Número de resultados | Incluir documentos | Consumo total de leitura | Consumo para linhas lidas | Consumo de documentos lidos |
|--------------|----------------|-------------|---------------------| --- |
| 199      | Não     | **2** | 2 | 0 |
| 199      | Sim     | **201** | 2 | 199 |
| 301      | Não     | **4** | 4 | 0 |
| 301      | Sim     | **305** | 4 | 301 |

Reduzir o uso de `include_docs=true` é a chave para reduzir o consumo de leitura para
consultas particionadas `_all_docs`, visualização e consultas de procura.

#### {{site.data.keyword.cloudant_short_notm}} Query

Para solicitações do {{site.data.keyword.cloudant_short_notm}} Query, o número de operações de leitura consumidas para linhas de índice
lidas está relacionado às linhas lidas por meio do índice subjacente _antes_ que a filtragem
ocorra com base em partes do seletor que não podem ser satisfeitas pelo índice.
Isso significa que as linhas do valor de leitura e, portanto, de unidades de leitura consumidas, podem ser
maiores do que o número de resultados finais que você recebe.

Além disso, {{site.data.keyword.cloudant_short_notm}}A consulta deve ler o documento para cada linha retornada pelo
de índice subjacente para que ele possa executar filtragem adicional requerida pelo
seletor transmitido para a consulta.

| Número de resultados | Número de linhas retornadas pelo índice | Consumo total de leitura | Consumo para linhas lidas | Consumo de documentos lidos |
|--------------|----------------|-------------|---------------------| --- |
| 5      | 199     | **201** | 2 | 199 |
| 199      | 199     | **201** | 2 | 199 |
| 5      | 301     | **305** | 4 | 301 |
| 301      | 301     | **305** | 4 | 301 |

O uso de índices apropriados é a chave para reduzir o consumo de leitura para particionado
{{site.data.keyword.cloudant_short_notm}}Consultar consultas.

### Visualizando e mudando a capacidade
{: #viewing-and-changing-capacity}

É possível ver detalhes da capacidade de rendimento nos planos disponíveis para sua conta.
É possível selecionar o nível de fornecimento que você deseja usar, por meio da guia Conta de seu painel de conta {{site.data.keyword.cloudant_short_notm}}.

![Account dashboard](../images/cloudant_capacity.png)

Para mover para uma capacidade de rendimento diferente, selecione o fornecimento
desejado e, em seguida, clique em `Atualizar`. Você é solicitado a confirmar a mudança
e lembrado de que a mudança de fornecimento pode levar até 24 horas para ser concluída.

![Account dashboard](../images/cloudant_capacity_change.png)

O tamanho do aumento de capacidade é limitado a 10 unidades (1000 leituras/segundo, 500 gravações/segundo e 50 consultas globais/segundo) por mudança. As diminuições não são limitadas pelo número de unidades. Qualquer mudança de capacidade, um aumento ou uma diminuição, é limitada a uma vez por hora. Se você precisar de mais capacidade do que está disponível no painel do {{site.data.keyword.cloudant_short_notm}}, entre em contato com o [suporte do {{site.data.keyword.cloudant_short_notm}}![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](mailto:support@cloudant.com){: new_window}.
{: note}

### Monitorando o uso 
{: #monitoring-usage}

As informações sobre seu uso estão disponíveis na área de janela Operações atuais da guia Monitoramento no Painel do {{site.data.keyword.cloudant_short_notm}}. 

![Monitorando o uso no painel](../images/cloudant_usage.png)

Os detalhes são fornecidos lá,
ilustrando seu [rendimento](#provisioned-throughput-capacity) atual
e a quantidade de [dados armazenados](#disk-space-included).

O monitoramento ajuda a reconhecer que uma mudança no fornecimento em seu plano pode ser aconselhável.
Por exemplo,
se você se aproximar frequentemente do número máximo de leituras do banco de dados,
será possível modificar o fornecimento por meio da [Área de janela de capacidade](#viewing-and-changing-capacity) na guia Conta do painel.

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

Exceder qualquer um desses limites resulta em uma [resposta 413](/docs/services/Cloudant?topic=cloudant-http#http-status-codes).

É recomendado que você armazene anexos binários, ou blobs JSON grandes,
no armazenamento de objetos e salve um link para o local em um documento JSON do {{site.data.keyword.cloudant_short_notm}}.   

Ao replicar, documentos ou anexos maiores do que esses limites não serão
replicados para o banco de dados de destino. Para obter mais informações sobre como detectar erros de replicação, consulte [Erros de replicação](/docs/services/Cloudant?topic=cloudant-replication-api#replication-errors).

## Locais e ocupação
{: #locations-and-tenancy}

Por padrão, todos os planos Lite e Padrão são implementados em ambientes de
diversos locatários. Como parte da seleção de seu plano,
é possível escolher entre as regiões do {{site.data.keyword.cloud_notm}} Public a seguir:

-   Washington DC
-   Dallas
-   Londres
-   Sydney
-   Frankfurt&Dagger;
-   Tóquio

As instâncias do plano Dedicated Hardware podem ser implementadas na maioria das [localizações de data center do {{site.data.keyword.IBM_notm}} ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/cloud/data-centers/).
Consulte o menu suspenso no catálogo do {{site.data.keyword.cloud_notm}} para uma lista atualizada de locais disponíveis.

&Dagger;Todas as instâncias do {{site.data.keyword.cloudant_short_notm}} que são implementadas por meio da
região Frankfurt do {{site.data.keyword.cloud_notm}} Public
são implementadas em ambientes gerenciados pela UE. Não se pode conceder acesso a uma instância do
{{site.data.keyword.cloudant_short_notm}} gerenciada pela UE a qualquer conta ou chave de API do {{site.data.keyword.cloudant_short_notm}}
que é gerada fora de um ambiente gerenciado pela UE.

## Métodos de Autenticação
{: #authentication-methods}

O {{site.data.keyword.cloudant_short_notm}} é acessado usando uma API HTTPS. No local que o terminal da API requerer, o usuário será autenticado para cada pedido de HTTPS que o {{site.data.keyword.cloudant_short_notm}} receber. Durante o fornecimento, os métodos de autenticação disponíveis incluem `Use both legacy credentials and IAM` ou `Use only IAM`. Para obter mais informações, consulte o [Guia do IAM](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-) ou o [Documento da API de autenticação](/docs/services/Cloudant?topic=cloudant-authentication#authentication) anterior.

Após o fornecimento de uma instância do {{site.data.keyword.cloudant_short_notm}}, a URL de conexão e os detalhes de autorização do IAM podem ser localizados ao gerar novas credenciais na guia Credenciais de serviço do painel do {{site.data.keyword.cloud_notm}}. Se você escolher esta opção durante o fornecimento, o nome do usuário e senha anteriores do {{site.data.keyword.cloudant_short_notm}} também serão incluídos.

A equipe do {{site.data.keyword.cloudant_short_notm}} recomenda que você use controles de acesso do IAM para autenticação sempre que possível. Se você estiver usando a autenticação do {{site.data.keyword.cloudant_short_notm}} anterior, recomenda-se usar [chaves de API](/docs/services/Cloudant?topic=cloudant-authorization#api-keys){: new_window} em vez de credenciais de nível de conta para acesso programático e tarefas de replicação. 
{: important}

## Alta disponibilidade, recuperação de desastre e backup em um data center
{: #high-availability-disaster-recovery-and-backup-in-a-data-center}

Para fornecer alta disponibilidade (HA) e recuperação de desastre (DR) em um data center, todos os dados são armazenados em triplicidade em três servidores físicos separados em um cluster. É possível provisionar contas em múltiplos data centers
e, em seguida, usar a replicação de dados contínua para fornecer HA/DR nos data centers. Os dados do {{site.data.keyword.cloudant_short_notm}} não são submetidos a backup automaticamente, mas as ferramentas suportadas são fornecidas para manipular backups. Revise o [guia Recuperação de desastre e backup](/docs/services/Cloudant?topic=cloudant-authorization#api-keys) para explorar todas as considerações de HA, de DR e de backup para atender aos requisitos do seu aplicativo. 

## {{site.data.keyword.cloud_notm}} Suporte
{: #ibm-cloud-support}

O suporte para as instâncias de serviço dos planos Padrão e Dedicado é opcional.
Ele é fornecido comprando o *{{site.data.keyword.cloud_notm}}Suporte Padrão*. O suporte não está disponível para o plano Lite.

Para obter mais informações sobre os planos de suporte, consulte os [ {{site.data.keyword.cloud_notm}} Planos de suporte Padrão ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/cloud/support#944376){: new_window}. Para obter mais informações sobre suporte, consulte o [Guia de suporte da {{site.data.keyword.IBM_notm}} ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/support/home/pages/support-guide/){: new_window}.

Os sistemas de suporte usados para o {{site.data.keyword.cloudant_short_notm}} não oferecem recursos para a proteção do conteúdo que contém Informações de saúde, dados de saúde, Informação protegida de saúde ou dados que estão sujeitos a requisitos regulamentares adicionais. Como tal, o Cliente não deve inserir nem fornecer tais dados.
{: note}

## Fornecendo uma instância do {{site.data.keyword.cloudant_short_notm}} no {{site.data.keyword.cloud_notm}}
{: #provisioning-a-cloudant-nosql-db-instance-on-ibm-cloud}

É possível provisionar uma instância do plano Lite ou Standard do {{site.data.keyword.cloudant_short_notm}} no {{site.data.keyword.cloud_notm}} de duas maneiras:

- Usando o painel. Para obter mais informações, consulte o tutorial [Criando uma instância do {{site.data.keyword.cloudant_short_notm}} no {{site.data.keyword.cloud_notm}}![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-an-ibm-cloudant-instance-on-ibm-cloud){: new_window} que descreve o processo.
- Usando a ferramenta de comando do Cloud Foundry. Para obter mais informações, consulte o tutorial [Criando uma instância do {{site.data.keyword.cloudant_short_notm}} no {{site.data.keyword.cloud_notm}} usando a CLI do {{site.data.keyword.cloud_notm}} ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli#creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli){: new_window} que descreve o processo.
 
Para criar e aproveitar uma instância do plano Dedicated Hardware do {{site.data.keyword.cloudant_short_notm}}, siga o tutorial [Criando e aproveitando uma instância do plano Dedicated Hardware do {{site.data.keyword.cloudant_short_notm}} no {{site.data.keyword.cloud_notm}} ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](/docs/services/Cloudant?topic=cloudant-creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud#creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud){: new_window} que descreve o processo.






