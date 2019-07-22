---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: couchapp, 3-tier application

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

<!-- Acrolinx: 2018-05-07 -->

# CouchApps
{: #couchapps}

O {{site.data.keyword.cloudantfull}} pode hospedar dados do arquivo brutos,
como imagens,
e entregá-los por meio de HTTP,
o que significa que ele pode hospedar todos os arquivos estáticos necessários para executar um website
e hospedá-los como um servidor da web.
{: shortdesc}

Como esses arquivos seriam hospedados no {{site.data.keyword.cloudant_short_notm}},
o JavaScript do lado do cliente poderia acessar bancos de dados {{site.data.keyword.cloudant_short_notm}}.
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
{: #a-couchapp-is-appropriate-if-}

-   Seu servidor tiver fornecido somente uma API para o {{site.data.keyword.cloudant_short_notm}} de qualquer maneira.
-   Você concordar em usar a
    [autenticação baseada em cookie](/docs/services/Cloudant?topic=cloudant-authentication#cookie-authentication) do {{site.data.keyword.cloudant_short_notm}}.
-   Você concordar em usar os bancos de dados [`_users` e `_security`](/docs/services/Cloudant?topic=cloudant-authorization#using-the-_users-database-with-cloudant-nosql-db)
    do {{site.data.keyword.cloudant_short_notm}} para gerenciar usuários e permissões.
-   Não for necessário planejar cronjobs ou outras tarefas regulares.

Para introdução aos CouchApps,
leia [Gerenciando aplicativos no {{site.data.keyword.cloudant_short_notm}} ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://cloudant.com/blog/app-management/){: new_window}.

## Um aplicativo de 3 camadas será apropriado se...
{: #a-3-tier-application-is-appropriate-if-}

-   Você precisa de permissões de granularidade menor do que aquela que o banco de dados `_security`
permite.
-   Você precisar de um método de autenticação diferente da autenticação básica ou autenticação de
cookie, como Oauth ou um sistema de login de terceiro.
-   Você precisar planejar tarefas fora do cliente para uma execução regular.

Será possível gravar a camada de seu servidor usando as tecnologias que funcionarem melhor
para você.
Uma lista de bibliotecas para trabalhar com o {{site.data.keyword.cloudant_short_notm}} está disponível na página [Fundamentos básicos do {{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant?topic=cloudant-client-libraries#client-libraries).
