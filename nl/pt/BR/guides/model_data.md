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

# Minhas 5 principais dicas para modelar seus dados para escala

Este artigo considera os melhores
pontos da modelagem de dados de seu aplicativo para que funcione de maneira eficiente em grande escala.
{:shortdesc}

_(Este guia se baseia em um artigo de Blog de Mike Rhodes:
["Minhas 5 principais dicas para modelar seus dados para escala" ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://cloudant.com/blog/my-top-5-tips-for-modelling-your-data-to-scale/){:new_window},
publicado originalmente em 17 de dezembro de 2013.)_

A maneira com que você modela dados no Cloudant afetará significativamente como seu aplicativo será capaz de
escalar. Nosso modelo de dados subjacente difere substancialmente de um modelo relacional e ignorar
esta distinção pode ser a causa de problemas de desempenho durante a jornada.

Como sempre, a modelagem bem-sucedida envolve alcançar um equilíbrio entre a facilidade de uso versus as
características de desempenho que você está esperando alcançar.

Sem mais delongas, vamos ao que interessa.

## Considerar dados imutáveis

Se você estiver mudando a mesma parte de estado em uma taxa de uma vez por segundo ou mais, considere
tornar seus documentos imutáveis. Isso diminui significativamente a possibilidade de criar
documentos em conflito.

Por outro lado, se você estiver atualizando um determinado documento menos de uma vez a cada dez segundos, um
modelo de dados de atualização no local - isto é, atualizar documentos existentes - simplificará o seu
código do aplicativo consideravelmente.

Geralmente, modelos de dados baseados em dados imutáveis requerem o uso de visualizações para resumir
os documentos que compõem o estado atual. Como as visualizações são pré-calculadas, isso não deveria
prejudicar o desempenho do aplicativo.

## Por que isso ajuda

Atrás de sua interface `https://<account>.cloudant.com/` há um banco de dados distribuído.
Dentro do cluster, os documentos são depositados em vários shards que formam coletivamente o
banco de dados. Esses shards são então distribuídos entre os nós no cluster. Isso é o que nos
permite suportar bancos de dados com muitos terabytes de tamanho.

Por padrão, além da divisão de um banco de dados em shards, todos os shards possuem três
cópias ou réplicas de shard, cada uma das quais reside em um nó diferente do cluster de banco de dados.
Isso permitirá que o banco de dados continue atendendo a solicitações se um nó falhar. Portanto,
salvar um documento envolve gravar em três nós. O que isso significa é que se duas atualizações forem
feitas simultaneamente no mesmo documento, será possível que um subconjunto de nós aceite a primeira
atualização e outro subconjunto aceite a segunda atualização. Quando o cluster descobrir essa
discrepância, ele combinará os documentos da mesma maneira que a replicação normal para
atualizações simultâneas, criando um conflito.

Documentos em conflito prejudicam o desempenho; veja abaixo para obter mais detalhes sobre o motivo de isso acontecer.
Um padrão de atualização no local altamente simultâneo também aumentará a probabilidade de que as gravações
serão rejeitadas porque o parâmetro `_rev` não é o esperado, o que forçará seu
aplicativo a tentar novamente e então atrasar o processamento.

Descobrimos que este cenário de documento em conflito é significativamente mais provável de acontecer
para atualizações mais frequentes que uma vez por segundo, mas recomendamos que documentos imutáveis para atualizações de
mais de uma vez a cada dez segundos estejam no lado seguro.

## Usar visualizações para pré-calcular resultados em vez de como índices de procura

Em vez de usar visualizações como índices de procura glorificados - "consiga para mim todos os documentos `person`" - tente
fazer com que o banco de dados faça o trabalho para você. Por exemplo, em vez de recuperar todos os dez mil
documentos de pessoa para calcular suas horas combinadas trabalhadas, use uma visualização com uma chave composta para
pré-calcular isso por ano, mês, dia, meio dia e hora usando a redução integrada `_sum`.
Você salvará o trabalho em seu aplicativo e permitirá que o banco de dados se concentre em atender muitas
solicitações pequenas, em vez de ler grandes quantias de dados do disco para atender uma única solicitação
grande.

## Por que isso ajuda

É bastante direto. Primeiro, observe que os mapas e as reduções são pré-calculados. Isso significa
que solicitar o resultado de uma função de redução é uma operação barata, especificamente quando
comparado a quantias significativas de E/S necessária para transmitir centenas ou até milhares de
documentos do armazenamento em disco.

Em um nível inferior, quando um nó recebe uma solicitação de visualização, ele solicita aos nós que estão retendo as réplicas
de shard do banco de dados da visualização os resultados da solicitação de visualização dos documentos em
cada shard. Conforme ele recebe as respostas - usando a primeira de cada réplica de shard - o nó
que atende à solicitação de visualização combina os resultados e transmite o resultado final para o cliente.
Conforme mais documentos são envolvidos, leva mais tempo para cada réplica transmitir os resultados do
disco e pela rede. Além disso, o nó que está atendendo a solicitação tem muito mais trabalho para
executar ao combinar os resultados de cada shard do banco de dados.

Em geral, o objetivo é que uma solicitação de visualização requeira a quantia mínima de dados de cada shard,
minimizando o tempo que os dados estão em trânsito e sendo combinados para formar o resultado final. Usar
o poder de visualizações para pré-calcular os dados agregados é uma maneira de alcançar esse objetivo. Isso obviamente
diminui o tempo que seu aplicativo gasta aguardando a conclusão da solicitação.

## Desnormalizar seus dados

Em bancos de dados relacionais, a normalização de dados geralmente é a maneira mais eficiente de armazenar dados.
Isso faz muito sentido quando é possível usar JOINs para combinar facilmente dados de múltiplas tabelas.
No Cloudant, é mais provável que você precisará de uma solicitação HTTP GET para cada parte de dados, portanto, reduzir
o número de solicitações necessárias para construir uma imagem completa de uma entidade modelada permitirá
apresentar informações para seus usuários mais rapidamente.

O uso de visualizações permite obter muitos dos benefícios de dados normalizados enquanto se mantém a
versão desnormalizada para eficiência.

Como exemplo, em um esquema relacional você normalmente representaria as tags em uma tabela separada e usaria
uma tabela de conexão para associar as tags a seus documentos associados, permitindo uma consulta rápida de todos os
documentos com uma determinada tag.

No Cloudant, você armazenaria as tags em uma lista em cada documento. Você usaria então uma visualização para obter os
documentos com uma determinada tag
[emitindo cada tag como uma chave na função de mapa de sua visualização](../api/creating_views.html).
Consultar a visualização em busca de uma determinada chave fornecerá então todos os documentos com essa tag.

## Por que isso ajuda

Tudo se resume ao número de solicitações de HTTP que seu aplicativo faz. Há um custo para
abrir conexões HTTP - especificamente HTTPS - e, embora a reutilização de conexões ajude, fazer
menos solicitações em geral acelerará a taxa em que seu aplicativo poderá processar dados.

Como um benefício secundário, os documentos desnormalizados e as visualizações pré-calculadas geralmente permitem que você tenha o
valor que seu aplicativo requer gerado antecipadamente, em vez de ser construído
automaticamente no momento da consulta.

## Evitar conflitos usando documentos com granularidade mais baixa

Conflitante com o conselho para desnormalizar seus dados, este é o próximo conselho: use
documentos com baixa granularidade para reduzir a possibilidade de que modificações simultâneas criem conflitos.
Isso é algo como normalizar seus dados. Há um equilíbrio entre reduzir o
número de solicitações de HTTP e evitar conflitos.

Por exemplo, pegue um registro médico contendo uma lista de operações:

```json
{
    "_id": "Joe McIllness",
    "operations": [
        { "surgery": "heart bypass" },
        { "surgery": "lumbar puncture" }
    ]
}
```
{:codeblock}

Se, por falta de sorte, Joe estiver lidando com muitas operações ao mesmo tempo, as várias
atualizações simultâneas de um documento tenderão a criar documentos em conflito, conforme descrito acima.
Será melhor dividir as operações em documentos separados que se refiram ao documento da pessoa de Joe
e usar uma visualização para conectar as coisas juntas. Para representar cada operação, você faria upload de documentos
como os dois exemplos a seguir:

```json
{
    "type": "operation",
    "patient": "Joe McIllness",
    "surgery": "heart bypass"
}
```
{:codeblock}

```json
{
    "type": "operation",
    "patient": "Joe McIllness",
    "surgery": "lumbar puncture"
}
```
{:codeblock}

Emitir o campo `"patient"` como a chave na visualização permitiria então consultar todas
as operações de um determinado paciente. Novamente, as visualizações são usadas para ajudar a unir uma imagem completa de
uma determinada entidade de documentos separados, ajudando a manter baixo o número de solicitações de HTTP,
apesar de termos dividido os dados de uma única entidade modelada.

## Por que isso ajuda

Evitar documentos em conflito ajuda a acelerar muitas operações nos bancos de dados Cloudant.
Isso ocorre porque há um processo que planeja a revisão vencedora atual usada sempre que
o documento é lido: recuperações de documento único, chamadas com `include_docs=true`, construção da visualização
e assim por diante.

A revisão vencedora é uma revisão específica da árvore geral do documento. Lembre-se de que
os documentos no Cloudant são na verdade árvores de revisões. Um algoritmo arbitrário, porém determinístico,
seleciona uma das folhas não excluídas dessa árvore para retornar quando uma solicitação é feita para o
documento. Árvores maiores com um fator de ramificação maior demoram mais para serem processadas que uma árvore de
documentos sem ou com poucas ramificações: cada ramificação precisa ser seguida para ver se é uma candidata a
ser a revisão vencedora. Os potenciais vencedores precisam então ser comparados entre si para fazer
a escolha final.

O Cloudant obviamente manipula bem pequenos números de ramificações - afinal, a replicação conta com
o fato de que os documentos podem ser ramificados para evitar o descarte de dados - mas quando níveis patológicos são
atingidos, especificamente se os conflitos não forem resolvidos, será muito demorado e
intenso o uso de memória para percorrer a árvore de documentos.

## Resolução de conflitos integrados

Em um sistema eventualmente consistente como o Cloudant, conflitos acabarão por acontecer. Conforme
descrito acima, esse é um preço de nossa escalabilidade e resiliência de dados.

Estruturar seus dados de uma forma que a resolução de conflitos seja rápida e não precise envolver
assistência do operador ajudará a manter os bancos de dados funcionando sem problemas. A capacidade de
resolver conflitos automaticamente sem a necessidade de envolvimento de seus usuários também
melhorará significativamente a experiência deles e reduzirá a carga de suporte em sua organização.

A forma de fazer isso é muito específica do aplicativo, mas aqui estão algumas dicas:

-   Evite invariáveis nos campos de documentos, se possível. Isso torna mais provável que uma simples
operação de mesclagem, usando o campo mudado de cada revisão de documento de conflito, seja
adequada. Isso torna o código do aplicativo mais simples e mais robusto.
-   Permita documentos independentes. A necessidade de recuperar outros documentos para planejar a resolução
correta aumentará a latência na resolução de conflitos. Há também a possibilidade de obter uma
versão dos outros documentos que não está consistente com o documento que está sendo resolvido,
dificultando a resolução correta. E se os outros documentos estiverem em conflito?

## Por que isso ajuda

Conforme descrito acima, documentos altamente conflitantes exercem uma carga pesada no banco de dados. A capacidade
de resolver conflitos do início é uma grande ajuda para evitar
documentos patologicamente conflitantes.

## Resumo

Essas dicas demonstram como algumas das maneiras de modelar dados afetarão o desempenho de
seu aplicativo. O armazenamento de dados do Cloudant tem algumas características específicas, tanto para observar
como para aproveitar, para certificar-se de que o desempenho do banco de dados seja escalado à medida que seu aplicativo
cresça. Entendemos que a mudança pode ser confusa, portanto, estamos sempre disponíveis para dar orientações.

Para leitura adicional, veja esta discussão sobre o
["modelo de dados para Foundbite" ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://cloudant.com/blog/foundbites-data-model-relational-db-vs-nosql-on-cloudant/){:new_window}
ou este ["exemplo de nossos amigos no Twilio" ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.twilio.com/blog/2013/01/building-a-real-time-sms-voting-app-part-3-scaling-node-js-and-couchdb.html){:new_window}.

