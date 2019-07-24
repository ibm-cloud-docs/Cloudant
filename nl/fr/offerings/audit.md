---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: principal, action, resource, timestamp, access audit logs

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

# Consignation dans le journal d'audit
{: #audit-logging}

La consignation dans le journal d'audit enregistre les principaux {{site.data.keyword.cloudantfull}} ayant accédé à des données stockées dans {{site.data.keyword.cloudant_short_notm}}. Pour tous les accès d'API HTTP à {{site.data.keyword.cloudant_short_notm}}, la fonction de consignation dans le journal d'audit enregistre les informations suivantes relatives à chaque demande HTTP :

Informations | Description
------------|------------
`Principal` | Identifiants de compte, clé d'API ou données d'identification IBM Cloud IAM.
`Action` | Action effectuée (par exemple, lecture de document).
`Ressource` | Détails sur le compte, la base de données, le document ayant fait l'objet d'un accès ou la requête créée.
`Horodatage` | Enregistrement de l'heure et des données de l'événement. 
{: shortdesc}

Les journaux d'audit {{site.data.keyword.cloudant_short_notm}} peuvent permettre de comprendre :

- Quelles bases de données et quels documents ont fait l'objet d'un accès dans un compte, à quel moment et par qui.
- Quelles requêtes ont été exécutées, à quel moment et par qui.
- Quel principal ou utilisateur spécifique a fait l'objet d'un accès ou a été mis à jour ou supprimé et à quel moment.
- Quels documents de réplication ont été créés ou supprimés et à quel moment.


## Comment accéder aux journaux d'audit pour votre compte
{: #how-to-access-audit-logs-for-your-account}

Afin de demander l'accès aux journaux d'audit pour votre compte, contactez le support {{site.data.keyword.cloudant_short_notm}}. L'équipe de support fournit une copie des journaux d'audit qui présentent un intérêt pour vous.

Lorsque vous contactez le support, veillez à inclure :

- Le compte concerné par la demande {{site.data.keyword.cloudant_short_notm}}.
- Le délai des journaux d'audit (ne doit pas dépasser un mois par demande de support).
- Les bases de données, documents ou principaux présentant un intérêt.
