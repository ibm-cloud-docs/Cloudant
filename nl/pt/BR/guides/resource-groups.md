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

<!-- Acrolinx: 2017-05-10 -->

# Como o  {{site.data.keyword.cloudant_short_notm}}  funciona com os  {{site.data.keyword.cloud_notm}}  Grupos de Recursos?

Desde 16 de julho de 2018, novas instâncias de recurso {{site.data.keyword.cloudantfull}} foram provisionadas em grupos de recursos, em vez de espaços de Cloud Foundry. Este documento abrange as perguntas comuns do {{site.data.keyword.cloudant_short_notm}} que o suporte recebeu sobre essa transição.

## Como migrar uma instância existente para um grupo de recursos?

Para migrar uma instância do {{site.data.keyword.cloudant_short_notm}} de um espaço do Cloud Foundry para um grupo de recursos, consulte [Migrando instâncias de serviço do Cloud Foundry e apps para um grupo de recursos](https://console.bluemix.net/docs/resources/instance_migration.html#migrate){:new_window}.

É possível migrar instâncias do {{site.data.keyword.cloudant_short_notm}} nos planos a seguir:

- Lite
- Padrão
- Hardware Dedicado

## Quanto tempo de inatividade ocorre quando você migra uma instância para um grupo de recursos?

Não há tempo de inatividade durante o processo de migração.

## Por que algumas instâncias têm uma organização e um espaço e outras não?

Desde 16 de julho de 2018, novas instâncias foram provisionadas em grupos de recursos em vez de espaços de Foundry Cloud. As instâncias de recursos provisionadas antes dessa data têm uma organização e um espaço do Cloud Foundry associados. Instâncias aprovisionadas após essa data serão associadas a um grupo de recursos.

## Por que não posso criar novas instâncias de plano Padrão em minhas instâncias de Hardware dedicado?

Novas instâncias de plano Padrão são provisionadas em grupos de recursos. Para fornecer essas instâncias para uma instância de Hardware dedicado, a instância de Hardware dedicado deve primeiro ser migrada para um grupo de recursos.

Para obter mais informações sobre como fazer isso, consulte [Migrando instâncias de serviço e apps do Cloud Foundry para um grupo de recursos](https://console.bluemix.net/docs/resources/instance_migration.html#migrate){:new_window}.

Depois que a instância de Hardware dedicado tiver sido migrada para um grupo de recursos, ela aparecerá no menu suspenso Local ao fornecer planos Padrão.

## Como devo migrar minhas instâncias de Hardware dedicado e as instâncias de plano Padrão hospedadas nelas?

Em teoria, as instâncias podem ser migradas para grupos de recursos em qualquer ordem. Na prática, recomendamos a ordem a seguir para instâncias de Hardware dedicado e as instâncias de plano Padrão hospedadas nelas:

1. Migrar instâncias de Hardware dedicado para um grupo de recursos. Isso permite que novas instâncias de plano Padrão sejam criadas no Hardware dedicado.
2. Migrar instâncias Padrão.

Instâncias do plano Lite e instâncias do plano Padrão não hospedadas em Hardware dedicado podem ser migradas a qualquer momento.
{: tip}
