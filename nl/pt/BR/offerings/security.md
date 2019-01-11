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

<!-- Acrolinx: 2017-05-10 -->

# Segurança
{: #security}

## Proteção de dados e segurança do {{site.data.keyword.cloudant_short_notm}} DBaaS
{: #ibm-cloudant-dbaas-data-protection-and-security}

A proteção de dados do aplicativo para apps da web e móveis de larga escala pode ser complexa,
especialmente com bancos de dados distribuídos e NoSQL.

Assim como reduz o esforço de manter seus bancos de dados para mantê-los em execução e crescendo sem parar, o {{site.data.keyword.cloudantfull}} também assegura que seus dados permaneçam seguros e protegidos.
{:shortdesc}

## Plataformas físicas da camada superior
{: #top-tier-physical-platforms}

O {{site.data.keyword.cloudant_short_notm}} DBaaS é
hospedado fisicamente nos provedores de infraestrutura em nuvem da Camada 1, como o
{{site.data.keyword.cloud}} e a Amazon.
Portanto,
seus dados são protegidos pelas medidas de segurança física e de rede utilizadas por esses provedores,
incluindo (mas não se limitando a):

- Certificações: conformidade com SSAE16, SOC2 Tipo 1, ISAE 3402, ISO 27001, CSA e outros padrões.
- Acesso e gerenciamento de identidade.
- Segurança física geral de data centers e monitoramento do centro de operações de rede.
- Reforço do servidor.
- O {{site.data.keyword.cloudant_short_notm}} fornece a flexibilidade de
escolher ou alternar entre os diferentes provedores
conforme seus requisitos de SLA e de custo mudam.

Mais detalhes sobre as certificações estão disponíveis nas [Informações de conformidade](compliance.html).
{:tip}

## Controle de acesso seguro
{: #secure-access-control}

O {{site.data.keyword.cloudant_short_notm}} possui vários recursos de segurança integrados, para que você controle o acesso aos dados:

Recurso | Descrição
--------|------------
Autenticação | O {{site.data.keyword.cloudant_short_notm}} é acessado usando uma API HTTPS. No local que o terminal da API requerer, o usuário será autenticado para cada pedido de HTTPS que o {{site.data.keyword.cloudant_short_notm}} receber. O {{site.data.keyword.cloudant_short_notm}} suporta controles de acesso anteriores e do IAM. Para obter mais informações, consulte o [Guia do IAM](../guides/iam.html){:new_window} ou o [Documento da API de autenticação](../api/authentication.html){:new_window} anterior.
Autorização | O {{site.data.keyword.cloudant_short_notm}} suporta controles de acesso anteriores e do IAM. Para obter mais informações, consulte o [Guia do IAM](../guides/iam.html){:new_window} e o [documento da API de autorização](../api/authorization.html){:new_window} anterior.
Criptografia "In-flight" | Todo o acesso a {{site.data.keyword.cloudant_short_notm}} é criptografado usando HTTPS.
Criptografia em repouso | Todos os dados armazenados em uma instância do {{site.data.keyword.cloudant_short_notm}} são criptografados em repouso. Se você precisar do recurso bring-your-own-key (BYOK) para criptografia em repouso, ele será ativado usando o {{site.data.keyword.cloud_notm}} Key Protect. O {{site.data.keyword.cloudant_short_notm}} suporta esse recurso para novas instâncias de plano de Hardware dedicado do {{site.data.keyword.cloudant_short_notm}} que são implementadas em todas as regiões. Primeiro, crie uma instância do plano de Hardware dedicado, usando o catálogo do {{site.data.keyword.cloud_notm}}. Em seguida, envie um chamado de suporte. Nossas coordenadas de equipe de suporte obtêm as novas chaves de criptografia encryption-at-rest da instância do Hardware dedicado que são gerenciadas pela instância do Key Protect.
Lista de Desbloqueio de IP | Os clientes do {{site.data.keyword.cloudant_short_notm}} que possuem um ambiente dedicado do {{site.data.keyword.cloudant_short_notm}} podem colocar endereços IP na lista de desbloqueio para restringir o acesso a apenas servidores e usuários especificados. A lista de desbloqueio de IP não está disponível para planos Lite/Padrão do {{site.data.keyword.cloud_notm}} Public que são implementados em ambientes de vários locatários. Abra um chamado de suporte para solicitar as listas de desbloqueio de IP para um conjunto especificado de IPs ou intervalos IP. Observe que as listas de desbloqueio de IP se aplicam à API e painel do {{site.data.keyword.cloudant_short_notm}}, portanto, esteja ciente de incluir quaisquer IPs de administrador que precisem acessar o Painel do {{site.data.keyword.cloudant_short_notm}} diretamente. 
CORS | Ative o suporte CORS para domínios específicos usando o painel do {{site.data.keyword.cloudant_short_notm}}.

<!--
> **Note**: Your data is visible to the {{site.data.keyword.cloudant_short_notm}} 
> worldwide team. If you don’t 
> want our team to see your data, encrypt it before sending it to 
> {{site.data.keyword.IBM_notm}}, and avoid leaking 
> data into your document `_id` and any attachment file names. In addition, 
> when you send personal data, you must use HTTPS to ensure that it is sent securely. 
> HTTP is no longer supported.  

> **Warning**: You are responsible for verifying that 
> {{site.data.keyword.cloudant_short_notm}} can be used to store 
> your data. You must also make sure that your data does not violate applicable 
> data protection laws or any regulations that require security measures 
> beyond those specified in the {{site.data.keyword.cloudant_short_notm}} 
> system requirements and {{site.data.keyword.cloud_notm}} Services terms. You must 
> verify that the security requirements are appropriate for any personal data 
> that is processed. If you are unsure, or intend to store data that is 
> beyond the scope of the {{site.data.keyword.cloudant_short_notm}} terms and conditions, 
> you must get approval from {{site.data.keyword.IBM_notm}} to ensure that it is 
> appropriate for {{site.data.keyword.cloudant_short_notm}} to store your data.
-->

## Proteção contra perda ou distorção de dados
{: #protection-against-data-loss-or-corruption}

O {{site.data.keyword.cloudant_short_notm}} possui vários recursos
para ajudar a manter a qualidade e a disponibilidade dos dados:

Recurso | Descrição
--------|------------
Armazenamento de dados redundante e durável | Por padrão, o {{site.data.keyword.cloudant_short_notm}} salva em disco três cópias de cada documento para três nós diferentes em um cluster. O salvamento das cópias assegura que uma cópia de failover funcional de seus dados
esteja sempre disponível,
independentemente de falhas.
Replicação de dados e exportação | É possível replicar seus bancos de dados continuamente entre clusters em datacenters diferentes ou para um cluster local do {{site.data.keyword.cloudant_short_notm}} ou Apache CouchDB. Outra opção é exportar dados do
{{site.data.keyword.cloudant_short_notm}} (no formato JSON)
para outros locais ou origens (como seu próprio data center)
para redundância adicional de dados.
