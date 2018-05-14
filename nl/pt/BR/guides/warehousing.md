---

copyright:
  years: 2015, 2017
lastupdated: "2017-01-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# Data Warehousing

Um banco de dados é essencial para armazenar dados.
Mas ser capaz de aplicar esses dados para propósitos comerciais é o que torna um banco de dados valioso:
ser capaz de recuperar dados relevantes
rápida e facilmente
e colocar os dados para trabalhar nos aplicativos.
{:shortdesc}

Mas muitas das tarefas
de armazenamento,
processamento
e análise executadas com os dados são usadas repetidamente nos aplicativos.
Ou podem ser bons exemplos de melhores práticas do segmento de mercado.

Portanto,
faz sentido ampliar os recursos do banco de dados padrão com recursos adicionais,
tarefas de apoio, como relatório
ou análise.

Por quase 30 anos,
os 'Data Warehouses' têm sido o padrão de mercado para armazenamento de dados,
relatório
e análise,
com base na tecnologia de banco de dados relacional.
Em geral,
um [data warehouse é ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://en.wikipedia.org/wiki/Data_warehouse){:new_window}:
"... um repositório central de dados integrados de uma ou mais fontes.
Ele armazena dados atuais e históricos.
Ele pode ser usado para executar análise e criar relatórios para os profissionais da área do conhecimento em toda a empresa."

As tecnologias que permitem armazenamento de dados,
relatório
e análise surgiram nos últimos anos como uma resposta à necessidade
de processar '[Big Data ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://en.wikipedia.org/wiki/Big_data){:new_window}':
"Big data é um termo para conjuntos de dados que são tão grandes ou complexos
que aplicativos de processamento de dados tradicionais são inadequados."

Ao mesmo tempo,
as propriedades e as características dos Data Warehouses e dos produtos relacionados significam que
usar a tecnologia de banco de dados relacional para ativar os Data Warehouses é uma escolha popular,
mesmo para tarefas de big data.

Há muitos casos de uso que ilustram bem os benefícios da
integração de recursos do Cloudant a um data warehouse relacional,
tal como os exemplos a seguir.

## Associando dados

A junção de dados de múltiplos armazenamentos de dados para análise de domínio cruzado
é uma tarefa que pode ser executada de modo fácil e eficiente usando um data warehouse relacional.

Os dados de diferentes fontes são preparados e transformados em um formato comum durante o carregamento de um data warehouse.
Os registros são armazenados em tabelas
e as operações ficam disponíveis para associar essas tabelas para ativar a análise combinada.

Executar a junção em um data warehouse relacional será especialmente útil
se alguns dos dados já estiverem disponíveis em uma representação relacional,
por exemplo, dados principais ou dados de referência.

## Flexibilidade

Os bancos de dados Cloudant são flexíveis para representar dados.
Por exemplo,
eles não utilizam um esquema durante a leitura ou a gravação.

Em contrapartida,
um modelo bem definido e rigorosamente utilizado é necessário para tarefas de relatório e análise.

Com seus documentos disponíveis em um warehouse relacional será possível basear seu modelo em um conjunto fixo de definições de tabela.
Somente documentos que se ajustem ao esquema de tabela poderão ser carregados enquanto as violações serão rejeitadas.
É possível treinar seus modelos com dados consistentes usando um esquema relacional fixo.

## Asserção de integridade de dados

Os Data warehouses podem usar restrições para impor a integridade de dados.
Por exemplo:

-   Dois registros não podem ter a mesma chave primária.
-   As chaves estrangeiras garantem que os registros estejam completos.
-   Há funções disponíveis para validar os registros nas regras de negócios.

Exclusividade,
exatidão
e completude são requisitos essenciais para qualquer serviço corporativo.
Carregar os documentos do Cloudant em um data warehouse ajuda a atender a esses requisitos.

## Cloudant e o Data Warehousing

Os Data Warehouses são uma tecnologia madura e importante.
O Cloudant fornece uma forte integração com data warehouses relacionais,
fornecendo o benefício dessa tecnologia.

O IBM Cloudant possui um recurso básico de warehousing integrado
na forma de [visualizações MapReduce](../api/using_views.html)
que permite executar uma variedade de tarefas analíticas básicas.

Para obter tarefas de warehousing mais avançadas,
é possível alavancar os recursos completos fornecidos pelo
serviço de warehousing baseado em nuvem da IBM [IBM dashDB ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://www-01.ibm.com/software/data/dashdb/){:new_window}.

Ao usar o IBM Cloudant,
você tem acesso integrado e fácil a recursos avançados de warehousing,
como:

-   Ver os dados JSON em um formato de banco de dados relacional.
-   Executar consultas baseadas em SQL nos dados.
-   Construir análise dos dados.

Esses recursos avançados de warehousing são ativados por meio de serviços como o IBM dashDB,
que é um complemento natural para o Cloudant.

Como alternativa,
se você precisar apenas de um armazenamento de dados relacionais para seus documentos,
sem os recursos de warehousing,
será possível carregar os documentos do Cloudant no serviço [IBM DB2 on Cloud](#ibm-db2-on-cloud).

## IBM dashDB

O IBM dashDB é um serviço de data warehouse baseado em nuvem
construído para trabalho analítico.
Embora especialmente adequado para dados JSON do Cloudant,
o dashDB pode aceitar dados de uma variedade de fontes
examinando a estrutura de dados ao ser carregado.

Para obter mais informações,
veja a [documentação do IBM dashDB Cloud Data Warehouse ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/support/knowledgecenter/SS6NHC/com.ibm.swg.im.dashdb.kc.doc/welcome.html){:new_window}.

## IBM DB2 on Cloud

O [IBM DB2 on Cloud ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://console.ng.bluemix.net/catalog/services/ibm-db2-on-cloud){:new_window}
fornece um banco de dados na infraestrutura em nuvem global da SoftLayer® da IBM.
Ele oferece os recursos avançados de uma implementação local do DB2,
mas sem o custo,
a complexidade
e o risco de gerenciar sua própria infraestrutura.

Para obter mais informações, veja a [documentação do IBM DB2 on Cloud ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://console.ng.bluemix.net/docs/services/DB2OnCloud/index.html#DB2OnCloud){:new_window}.

## Criando um warehouse

Há duas maneiras de criar um warehouse:

1.  [Usar o Cloudant para criar um warehouse do dashDB](#use-cloudant-to-create-a-dashdb-warehouse)
2.  [Conectar o Cloudant a um warehouse existente](#connect-cloudant-to-an-existing-warehouse)

### Usar o Cloudant para criar um warehouse do dashDB

O método mais simples para criar um warehouse é o Cloudant criar uma instância de warehouse do dashDB dentro do Bluemix,
em seu nome.
Faça isso clicando no botão `Create Warehouse` na tarefa `Warehouse`
na guia `Integrations` do painel do Cloudant.

![Captura de tela da tarefa "Create a dashDB warehouse" no painel do Cloudant](../images/createDashDBWH.png)

Se você ainda não tiver efetuado login no Bluemix,
será solicitado para que faça isso.

>   **Nota**: por padrão,
o Cloudant cria uma instância do dashDB no Bluemix para seu warehouse.

![Captura de tela da tarefa "Authenticate to Bluemix" no painel do Cloudant](../images/authenticateToBluemix.png)

Após a autenticação,
será possível solicitar que uma nova instância do dashDB seja criada usando sua conta do Bluemix.
Para fazer isso:

1.  Forneça o nome que gostaria de usar para o Warehouse no campo `Warehouse Name`.
2.  Forneça o nome de seu banco de dados existente no Cloudant, no campo `Data Sources`.
3.  Assegure-se de que a opção `Create new dashDB instance` seja selecionada no formulário.
4.  Clique no botão `Create Warehouse`.

![Captura de tela da tarefa "Create Warehouse" no painel do Cloudant](../images/createWarehouse.png)

### Conectar o Cloudant a um warehouse existente

Em vez de usar o Cloudant para criar o banco de dados de warehouse do dashDB,
é possível conectar-se a uma instância existente do dashDB.

O processo é semelhante ao [uso do Cloudant para criar um warehouse do dashDB](#use-cloudant-to-create-a-dashdb-warehouse),
no entanto, em vez de selecionar a opção `Create new dashDB instance`,
selecione a `dashDB service instance` e escolha o warehouse do dashDB já existente dentro do Bluemix.

![Captura de tela da tarefa "Connect to existing dashDB instance" no painel do Cloudant](../images/existingDashDBInstance.png)

### Usando uma instância do warehouse do DB2

Se preferir,
será possível se conectar a uma instância de warehouse existente do DB2, em vez do dashDB.
Faça isso selecionando a opção `DB2` no painel do Cloudant para se conectar a uma instância existente do DB2.

![Captura de tela da tarefa Create a DB2 warehouse" no painel do Cloudant](../images/createDB2WH.png)

Se desejar se conectar a uma instância do DB2,
deverá fornecer os detalhes a seguir:

-   Endereço do host.
-   Número da porta.
-   Nome do banco de dados.
-   ID do usuário do banco de dados.
-   Senha para o ID do usuário.

>   **Nota**: o restante deste tópico refere-se ao dashDB como a instância do warehouse.
No entanto,
o tópico se aplicará igualmente se você estiver usando uma instância do DB2.
Também está disponível um tutorial descrevendo como
[carregar dados JSON do Cloudant no dashDB ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://developer.ibm.com/clouddataservices../dashdb/get/load-json-from-cloudant-database-in-to-dashdb/){:new_window}
e que inclui exemplos de uso do DB2 como o banco de dados de warehouse.

## Esquema de warehouse

Quando você cria um warehouse pela primeira vez de dentro do Cloudant,
o dashDB cria o melhor esquema possível para os dados dentro do banco de dados,
ajudando a assegurar que cada um dos campos nos documentos JSON possuam uma entrada correspondente no novo esquema.
Opcionalmente,
ao criar o warehouse,
será possível optar por [customizar o esquema](#customizing-the-warehouse-schema) manualmente.

Após a criação do esquema,
o warehouse é capaz de manter os dados em um formato relacional.
O Cloudant então [replica](../api/replication.html) para executar
um 'carregamento inicial' dos documentos do banco de dados no warehouse,
fornecendo uma coleção operacional de seus dados no banco de dados relacional do dashDB.

Com o tempo,
o conteúdo do banco de dados Cloudant pode mudar.
É possível modificar o esquema de um warehouse existente.

>   **Nota**: se você modificar o esquema de um warehouse existente,
os dados do banco de dados Cloudant deverão ser replicados novamente no banco de dados de warehouse.
De fato,
modificar o esquema causa um novo 'carregamento inicial' no warehouse.

## Trabalhando com seu warehouse

Com o warehousing do Cloudant,
é possível executar consultas SQL 'tradicionais'
e visualizar os resultados,
tudo de dentro do console do dashDB.

![Captura de tela do "dashDB dashboard" no Bluemix](../images/useDashDBdashboard.png)

Os aplicativos externos podem interagir com os dados da mesma maneira que com qualquer outro banco de dados relacional.

A vantagem do dashDB é que é possível executar outras tarefas de warehousing,
como o carregamento de mais dados de outras fontes
e a análise dos dados usando ferramentas analíticas integradas.
O dashDB suporta a
linguagem de programação [`'R'` ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://en.wikipedia.org/wiki/R_%28programming_language%29){:new_window}
e o ambiente de software para computação estatística e gráficos.
Isso significa que você terá acesso a algoritmos que permitem executar tarefas analíticas do banco de dados, como regressão linear,
armazenamento em cluster 'k-médias'
e análise geoespacial.

A ferramenta `RStudio` permite criar scripts `'R'` que são então transferidos por upload para o dashDB
e, em seguida, executados usando seus dados.

Para obter mais informações sobre como trabalhar com o dashDB,
veja a [documentação do IBM dashDB Cloud Data Warehouse ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/support/knowledgecenter/SS6NHC/com.ibm.swg.im.dashdb.kc.doc/welcome.html){:new_window}.

## Mantendo os dados e a estrutura atualizados

Os dados são carregados do Cloudant para o dashDB usando um processo de [replicação](../api/replication.html).
Isso significa que se os dados do Cloudant forem atualizados ou modificados de alguma forma,
a replicação dos documentos para o dashDB deverá ocorrer novamente
para assegurar que suas tarefas analíticas continuem a funcionar usando as informações mais atualizadas.

Como acontece com a replicação normal do Cloudant,
os dados são transferidos apenas unidirecionalmente:
para um warehouse, a transferência é do Cloudant para o dashDB.
Após o carregamento de dados inicial,
o warehouse assina as mudanças de conteúdo de dados no banco de dados Cloudant.
Todas as mudanças são replicadas da origem do Cloudant para o destino do dashDB.
Isso significa que o warehousing é uma forma de replicação contínua do Cloudant para o dashDB.

Com o tempo,
seu banco de dados Cloudant também poderá ter mudanças estruturais.
Isso pode incluir a inclusão ou a remoção de campos dos documentos JSON.
Quando isso acontece,
o esquema usado pelo warehouse pode se tornar inválido,
resultando em erros relatados quando dados novos são replicados do Cloudant para o dashDB.

Para resolver esse problema,
o warehousing do Cloudant possui um recurso de 'nova varredura'.
Isso varre novamente a estrutura do banco de dados Cloudant
e determina o novo esquema requerido no dashDB.
As tabelas antigas do dashDB criadas durante a varredura anterior são então descartadas,
novas tabelas são criadas usando o novo esquema
e finalmente os dados atuais do Cloudant são carregados como um novo 'carregamento inicial'.

Para usar o recurso de nova varredura,
assegure-se primeiro de que o warehouse não esteja em execução.
Faça isso como a seguir:

1.  Selecione a guia `Integrations` no painel do Cloudant.
2.  Localize o nome do Warehouse que você deseja varrer novamente na tarefa `Warehouse`:<br/>![Captura de tela da guia "warehouse" no painel do Cloudant](../images/selectWarehouse.png)
3.  Clique no nome do Warehouse.
É um link
e quando clicado, ele abre a visualização de detalhes do warehouse:<br/>![Captura de tela da visualização detalhada do warehouse no painel do Cloudant](../images/viewWarehouseDetail.png)
4.  Verifique o status atual do warehouse.
Um círculo verde rotativo indica que o warehouse está em execução.
Para parar o warehouse,
clique no ícone `Stop Database` na coluna Ações:<br/>![Captura de tela do ícone "stop warehouse database" no painel do Cloudant](../images/stopWarehouseDatabase.png)
5.  Quando o banco de dados de warehouse não está em execução,
o ícone `Rescan` na coluna Ação fica ativado:<br/>![Captura de tela do ícone de nova varredura no painel do Cloudant](../images/rescanIcon.png)

### Varrendo novamente o banco de dados de origem

![Captura de tela da janela que permite varrer novamente o banco de dados de origem do warehouse.](../images/rescanSource.png)

Ao clicar no ícone `Rescan`,
você terá duas opções:

-   Uma varredura direta de seu banco de dados.
Esta é a ação padrão
e é muito semelhante à varredura inicial de seu banco de dados executada quando o warehouse foi criado pela primeira vez.
-   Customize o esquema de warehouse.

Se você escolher a ação padrão de uma nova varredura simples,
seu banco de dados de origem será inspecionado e um novo esquema de banco de dados do warehouse será gerado.
Assim que a nova varredura for concluída,
o warehouse será iniciado.

Se desejar customizar o esquema de warehouse,
ative a caixa de seleção `Customize Schema`,
antes de clicar no botão `Rescan`.

![Captura de tela do painel 'Rescan Source', mostrando a opção 'Customize Schema' ativada.](../images/rescanSource2.png)

A caixa de seleção `Customize Schema` ativa duas opções.

1.  O algoritmo de descoberta usado.
2.  O tamanho da amostra.

### O algoritmo de descoberta

A opção padrão para varrer novamente é o algoritmo `Union`.
Isso usa todos os atributos em todos os documentos do banco de dados Cloudant de amostra
para criar um único conjunto de tabelas no banco de dados de warehouse.
O resultado é que todos os documentos do banco de dados Cloudant podem ser armazenados no banco de dados de warehouse,
mas algumas linhas no banco de dados podem não ter conteúdo em alguns dos campos.

A opção alternativa para varrer novamente é o algoritmo `Cluster`.
Isso identifica documentos no banco de dados Cloudant que possuem o mesmo conjunto de atributos e,
em seguida, cria esquemas de tabela de banco de dados de warehouse correspondentes.

### O tamanho da amostra

Essa opção determina quantos documentos no banco de dados Cloudant
são inspecionados como parte da determinação do esquema.

O valor padrão é 10.000 documentos.

Configurar o valor muito baixo apresenta o risco de que alguns documentos do Cloudant tenham atributos que não sejam detectados
e, portanto, sejam omitidos da estrutura do banco de dados de warehouse.

Configurar o valor muito alto significa que o processo de varredura
para determinar a estrutura do banco de dados de warehouse levará mais tempo para ser concluído.

### Após a nova varredura

Depois que a nova varredura do banco de dados Cloudant tiver sido concluída,
o warehouse não será iniciado automaticamente.
Em vez disso,
ele permanecerá em um estado parado,
para que o banco de dados de warehouse possa ser customizado.

## Customizando o esquema de warehouse

É possível modificar o esquema do banco de dados determinado automaticamente
durante o processo de criação inicial do warehouse
ou após uma nova varredura.
Para fazer isso,
assegure-se de verificar a opção `Customize Schema` durante o processo de criação:

![Captura de tela do painel de criação do warehouse, mostrando a opção 'Customize Schema' ativada.](../images/customizeSchema01.png)

O warehouse é criado no dashDB normalmente,
no entanto, ele não é iniciado imediatamente.
Em vez disso,
você tem a oportunidade de customizar o esquema antes de continuar.

Para fazer isso,
clique no link para seu warehouse:

![Captura de tela do botão `Open in dashDB`.](../images/openInDashDB.png)

A exibição resultante fornecerá um botão para customizar o esquema usado para seu banco de dados de origem.
Passar o mouse sobre o indicador de Status confirma que o esquema está pronto para customização:

![Captura de tela do botão `Customize <source database name>`.](../images/customizeSchema02.png)

Clicar no botão 'Customize' resultará em um painel no qual é possível modificar os campos no esquema do banco de dados:

![Captura de tela do painel Customizar esquema.](../images/customizeSchema03.png)

Para reconfigurar o esquema para o padrão,
clique no botão `Rescan`:

![Captura de tela do botão `Rescan`.](../images/customizeSchema04.png)

Quando estiver satisfeito com o esquema do banco de dados para o warehouse,
bastará clicar no botão `Run`:

![Captura de tela do botão `Run`.](../images/customizeSchema05.png)

O esquema é salvo
e o warehouse é iniciado.

### Customizando um esquema de warehouse existente

Se o esquema do banco de dados para o warehouse já existir,
você terá a [opção para customizá-lo](#keeping-the-data-and-structure-fresh).

## Solucionando problemas

De tempos em tempos,
é possível que você encontre problemas ao usar o recurso de warehousing.
Informações sobre alguns desses problemas são fornecidas posteriormente neste tópico.

Além disso,
a discussão de alguns erros ou problemas comuns,
além dos detalhes de como solucioná-los,
estão disponíveis no [Stack Overflow ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://stackoverflow.com/questions/tagged/cloudant+dashdb){:new_window}.

Se precisar de ajuda adicional
e não puder localizar soluções no Stack Overflow,
entre em contato com o [Suporte do Cloudant ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](mailto:support@cloudant.com){:new_window}.

### Exceções visíveis no painel

Às vezes,
o warehouse encontra uma condição de erro.
Por exemplo,
se você tentar criar um warehouse usando um banco de dados DB2 existente,
mas falhar ao inserir os detalhes corretos do banco de dados,
o warehouse não poderá ser criado com sucesso.

Quando existir uma condição de erro,
o status do warehouse mudará para um círculo vermelho,
indicando que há um problema que requer sua atenção:

![Captura de tela do indicador de status de erro.](../images/errorIndicator1.png)

Se você 'passar o mouse sobre' o indicador,
serão fornecidas mais algumas informações:

![Captura de tela mostrando o resumo da ajuda instantânea do status de erro.](../images/errorIndicator2.png)

Quando você clica no indicador,
aparece uma janela fornecendo mais detalhes sobre o que é o problema exatamente.
Neste exemplo,
os detalhes do host inseridos para a conexão do DB2 não eram válidos:

![Captura de tela mostrando o resumo da ajuda instantânea do status de erro.](../images/errorIndicator3.png)

### Avisos e erros

As mudanças no banco de dados Cloudant são replicadas para o banco de dados de warehouse.
É possível que uma mudança possa não se ajustar ao warehouse ou a seu esquema.
Problemas desse tipo são detectados e registrados na tabela `OVERFLOW` do banco de dados de warehouse.

Por exemplo,
se o esquema de warehouse tiver um campo `Movie_earnings_rank` do tipo `VARCHAR`
e puder conter até 32 caracteres,
mas uma mudança no banco de dados Cloudant requerer armazenamento de 40 caracteres,
o campo 'estourará'.
Isso produziria uma condição de 'aviso',
que é indicado no ícone de status do painel do warehouse:

![Captura de tela mostrando a mensagem de aviso no ícone de status.](../images/overflowWarning.png)

Ao verificar a tabela de estouro indicada no banco de dados de warehouse,
você vê mais detalhes sobre o aviso:

![Captura de tela mostrando os detalhes da mensagem de aviso na tabela Estouro do banco de dados de warehouse.](../images/overflowWarningDetail.png)

Neste exemplo,
o aviso torna claro que ocorreu um truncamento,
afetando o campo `Movie_earnings_rank` do documento do Cloudant que tem um `_ID` de `70f6284d2a395396dbb3a60b4cf1cac2`.

Há duas opções de solução possíveis:

-   Corrigir o campo de estouro no documento do Cloudant.
-   [Atualizar o esquema de warehouse](#customizing-the-warehouse-schema).

A opção escolhida depende de se o conteúdo extra no campo é intencional ou não.
Se você requerer o conteúdo extra para seu aplicativo,
será necessário
[atualizar o esquema de warehouse](#customizing-the-warehouse-schema) para remover a condição de aviso.

Um problema mais significativo será se um campo inteiramente novo for introduzido em um documento no banco de dados Cloudant,
mas o campo não tiver uma contraparte no esquema do banco de dados de warehouse.
Isso causa uma condição de 'erro'.

Por exemplo,
um documento no banco de dados Cloudant pode 'ganhar' um campo extra chamado `my key`
que não existe no esquema do banco de dados de warehouse:

![Captura de tela mostrando o campo 'my key' adicional em um documento.](../images/extraField.png)

O resultado é uma condição de erro,
que é indicada no ícone de status do painel do warehouse:

![Captura de tela mostrando a mensagem de erro no ícone de status.](../images/overflowError.png)

Ao verificar a tabela de estouro indicada no banco de dados de warehouse,
você vê mais detalhes sobre o erro:

![Captura de tela mostrando os detalhes da mensagem de erro na tabela Estouro do banco de dados de warehouse.](../images/overflowErrorDetail.png)

Neste exemplo,
o erro deixa claro que foi encontrado um campo
que não estava presente quando o esquema do banco de dados de warehouse foi criado.
O próprio campo foi detectado no documento do Cloudant tendo um `_ID` de `70f6284d2a395396dbb3a60b4cf1cac2`.

Há duas opções de solução possíveis:

-   Remover o campo extra do documento do Cloudant.
-   [Atualizar o esquema de warehouse](#customizing-the-warehouse-schema).

A opção escolhida depende de se o campo extra é intencional ou não.
Se você requerer o campo extra para seu aplicativo,
será necessário [atualizar o esquema de warehouse](#customizing-the-warehouse-schema) para remover a condição de erro.
