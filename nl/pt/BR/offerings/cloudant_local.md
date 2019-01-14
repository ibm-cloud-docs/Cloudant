---

copyright:
  years: 2015, 2018
lastupdated: "2018-10-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:tip: .tip}

<!-- Acrolinx: 2017-05-10 -->

# {{site.data.keyword.cloudant_local_notm}}

[{{site.data.keyword.cloudantfull}} Data Layer Local Edition ({{site.data.keyword.cloudant_local_notm}}) ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/support/knowledgecenter/SSTPQH_1.1.0/com.ibm.cloudant.local.doc/SSTPQH_1.1.0_welcome.html){:new_window} é uma versão instalada localmente da oferta Banco de Dados como um Serviço (DBaaS) do {{site.data.keyword.cloudant_short_notm}}.

O {{site.data.keyword.cloudant_local_notm}} fornece a você a mesma capacidade básica que a oferta completa de único locatário do {{site.data.keyword.cloudant_short_notm}},
mas hospedado em seu próprio data center.

Uma visão geral mais detalhada do {{site.data.keyword.cloudant_local_notm}} está
[disponível ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/support/knowledgecenter/en/SSTPQH_1.1.0/com.ibm.cloudant.local.install.doc/topics/clinstall_cloudant_local_overview.html){:new_window}.
O
[IBM Knowledge Center ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/support/knowledgecenter/en/SSTPQH_1.1.0/com.ibm.cloudant.local.doc/SSTPQH_1.1.0_welcome.html){:new_window}
fornece informações sobre vários aspectos do {{site.data.keyword.cloudant_local_notm}},
incluindo:

-   [Instalação e configuração ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/support/knowledgecenter/en/SSTPQH_1.1.0/com.ibm.cloudant.local.install.doc/topics/clinstall_installing.html){:new_window}.
-   [Tarefas de manutenção ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/support/knowledgecenter/en/SSTPQH_1.1.0/com.ibm.cloudant.local.install.doc/topics/clinstall_maintenance_tasks_overview.html){:new_window}.
-   [Ajustando os parâmetros de replicação ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/support/knowledgecenter/en/SSTPQH_1.1.0/com.ibm.cloudant.local.install.doc/topics/clinstall_tuning_parameters_replication_cases.html){:new_window}.

## Suporte

O suporte do {{site.data.keyword.cloudant_short_notm}} é capaz de fornecer assistência para a instalação, a configuração e o uso adequado do {{site.data.keyword.cloudant_local_notm}}. No caso de um problema de desempenho ou inconsistência, o suporte é capaz de ajudar a solucionar problemas. No caso de uma indisponibilidade, o suporte pode ajudar a diagnosticar o problema, mas a responsabilidade de resolver o problema depende da equipe do cliente, já que não temos acesso aos sistemas do cliente.

Logs adequados são necessários para fornecer assistência adequada a qualquer problema. Para ajudar a resolução de problemas iniciar o mais rápido possível, deve-se incluir a saída do utilitário Weatherreport, bem como quaisquer logs relevantes, solicitações e códigos de status ao informar o suporte sobre um problema. Para obter mais informações, consulte o [Utilitário Weatherreport ![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo") ](https://www.ibm.com/support/knowledgecenter/SSTPQH_1.1.0/com.ibm.cloudant.local.install.doc/topics/clinstall_checking_health_cluster_with_weatherreport.html){:new_window}.

A assistência com questões comuns e indisponibilidades só poderá ser oferecida se o problema subjacente estiver no âmbito do suporte. O texto a seguir descreve o suporte que está disponível: 

O suporte {{site.data.keyword.cloudant_short_notm}}  abrange os seguintes problemas:
- Instalação Próppor
- Configurar
- Qualquer coisa relacionada aos erros de retorno da API ou resultados ou desempenho inesperados

O suporte do {{site.data.keyword.cloudant_short_notm}} não abrange os problemas a seguir:
- Conjunto de ferramentas ou fluxo de trabalho do lado do cliente proprietário
- Problemas de rede 
- Criptografia no disco 
- Ferramenta Customizada ou Funcionalidade

Por exemplo, se a causa raiz for um servidor de propriedade do cliente tendo problemas de hardware, o suporte não poderá ajudar. No entanto, se a indisponibilidade acontecer por causa do próprio software do {{site.data.keyword.cloudant_short_notm}}, por exemplo, se ocorrer lentidão na solicitação devido a conflitos de documentos, o suporte poderá ajudar o cliente a resolver o problema.

Entre em contato com o Sucesso do cliente ou o Gerente de contas para obter assistência adicional com as solicitações a seguir:
- Ajuste de Desempenho
- Otimização de design
- Planejamento de capacidade

Se você tiver quaisquer perguntas relacionadas à política de suporte, entre em contato com a [equipe de suporte do {{site.data.keyword.cloudant_short_notm}}![Ícone de link externo](../images/launch-glyph.svg "Ícone de link externo")](mailto:support@cloudant.com){:new_window}.

### Como abrir um chamado de suporte
Para obter ajuda com um problema do {{site.data.keyword.cloudant_local_notm}}, abra um chamado de suporte com o suporte do {{site.data.keyword.cloudant_short_notm}} e inclua as informações a seguir:

1. Crie um e-mail para abrir uma [solicitação de suporte do {{site.data.keyword.cloudant_short_notm}}](mailto:support@cloudant.com).
2. Na linha de assunto de e-mail, forneça uma única frase sobre o problema.
3. O e-mail deve conter os seguintes detalhes para nos ajudar a diagnosticar seu problema:
    - Nome
    - Endereço de e-mail de contato
    - Nome de sua organização
    - Versão do {{site.data.keyword.cloudant_local_notm}} que você está usando
    - Distribuição e versão do Linux que você está usando para executar o {{site.data.keyword.cloudant_local_notm}}
    - Nível de severidade do problema
    - Descrição detalhada do problema, incluindo as condições quando ele acontece e informações sobre quaisquer mudanças recentes
    - Se disponível, anexe logs ou saída que possa ajudar no diagnóstico, na reprodução e na investigação do problema
4. Quando o suporte receber o e-mail, um membro da equipe de suporte entrará em contato com você.

