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
{:tip: .tip}

<!-- Acrolinx: 2018-09-19 -->

# Criando uma instância do  {{site.data.keyword.cloudant_short_notm}}  no  {{site.data.keyword.cloud_notm}}

Este tutorial mostra como criar uma instância de serviço do {{site.data.keyword.cloudantfull}}
usando o painel do {{site.data.keyword.cloud}}
e mostra onde localizar as informações essenciais para permitir que os aplicativos
funcionem com o banco de dados.
{:shortdesc} 

## Criando uma instância de serviço

1.  Efetue login em sua conta do {{site.data.keyword.cloud_notm}}.<br/>
    O painel do {{site.data.keyword.cloud_notm}} pode ser localizado em:
    [http://console.bluemix.net ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://bluemix.net){:new_window}.
    Depois de se autenticar com seu nome de usuário e senha, o painel do {{site.data.keyword.cloud_notm}} será apresentado sem nenhuma instância de serviço:<br/>
    ![Painel do {{site.data.keyword.cloud_notm}}](images/img0001.png)

2.  Clique no botão  ` Criar Recurso ` :<br/>
    ![Link de catálogo do {{site.data.keyword.cloud_notm}}](images/img0002.png)<br/>
    Aparece uma lista dos serviços disponíveis no {{site.data.keyword.cloud_notm}}.

3.  Clique na categoria `Bancos de dados` e selecione o serviço `Cloudant`:<br/>
    ![Serviços de bancos de dados do {{site.data.keyword.cloud_notm}}](images/img0003.png)<br/>

4.  Na janela de configuração de serviço,
insira um nome de serviço. Verifique se o nome do serviço, região/local, grupo de recursos e método de autenticação estão corretos. Os métodos de autenticação que estão disponíveis incluem `Usar apenas o IAM` ou `Usar as credenciais anteriores e o IAM`. Para obter mais informações, consulte  [ métodos de autenticação ](../guides/iam.html#ibm-cloud-identity-and-access-management-iam-){:new_window}. 
    Neste exemplo, o nome do serviço é `Cloudant-o7`:<br/>
    ![Nome do serviço e credenciais do {{site.data.keyword.cloudant_short_notm}}](images/img0005.png)

5.  Por padrão, o serviço é criado usando o plano de precificação 'Lite', que é gratuito, mas é fornecido com uma quantia fixa de capacidade de rendimento provisionada e armazenamento de dados. Se você tiver uma conta paga do {{site.data.keyword.cloud_notm}}, também poderá escolher o plano pago 'Padrão' para poder alternar a capacidade de rendimento provisionada e o uso de dados em escala, conforme necessário. Para obter mais informações sobre planos de precificação, consulte [Planos](../offerings/bluemix.html#plans){:new_window}. Para criar o serviço,
clique no botão `Create`: <br/>
    ![Criar o nome do serviço e as credenciais do {{site.data.keyword.cloudant_short_notm}}](images/img0006.png)

6.  Aparece uma página de serviço
confirmando que seu novo serviço {{site.data.keyword.cloudant_short_notm}} está disponível.
    Para criar as informações de conexão que seu aplicativo precisa para se conectar ao serviço, clique na guia `Credenciais de serviço`:<br/>
    ![Creating the {} service credentials](images/img0007.png)

7.  Crie uma nova credencial de serviço  {{site.data.keyword.cloudant_short_notm}} :
  <br>a. Clique no botão  ` Nova credencial ` .
  <br>![Criar novas credenciais de serviço](images/img0050.png)
  <br>b. Insira um nome para a nova credencial na janela Incluir nova credencial. Consulte imagem.
  <br>c. Aceite a função de Gerenciador.
  <br>d. Crie um novo ID de serviço ou obtenha um gerado automaticamente para você.
  <br>d. (Opcional) Inclua parâmetros de configuração sequenciais. Observe que esse parâmetro não é usado atualmente pelas credenciais de serviço do {{site.data.keyword.cloudant_short_notm}}, portanto, ignore-o.
  <br>e. Clique no botão  ` Incluir ` . </br>
  <br>![Incluir uma nova credencial de serviço](images/img0051.png)
  <br>Sua nova credencial aparecerá após a tabela.</br>
  <br>f. Clique em  ` Visualizar credenciais `  em Ações.
  <br>![Visualizar todas as credenciais de serviço](images/img0052.png)
8.  Os detalhes das credenciais de serviço aparecem:<br/>
    ![As credenciais de serviço do {{site.data.keyword.cloudant_short_notm}}](images/img0009.png)

As credenciais de serviço nesses exemplos foram definidas quando um serviço de demonstração do {{site.data.keyword.cloudant_short_notm}} foi criado no {{site.data.keyword.cloudant_short_notm}}. As credenciais foram reproduzidas aqui para mostrar como apareceriam no painel. No entanto, o serviço de demonstração do {{site.data.keyword.cloudant_short_notm}} foi removido; portanto, essas credenciais não são mais válidas; _deve-se_ fornecer e usar as suas próprias credenciais de serviço.
{: tip}

## As credenciais de serviço

As credenciais de serviço são valiosas. Se qualquer pessoa ou qualquer aplicativo tiver acesso às credenciais, eles poderão efetivamente fazer o que desejarem com a instância de serviço. Por exemplo, eles podem criar dados espúrios ou excluir informações de valor. Proteja essas credenciais cuidadosamente.
    
O {{site.data.keyword.cloudant_short_notm}} possui dois métodos de autenticação disponíveis no tempo de fornecimento, `Usar apenas o IAM` ou `Usar as credenciais anteriores e o IAM`. Será possível ver os detalhes sobre suas credenciais anteriores apenas se o método de autenticação `Usar as credenciais anteriores e o IAM` for escolhido. As credenciais são exibidas na guia Credenciais de serviço de sua instância. Para obter mais informações, consulte o [Guia do IAM](guides/iam.html#ibm-cloud-identity-and-access-management-iam-) e o documento de [autenticação anterior](api/authentication.html#authentication) para obter detalhes sobre como usar o estilo de autenticação.

As credenciais de serviço incluem os campos a seguir:

Campo | Propósito
------|--------
`username` | O nome do serviço do usuário da instância de serviço na URL. Esse campo também serve como o nome de usuário administrativo. 
`password` | A senha de credenciais anteriores que é necessária para que os aplicativos acessem a instância de serviço. Esse campo será exibido apenas se a opção `Usar as credenciais anteriores e o IAM` for escolhida. 
`host` | O nome do host usado por aplicativos para localizar a instância de serviço. Esse campo será exibido apenas se a opção `Usar as credenciais anteriores e o IAM` for escolhida. 
`port` | O número da porta HTTPS para acessar a instância de serviço no host. Ele é 443, pois apenas o acesso HTTPS é permitido pelo {{site.data.keyword.cloudant_short_notm}}. Esse campo será exibido apenas se a opção `Usar as credenciais anteriores e o IAM` for escolhida. 
`url`	| A URL HTTPS para acessar a instância do {{site.data.keyword.cloudant_short_notm}}. Se a opção `Usar as credenciais anteriores e o IAM` for escolhida, ela também incluirá o nome de usuário e a senha anteriores integrados. 
`apikey` | A chave de API do IAM. 
`iam_apikey_description` | Descrição da chave de API do IAM. 
`iam_apikey_name` | ID da chave de API do IAM.
`iam_role_crn` | A função do IAM que a chave de API do IAM possui.
`iam_serviceid_crn`	| O CRN do ID do serviço.

Para criar um aplicativo que possa acessar sua instância de serviço,
você precisará dessas credenciais.

## Localizando suas credenciais de serviço

A qualquer momento,
é possível localizar as credenciais de um serviço que esteja associado à sua conta.

1.  Inicie efetuando login no {{site.data.keyword.cloud_notm}}.
    O painel do {{site.data.keyword.cloud_notm}} pode ser localizado em:
[http://bluemix.net ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://bluemix.net){:new_window}.
    Após a autenticação com seu nome de usuário e senha,
será apresentado o painel do {{site.data.keyword.cloud_notm}}:<br/>
    ![{} dashboard](images/img0053.png)

2.  Neste exemplo, queremos localizar as credenciais de serviço para a instância de serviço do {{site.data.keyword.cloudant_short_notm}} que foi criada anteriormente neste tutorial, chamada `Cloudant-o7`.
    Clique na linha correspondente:<br/>
    ![Selecionando o serviço {{site.data.keyword.cloudant_short_notm}}](images/img0011.png)

3.  Para ver as credenciais que são necessárias para acessar o serviço, clique em `Visualizar credenciais`:<br/>
    ![Viewing the {} service credentials](images/img0052.png)

4.  Os detalhes das credenciais de serviço aparecem:<br/>
    ![As credenciais de serviço do {{site.data.keyword.cloudant_short_notm}}](images/img0009.png)

As credenciais de serviço nesses exemplos foram definidas quando um serviço de demonstração do {{site.data.keyword.cloudant_short_notm}} foi criado no {{site.data.keyword.cloudant_short_notm}}. As credenciais foram reproduzidas aqui para mostrar como apareceriam no painel. No entanto, o serviço de demonstração do {{site.data.keyword.cloudant_short_notm}} foi removido; portanto, essas credenciais não são mais válidas; _deve-se_ fornecer e usar as suas próprias credenciais de serviço.
{: tip}

