---

copyright:
  years: 2017, 2019
lastupdated: "2019-03-18"

keywords: dbaas data protection, top-tier physical platforms, secure access control, data loss, corruption

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

# Segurança
{: #security}


## Proteção de dados e segurança do {{site.data.keyword.cloudant_short_notm}} DBaaS
{: #ibm-cloudant-dbaas-data-protection-and-security}

A proteção de dados do aplicativo para apps da web e móveis de larga escala pode ser complexa,
especialmente com bancos de dados distribuídos e NoSQL.

Assim como reduz o esforço de manter seus bancos de dados para mantê-los em execução e crescendo sem parar, o {{site.data.keyword.cloudantfull}} também assegura que seus dados permaneçam seguros e protegidos.
{: shortdesc}

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

Mais detalhes sobre as certificações estão disponíveis nas [Informações de conformidade](/docs/services/Cloudant?topic=cloudant-compliance#compliance).
{: tip}

## Controle de acesso seguro
{: #secure-access-control}

O {{site.data.keyword.cloudant_short_notm}} possui vários recursos de segurança integrados, para que você controle o acesso aos dados:

Recurso | Descrição
--------|------------
Autenticação | O {{site.data.keyword.cloudant_short_notm}} é acessado usando uma API HTTPS. No local que o terminal da API requerer, o usuário será autenticado para cada pedido de HTTPS que o {{site.data.keyword.cloudant_short_notm}} receber. O {{site.data.keyword.cloudant_short_notm}} suporta controles de acesso anteriores e do IAM. Para obter mais informações, consulte o [Guia do IAM](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-){: new_window} ou o [Documento da API de autenticação](/docs/services/Cloudant?topic=cloudant-authentication#authentication){: new_window} anterior.
Autorização | O {{site.data.keyword.cloudant_short_notm}} suporta controles de acesso anteriores e do IAM. A equipe do {{site.data.keyword.cloudant_short_notm}} recomenda que você use controles de acesso do IAM para autenticação sempre que possível. Se você estiver usando a autenticação do {{site.data.keyword.cloudant_short_notm}} anterior, recomenda-se usar [chaves de API](/docs/services/Cloudant?topic=cloudant-authorization#api-keys){: new_window} em vez de credenciais de nível de conta para acesso programático e tarefas de replicação. Para obter mais informações, consulte o [Guia do IAM](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-){: new_window} ou o [Documento da API de autenticação](/docs/services/Cloudant?topic=cloudant-authentication#authentication){: new_window} anterior e o [Documento da API de autorização](/docs/services/Cloudant?topic=cloudant-authorization#authorization){: new_window} anterior.
Criptografia em repouso | Todos os dados armazenados em uma instância do {{site.data.keyword.cloudant_short_notm}} são criptografados em repouso. Se você precisar do recurso bring-your-own-key (BYOK) para criptografia em repouso, ele será ativado usando o {{site.data.keyword.cloud_notm}} Key Protect. O {{site.data.keyword.cloudant_short_notm}} suporta esse recurso para novas instâncias de plano de Hardware dedicado do {{site.data.keyword.cloudant_short_notm}} que são implementadas em todas as regiões. Primeiro, crie uma instância do plano de Hardware dedicado, usando o catálogo do {{site.data.keyword.cloud_notm}}. Em seguida, envie um chamado de suporte. Nossas coordenadas de equipe de suporte obtêm as novas chaves de criptografia encryption-at-rest da instância do Hardware dedicado que são gerenciadas pela instância do Key Protect.
Criptografia "In-flight" | Todo o acesso a {{site.data.keyword.cloudant_short_notm}} é criptografado usando HTTPS.
TLS | Recomendamos que você use TLS 1.2 ou 1.3 para todos os acessos ao {{site.data.keyword.cloudant_short_notm}}. (***Em junho de 2019, o suporte do {{site.data.keyword.cloudant_short_notm}} retirará o uso de versões mais antigas (TLS 1.0 e 1.1) até o ponto em que somente o TLS 1.2+ será suportado.***) O certificado {{site.data.keyword.cloudant_short_notm}}usa para conexões HTTPS é assinado por uma Autoridade de Certificação universalmente confiável, que é pré-confiada por todos os navegadores, sistemas operacionais e outros sistemas de software como o Java Development Kit (JDK). Comprometemo-nos a sempre publicar um certificado TLS válido (não expirado) assinado por uma autoridade de certificação universalmente confiável. Não é possível, no entanto, coordenar as mudanças com os clientes e não nos comprometemos a permanecer com o DigiCert. Para assegurar o acesso contínuo ao serviço do {{site.data.keyword.cloudant_short_notm}}, os clientes são fortemente desencorajados de fixar o certificado atual, que está sujeito à expiração e à rotação do prompt no caso de um compromisso. Em vez disso, recomendamos que os clientes usem os pacotes configuráveis de certificado padrão para seus sistemas operacionais e navegadores, o que garantirá o serviço seguro continuado por meio de qualquer mudança de certificado.
Terminais | Todas as instâncias do {{site.data.keyword.cloudant_short_notm}} são fornecidas com os terminais externos que são acessíveis publicamente. Os ambientes de hardware dedicado fornecidos após 1º de janeiro de 2019 também incluem os terminais internos para todas as instâncias de plano Standard implementadas neles. O uso de terminais internos permite que os clientes se conectem a uma instância do {{site.data.keyword.cloudant_short_notm}} por meio da rede interna do {{site.data.keyword.cloud}} para evitar que o tráfego de aplicativos de envio de dados entre na rede pública, incorrendo em encargos de largura da banda. Consulte a [Documentação do terminal em serviço](https://cloud.ibm.com/docs/services/service-endpoint/getting-started.html#about){:new_window} para obter mais detalhes sobre como ativar os terminais em serviço para a sua conta do {{site.data.keyword.cloud}}.
Lista de Desbloqueio de IP | Os clientes do {{site.data.keyword.cloudant_short_notm}} que possuem um ambiente dedicado do {{site.data.keyword.cloudant_short_notm}} podem colocar endereços IP na lista de desbloqueio para restringir o acesso a apenas servidores e usuários especificados. A lista de desbloqueio de IP não está disponível para planos Lite/Padrão do {{site.data.keyword.cloud_notm}} Public que são implementados em ambientes de vários locatários. Abra um chamado de suporte para solicitar as listas de desbloqueio de IP para um conjunto especificado de IPs ou intervalos IP. Observe que as listas de desbloqueio de IP se aplicam à API e painel do {{site.data.keyword.cloudant_short_notm}}, portanto, esteja ciente de incluir quaisquer IPs de administrador que precisem acessar o Painel do {{site.data.keyword.cloudant_short_notm}} diretamente. 
CORS | Ative o suporte do CORS para domínios específicos usando o painel ou a API do {{site.data.keyword.cloudant_short_notm}}. Para obter mais informações, consulte a [Documentação da API do CORS](/docs/services/Cloudant?topic=cloudant-cors#cors){:new_window}.

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
