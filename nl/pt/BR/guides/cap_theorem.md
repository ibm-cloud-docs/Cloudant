---

copyright:
  years: 2015, 2017
lastupdated: "2017-01-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-01-24 -->

<div id="cap_theorem"></div>

<div id="consistency"></div>

# Teorema CAP

O {{site.data.keyword.cloudantfull}} usa um modelo ['Eventualmente consistente' ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://en.wikipedia.org/wiki/Eventual_consistency){:new_window}.
{:shortdesc}

Para entender como esse modelo funciona
e porque é uma parte essencial do uso do {{site.data.keyword.cloudant_short_notm}},
considere o que se entende por Consistência.

Consistência é uma das quatro propriedades ['ACID' ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://en.wikipedia.org/wiki/ACID){:new_window}
necessárias para que transações dentro de um banco de dados sejam processadas e relatadas de forma confiável.

Além disso,
consistency é um dos três atributos no
teorema <a href="http://en.wikipedia.org/wiki/CAP_Theorem" target="_blank">'CAP' <img src="../images/launch-glyph.svg" alt="Ícone de link externo" title="Ícone de link externo"></a>.
Os atributos são **C**onsistency,
**A**vailability e **P**artition tolerance.
O teorema afirma que não é possível para um sistema de computador distribuído, como {{site.data.keyword.cloudant_short_notm}},
garantir três atributos _simultaneamente_:

-   Consistência,
em que todos os nós veem os mesmos dados ao mesmo tempo.
-   Disponibilidade,
que garante que cada solicitação receba uma resposta sobre se foi bem-sucedida ou falhou.
-   Tolerância de partição,
em que o sistema continuará a operar, mesmo se qualquer parte do sistema for perdida ou falhar.

A impossibilidade de garantir os três atributos ao mesmo tempo
significa que o {{site.data.keyword.cloudant_short_notm}} não garante o atributo Consistency.
Em um modelo eventualmente consistente,
como {{site.data.keyword.cloudant_short_notm}},
uma atualização feita em uma parte do sistema é _eventualmente_ vista por outras partes do sistema.
À medida que a atualização se propaga,
diz-se que o sistema 'converge' em consistência completa.

A consistência eventual é boa para o desempenho.
Com um modelo de consistência forte,
um sistema deve esperar que quaisquer atualizações sejam propagadas por completo e com sucesso
para que uma solicitação de gravação ou atualização possa ser concluída.
Com um modelo eventualmente consistente,
a solicitação de gravação ou atualização pode retornar quase imediatamente,
enquanto a propagação pelo sistema continua 'nos bastidores'.

Um banco de dados pode exibir apenas dois destes três atributos por razões teóricas e práticas.
Um banco de dados que prioriza consistência e disponibilidade é simples:
um único nó armazena uma única cópia de seus dados.
Mas este modelo é difícil de escalar, pois deve-se fazer upgrade do nó para obter mais desempenho,
em vez de usar nós extras.
E
mesmo uma falha menor do sistema pode encerrar um sistema de único nó,
enquanto qualquer perda de mensagem significa perda de dados significativos.
Para suportar,
o sistema deve se tornar mais sofisticado.

## Trocas na Tolerância de partição

Um banco de dados que prioriza consistência e tolerância de partição geralmente emprega uma
configuração <a href="http://en.wikipedia.org/wiki/Master/slave_(technology)" target="_blank">mestre-escravo <img src="../images/launch-glyph.svg" alt="Ícone de link externo" title="Ícone de link externo"></a>,
em que um nó dos vários no sistema é eleito líder.
Apenas o líder pode aprovar gravações de dados,
enquanto todos os nós secundários replicam dados do líder para manipular as leituras.
Se o líder perder a conexão com a rede
ou não puder se comunicar com vários dos nós do sistema,
o restante elegerá um novo líder.
Este processo de eleição difere entre os sistemas
e pode ser uma origem de [problemas significativos ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://aphyr.com/posts/284-call-me-maybe-mongodb){:new_window}.

O {{site.data.keyword.cloudant_short_notm}} prioriza a disponibilidade e a tolerância de partição empregando uma configuração mestre/mestre,
para que cada nó possa aceitar gravações e leituras para sua parte dos seus dados.
Vários nós contêm cópias de cada parte de seus dados.
Cada nó copia dados com outros nós.
Se um nó se tornar inacessível,
outros poderão entregar em seu lugar, enquanto a rede sana o problema.
Dessa forma,
o sistema retornará seus dados em tempo hábil apesar de falha arbitrária do nó
e manterá a [consistência eventual ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://en.wikipedia.org/wiki/Eventual_consistency){:new_window}.
A troca em despriorizar a consistência absoluta é que leva tempo para todos os nós verem os mesmos dados.
Como resultado,
algumas respostas podem conter dados antigos enquanto os novos dados são propagados pelo sistema.

## Mudando a abordagem

A manutenção de uma visualização consistente de dados é lógica e fácil de entender,
porque um banco de dados relacional faz esse trabalho para você.
A expectativa é que os serviços baseados na web que interagem com sistemas de banco de dados se comportem dessa maneira.
Mas essa expectativa não significa que funcionarão assim.
A consistência não é um dado
e dá um pouco de trabalho mudar a abordagem.

Na verdade,
a consistência não é necessariamente essencial para vários serviços de nuvem corporativos.
Sistemas
grandes com alta utilização trazem com eles uma grande probabilidade de que uma parte do sistema pode falhar.
Um banco de dados planejado em torno da necessidade de priorizar a disponibilidade e a consistência eventual
é mais adequado para manter seu aplicativo on-line.
A consistência de dados do aplicativo pode ser tratada após o fato.
Conforme Seth Gilbert e Nancy Lynch da MIT
[concluem ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://www.glassbeam.com/sites/all/themes/glassbeam/images/blog/10.1.1.67.6951.pdf){:new_window},
"boa parte dos sistemas do mundo real hoje em dia é forçada a resolver retornando 'a maioria dos dados, na maioria das vezes'".

## Disponibilidade do aplicativo versus consistência na empresa

Um olhar nos serviços populares baseados na web mostra que as pessoas já esperam alta disponibilidade
e trocam muito bem essa disponibilidade por dados eventualmente consistentes,
muitas vezes sem perceber que estão fazendo isso.

Muitos aplicativos enganam os usuários por causa da disponibilidade.
Considere os ATMs:
dados financeiros inconsistentes é o motivo de ainda ser possível sacar dinheiro sem perceber.
Será impraticável apresentar uma visualização consistente de seu saldo da conta em todo o sistema financeiro
se cada nó na rede tiver que parar e registrar essa estimativa para que as operações continuem.
É melhor tornar o sistema altamente disponível.

O setor financeiro percebeu isso nos anos 80,
mas várias organizações de TI ainda estão preocupadas em sacrificar a consistência por causa da disponibilidade.
Pense no número de chamadas de suporte feitas quando sua equipe de vendas não pode acessar o app CRM.
Agora considere se eles perceberiam mesmo, uma vez que leva alguns segundos para uma atualização de banco de dados
se propagar em todo o aplicativo.

A disponibilidade supera a consistência mais do que se pode esperar.
Sistemas de carrinho de compras on-line,
caches HTTP
e DNS são mais alguns exemplos.
As organizações devem considerar o custo do tempo de inatividade, como frustração do usuário,
perda de produtividade
e oportunidades perdidas.

## Da teoria à implementação

Tratar a alta disponibilidade é vital para aplicativos em nuvem.
Caso contrário,
a consistência de banco de dados global permanecerá um gargalo importante na escalada.
Os aplicativos altamente disponíveis precisam manter contato constante com seus dados,
mesmo se esses dados não forem os mais atualizados.
Este é o conceito de consistência eventual
e não há nada a temer.
Em grande escala,
às vezes é melhor entregar respostas que não estão perfeitamente corretas do que não entregá-las.

Os sistemas de banco de dados ocultam as complexidades de disponibilidade versus consistência em diferentes maneiras,
mas elas estão sempre lá.
A visualização que é tomada pelo banco de dados como um serviço do {{site.data.keyword.cloudant_short_notm}},
junto ao CouchDB e outros bancos de dados NoSQL,
é que é melhor requerer que os desenvolvedores direcionem essas complexidades no início do processo de design.
Ao fazer o trabalho duro na frente,
você reduz as surpresas porque os aplicativos estão prontos para escalar desde o primeiro dia.
