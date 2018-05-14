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

# CouchApps

O Cloudant pode hospedar dados de arquivo brutos,
como imagens,
e entregá-los por meio de HTTP,
o que significa que ele pode hospedar todos os arquivos estáticos necessários para executar um website
e hospedá-los como um servidor da web.
{:shortdesc}

Como esses arquivos seriam hospedados no Cloudant,
o JavaScript do lado do cliente poderia acessar bancos de dados Cloudant.
Um aplicativo construído assim é mencionado como tendo uma arquitetura de duas camadas,
consistindo no cliente - geralmente um navegador - e no banco de dados.
Na comunidade CouchDB,
isso é chamado de CouchApp.

A maioria dos apps da web possui três camadas:
o cliente,
o servidor
e o banco de dados.
A colocação do servidor entre o cliente e o banco de dados pode ajudar na autenticação,
autorização,
gerenciamento de ativos,
aproveitamento de APIs da web de terceiros,
fornecimento de terminais especificamente sofisticados,
etc.
Essa separação permite uma maior complexidade sem confundir preocupações,
para que seu cliente possa se preocupar com a apresentação de dados do começo ao fim,
enquanto seu banco de dados pode se concentrar no armazenamento e na entrega de dados.

Os CouchApps brilham em sua simplicidade,
mas frequentemente um app da web precisará do poder de uma arquitetura de 3 camadas.
Quando cada um é apropriado?

## Um CouchApp será apropriado se...

-   De qualquer forma, o servidor tiver fornecido apenas uma API para o Cloudant.
-   Estiver tudo bem para você usar a
    [autenticação baseada em cookie](../api/authentication.html) do Cloudant.
-   Estiver tudo bem para você usar os bancos de dados [`_users` e `_security`](../api/authorization.html)
do Cloudant para gerenciar usuários e permissões.
-   Não for necessário planejar cronjobs ou outras tarefas regulares.

Para iniciar a utilização dos CouchApps,
leia [Gerenciando aplicativos no Cloudant ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://cloudant.com/blog/app-management/){:new_window}.

## Um aplicativo de 3 camadas será apropriado se...

-   Você precisa de permissões de granularidade menor do que aquela que o banco de dados `_security`
permite.
-   Você precisar de um método de autenticação diferente da autenticação básica ou autenticação de
cookie, como Oauth ou um sistema de login de terceiro.
-   Você precisar planejar tarefas fora do cliente para uma execução regular.

Será possível gravar a camada de seu servidor usando as tecnologias que funcionarem melhor
para você.
Está [disponível](../libraries/index.html) uma lista de bibliotecas para trabalhar com o Cloudant.
