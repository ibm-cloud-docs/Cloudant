---

copyright:
  years: 2019
lastupdated: "2019-03-18"

keywords: endpoints, service credentials, authentication, ibm cloudant dashboard, curl, client libraries

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

<!-- Acrolinx: 2018-07-02 -->

# Conectando
{: #connecting}

O{{site.data.keyword.cloudantfull}} é acessado por meio de uma API HTTP. Este documento descreve as diferentes partes que você usa para se conectar ao {{site.data.keyword.cloudant_short_notm}}:
- Terminais
- Credenciais de serviço
- Autenticação
- Acessando o painel do {{site.data.keyword.cloudant_short_notm}}
- Acessando programaticamente o {{site.data.keyword.cloudant_short_notm}} por meio de [curl ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://curl.haxx.se/){: new_window} ou bibliotecas do cliente
{: shortdesc}

## Terminais
{: #endpoints}

O {{site.data.keyword.cloudant_short_notm}} é acessado por meio de terminais de API HTTP. Os terminais para uma instância são
mostrados no campo de URL das credenciais de serviço geradas para a instância e na guia **Conta** > **Configurações** do
painel do {{site.data.keyword.cloudant_short_notm}}.

Todos os terminais HTTP do {{site.data.keyword.cloudant_short_notm}} devem ser acessados por meio de TLS e, portanto, começam com `https://`.

O terminal externo voltado para o público é:

`https://USERNAME.cloudant.com`

Todas as instâncias provisionadas após 1 de janeiro de 2019 incluem um terminal do domínio appdomain.cloud. O terminal externo
voltado para o público é:

`https://USERNAME.cloudantnosqldb.appdomain.cloud`

Terminais internos são incluídos em todas as instâncias implementadas em ambientes de hardware dedicado fornecidos após 1º de janeiro de 2019
fora do ambiente gerenciado pela UE. O terminal de rede interna do {{site.data.keyword.cloud_notm}} é:

`https://USERNAME.private.cloudantnosqldb.appdomain.cloud`

Em que USERNAME é o nome do serviço do usuário da instância de serviço na URL. Esse campo também serve como o nome do usuário administrativo
ao usar a autenticação do {{site.data.keyword.cloudant_short_notm}} anterior. Um exemplo de USERNAME é
de810d0e-763f-46a6-ae88-50823dc85581-bluemix e o terminal externo de exemplo resultante seria
de810d0e-763f-46a6-ae88-50823dc85581-bluemix.cloudantnosqldb.appdomain.cloud. 

## Credenciais de serviço
{: #service-credentials}

Para gerar credenciais de serviço para o {{site.data.keyword.cloudant_short_notm}} por meio do
painel do {{site.data.keyword.cloud_notm}}, consulte o tutorial [Criando uma instância do {{site.data.keyword.cloudant_short_notm}} no {{site.data.keyword.cloud_notm}}](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-an-ibm-cloudant-instance-on-ibm-cloud). Para gerar credenciais de serviço a partir de
a CLI do {{site.data.keyword.cloud_notm}}, consulte [Criando credenciais para seu serviço {{site.data.keyword.cloudant_short_notm}}
](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli#creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli). 

Aqui estão as credenciais de serviço de exemplo para uma instância do {{site.data.keyword.cloudant_short_notm}}:

```json
{
  "apikey": "MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz",
  "host": "76838001-b883-444d-90d0-46f89e942a15-bluemix.cloudant.com",
  "iam_apikey_description": "Auto generated apikey during resource-key [...]",
  "iam_apikey_name": "auto-generated-apikey-050d21b5-5f[...]",
  "iam_role_crn": "crn:v1:bluemix:public:iam::::serviceRole:Manager",
  "iam_serviceid_crn": "crn:v1:staging:public:iam-identity::[...]",
  "password": "8fb6a16b48903e87b769e7f4968521e85c2394ed8f0e69b2769e56dcb27d2e76",
  "port": 443,
  "url": "https://<username>:<password>@76838001-b883-444d-90d0-46f89e942a15-bluemix.cloudant.com",
  "username": "76838001-b883-444d-90d0-46f89e942a15-bluemix"
}
```
{: codeblock}

As credenciais de serviço incluem os campos a seguir:

Campo | Propósito
------|--------
`username` | O nome do serviço do usuário da instância de serviço na URL. Esse campo também serve como o nome de usuário administrativo. 
`password` | A senha de credenciais anteriores que é necessária para que os aplicativos acessem a instância de serviço. Esse campo será exibido apenas se a opção `Usar as credenciais anteriores e o IAM` for escolhida. 
`host` | O nome do host usado por aplicativos para localizar a instância de serviço. Esse campo será exibido apenas se a opção `Usar as credenciais anteriores e o IAM` for escolhida. 
`port` | O número da porta HTTPS para acessar a instância de serviço no host. Ele é 443, pois apenas o acesso HTTPS é permitido pelo {{site.data.keyword.cloudant_short_notm}}. Esse campo será exibido apenas se a opção `Usar as credenciais anteriores e o IAM` for escolhida. 
`url`	| A URL HTTPS para acessar a instância do {{site.data.keyword.cloudant_short_notm}}. Se a opção `Usar as credenciais anteriores e o IAM` for escolhida, ela também incluirá o nome de usuário e a senha anteriores integrados. 
`apikey` | A chave de API do IAM. 
`iam_apikey_description` | Descrição da chave de API do IAM. 
`iam_apikey_name` | ID da chave de API do IAM.
`iam_role_crn` | A função do IAM que a chave de API do IAM possui.
`iam_serviceid_crn`	| O CRN do ID do serviço.

## Autenticação
{: #authentication-overview}

O {{site.data.keyword.cloudant_short_notm}} possui dois métodos de autenticação disponíveis no tempo de fornecimento,
`Usar apenas o IAM` ou `Usar as credenciais anteriores e o IAM`. Será possível ver os detalhes sobre suas credenciais anteriores nas credenciais de
serviço somente se o método de autenticação `Use both legacy credentials and IAM` for escolhido. As credenciais são exibidas na guia Credenciais
de serviço de sua instância. Para obter mais informações, consulte o
[Guia do IAM](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-)
 e o documento de [autenticação anterior](/docs/services/Cloudant?topic=cloudant-authentication#authentication) para obter detalhes sobre como usar
 o estilo de autenticação.
 
A equipe do {{site.data.keyword.cloudant_short_notm}} recomenda que você use controles de acesso do IAM para autenticação sempre que possível. Se você estiver usando a autenticação do {{site.data.keyword.cloudant_short_notm}} anterior, recomenda-se usar [chaves de API](/docs/services/Cloudant?topic=cloudant-authorization#api-keys){: new_window} em vez de credenciais de nível de conta para acesso programático e tarefas de replicação.
{: important}

## {{site.data.keyword.cloudant_short_notm}} Painel
{: #ibm-cloudant-dashboard}

É possível abrir o painel do {{site.data.keyword.cloudant_short_notm}} para a sua instância, acessando a guia Gerenciar da
página de detalhes da instância do painel do {{site.data.keyword.cloud_notm}}. É possível usar o botão `Ativar` ou `Ativar o painel do Cloudant`
para abrir o painel em uma nova guia do navegador. O painel do {{site.data.keyword.cloudant_short_notm}} permite que você execute as tarefas a seguir:

- Monitorar o consumo atual da instância
- Executar CRUD (criar, ler, atualizar, excluir) em bancos de dados, documentos e índices do {{site.data.keyword.cloudant_short_notm}}
- Configurar e visualizar tarefas de replicação
- Visualizar tarefas ativas
- Visualizar e atualizar informações da conta, como capacidade de rendimento, anúncios, CORS e configurações provisionados

## Acesso programático
{: #programmatic-access}

### Linha de comandos (curl)
{: #command-line-curl-}

É possível aproveitar o utilitário de linha de comandos curl para acessar a API HTTPS do {{site.data.keyword.cloudant_short_notm}}. 

Se você usar a autenticação do {{site.data.keyword.cloudant_short_notm}} anterior, consulte a
[Visão geral de referência da API](/docs/services/Cloudant?topic=cloudant-api-reference-overview#api-reference-overview) para obter detalhes sobre como fornecer um nome de usuário e
uma senha para acessar a API do {{site.data.keyword.cloudant_short_notm}} com curl, conforme mostrado nos exemplos de referência da API.

Se você usar a autenticação IAM do {{site.data.keyword.cloud_notm}}, deverá primeiro obter um token do IAM do {{site.data.keyword.cloud_notm}} usando uma chave de API. Em seguida, você passa o token do IAM para a instância do {{site.data.keyword.cloudant_short_notm}} para autenticar. Consulte o tutorial [Passando um
token do IAM do {{site.data.keyword.cloud_notm}} para autenticar com a API de um serviço](https://cloud.ibm.com/docs/services/iam?topic=iam-iamapikeysforservices#token_auth){: new_window} 
. 

Não é possível usar uma chave de API do IAM diretamente para autenticar com relação ao {{site.data.keyword.cloudant_short_notm}}.
{: note}

### Bibliotecas do cliente
{: #client-libraries-overview}

O {{site.data.keyword.cloudant_short_notm}} tem bibliotecas do cliente oficiais para Java, Node.js, Python, Swift e Mobile. Para obter mais informações, consulte a [documentação de bibliotecas do cliente](/docs/services/Cloudant?topic=cloudant-client-libraries#client-libraries) para acessar as bibliotecas e ver exemplos para se conectar a uma instância do {{site.data.keyword.cloudant_short_notm}}
por meio de cada uma delas. 
