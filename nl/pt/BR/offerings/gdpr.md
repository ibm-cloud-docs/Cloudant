---

copyright:
  years: 2018, 2019
lastupdated: "2019-06-12"

keywords: audit access ibm cloudant, supported classifications of personal data, personal data, sensitive personal data, restrictions on processing, encrypt data, data locations, service security, delete data

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

# General Data Protection Regulation (GDPR)
{: #general-data-protection-regulation-gdpr-}

O GDPR visa a criar uma estrutura legal de proteção de dados harmonizada em toda a UE e pretende
devolver aos cidadãos o controle de seus dados pessoais, enquanto impõe regras rígidas sobre
a hospedagem e o ‘processamento‘ desses dados, em qualquer lugar do mundo. O regulamento também introduz regras que se relacionam com a livre circulação de dados pessoais dentro e fora da UE. 

Com o [General Data Protection Regulation ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.eugdpr.org/){: new_window},
os clientes do {{site.data.keyword.cloudantfull}} podem contar com o
entendimento e a conformidade da equipe do {{site.data.keyword.cloudant_short_notm}}
com os novos padrões e legislação de privacidade de dados, além da maior capacidade da {{site.data.keyword.IBM}}
de fornecer um conjunto de soluções abrangente para ajudar empresas de todos
os tamanhos com seus próprios requisitos de controle de dados internos.

## Como de acesso ao {{site.data.keyword.cloudant_short_notm}}?
{: #how-do-i-audit-access-to-ibm-cloudant-}

É possível localizar informações sobre auditoria em [Criação de log de auditoria](/docs/services/Cloudant?topic=cloudant-audit-logging#audit-logging){: new_window}. 

## As classificações suportadas de Dados Pessoais
{: #supported-classifications-of-personal-data}

As categorias de Dados Pessoais a seguir são suportadas pelo {{site.data.keyword.cloudant_short_notm}}
para GDPR:

**Dados Pessoais**, por exemplo:
 * Identidade / status civil
 * A vida pessoal
 * A vida profissional
 * Local de dados
 * Dados de conectividade/dispositivo

**Dados pessoais sensíveis**, que estão restritos a:
  * Dados de funcionamento e condições extras são abordados na [Descrição do {{site.data.keyword.cloudant_short_notm}} Dedicated Cluster Service ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www-03.ibm.com/software/sla/sladb.nsf/pdf/6756-04/$file/i126-6756-04_05-2018_en_US.pdf){: new_window} e na [Descrição do serviço adicional do {{site.data.keyword.cloud}}![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www-03.ibm.com/software/sla/sladb.nsf/pdf/6627-04/$file/i126-6627-04_04-2018_en_US.pdf){: new_window}

Se você está armazenando dados de assistência médica, *deve-se* concluir as tarefas a seguir:
 - Notificar {{site.data.keyword.cloudant_short_notm}} antes de gravar quaisquer dados.
 - Solicitar um cluster dedicado HIPAA compatível.

Para obter mais informações sobre as classificações suportadas de Dados pessoais, consulte o
[Data Sheet Addendum (DSA) em 2. Dados pessoais ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/software/reports/compatibility/clarity-reports/report/html/softwareReqsForProduct?deliverableId=2EBB5860B34311E7A9EB066095601ABB){: new_window}.

## Dados sobre mim
{: #data-about-me}

O {{site.data.keyword.cloudant_short_notm}} registra alguns dados sobre seus usuários e é um Controlador de Dados para
os referidos dados de Informações Pessoais (PI). Os dados que o {{site.data.keyword.cloudant_short_notm}} registra dependem do tipo de conta que você possui.

Se você tiver um {{site.data.keyword.cloudant_short_notm}} Dedicated Cluster/c{{site.data.keyword.cloudant_short_notm}}
Enterprise Cluster, nós registraremos os dados sobre você
e eles serão considerados um Controlador de Dados para seus dados dentro do contexto de GDPR. 
Se você tiver um {{site.data.keyword.cloudant_short_notm}} Dedicated Cluster/{{site.data.keyword.cloudant_short_notm}}
Enterprise Cluster, nós teremos seu:

 * Nome
 * Email

Os dados que o {{site.data.keyword.cloudant_short_notm}} retém podem ser visualizados e atualizados por meio do painel do {{site.data.keyword.cloudant_short_notm}}.

Se você tiver uma conta provisionada pelo {{site.data.keyword.cloud_notm}} (incluindo uma instância dedicada),
o {{site.data.keyword.cloudant_short_notm}} _não_ coletará os dados pessoais mencionados anteriormente. Esses dados são mantidos pelo {{site.data.keyword.cloud_notm}}.

O {{site.data.keyword.cloudant_short_notm}} processa o PI do cliente limitado no curso da execução do serviço e otimiza
a experiência do usuário dele. O {{site.data.keyword.cloudant_short_notm}} usa e-mail para entrar em contato com os clientes conforme apropriado. Monitorar interações do cliente com o painel do {{site.data.keyword.cloudant_short_notm}} é outra maneira como o {{site.data.keyword.cloudant_short_notm}} processa o PI.

### Processamento de Restrição
{: #restriction-of-processing}

O {{site.data.keyword.cloudant_short_notm}}  envia dados de interação do painel para o Segmento. É possível pedir que o {{site.data.keyword.cloudant_short_notm}} restrinja o processamento do PI do cliente dessa maneira por meio de uma [Solicitação de suporte do {{site.data.keyword.cloudant_short_notm}}![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](mailto:support@cloudant.com){: new_window}. Após
o recebimento de tal solicitação, o {{site.data.keyword.cloudant_short_notm}} exclui informações associadas
ao cliente conforme enviadas para o segmento e evita que dados adicionais sejam enviados. O {{site.data.keyword.cloudant_short_notm}} precisa reter a
capacidade de entrar em contato com clientes dedicados por e-mail e fornece uma interface para os clientes para manter essas
informações atualizadas diretamente ou por meio da configuração do cliente de seus detalhes de contato
por meio de seus detalhes da conta do {{site.data.keyword.cloud_notm}}.

## Nosso {{site.data.keyword.cloudant_short_notm}} banco de dados criptografado?
{: #is-our-ibm-cloudant-database-encrypted-}

Todos os clusters têm um sistema de arquivos com criptografia (criptografia em repouso) usando Linux Unified Key Setup (LUKS). Os dados no banco de dados são visíveis para nossas operações e equipes de suporte (consulte o parágrafo a seguir).

Para dados sensíveis, que você determinar que devem permanecer invisíveis para o {{site.data.keyword.cloudant_short_notm}},
deve-se criptografar ou de outra forma proteger (pseudonimizar) seus dados antes de enviá-los para nós. Deve-se evitar a utilização do PI como um documento `_id` em suas URLs, por exemplo, `https://$ACCOUNT.cloudant.com/$DATABASE/$DOCUMENT_ID`, já que estes são sempre visíveis e gravados nos logs de acesso.

## Locais de dados
{: #data-locations}

Locais em que o {{site.data.keyword.cloudant_short_notm}} processa dados pessoais serão disponibilizados e mantidos atualizados, por meio do DSA.

Para obter mais informações sobre os locais de dados, consulte o [DSA sob 7. {{site.data.keyword.IBM_notm}} Locais de hospedagem e de processamento ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/software/reports/compatibility/clarity-reports/report/html/softwareReqsForProduct?deliverableId=2EBB5860B34311E7A9EB066095601ABB){: new_window}.

## Serviços de segurança
{: #service-security}

### Usando {{site.data.keyword.cloudant_short_notm}} firmemente
{: #using-ibm-cloudant-securely}

Como um usuário do {{site.data.keyword.cloudant_short_notm}}, você deve:

 * Use a configuração CORS padrão para evitar acesso inesperado.
 * Use as chaves API de modo liberal, de forma que os componentes possam ter 'menos acesso privilegiado', juntamente com o log de auditoria. Essa prática permite que você entenda quem acessou quais dados.
 * Os dados sensíveis de criptografia ou de outra forma protegidos (pseudônimos) que você determina devem permanecer invisíveis para o {{site.data.keyword.cloudant_short_notm}}.

### Medidas de segurança física e ambiental
{: #physical-and-environmental-security-measures}

A segurança física de nossos centros de dados é manipulada por nossos provedores de infraestrutura: {{site.data.keyword.cloud}}, 
AWS e 21Vianet. Todos detêm certificações externamente auditadas para manter sua segurança física. O {{site.data.keyword.cloudant_short_notm}} não fornecerá detalhes adicionais dos controles de segurança física em vigor em nossos datacenters.

A segurança física dos locais comerciais usados pelo nosso pessoal é controlada pela {{site.data.keyword.IBM_notm}} Corporate. 
Detalhes de certificação e relatórios de atestado (ou seja, ISO e SOC2) podem ser fornecidos ao
cliente mediante solicitação.

### Medidas técnicas e organizacionais
{: #technical-and-organizational-measures}

As medidas técnicas e organizacionais (TOMs) são empregadas pelo {{site.data.keyword.cloudant_short_notm}}
para garantir a segurança
de Dados Pessoais. O {{site.data.keyword.cloudant_short_notm}} contém certificações auditadas externamente para os controles que o {{site.data.keyword.cloudant_short_notm}} emprega. 
Detalhes de certificação e relatórios de atestado (ou seja, ISO e SOC2) podem ser fornecidos ao
cliente mediante solicitação.

### Serviço de acesso a dados
{: #service-access-to-data}

As equipes de operações e de suporte do {{site.data.keyword.cloudant_short_notm}} têm acesso aos dados do cliente
e podem acessá-los durante as operações de rotina. Esse acesso é feito apenas conforme necessário, para operar e suportar o serviço. 
O acesso também é limitado a uma *necessidade de saber* e é registrado, monitorado e auditado.

## Exclusão de dados
{: #deletion-of-data}

### Excluindo um documento
{: #deleting-a-document}

Quando um documento é excluído, o banco de dados cria um 'tombstone'. O que o tombstone contém depende
de como você o exclui.

 - Se você faz uma chamada `DELETE`, o tombstone inclui os campos `_id`, `_rev` e `_deleted`.
 - Se você exclui atualizando o documento com um campo `_deleted: true` e efetua `PUT` ou `POST`,
o tombstone inclui o que você configura no corpo do documento. Essa prática pode ser útil em algumas
circunstâncias, por exemplo, ao gravar porque um documento foi excluído em seu tombstone.

Para obter mais informações sobre como excluir tombstones, consulte [Remoção simples de documentos 'tombstone'](/docs/services/Cloudant?topic=cloudant-documents#tombstone-documents){: new_window}.

### Quando um documento excluído é removido?
{: #when-is-a-deleted-document-removed-}

A compactação é executada automaticamente e remove periodicamente as revisões antigas (excluídas ou não)
do banco de dados, gravando apenas revisões de 'folha' em um novo arquivo. O {{site.data.keyword.cloudant_short_notm}} mantém um histórico de `_id` e `_rev` para ativar a replicação, mas não os corpos de documentos antigos.

O {{site.data.keyword.cloudant_short_notm}} não expõe a API de compactação CouchDB.
{: tip}

O {{site.data.keyword.cloudant_short_notm}} não garante que um banco de dados será compactado em um horário específico. 
A compactação é feita como um processo de segundo plano na camada de armazenamento e os bancos de dados estão sempre sendo compactados; não há garantia de que sejam os dados
que você acabou de excluir/mudar.

O {{site.data.keyword.cloudant_short_notm}} está aceitando as solicitações *Direito a ser esquecido* por meio do
[{{site.data.keyword.IBM_notm}} Data Privacy Office (DPO) ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://w3-03.ibm.com/ibm/privacy/index.html){: new_window}. 
Quando uma solicitação *Direito a ser esquecido* é feita no DPO do {{site.data.keyword.IBM_notm}}, o {{site.data.keyword.cloudant_short_notm}} verifica a solicitação, aciona explicitamente a compactação do banco de dados e verifica se a compactação ocorreu.
No final desse processo, a única versão do documento é seu tombstone
(`_id`, `_rev`, `_deleted` e quaisquer campos que seu aplicativo incluir lá).

### Remoção de tombstones
{: #removal-of-tombstones}

{{site.data.keyword.cloudant_short_notm}} pode remover completamente todas as referências e dados para um
documento quando necessário. Essa tarefa é um
processo gerenciado pelo operador chamado de limpeza. Antes de solicitar que os documentos sejam limpos, é
importante entender que os documentos limpos *não poderão ser recuperados* pelo
{{site.data.keyword.cloudant_short_notm}} quando o
processo for concluído.

A API de limpeza CouchDB não é suportada pelo {{site.data.keyword.cloudant_short_notm}}.
{: tip}

No contexto do GDPR, a limpeza é necessária apenas se a PI é usada em um ID do documento. É uma péssima
ideia um `_id` armazenar PI por vários motivos, mas há alguns casos
de uso semiválidos (por exemplo, um e-mail exclusivo). Se possível, criptografe ou pseudonimize os dados para que fiquem opacos
para o {{site.data.keyword.cloudant_short_notm}}.

Se um documento precisar de remoção por meio de uma solicitação de *direito de ser esquecido*:

1. Arquivar uma solicitação com o [{{site.data.keyword.IBM_notm}} DPO ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://w3-03.ibm.com/ibm/privacy/index.html){: new_window} para solicitar a limpeza de valores `_id` do documento específico juntamente com o motivo.
1. Após o recebimento de uma solicitação formal do DPO do {{site.data.keyword.IBM_notm}}, as operações do {{site.data.keyword.cloudant_short_notm}}
verificam a solicitação para confirmar se o `id` contém PI. O {{site.data.keyword.cloudant_short_notm}} não limpa dados que não possuem PI no `_id`. 
1. O {{site.data.keyword.cloudant_short_notm}} aciona a ação de limpeza para remover permanentemente os dados solicitados.

Esse processo deve ser utilizado apenas para solicitações de exclusão de emergência (por exemplo, *Direito de ser esquecido*) e não se deve depender dele a longo prazo. Se seu aplicativo estiver intencionalmente
usando PI em IDs de documento,
isso deverá ser mudado para pseudonimizar a PI ou para não usar PI em IDs de documento. Você não pode
depender da limpeza regular pela equipe de operações do {{site.data.keyword.cloudant_short_notm}} para evitar isso. 
{{site.data.keyword.cloudant_short_notm}} portanto, rejeita as solicitações de limpeza a seguir:

1. A solicitação é para a limpeza regular, por exemplo, *a cada 30 dias*.
1. A solicitação é para mais de 100 documentos.

Mesmo com a limpeza, a PI no campo `_id` vaza para locais que você não deseja, como
logs do {{site.data.keyword.cloudant_short_notm}}, portanto, ela deve ser evitada. 
O {{site.data.keyword.cloudant_short_notm}} possui um motivo de negócios para reter esses logs e não removerá linhas de log contendo os valores `_id` do documento.

### Que tal excluir um banco de dados?
{: #what-about-deleting-a-database-}

A exclusão de um banco de dados o coloca em uma lixeira por até 48h, após isso ele é removido do
sistema de arquivos. A equipe do {{site.data.keyword.cloudant_short_notm}} *não* faz backups de seus bancos de dados; essa tarefa é
de *responsabilidade do cliente*. Deve-se assegurar que todas as cópias de seu
banco de dados sejam removidas de seu sistema. Para obter mais informações, consulte
[Backup e recuperação do {{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant?topic=cloudant-ibm-cloudant-backup-and-recovery#ibm-cloudant-backup-and-recovery){: new_window}. 

Se precisar de ajuda adicional, entre em contato com
[Suporte do {{site.data.keyword.cloudant_short_notm}} ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](mailto:support@cloudant.com).

