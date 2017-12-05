---

copyright:
  years: 2017
lastupdated: "2017-07-13"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-04-28 -->

# Segurança

## Proteção de dados e segurança do Cloudant DBaaS

A proteção de dados do aplicativo para apps da web e móveis de larga escala pode ser complexa,
especialmente com bancos de dados distribuídos e NoSQL.

Da mesma forma que reduz o esforço de manutenção de seus bancos de dados,
para mantê-los em execução e em crescimento ininterrupto,
o {{site.data.keyword.cloudantfull}} também assegura que os dados permaneçam seguros e protegidos.

## Plataformas físicas da camada superior

O {{site.data.keyword.cloudant_short_notm}} DBaaS é
hospedado fisicamente nos provedores de infraestrutura em nuvem da Camada 1, como o
{{site.data.keyword.BluSoftlayer_full}} e a Amazon.
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

> **Nota:** mais detalhes sobre as certificações estão disponíveis nas [Informações de conformidade](compliance.html).

## Controle de acesso seguro

Uma multidão de recursos de segurança é construída no
{{site.data.keyword.cloudant_short_notm}},
para você controlar o acesso aos dados:

- Autenticação: o {{site.data.keyword.cloudant_short_notm}} é acessado
usando uma API HTTP.
  Quando o terminal de API a requerer,
o usuário será autenticado para cada solicitação de HTTPS ou HTTP que o
{{site.data.keyword.cloudant_short_notm}} receber.
- Autorização: conceder permissões de
administrador,
leitura, gravação, a bancos de dados específicos.
- Criptografia "em andamento": todo o acesso ao
{{site.data.keyword.cloudant_short_notm}} é criptografado usando HTTPS.
- Criptografia inativa: os dados armazenados em disco no
{{site.data.keyword.cloudant_short_notm}} podem ser criptografados.
  > **Nota**: os dados armazenados em uma instância do {{site.data.keyword.Bluemix_notm}} {{site.data.keyword.cloudant_short_notm}} são sempre criptografados.
- Acesso à API: o {{site.data.keyword.cloudant_short_notm}} é acessado programaticamente
usando uma API sobre HTTP seguro (HTTPS).
  As chaves API podem ser geradas usando
o painel do {{site.data.keyword.cloudant_short_notm}}.
- Lista de aplicativos confiáveis IP: os clientes do {{site.data.keyword.cloudant_short_notm}} em ambientes dedicados
podem colocar endereços IP na lista de desbloqueio para restringir o acesso somente aos servidores e usuários especificados.
- CORS: ativar o suporte CORS para domínios específicos usando o
painel do {{site.data.keyword.cloudant_short_notm}}.

## Proteção contra perda ou distorção de dados

O {{site.data.keyword.cloudant_short_notm}} possui vários recursos
para ajudar a manter a qualidade e a disponibilidade dos dados:

- Armazenamento de dados redundante e durável: por padrão,
o {{site.data.keyword.cloudant_short_notm}} salva no disco três cópias
de cada documento para três nós diferentes em um cluster.
  O salvamento das cópias assegura que uma cópia de failover funcional de seus dados
esteja sempre disponível,
independentemente de falhas.
- Replicação de dados e exportação: é possível replicar seus bancos de dados continuamente
entre os clusters em diferentes data centers
ou em um cluster local do Cloudant Local
ou Apache CouchDB.
  Outra opção é exportar dados do
{{site.data.keyword.cloudant_short_notm}} (no formato JSON)
para outros locais ou origens (como seu próprio data center)
para redundância adicional de dados.
