---

copyright:
  years: 2018, 2019
lastupdated: "2019-03-18"

keywords: audit access ibm cloudant, supported classifications of personal data, personal data, sensitive personal data, restrictions on processing, encrypt data, data locations, service security, delete data

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

# Règlement général sur la protection des données (RGPD)
{: #general-data-protection-regulation-gdpr-}

Le Règlement général sur la protection des données cherche à créer un cadre juridique harmonisé pour la protection des données dans l'UE et vise à redonner aux citoyens le contrôle de leurs données personnelles, tout en imposant des règles strictes à ceux qui hébergent et 'traitent' ces données partout dans le monde. Ce règlement introduit également des règles relatives à la libre circulation des données à caractère personnel à l'intérieur et à l'extérieur de l'UE. 

Grâce au [Règlement général sur la protection des données ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://www.eugdpr.org/){: new_window}, les clients {{site.data.keyword.cloudantfull}} peuvent se fier à la compréhension et à la conformité de l'équipe
{{site.data.keyword.cloudant_short_notm}} par rapport aux nouvelles normes et lois liées à la confidentialité des données, mais aussi à la capacité croissante d'{{site.data.keyword.IBM}} de fournir une
suite complète de solutions destinées à assister les entreprises de toutes tailles quant à la conformité à leurs propres exigences gouvernementales en matière de données internes.

## Comment puis-je effectuer un audit de l'accès à {{site.data.keyword.cloudant_short_notm}} ?
{: #how-do-i-audit-access-to-ibm-cloudant-}

Vous trouverez des informations sur le processus d'audit dans la rubrique [Consignation dans le journal d'audit](/docs/services/Cloudant?topic=cloudant-audit-logging#audit-logging){: new_window}. 

## Classifications de données personnelles prises en charge
{: #supported-classifications-of-personal-data}

Les catégories suivantes de données personnelles sont prises en charge par {{site.data.keyword.cloudant_short_notm}} pour le Règlement général sur la protection des données
(RGPD) :

**Données personnelles**, par exemple :
 * Identité/état civil
 * Vie personnelle
 * Vie professionnelle
 * Données d'emplacement
 * Données de connectivité/d'appareil

**Données personnelles sensibles**, limitées à :
  * Données de santé. Les conditions supplémentaires sont couvertes dans la [description du service {{site.data.keyword.cloudant_short_notm}} Dedicated Cluster Service ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://www-03.ibm.com/software/sla/sladb.nsf/pdf/6756-04/$file/i126-6756-04_05-2018_en_US.pdf){: new_window} et [{{site.data.keyword.cloud}} Additional Service Description ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://www-03.ibm.com/software/sla/sladb.nsf/pdf/6627-04/$file/i126-6627-04_04-2018_en_US.pdf){: new_window}

Si vous stockez des données de santé, vous *devez* effectuer les tâches suivantes :
 - Prévenir {{site.data.keyword.cloudant_short_notm}} avant d'écrire des données.
 - Demander un cluster dédié conforme à HIPAA.

Pour en savoir plus sur les classifications de données personnelles prises en charge, consultez le document
[Data Sheet Addendum (DSA), paragraphe 2. Personal Data ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/software/reports/compatibility/clarity-reports/report/html/softwareReqsForProduct?deliverableId=2EBB5860B34311E7A9EB066095601ABB){: new_window}.

## Données me concernant
{: #data-about-me}

{{site.data.keyword.cloudant_short_notm}} enregistre certaines des données relatives à ses utilisateurs, et est un contrôleur de données pour
lesdites informations personnelles. Les données que {{site.data.keyword.cloudant_short_notm}} enregistre dépendent de votre type de compte.

Si vous avez un cluster {{site.data.keyword.cloudant_short_notm}} dédié/cluster {{site.data.keyword.cloudant_short_notm}}
d'entreprise, nous enregistrons des données vous concernant et nous sommes considéré comme un contrôleur de données pour vos données dans le
contexte du Règlement général sur la protection des données. 
Si vous avez un cluster {{site.data.keyword.cloudant_short_notm}} dédié/cluster {{site.data.keyword.cloudant_short_notm}} d'entreprise,
nous avons vos :

 * Nom
 * Adresse électronique

Les données que {{site.data.keyword.cloudant_short_notm}} détient peuvent être affichées et mises à jour via le tableau de bord {{site.data.keyword.cloudant_short_notm}}.

Si vous possédez un compte mis à disposition par {{site.data.keyword.cloud_notm}} (incluant une instance dédiée),
{{site.data.keyword.cloudant_short_notm}} _ne_ collecte pas les données personnelles mentionnées précédemment. Ces données sont conservées par {{site.data.keyword.cloud_notm}}.

{{site.data.keyword.cloudant_short_notm}} traite des informations personnelles client limitées durant l'exécution du service et l'optimisation de
l'expérience utilisateur de ce dernier. {{site.data.keyword.cloudant_short_notm}} utilise la messagerie électronique pour contacter les clients au besoin. {{site.data.keyword.cloudant_short_notm}} se sert également de la surveillance des interactions client avec le tableau de bord {{site.data.keyword.cloudant_short_notm}}  pour traiter les informations personnelles.

### Restriction de traitement
{: #restriction-of-processing}

{{site.data.keyword.cloudant_short_notm}} envoie les données d'interaction avec le tableau de bord à Segment. Il est possible de demander à {{site.data.keyword.cloudant_short_notm}} de limiter le traitement des informations personnelles client de cette façon en créant une [demande de support {{site.data.keyword.cloudant_short_notm}}](mailto:support@cloudant.com). Quand cette demande est reçue, {{site.data.keyword.cloudant_short_notm}} supprime les informations associées au client telles qu'elles ont été envoyées à Segment, et empêche l'envoi d'autres données. {{site.data.keyword.cloudant_short_notm}} doit garder la possibilité de contacter les clients dédiés par courrier électronique et fournit une interface leur permettant de maintenir ces informations à jour soit directement, soit via la configuration des détails de leurs contacts {{site.data.keyword.cloud_notm}}.

## Notre base de données {{site.data.keyword.cloudant_short_notm}} est-elle chiffrée ?
{: #is-our-ibm-cloudant-database-encrypted-}

Tous les clusters comportent un système de fichiers chiffrés (chiffrement au repos) utilisant Linux Unified Key Setup (LUKS). Les données contenues dans la base de données sont visibles pour nos équipes de support et des opérations (voir ci-dessous).

Les données sensibles devant rester invisibles pour {{site.data.keyword.cloudant_short_notm}} doivent être chiffrées ou protégées (pseudonymisées) avant de nous être envoyées. Vous devez éviter d'utiliser des informations personnelles dans un `_id` de document, dans vos URL, par exemple `https://$ACCOUNT.cloudant.com/$DATABASE/$DOCUMENT_ID`,
car elles sont toujours visibles et car elles sont écrites dans les journaux d'accès.

## Emplacements des données
{: #data-locations}

Les emplacements où {{site.data.keyword.cloudant_short_notm}} traite les données personnelles seront mises à disposition
et tenues à jour via le DSA.

Pour en savoir plus sur les emplacements des données, voir le
[DSA au paragraphe 7. {{site.data.keyword.IBM_notm}} Hosting and Processing Locations ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/software/reports/compatibility/clarity-reports/report/html/softwareReqsForProduct?deliverableId=2EBB5860B34311E7A9EB066095601ABB){: new_window}.

## Sécurité des services
{: #service-security}

### Utilisation de {{site.data.keyword.cloudant_short_notm}} en toute sécurité
{: #using-ibm-cloudant-securely}

En tant qu'utilisateur de {{site.data.keyword.cloudant_short_notm}}, vous devez :

 * Utiliser la configuration CORS par défaut pour empêcher tout accès non autorisé.
 * Utiliser des clés d'API généreusement, de sorte que les composants aient des "accès avec le moindre privilège", conjointement avec le journal d'audit. Cette pratique vous permet de comprendre qui a accédé à quelles données.
 * Chiffrer ou protéger (pseudonymiser) les données sensibles qui selon vous ne doivent pas être visibles par {{site.data.keyword.cloudant_short_notm}}.

### Mesures de sécurité physique et environnementale
{: #physical-and-environmental-security-measures}

La sécurité physique des centres de données est gérée par les fournisseurs d'infrastructure : {{site.data.keyword.cloud}}, AWS et 21Vianet. Ils conservent tous des certifications auditées en externe pour leur sécurité physique. {{site.data.keyword.cloudant_short_notm}}
ne fournira pas d'autres détails sur les contrôles de sécurité physique en vigueur dans ses centres de données.

La sécurité physique des bureaux utilisés par notre personnel est gérée par {{site.data.keyword.IBM_notm}} Corporate. 
Les détails de certification et les rapports d'attestation (par exemple, ISO et SOC2) sont disponibles sur demande du client.

### Mesures techniques et organisationnelles
{: #technical-and-organisational-measures}

Des mesures techniques et organisationnelles (TOM) sont employées par {{site.data.keyword.cloudant_short_notm}} pour garantir la sécurité des données personnelles. {{site.data.keyword.cloudant_short_notm}} conserve des certifications auditées en externe pour les contrôles utilisés par {{site.data.keyword.cloudant_short_notm}}. 
Les détails de certification et les rapports d'attestation (par exemple, ISO et SOC2) sont disponibles sur demande du client.

### Accès de service aux données
{: #service-access-to-data}

L'équipe de support et des opérations {{site.data.keyword.cloudant_short_notm}} a accès aux données client et peut y accéder durant des opérations de routine. Les équipes n'accèdent aux données que si cela est nécessaire, afin d'exploiter et de prendre en charge le service. 
De plus, l'accès repose sur la *nécessité de savoir* et il est consigné, surveillé et audité.

## Suppression de données
{: #deletion-of-data}

### Suppression d'un document
{: #deleting-a-document}

Lorsqu'un document est supprimé, la base de données crée un 'tombstone'. Ce que contient le tombstone dépend de la façon dont vous le supprimez :

 - Si vous effectuez un appel `DELETE`, le tombstone inclut les zones `_id`, `_rev` et `_deleted`.
 - Si vous supprimez le document en le mettant à jour avec une zone `_deleted: true` et en exécutant une action `PUT` ou `POST` dessus, le tombstone inclut ce que vous définissez dans le corps du document. Cette pratique peut être utile dans certains cas, par exemple, lorsque vous enregistrez la raison de la suppression d'un document dans son tombstone.

Pour plus d'informations sur la suppression de tombstones, voir [Retrait simple de documents 'tombstone'](/docs/services/Cloudant?topic=cloudant-documents#tombstone-documents){: new_window}.

### A quel moment un document supprimé est-il retiré ?
{: #when-is-a-deleted-document-removed-}

La compression s'exécute automatiquement et retire régulièrement les anciennes révisions (supprimées ou non) de la base de données,
en écrivant uniquement les révisions 'feuille' dans un nouveau fichier. {{site.data.keyword.cloudant_short_notm}} conserve un historique des
`_id` et `_rev` pour activer la réplication, mais pas les anciens corps de document.

{{site.data.keyword.cloudant_short_notm}} n'expose pas l'API de compression CouchDB.
{: tip}

{{site.data.keyword.cloudant_short_notm}} ne peut pas garantir le moment précis auquel la compression d'une base de données se produira. 
La compression est effectuée en arrière-plan
sur l'ensemble du niveau de stockage et les bases de données sont toujours compressées ; simplement, il est impossible de garantir que les
données que vous venez de supprimer/modifier sont en train d'être compressées.

{{site.data.keyword.cloudant_short_notm}} accepte les demandes de *droit à l'oubli* créées par le [ {{site.data.keyword.IBM_notm}} bureau délégué à la protection des données ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](http://w3-03.ibm.com/ibm/privacy/index.html){: new_window}.
Lorsqu'une demande de *droit à l'oubli* est émise par le bureau délégué à la protection des données {{site.data.keyword.IBM_notm}}, {{site.data.keyword.cloudant_short_notm}} vérifie cette demande,
déclenche explicitement la compression de base de données et s'assure que cette opération a bien eu lieu.
A la fin de ce processus, la seule version du document qui subsiste est son tombstone (`_id`, `_rev`, `_deleted`, et les autres zones éventuellement incluses par votre application).

### Retrait de tombstones
{: #removal-of-tombstones}

{{site.data.keyword.cloudant_short_notm}} peut retirer complètement toutes les références et données d'un document si nécessaire. Cette tâche est un processus géré par un opérateur appelé purge. Avant de demander que des documents soient purgés, il est essentiel de bien comprendre que les documents purgés *ne peuvent pas être récupérés* par
{{site.data.keyword.cloudant_short_notm}} une fois le processus terminé.

La purge d'API CouchDB n'est pas prise en charge par {{site.data.keyword.cloudant_short_notm}}.
{: tip}

Dans le contexte du Règlement général sur la protection des données, la purge est requise uniquement si des informations personnelles sont utilisées dans un ID document. Il existe plein de raisons de ne pas stocker des informations personnelles dans un `_id`, mais il existe une petite poignée de cas d'utilisation plus ou moins valides (par exemple, une adresse électronique unique). Dans la mesure du possible, chiffrez ou pseudonymisez vos données afin de les rendre opaques pour {{site.data.keyword.cloudant_short_notm}}.

Si un document doit être retiré via une demande de *droit à l'oubli* :

1. Déposez une demande auprès du [{{site.data.keyword.IBM_notm}} bureau délégué à la protection des données ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](http://w3-03.ibm.com/ibm/privacy/index.html){: new_window} afin de demander qu'un `_id` de document spécifique soit purgé et indiquez le motif de cette demande.
1. A la réception d'une demande formelle émise par le bureau délégué à la protection des données (DPO) {{site.data.keyword.IBM_notm}}, l'équipe des opérations {{site.data.keyword.cloudant_short_notm}} vérifie
la demande afin de s'assurer que l'`id` contient bien des informations personnelles. {{site.data.keyword.cloudant_short_notm}} ne purge pas les données dont l'`_id` ne comporte pas d'informations personnelles. 
1. {{site.data.keyword.cloudant_short_notm}} déclenche l'action de purge afin de retirer définitivement les données demandées.

Ce processus est uniquement utilisé pour les demandes de suppression d'urgence (par exemple, pour les demandes de *droit à l'oubli*) et ne peut pas être invoqué sur le long terme. Si votre application
utilise intentionnellement des informations personnelles dans des ID de document, vous devez la modifier de sorte que ces informations personnelles soient pseudonymisées ou qu'aucune information personnelle
ne soit utilisée dans les ID de document. Vous ne pouvez pas vous en remettre régulièrement au processus de purge déclenché par
l'équipe des opérations {{site.data.keyword.cloudant_short_notm}} pour éviter cela. 
Par conséquent, {{site.data.keyword.cloudant_short_notm}} rejette les demandes de purge suivantes :

1. La demande porte sur une purge régulière, par exemple, *tous les 30 jours*.
1. La demande porte sur plus de 100 documents.

Même en ayant recours à une purge, les informations personnelles contenues dans la zone `_id` s'immiscent dans des endroits non désirés, par exemple, dans des journaux
{{site.data.keyword.cloudant_short_notm}}, par conséquent, il est préférable d'éviter cette opération. 
{{site.data.keyword.cloudant_short_notm}} a une raison métier de conserver ces journaux et ne retirera pas les lignes contenant des valeurs `_id` de document.

### Que dire de la suppression d'une base de données ?
{: #what-about-deleting-a-database-}

Lorsqu'elle est supprimée, une base de données est placée dans une corbeille pendant 48 heures maximum, puis elle est retirée du système de fichiers. L'équipe {{site.data.keyword.cloudant_short_notm}} *ne crée pas* de copies de sauvegarde de vos bases de données ;
cette tâche *incombe au client*. Vous devez vous assurer que toutes le copies de votre base de données
sont retirées de votre système. Pour plus d'informations, voir [Méthodes d'authentification{{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant?topic=cloudant-ibm-cloudant-backup-and-recovery#ibm-cloudant-backup-and-recovery){: new_window}. 

Pour obtenir de l'aide supplémentaire, contactez le
[support {{site.data.keyword.cloudant_short_notm}} ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](mailto:support@cloudant.com).

