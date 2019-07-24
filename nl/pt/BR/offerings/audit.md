---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: principal, action, resource, timestamp, access audit logs

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

# Log de auditoria
{: #audit-logging}

A criação de log de auditoria registra os proprietários do {{site.data.keyword.cloudantfull}} que têm
acessado dados armazenados no {{site.data.keyword.cloudant_short_notm}}. Para todo o acesso da
API HTTP ao {{site.data.keyword.cloudant_short_notm}}, a função de criação de log de auditoria
registra as seguintes informações sobre cada solicitação de HTTP:

Informações | Descrição
------------|------------
`Proprietário` | Credenciais da conta, chave de API ou credenciais do IAM do IBM Cloud.
`Ação` | A ação realizada (por exemplo, leitura de documentos).
`Recurso` | Detalhes sobre a conta, banco de dados e documento acessado ou consulta feita.
`Registro de data e hora` | Um registro do tempo e dos dados do evento. 
{: shortdesc}

Os logs de auditoria do {{site.data.keyword.cloudant_short_notm}} podem ser usados para entender:

- Quais bancos de dados e documentos foram acessados dentro de uma conta,
quando e por quem.
- Quais consultas foram executadas, quando e por quem.
- O que um proprietário ou usuário específico acessou, atualizou ou excluiu e quando.
- Quais documentos de replicação foram criados ou excluídos e quando.


## Como acessar logs de auditoria para a sua conta
{: #how-to-access-audit-logs-for-your-account}

Para solicitar acesso aos logs de auditoria para a sua conta, entre em contato
com o suporte do {{site.data.keyword.cloudant_short_notm}}. O suporte fornece uma cópia dos logs de auditoria que são de seu interesse.

Ao contatar o suporte, certifique-se de incluir:

- A conta do {{site.data.keyword.cloudant_short_notm}} à qual a solicitação está relacionada.
- O intervalo de tempo para logs de auditoria (não deve ser mais de um mês por solicitação de suporte).
- Quaisquer bancos de dados específicos, documentos ou proprietários de interesse.
