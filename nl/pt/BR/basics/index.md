---

copyright:
  years: 2015, 2018
lastupdated: "2018-02-15"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# Informações básicas do {{site.data.keyword.cloudant_short_notm}}

Se for a sua primeira vez aqui,
verifique esta seção antes de continuar.
{:shortdesc}

As seções sobre [Bibliotecas do cliente](../libraries/index.html#-client-libraries),
[Referência de API](../api/index.html#-api-reference)
e [Guias](../guides/acurl.html#authorized-curl-acurl-) presumem que você saiba algumas coisas básicas sobre o {{site.data.keyword.cloudantfull}}.

## Conectando-se ao {{site.data.keyword.cloudant_short_notm}}

Para acessar o {{site.data.keyword.cloudant_short_notm}},
deve-se ter uma conta do [{{site.data.keyword.cloudant_short_notm}}](../api/account.html)
ou uma conta do [{{site.data.keyword.Bluemix}}](../offerings/bluemix.html).

## API HTTP

Todas as solicitações para o {{site.data.keyword.cloudant_short_notm}} passam pela web.
Isso significa que qualquer sistema que possa falar com a web pode falar com o {{site.data.keyword.cloudant_short_notm}}.
Todas as bibliotecas específicas da linguagem para o {{site.data.keyword.cloudant_short_notm}} são realmente apenas wrappers que fornecem
alguma conveniência e sutilezas linguísticas para ajudar você a trabalhar com uma API simples.
Muitos usuários escolhem usar bibliotecas HTTP brutas para trabalhar com o {{site.data.keyword.cloudant_short_notm}}.

Detalhes específicos sobre como o {{site.data.keyword.cloudant_short_notm}} usa HTTP são
fornecidos no [tópico HTTP da Referência de API](../api/http.html).

O {{site.data.keyword.cloudant_short_notm}} suporta os métodos de solicitação de HTTP a seguir:

-   `GET`

    Solicitar o item especificado.
    Como com solicitações normais de HTTP,
o formato da URL define o que é retornado.
    Com o {{site.data.keyword.cloudant_short_notm}}, isso pode incluir itens estáticos,
documentos do banco de dados
e informações de configuração e de estatísticas.
    Na maioria dos casos, as informações são retornadas na forma de um documento JSON.

-   `HEAD`

    O método `HEAD` é usado para obter o cabeçalho HTTP de uma solicitação `GET` sem o corpo da resposta.

-   `POST`

    Fazer upload de dados.
    Na API do {{site.data.keyword.cloudant_short_notm}},
o método `POST` é usado para configurar valores,
fazer upload de documentos,
configurar valores do documento
e iniciar alguns comandos de administração.

-   `PUT`

    Usado para 'armazenar' um recurso específico.
    Na API do {{site.data.keyword.cloudant_short_notm}},
`PUT` é usado para criar novos objetos,
incluindo bancos de dados,
documentos,
visualizações
e documentos de design.

-   `DELETE`

    Exclui o recurso especificado,
incluindo documentos,
visualizações
e documentos de design.

-   `COPY`

    Um método especial que pode ser usado para copiar documentos e objetos.

Se o cliente (como alguns navegadores da web) não suportar o uso desses métodos HTTP,
`POST` poderá ser usado no lugar com o cabeçalho de solicitação `X-HTTP-Method-Override` configurado como o método HTTP real.

### Erro de método não permitido

Se você usar um tipo de solicitação de HTTP não suportado com uma URL que não suporta o tipo especificado,
um erro [405](../api/http.html#405) será retornado
listando os métodos HTTP suportados, conforme mostrado no exemplo a seguir.

_Exemplo de mensagem de erro em resposta a uma solicitação não suportada:_

```json
{
    "error":"method_not_allowed",
    "reason":"Only GET,HEAD allowed"
}
```
{:codeblock}

## JSON
{: #json}

O {{site.data.keyword.cloudant_short_notm}} armazena documentos usando codificação JSON (JavaScript Object Notation),
portanto, qualquer coisa codificada em JSON pode ser armazenada como um documento.
Arquivos contendo mídia,
como imagens,
vídeos
e áudio,
são chamados de BLOBs (Binary Large OBjects)
e podem ser armazenados como anexos associados a documentos.

Mais informações sobre JSON podem ser localizadas no [Guia do JSON](../guides/json.html).

<div id="distributed"></div>

## Sistemas distribuídos

a API do {{site.data.keyword.cloudant_short_notm}} permite interagir com uma colaboração de várias máquinas,
chamadas de cluster.
As máquinas em um cluster devem estar no mesmo data center,
mas podem ficar dentro de 'pods' diferentes nesse data center.
Usar diferentes pods ajuda a melhorar as características de Alta Disponibilidade do {{site.data.keyword.cloudant_short_notm}}.

Uma vantagem do armazenamento em cluster é que quando for necessário mais capacidade de cálculo,
bastará incluir mais máquinas.
Isso geralmente apresenta menor custo e tolerância a falhas do que ajustar a escala ou aprimorar uma única máquina existente.

Para obter mais informações sobre o {{site.data.keyword.cloudant_short_notm}} e os conceitos de sistema distribuído,
veja o guia [Teorema CAP](../guides/cap_theorem.html).

## Replicação

[Replicação](../api/replication.html) é um procedimento seguido pelo {{site.data.keyword.cloudant_short_notm}},
[CouchDB ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://couchdb.apache.org/){:new_window},
[PouchDB ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](http://pouchdb.com/){:new_window}
e outros bancos de dados distribuídos.
A replicação sincroniza o estado de dois bancos de dados para que seus conteúdos sejam idênticos.

É possível replicar continuamente.
Isso significa que um banco de dados de destino é atualizado sempre que o banco de dados de origem muda.
A replicação contínua pode ser usada para backups de dados,
agregação de dados entre múltiplos bancos de dados
ou para compartilhamento de dados.

No entanto,
replicação contínua significa testar continuamente por quaisquer mudanças do banco de dados de origem.
Esse teste requer chamadas internas contínuas,
que podem afetar o desempenho ou o custo de uso do banco de dados.

>   **Nota**: a replicação contínua pode resultar em um grande número de chamadas internas.
    Isso pode afetar os custos para usuários com diversos locatários de sistemas {{site.data.keyword.cloudant_short_notm}}.
    A replicação contínua é desativada por padrão.
