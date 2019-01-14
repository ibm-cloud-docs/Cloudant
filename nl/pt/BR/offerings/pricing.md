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

# Precificação
{: #pricing}

O {{site.data.keyword.cloudantfull}} permite aumentar ou reduzir sua capacidade de rendimento
provisionada, que é um número reservado de consultas e gravações, além de consultar cada segundo alocado
para uma instância. O nível de capacidade de rendimento é o nível de uso máximo. Se você tentar
exceder a capacidade reservada, obterá um código de status HTTP 429 que indica que o
aplicativo está tentando ultrapassar sua capacidade de rendimento provisionada.


## Exemplos de precificação 
{: #pricing-examples}

Vamos supor que você esteja desenvolvendo um app móvel com o {{site.data.keyword.cloudant_short_notm}} e ainda não sabe a capacidade
que poderá ser necessária. Nesse caso, recomendamos que você comece com a menor capacidade de rendimento
provisionada e a aumente conforme requerido pelo uso de seu aplicativo ao longo do tempo. As contas do {{site.data.keyword.cloudant_short_notm}}
são proporcionais a cada hora e a mudança na capacidade de rendimento provisionada não incorre em tempo de inatividade. 

Para o exemplo de aplicativo móvel, você começa com a capacidade de rendimento mínima provisionada para
o plano Standard que é 100 consultas/s, 50 gravações/s e 5 consultas/s. O custo para
essa capacidade é US$ 0,105 por hora. As 100 consultas/s, 50 gravações/s e 5 consultas/s são
um bloco de capacidade de rendimento provisionada. Quando você precisar aumentar a capacidade (ou reduzir), poderá
escalar em incrementos desses blocos de capacidade. Supondo que a instância tenha menos de
20 GB de armazenamento incluídos no plano Standard, não incorrerá nenhum custo de armazenamento. Na guia
Painel do {{site.data.keyword.cloudant_short_notm}} > Conta > Capacidade, a
configuração da capacidade de rendimento provisionada é semelhante a esta captura de tela:

![Guia Capacidade do painel do {{site.data.keyword.cloudant_short_notm}}](../images/cloudant-dashboard.png)

A régua de controle de capacidade mostra o custo por hora da capacidade de rendimento provisionada de 100 consultas/s, 50 gravações/s e 5 consultas/s no valor em US$ de 0,105/hora. A régua de controle mostra um custo bruto por mês de US$ 76,65. A quantia mensal é uma estimativa baseada em uma média de 730 horas por mês. O custo em qualquer mês pode ser um pouco diferente dependendo do número de horas no mês.

Exemplo: equação 

- US$ 0,105 por hora 1 bloco de 100 consultas/s, 50 gravações/s e 5 consultas/s de capacidade de rendimento provisionada * 730 horas (horas aproximadas em um mês)
- Total = $ 76,65

Consultas, gravações e consultas não podem ser escaladas independentemente. Use a régua de controle para selecionar o número de blocos de capacidade de rendimento provisionada com base no limite máximo de consultas/s, gravações/s ou consultas/s necessárias para seu aplicativo. Por exemplo, se seu aplicativo requer 1.000 consultas por segundo, use a régua de controle para selecionar a capacidade que oferece 1.000 consultas/s, 500 gravações/segundo e 50 consultas/s, mesmo se você não precisar do número correspondente de gravações ou consultas.

![Guia Capacidade do painel do {{site.data.keyword.cloudant_short_notm}} com mais capacidade selecionada](../images/cloudant-gran-tuning.png)

Como você estima o custo total para a capacidade de rendimento provisionada por mês de 1.000 consultas, 500 gravações e 50 consultas? 

- US$ 0,105 por hora 10 blocos de 100 consultas/s, 50 gravações/s e 5 consultas/s de capacidade de rendimento provisionada * 730 horas (horas aproximadas em um mês)
- Como alternativa, a régua de controle mostra que a capacidade de rendimento provisionada de 1000 consultas/s, 500 gravações/s e 50 consultas/s custa US$ 1,050/hora * 730 horas
- Total = $ 766,50

## Uso de Dados 
{: #data-usage}

E a precificação para excedente de dados, como funciona?

Plano | Armazenamento incluído | Limite Excedente
-----|------------------|--------------
Lite | 1 GB |  Sua conta fica bloqueada para gravação de novos dados até que você exclua dados suficientes para estar abaixo do limite de 1 GB ou até fazer upgrade para um plano superior.
Padrão | 20 GB | Custos de armazenamento adicional de US$ 0,0014 por GB por hora, que é de aproximadamente US$ 1/GB por mês.

Como os dados são exibidos no Painel de uso do {{site.data.keyword.cloud_notm}}?

Essa visualização mostra os totais para uso que são acumulados durante o mês e, portanto, mostra os custos apenas para o mês até a data. O Total Estimado reflete a fatura para o mês até a data. No final do mês, você vê sua capacidade média para o mês, que é o total da fatura mensal. O campo `STORAGE_MANAGED_PER_MONTH` mostra apenas a quantia maior do que 20 GB incluídos, portanto, no exemplo a seguir, você vê aproximadamente 40 GB de dados totais na conta.  

![Visualização de métricas de uso do Painel do {{site.data.keyword.cloudant_short_notm}} com ARMAZENAMENTO GERENCIADO POR MÊS mais alto](../images/usage-dashboard1.png)

Quando você usa menos de 20 GB de armazenamento, a exibição mostra 0 GB porque você não ficou acima do limite.
