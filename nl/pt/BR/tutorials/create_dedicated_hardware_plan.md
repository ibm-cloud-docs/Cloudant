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

<!-- Acrolinx: 2017-02-23 -->

# Criando e alavancando uma instância do plano Dedicated Hardware do {{site.data.keyword.cloudant_short_notm}} no {{site.data.keyword.Bluemix_notm}}

Este tutorial mostra como criar uma instância do plano Dedicated
Hardware do {{site.data.keyword.cloudantfull}}
usando o painel do {{site.data.keyword.Bluemix}} e mostra como provisionar subsequentemente uma ou mais
instâncias do plano Standard para executar nela. 

A criação de uma instância do plano Dedicated
Hardware do {{site.data.keyword.cloudant_short_notm}} resulta no fornecimento
de um ambiente do {{site.data.keyword.cloudant_short_notm}} no hardware dedicado para seu uso exclusivo. Uma instância
de serviço é criada no painel do {{site.data.keyword.Bluemix_notm}}, mas observe que não é possível
acessar a instância do plano Hardware dedicado diretamente e você não terá
nenhuma Credencial de serviço para isso. É possível usar uma instância do plano Dedicated
Hardware do {{site.data.keyword.cloudant_short_notm}}
após ela ser criada pelo fornecimento de uma ou mais instâncias de plano
Standard nela.

## Criando uma instância de plano Dedicated Hardware do {{site.data.keyword.cloudant_short_notm}}  

1.  Efetue login em sua conta do {{site.data.keyword.Bluemix_notm}}.<br/>
    O painel do {{site.data.keyword.Bluemix_notm}} pode ser localizado em:
[http://bluemix.net ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://bluemix.net){:new_window}.
    Após a autenticação com seu nome de usuário e senha,
será apresentado o painel do {{site.data.keyword.Bluemix_notm}}:<br/>
    ![Painel do {{site.data.keyword.Bluemix_notm}}](images/img0001.png)

2.  Clique no link `Catalog`:<br/>
    ![Link do catálogo do {{site.data.keyword.Bluemix_notm}}](images/img0002.png)<br/>
    Aparece uma lista dos serviços disponíveis no {{site.data.keyword.Bluemix_notm}}.

3.  Clique na entrada `Data & Analytics` sob o título `Services`:<br/>
    ![Serviços de Dados e Analítica do {{site.data.keyword.Bluemix_notm}}](images/img0003.png)<br/>
    Aparece uma lista dos serviços de Dados e Analítica
disponíveis no {{site.data.keyword.Bluemix_notm}}.

4.  Clique no serviço {{site.data.keyword.cloudant_short_notm}}:<br/>
    ![Seleção de serviço do {{site.data.keyword.Bluemix_notm}} {{site.data.keyword.cloudant_short_notm}}](images/img0004.png)<br/>
    A página para criar um serviço aparece. 

5.  Selecione o plano de hardware `Dedicated Hardware` na lista de planos de precificação na parte inferior da página:<br/>
    ![Planos de precificação](../tutorials/images/pricing_plan.png)
    
6.  Preencha os parâmetros a seguir na parte superior da página: <br/>
    -   Insira um nome de Serviço.<br/>
    -   Especifique a região e espaço para implementar.<br/>
    -   Selecione um local para implementação.<br/>
    -   Responda sim ou não para a pergunta sobre se o HIPAA é necessário. Observe que o HIPAA é válido somente para locais dos Estados Unidos.<br/> 
     
    **Nota**: você implementa e provisiona instâncias do plano Padrão na mesma região e espaço.    
    ![Configurar o hardware dedicado](../tutorials/images/select_deployment_location.png)<br/>
    Inicie o processo de fornecimento. 
    
7.  Clique no botão `Create` para começar a provisionar na parte inferior da página. <br/>
    **Nota**: o faturamento será rateado diariamente para garantir que você deseja provisionar e
    pagar por um ambiente antes de clicar no botão **Criar**.<br/>
    ![Provisionionar o hardware dedicado](../tutorials/images/create_button_provision.png)<br/>
    **Nota**: durante o fornecimento, uma roda girando aparece ao lado da instância em
    seu painel do {{site.data.keyword.Bluemix_notm}}. Uma solicitação é enviada para provisionar uma instância do plano Hardware dedicado nos
    servidores bare metal. O tempo de fornecimento é assíncrono pode levar até 5 dias.
    ![Provisionar a versão alternativa do hardware dedicado](../tutorials/images/create_button_provision2.png)<br/>
    
## Provisionando uma instância do plano Padrão em um ambiente de Hardware dedicado

1.  Efetue login em sua conta do {{site.data.keyword.Bluemix_notm}}.<br/>
    O painel do {{site.data.keyword.Bluemix_notm}} pode ser localizado em:
[http://bluemix.net ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://bluemix.net){:new_window}.
    Após a autenticação com seu nome de usuário e senha,
será apresentado o painel do {{site.data.keyword.Bluemix_notm}}:<br/>
    ![Painel do {{site.data.keyword.Bluemix_notm}}](images/img0001.png)

2.  Clique no link `Catalog`:<br/>
    ![Link do catálogo do {{site.data.keyword.Bluemix_notm}}](images/img0002.png)<br/>
    Aparece uma lista dos serviços disponíveis no {{site.data.keyword.Bluemix_notm}}.

3.  Clique na entrada `Data & Analytics` sob o título `Services`:<br/>
    ![Serviços de Dados e Analítica do {{site.data.keyword.Bluemix_notm}}](images/img0003.png)<br/>
    Aparece uma lista dos serviços de Dados e Analítica
disponíveis no {{site.data.keyword.Bluemix_notm}}.

4.  Clique no serviço {{site.data.keyword.cloudant_short_notm}}:<br>
    ![Seleção de serviço do {{site.data.keyword.Bluemix_notm}} {{site.data.keyword.cloudant_short_notm}}](images/img0004.png)<br/>
    A página para criar um serviço aparece.  

5.  Clique em `Standard` nos planos de precificação na parte inferior da página. <br/>
    **Nota**: não é possível provisionar uma instância do plano Lite em um ambiente de Hardware dedicado.<br/>
    ![Plano de precificação padrão](../tutorials/images/standard_pricing_plan.png)
    
6.  Preencha os parâmetros na parte superior da página inserindo um Nome de serviço, Nome de credencial e assim por diante,
como você faria para uma instância do plano Padrão. Decida se deseja provisionar no ambiente padrão regional de diversos locatários
ou no ambiente de Hardware dedicado que foi provisionado usando a lista suspensa `Select Environment`.<br/>
    ![Configurar a instância padrão](../tutorials/images/select_environment.png)
    
7.  Clique no botão `Create` na parte inferior da página.<br/>
    Após alguns segundos, a instância é provisionada no ambiente que você selecionou.<br/>
    ![Provisionar instância padrão](../tutorials/images/create_button_provision_standard.png)
    
8.  Obtenha suas Credenciais de serviço e acesse o Painel do {{site.data.keyword.cloudant_short_notm}} tal como você faz para uma instância de diversos locatários do {{site.data.keyword.cloudant_short_notm}}. 
    Veja mais informações sobre como localizar suas Credenciais de serviço [aqui ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://console.bluemix.net/docs/services/Cloudant/tutorials/create_service.html#locating-your-service-credentials){:new_window}. 
     
