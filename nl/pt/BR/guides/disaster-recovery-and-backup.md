---

copyright:
  years: 2017, 2019
lastupdated: "2019-06-12"

keywords: types and levels of protection, data redundancy, cross-region redundancy, database backup and recovery

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

# Recuperação de desastre e backup
{: #disaster-recovery-and-backup}

Seus dados são importantes e valiosos.
Você deseja proteger seus dados
para ajudar a assegurar que sejam seguros,
disponíveis
e mantenham a integridade.
O {{site.data.keyword.cloudantfull}} fornece várias maneiras de proteger seus dados e ajudar a manter seus aplicativos operacionais.
{: shortdesc}

Alguns desses recursos de proteção são automáticos.
Para outras formas de proteção,
o {{site.data.keyword.cloudant_short_notm}} fornece a você ferramentas suportadas que
ajudam a criar seus próprios recursos de alta disponibilidade e recuperação de desastre.

Este documento fornece uma visão geral dos recursos automáticos e das ferramentas suportadas que são oferecidos pelo {{site.data.keyword.cloudant_short_notm}}.

## Tipos e níveis de proteção
{: #types-and-levels-of-protection}

O tipo de proteção que você pode desejar depende do problema que está tentando resolver.

Por exemplo,
talvez você queira ter um alto nível de disponibilidade de dados para que ainda possa acessar seus dados,
mesmo que uma quantia limitada de hardware dentro do sistema tenha falhado.
Este é um requisito de 'Alta disponibilidade' (HA).
Significa fornecer a melhor disponibilidade de dados contínua possível após uma falha de hardware.
Diferentes técnicas de HA toleram diferentes níveis de falha antes que as operações sejam afetadas.

Como alternativa,
talvez você queira ter maneiras fáceis e rápidas de fazer backup e restaurar dados.
Por exemplo,
após uma falha de hardware grave ou ampla,
você deseja ser capaz de disponibilizar todos os dados em um sistema alternativo
o mais rápido possível.
Este é um requisito de 'Recuperação de desastre' (DR).
Um desastre geralmente significa que um banco de dados não está mais disponível em um ou mais locais.
Por exemplo,
uma indisponibilidade de energia pode fazer com que todos os sistemas em um cluster de banco de dados falhem.
Como alternativa,
uma falha de rede em larga escala pode significar que os sistemas em um cluster não poderão ser contatados,
mesmo que continuem a funcionar corretamente.

Tratar dos requisitos de HA ou DR muitas vezes começa simplificando o problema em requisitos mais genéricos.
Ao identificar seus requisitos,
será possível aplicar as ferramentas e os recursos que ajudam a resolver as necessidades genéricas.
Quando em conjunto,
as ferramentas e os recursos podem então tratar dos requisitos de HA ou DR.

Diferentes ferramentas e recursos fornecem diferentes níveis de proteção. Os diferentes recursos podem ser mais ou menos adequados para seu requisito específico de HA ou DR.
{: tip}

O {{site.data.keyword.cloudant_short_notm}} fornece várias ferramentas e recursos que tratam de requisitos gerais:

1.	Redundância de dados em uma única região, também conhecida como [Redundância de dados automática na região](#in-region-automatic-data-redundancy).
2.	Redundância de dados de região cruzada e failover, também conhecidos como [Redundância entre regiões para recuperação de desastre](#cross-region-redundancy-for-disaster-recovery).
3.	Backup de captura instantânea de momento para restauração de momento, usando o [Backup e recuperação de banco de dados](#database-backup-and-recovery) 'tradicional'.

## Redundância de dados automática na região
{: #in-region-automatic-data-redundancy}

Em uma única conta do {{site.data.keyword.cloudant_short_notm}},
os dados são armazenados em triplicidade usando processos internos e automáticos.
Você não precisa fazer nada para ativar esta replicação de dados internos.

A redundância de dados na região permite a proteção de alta disponibilidade.
Especificamente,
a redundância de dados na região fornece proteção para seus dados na falha de hardware dentro da região.
Quando uma unidade de hardware dentro da região falha,
somente a cópia dos dados armazenados nessa unidade não fica mais disponível.
Seus aplicativos permanecem utilizáveis porque o {{site.data.keyword.cloudant_short_notm}} roteia automaticamente as solicitações para as cópias de seus dados
que ainda estão disponíveis em outras unidades de hardware dentro da região.
Enquanto isso,
o monitoramento automático de sistemas detecta a falha da unidade de hardware,
solicitando ação e restauração subsequente de redundância integral.

As contas do {{site.data.keyword.cloudant_short_notm}} estão localizadas em uma única região.
Essa característica significa que todos os dados armazenados em sua conta são armazenados em servidores separados,
cada um dos quais é hospedado dentro dessa única região.

A redundância automática de dados na região está limitada a:

1.	Fornecer proteção dentro de uma única região apenas.
2.	Manter os dados atuais.

Para fornecer proteção além da única região associada à sua conta, use [Redundância entre regiões para recuperação de desastre](#cross-region-redundancy-for-disaster-recovery).

Para fornecer proteção para o 'histórico' de seus dados, por exemplo, para ativar a auditoria de mudanças que são feitas nos dados por aplicativos, use capturas instantâneas de dados criadas pelas ferramentas de [Backup e recuperação do banco de dados](#database-backup-and-recovery).

Resumindo,
a redundância de dados na região permite um recurso de Alta disponibilidade,
fornecendo tolerância para falhas que afetam sistemas únicos dentro da região.

## Redundância entre regiões para recuperação de desastre
{: #cross-region-redundancy-for-disaster-recovery}

O recurso de replicação do {{site.data.keyword.cloudant_short_notm}} ajuda a construir um recurso de recuperação de desastre flexível em seus aplicativos.
A principal maneira de ativar a recuperação de desastre é usar a replicação do {{site.data.keyword.cloudant_short_notm}} para criar redundância entre regiões.
O resultado é que seu aplicativo será capaz de tolerar a situação em que um ou mais regiões não está disponível.

As etapas básicas para criar redundância entre regiões são:

1.  Crie contas do {{site.data.keyword.cloudant_short_notm}} em duas ou mais regiões.
2.  Criar bancos de dados em cada região, conforme necessário.
3.  Para bancos de dados que devem ser armazenados com redundância entre regiões, configurar replicações contínuas bidirecionais entre os bancos de dados correspondentes em cada conta.
4.  Projetar e implementar seus aplicativos para que as solicitações de dados sejam roteadas dependendo se seu ambiente for uma configuração Ativa/Passiva ou Ativa/Ativa.
  Para obter mais informações sobre como configurar isso, consulte [Configurando o {{site.data.keyword.cloudant_short_notm}} para recuperação de desastre entre regiões](/docs/services/Cloudant?topic=cloudant-configuring-ibm-cloudant-for-cross-region-disaster-recovery#configuring-ibm-cloudant-for-cross-region-disaster-recovery).

Ao projetar seus aplicativos para funcionar com dados em múltiplas regiões,
considere os pontos a seguir:

* Os aplicativos podem enviar solicitações para o banco de dados hospedado mais próximo de seu local físico.
  Esse uso de proximidade pode reduzir a latência de rede e melhorar os tempos de resposta.
  Essa configuração é referida como um método 'Ativo/Ativo'.
  Ela é caracterizada pelo uso simultâneo de múltiplas cópias de dados.
  Os aplicativos que funcionam em uma configuração ativa/ativa devem ter
uma [estratégia para manipular conflitos](/docs/services/Cloudant?topic=cloudant-document-versioning-and-mvcc#distributed-databases-and-conflicts) para evitar problemas com múltiplas cópias de dados.
* Os aplicativos podem solicitar dados de uma única região por padrão.
  Se a região não estiver disponível,
o aplicativo poderá alternar para solicitar dados de outra região.
  Essa configuração é referida como um método 'Ativo/Passivo'.
  Ele é caracterizado pelo uso ativo de um conjunto de dados apenas em um momento.
* Um aplicativo pode usar uma configuração híbrida,
em que uma única conta é usada para todas as solicitações de gravação de dados
e outros locais são usados exclusivamente para solicitações somente leitura.
  Essa configuração é considerada Ativa/Ativa para leituras.
* Em um cenário de desastre,
seu aplicativo deve rotear novamente solicitações de dados para acessar as contas
hospedadas nas regiões que ainda estão on-line.
  Esse requisito significa que seu aplicativo deve ser capaz de detectar a perda de uma região
e, em seguida, rotear novamente as solicitações de dados.

Em resumo,
a redundância entre regiões é semelhante a um recurso de alta disponibilidade,
mas se aplica a falhas que afetam uma região inteira.
No entanto,
configurar seus aplicativos para funcionar corretamente com configurações entre redundâncias fornece um verdadeiro recurso de recuperação de desastre.
O motivo é que os aplicativos poderão continuar funcionando se os dados de uma região não estiverem disponíveis durante um período de tempo.
A replicação do {{site.data.keyword.cloudant_short_notm}} ajuda a assegurar a sincronização de dados entre as regiões.
No entanto,
seus aplicativos deverão ser capazes de 'executar failover' para cópias de seus dados armazenadas em outras regiões.

## Backup e recuperação do banco de dados
{: #database-backup-and-recovery}

[Redundância de dados automática na região](#in-region-automatic-data-redundancy) fornece aplicativos com acesso de alta disponibilidade aos dados.
[Redundância entre regiões para recuperação de desastre](#cross-region-redundancy-for-disaster-recovery) fornece aplicativos com um meio de se recuperar de um desastre.
No entanto,
esses dois recursos se concentram em manter o acesso apenas à cópia _atual_ de seus dados.

Na prática,
pessoas e aplicativos podem cometer erros e mudar dados de maneiras indesejadas.
Os próprios aplicativos podem implementar alguma proteção,
mas às vezes, ocorrem mudanças indesejáveis.
Nesse caso,
será útil ser capaz de restaurar dados de um momento anterior.
Os backups de banco de dados suportam esse requisito.

Além de proteger seus dados com recursos de alta disponibilidade e de recuperação de desastre,
considere fazer dump dos dados de seu banco de dados em um local separado em intervalos
regulares periódicos.
Assegure-se de verificar e testar os backups para ter confiança de que estão completos e corretos.

O {{site.data.keyword.cloudant_short_notm}} suporta ferramentas que ajudam a fazer dump do conteúdo JSON em bancos de dados para um arquivo
e depois restaurar bancos de dados por meio desses arquivos.

Especificamente,
as ferramentas suportadas pelo {{site.data.keyword.cloudant_short_notm}} ajudam você a:

*	Fazer backup de bancos de dados completos em um arquivo,
adequado para processamento posterior e armazenamento externo.
*	Restaurar bancos de dados completos de um estado anterior contido em seu arquivo de backup.

As ferramentas suportadas pelo {{site.data.keyword.cloudant_short_notm}} tem as limitações a seguir: 
{: tip}

*	As configurações `_security` não são submetidas a backup pelas ferramentas.
*	Os anexos não são submetidos a backup pelas ferramentas.
*	Os backups não são capturas instantâneas do "momento" precisamente exatas.
	O motivo é que os documentos no banco de dados são recuperados em lotes,
mas outros aplicativos podem estar atualizando documentos ao mesmo tempo.
	Portanto, os dados no banco de dados podem mudar entre as vezes em que o primeiro e o último lotes são lidos.
*	Os documentos de design retidos por definições do índice remissivo são submetidos a backup,
mas quando os dados são restaurados, os índices devem ser reconstruídos.
	Essa reconstrução poderá levar um período de tempo considerável,
dependendo da quantidade de dados restaurada.

## Próximas etapas com suas estratégias de proteção de dados
{: #next-steps-with-your-data-protection-strategies}

É possível desenvolver aplicativos que constroem funções básicas do {{site.data.keyword.cloudant_short_notm}} e ferramentas suportadas
para ativar estratégias mais complexas de proteção de dados.

Os cenários de exemplo incluem:

*	Restauração de documentos únicos de estados anteriores.
*	Armazenamento de múltiplos estados de documentos anteriores para permitir restaurações de longo tempo no passado.
*	Migração de dados mais antigos para armazenamento mais barato, para retenção com custo mais reduzido.

As ferramentas de backup consistem em um aplicativo e uma biblioteca de linha de comandos node.js de software livre.
Ele está disponível no [NPM ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.npmjs.com/package/@cloudant/couchbackup){: new_window}.

Para obter ideias e exemplos que mostram como integrar as ferramentas em sua estratégia de proteção de dados, consulte o [Guia de backup e recuperação do {{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant?topic=cloudant-ibm-cloudant-backup-and-recovery#ibm-cloudant-backup-and-recovery).
