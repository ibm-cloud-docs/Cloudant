---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: create dedicated hardware plan instance, provision standard plan instance, cli, create credentials, list service credentials

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

# Criando e alavancando uma instância de plano de Hardware dedicado do {{site.data.keyword.cloudant_short_notm}} no {{site.data.keyword.cloud_notm}}
{: #creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud}

Este tutorial mostra como criar uma instância do plano de Hardware dedicado do {{site.data.keyword.cloudantfull}} que usa o painel do {{site.data.keyword.cloud}} e mostra como provisionar subsequentemente uma ou mais instâncias do plano Padrão para serem executadas nela usando o Catálogo do {{site.data.keyword.cloud_notm}} ou a CLI do {{site.data.keyword.cloud_notm}}. 
{: shortdesc}

A criação de uma instância do plano Dedicated
Hardware do {{site.data.keyword.cloudant_short_notm}} resulta no fornecimento
de um ambiente do {{site.data.keyword.cloudant_short_notm}} no hardware dedicado para seu uso exclusivo. Uma instância de serviço é criada no painel do {{site.data.keyword.cloud_notm}}, mas não é possível acessar a instância do plano de Hardware dedicado diretamente e não haverá nenhuma Credencial de serviço para ela. É possível usar uma instância do plano Dedicated
Hardware do {{site.data.keyword.cloudant_short_notm}}
após ela ser criada pelo fornecimento de uma ou mais instâncias de plano
Standard nela.

## Criando uma instância de plano Dedicated Hardware do {{site.data.keyword.cloudant_short_notm}}
{: #creating-an-ibm-cloudant-dedicated-hardware-plan-instance}

1.  Efetue login em sua conta {{site.data.keyword.cloud_notm}}.<br/>
    O painel do {{site.data.keyword.cloud_notm}}pode ser localizado em:
   [`https://cloud.ibm.com/ ` ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://cloud.ibm.com/){: new_window}.
    Depois de autenticar-se com seu nome de usuário e senha,
você será apresentado ao painel do {{site.data.keyword.cloud_notm}}. Clique no botão `Criar Recurso`:<br/>
   ![{{site.data.keyword.cloud_notm}} dashboard](images/img0001.png)

2.  Clique em `Bancos de dados` no menu e em `Cloudant` na lista de serviços de banco de dados.<br/>
     ![Seleção do serviço {{site.data.keyword.cloud_notm}} {{site.data.keyword.cloudant_short_notm}}](images/img0003.png)<br/>

3.  Selecione o plano `Dedicated Hardware` na lista de planos de precificação:<br/>![Planos de precificação](images/pricing_plan.png)
    
4.  Preencha os parâmetros a seguir: <br/>
    -   Insira um nome de serviço.<br/>
    -   Especifique a região/o local em que deseja implementar. A região/localização será uma das seis principais regiões do {{site.data.keyword.cloud_notm}} em que você deseja que a instância seja implementada. O local físico real da instância é ditado pelo parâmetro de localização descrito na lista a seguir.<br/>
    -   Selecione um grupo de recursos.</br>
    -   Inclua uma tag. 
    -   Selecione um local para implementação. Essa localização é o local físico da instância, que pode estar em qualquer localização do {{site.data.keyword.cloud_notm}}, incluindo regiões e localizações principais fora das principais regiões. Para obter mais informações, consulte os [Data centers globais do {{site.data.keyword.IBM}} ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/cloud/data-centers/){:new_window}.<br/>
    -   Selecione `yes`ou `no`para responder se HIPAA é necessário.<br/> 
    
    HIPAA é válido apenas para locais dos EUA. O {{site.data.keyword.IBM}} pode fornecer um ambiente do plano de hardware dedicado para implementar os controles do HIPAA. Um ambiente é fornecido somente após a confirmação de um contrato de associação de negócios (BAA) que é estabelecido com o {{site.data.keyword.IBM_notm}}. Consulte [Ativando a configuração HIPAA suportada](https://cloud.ibm.com/docs/account/eu_hipaa_supported.html#enabling-the-hipaa-supported-setting) e os termos da descrição do serviço para obter mais detalhes. Fornecer um cluster para gerenciar dados HIPAA pode levar mais tempo do que o período estimado de 5 dias.
    {: note}

    ![Configurar o hardware dedicado](images/select_deployment_location.png)
        
5.  Clique no botão `Criar`para iniciar o processo de fornecimento. <br/>

    O faturamento é rateado diariamente para se certificar de que deseja provisionar e pagar por um ambiente antes de clicar no botão **Criar**.
    {: note}

    ![Provisionionar o hardware dedicado](images/create_button_provision.png)

    Durante o fornecimento, uma roda giratória aparece ao lado da instância em seu painel do {{site.data.keyword.cloud_notm}}. Uma solicitação é enviada para provisionar uma instância do plano Hardware dedicado nos
    servidores bare metal. O tempo de fornecimento é assíncrono e pode levar até 5 dias. 
    {: note}   

    ![Provisionar a versão alternativa do hardware dedicado](images/create_button_provision2.png)
    
## Provisionando uma instância do plano Padrão em um ambiente de Hardware dedicado
{: #provisioning-a-standard-plan-instance-on-a-dedicated-hardware-environment}

1.  Efetue login em sua conta {{site.data.keyword.cloud_notm}}.<br/>
    O painel do {{site.data.keyword.cloud_notm}}pode ser localizado em:
   [https://cloud.ibm.com/ ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://cloud.ibm.com/){: new_window}.
    Depois de autenticar-se com seu nome de usuário e senha,
você será apresentado ao painel do {{site.data.keyword.cloud_notm}}. Clique no botão `Criar Recurso`:<br/>
   ![{{site.data.keyword.cloud_notm}} dashboard](images/img0001.png)

2.  Clique em `Bancos de dados` no menu e em `Cloudant` na lista de serviços de banco de dados.<br/>
     ![Seleção do serviço {{site.data.keyword.cloud_notm}} {{site.data.keyword.cloudant_short_notm}}](images/img0003.png)<br/>
    A página para criar um serviço aparece.<br/>  

3.  Clique em `Standard` nos planos de precificação. <br/>![Plano de precificação Standard](images/standard_pricing_plan.png)
    
    Não é possível provisionar uma instância de plano Lite em um ambiente de Hardware dedicado.
    {: tip}
    
4.  Preencha os parâmetros a seguir: <br/>
    -   Insira um nome de serviço.<br/>
    -   Especifique a região / local em que deseja implementar.<br/>
    -   Selecione um grupo de recursos.</br>
    -   Inclua uma tag. 
    -   Selecione um método de autenticação.</br>
    -   Selecione um ambiente, que é o local em que a instância do plano Standard será implementada. Qualquer instância de ambiente de hardware dedicado implementada na conta será mostrada na lista suspensa se estiver disponível.</br>![Configurar instância padrão](images/select_environment.png)
    
5.  Clique no botão `Criar`.<br/>
    Após alguns segundos, a instância é provisionada no ambiente selecionado.<br/>
    ![Provisionar instância padrão](images/create_button_provision_standard.png)
    
6.  Obtenha suas Credenciais de serviço e acesse o Painel do {{site.data.keyword.cloudant_short_notm}} tal como você faz para uma instância de diversos locatários do {{site.data.keyword.cloudant_short_notm}}. 
    
    Para obter mais informações, consulte [Como localizar suas credenciais de serviço](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#locating-your-service-credentials){: new_window}. 
    
## Provisionando uma instância do plano Padrão em um ambiente de Hardware dedicado com a CLI do {{site.data.keyword.cloud_notm}}
{: #provisioning-a-standard-plan-instance-on-a-dedicated-hardware-environment-with-the-ibm-cloud-cli}

Para usar a CLI do {{site.data.keyword.cloud_notm}}, o login deve estar efetuado. Para obter mais informações sobre como efetuar login e configurar um grupo de recursos de destino, consulte [Efetuando login em sua conta do {{site.data.keyword.cloud_notm}}](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli#logging-in-to-your-ibm-cloud-account){: new_window}. 

Para criar uma instância de plano {{site.data.keyword.cloudant_short_notm}} Padrão em seu ambiente de plano de Hardware dedicado do {{site.data.keyword.cloudant_short_notm}}, o formato de comando básico é o seguinte:


Campo | Descrição
------|------------
`NAME`| Um nome arbitrário que você designa à instância.
`SERVICE_NAME` | ` cloudantnosqldb `
`PLAN_NAME` | Plano padrão
`LOCATION` |  O local no qual você deseja implementar, por exemplo, Sul dos EUA, Leste dos EUA ou UE - Grã-Bretanha. 

Consulte o seguinte comando de exemplo: 

```sh
ibmcloud resource service-instance-create NAME SERVICE_NAME SERVICE_PLAN_NAME LOCATION [-p, --parameters @JSON_FILE | JSON_STRING ]
```
{: codeblock}

As instâncias do {{site.data.keyword.cloudant_short_notm}} que são implementadas em ambientes de Hardware dedicados levam mais dois parâmetros:

Parâmetro | Descrição
----------|------------
`environment_crn` | Esse parâmetro deve ser configurado para o CRN da instância do plano de Hardware dedicado do {{site.data.keyword.cloudant_short_notm}}. É possível determinar o que o CRN é ao consultar o comando da CLI de exemplo na guia Gerenciar da instância do plano de Hardware dedicado do {{site.data.keyword.cloudant_short_notm}} no Painel do {{site.data.keyword.cloud_notm}}. Ou é possível determinar o que o CRN é usando o comando `ibmcloud resource service-instance SERVICE_INSTANCE_NAME`. 
`legacyCredentials` | Um parâmetro opcional padronizado como true e que determina se a instância usa credenciais anteriores e do IAM ou somente credenciais do IAM. Consulte o [Guia do IAM](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-) para obter mais detalhes sobre a escolha de um método de autenticação.

Consulte o seguinte comando de exemplo: 

```sh
ibmcloud resource service-instance-create cloudant_on_ded_hardware_cli cloudantnosqldb standard us-south -p '{"environment_crn":"crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b43434444bb7e2abb0841ca25d28ee4c:301a3118-7678-4d99-b1b7-4d45cf5f7b29::","legacyCredentials":false}'
```
{: codeblock}

## Criando as credenciais para o serviço {{site.data.keyword.cloudant_short_notm}}
{: #creating-the-credentials-for-your-ibm-cloudant-service}

Os aplicativos que requerem acesso ao serviço do {{site.data.keyword.cloudant_short_notm}}
devem ter as credenciais necessárias.

As credenciais de serviço são valiosas. Se qualquer pessoa ou qualquer aplicativo tiver acesso às credenciais, eles poderão efetivamente fazer o que desejarem com a instância de serviço. Por exemplo, eles podem criar dados espúrios ou excluir informações de valor. Proteja essas credenciais cuidadosamente.
{: important}

Para obter mais informações sobre os campos incluídos nas credenciais de serviço, consulte o [Guia do IAM](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-).

O formato básico do comando para criar credenciais para uma instância de serviço
no {{site.data.keyword.cloud_notm}} é como a seguir:

```sh
ibmcloud resource service-key-create NAME ROLE_NAME --instance-name SERVICE_INSTANCE_NAME [-p '{"service-endpoints":"internal"}]
```
{: pre}

Os campos são descritos na tabela a seguir:

Campo | Descrição
------|------------
`NAME` | Nome arbitrário dado às credenciais de serviço. 
`ROLE_NAME` | Este campo atualmente permite apenas a função de Gerenciador.
`SERVICE_INSTANCE_NAME` | O nome que você dá a sua instância do {{site.data.keyword.cloudant_short_notm}}.
`service-endpoints` | Um parâmetro opcional para preencher o campo URL nas credenciais de serviço com um terminal interno para conectar-se ao serviço por meio da rede interna do {{site.data.keyword.cloud_notm}}. Omita esse parâmetro para preencher a URL com um terminal externo publicamente acessível. Aplica-se somente às instâncias do plano Standard implementadas em ambientes de hardware dedicado que suportam terminais internos. O comando resultará em um erro 400 se o ambiente não suportar os terminais internos. 

Se desejar criar credenciais para a instância `cs20170517a`
de um serviço do {{site.data.keyword.cloudant_short_notm}} (em que o nome para as credenciais é `creds_for_cs20170517a`), crie essas credenciais usando um comando semelhante ao exemplo a seguir:

```sh
ibmcloud resource service-key-create creds_for_cs20170517a Manager --instance-name cs20170517a
```
{: codeblock}

Depois de receber a solicitação para criar credenciais para a instância de serviço,
o {{site.data.keyword.cloud_notm}} responderá com uma mensagem semelhante ao exemplo a seguir:

```sh
Creating service key in resource group default of account John Does's Account as john.doe@email.com...
OK
Service key crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a was created.
                  
Name: creds_for_cs20170517a ID: crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a Created At: Tue Sep 18 19:58:38 UTC 2018 State: active Credentials: iam_apikey_name: auto-generated-apikey-621ffde2-ea10-4318-b297-d6d849cec48a iam_role_crn: crn:v1:bluemix:public:iam::::serviceRole:Manager url: https://f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix:5811381f6daff7255b288695c3544be63f550e975bcde46799473e69c7d48d61@f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix.cloudant.com username: f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix port: 443 apikey: XXXXX-XXXXXX_XXXXXXXXXXXXX-XXXXXXXXXXX host: f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix.cloudant.com iam_apikey_description: Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42116849bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:: iam_serviceid_crn: crn:v1:bluemix:public:iam-identity::a/b42116849bb7e2abb0841ca25d28ee4c::serviceid:ServiceId-53f9e2a2-cdfb-4f90-b072-bfffafb68b3e password: 581138...7d48d61 
```
{: pre}

Se desejar criar credenciais para a instância `cs20170517a`
de um serviço do {{site.data.keyword.cloudant_short_notm}} (em que o nome para as credenciais é `creds_for_cs20170517a`) e desejar preencher a URL com o terminal interno, crie essas credenciais usando um comando semelhante ao exemplo a seguir:

```sh
ibmcloud resource service-key-create creds_for_cs20170517a Manager --instance-name cs20170517a -p '{"service-endpoints":"internal"}'
```
{: codeblock}

Depois de receber a solicitação para criar credenciais para a instância de serviço,
o {{site.data.keyword.cloud_notm}} responderá com uma mensagem semelhante ao exemplo a seguir:

```sh
Creating service key in resource group default of account John Does's Account as john.doe@email.com...
OK
Service key crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a was created.
                  
Name:          creds_for_cs20170517a   
ID:            crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a   
Created At:    Tue Jan 02 19:58:38 UTC 2019   
State:         active   
Credentials:                                   
               iam_apikey_name:          auto-generated-apikey-621ffde2-ea10-4318-b297-d6d849cec48a      
               iam_role_crn:             crn:v1:bluemix:public:iam::::serviceRole:Manager      
               url:                      https://2624fed5-e53e-41de-a85b-3c7d7636886f-bluemix.private.cloudantnosqldb.appdomain.cloud      
               username:                 f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix          
               apikey:                   XXXXX-XXXXXX_XXXXXXXXXXXXX-XXXXXXXXXXX      
               host:                     2624fed5-e53e-41de-a85b-3c7d7636886f-bluemix.private.cloudantnosqldb.appdomain.cloud      
               iam_apikey_description:   Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42116849bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3::      
               iam_serviceid_crn:        crn:v1:bluemix:public:iam-identity::a/b42116849bb7e2abb0841ca25d28ee4c::serviceid:ServiceId-53f9e2a2-cdfb-4f90-b072-bfffafb68b3e       
```
{: pre}

## Listando as credenciais de serviço para seu serviço {{site.data.keyword.cloudant_short_notm}}
{: #listing-the-service-credentials-for-your-ibm-cloudant-service}

O formato básico do comando para recuperar as credenciais para uma instância de serviço
no {{site.data.keyword.cloud_notm}} é como a seguir:

```sh
serviço de recurso ibmcloud-chave KEY_NAME
```
{: codeblock}

Neste exemplo, desejamos recuperar as credenciais para a instância `cs20170517a` de um serviço {{site.data.keyword.cloudant_short_notm}} (em que o nome para as credenciais é `creds_for_cs20170517a`), você recupera as credenciais usando um comando semelhante ao exemplo a seguir:

```sh
ibmcloud resource service-key creds_for_cs20170517b
```
{: codeblock}

Depois de receber a solicitação para recuperar as credenciais da instância de serviço,
o {{site.data.keyword.cloud_notm}} responderá com uma mensagem semelhante ao exemplo (abreviado) a seguir:

```sh
Retrieving service key in resource group default of account John Does's Account as john.doe@email.com...
OK
Service key crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a was created.
                  
Name: creds_for_cs20170517a ID: crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a Created At: Tue Sep 18 19:58:38 UTC 2018 State: active Credentials: iam_apikey_name: auto-generated-apikey-621ffde2-ea10-4318-b297-d6d849cec48a iam_role_crn: crn:v1:bluemix:public:iam::::serviceRole:Manager url: https://f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix:5811381f6daff7255b288695c3544be63f550e975bcde46799473e69c7d48d61@f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix.cloudant.com username: f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix port: 443 apikey: XXXXX-XXXXXX_XXXXXXXXXXXXX-XXXXXXXXXXX host: f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix.cloudant.com iam_apikey_description: Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42116849bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:: iam_serviceid_crn: crn:v1:bluemix:public:iam-identity::a/b42116849bb7e2abb0841ca25d28ee4c::serviceid:ServiceId-53f9e2a2-cdfb-4f90-b072-bfffafb68b3e password: 581138...7d48d61 
```
{: pre}
