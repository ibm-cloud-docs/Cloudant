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

<!-- Acrolinx: 2018-08-14 -->

# Migrando para o  {{site.data.keyword.cloudant_short_notm}}  no  {{site.data.keyword.cloud_notm}}
 
A oferta de banco de dados como um serviço do [{{site.data.keyword.cloudantfull}}](https://www.ibm.com/cloud/cloudant) é um armazenamento de documentos JSON que é executado em clusters de vários locatários. O serviço está disponível com uma opção de locais geográficos com custos previsíveis, escalabilidade e um acordo de nível de serviço (SLA).

Este documento descreve como migrar para uma instância de plano {{site.data.keyword.cloudant_short_notm}} Lite ou Padrão no {{site.data.keyword.cloud_notm}} por meio de um dos planos a seguir:

Plano | Descrição
-----|------------
{{site.data.keyword.cloudant_short_notm}}  Empresa | Clusters Dedicados, de Locatário Único
{{site.data.keyword.cloudant_short_notm}}  Plano Compartilhado | Um serviço legado pay-as-você-go, multi-tenant  {{site.data.keyword.cloudant_short_notm}} . O plano Compartilhado `cloudant.com` se tornou obsoleto em março de 2018. O plano {{site.data.keyword.cloudant_short_notm}} Compartilhado foi descontinuado para novas assinaturas em outubro de 2016 e está se tornando obsoleto no quarto trimestre de 2018.
{{site.data.keyword.cloudant_localfull}} | A instalação empacotada e empacotada do  {{site.data.keyword.cloudant_short_notm}}.
Apache CouchDB | O banco de dados de software livre auto-hospedado no qual o {{site.data.keyword.cloudant_short_notm}} se baseia.

## Quais são os benefícios dos planos {{site.data.keyword.cloudant_short_notm}} Lite e Padrão?

O plano Padrão permite *reservar capacidade de rendimento* para seu serviço de banco de dados, ou seja, especificar quanto rendimento o banco de dados do seu aplicativo precisará para manipular a demanda. O plano Padrão também cobra pela quantidade de armazenamento que você usa. A capacidade é medida usando as métricas a seguir:

de Métrica | Descrição
-------|------------
Consultas por segundo | A taxa em que as buscas de documentos simples são executadas, por exemplo, recuperando um documento por seu `_id`.
Gravações por segundo | A taxa na qual os dados são gravados no banco de dados. Chamadas API que lidam com a criação de documento, atualização ou contagem de exclusão como 'gravações'.
Consultas por Segundo | A taxa na qual o banco de dados é consultado, tipicamente acessando o terminal `_find` ou usando índices de MapReduce secundários.
Armazenamento | A quantidade de espaço em disco ocupada por seus dados JSON, anexos e índices secundários.

Como exemplo, o plano Lite oferece 20 consultas por segundo, 10 gravações por segundo, 5 consultas por segundo e 1 GB de armazenamento gratuitamente. Esse plano é ideal quando se está "testando" o produto e durante o desenvolvimento do produto. Quando seu aplicativo entra em produção, deve-se alternar para o plano Padrão. O menor pacote do plano Padrão tem 100 consultas por segundo, 50 gravações por segundo, 5 consultas por segundo e 20 GB de armazenamento (o armazenamento extra é cobrado por GB) por ~76,65 USD por mês. 

Usando a régua de controle no painel do {{site.data.keyword.cloudant_short_notm}}, é possível reservar uma capacidade menor ou maior para seu serviço {{site.data.keyword.cloudant_short_notm}} sempre que precisar dela:

![slider](../images/migrate2.gif)

A quantia que você pode mudar a capacidade de rendimento é limitada a um máximo de 10 unidades por mudança (observe o ponto de 'limite de mudança' na régua de controle) com um máximo de uma mudança por hora. As mudanças para baixo são ilimitadas em magnitude, mas ainda estão sujeitas ao limite de tempo.
{: tip}

Você é cobrado pela maior capacidade que está selecionada em qualquer janela de hora em hora fornecida. Seu rendimento do banco de dados pode ser aumentado para lidar com demandas sazonais e diminuído novamente para os momentos calmos. Em todos os momentos, sua fatura mensal é previsível, os upgrades são automáticos e seu SLA é [99,95%](http://www-03.ibm.com/software/sla/sladb.nsf/sla/bm-6627-03).

Se você exceder sua cota de consultas, gravações e consultas em um determinado segundo, o cluster do {{site.data.keyword.cloudant_short_notm}} responderá com uma resposta `HTTP 429`. Seu aplicativo pode tentar novamente a solicitação posteriormente - nossas bibliotecas oficiais oferecem a opção de tentar novamente tais solicitações com um retrocesso exponencial. 

## Que tipo de plano do {{site.data.keyword.cloudant_short_notm}} eu tenho?

Se você estiver usando o {{site.data.keyword.cloudant_short_notm}}, o painel do {{site.data.keyword.cloud_notm}} mostrará todas as instâncias do {{site.data.keyword.cloudant_short_notm}} juntamente com uma coluna Plano. Os planos Lite, Padrão e Hardware dedicado são chamados especificamente. Qualquer instância do {{site.data.keyword.cloudant_short_notm}} que mostre o nome do plano Dedicado compartilhado faz parte de um ambiente dedicado do {{site.data.keyword.cloudant_short_notm}} e não do plano Compartilhado público. Qualquer instância do {{site.data.keyword.cloudant_short_notm}} que mostre um nome de plano Compartilhado ou não possua um nome de plano nessa coluna está usando o plano Compartilhado descontinuado. No exemplo a seguir, as instâncias 'Cloudant NoSQL DB-ix' e 'Cloudant_NewConsole' usam o plano Compartilhado descontinuado.  

![cloud dash](../images/ibmclouddashboard.png)

Também é possível realizar drill down em uma instância específica e observar a guia Plano. As instâncias do {{site.data.keyword.cloudant_short_notm}} no plano Compartilhado descontinuado não têm um plano destacado. Uma instância no {{site.data.keyword.cloudant_short_notm}} plano Padrão é semelhante a este exemplo: 

![standard dash](../images/ibmcloud_instance_standard_plan.png)

Também é possível abrir o painel do {{site.data.keyword.cloudant_short_notm}} e clicar na guia **Conta**. Um plano Lite é semelhante ao exemplo a seguir:

![lite plan](../images/migrate1.png)

Se você estiver usando uma conta do `cloudant.com` anterior, será possível efetuar login no painel do {{site.data.keyword.cloudant_short_notm}} e ir para a guia Conta. Um plano Compartilhado anterior do `cloudant.com` possui uma guia Uso com gráficos e estimativas de faturamento para o mês atual, como o exemplo a seguir:

![shared plan](../images/cloudantcom_sharedplan_usage.png)

Um usuário corporativo `cloudant.com` em um cluster dedicado não tem a guia Uso em sua guia Conta. Ele se parece com o exemplo a seguir:

![plano corporativo](../images/cloudantcom_enterpriseplan_account.png)

Se a guia Conta já indicar que você está no plano Padrão, não será necessário ler mais. Você já está em um serviço {{site.data.keyword.cloudant_short_notm}} suportado pelo SLA pago. Nenhuma outra ação é necessária.

## Migrando de  {{site.data.keyword.cloudant_short_notm}}  Lite para  {{site.data.keyword.cloudant_short_notm}}  Padrão

Migre do plano Lite gratuito para o plano Padrão seguindo estas etapas: 

1.  Acesse o painel do  {{site.data.keyword.cloud_notm}} .
2.  Selecione a instância do {{site.data.keyword.cloudant_short_notm}} que você deseja migrar. 
3.  Selecione a guia **Plano** na navegação esquerda. 
4.  Na lista de planos de precificação, selecione a caixa de seleção **Padrão**. ![lite](../images/migrate3.png)
5.  Clique em **Upgrade** na parte inferior da página.
Todos os dados existentes são retidos para você.

Ajuste sua capacidade usando a régua de controle Capacidade de rendimento para aumentar ou diminuir a capacidade, conforme necessário.
{: tip} 
 
Agora, você está pronto para ir!

## Migrando todo o resto para o plano {{site.data.keyword.cloudant_short_notm}} Lite ou Padrão

A migração dos planos Compartilhados ou Corporativos para os planos {{site.data.keyword.cloudant_short_notm}} Lite ou Padrão inclui essas tarefas, que são descritas nas etapas a seguir. 

Não é possível mudar diretamente uma instância de plano Compartilhado para uma instância de plano Lite ou Padrão. A migração requer que você crie uma nova instância do plano Lite ou Padrão e replique os dados por meio da instância do plano Compartilhado.
{: tip}

### Etapa 1: Inscrever-se no {{site.data.keyword.cloud_notm}}

Se você ainda não tiver se inscrito, [inscreva-se para uma conta do {{site.data.keyword.cloud_notm}}](https://www.ibm.com/cloud/). 

### Etapa 2: Criar uma instância do  {{site.data.keyword.cloudant_short_notm}}

Depois de efetuar login em sua conta {{site.data.keyword.cloud_notm}}, inclua um serviço {{site.data.keyword.cloudant_short_notm}}. Clique no botão `Criar recurso` no painel e, em seguida, clique em `Bancos de dados` e `Cloudant`. Para obter mais informações, consulte [Como criar uma instância do {{site.data.keyword.cloudant_short_notm}} no {{site.data.keyword.cloud_notm}}](../tutorials/create_service.html#creating-an-ibm-cloudant-instance-on-ibm-cloud). 

![add {} instance](../tutorials/images/img0003.png)

### Etapa 3: Descobrir se seu aplicativo está pronto para o {{site.data.keyword.cloudant_short_notm}}

Se você estiver mudando de um serviço corporativo do {{site.data.keyword.cloudant_short_notm}} ou de um plano Compartilhado do {{site.data.keyword.cloudant_short_notm}}, deverá revisitar o uso de seu aplicativo de {{site.data.keyword.cloudant_short_notm}} para se certificar de que ele esteja pronto para manipular os limites de capacidade do plano Padrão. Para obter mais informações, consulte [Como a API {{site.data.keyword.cloudant_short_notm}} funciona](../offerings/bluemix.html#provisioned-throughput-capacity). Mais importante, você deverá se certificar de que seu aplicativo possa manipular uma resposta HTTP `429: muitas solicitações` se você exceder sua capacidade de rendimento provisionada. 

As solicitações de nova tentativa que obtêm uma resposta `429` são aceitáveis para picos de tráfego ocasionais que excedem a capacidade do plano. Se o tráfego do aplicativo está gerando rotineiramente respostas `429`, há uma boa chance de que você precise fazer upgrade para um plano maior.

Além disso, vale a pena observar que o tamanho máximo do documento individual é 1 MB no {{site.data.keyword.cloudant_short_notm}} e você receberá uma mensagem `413: entidade de solicitação muito grande` se o limite for excedido. Para obter mais informações, consulte [limites de solicitação e tamanho de documento](../offerings/bluemix.html#request-and-document-size-limits). 

### Etapa 4: Migrar dados de serviço antigos para o novo serviço 

Configure as replicações contínuas de seu serviço existente para sua conta do {{site.data.keyword.cloudant_short_notm}}. Para obter mais informações, consulte o [Guia de replicação](../guides/replication_guide.html#replication) e a [Documentação da API](../api/replication.html#replication) sobre como configurar e monitorar tarefas de replicação.

Como alternativa, efetue o check-out da ferramenta [`couchreplicate`](https://www.npmjs.com/package/couchreplicate), que é um utilitário de linha de comandos que ajuda a coordenar a transferência de dados de uma conta {{site.data.keyword.cloudant_short_notm}} para outra. Ela configura várias tarefas de replicação entre as contas de origem e de destino, assegurando que um número específico de tarefas de replicação continue de cada vez. Se você precisar migrar centenas de bancos de dados, `couchreplicate` poderá ajudar a coordenar as tarefas de replicação.

![`couchreplicate`](https://raw.githubusercontent.com/glynnbird/couchreplicate/HEAD/img/couchreplicate.gif)

Verifique se todos os seus dados são replicados para o novo serviço e se os índices são construídos.

### Etapa 5: Testando

Realize testes funcionais e de carga em seu aplicativo para se assegurar de que não haja problemas antes de migrar para a produção.

### Etapa 6: Pronto para mudar para a nova instância?

Quando você estiver pronto para mudar para a nova instância, atualize seu aplicativo com a nova URL de conta gerada automaticamente e as credenciais para a instância do {{site.data.keyword.cloudant_short_notm}}. Para obter mais informações, consulte o [tutorial de fornecimento](../tutorials/create_service.html#creating-a-cloudant-instance-on-bluemix) sobre como obter as credenciais de serviço para uma instância do {{site.data.keyword.cloudant_short_notm}}.

### Etapa 7: Desligar o serviço antigo

 Quando seu aplicativo é totalmente migrado para a instância Lite ou Padrão do {{site.data.keyword.cloudant_short_notm}}, é possível excluir a instância antiga do plano Compartilhado do {{site.data.keyword.cloudant_short_notm}} do console do {{site.data.keyword.cloud_notm}} para assegurar que não seja mais cobrada pelo serviço.

## FAQ-Perguntas mais frequentes

As Perguntas Mais Frequentes (FAQs) são publicadas pela organização {{site.data.keyword.cloudant_short_notm}} para ajudar os clientes {{site.data.keyword.IBM_notm}} a migrarem para uma instância de plano {{site.data.keyword.cloudant_short_notm}} Lite ou Padrão no {{site.data.keyword.cloud_notm}}.

## Posso fazer backup dos meus dados antes de fazer alguma coisa?

O {{site.data.keyword.cloudant_short_notm}} recomenda que você use o utilitário [couchbackup](../guides/backup-cookbook.html#cloudant-nosql-db-backup-and-recovery) para exportar dados para o disco. O [ {{site.data.keyword.cloud_notm}} Object Storage](https://www.ibm.com/cloud/object-storage) é uma solução escalável, que é barata, para armazenar os arquivos exportados. 

## Posso manter meu domínio `username.cloudant.com` e redirecioná-lo para o novo serviço no {{site.data.keyword.cloudant_short_notm}}?

Não, não é possível manter seu domínio. Deve-se planejar atualizar seus aplicativos para usar a nova URL da conta e as credenciais que são geradas para as instâncias do {{site.data.keyword.cloudant_short_notm}}.

## Com quem entro em contato no caso de dúvidas?

Entre em contato com o [suporte do {{site.data.keyword.cloudant_short_notm}}](mailto:support@cloudant.com) ou abra um chamado de dentro do painel do {{site.data.keyword.cloudant_short_notm}} se você tiver alguma pergunta sobre migração. O suporte do {{site.data.keyword.cloudant_short_notm}} ficará feliz em fornecer mais detalhes.
