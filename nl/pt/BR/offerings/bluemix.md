---

copyright:
  years: 2015, 2018
lastupdated: "2017-12-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-02-23 -->

# {{site.data.keyword.Bluemix_notm}} Público

O {{site.data.keyword.cloudantfull}} Public é a oferta mais rica em recursos do {{site.data.keyword.cloudant_short_notm}},
recebendo atualizações e novos recursos primeiro. A precificação baseia-se em
seu rendimento e requisitos de armazenamento, tornando-a adequada para qualquer
carga necessária. 

Há um [plano Lite](#lite-plan) grátis com uma quantia fixa de
capacidade de rendimento e dados para propósitos de desenvolvimento e avaliação. Há
também um [plano Padrão](#standard-plan) pago que oferece capacidade de rendimento provisionado configurável
e precificação de armazenamento de dados que escala conforme seus requisitos de aplicativo
mudam.  Um [plano Hardware dedicado](#dedicated-hardware-plan) opcional também está disponível por uma
taxa mensal adicional para executar uma ou mais de suas instâncias do plano Padrão
em um ambiente de hardware dedicado. O ambiente de hardware dedicado
é para seu uso exclusivo e, quando uma instância do plano Hardware dedicado é provisionada
em um local dos Estados Unidos, é possível selecionar opcionalmente uma configuração compatível com
[HIPAA ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){:new_window}.

A tabela a seguir resume a capacidade de rendimento provisionado e a configuração de
espaço em disco para os planos:

<table border='1'>

<tr>
<th>Planos</th><th>Lite</th><th colspan='4'>Padrão</th>
</tr>
<tr>
<td>Preço base (por hora)</td>
<td>US$ 0,00</td>
<td colspan='4'>Veja <a href="https://www.ibm.com/cloud/cloudant/pricing" target="_blank">Detalhes de precificação <img src="../images/launch-glyph.svg" alt="Ícone de link externo" title="Ícone de link externo"></a>.</td>
</tr>
<tr>
<td>Capacidade de rendimento provisionado (Consultas por segundo)</td>
<td>20</td>
<td>100</td>
<td>1.000</td>
<td>5.000</td>
<td>20.000</td>
</tr>
<tr>
<td>Capacidade de rendimento provisionado (Gravações por segundo)</td>
<td>10</td>
<td>50</td>
<td>500</td>
<td>2.500</td>
<td>10.000</td>
</tr>
<tr>
<td>Capacidade de rendimento provisionado (Consultas por segundo)</td>
<td>5</td>
<td>5</td>
<td>50</td>
<td>250</td>
<td>1.000</td>
</tr>
<tr>
<td>Tamanho máximo do documento individual</td>
<td>1 MB</td>
<td colspan='4'>1 MB</td>
</tr>
<tr>
<td>Espaço em disco incluído</td>
<td>1 GB</td>
<td colspan='4'>20 GB</td>
</tr>
<tr>
<td>Disco excedente (por GB/hora)</td>
<td>Não está disponível</td>
<td colspan='4'>Veja <a href="https://www.ibm.com/cloud/cloudant/pricing" target="_blank">Detalhes de precificação <img src="../images/launch-glyph.svg" alt="Ícone de link externo" title="Ícone de link externo"></a>.</td>
</tr>

</table>

## Planos

É possível selecionar qual plano usar ao
[provisionar sua instância de serviço do {{site.data.keyword.cloudant_short_notm}}](#provisioning-a-cloudant-instance-on-bluemix).
Por padrão,
o [plano Lite](#lite-plan) é selecionado.

![{{site.data.keyword.cloudant_short_notm}} seleção de plano da instância de serviço](../images/fb87416a.png)

### Plano Lite

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

O plano Padrão inclui 20 GB de armazenamento de dados.
Se você armazenar mais de 20 GB,
será cobrado um custo definido por GB por hora.
Veja as informações de [Precificação ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/cloud/cloudant/pricing){:new_window} para o custo atual.
No plano Padrão,
também será possível mudar a quantia de capacidade de rendimento provisionado para pesquisas,
gravações
e consultas.

### Plano de hardware dedicado

É possível, opcionalmente, executar suas instâncias do plano Padrão em um ambiente de hardware dedicado em
qualquer [data center do {{site.data.keyword.IBM}} ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/cloud-computing/bluemix/data-centers)
por uma taxa mensal. Você compra um único plano de hardware dedicado para um determinado local
e pode fornecer uma ou mais instâncias do plano Padrão nele. Esse plano é necessário para
conformidade com HIPAA e deve ser selecionado no tempo de fornecimento. Observe que o plano Hardware dedicado
não está disponível para clientes do {{site.data.keyword.Bluemix_notm}} Dedicated e está disponível somente para clientes do
{{site.data.keyword.Bluemix_notm}} Public.

## Capacidade de rendimento provisionada

A provisão de rendimento é identificada e medida como um de três tipos de eventos:

1.	Uma consulta,
que é uma leitura de um documento específico,
com base no `_id` do documento.
2.	Uma gravação,
que é a criação,
a modificação
ou a exclusão de um documento individual
ou qualquer atualização devido a uma construção de índice.
3.	Uma consulta,
que é uma solicitação feita a um dos terminais de consulta do {{site.data.keyword.cloudant_short_notm}},
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

Por exemplo,
se você estiver no plano Padrão com provisão para 200 consultas por segundo,
sua conta poderá fazer no máximo 200 solicitações de consultas durante um período consecutivo de 1.000 milissegundos (1 segundo).
As solicitações subsequentes de consultas feitas durante o período deslizante de 1.000 milissegundos
serão rejeitadas até que o número de solicitações de consultas nesse período caia para menos de 200 novamente.

Quando uma solicitação é rejeitada porque o número de eventos foi excedido,
os aplicativos recebem uma resposta [`429` Muitas solicitações](../api/http.html#429).

As versões recentes das bibliotecas de clientes suportados (para as linguagens [Java](../libraries/supported.html#java),
[Node.js](../libraries/supported.html#node-js)
e [Python](../libraries/supported.html#python)) ajudam a manipular uma resposta `429`.
Por exemplo,
a biblioteca Java emitirá uma
[`TooManyRequestsException` ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://static.javadoc.io/com.cloudant/cloudant-client/2.5.1/com/cloudant/client/org/lightcouch/TooManyRequestsException.html){:new_window}.

Por padrão,
as bibliotecas de clientes suportados não tentarão novamente uma solicitação
automaticamente quando uma resposta `429` for recebida.

É melhor assegurar-se de que seu aplicativo manipule respostas `429` corretamente.
O motivo é que o número de novas tentativas é limitado;
transgredir regularmente o número de solicitações é um forte indicador
para mover para uma configuração de plano diferente.

>   **Nota**: se você estiver transportando um aplicativo existente,
    talvez ele não seja capaz de manipular uma resposta `429`.
    Como parte de sua verificação de migração,
verifique se o seu aplicativo manipula respostas `429` corretamente.

Em resumo,
deve-se assegurar que seu aplicativo seja capaz de manipular uma resposta [`429`](../api/http.html#429) corretamente.

<div id="servicetier"></div>

### Visualizando e mudando a capacidade

É possível ver detalhes da capacidade de rendimento nos planos disponíveis para sua conta.
É possível selecionar o nível de fornecimento que você deseja usar
por meio da guia Conta do Painel de sua conta do {{site.data.keyword.cloudant_short_notm}}.

![Painel da Conta](../images/cloudant_capacity.png)

Para mover para uma capacidade de rendimento diferente,
selecione o fornecimento desejado
e, em seguida, clique no botão de opção `Change Capacity`.
Você é solicitado a confirmar a mudança
e lembrado de que a mudança de fornecimento pode levar até 24 horas para ser concluída.

![Painel da Conta](../images/cloudant_capacity_change.png)

<div id="throughput"></div>

### Monitorando o uso 

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

### Espaço em disco incluído

Esse valor é a capacidade de armazenamento incluída no plano.
Ele é usado para o armazenamento de dados e de índice.

### Excedente de disco

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

Suponha que você inicie um mês de 30 dias com uma instância de serviço do plano Padrão que use 9 GB de armazenamento.
Em seguida,
seu armazenamento aumenta para 21,5 GB por 15 minutos durante a hora, iniciando às 02:00 do dia 3.
A instância cai de volta para 9,5 GB pelos próximos 10 minutos da hora 02:00
e, em seguida, aumenta para 108 GB pelos próximos 25 minutos da hora 02:00.
Finalmente,
sua instância conclui a hora e certamente o restante do mês, caindo para 28 GB.

Esse padrão significa que o número máximo de GB além da alocação do plano era 88 GB durante a hora 2 do dia 3.
Para a hora 03:00 do dia 3
e para o resto do mês,
sua instância era de 8 GB além da alocação do plano.

Portanto,
para a hora 2h do dia 3,
você será faturado por um excedente com base em 88 GB x 1 hora = 88 GB horas.

Para a hora 3h do dia 3 até o término do dia 3,
você será faturado por um excedente com base em 8 GB x 21 horas = 168 GB horas.

Para a hora 0h do dia 4 até o término do mês (de 30 dias),
você será faturado por um excedente com base em 8 GB x 24 horas x 27 dias = 5184 GB horas.

O total excedente para o mês será baseado em um total de 88 + 168 + 5184 = 5.440 GB de horas.

### Tamanho máximo do documento individual

Os dados são armazenados no {{site.data.keyword.cloudant_short_notm}} como [documentos JSON](../api/document.html).
Para documentos em um serviço {{site.data.keyword.cloudant_short_notm}} no {{site.data.keyword.Bluemix_notm}},
o tamanho máximo de um documento individual é 1 MB.
Exceder esse limite causará um erro [`413`](../api/http.html#413).

## Locais e ocupação

Por padrão, todos os planos Lite e Padrão são implementados em ambientes de
diversos locatários. Como parte da seleção de seu plano,
é possível escolher entre as regiões do {{site.data.keyword.Bluemix_notm}} Public a seguir:

-   Sul dos EUA
-   Reino Unido
-   Sydney
-   Alemanha

As instâncias do plano Hardware dedicado podem ser implementadas na maioria
dos [locais de data center do {{site.data.keyword.IBM_notm}} ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/cloud-computing/bluemix/data-centers).
Consulte o menu suspenso no catálogo do {{site.data.keyword.Bluemix_notm}} para uma lista atualizada de locais disponíveis.

## Segurança, criptografia e conformidade

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

## Alta disponibilidade, recuperação de desastre e backup

Para fornecer alta disponibilidade (HA) e recuperação de desastre (DR) em um data center, todos os dados são armazenados em triplicidade em três servidores físicos separados em um cluster. É possível provisionar contas em múltiplos data centers
e, em seguida, usar a replicação de dados contínua para fornecer HA/DR nos data centers. Os dados do {{site.data.keyword.cloudant_short_notm}} não são submetidos a backup automaticamente, mas o conjunto de ferramentas suportado é fornecido para manipular backups. Revise o
[guia de Recuperação de desastre e backup ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://console.bluemix.net/docs/services/Cloudant/guides/disaster-recovery-and-backup.html#disaster-recovery-and-backup)
para explorar todas as considerações sobre HA, DR e backup para atender aos seus requisitos de aplicativo. 

## Suporte

O suporte para as instâncias de serviço dos planos Padrão e Dedicado é opcional.
Ele é fornecido comprando o "Suporte padrão do {{site.data.keyword.Bluemix}}".
O suporte não está disponível para o plano Lite.

Uma calculadora de precificação para o suporte Padrão do {{site.data.keyword.Bluemix_notm}} está disponível
[aqui ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://console.ng.bluemix.net/?direct=classic/#/pricing/cloudOEPaneId=pricing&paneId=pricingSheet){:new_window}.
Informações sobre os detalhes do Acordo de Nível de Serviço (SLA) do Suporte estão disponíveis
[aqui ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://www-03.ibm.com/software/sla/sladb.nsf/pdf/6606-08/$file/i126-6606-08_05-2016_en_US.pdf){:new_window}.

## Provisionando uma instância do {{site.data.keyword.cloudant_short_notm}} no {{site.data.keyword.Bluemix_notm}}

É possível provisionar uma instância do plano Lite ou Padrão do {{site.data.keyword.cloudant_short_notm}} no {{site.data.keyword.Bluemix}} de duas maneiras:

- Usando o Painel. Um tutorial descrevendo o processo está disponível [aqui ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://console.bluemix.net/docs/services/Cloudant/tutorials/create_service.html#creating-a-cloudant-instance-on-bluemix){:new_window}.
- Usando a ferramenta de comando do Cloud Foundry. Um tutorial descrevendo o processo está disponível [aqui ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://console.bluemix.net/docs/services/Cloudant/tutorials/create_service_cli.html#creating-a-cloudant-instance-on-bluemix-using-the-cloud-foundry-tools){:new_window}.
 
Para criar e alavancar uma instância do plano {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware, siga o tutorial que descreve o processo [aqui ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://console.bluemix.net/docs/services/Cloudant/tutorials/create_dedicated_hardware_plan.html#creating-and-leveraging-a-cloudant-dedicated-hardware-plan-instance-on-bluemix){:new_window}.




