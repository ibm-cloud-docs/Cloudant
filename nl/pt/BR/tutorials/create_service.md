---

copyright:
  years: 2017, 2018
lastupdated: "2018-06-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# Criando uma instância do {{site.data.keyword.cloudant_short_notm}} no {{site.data.keyword.Bluemix_notm}}

Este tutorial mostra como criar uma instância de serviço do {{site.data.keyword.cloudantfull}}
usando o painel do {{site.data.keyword.Bluemix}}
e mostra onde localizar as informações essenciais para permitir que os aplicativos
funcionem com o banco de dados.
{:shortdesc}

Para acessar uma instância de serviço do {{site.data.keyword.cloudant_short_notm}},
você requer um conjunto de [Credenciais de serviço](#the-service-credentials).
As credenciais serão geradas como parte do processo quando você criar uma instância de serviço.

Também será possível localizar essas credenciais a qualquer momento,
acessando sua conta do {{site.data.keyword.cloudant_short_notm}}.

## Criando uma instância de serviço

1.  Efetue login em sua conta do {{site.data.keyword.Bluemix_notm}}.<br/>
    O painel do {{site.data.keyword.Bluemix_notm}} pode ser localizado em:
[http://bluemix.net ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://bluemix.net){:new_window}.
    Após a autenticação com seu nome de usuário e senha,
será apresentado o painel do {{site.data.keyword.Bluemix_notm}}:<br/>
    ![Painel do {{site.data.keyword.Bluemix_notm}}](images/img0001.png)

2.  Clique no link `Catalog`:<br/>
    ![Link do catálogo do {{site.data.keyword.Bluemix_notm}}](images/img0002.png)<br/>
    Aparece uma lista dos serviços disponíveis no {{site.data.keyword.Bluemix_notm}}.

3.  Clique na entrada `Data & Analytics` sob o título `Services`:<br/>
    ![Serviços de Dados e Analítica do {{site.data.keyword.Bluemix_notm}}](images/img0003.png)<br/>
    Aparece uma lista dos serviços de Dados e Analítica
disponíveis no {{site.data.keyword.Bluemix_notm}}.

4.  Clique no serviço {{site.data.keyword.cloudant_short_notm}}:<br>
    ![Seleção de serviço do {{site.data.keyword.Bluemix_notm}} {{site.data.keyword.cloudant_short_notm}}](images/img0004.png)

5.  Na janela de configuração de serviço,
insira um nome de serviço.
    Neste exemplo,
o nome do serviço é `Cloudant Service 2017`:<br/>
    ![Nome do serviço e credenciais do {{site.data.keyword.cloudant_short_notm}}](images/img0005.png)

6.  Por padrão,
o serviço é criado usando o plano de precificação 'Lite',
que é gratuito, mas oferece capacidade limitada.
    Outros planos de precificação
com maior capacidade
[estão disponíveis](../offerings/bluemix.html).<br/>
    Para criar o serviço,
clique no botão `Create`:<br/>
    ![Criar o nome do serviço e as credenciais do {{site.data.keyword.cloudant_short_notm}}](images/img0006.png)

7.  Aparece uma página de serviço
confirmando que seu novo serviço {{site.data.keyword.cloudant_short_notm}} está disponível.
    Para acessar as informações de conexão que seu aplicativo precisa para se conectar ao serviço,
clique na guia `Credenciais de serviço`:<br/>
    ![Acessando as credenciais de serviço do {{site.data.keyword.cloudant_short_notm}}](images/img0007.png)

8.  A janela Credenciais de serviço aparece.
    Para ver as credenciais necessárias para acessar o serviço,
clique na lista suspensa `View Credentials`:<br/>
    ![Visualizando as credenciais de serviço do {{site.data.keyword.cloudant_short_notm}}](images/img0008.png)

9.  Os detalhes de Credenciais de serviço aparecem:<br/>
    ![As credenciais de serviço do {{site.data.keyword.cloudant_short_notm}}](images/img0009.png)

>   **Nota**: as credenciais de serviço nestes exemplos
    foram definidos quando um serviço de demonstração do {{site.data.keyword.cloudant_short_notm}} foi criado no {{site.data.keyword.cloudant_short_notm}}.
    As credenciais foram reproduzidas aqui para mostrar como apareceriam no painel.
    No entanto, o serviço de demonstração do {{site.data.keyword.cloudant_short_notm}} foi removido; portanto, essas credenciais não são mais válidas; _deve-se_ fornecer e usar as suas próprias credenciais de serviço.

## As credenciais de serviço

>   **Nota**: as credenciais de serviço são valiosas.
    Se alguém ou algum aplicativo tiver acesso às credenciais,
eles poderão efetivamente fazer o que quiserem com a instância de serviço,
por exemplo, poderão criar dados falsos
ou excluir informações de valor.
    Proteja essas credenciais cuidadosamente.

As credenciais de serviço consistem em cinco campos:

Campo      | Propósito
-----------|--------
`host`     | O nome do host usado por aplicativos para localizar a instância de serviço.
`username` | O nome do usuário necessário para que os aplicativos acessem a instância de serviço.
`password` | A senha necessária para que os aplicativos acessem a instância de serviço.
`port`     | O número da porta HTTP para acessar a instância de serviço no host. Normalmente 443 para forçar o acesso HTTPS.
`url`      | Uma sequência que agrega outras informações de credenciais em uma única URL, adequada para ser usada pelos aplicativos.

Para criar um aplicativo que possa acessar sua instância de serviço,
você precisará dessas credenciais.

## Localizando suas credenciais de serviço

A qualquer momento,
é possível localizar as credenciais de um serviço que esteja associado à sua conta.

1.  Inicie efetuando login no {{site.data.keyword.cloudant_short_notm}}.
    O painel do {{site.data.keyword.Bluemix}} pode ser localizado em:
    [http://bluemix.net ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://bluemix.net){:new_window}.
    Após a autenticação com seu nome de usuário e senha,
será apresentado o painel do {{site.data.keyword.Bluemix_notm}}:<br/>
    ![Painel do {{site.data.keyword.Bluemix_notm}}](images/img0001.png)

2.  Role para baixo no painel
até chegar na seção que lista todos os serviços:<br/>
    ![{{site.data.keyword.Bluemix_notm}}' listagem de serviço](images/img0010.png)

3.  Neste exemplo,
queremos localizar as credenciais de serviço da instância de serviço do {{site.data.keyword.cloudant_short_notm}}
que foram criadas anteriormente no tutorial,
chamadas `Cloudant Service 2017`.
    Clique na linha correspondente:<br/>
    ![Selecionando o serviço {{site.data.keyword.cloudant_short_notm}}](images/img0011.png)

3.  A janela Credenciais de serviço aparece.
    Para ver as credenciais necessárias para acessar o serviço,
clique na lista suspensa `View Credentials`:<br/>
    ![Visualizando as credenciais de serviço do {{site.data.keyword.cloudant_short_notm}}](images/img0008.png)

4.  Os detalhes de Credenciais de serviço aparecem:<br/>
    ![As credenciais de serviço do {{site.data.keyword.cloudant_short_notm}}](images/img0009.png)

>   **Nota**: as credenciais de serviço nestes exemplos
    foram definidos quando um serviço de demonstração do {{site.data.keyword.cloudant_short_notm}} foi criado no {{site.data.keyword.cloudant_short_notm}}.
    As credenciais foram reproduzidas aqui para mostrar como apareceriam no painel.
    No entanto, o serviço de demonstração do {{site.data.keyword.cloudant_short_notm}} foi removido; portanto, essas credenciais não são mais válidas; _deve-se_ fornecer e usar as suas próprias credenciais de serviço.
