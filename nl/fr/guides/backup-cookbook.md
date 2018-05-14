---

copyright:
  years: 2017
lastupdated: "2017-07-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-05-23 -->

# Sauvegarde et reprise Cloudant

Le présent manuel d'instructions fait partie du [guide de reprise après incident {{site.data.keyword.cloudantfull}}](disaster-recovery-and-backup.html).
Cela vaut vraiment la peine de commencer par la lecture de celui-ci si vous n'êtes pas familier du sujet et que vous souhaitez comprendre comment fonctionne la sauvegarde avec d'autres fonctionnalités offertes par {{site.data.keyword.cloudant_short_notm}} pour répondre aux exigences de reprise après incident et de haute disponibilité.

Bien que les données soient stockées de manière redondante dans un cluster {{site.data.keyword.cloudant_short_notm}}, il est important d'envisager des mesures de sauvegarde supplémentaires.
Par exemple, le stockage redondant de données ne protège pas contre les risques d'erreur lorsque des données sont modifiées.

## Introduction à CouchBackup

{{site.data.keyword.cloudant_short_notm}} fournit un outil pris en charge de sauvegarde et de restauration par image instantanée, à savoir CouchBackup, un outil open source.
Celui-ci contient une bibliothèque `node.js` qui est [disponible pour être installée sur npm ![External link icon](../images/launch-glyph.svg "External link icon")][npmpackage]{:new_window}.

Outre la bibliothèque, le package CouchBackup contient deux outils de ligne de commande :

1. `couchbackup`, qui vide les données JSON d'une base de données vers un fichier texte de sauvegarde.
2. `couchrestore`, qui restaure les données d'un fichier texte de sauvegarde vers une base de données.

<strong style="color:red;">Avertissement</strong> : Les outils CouchBackup présentent certaines [limites](#limitations).

## Sauvegarde de vos données Cloudant

Vous pouvez procéder à une simple sauvegarde à l'aide de l'outil `couchbackup`.
Pour sauvegarder la base de données `animaldb` vers un fichier texte appelé `backup.txt`, utilisez une commande similaire à l'exemple suivant :

```sh
couchbackup --url https://examples.cloudant.com --db animaldb > backup.txt
```
{:codeblock}

Le fichier [npm readme ![External link icon](../images/launch-glyph.svg "External link icon")][npmreadme]{:new_window} contient des informations sur d'autres options, telles que :

* Les variables d'environnement permettant de définir le nom de la base de données et son adresse URL.
* L'utilisation d'un fichier journal permettant d'enregistrer la progression d'une sauvegarde.
* La possibilité de reprendre une sauvegarde interrompue.
  **Remarque** : Cette option est disponible uniquement avec le fichier journal associé à la sauvegarde interrompue.
* L'envoi d'un fichier texte de sauvegarde vers un fichier de sortie spécifique, au lieu de réacheminer la sortie `stdout`.

<strong style="color:red;">Avertissement</strong> : Les outils CouchBackup présentent certaines [limites](#limitations).

## Restauration de vos données Cloudant

Pour restaurer vos données, utilisez l'outil `couchrestore`.
Exécutez `couchrestore` pour importer le fichier de sauvegarde dans une nouvelle base de données {{site.data.keyword.cloudant_short_notm}}.
Assurez-vous ensuite d'avoir créé tous les index avant qu'une application ne tente d'utiliser les données restaurées.

Par exemple, pour restaurer les données qui ont été sauvegardées dans l'exemple ci-dessus :

```sh
couchrestore --url https://myaccount.cloudant.com --db newanimaldb < backup.txt
```
{:codeblock}

Le [fichier readme npm ![External link icon](../images/launch-glyph.svg "External link icon")][npmreadme]{:new_window} fournit des détails sur d'autres options de restauration.

<strong style="color:red;">Avertissement</strong> : Les outils CouchBackup présentent certaines [limites](#limitations).

## Limites

<strong style="color:red;">Avertissement</strong> : Les limites des outils CouchBackup sont les suivantes : 

* Les paramètres `_security` ne sont pas sauvegardés par les outils.
* Les pièces jointes ne sont pas sauvegardées par les outils.
* Les sauvegardes ne sont pas vraiment des instantanés à un "moment donné".
  La raison en est que les documents présents dans la base de données sont extraits par lots, mais que d'autres applications peuvent être en train de mettre à jour des documents au même moment.
  Par conséquent, les données de la base de données peuvent varier entre la lecture du premier lot et celle du dernier lot.
* Les définitions d'index conservées dans les documents de conception sont sauvegardées, mais le contenu des index n'est pas sauvegardé.
  Cette limitation signifie que lorsque les données sont restaurées, les index doivent être régénérés.
  La régénération peut prendre énormément de temps en fonction du volume de données restaurées.

## Utilisation des outils

La [page npm ![External link icon](../images/launch-glyph.svg "External link icon")][npmpackage]{:new_window} fournit des informations détaillées sur les bases de l'utilisation des outils de ligne de commande destinés à la sauvegarde et la restauration de données.
Les exemples suivants illustrent les modalités de mise en pratique en décrivant l'utilisation des outils pour des tâches spécifiques.

Le package CouchBackup fournit deux façons d'utiliser ses fonctions principales.

* Les outils de ligne de commande peuvent être intégrés dans les pipelines de commandes UNIX standard.
  Pour de nombreux scénarios, l'utilisation combinée de la tâche `cron` et d'un simple script shell de l'application `couchbackup` suffit.
* Bibliothèque utilisable à partir de node.js.
  La bibliothèque permet de créer et de déployer des processus de sauvegarde beaucoup plus complexes, tels que l'identification dynamique des bases de données à sauvegarder.

Utilisez soit l'outil de sauvegarde de ligne de commande, soit la bibliothèque avec le code de l'application, pour activer la sauvegarde depuis les bases de données {{site.data.keyword.cloudant_short_notm}} dans les situations plus complexes.
Un scénario utile permet de planifier les sauvegardes à l'aide de la tâche `cron`, et de télécharger automatiquement les données vers [Cloud Object Storage ![External link icon](../images/launch-glyph.svg "External link icon")](http://www-03.ibm.com/software/products/en/object-storage-public){:new_window} à des fins de conservation à long terme.

## Exemples de scripts en ligne de commande

Deux exigences sont souvent rencontrées :

* Economiser de l'espace disque en ['compressant' le fichier de sauvegarde](#zipping-a-backup-file) lors de sa création.
* Créer une sauvegarde de base de données automatique, [à intervalles réguliers](#hourly-or-daily-backups-using-cron).

### Compression d'un fichier de sauvegarde

L'outil `couchbackup` peut écrire un fichier de sauvegarde directement sur le disque ou transférer la sauvegarde vers `stdout`.
Le transfert vers `stdout` permet de transformer les données avant de les écrire sur le disque.
Cette opération est utilisée pour compresser les données dans le flux. 

```sh
couchbackup --url "https://examples.cloudant.com" \
  --db "animaldb" | gzip > backup.gz
```
{:codeblock}

Dans cet exemple, l'outil `gzip` accepte les données de sauvegarde directement via `stdin`, les compresse puis les diffuse via `stdout`.
Le flux de données compressées est ensuite redirigé et écrit dans un fichier `backup.gz`.

Si la base de données vous demande de fournir les données d'identification d'accès, entrez une URL au format `https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com`, par exemple :

```sh
couchbackup --url "https://$USERNAME:$PASSWORD@examples.cloudant.com" \
  --db "animaldb" | gzip > backup.gz
```
{:codeblock}

Il est relativement simple d'étendre le pipeline si vous souhaitez transformer les données d'une autre manière.
Par exemple, vous pouvez choisir de chiffrer les données avant qu'elles ne soient écrites sur le disque.
Vous pouvez également vouloir écrire les données directement vers un service de conteneur d'objets, à l'aide des outils de ligne de commande.

### Sauvegardes horaires ou quotidiennes utilisant `cron`

L'outil de planification `cron` peut être configuré de manière à prendre une image instantanée des données à intervalles réguliers.

Un point de départ utile est d'obtenir `couchbackup` pour écrire une sauvegarde unique dans un fichier, dont le nom indique la date et l'heure actuelles, tel qu'illustré dans l'exemple suivant :

```sh
couchbackup --url "https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com" \
  --db "animaldb" > animaldb-backup-`date -u "+%Y-%m-%dT%H:%M:%SZ"`.bak
```
{:codeblock}

Après avoir vérifié le bon fonctionnement de la commande, vous pouvez la saisir dans un "travail cron" :

1.  Installez les outils CouchBackup sur le serveur utilisé pour les sauvegardes.
2.  Créez un dossier dans lequel stocker les sauvegardes.
3.  Créez une "entrée cron" indiquant la fréquence des sauvegardes.

Vous pouvez créer une entrée cron par l'intermédiaire de la commande `crontab -e`.
Consultez votre documentation système pour en savoir plus sur les options "cron".

Une entrée cron chargée de la sauvegarde quotidienne est similaire à l'exemple suivant :

```sh
0 5 * * * couchbackup --url "https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com" --db "animaldb" > /path/to/folder/animaldb-backup-`date -u "+%Y-%m-%dT%H:%M:%SZ"`.bak
```
{:codeblock}

Cette entrée cron crée une sauvegarde quotidienne à 05:00.
Vous pouvez modifier le modèle cron de manière à effectuer des sauvegardes horaires, quotidiennes, hebdomadaires ou mensuelles, selon vos besoins.

## Utilisation de CouchBackup en tant que bibliothèque

Les outils de ligne de commande `couchbackup` et `couchrestore` sont des encapsuleurs placés autour d'une bibliothèque qui peuvent être utilisés dans vos propres applications node.js.

La bibliothèque est très utile pour les scénarios plus complexes, par exemple :

* Sauvegarde de plusieurs bases de données en une seule tâche.
  Vous pouvez effectuer cette sauvegarde en identifiant l'ensemble des bases de données à l'aide de l'appel [`_all_dbs`](../api/database.html#get-databases), puis en sauvegardant individuellement chaque base de données.
* Les pipelines plus longs augmentent le risque d'erreur.
  En utilisant la bibliothèque CouchBackup, votre application peut détecter et corriger les erreurs dans les plus brefs délais.

Pour plus d'informations, consultez la [page npm ![External link icon](../images/launch-glyph.svg "External link icon")][npmpackage]{:new_window}.

L'exemple de script ci-dessous décrit comment combiner la bibliothèque `couchbackup` à une utilisation d'{{site.data.keyword.IBM}} Cloud Object Storage.
Ce code explique l'utilisation de l'interface de programmation Cross Region S3 à des fins de sauvegarde d'une base de données dans un conteneur d'objets.

> **Remarque** : L'une des conditions préalables à l'utilisation de ce code est l'initialisation de l'objet client S3 pour {{site.data.keyword.IBM_notm}} Cloud Object Storage en suivant
[ces instructions ![External link icon](../images/launch-glyph.svg "External link icon")][cosclient]{:new_window}.

```javascript
/*
  Backup directly from Cloudant to an S3 bucket via a stream.
  @param {string} couchHost - URL of database root
  @param {string} couchDatabase - backup source database
  @param {object} s3Client - S3 client object
  @param {string} s3Bucket - Destination S3 bucket (must exist)
  @param {string} s3Key - Destination object's key (shouldn't exist)
  @param {boolean} shallow - Whether to use couchbackup's shallow mode
  @returns {Promise}
*/
function backupToS3(sourceUrl, s3Client, s3Bucket, s3Key, shallow) {
  return new Promise((resolve, reject) => {
    debug('Setting up S3 upload to ${s3Bucket}/${s3Key}');

    // A pass through stream that has couchbackup's output
    // written to it and it then read by the S3 upload client.
    // It has a 10MB internal buffer.
    const streamToUpload = new stream.PassThrough({highWaterMark: 10485760});

    // Set up S3 upload.
    const params = {
      Bucket: s3Bucket,
      Key: s3Key,
      Body: streamToUpload
    };
    s3Client.upload(params, function(err, data) {
      debug('S3 upload done');
      if (err) {
        debug(err);
        reject(new Error('S3 upload failed'));
        return;
      }
      debug('S3 upload succeeded');
      debug(data);
      resolve();
    }).httpUploadProgress = (progress) => {
      debug('S3 upload progress: ${progress}');
    };

    debug('Starting streaming data from ${sourceUrl}');
    couchbackup.backup(
      sourceUrl,
      streamToUpload,
      (err, obj) => {
        if (err) {
          debug(err);
          reject(new Error('CouchBackup failed with an error'));
          return;
        }
        debug('Download from ${sourceUrl} complete.');
        streamToUpload.end();  // must call end() to complete S3 upload.
        // resolve() is called by the S3 upload
      }
    );
  });
}
```
{:codeblock}

## Autres options de reprise après incident

Revenez au [guide de reprise après incident {{site.data.keyword.cloudant_short_notm}}](disaster-recovery-and-backup.html) pour en savoir plus sur les autres configurations complètes de reprise après incident offertes par {{site.data.keyword.cloudant_short_notm}}.

[npmpackage]: https://www.npmjs.com/package/@cloudant/couchbackup
[npmreadme]: https://github.com/cloudant/couchbackup/blob/master/README.md
[cosclient]: https://developer.ibm.com/recipes/tutorials/cloud-object-storage-s3-api-intro/
