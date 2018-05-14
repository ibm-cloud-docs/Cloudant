---

copyright:
  years: 2015, 2017
lastupdated: "2017-06-09"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-02-23 -->

# IBM Bluemix

O {{site.data.keyword.cloudant}} também está disponível como um
serviço do [{{site.data.keyword.Bluemix}} ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://console.ng.bluemix.net/catalog/services/cloudant-nosql-db/){:new_window}.
{:shortdesc}

{{site.data.keyword.Bluemix_short}} é uma plataforma de nuvem de
padrão aberto para construir,
executar
e gerenciar aplicativos.
Descubra mais sobre o {{site.data.keyword.Bluemix_notm}}
e comece a utilizá-lo
na [página inicial ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://console.ng.bluemix.net/){:new_window}.

## Bluemix Public

O {{site.data.keyword.cloudantfull}} está disponível como um [plano Lite](#lite-plan) grátis
e como várias configurações no [plano Padrão](#standard-plan) pago.
Um [plano Dedicado](#dedicated-plan) também está disponível.
Esse plano oferece a mesma configurabilidade que o plano Padrão,
mas é fornecido no hardware dedicado.
O hardware Dedicado não é compartilhado com nenhuma outra conta,
o que significa que é exclusivamente para seu uso.
Se uma instância do plano Dedicado for provisionada em um [Local dos EUA](#locations),
será possível selecionar opcionalmente uma
configuração compatível com [HIPAA ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){:new_window}.

A tabela a seguir resume as medidas de desempenho para cada um dos planos.

>   **Nota**: os detalhes na tabela são indicativos de setembro de 2016.
Para valores atuais,
entre em contato com o [Suporte do {{site.data.keyword.cloudant_short_notm}} ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](mailto:support@cloudant.com){:new_window}.

>   **Nota**: todos os valores de moeda neste documento estão em dólares americanos (US$).

<table border='1'>

<tr>
<th>Planos</th><th>Lite</th><th colspan='4'>Padrão <i>e</i> Dedicado</th>
</tr>
<tr>
<td>Preço base (por hora)</td>
<td>US$ 0,00</td>
<td colspan='4'>Veja <a href="http://cloudant.com/bluemix" target="_blank">Detalhes de precificação <img src="../images/launch-glyph.svg" alt="Ícone de link externo" title="Ícone de link externo"></a>.</td>
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
<td colspan='4'>Veja <a href="http://cloudant.com/bluemix" target="_blank">Detalhes de precificação <img src="../images/launch-glyph.svg" alt="Ícone de link externo" title="Ícone de link externo"></a>.</td>
</tr>

</table>

É possível selecionar qual plano usar ao
[provisionar sua instância de serviço do {{site.data.keyword.cloudant_short_notm}}](#provisioning-a-cloudant-instance-on-bluemix).
Por padrão,
o [plano Lite](#lite-plan) é selecionado.

![Seleção de plano da instância de serviço do Cloudant](../images/fb87416a.png)

### Plano Lite

O plano Lite é grátis,
mas limita a um máximo de 1 GB de armazenamento de dados.
Os limites também se aplicam à capacidade de rendimento provisionado para pesquisas,
gravações e consultas. 

O uso de armazenamento é verificado diariamente. Se você exceder seu limite de armazenamento, as solicitações de HTTP para a conta receberão um
código de status 402 com a mensagem de erro "A conta excedeu sua cota de uso de dados. Será necessário fazer upgrade para um plano pago".
Também aparece um banner no painel do Cloudant para informá-lo. Ainda será possível ler e excluir dados. No entanto, para gravar novos dados,
deve-se fazer upgrade para uma conta paga ou excluir dados e aguardar até que a próxima verificação seja executada para sua conta ser reativada. 

Se você quiser armazenar mais de um GB de dados
ou ter uma capacidade de rendimento maior,
mova para o [plano Padrão](#standard-plan).

### Plano padrão

O plano Padrão inclui 20 GB de armazenamento de dados.
Se você armazenar mais de 20 GB,
será cobrado um custo definido por GB por hora.
Veja as informações de [Precificação ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://cloudant.com/bluemix){:new_window} para o custo atual.
No plano Padrão,
também será possível mudar a quantia de capacidade de rendimento provisionado para pesquisas,
gravações
e consultas.

### Plano Dedicado

O {{site.data.keyword.cloudant_short_notm}} está disponível no único hardware dedicado de locatário como parte de uma
configuração do [{{site.data.keyword.Bluemix_notm}} Dedicated ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://www.ibm.com/cloud-computing/bluemix/dedicated/){:new_window}.

<div id="servicetier"></div>

## Camadas de serviço

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

### Capacidade de rendimento provisionada

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
	-	Consulta do Cloudant ([`_find`](../api/cloudant_query.html#finding-documents-using-an-index))
	-	Mudanças ([`_changes`](../api/database.html#get-changes))

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

Quando uma solicitação for rejeitada porque o número de eventos foi excedido,
os aplicativos receberão uma resposta [`429` Muitas solicitações](../api/http.html#429).

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

### Tamanho máximo do documento individual

Os dados são armazenados no {{site.data.keyword.cloudant_short_notm}} como [documentos JSON](../api/document.html).
Para documentos em um serviço {{site.data.keyword.cloudant_short_notm}} no {{site.data.keyword.Bluemix_notm}},
o tamanho máximo de um documento individual é 1 MB.
Exceder esse limite causará um erro [`413`](../api/http.html#413).

### Espaço em disco incluído

Esse valor é a capacidade de armazenamento incluída no plano.
Ele é usado para o armazenamento de dados e de índice.

### Disco excedente

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

### Um exemplo prático de excedente

Suponha que você inicie um mês de 30 dias com uma instância de serviço do plano Padrão que use 9 GB de armazenamento.
Em seguida,
seu armazenamento aumenta para 21,5 GB por 15 minutos durante a hora, iniciando às 02:00 do dia 3.
A instância cai de volta para 9,5 GB pelos próximos 10 minutos da hora 02:00
e, em seguida, aumenta para 108 GB pelos próximos 25 minutos da hora 02:00.
Por fim,
sua instância conclui a hora e certamente o restante do mês, caindo para 28 GB.

Esse padrão significa que o número máximo de GB além da alocação do plano era 88 GB durante a hora 2 do dia 3.
Para a hora 03:00 do dia 3
e para o resto do mês,
sua instância era de 8 GB além da alocação do plano.

Portanto,
para a hora 02:00 do dia 3,
você será faturado por um excedente com base em 88 GB x 1 hora = 88 GB de horas.

Para a hora 03:00 do dia 3 até o término do dia 3,
você será faturado por um excedente com base em 8 GB x 21 horas = 168 GB de horas.

Para a hora 00:00 do dia 4 até o término do mês (de 30 dias),
você será faturado por um excedente com base em 8 GB x 24 horas x 27 dias = 5184 GB de horas.

O total excedente para o mês será baseado em um total de 88 + 168 + 5184 = 5.440 GB de horas.

## Localidades

Por padrão,
todos os planos, exceto o Dedicado, se baseiam em clusters com diversos locatários.
Como parte da seleção de seu plano,
é possível escolher entre as regiões do {{site.data.keyword.Bluemix_notm}} Public a seguir:

-   Sul dos EUA
-   Reino Unido
-   Sydney
-   Alemanha

## Segurança, criptografia e conformidade

Todos os planos são fornecidos em servidores com
criptografia de disco [inativa ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://en.wikipedia.org/wiki/Data_at_rest){:new_window}.
O acesso é criptografado por meio de uma conexão de rede usando HTTPS.
Para obter mais detalhes,
veja [Segurança do DBaaS ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://cloudant.com/product/cloudant-features/dbaas-security/){:new_window}.

Os planos também oferecem
[Certificação de conformidade de segurança ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://cloudant.com/product/cloudant-features/cloudant-compliance/){:new_window}.
A conformidade [HIPAA ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){:new_window}
requer um [ambiente Dedicado](#dedicated-plan),
portanto, solicite esse ambiente como parte do [processo de fornecimento](#provisioning-a-cloudant-instance-on-bluemix).

## Alta disponibilidade, Recuperação de desastre e Backup

Para fornecer Alta disponibilidade (HA) e Recuperação de desastre (DR) em um data center,
todos os dados são armazenados em triplicidade em três servidores físicos separados em um cluster.
É possível provisionar contas em múltiplos data centers
e, em seguida, usar a replicação de dados contínua para fornecer HA/DR nos data centers.

Os dados do {{site.data.keyword.cloudant_short_notm}} não são submetidos a backup automaticamente.
É possível solicitar a ativação de um [recurso de backup incremental](../guides/backup-guide.html)
ou, como alternativa, implementar sua própria solução usando uma de várias técnicas possíveis descritas
[aqui ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://developer.ibm.com/clouddataservices/2016/03/22/simple-couchdb-and-cloudant-backup/){:new_window}.  

## Monitorando o uso

As informações sobre seu uso estão disponíveis na área de janela Uso da guia Atividade no Painel do {{site.data.keyword.cloudant_short_notm}}.

![Monitorando o uso no painel](../images/cloudant_usage.png).

Os detalhes são fornecidos lá,
ilustrando seu [rendimento](#throughput) atual
e a quantidade de [dados armazenados](#disk-space-included).

O monitoramento ajuda a reconhecer que uma mudança no fornecimento em seu plano pode ser aconselhável.
Por exemplo,
se você frequentemente aproximar o número máximo de consultas de banco de dados,
será possível modificar o fornecimento por meio da [área de janela Serviço](#servicetier) na guia Conta do Painel.

## Especificação de hardware

Todos os planos, exceto o Dedicado, são implementados em clusters com diversos locatários.
Todos os dados são armazenados em triplicidade,
em três nós físicos separados para Alta disponibilidade e Recuperação de dados.

## Suporte

O suporte para as instâncias de serviço dos planos Padrão e Dedicado é opcional.
Ele é fornecido comprando o "Suporte padrão do {{site.data.keyword.Bluemix_notm}}".
O suporte não está disponível para o plano Lite.

Uma calculadora de precificação para o suporte Padrão do {{site.data.keyword.Bluemix_notm}} está disponível
[aqui ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://console.ng.bluemix.net/?direct=classic/#/pricing/cloudOEPaneId=pricing&paneId=pricingSheet){:new_window}.
Informações sobre os detalhes do Acordo de Nível de Serviço (SLA) do Suporte estão disponíveis
[aqui ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://www-03.ibm.com/software/sla/sladb.nsf/pdf/6606-08/$file/i126-6606-08_05-2016_en_US.pdf){:new_window}.

## Provisionando uma instância do Cloudant no Bluemix

É possível provisionar uma instância do {{site.data.keyword.cloudant_short_notm}} no {{site.data.keyword.Bluemix_notm}} de duas maneiras:

-	Usando o Painel. Um tutorial descrevendo o processo está disponível [aqui](../tutorials/create_service.html).
-	Usando a ferramenta de comando do Cloud Foundry. Um tutorial descrevendo o processo está disponível [aqui](../tutorials/create_service_cli.html).
