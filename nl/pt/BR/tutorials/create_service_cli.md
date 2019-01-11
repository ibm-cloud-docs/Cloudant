---

copyright:
  years: 2017, 2018
lastupdated: "2018-10-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:tip: .tip}

<!-- Acrolinx: 2018-08-20 -->

# Criando uma instância do {{site.data.keyword.cloudant_short_notm}} no {{site.data.keyword.cloud_notm}} usando a CLI do {{site.data.keyword.cloud_notm}}

Este tutorial mostra como criar uma instância de serviço do {{site.data.keyword.cloudantfull}} no {{site.data.keyword.cloud}} usando a CLI do {{site.data.keyword.cloud_notm}}.
{:shortdesc}

## Pré-requisitos 

Para seguir esse tutorial, deve-se primeiro instalar as ferramentas do desenvolvedor da CLI {{site.data.keyword.cloud_notm}}. Para obter mais informações sobre a instalação das ferramentas, consulte o tutorial [Introdução à CLI do {{site.data.keyword.cloud_notm}} ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://console.bluemix.net/docs/cli/index.html#overview){:new_window}.

## Identificando o terminal de API do {{site.data.keyword.cloud_notm}}

Especifique o terminal da API de destino para seus comandos {{site.data.keyword.cloud_notm}}:

```sh
Ibmcloud api https://api.ng.bluemix.net
```
{:codeblock}

O resultado confirma que você identificou corretamente o terminal:

```sh
Setting api endpoint to https://api.ng.bluemix.net...
OK

API endpoint:   https://api.ng.bluemix.net (API version: 2.54.0)
Not logged in. Use 'login ibmcloud' para efetuar login.
```
{:pre}

## Efetuando login em sua conta do {{site.data.keyword.cloud_notm}}

O exemplo a seguir descreve o processo de login. Se você está usando um ID de usuário federado, é importante que você alterne para uma senha descartável (`ibmcloud login -- sso`) ou use uma chave de API (`ibmcloud -- apikey key ou @key_file`) para autenticar. Para obter mais informações sobre como efetuar login usando a CLI, consulte [Comandos gerais da CLI (ibmcloud)![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://console.bluemix.net/docs/cli/reference/ibmcloud/bx_cli.html#ibmcloud_login){:new_window} sob `ibmcloud login`. 

1.  Inicie o processo de login para sua conta {{site.data.keyword.cloud_notm}} usando o comando a seguir:
  
  ```sh
  Login do ibmcloud
  ```
  {:codeblock}
  
  O {{site.data.keyword.cloud_notm}} responde lembrando-o do terminal de API atual e solicita o endereço de e-mail de sua conta:
  
  ```sh
  API endpoint: https://api.ng.bluemix.net
  
  Email>
  ```
  {:pre}

2.  Insira o endereço de e-mail de sua conta e, em seguida, insira sua senha:

  ```sh
  API endpoint: https://api.ng.bluemix.net
  
  Email> J.Doe@email.com
  
  Password>
  ```
  {:pre}
  
  O {{site.data.keyword.cloud_notm}} valida seus detalhes e resume as informações sobre sua sessão de login:

  ```sh
  API endpoint: https://api.ng.bluemix.net
  
  Email> J.Doe@email.com
  
  Password> 
  Authenticating...
  OK
  
  Targeted account J DOE's Account (707...a32)
  
  Targeted org J.Doe@email.com
  
  Targeted space dev
  
  API endpoint:   https://api.ng.bluemix.net (API version: 2.54.0)
  Region:         us-south
  User:           j.doe@email.com
  Account:        J DOE's Account (707...a32)
  Org:            J.Doe@email.com
  Space:          dev
  ```
  {:pre}

3.  Agora você está com login efetuado na sua conta {{site.data.keyword.cloud_notm}}.

## Escolhendo o plano do {{site.data.keyword.cloudant_short_notm}} para seu serviço

Consulte a seção [Planos ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://console.bluemix.net/docs/services/Cloudant/offerings/bluemix.html#plans){:new_window} da documentação para obter detalhes sobre o uso do plano {{site.data.keyword.cloudant_short_notm}} Lite ou Padrão.
{:pre}

## Criando o serviço {{site.data.keyword.cloudant_short_notm}}

O {{site.data.keyword.cloudant_short_notm}} usa Grupos de recursos para fornecimento de novas instâncias em vez de organizações e espaços do Cloud Foundry. As instâncias do {{site.data.keyword.cloudant_short_notm}} que são provisionadas no passado ainda podem ser implementadas nas organizações e espaços do Cloud Foundry. Para obter mais informações, consulte o [Como o IBM Cloudant trabalha com o IBM Cloud Resource Groups? ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo") ](https://console.bluemix.net/docs/services/Cloudant/guides/resource-groups.html#how-does-ibm-cloudant-work-with-ibm-cloud-resource-groups-){:new_window} guia.

Primeiro, configure seu Grupo de recursos de destino e a região conforme mostrado em [Comandos gerais da CLI (ibmcloud) ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://console.bluemix.net/docs/cli/reference/ibmcloud/bx_cli.html#ibmcloud_target){:new_window} em `ibmcloud target` usando o formato a seguir:

```sh
Destino ibmcloud [-r REGION_NAME ] [-g RESOURCE_GROUP ]
```

Para obter uma lista de regiões, execute este comando:

```sh
regiões ibmcloud
```

Para obter uma lista de grupos de recursos, execute este comando: 

```sh
grupos de recursos ibmcloud
```

Segundo, para criar uma instância de serviço, o formato de comando básico no {{site.data.keyword.cloud_notm}} é o seguinte:

```sh
ibmcloud resource service-instance-create NAME SERVICE_NAME|SERVICE_ID SERVICE_PLAN_NAME|SERVICE_PLAN_ID LOCATION [-p, --parameters @JSON_FILE | JSON_STRING ]
```
{:pre}

Os campos são descritos na tabela a seguir: 


Campo | Descrição
------|------------
`NAME` | Nome arbitrário que você dá para a instância. 
`SERVICE_NAME` | ` cloudantnosqldb `
`PLAN_NAME` | Plano Lite ou plano padrão.
`LOCATION` | O local em que você deseja implementar: Norte da Ásia-Pacífico, Alemanha, Global, Sydney, Reino Unido, Leste dos EUA ou Sul dos EUA. 
`legacyCredentials` | Padronizado como true. Esse campo determina se a instância usa as credenciais anteriores e do IAM ou apenas as credenciais do IAM. 

Para obter mais informações sobre a escolha de um método de autenticação, consulte o [Guia do IAM](../guides/iam.html#ibm-cloud-identity-and-access-management-iam-){:new_window}.

Neste exemplo, queremos criar uma instância de um serviço {{site.data.keyword.cloudant_short_notm}} usando o plano `Lite` (em que o nome da instância é `cs20170517a` no local Sul dos EUA e usa apenas credenciais do IAM), você cria essa instância usando um comando semelhante ao exemplo a seguir:

```sh
ibmcloud resource service-instance-create cs20170517a cloudantnosqldb lite us-south -p '{"legacyCredentials": false}'
```
{:codeblock}

Depois de criar a instância de serviço, o {{site.data.keyword.cloud_notm}} responde com uma mensagem semelhante ao exemplo a seguir:

```sh
Creating service instance cs20170517a in resource group default of account John Does's Account as j.doe@email.com...
OK
Service instance cs20170517a was created.
Name          Location   State    Type               Tags
cs20170517a   us-south   active   service_instance
```
{:pre}

## Criando credenciais para seu serviço {{site.data.keyword.cloudant_short_notm}}

Os aplicativos que requerem acesso ao serviço do {{site.data.keyword.cloudant_short_notm}}
devem ter as credenciais necessárias.

As credenciais de serviço são valiosas. Se qualquer pessoa ou qualquer aplicativo tiver acesso às credenciais, eles poderão efetivamente fazer o que desejarem com a instância de serviço. Por exemplo, eles podem criar dados espúrios ou excluir informações de valor. Proteja essas credenciais cuidadosamente.
{: tip}

Para obter mais informações sobre os campos incluídos nas credenciais de serviço, consulte o [Guia do IAM](../guides/iam.html#ibm-cloud-identity-and-access-management-iam-){:new_window}.

O formato básico do comando para criar credenciais para uma instância de serviço
no {{site.data.keyword.cloud_notm}} é como a seguir:

```sh
ibmcloud resource service-key-create NAME ROLE_NAME --instance-name SERVICE_INSTANCE_NAME
```
{:pre}

Os campos são descritos na tabela a seguir:

Campo | Descrição
------|------------
`NAME` | Nome arbitrário dado às credenciais de serviço. 
`ROLE_NAME` | Este campo atualmente permite apenas a função de Gerenciador.
`SERVICE_INSTANCE_NAME` | O nome que você dá a sua instância do {{site.data.keyword.cloudant_short_notm}}. 

Se desejar criar credenciais para a instância `cs20170517a` de
um serviço do {{site.data.keyword.cloudant_short_notm}} (em que o nome para as credenciais é `creds_for_cs20170517a`), crie essas credenciais usando um comando semelhante ao exemplo a seguir:

```sh
ibmcloud resource service-key-create creds_for_cs20170517a Manager --instance-name cs20170517a
```
{:codeblock}
Depois de receber a solicitação para criar credenciais para a instância de serviço,
o {{site.data.keyword.cloud_notm}} responderá com uma mensagem semelhante ao exemplo a seguir:

```sh
Creating service key in resource group default of account John Does's Account as john.doe@email.com...
OK
Service key crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a was created.
                  
Name: creds_for_cs20170517a ID: crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a Created At: Tue Sep 18 19:58:38 UTC 2018 State: active Credentials: iam_apikey_name: auto-generated-apikey-621ffde2-ea10-4318-b297-d6d849cec48a iam_role_crn: crn:v1:bluemix:public:iam::::serviceRole:Manager url: https://f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix:5811381f6daff7255b288695c3544be63f550e975bcde46799473e69c7d48d61@f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix.cloudant.com username: f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix port: 443 apikey: XXXXX-XXXXXX_XXXXXXXXXXXXX-XXXXXXXXXXX host: f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix.cloudant.com iam_apikey_description: Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42116849bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:: iam_serviceid_crn: crn:v1:bluemix:public:iam-identity::a/b42116849bb7e2abb0841ca25d28ee4c::serviceid:ServiceId-53f9e2a2-cdfb-4f90-b072-bfffafb68b3e password: 581138...7d48d61 
```
{:pre}

## Listando as credenciais de serviço para seu serviço {{site.data.keyword.cloudant_short_notm}}

O formato básico do comando para recuperar as credenciais para uma instância de serviço
no {{site.data.keyword.cloud_notm}} é como a seguir:

```sh
serviço de recurso ibmcloud-chave KEY_NAME
```
{:pre}

Neste exemplo, desejamos recuperar as credenciais para a instância `cs20170517a` de um serviço {{site.data.keyword.cloudant_short_notm}} (em que o nome para as credenciais é `creds_for_cs20170517a`), você recupera as credenciais usando um comando semelhante ao exemplo a seguir:

```sh
ibmcloud resource service-key creds_for_cs20170517b
```
{:codeblock}

Depois de receber a solicitação para recuperar as credenciais da instância de serviço,
o {{site.data.keyword.cloud_notm}} responderá com uma mensagem semelhante ao exemplo (abreviado) a seguir:

```sh
Retrieving service key in resource group default of account John Does's Account as john.doe@email.com...
OK
Service key crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a was created.
                  
Name: creds_for_cs20170517a ID: crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a Created At: Tue Sep 18 19:58:38 UTC 2018 State: active Credentials: iam_apikey_name: auto-generated-apikey-621ffde2-ea10-4318-b297-d6d849cec48a iam_role_crn: crn:v1:bluemix:public:iam::::serviceRole:Manager url: https://f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix:5811381f6daff7255b288695c3544be63f550e975bcde46799473e69c7d48d61@f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix.cloudant.com username: f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix port: 443 apikey: XXXXX-XXXXXX_XXXXXXXXXXXXX-XXXXXXXXXXX host: f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix.cloudant.com iam_apikey_description: Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42116849bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:: iam_serviceid_crn: crn:v1:bluemix:public:iam-identity::a/b42116849bb7e2abb0841ca25d28ee4c::serviceid:ServiceId-53f9e2a2-cdfb-4f90-b072-bfffafb68b3e password: 581138...7d48d61 
```
{:pre}

## Usando sua instância de serviço do {{site.data.keyword.cloudant_short_notm}}

Agora, você concluiu as tarefas a seguir:

1.  Criou uma instância de serviço do {{site.data.keyword.cloudant_short_notm}} no {{site.data.keyword.cloud_notm}}.
2.  Criado credenciais para a instância de serviço do {{site.data.keyword.cloudant_short_notm}}.
3.  Recuperado as credenciais da instância de serviço, para que elas possam ser usadas por seu aplicativo.

Para obter mais informações, consulte o tutorial [Criando e preenchendo um banco de dados {{site.data.keyword.cloudant_short_notm}} simples no {{site.data.keyword.cloud_notm}} ](../tutorials/create_database.html#context){:new_window} que mostra como usar uma instância de serviço do {{site.data.keyword.cloudant_short_notm}} por meio de um aplicativo Python usando credenciais anteriores. Lembre-se de substituir as credenciais criadas neste tutorial.

## (Opcional) Tidindo após

A lista pequena de comandos a seguir pode ser útil na organização de seu ambiente de desenvolvimento.

### Excluindo credenciais de serviço

Para excluir um conjunto de credenciais de serviço, use um comando como este:

```sh
Serviço de recurso ibmcloud-key-delete KEY_NAME
```
{:pre}

Por exemplo, para excluir as credenciais chamadas `creds_for_cs20170517a`, use um comando como este:

```sh
ibmcloud resource service-key-delete creds_for_cs20170517a
```
{:pre}

### Excluindo uma instância de serviço

Para excluir uma instância de serviço, use um comando como este:

```sh
ibmcloud resource service-instance-delete SERVICE_INSTANCE_NAME
```
{:pre}

Por exemplo, para excluir a instância `cs20170517a` de um serviço {{site.data.keyword.cloudant_short_notm}}, use um comando como este:

```sh
ibmcloud resource service-instance-delete cs20170517a
```
{:pre}

