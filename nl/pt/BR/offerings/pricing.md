---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: pricing examples, data usage, ibm cloud usage dashboard

subcollection: cloudant

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:note: .note}
{:important: .important}
{:deprecated: .deprecated}

<!-- Acrolinx: 2019-01-11 -->

# Precificação
{: #pricing}

O {{site.data.keyword.cloudantfull}} será precificado com base na capacidade de rendimento fornecida que você alocar para sua instância e a quantia de armazenamento de dados consumida. O {{site.data.keyword.cloudant_short_notm}} permite aumentar e diminuir a capacidade de rendimento fornecida e pagar por hora rateada. A capacidade de rendimento fornecida é um número reservado de leituras por segundo, gravações por segundo e consultas globais por segundo alocadas para uma instância. A configuração de capacidade de rendimento é o nível de uso máximo para um determinado segundo. Se você tentar exceder a capacidade reservada para as leituras, gravações ou consultas globais, você obterá um código de status HTTP 429 que indica que o aplicativo está tentando exceder seu limite de capacidade de rendimento fornecida.

A tabela a seguir mostra a precificação por hora de exemplo para uma variedade de configurações de capacidade de rendimento fornecida. É possível alternar a capacidade em blocos granulares de 100 leituras/s, 50 gravações/s e 5 consultas globais/s em uma base de hora em hora. Um custo mensal aproximado também é mostrado para cada ajuste, assumindo uma média de 730 horas em um mês. Os preços mostrados estão em dólares americanos. É possível usar a calculadora de precificação do {{site.data.keyword.cloud_notm}} para ver os custos estimados em outras moedas clicando no botão `Incluir para estimar` no quadro do catálogo do {{site.data.keyword.cloudant_short_notm}}.

![planilha de precificação](../images/pricing_spreadsheet.png)

É possível ativar a guia **Painel** > **Conta** > **Capacidade** do {{site.data.keyword.cloudant_short_notm}} para visualizar e mudar a capacidade de rendimento fornecida e ver os custos mensais por hora e aproximados: 

![slider](../images/migrate2.gif)

## Exemplos de precificação 
{: #pricing-examples}

Vamos supor que você esteja desenvolvendo um app móvel com o {{site.data.keyword.cloudant_short_notm}} e ainda não sabe a capacidade
que poderá ser necessária. Nesse caso, recomendamos que você comece com a menor capacidade de rendimento
provisionada e a aumente conforme requerido pelo uso de seu aplicativo ao longo do tempo. As contas do {{site.data.keyword.cloudant_short_notm}}
são proporcionais a cada hora e a mudança na capacidade de rendimento provisionada não incorre em tempo de inatividade. 

Para o exemplo de app móvel, você começa com a capacidade de rendimento fornecida mínima para o
plano Standard que tem 100 leituras/s, 50 gravações/s e 5 consultas globais/s. O custo para
essa capacidade é US$ 0,105 por hora. As 100 leituras/s, 50 gravações/s e 5 consultas globais/s são um
bloco de capacidade de rendimento fornecida. Quando você precisar aumentar a capacidade (ou reduzir), poderá
escalar em incrementos desses blocos de capacidade. Supondo que a instância tenha menos de
20 GB de armazenamento incluídos no plano Standard, não incorrerá nenhum custo de armazenamento. Na guia
Painel do {{site.data.keyword.cloudant_short_notm}} > Conta > Capacidade, a
configuração da capacidade de rendimento provisionada é semelhante a esta captura de tela:

![Guia Capacidade do painel do {{site.data.keyword.cloudant_short_notm}}](../images/cloudant-dashboard.png)

A régua de controle de capacidade mostra o custo por hora da capacidade de rendimento fornecida de 100 leituras/s, 50 gravações/s e 5 consultas globais/s em US$ 0,105/hora. A régua de controle mostra um custo bruto por mês de US$ 76,65. A quantia mensal é uma estimativa baseada em uma média de 730 horas por mês. O custo em qualquer mês pode ser um pouco diferente dependendo do número de horas no mês.

Exemplo: equação 

- US$ 0,105 por hora \* 1 bloco (de capacidade de rendimento fornecida 100 leituras/s, 50 gravações/s e 5 consultas globais/s) \* 730 horas (horas aproximadas em um mês)
- Total = $ 76,65


Leituras, gravações e consultas globais não podem ser escaladas de forma independente. Use a régua de controle para selecionar o número de blocos de capacidade de rendimento fornecida com base no limite máximo de leituras/s, gravações/s ou consultas globais/s necessárias para o seu aplicativo. Por exemplo, se o seu aplicativo precisar de 1.000 leituras por segundo, use a régua de controle para selecionar a capacidade que oferece 1.000 leituras/s, 500 gravações/s e 50 consultas globais/s, mesmo se você não precisar do número correspondente de gravações ou consultas globais.

![Guia Capacidade do painel do {{site.data.keyword.cloudant_short_notm}} com mais capacidade selecionada](../images/cloudant-gran-tuning.png)

Como você estima o custo total para a capacidade de rendimento fornecida por mês de 1.000 leituras, 500 gravações e 50 consultas globais? 

- $0.105 por hora \ * 10 blocos (de 100 leituras / segundo, 50 gravações / seg e 5 consultas globais / segundo capacidade de transmissão provisionada) \ * 730 horas (aproximações aproximadas em um mês)
- Como alternativa, a régua de controle mostra que a capacidade de rendimento fornecida de 1000 leituras/s, 500 gravações/s e 50 consultas globais/s custa US$ 1,050/hora \* 730 horas
- Total = $ 766,50

## Precificação do uso de dados
{: #data-usage-pricing}

E a precificação para excedente de dados, como funciona?

Plano | Armazenamento incluído | Limite Excedente
-----|------------------|--------------
Lite | 1 GB |  Sua conta está bloqueada para gravar novos dados até que você exclua dados suficientes para estar abaixo do limite de 1 GB ou faça upgrade para um plano superior.
Padrão | 20 GB | Custos de armazenamento adicional de US$ 0,0014 por GB por hora, que é de aproximadamente US$ 1/GB por mês.

## Painel de uso do {{site.data.keyword.cloud_notm}} 
{: #usage-dashboard}

Como os dados são exibidos no Painel de uso do {{site.data.keyword.cloud_notm}}?

As faturas de uso atuais e históricas podem ser vistas no painel do {{site.data.keyword.cloud_notm}}, em Gerenciar-> Faturamento e uso-> Uso. Esta visualização mostra os totais para uso que são acumulados durante um mês específico no nível de serviço, plano ou instância.  O total estimado reflete a fatura até agora para o mês ou para os últimos meses completos. Ela só mostrará os custos por hora acumulados até esse ponto para o mês atual. Até o final do mês, você verá a capacidade média de rendimento fornecida do mês refletida nos campos `LOOKUPS_PER_MONTH`, `WRITES_PER_MONTH` e `QUERIES_PER_MONTH`. (Observe que agora as pesquisas são chamadas de leituras e as consultas são chamadas de consultas globais.) O campo `STORAGE_MANAGED_PER_MONTH` mostra apenas o armazenamento cobrado e não inclui os 20 GB que estão incluídos no plano Standard. No exemplo a seguir, uma quantidade de mais de 20 GB reflete que havia uma média de 40 GB de dados na instância para o mês. Quando você usa menos de 20 GB de armazenamento, a exibição mostra 0 GB porque você não ficou acima do limite.   

![Visualização de métricas de uso do Painel do {{site.data.keyword.cloudant_short_notm}} com ARMAZENAMENTO GERENCIADO POR MÊS mais alto](../images/usage-dashboard1.png)


