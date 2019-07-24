---

copyright:
  years: 2017, 2019
lastupdated: "2019-06-12"

keywords: connect to ibm cloud, upload application, test sample application, confirm database details

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

# Criando um aplicativo {{site.data.keyword.cloud_notm}} para acessar um banco de dados do {{site.data.keyword.cloudant_short_notm}}: fazendo upload do aplicativo
{: #creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-uploading-the-application}

Esta seção do tutorial descreve como fazer upload de um
aplicativo {{site.data.keyword.cloud}}.
{: shortdesc}

## Conectando-se ao {{site.data.keyword.cloud_notm}}
{: #connecting-to-ibm-cloud}

A primeira tarefa é se conectar ao {{site.data.keyword.cloud_notm}}.

A CLI do {{site.data.keyword.cloud_notm}} precisa saber qual URL usar para fazer chamadas de API. Por exemplo, ao fazer upload de um aplicativo, o kit de ferramentas do {{site.data.keyword.cloud_notm}} usa o comando `ibmcloud api` para gerenciar o terminal de API. Para obter mais informações sobre o comando `ibmcloud api`, consulte [Introdução à CLI do {{site.data.keyword.cloud_notm}} ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://cloud.ibm.com/docs/cli?topic=cloud-cli-ibmcloud-cli){: new_window}.

Use o comando a seguir para informar ao Cloud Foundry a URL a ser usada:

```sh
Ibmcloud api https://api.ng.bluemix.net
```
{: pre}

Espere um resultado semelhante à saída a seguir:

```
Invoking 'cf api https://api.ng.bluemix.net'...

Setting api endpoint to https://api.ng.bluemix.net...
OK

API endpoint:   https://api.ng.bluemix.net
API version:    2.54.0
Not logged in. Use 'login ibmcloud' para efetuar login.
```
{: codeblock}

Agora o Cloud Foundry sabe onde enviar chamadas API para gerenciar aplicativos.

A próxima etapa é efetuar login em seu ambiente de aplicativos do {{site.data.keyword.cloud_notm}}.
Deve-se fornecer os detalhes de conta a seguir:

-   Seu nome de usuário, especificado como o parâmetro '`-u`'.
-   O nome de sua organização, especificado como o parâmetro '`-o`'.
-   Seu espaço, especificado como o parâmetro '`-s`'.

  Os detalhes da conta estão disponíveis em seu painel do {{site.data.keyword.cloud_notm}}, quando você efetua login por meio de um navegador da web, conforme mostrado no exemplo a seguir:
  {: tip}

  ![Localizando os detalhes da conta do {{site.data.keyword.cloud_notm}}](images/img0035.png)

Use um comando semelhante ao exemplo a seguir para efetuar login no
ambiente de aplicativos do {{site.data.keyword.cloud_notm}}.
Observe que você é solicitado a inserir a senha de sua conta.

```sh
ibmcloud login -u Adrian.Warman@uk.ibm.com -o Adrian.Warman@uk.ibm.com -s dev
```
{: pre}

Espere um resultado semelhante à saída a seguir:

```
Invoking 'cf login -u Adrian.Warman@uk.ibm.com -o Adrian.Warman@uk.ibm.com -s dev'...

API endpoint: https://api.ng.bluemix.net

Password> 
Authenticating...
OK

Targeted org Adrian.Warman@uk.ibm.com

Targeted space dev
                
API endpoint:   https://api.ng.bluemix.net (API version: 2.54.0)
User:           adrian.warman@uk.ibm.com
Org:            Adrian.Warman@uk.ibm.com
Space:          dev
```
{: codeblock}

## Fazendo upload do aplicativo
{: #uploading-the-application}

O kit de ferramentas do {{site.data.keyword.cloudant_short_notm}} Foundry agora sabe como se conectar ao ambiente {{site.data.keyword.cloud_notm}}.

A próxima etapa é fazer upload do próprio aplicativo.
Detalhes de um aplicativo {{site.data.keyword.cloud_notm}}
são fornecidos no [arquivo manifest](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#the-manifest.yml-file).

Use um comando semelhante ao exemplo a seguir para efetuar login para fazer upload do
aplicativo {{site.data.keyword.cloud_notm}}.

```sh
cf push "Cloudant Python"
```
{: pre}

Uma sequência de mensagens de resultado é exibida.

```
Using manifest file /..../BMXDemo/manifest.yml

Updating app {{site.data.keyword.cloudant_short_notm}} Python in org Adrian.Warman@uk.ibm.com / space dev as Adrian.Warman@uk.ibm.com...
OK
```
{: codeblock}

O kit de ferramentas do Cloud Foundry localizou o arquivo manifest
e está se preparando para fazer upload do aplicativo usando os detalhes de
conexão e identificação fornecidos [anteriormente](#uploading-the-application).

```
Using route Cloudant-Python.mybluemix.net
Uploading Cloudant Python...
Uploading app files from: /..../BMXDemo
Uploading 1.5K, 3 files
Done uploading               
OK
Binding service {{site.data.keyword.cloudant_short_notm}} Service 2017 to app {{site.data.keyword.cloudant_short_notm}} Python in org Adrian.Warman@uk.ibm.com / space dev as Adrian.Warman@uk.ibm.com...
OK
```
{: codeblock}

O aplicativo foi transferido por upload com sucesso
e uma conexão feita com a instância de banco de dados do {{site.data.keyword.cloudant_short_notm}}.

```
Starting app {{site.data.keyword.cloudant_short_notm}} Python in org Adrian.Warman@uk.ibm.com / space dev as Adrian.Warman@uk.ibm.com...
-----> Downloaded app package (4.0K)
-----> Downloaded app buildpack cache (29M)
-------> Buildpack version 1.5.5
     $ pip install -r requirements.txt
DEPRECATION: --allow-all-external has been deprecated and will be removed in the future. Due to changes in the repository protocol, it no longer has any effect.
       Collecting cloudant==2.3.1 (from -r requirements.txt (line 1))
         Downloading cloudant-2.3.1-py2-none-any.whl (63kB)
       Collecting requests<3.0.0,>=2.7.0 (from cloudant==2.3.1->-r requirements.txt (line 1))
         Downloading requests-2.12.4-py2.py3-none-any.whl (576kB)
       Installing collected packages: requests, cloudant
       Successfully installed cloudant-2.3.1 requests-2.12.4
You are using pip version 8.1.1, however version 9.0.1 is available.
You should consider upgrading via the 'pip install --upgrade pip' command.
You are using pip version 8.1.1, however version 9.0.1 is available.
You should consider upgrading via the 'pip install --upgrade pip' command.
-----> Uploading droplet (30M)

0 of 1 instances running, 1 starting
1 of 1 instances running

App started


OK

App {{site.data.keyword.cloudant_short_notm}} Python was started using this command `python server.py`
```
{: codeblock}

O aplicativo é iniciado automaticamente.
Como parte da inicialização,
é feita uma verificação para assegurar que todos os requisitos sejam atendidos,
avaliando o conteúdo do [arquivo requirements.txt](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#the-requirements.txt-file).

Depois que você faz upload e inicia o aplicativo,
algumas verificações simples do sistema são executadas para confirmar que o aplicativo está sendo executado corretamente,
no que diz respeito ao {{site.data.keyword.cloud_notm}}.

```
Showing health and status for app {{site.data.keyword.cloudant_short_notm}} Python in org Adrian.Warman@uk.ibm.com / space dev as Adrian.Warman@uk.ibm.com...
OK

requested state: started
instances: 1/1
usage: 128M x 1 instances
urls: Cloudant-Python.mybluemix.net
last uploaded: Thu Dec 22 15:58:18 UTC 2016
stack: cflinuxfs2
buildpack: python 1.5.5

     state     since                    cpu    memory          disk           details
#0   running   2016-12-22 03:59:21 PM   0.0%   49.9M of 128M   110.6M of 1G
```
{: codeblock}

## Testando o aplicativo de amostra
{: #testing-the-sample-application}

Agora, teste seu aplicativo e verifique se ele está sendo executado corretamente. 

1.  No painel do {{site.data.keyword.cloud_notm}}, acesse o ícone de **Menu** > **Lista de recursos**e abra seu aplicativo. Em Cloud Foundry Apps, clique em `app Cloudant CF`para abrir a página de detalhes.<br/>  
![Captura de tela mostrando o painel do aplicativo](images/img0017.png)

2.  Na página de detalhes do `aplicativo de CF Cloudant`, clique em `Rotas`e clique no link `Cloudant-CF-app.mybluemix.net`. <br/>
![Cloudant CF app details page](images/img0030.png)

3. Uma nova janela do navegador é aberta em `https://cloudant-cf-app.mybluemix.net/`. A mensagem verifica se o aplicativo está sendo executado, exibindo a mensagem, ' Hello World! Obrigado pela criação de um Aplicativo Starter da Python.'<br/>
![Hello World! verificou se o aplicativo Cloudant CF executa corretamente](images/img0054.png)


### Confirmando os detalhes do banco de dados
{: #confirming-the-database-details}

No painel do {{site.data.keyword.cloud_notm}}, acesse o ícone de **Menu** > **Lista de recursos**e abra a sua instância de serviço. Acesse a guia `Gerenciar`e clique em `Ativar Cloudant Dashboard`.<br/>
![Launch Cloudant dashboard on the {{site.data.keyword.cloudant_short_notm}} service page](images/img0036.png)

Para localizar sua página de serviço do {{site.data.keyword.cloudant_short_notm}},
consulte os detalhes no tutorial [Criando uma instância do {{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#locating-your-service-credentials).
{: note}

Quando o painel for aberto,
você pode ver que o aplicativo
criou o banco de dados '`databasedemo`':<br/>
![The {{site.data.keyword.cloudant_short_notm}} Dashboard showing the new database](images/img0031.png)

O banco de dados contém um único documento,
criado pelo aplicativo.
Para verificar a presença do documento,
clique no nome do banco de dados dentro do painel.
Aparece uma lista de opções para o banco de dados.
Quando você seleciona a guia `Todos os documentos`,
os detalhes de um único documento aparecem:<br/>
![A single document within the new database](images/img0032.png)

Para ver o conteúdo do documento,
clique no ícone `Editar`,
que aparece como uma imagem de um lápis:<br/>
![Details of the document](images/img0033.png)

Quando o conteúdo do documento aparecer,
é possível ver cada um dos campos que foram criados pelo aplicativo do tutorial.<br/>
![The fields within the document](images/img0034.png)<br/>
Em especial,
o campo `rightNow`possui a data e a hora em que o documento foi criado.
Esse valor corresponde ao tempo que foi registrado no
[arquivo de log do aplicativo](#testing-the-sample-application).

A próxima etapa no tutorial é [operar e manter o aplicativo](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting),
por exemplo, quando você iniciar,
parar
e depurar o aplicativo.
