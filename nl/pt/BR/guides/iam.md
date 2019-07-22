---

copyright:
  years: 2017, 2019
lastupdated: "2019-06-12"

keywords: legacy access controls, api keys, enable iam, provisioning, how to choose between iam and legacy credentials, making requests, required client libraries, actions, endpoints, map actions to iam roles

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

<!-- Acrolinx: 2018-07-02 -->

# {{site.data.keyword.cloud_notm}}  Gerenciamento de Identidade e Acesso (IAM)
{: #ibm-cloud-identity-and-access-management-iam-}

O {{site.data.keyword.cloud}} Identity and Access Management fornece uma abordagem unificada para gerenciar identidades do usuário, serviços e controle de acesso.
{: shortdesc}

## Introdução
{: #introduction}

Este documento descreve a integração do {{site.data.keyword.cloudantfull}} ao {{site.data.keyword.cloud_notm}} Identity and Access Management. Ele discute as diferenças entre os controles de acesso do {{site.data.keyword.cloudant_short_notm}} Legacy e os controles de acesso do {{site.data.keyword.cloud_notm}} IAM. Em seguida, analisa as vantagens e desvantagens de cada um para ajudá-lo a decidir qual usar. Depois, discutiremos como usar o IAM dentro das bibliotecas do cliente do {{site.data.keyword.cloudant_short_notm}} e por meio de chamadas HTTP. Finalmente, terminaremos com uma seção de referência que descreve todas as ações e funções do IAM disponíveis no {{site.data.keyword.cloudant_short_notm}}.

Consulte uma visão geral do IAM do [ ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://cloud.ibm.com/docs/iam/index.html#iamoverview){: new_window}, incluindo como:

- Gerenciar IDs do usuário e de serviço.
- Gerenciar credenciais disponíveis.
- Usar as políticas de acesso do IAM que permitem e revogam o acesso às instâncias de serviço do {{site.data.keyword.cloudant_short_notm}}.

## Diferenças entre os controles de acesso do {{site.data.keyword.cloudant_short_notm}} Legacy e do IAM
{: #differences-between-ibm-cloudant-legacy-and-iam-access-controls}

A seção a seguir fornece uma breve visão geral das diferenças entre os mecanismos de controle de acesso do {{site.data.keyword.cloudant_short_notm}} Legacy e do {{site.data.keyword.cloud_notm}} IAM.

### {{site.data.keyword.cloud_notm}}  Gerenciamento de Identidade e Acesso
{: #ibm-cloud-identity-and-access-management}

- Gerenciamento de acesso gerenciado centralmente em  {{site.data.keyword.cloud_notm}}.
- Permitir que um usuário ou serviço acesse vários recursos diferentes usando o mesmo conjunto de credenciais (por exemplo, o mesmo nome de usuário/senha ou chave de API do IAM).
- As chaves da API do IAM podem ter acesso concedido a funções de gerenciamento de contas, como criar novos bancos de dados.

### {{site.data.keyword.cloudant_short_notm}}  Legado
{: #ibm-cloudant-legacy}

- Exclusivo para  {{site.data.keyword.cloudant_short_notm}}.
- O acesso a cada instância de serviço requer seu próprio conjunto de credenciais.
- Usa a autenticação básica HTTP com credenciais que não estão ligadas a um usuário ou serviço individual.
- {{site.data.keyword.cloudant_short_notm}} As chaves API podem receber permissões apenas em um nível de banco de dados.

### Notas chave da API
{: #api-key-notes}

Neste documento, sempre que as chaves API forem mencionadas, elas se referirão às chaves da API do IAM.
O {{site.data.keyword.cloudant_short_notm}} Legacy também tem um conceito de chaves de API e qualquer discussão sobre combinações de credenciais ou nome de usuário/senha do {{site.data.keyword.cloudant_short_notm}}
Legacy também inclui as chaves de API do {{site.data.keyword.cloudant_short_notm}}. 

## Ativando o IAM com  {{site.data.keyword.cloudant_short_notm}}
{: #enabling-iam-with-ibm-cloudant}

Somente novas instâncias de serviço do {{site.data.keyword.cloudant_short_notm}} podem ser usadas com o {{site.data.keyword.cloud_notm}} IAM a partir do final de julho de 2018.

Todas as novas instâncias de serviço do {{site.data.keyword.cloudant_short_notm}} estão ativadas para usar o IAM quando provisionado. Opcionalmente, também é possível ativar o mecanismo de autenticação anterior.  Quando você provisionar uma nova instância do {{site.data.keyword.cloudant_short_notm}} do catálogo do {{site.data.keyword.cloud_notm}}, escolha dentre os métodos de autenticação disponíveis:

1. **Use as credenciais anteriores e o IAM**: esse modo significa que as credenciais do IAM e do Legacy podem ser usadas para acessar a conta. Em particular, os conjuntos de credenciais do IAM e do Legacy são fornecidos para todos os aplicativos ligados às credenciais de conta e de serviço geradas.
2. **Usar apenas o IAM**: este modo significa que apenas as credenciais do IAM são fornecidas por meio da ligação de serviço e geração de credencial.

### {{site.data.keyword.cloudant_short_notm}}  Chaves de API e  _ Usar apenas IAM _
{: #ibm-cloudant-api-keys-and-_use-only-iam_}

O uso de chaves API do {{site.data.keyword.cloudant_short_notm}} com o IAM é possível, mas **não recomendado**. Essa recomendação é feita porque as permissões e as chaves API do {{site.data.keyword.cloudant_short_notm}} não são visíveis ou gerenciáveis por meio da interface de política do IAM, tornando impossível o gerenciamento de acesso holístico.

A opção entre _Usar apenas o IAM_ ou _Usar as credenciais anteriores e o IAM_ afeta:

1. Se as credenciais de nível de conta anteriores do {{site.data.keyword.cloudant_short_notm}} estão disponíveis para gerenciar bancos de dados e outras ações no nível da conta.
2. O estilo de credenciais que são entregues durante a geração de credencial de serviço.

Em particular, as chaves API {{site.data.keyword.cloudant_short_notm}} ainda podem ser usadas para gerenciar o acesso ao banco de dados. Essas credenciais devem ser geradas e configuradas usando a API HTTP.

### Fornecendo Usando a Linha de Comandos
{: #provisioning-by-using-the-command-line}

Ao provisionar uma nova instância do {{site.data.keyword.cloudant_short_notm}} por meio da linha de comandos, forneça uma opção para a ferramenta `ic` usando o parâmetro `-p` para ativar ou desativar as credenciais anteriores para uma conta. A opção é transmitida no formato JSON e é chamada de `legacyCredentials`.

Para fornecer uma instância como _Usar apenas o IAM_ (recomendado), execute o comando a seguir:

```sh
ic resource service-instance-create  "Instance Name" \
    cloudantnosqldb Standard us-south \
    -p {"legacyCredentials": false}
```

Para provisionar uma instância como _Usar as credenciais anteriores e o IAM_, execute o comando a seguir:

```sh
ic resource service-instance-create  "Instance Name" \
    cloudantnosqldb Standard us-south \
    -p {"legacyCredentials": true}
```

### Exemplos de JSON da credencial de serviço para cada opção
{: #service-credential-json-examples-for-each-option}

A opção entre o controle de acesso _Usar apenas o IAM_ e _Usar as credenciais anteriores e o IAM_ afeta como as credenciais serão entregues ao seu aplicativo ao ligar e gerar credenciais de serviço. Ao gerar credenciais dentro da interface primária do {{site.data.keyword.cloud_notm}} IAM, as chaves API são mostradas nessa interface quando são geradas.

Também é possível gerar credenciais pela seção Credenciais de serviço de uma instância de serviço. Gerar credenciais de serviço dessa maneira cria uma blob JSON de credenciais de serviço que pode ser colado em aplicativos com todos os detalhes que são necessários para acessar a instância de serviço.

Esta seção mostra o que a credencial de serviço JSON se parece e o que cada valor significa.

Quando você seleciona _Usar apenas o IAM_, as credenciais de serviço que são geradas contêm somente valores do IAM e se parecem com o exemplo a seguir:

```json
{
  "apikey": "MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz",
  "iam_apikey_description": "Auto generated apikey during resource-key [...]", "iam_apikey_name": "auto-generated-apikey-050d21b5-5f [ ... ]", "iam_role_crn": "crn:v1:bluemix:public:iam::::serviceRole:Manager", "iam_serviceid_crn": "crn:v1:staging:public:iam-identity::[...]",
  "url": "https://76838001-b883-444d-90d0-46f89e942a15-bluemix.cloudant.com",
  "username": "76838001-b883-444d-90d0-46f89e942a15-bluemix"
}
```

Cada valor no exemplo de JSON prévio deve ser interpretado da seguinte forma:

- ` apikey `: chave da API do IAM.
- ` iam_apikey_description `: Descrição da chave de API do IAM.
- ` iam_apikey_name `: ID da chave de API do IAM.
- `iam_role_crn`: a função do IAM que a chave de API do IAM tem.
- ` iam_serviceid_crn `: O CRN do ID do serviço.
- ` url `:  {{site.data.keyword.cloudant_short_notm}}  URL de serviço.
- `username`: o nome interno da conta do {{site.data.keyword.cloudant_short_notm}}.

Quando você seleciona _Usar as credenciais anteriores e o IAM_, as credenciais de serviço que são geradas contêm as credenciais do IAM e do Legacy e se parecem com o exemplo a seguir:

```json
{
  "apikey": "MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz",
  "host": "76838001-b883-444d-90d0-46f89e942a15-bluemix.cloudant.com",
  "iam_apikey_description": "Auto generated apikey during resource-key [...]", "iam_apikey_name": "auto-generated-apikey-050d21b5-5f [ ... ]", "iam_role_crn": "crn:v1:bluemix:public:iam::::serviceRole:Manager", "iam_serviceid_crn": "crn:v1:staging:public:iam-identity::[...]",
  "password": "8fb6a16b48903e87b769e7f4968521e85c2394ed8f0e69b2769e56dcb27d2e76",
  "port": 443,
  "url": "https://<username>:<password>@76838001-b883-444d-90d0-46f89e942a15-bluemix.cloudant.com",
  "username": "76838001-b883-444d-90d0-46f89e942a15-bluemix"
}
```
{: codeblock}

Cada valor no exemplo de JSON prévio deve ser interpretado da seguinte forma:

- ` apikey `: chave da API do IAM.
- ` host `:  {{site.data.keyword.cloudant_short_notm}}  nome do host de serviço.
- ` iam_apikey_description `: Descrição da chave de API do IAM.
- ` iam_apikey_name `: ID da chave de API do IAM.
- `iam_role_crn`: a função do IAM que a chave de API do IAM tem.
- ` iam_serviceid_crn `: O CRN do ID do serviço.
- ` password `: A  {{site.data.keyword.cloudant_short_notm}}  Senha da credencial de Legado.
- ` port `:  {{site.data.keyword.cloudant_short_notm}}  porta de serviço.
- `url`: URL de serviço {{site.data.keyword.cloudant_short_notm}}, incluindo as credenciais do {{site.data.keyword.cloudant_short_notm}} Legacy integradas.
- ` username `: O nome do usuário da credencial  {{site.data.keyword.cloudant_short_notm}}  Legacy.

## Devo usar _Usar apenas o IAM_ ou _Usar as credenciais anteriores e o IAM_?
{: #should-i-use-_use-only-iam_-or-_use-both-legacy-credentials-and-iam_-}

Se possível, _Usar apenas o IAM_ é preferencial. As principais vantagens de uso do {{site.data.keyword.cloud_notm}} IAM incluem:

- Gerenciamento de acesso ao {{site.data.keyword.cloudant_short_notm}} com o conjunto de ferramentas padrão do {{site.data.keyword.cloud_notm}} em vez de uma combinação de gerenciamento de credenciais específico do {{site.data.keyword.cloud_notm}} e do  {{site.data.keyword.cloudant_short_notm}}.
- As credenciais podem ser facilmente revogadas e giradas quando você usa o {{site.data.keyword.cloud_notm}} IAM.

A seguir, uma descrição mais aprofundada das vantagens e desvantagens de cada abordagem.

### Vantagens e desvantagens dos dois mecanismos de controle de acesso
{: #advantages-and-disadvantages-of-the-two-access-control-mechanisms}

Em geral, o {{site.data.keyword.cloud_notm}} IAM é o modelo de autenticação recomendado. No entanto, há desvantagens para a abordagem, principalmente se você tem um aplicativo existente ou não pode usar uma biblioteca de cliente suportada pelo {{site.data.keyword.cloudant_short_notm}}.

<table>
<caption style="caption-side:top">Tabela 1. Vantagens e desvantagens dos dois mecanismos de controle de acesso</caption>
<thead>
<tr>
<th id="mode">Modo</th>
<th id="advantages">Vantagens</th>
<th id="disadvantages">Desvantagens</th>
</tr>
</thead>
<tr>
<td headers="mode">IAM</td>
<td headers="advantages" valign="top"><ul><li>Gerenciar o acesso para muitos serviços usando uma interface. Revogar acesso a um usuário globalmente.</li>
<li>Chaves de API no nível da conta por meio de IDs de serviço</li>
<li>Credenciais fáceis de girar.</li>
<li>Os logs do Activity Tracker capturam humanos e serviços.</li>
<li>O IAM é federado com outros sistemas de identidade, como repositórios LDAP corporativos.</li></ul>
</td>
<td headers="disadvantages"><ul><li>Se você não estiver usando as bibliotecas suportadas do {{site.data.keyword.cloudant_short_notm}}, as mudanças do aplicativo provavelmente serão necessárias para usar as chaves API e os tokens de acesso do IAM.</li>
<li>Nenhuma permissão de nível do banco de dados (ainda).</li>
<li>Alguns terminais estão indisponíveis, consulte [Terminais indisponíveis](#unavailable-endpoints).</li>
<li>Não há como especificar um banco de dados como "público", ou seja, que não requer que um usuário seja autorizado para acessá-lo.</li></ul>
</td>
</tr>

<tr>
<td headers="mode">Legado</td>
<td headers="advantages">
<ul><li>Nenhuma necessidade de mudar os aplicativos existentes ou as dependências da biblioteca do cliente.</li>
<li>Permissões no nível do banco de dados</li>
</ul>
</td>
<td headers="disadvantages">
<ul><li>Nenhuma chave de API no nível da conta. Deve-se usar credenciais `root` para gerenciar bancos de dados.</li>
<li>Gerenciamento separado de credenciais do {{site.data.keyword.cloudant_short_notm}}, portanto, incapaz de obter uma visão geral completa de todo o acesso dentro da interface centralizada.</li>
<li>É difícil implementar a rotação de credencial.</li>
</ul>
</td>
</tr>
</table>

## Fazendo solicitações para instâncias usando credenciais do IAM
{: #making-requests-to-instances-by-using-iam-credentials}

Esta seção discute como usar o {{site.data.keyword.cloudant_short_notm}} com instâncias de serviço usando a autenticação do IAM e o controle de acesso. Ela usa os detalhes do exemplo JSON de Credenciais de serviço anteriormente mencionado.

O {{site.data.keyword.cloud_notm}} IAM requer que uma chave de API do IAM seja trocada por um token de acesso com limite de tempo antes que você faça uma solicitação para um recurso ou um serviço. O token de acesso é, então, incluído no cabeçalho de HTTP `Authorization` para o serviço. Quando o token de acesso expira, o aplicativo de consumo deve manipular a obtenção de um novo por meio do serviço de token do IAM. Para obter mais informações, consulte [Obtendo um token do {{site.data.keyword.cloud_notm}} IAM usando uma documentação de chave de API ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://cloud.ibm.com/docs/iam/apikey_iamtoken.html#iamtoken_from_apikey) para obter mais detalhes.

As bibliotecas de clientes oficiais do {{site.data.keyword.cloudant_short_notm}} tratam de obter um token de uma chave de API para você. Se você acessar o {{site.data.keyword.cloudant_short_notm}} diretamente usando um cliente HTTP em vez de uma biblioteca do cliente {{site.data.keyword.cloudant_short_notm}}, a troca e a atualização de um token de acesso com limite de tempo deverão ser manipuladas usando uma chave de API do IAM com o serviço de token do IAM. Depois que um token expirar, o {{site.data.keyword.cloudant_short_notm}} retorna um código de status HTTP `401`.

### Versões necessárias da biblioteca do cliente
{: #required-client-library-versions}

Use no mínimo as versões de biblioteca do cliente a seguir com instâncias de serviço do {{site.data.keyword.cloudant_short_notm}} ativadas para o IAM:

<table>
<caption style="caption-side:top">Tabela 2. Versão da biblioteca do cliente recomendada</caption>
<thead>
<tr>
<th id="library">Biblioteca</th>
<th id="recommended">Recomendado</th>
</tr>
</thead>
<tr>
<td headers="library"><a href="https://github.com/cloudant/java-cloudant" target="_blank">java-cloudant <img src="../images/launch-glyph.svg" alt="Ícone de link externo" title="Ícone de link externo"></a></td>
<td headers="recommended">2.13.0+</td>
</tr>

<tr>
<td headers="library"><a href="https://github.com/cloudant/nodejs-cloudant" target="_blank">nodejs-cloudant <img src="../images/launch-glyph.svg" alt="Ícone de link externo" title="Ícone de link externo"></a></td>
<td headers="recommended">2.3.0+</td>
</tr>

<tr>
<td headers="library"><a href="https://github.com/cloudant/python-cloudant" target="_blank">python-cloudant <img src="../images/launch-glyph.svg" alt="Ícone de link externo" title="Ícone de link externo"></a></td>
<td headers="recommended">2.9.0+</td>
</tr>

<tr>
<td headers="library"><a href="https://github.com/cloudant/couchbackup/" target="_blank">couchbackup <img src="../images/launch-glyph.svg" alt="Ícone de link externo" title="Ícone de link externo"></a></td>
<td headers="recommended">2.3.1+</td>
</tr>

<tr>
<td headers="library"><a href="https://github.com/cloudant/cdtdatastore/" target="_blank">CDTDatastore <img src="../images/launch-glyph.svg" alt="Ícone de link externo" title="Ícone de link externo"></a></td>
<td headers="recommended">2.0.3+</td>
</tr>

<tr>
<td headers="library"><a href="https://github.com/cloudant/sync-android/" target="_blank">sync-android <img src="../images/launch-glyph.svg" alt="Ícone de link externo" title="Ícone de link externo"></a></td>
<td headers="recommended">2.2.0+</td>
</tr>
</table>

Os fragmentos de código a seguir requerem essas versões.

### Componente
{: #java-iam}

Requer [java-cloudant ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/cloudant/java-cloudant){: new_window}, 2.13.0+.

Use o método `iamApiKey()` para criar um cliente de banco de dados com uma chave de API do IAM:

```java
pacote com.mycompany.app;

import com.cloudant.client.api.ClientBuilder; import com.cloudant.client.api.CloudantClient;


aplicativo de classe pública {
    public static void main( String[] args )
    {
        CloudantClient client = ClientBuilder
                .account("76838001-b883-444d-90d0-46f89e942a15-bluemix")
                .iamApiKey ("MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz ")
                .build ();

        para (String db: client.getAllDbs ()) {
            System.out.println(db);
        }
    }
}
```

### Node.js
{: #node.js}

Requer [nodejs-cloudant ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/cloudant/nodejs-cloudant){: new_window}, 2.3.0+.

Use o plug-in `iamauth` para criar um cliente de banco de dados com uma chave de API do IAM:

```js
var Cloudant = require ('@cloudant/cloudant');

var cloudant = new Cloudant({
  account: '76838001-b883-444d-90d0-46f89e942a15-bluemix',
  plugins: {
    iamauth: {
      iamApiKey: 'MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz'
    }
  }
}); cloudant.db.list (função (err, corpo) {); cloudant.db.list (função (err, corpo) {
  body.forEach (function (db) {
    console.log (db); }); });
```

### Python
{: #python}

Requer [python-cloudant ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://github.com/cloudant/python-cloudant){: new_window}, 2.9.0+.

Use o método `Cloudant.iam(account_name, api_key, **kwargs)` para criar um cliente de banco de dados com uma chave de API do IAM:

```python
do cloudant.client import Cloudant

client = Cloudant.iam(
    "76838001-b883-444d-90d0-46f89e942a15-bluemix",
    "MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz",
    connect=True
)
imprimir client.all_dbs ()
```

### Acesso usando o cliente HTTP
{: #access-by-using-http-client}

O {{site.data.keyword.cloud_notm}} IAM requer que uma chave de API do IAM seja trocada por um token de acesso com limite de tempo antes que você faça uma solicitação para um recurso ou um serviço. O token de acesso é, então, incluído no cabeçalho de HTTP `Authorization` para o serviço. Quando o token de acesso expirar, o cliente deverá obter um novo por meio do serviço de token do IAM.

Conforme indicado anteriormente, o uso do {{site.data.keyword.cloud_notm}} IAM requer que você primeiro troque uma chave de API do {{site.data.keyword.IBM_notm}} por um token de acesso com limite de tempo e, em seguida, use o token para autenticar com relação à API {{site.data.keyword.cloudant_short_notm}}.

Em Python, um exemplo pode ser semelhante a:

```python
tempo de importação

solicitações de importação

API_KEY = "MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz"
ACCOUNT = "76838001-b883-444d-90d0-46f89e942a15-bluemix"

def get_access_token(api_key):
    """Retrieve an access token from the IAM token service."""
    token_response = requests.post(
        "https://iam.cloud.ibm.com/identity/token",
        data={
            "grant_type": "urn:ibm:params:oauth:grant-type:apikey",
            "response_type": "cloud_iam",
            "apikey": api_key
        },
        headers={
            "Accept": "application/json"
        }
    )
    if token_response.status_code == 200:
        print "Got access token from IAM"
        return token_response.json()['access_token']
    else:
        print token_response.status_code, token_response.json()
        return None

def main(api_key, account):
    access_token = None
    while True:
        if not access_token:
            access_token = get_access_token(api_key)

        if access_token:
            response = requests.get(
                "https://{0}.cloudant.com/_all_dbs".format(account),
                headers={
                    "Accept": "application/json",
                    "Authorization": "Bearer {0}".format(access_token)
                }
            )
            print "Got Cloudant response, status code", response.status_code
            if response.status_code == 401:
                print "Token has expired."
                access_token = None

        time.sleep (1)

if __name__ == "__main__":
    main(API_KEY, ACCOUNT)
```

## Referência
{: #reference}

Esta seção contém uma lista completa das ações do IAM do {{site.data.keyword.cloudant_short_notm}} e quais delas são permitidas para cada função do sistema IAM.

### {{site.data.keyword.cloudant_short_notm}}  ações
{: #ibm-cloudant-actions}

As tabelas a seguir descrevem as ações e funções disponíveis do IAM. 

<table>
<caption style="caption-side:top">Tabela 3. Descrições da ação disponível</caption>
<thead>
<tr>
<th id="action">Ação</th>
<th id="description">Descrição</th>
</tr>
</thead>

<tr>
<td headers="action"><code>cloudant.db.any</code></td>
<td headers="description">Acesse qualquer terminal de banco de dados (aqueles cujo caminho não se inicia com `/_api`).</td>
</tr>

<tr>
<td headers="action"><code>cloudantnosqldb.sapi.dbsecurity</code></td>
<td headers="description">Acesse `/_api/v2/db/<path:db>/_security`.</td>
</tr>

<tr>
<td headers="action"><code>cloudantnosqldb.sapi.usercors</code></td>
<td headers="description">Acesse `/_api/v2/user/config/cors/`.</td>
</tr>

<tr>
<td headers="action"><code>cloudantnosqldb.sapi.apikeys</code></td>
<td headers="description">Acesse  ` /_api/v2/api_keys `.</td>
</tr>

<tr>
<td headers="action"><code>cloudantnosqldb.sapi.userinfo</code></td>
<td headers="description">Acesse  ` /_api/v2/user `.</td>
</tr>
</table>
</br>
Para autorização de baixa granularidade, oferecemos funções de gerenciador, leitor e gravador.
</br>

<table>
<caption style="caption-side:top">Tabela 4. Ações somente gerenciador</caption>
<thead>
<tr>
<th id="method">Método</th>
<th id="endpoint">Terminal</th>
<th id="action-name">Nome da Ação</th>
<th id="role">Papel</th>
</tr>
</thead>

<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/</code></td>
<td headers="action-name">cloudantnosqldb.db.meta-info</td>
<td headers="role">Gerente</td>
</tr>

<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/_active_tasks</code></td>
<td headers="action-name">cloudantnosqldb.account.active-tasks</td>
<td headers="role">Gerente</td>
</tr>

<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/_replicator</code></td>
<td headers="action-name">cloudantnosqldb.replication.status</td>
<td headers="role">Gerente</td>
</tr>

<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/_replicator/$DOC</code></td>
<td headers="action-name">cloudantnosqldb.replication.status</td>
<td headers="role">Gerente</td>
</tr>

<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/_scheduler/jobs</code></td>
<td headers="action-name">cloudantnosqldb.replication.status</td>
<td headers="role">Gerente</td>
</tr>

<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/_scheduler/docs</code></td>
<td headers="action-name">cloudantnosqldb.replication.status</td>
<td headers="role">Gerente</td>
</tr>

<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/_replicate</code></td>
<td headers="action-name">cloudantnosqldb.replication.write</td>
<td headers="role">Gerente</td>
</tr>

<tr>
<td headers="method"><code>PUT/DELETE</code></td>
<td headers="endpoint"><code>/_replicator</code></td>
<td headers="action-name">cloudantnosqldb.replication.write</td>
<td headers="role">Gerente</td>
</tr>

<tr>
<td headers="method"><code>PUT/DELETE</code></td>
<td headers="endpoint"><code>/_replicator/$DOC</code></td>
<td headers="action-name">cloudantnosqldb.replication.write</td>
<td headers="role">Gerente</td>
</tr>

<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/_up</code></td>
<td headers="action-name">cloudantnosqldb.account.up</td>
<td headers="role">Gerente</td>
</tr>

<tr>
<td headers="method"><code>PUT</code></td>
<td headers="endpoint"><code>/$DB/</code></td>
<td headers="action-name">cloudantnosqldb.database.create</td>
<td headers="role">Gerente</td>
</tr>

<tr>
<td headers="method"><code>DELETE</code></td>
<td headers="endpoint"><code>/$DB/</code></td>
<td headers="action-name">cloudantnosqldb.database.delete</td>
<td headers="role">Gerente</td>
</tr>

<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/$DB/_design_docs/queries</code></td>
<td headers="action-name">cloudantnosqldb.index.read</td>
<td headers="role">Gerente</td>
</tr>

<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID/_geo_info</code></td>
<td headers="action-name">cloudantnosqldb.index.read</td>
<td headers="role">Gerente</td>
</tr>

<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID/_info/$FURTHER_PATH_PARTS</code></td>
<td headers="action-name">cloudantnosqldb.index.read</td>
<td headers="role">Gerente</td>
</tr>

<tr>
<td headers="method"><code>GET</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID/_search_disk_size/$FURTHER_PATH_PARTS</code></td>
<td headers="action-name">cloudantnosqldb.index.read</td>
<td headers="role">Gerente</td>
</tr>

<tr>
<td headers="method"><code>GET</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID/_search_info/$FURTHER_PATH_PARTS</code></td>
<td headers="action-name">cloudantnosqldb.index.read</td>
<td headers="role">Gerente</td>
</tr>

<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/$DB/_index/$FURTHER_PATH_PARTS</code></td>
<td headers="action-name">cloudantnosqldb.index.read</td>
<td headers="role">Gerente</td>
</tr>

<tr>
<td headers="method"><code>GET</code></td>
<td headers="endpoint"><code>/$DB/_design_docs</code></td>
<td headers="action-name">cloudantnosqldb.index.read</td>
<td headers="role">Gerente</td>
</tr>

<tr>
<td headers="method"><code>GET</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID</code></td>
<td headers="action-name">cloudantnosqldb.index.read</td>
<td headers="role">Gerente</td>
</tr>

<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID/$ATTACHMENT</code></td>
<td headers="action-name">cloudantnosqldb.index.read</td>
<td headers="role">Gerente</td>
</tr>

<tr>
<td headers="method"><code>PUT</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID</code></td>
<td headers="action-name">cloudantnosqldb.index.write</td>
<td headers="role">Gerente</td>
</tr>

<tr>
<td headers="method"><code>COPY</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID</code></td>
<td headers="action-name">cloudantnosqldb.index.write</td>
<td headers="role">Gerente</td>
</tr>

<tr>
<td headers="method"><code>DELETE</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID</code></td>
<td headers="action-name">cloudantnosqldb.index.write</td>
<td headers="role">Gerente</td>
</tr>

<tr>
<td headers="method"><code>PUT</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID/$ATTACHMENT</code></td>
<td headers="action-name">cloudantnosqldb.index.write</td>
<td headers="role">Gerente</td>
</tr>

<tr>
<td headers="method"><code>DELETE</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID/$ATTACHMENT</code></td>
<td headers="action-name">cloudantnosqldb.index.write</td>
<td headers="role">Gerente</td>
</tr>

<tr>
<td headers="method"><code>POST/DELETE</code></td>
<td headers="endpoint"><code>/$DB/_index/$FURTHER_PATH_PARTS</code></td>
<td headers="action-name">cloudantnosqldb.index.write</td>
<td headers="role">Gerente</td>
</tr>

<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/$DB/_missing_revs</code></td>
<td headers="action-name">cloudantnosqldb.database.missing-revs</td>
<td headers="role">Gerente</td>
</tr>

<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/$DB/_missing_revs</code></td>
<td headers="action-name">cloudantnosqldb.database.missing-revs</td>
<td headers="role">Gerente</td>
</tr>

<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/$DB/_revs_diff</code></td>
<td headers="action-name">cloudantnosqldb.database.revs-diff</td>
<td headers="role">Gerente</td>
</tr>

<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/$DB/_security</code></td>
<td headers="action-name">cloudantnosqldb.database-security.read</td>
<td headers="role">Gerente</td>
</tr>

<tr>
<td headers="method"><code>PUT</code></td>
<td headers="endpoint"><code>/$DB/_security</code></td>
<td headers="action-name">cloudantnosqldb.database-security.write</td>
<td headers="role">Gerente</td>
</tr>

<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/$DB/_shards</code></td>
<td headers="action-name">cloudantnosqldb.database.shards</td>
<td headers="role">Gerente</td>
</tr>

<tr>
<td headers="method"><code>COPY</code></td>
<td headers="endpoint"><code>/$DB/$DOC_ID</code></td>
<td headers="action-name">cloudantnosqldb.document.copy</td>
<td headers="role">Gerente</td>
</tr>

<tr>
<td headers="method"><code>GET</code></td>
<td headers="endpoint"><code>/_membership</code></td>
<td headers="action-name">cloudantnosqldb.cluster-membership.read</td>
<td headers="role">Gerente</td>
</tr>

<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/$DB/_ensure_full_commit</code></td>
<td headers="action-name">cloudantnosqldb.database.ensure-full-commit</td>
<td headers="role">Gerente</td>
</tr>
</table>

</br>

<table>
<caption style="caption-side:top">Tabela 5. Ações de gerenciador e de gravador</caption>
<thead>
<tr>
<th id="method">Método</th>
<th id="endpoint">Terminal</th>
<th id="action-name">Nome da Ação</th>
<th id="role">Papel</th>
</tr>
</thead>

<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/_uuids</code></td>
<td headers="action-name">cloudantnosqldb.account.uuids</td>
<td headers="role">Gerenciador, gravador</td>
</tr>

<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/$DB/</code></td>
<td headers="action-name">cloudantnosqldb.document.write</td>
<td headers="role">Gerenciador, gravador</td>
</tr>

<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/$DB/_bulk_docs</code></td>
<td headers="action-name">cloudantnosqldb.document.write</td>
<td headers="role">Gerenciador, gravador</td>
</tr>

<tr>
<td headers="method"><code>PUT</code></td>
<td headers="endpoint"><code>/$DB/$DOC_ID</code></td>
<td headers="action-name">cloudantnosqldb.document.write</td>
<td headers="role">Gerenciador, gravador</td>
</tr>

<tr>
<td headers="method"><code>DELETE</code></td>
<td headers="endpoint"><code>/$DB/$DOC_ID</code></td>
<td headers="action-name">cloudantnosqldb.document.write</td>
<td headers="role">Gerenciador, gravador</td>
</tr>

<tr>
<td headers="method"><code>PUT</code></td>
<td headers="endpoint"><code>/$DB/$DOC_ID/$ATTACHMENT</code></td>
<td headers="action-name">cloudantnosqldb.document.write</td>
<td headers="role">Gerenciador, gravador</td>
</tr>

<tr>
<td headers="method"><code>DELETE</code></td>
<td headers="endpoint"><code>/$DB/$DOC_ID/$ATTACHMENT</code></td>
<td headers="action-name">cloudantnosqldb.document.write</td>
<td headers="role">Gerenciador, gravador</td>
</tr>

<tr>
<td headers="method"><code>PUT/DELETE</code></td>
<td headers="endpoint"><code>/$DB/_local/$DOC_ID</code></td>
<td headers="action-name">cloudantnosqldb.document-local.write</td>
<td headers="role">Gerenciador, gravador</td>
</tr>

<tr>
<td headers="method"><code>COPY</code></td>
<td headers="endpoint"><code>/$DB/_local/$DOC_ID</code></td>
<td headers="action-name">cloudantnosqldb.document-local.copy</td>
<td headers="role">Gerenciador, gravador</td>
</tr>
</table>

</br>

<table>
<caption style="caption-side:top">Tabela 6. Ações de gerenciador, gravador e leitor</caption>
<thead>
<tr>
<th id="method">Método</th>
<th id="endpoint">Terminal</th>
<th id="action-name">Nome da Ação</th>
<th id="role">Papel</th>
</tr>
</thead>
<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/_iam_session</code></td>
<td headers="action-name">cloudantnosqldb.iam-session.read</td>
<td headers="role">Gerenciador, gravador, leitor</td>
</tr>

<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/_iam_session</code></td>
<td headers="action-name">cloudantnosqldb.iam-session.write</td>
<td headers="role">Gerenciador, gravador, leitor</td>
</tr>
<tr>
<td headers="method"><code>DELETE</code></td>
<td headers="endpoint"><code>/_iam_session</code></td>
<td headers="action-name">cloudantnosqldb.iam-session.delete</td>
<td headers="role">Gerenciador, gravador, leitor</td>
</tr>
<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/_session</code></td>
<td headers="action-name">cloudantnosqldb.session.read</td>
<td headers="role">Gerenciador, gravador, leitor</td>
</tr>
<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/_session</code></td>
<td headers="action-name">cloudantnosqldb.session.write</td>
<td headers="role">Gerenciador, gravador, leitor</td>
</tr>
<tr>
<td headers="method"><code>DELETE</code></td>
<td headers="endpoint"><code>/_session</code></td>
<td headers="action-name">cloudantnosqldb.session.delete</td>
<td headers="role">Gerenciador, gravador, leitor</td>
</tr>
<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/_all_dbs</code></td>
<td headers="action-name">cloudantnosqldb.account.all-dbs</td>
<td headers="role">Gerenciador, gravador, leitor</td>
</tr>
<tr>
<td headers="method"><code>GET</code></td>
<td headers="endpoint"><code>/_db_updates</code></td>
<td headers="action-name">cloudantnosqldb.account.db-updates</td>
<td headers="role">Gerenciador, gravador, leitor</td>
</tr>
<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/_dbs_info</code></td>
<td headers="action-name">cloudantnosqldb.account.dbs-info</td>
<td headers="role">Gerenciador, gravador, leitor</td>
</tr>
<tr>
<td headers="method"><code>GET</code></td>
<td headers="endpoint"><code>/$DB/</code></td>
<td headers="action-name">cloudantnosqldb.database.info</td>
<td headers="role">Gerenciador, gravador, leitor</td>
</tr>
<tr>
<td headers="method"><code>GET/POST</code></td>
<td headers="endpoint"><code>/$DB/_all_docs</code></td>
<td headers="action-name">cloudantnosqldb.database.all-docs</td>
<td headers="role">Gerenciador, gravador, leitor</td>
</tr>
<tr>
<td headers="method"><code>GET/POST</code></td>
<td headers="endpoint"><code>/$DB/_changes</code></td>
<td headers="action-name">cloudantnosqldb.database.changes</td>
<td headers="role">Gerenciador, gravador, leitor</td>
</tr>
<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/$DB/$DOC_ID</code></td>
<td headers="action-name">cloudantnosqldb.document.read</td>
<td headers="role">Gerenciador, gravador, leitor</td>
</tr>
<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/$DB/$DOC_ID/$ATTACHMENT</code></td>
<td headers="action-name">cloudantnosqldb.document.read</td>
<td headers="role">Gerenciador, gravador, leitor</td>
</tr>
<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/$DB/_bulk_get</code></td>
<td headers="action-name">cloudantnosqldb.document.read</td>
<td headers="role">Gerenciador, gravador, leitor</td>
</tr>

<tr>
<td headers="method"><code>GET/POST</code></td>
<td headers="endpoint"><code>/_search_analyze</code></td>
<td headers="action-name">cloudantnosqldb.query.execute</td>
<td headers="role">Gerenciador, gravador, leitor</td>
</tr>
<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/$DB/_all_docs/queries</code></td>
<td headers="action-name">cloudantnosqldb.query.execute</td>
<td headers="role">Gerenciador, gravador, leitor</td>
</tr>
<tr>
<td headers="method"><code>GET/HEAD</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID/_geo/$FURTHER_PATH_PARTS</code></td>
<td headers="action-name">cloudantnosqldb.query.execute</td>
<td headers="role">Gerenciador, gravador, leitor</td>
</tr>
<tr>
<td headers="method"><code>GET/POST</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID/_list/$FURTHER_PATH_PARTS</code></td>
<td headers="action-name">cloudantnosqldb.query.execute</td>
<td headers="role">Gerenciador, gravador, leitor</td>
</tr>
<tr>
<td headers="method"><code>GET/POST</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID/_search/$FURTHER_PATH_PARTS</code></td>
<td headers="action-name">cloudantnosqldb.query.execute</td>
<td headers="role">Gerenciador, gravador, leitor</td>
</tr>
<tr>
<td headers="method"><code>GET/POST</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID/_show/$FURTHER_PATH_PARTS</code></td>
<td headers="action-name">cloudantnosqldb.query.execute</td>
<td headers="role">Gerenciador, gravador, leitor</td>
</tr>
<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID/_view/$VIEW/queries</code></td>
<td headers="action-name">cloudantnosqldb.query.execute</td>
<td headers="role">Gerenciador, gravador, leitor</td>
</tr>
<tr>
<td headers="method"><code>GET/POST</code></td>
<td headers="endpoint"><code>/$DB/_design/$DOC_ID/_view/$FURTHER_PATH_PARTS</code></td>
<td headers="action-name">cloudantnosqldb.query.execute</td>
<td headers="role">Gerenciador, gravador, leitor</td>
</tr>
<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/$DB/_explain/$FURTHER_PATH_PARTS</code></td>
<td headers="action-name">cloudantnosqldb.query.execute</td>
<td headers="role">Gerenciador, gravador, leitor</td>
</tr>
<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/$DB/_find/$FURTHER_PATH_PARTS</code></td>
<td headers="action-name">cloudantnosqldb.query.execute</td>
<td headers="role">Gerenciador, gravador, leitor</td>
</tr>
<tr>
<td headers="method"><code>GET</code></td>
<td headers="endpoint"><code>/$DB/_local_docs</code></td>
<td headers="action-name">cloudantnosqldb.document-local.read</td>
<td headers="role">Gerenciador, gravador, leitor</td>
</tr>
<tr>
<td headers="method"><code>POST</code></td>
<td headers="endpoint"><code>/$DB/_local_docs/queries</code></td>
<td headers="action-name">cloudantnosqldb.document-local.read</td>
<td headers="role">Gerenciador, gravador, leitor</td>
</tr>
<tr>
<td headers="method"><code>GET</code></td>
<td headers="endpoint"><code>/$DB/_local/$DOC_ID</code></td>
<td headers="action-name">cloudantnosqldb.document-local.read</td>
<td headers="role">Gerenciador, gravador, leitor</td>
</tr>
</table>

</br>

#### Terminais indisponíveis
{: #unavailable-endpoints}

Os terminais a seguir estão indisponíveis para solicitações autorizadas com o IAM:

- Retornos de regravação HTTP:  ` /db/_design/design-doc/_rewrite/path `. <br>
Embora os documentos de design possam conter manipuladores de regravação, os usuários não podem chamá-los.
- Atualize os handers:  ` POST / { /_design/ { /_update/ { `. <br>
Embora os documentos de design possam conter funções de atualização, os usuários não podem chamá-los.

### Mapeamento de  {{site.data.keyword.cloudant_short_notm}}  ações para funções do IAM
{: #mapping-of-ibm-cloudant-actions-to-iam-roles}

Somente usuários e serviços da função de Gerenciador podem acessar dados do {{site.data.keyword.cloudant_short_notm}}.

<table>
<caption style="caption-side:top">Tabela 7. Funções mapeadas para ações permitidas</caption>
<thead>
<tr>
<th id="role">Papel</th>
<th id="allowed-action">Ação permitida</th>
</tr>
</thead>

<tr>
<td headers="role">Gerente</td>
<td headers="allowed-action">Todas as ações documentadas</td>
</tr>

<tr>
<td headers="role">Leitor</td>
<td headers="allowed-action">Nenhuma</td>
</tr>

<tr>
<td headers="role">Transcritor</td>
<td headers="allowed-action">Nenhuma</td>
</tr>
</table>

## Solucionando problemas
{: #troubleshooting}
Se você estiver tendo problemas ao usar o IAM para autenticar-se ao fazer solicitações para a instância de serviço do {{site.data.keyword.cloudant_short_notm}}, verifique sua conta conforme mostrado na próxima seção.

### Assegure-se de que sua conta esteja ativada pelo IAM
{: #ensure-your-account-is-iam-enabled}

Na parte Visão geral do IBM Cloudant Dashboard, o "método de autenticação" é listado sob os detalhes da implementação. Seus métodos de autenticação disponíveis estão listados lá. 
