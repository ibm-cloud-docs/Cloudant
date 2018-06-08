---

copyright:
  years: 2015, 2018
lastupdated: "2017-11-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-02-23 -->

# {{site.data.keyword.Bluemix_notm}} Dedicated

O {{site.data.keyword.cloudantfull}} for (Bluemix Dedicated) é
um complemento de compra opcional em um ambiente Bluemix Dedicated. O complemento opcional para
{{site.data.keyword.cloudant_short_notm}} Dedicated no Bluemix Dedicated é precificado com base na capacidade de hardware
alocado para o ambiente e pode ser comprado entrando em contato com o representante de vendas da {{site.data.keyword.IBM}}.  

Os clientes do Bluemix Dedicated também podem escolher usar o {{site.data.keyword.cloudant_short_notm}} no Bluemix Public
por meio do catálogo organizado, incluindo as instâncias dos planos Lite e Padrão. Observe que
os usuários do Bluemix Dedicado não são elegíveis para comprar o plano Hardware dedicado do
catálogo Bluemix Public e deverão alavancar o {{site.data.keyword.cloudant_short_notm}} Dedicated no
Bluemix Dedicated se o hardware dedicado for necessário.   

A captura de tela a seguir mostra um exemplo de catálogo do {{site.data.keyword.Bluemix_notm}} destacando a versão organizada do
{{site.data.keyword.Bluemix_notm}} Public do {{site.data.keyword.cloudant_short_notm}} (à esquerda) e do ambiente {{site.data.keyword.cloudant_short_notm}} Dedicated (à direita).  

![{{site.data.keyword.cloudant_short_notm}} catálogo](../images/bluemix_catalog.png)

## Capacidade de hardware 

O {{site.data.keyword.cloudant_short_notm}} no {{site.data.keyword.Bluemix_notm}} Dedicated é comprado por meio de uma parte '{{site.data.keyword.Bluemix_notm}} Dedicated
{{site.data.keyword.cloudant_short_notm}} 1.6 TB Capacity', que inclui um ambiente do {{site.data.keyword.cloudant_short_notm}} em cluster
que consiste em três nós de banco de dados e dois balanceadores de carga. Cada nó de banco de dados
contém 1,6 TB nos SSDs e, como todos os dados são armazenados em triplicidade, isso
equivale a 1,6 TB de espaço exclusivo em disco no cluster. A expansão de um
ambiente pode ser realizada comprando partes adicionais '{{site.data.keyword.Bluemix_notm}} Dedicated
{{site.data.keyword.cloudant_short_notm}} 1.6TB Capacity', que podem ser usadas para expandir o
cluster do {{site.data.keyword.cloudant_short_notm}} em múltiplos de três nós de banco de dados. Os clientes também podem
escolher ter múltiplos ambientes do {{site.data.keyword.cloudant_short_notm}} separados em vez de
expandir um único ambiente.

## Locais e ocupação 

O ambiente {{site.data.keyword.cloudant_short_notm}} Dedicated dentro de um ambiente {{site.data.keyword.Bluemix_notm}} Dedicated está no hardware
que é designado para uso exclusivo pelo cliente do {{site.data.keyword.Bluemix_notm}} Dedicated. O cliente pode provisionar
uma ou mais instâncias do {{site.data.keyword.cloudant_short_notm}} no ambiente fornecido e cada instância do {{site.data.keyword.cloudant_short_notm}}
compartilha os recursos de hardware subjacentes que compõem o ambiente {{site.data.keyword.cloudant_short_notm}}. 

## Segurança, criptografia e conformidade 

Todos os planos são fornecidos em servidores com criptografia de disco [em repouso
![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://en.wikipedia.org/wiki/Data_at_rest). O acesso é pela conexão de rede pública e criptografado
usando HTTPS. Para obter mais detalhes, veja [Segurança ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://console.bluemix.net/docs/services/Cloudant/offerings/security.html#security){:new_window}.
A lista de bloqueio de IP está disponível sob solicitação para o Suporte do {{site.data.keyword.cloudant_short_notm}} e se aplicará a
todo o ambiente {{site.data.keyword.cloudant_short_notm}}, e não no nível da instância. 

O plano também oferece [Certificação de conformidade ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://console.bluemix.net/docs/services/Cloudant/offerings/compliance.html#cloudant-security-compliance){:new_window}.
A conformidade do [HIPAA ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){:new_window}
está disponível mediante solicitação, portanto, solicite isso durante o processo de compra com um representante de vendas da {{site.data.keyword.IBM_notm}}. 

## Alta disponibilidade, recuperação de desastre e backup 

Para fornecer alta disponibilidade (HA) e recuperação de desastre (DR) em um data center, todos os dados são armazenados em triplicidade em três servidores físicos separados em um cluster. Quando disponível, é possível provisionar contas em múltiplos locais,
em seguida, usar a replicação de dados contínuos para fornecer HA/DR nos data centers. Os dados do {{site.data.keyword.cloudant_short_notm}} não são submetidos a backup automaticamente, mas o conjunto de ferramentas suportado é fornecido para manipular backups. Revise o
guia de [Recuperação de desastre e backup ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://console.bluemix.net/docs/services/Cloudant/guides/disaster-recovery-and-backup.html#disaster-recovery-and-backup){:new_window}
para explorar todas as considerações sobre HA, DR e backup para atender aos seus requisitos de aplicativo.
