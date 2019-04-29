---

copyright:
  years: 2015, 2019
lastupdated: "2019-03-06"

keywords: encode user name, encode password, create alias, activate alias, test acurl

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

# Curl autorizado: `acurl`
{: #authorized-curl-acurl-}

_(Este guia se baseia em um artigo do Blog de Samantha Scharr: [
"Curl autorizado, também conhecido como acurl", originalmente publicado em 27 de novembro de 2013.)_

`acurl` é um alias útil que permite executar `curl` de comandos {{site.data.keyword.cloudantfull}} para URLs sem ter que inserir seu nome de usuário e senha para cada solicitação.
Isso significa que um simples `GET` para um banco de dados não precisa mais ser gravado como
`https://$ACCOUNT:$PASSWORD@$ACCOUNT.cloudant.com/foo`;
em vez disso, basta usar `https://$ACCOUNT.cloudant.com/foo`.

Isso não apenas diminui URLs muito longas,
como também o alias `acurl` é mais seguro.
Ele evita que alguém leia sua senha sobre seus ombros enquanto você digita
e, o mais importante,
ele garante que sua senha não seja enviada em texto sem formatação pela rede, utilizando HTTPS.

São necessárias apenas três etapas simples:

1.	[ Codificar nome de usuário e senha ](#encode-user-name-and-password).
2.	[Crie um alias](#create-an-alias).
3.	[Ativar o alias](#activate-the-alias).

Se você estiver usando um computador Windows, será possível especificar seu nome de usuário e senha por meio da linha de comandos.
{: tip}

## Codificar nome de usuário e senha
{: #encode-user-name-and-password}

Primeiro, codificamos seu nome de usuário e senha do {{site.data.keyword.cloudant_short_notm}} com base64.
Isso nos dá uma sequência de caracteres base64 como saída.

O comando para codificar alguns dados com base64 é semelhante ao exemplo a seguir:

```python
python -c 'import base64; print base64.urlsafe_b64encode("$ACCOUNT:$PASSWORD")'
```
{: codeblock}

Assumimos que a saída seja chamada de `<OUTPUT-OF-BASE64>`.

Por exemplo,
se você usar o comando:

```python
python -c 'import base64; print base64.urlsafe_b64encode("$ACCOUNT:$PASSWORD")'
```
{: codeblock}

Você obterá a saída a seguir:

```
bXl1c2VybmFtZTpteXBhc3N3b3Jk
```
{: codeblock}

Lembre-se de que sua senha ainda está armazenada em texto sem formatação em seu computador. A codificação Base64 _não_ é criptografia. Se você usar a codificação base64 na mesma sequência de caracteres,
sempre obterá a mesma sequência de saída de caracteres correspondente.
{: note}

## Criar um alias
{: #create-an-alias}

Agora criaremos um alias para `curl` que inclua essas credenciais para que não seja necessário inseri-las
sempre que um comando `curl` for gravado.

Inclua a linha a seguir em seu `~/.bashrc` ou `~/.bash_profile`:

```sh
alias acurl="curl -s --proto '=https' -g -H 'Authorization: Basic <OUTPUT-OF-BASE64>'"
```
{: codeblock}

Esse alias inclui um cabeçalho de Autorização em vez de incluir as
credenciais de autorização na URL inserida na linha de comandos.
Ele também força o uso de HTTPS, que é altamente recomendável sobre HTTP simples,
uma vez que criptografa seus dados e credenciais em trânsito e o ajuda a ter certeza de que está se conectando a sistemas {{site.data.keyword.cloudant_short_notm}}.

## Ativar o alias
{: #activate-the-alias}

Agora inicie um novo shell ou execute `source ~/.bash_profile` (ou `~/.bashrc`, se isso tiver sido usado) para tornar o alias funcional.

## Testando `acurl`
{: #testing-acurl-}

Agora vamos nos certificar de que tudo está configurado corretamente.
Vá em frente e execute:

```sh
acurl https://$ACCOUNT.cloudant.com/_all_dbs
```
{: codeblock}

Se você obtiver a lista de seus bancos de dados de volta,
incrível!
`acurl` estará configurado e pronto para execução.

Boa codificação!
