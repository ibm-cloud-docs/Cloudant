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

<!-- Acrolinx: 2017-05-02 -->

# Fazer backup dos dados usando CouchBackup

A natureza distribuída do {{site.data.keyword.cloudant}} fornece uma forma inerente de backup de dados.
CouchBackup é uma ferramenta de linha de comandos que fornece uma maneira mais poderosa e flexível de fazer backup dos dados.
{:shortdesc}

## Visão geral

Os benefícios distribuídos do {{site.data.keyword.cloudant_short_notm}} são obtidos usando clusters.
Em um cluster,
os dados de um banco de dados são armazenados em múltiplas cópias.
As cópias são difundidas por pelo menos três servidores físicos separados.
O uso de clusters para armazenamento de dados fornece ao {{site.data.keyword.cloudant_short_notm}}
características inerentes de Alta disponibilidade (HA) e Recuperação de desastre (DR).
O uso de clusters ajuda o {{site.data.keyword.cloudant_short_notm}} a tolerar a perda de um nó
de um cluster sem perder dados.

No entanto,
mesmo com essas características de HA e DR,
há outros casos de uso nos quais talvez você queira backup aprimorado de dados.

<div id="activepassive"></div>

### Indisponibilidade do data center e recuperação de desastre

A [replicação contínua](../api/replication.html#continuous-replication) entre clusters é uma boa solução para quando
um cluster do {{site.data.keyword.cloudant_short_notm}} não está completamente disponível.
A replicação contínua é um modelo 'ativo/passivo'.
A parte 'ativa' do modelo é a replicação contínua.
A parte 'passiva' do modelo reconhece que a réplica não deseja normalmente responder a solicitações dos aplicativos.
Em vez disso,
a réplica é usada principalmente como um clone do banco de dados original.
Se necessário,
os dados podem ser acessados do clone.
Como alternativa,
os dados no clone podem ser restaurados em outro lugar usando a [replicação](../api/replication.html).

>	**Nota:** a restauração de um banco de dados grande replicando de um clone pode levar muito tempo.

### Alta disponibilidade, failover automático ou balanceamento de carga geográfico

Uma alternativa para a abordagem ['ativa/passiva'](#activepassive) é configurar dois data centers para usar um modelo 'ativo/ativo'.

Nesse modelo,
todas as mudanças feitas em um banco de dados no cluster A são replicadas para um banco de dados no cluster B.
Da mesma forma,
todas as mudanças feitas no banco de dados no cluster B são replicadas para o banco de dados no cluster A.

>	**Nota:** esse modelo pode ser configurado usando o painel do {{site.data.keyword.cloudant_short_notm}}.
Ele não requer ação pelo suporte do {{site.data.keyword.cloudant_short_notm}}.

Com esse modelo em vigor,
será possível projetar os aplicativos do banco de dados para 'executar failover' em um dos clusters se algum critério de disponibilidade for atendido.
É possível definir os critérios de disponibilidade como parte do design do aplicativo.

Também é possível incluir 'balanceamento de carga' geográfico no design do aplicativo.
Por exemplo,
um aplicativo cliente usado em uma área geográfica normalmente esperaria melhor desempenho
quando o aplicativo acessasse os dados armazenados em um cluster em uma área geográfica 'próxima'.
Projetar o aplicativo cliente para identificar o cluster 'mais próximo' e conectar-se a ele para consultas de banco de dados
ajudaria o desempenho do aplicativo.

Um tutorial explicando como configurar um ambiente de aplicativos multiregion está disponível
[aqui ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://www.ibm.com/developerworks/cloud/library/cl-multi-region-bluemix-apps-with-cloudant-and-dyn-trs/index.html){:new_window}.

### Modificação acidental, maliciosa ou de dados

O {{site.data.keyword.cloudant_short_notm}} não fornece um mecanismo para criar uma captura instantânea de seu banco de dados.
Se precisar desse tipo de recurso,
por exemplo, para facilitar a recuperação no nível de documento para um estado conhecido anterior,
será possível alcançar o mesmo efeito em uma de duas maneiras:

1.	Usando a replicação. Faça isso replicando o banco de dados. Certifique-se de registrar o ID de sequência final. Em um planejamento que você determinar, replique o banco de dados para um novo banco de dados. Inicie a replicação do último ID de sequência registrado. Ao reter os IDs de sequência para as replicações, será possível produzir o efeito de um mecanismo de rolagem. O resultado seria semelhante à criação de capturas instantâneas 'semanais' regulares por meio de capturas instantâneas 'diárias'. Uma limitação dessa abordagem é que ela também replica revisões de documentos excluídos ou 'tombstone' e também conflitos não resolvidos.

2.	Fazendo dump do conteúdo do banco de dados no arquivo. Existem várias ferramentas que podem ser usadas para fazer dump do conteúdo do banco de dados em um arquivo. O arquivo dump resultante pode ser armazenado em um dispositivo ou um serviço orientado a bloco mais barato. Uma limitação de tal abordagem é que ela normalmente faz dump de revisões de documentos atuais apenas. Essa limitação significa que os conflitos não resolvidos não são incluídos.

Criar um dump de banco de dados é uma maneira efetiva de permitir uma variedade de soluções de backup.
Portanto,
o restante da discussão se concentra nesta abordagem.

<!--
https://developer.ibm.com/clouddataservices/2016/03/22/simple-couchdb-and-cloudant-backup/

A useful approach is to have couchbackup's snapshots placed on the {{site.data.keyword.cloud}} Object Storage service, as described here:

https://developer.ibm.com/recipes/tutorials/object-storage-cloudant-backup/
-->
