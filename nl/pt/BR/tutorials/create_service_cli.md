---

copyright:
  years: 2017, 2018
lastupdated: "2018-03-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# Criando uma instância do {{site.data.keyword.cloudant_short_notm}} no {{site.data.keyword.Bluemix_notm}} usando as ferramentas do Cloud Foundry

Esse tutorial mostra como criar uma instância de serviço do
{{site.data.keyword.cloudantfull}} no {{site.data.keyword.Bluemix}}
usando as ferramentas do Cloud Foundry.
{:shortdesc}

## Pré-requisitos

Para seguir este tutorial,
deve-se primeiro instalar as ferramentas do Cloud Foundry do {{site.data.keyword.Bluemix_notm}}.
Detalhes para instalar as ferramentas estão disponíveis
[neste tutorial separado](create_bmxapp_appenv.html#the-cloud-foundry-and-bluemix-command-toolkits).

> **Nota**: assegure-se de instalar os kits de ferramentas do Cloud Foundry _e_
do {{site.data.keyword.Bluemix_notm}}.

## Identificando o terminal de API do {{site.data.keyword.Bluemix_notm}}

Especifique o terminal de API de destino para comandos do Cloud Foundry;

```sh
bx api https://api.ng.bluemix.net
```
{:codeblock}

O resultado confirma que você identificou corretamente o terminal:

```sh
Setting api endpoint to https://api.ng.bluemix.net...
OK

API endpoint:   https://api.ng.bluemix.net (API version: 2.54.0)
Not logged in. Use 'bx login' to log in.
```
{:pre}

## Efetuando login em sua conta do {{site.data.keyword.Bluemix_notm}}

1.  Use o comando a seguir para iniciar o processo de login
de sua conta do {{site.data.keyword.Bluemix_notm}}:
  
  ```sh
  bx login
  ```
  {:codeblock}
  
  O {{site.data.keyword.Bluemix_notm}} responde lembrando a você do terminal
de API atual
e, em seguida, solicita o endereço de e-mail de sua conta:
  
  ```sh
  API endpoint: https://api.ng.bluemix.net
  
  Email>
  ```
  {:pre}

2.  Insira o endereço de e-mail de sua conta.
  O {{site.data.keyword.Bluemix_notm}} então solicita a senha de sua conta:
  ```sh
  API endpoint: https://api.ng.bluemix.net
  
  Email> J.Doe@email.com
  
  Password>
  ```
  {:pre}
  
  O {{site.data.keyword.Bluemix_notm}} valida os detalhes
e, em seguida, resume as informações sobre sua sessão de login:
  ```sh
  API endpoint: https://api.ng.bluemix.net
  
  Email> J.Doe@email.com
  
  Password> 
  Authenticating...
  OK
  
  Targeted account J DOE's Account (707...a32)
  
  Targeted org J.Doe@email.com
  
  Targeted space dev
  
  API endpoint:   https://api.ng.bluemix.net (API version: 2.54.0)
  Region:         us-south
  User:           j.doe@email.com
  Account:        J DOE's Account (707...a32)
  Org:            J.Doe@email.com
  Space:          dev
  ```
  {:pre}

3.  Agora você efetuou login em sua conta do {{site.data.keyword.Bluemix_notm}}.

## Escolhendo o plano do {{site.data.keyword.cloudant_short_notm}} para seu serviço

Obtenha uma lista de todas as ofertas de serviços disponíveis.
Filtre a lista para que corresponda apenas aos serviços do {{site.data.keyword.cloudant_short_notm}}:

```sh
bx service offerings | grep -i Cloudant
```
{:codeblock}

O resultado é uma lista dos serviços do {{site.data.keyword.cloudant_short_notm}}
disponíveis para sua conta,
incluindo os planos específicos que você pode selecionar:

```sh
cloudantNoSQLDB   Lite, Standard*
```
{:pre}

**Opcional**: para ver mais detalhes sobre os planos,
use o comando a seguir:

```sh
bx cf marketplace -s cloudantNoSQLDB
```
{:codeblock}

O resultado é um resumo dos planos disponíveis,
semelhante à seção a seguir de uma resposta de exemplo (detalhes corretos como em maio de 2017):

```
Lite
O plano Lite fornece acesso à funcionalidade integral do {{site.data.keyword.cloudant_short_notm}} para desenvolvimento e avaliação.
The plan has a set amount of provisioned throughput capacity as shown
and includes a max of 1GB of encrypted data storage.   free
```
{:pre}

## Criando o serviço {{site.data.keyword.cloudant_short_notm}}

O formato básico do comando para criar uma instância de serviço
no {{site.data.keyword.Bluemix_notm}} é como a seguir:

```sh
bx service create <service> <plan> <instance name>
```
{:pre}

Suponha que queiramos criar uma instância de
um serviço do {{site.data.keyword.cloudant_short_notm}} usando o plano `Lite`,
em que o nome da instância é `cs20170517a`.

Faça isso usando um comando semelhante ao exemplo a seguir:

```sh
bx service create cloudantNoSQLDB Lite cs20170517a
```
{:codeblock}

Depois de criar a instância de serviço,
responderá com uma mensagem semelhante ao exemplo a seguir:

```sh
Invoking 'cf create-service cloudantNoSQLDB Lite cs20170517a'...

Creating service instance cs20170517a in org J.Doe@email.com / space dev as J.Doe@email.com...
OK

```
{:pre}

## Criando credenciais para seu serviço {{site.data.keyword.cloudant_short_notm}}

Os aplicativos que requerem acesso ao serviço do {{site.data.keyword.cloudant_short_notm}}
devem ter as credenciais necessárias.

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

O formato básico do comando para criar credenciais para uma instância de serviço
no {{site.data.keyword.Bluemix_notm}} é como a seguir:

```sh
bx cf create-service-key <instance name> <credentials name>
```
{:pre}

Suponha que queiramos criar credenciais para a instância `cs20170517a` de
um serviço do {{site.data.keyword.cloudant_short_notm}},
em que o nome das credenciais é `creds20170517a`.

Faça isso usando um comando semelhante ao exemplo a seguir:

```sh
bx cf create-service-key cs20170517a creds20170517a
```
{:codeblock}

Depois de receber a solicitação para criar credenciais para a instância de serviço,
o {{site.data.keyword.Bluemix_notm}} responderá com uma mensagem semelhante ao exemplo a seguir:

```sh
Invoking 'cf create-service-key cs20170517a creds20170517a'...

Creating service key creds20170517a for service instance cs20170517a as J.Doe@email.com...
OK
```
{:pre}

## Listando as credenciais de serviço para seu serviço {{site.data.keyword.cloudant_short_notm}}

O formato básico do comando para recuperar as credenciais para uma instância de serviço
no {{site.data.keyword.Bluemix_notm}} é como a seguir:

```sh
bx cf service-key <instance name> <credentials name>
```
{:pre}

Suponha que queiramos recuperar credenciais para a instância `cs20170517a` de
um serviço do {{site.data.keyword.cloudant_short_notm}},
em que o nome das credenciais é `creds20170517a`.

Faça isso usando um comando semelhante ao exemplo a seguir:

```sh
bx cf service-key cs20170517a creds20170517a
```
{:codeblock}

Depois de receber a solicitação para recuperar as credenciais da instância de serviço,
o {{site.data.keyword.Bluemix_notm}} responderá com uma mensagem semelhante ao exemplo (abreviado) a seguir:

```sh
Invoking 'cf service-key cs20170517a creds20170517a'...

Getting key creds20170517a for service instance cs20170517a as J.Doe@email.com...

{
 "host": "946...46f-bluemix.cloudant.com",
 "password": "4eb...eb5",
 "port": 443,
 "url": "https://946...46f-bluemix:4eb...eb5@946...46f-bluemix.cloudant.com",
 "username": "946...46f-bluemix"
}
```
{:pre}

## Usando sua instância de serviço do {{site.data.keyword.cloudant_short_notm}}

Neste ponto,
você terá:

1.  Criado uma instância de serviço do {{site.data.keyword.cloudant_short_notm}}
no {{site.data.keyword.Bluemix_notm}}.
2.  Criado credenciais para a instância de serviço do {{site.data.keyword.cloudant_short_notm}}.
3.  Recuperado as credenciais da instância de serviço, para que elas possam ser usadas por seu aplicativo.

Um tutorial mostrando como usar uma instância de serviço do {{site.data.keyword.cloudant_short_notm}}
está disponível [aqui](create_database.html#context).
Lembre-se de substituir as credenciais criadas neste tutorial.

## (Opcional) Organizando em seguida

A lista pequena de comandos a seguir pode ser útil na organização de seu ambiente de desenvolvimento.

### Excluindo credenciais de serviço

Para excluir um conjunto de credenciais de serviço,
use um comando semelhante ao seguinte:

```sh
bx cf delete-service-key <instance name> <credentials name>
```
{:pre}

Por exemplo,
para excluir as credenciais chamadas `creds20170517a`
da instância `cs20170517a` de
um serviço do {{site.data.keyword.cloudant_short_notm}},
você poderia usar um comando como este:

```sh
bx cf delete-service-key cs20170517a creds20170517a
```
{:pre}

### Excluindo uma instância de serviço

Para excluir uma instância de serviço,
use um comando semelhante ao seguinte:

```sh
bx service delete <instance name>
```
{:pre}

Por exemplo,
para excluir a instância `cs20170517a` de
um serviço do {{site.data.keyword.cloudant_short_notm}},
você poderia usar um comando como este:

```sh
bx service delete cs20170517a
```
{:pre}

