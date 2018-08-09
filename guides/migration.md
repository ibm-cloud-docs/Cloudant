# Migrating to Cloudant on IBM Cloud
 
[Cloudant](https://www.ibm.com/cloud/cloudant)'s database-as-a-service offering on [IBM Cloud](https://www.ibm.com/cloud/) is a JSON document store running on multi-tenant clusters. The service is available at a choice of geographical locations with predictable costs, scalability and a service level agreement (SLA).

This document describes how to migrate to a Cloudant Lite or Standard plan instance on the IBM Cloud whether you are coming from:

- Cloudant Enterprise - dedicated, single-tenant clusters
- Cloudant Shared Plan - a legacy pay-as-you-go multi-tenant Cloudant service. The cloudant.com Shared plan was retired on March 2018. The Cloudant Shared plan on IBM Cloud was deprecated for new signups in October 2016 and being retired in Q4 2018.
- Cloudant Local - the self-hosted, packaged installation of Cloudant.
- Apache CouchDB - the self-hosted, open-source database on which Cloudant is based.

## What are the benefits of the Cloudant Lite and Standard plans on the IBM Cloud?

The Standard plan allows you to *reserve throughput capacity* for your database service, that is specify how much throughput your application's database is going to need to cope with demand. Capacity is measured in:

- **lookups per second** - the rate at which simple document fetches are performed e.g retrieving a document by its `_id`.
- **writes per second** - the rate at which data is written to the database. A "write" counts as API calls dealing with document creation, update or deletion.
- **queries per second** - the rate at which the database is queried, typically by accessing the `_find` endpoint or using secondary MapReduce indicies.
- **storage** - the amount of disk space occupied by your JSON data, attachments and secondary indicies.

As an example, the Lite plan offers 20 lookups/s, 10 writes/s, 5 queries/s and 1GB of storage for free. This is ideal when you are "kicking the tires" of the product and during product development. When your app goes into production, you'll need to switch to the "Standard plan", whose smallest package has 100 lookups/s, 50 writes/s, 5 queries/s and 20GB of storage (extra storage charged per GB) for $76.65 per month. 

A slider in the Cloudant dashboard allows you to reserve a smaller or greater capacity for your Cloudant service whenever you need it:

![slider](assets/img/migrate2.gif)

Note that the amount you can change the throughput capacity is limited to a maximum of 10 units per change (notice the "change limit" point on the slider), and maximum of one change change per hour. Changes downwards are unlimited in magnitude, but still subject to the time limit.

You are billed on the highest capacity selected in any given hourly window. Your database throughput can scale up to deal with seasonal demands and scale down again for the quiet times. At all times, your monthly bill is predicatable, upgrades are automatic and your SLA is [99.95%](http://www-03.ibm.com/software/sla/sladb.nsf/sla/bm-6627-03).

If you exceed your quota of lookups/writes/queries in a given second, the Cloudant cluster will respond with an `HTTP 429` response. Your application may retry the request at a later time - our official libraries offer the option of retrying such requests with an expontential back-off. 

## Which type of Cloudant plan do I have?

If you are using Cloudant on the IBM Cloud, the IBM Cloud Dashboard will show all your Cloudant instances along with a Plan column. The Lite, Standard, and Dedicated Hardware plans will be called out specifically. Any Cloudant instance that is lacking a plan name in that column will be using the deprecated Shared plan. In the example below, the 'Cloudant NoSQL DB-ix' and 'Cloudant_NewConsole' instances are on the deprecated Shared plan. 

![cloud dash](assets/img/ibmclouddashboard.png)

You can also drill into a specific instance and look at the Plan tab. Cloudant instances on the deprecated Shared plan won't have a plan highlighted. An instance on the Cloudant Standard plan will look like this: 

![standard dash](assets/img/ibmcloud_instance_standard_plan.png)

You can also open up Cloudant dashboard, click on the "Account" tab. A *Lite* plan will look like this:

![lite plan](assets/img/migrate1.png)

If you are using a legacy cloudant.com account, you can login to your Cloudant Dashboard and go to the Account tab. A legacy cloudant.com Shared plan has a Usage tab with graphs and billing estimates for the current month like below. 

![shared plan](assets/img/cloudantcom_sharedplan_usage.png)

A cloudant.com Enterprise user on a dedicated cluster will not have the Usage tab in their Account tab and will look like the following:

![enterprise plan](assets/img/cloudantcom_enterpriseplan_account.png)

If your "Account" tab already indicates that you are on the "Standard" plan, then you need not read any further - you're already on a paid SLA-backed Cloudant service and no further action is required.

## Migrating from Cloudant Lite --> Cloudant Standard

Migrating from the free Lite plan to the Standard plan is easy: simply tick the "Standard" tick box in your Cloudant service's "Plan" panel in the IBM Cloud dashboard.

![lite](assets/img/migrate3.png)

Once you click the "Upgrade" button, you will be able to adjust the "Throughput Capacity" slider as needed in your Cloudant service's dashboard. All of your existing data will be retained and you're good to go!

## Migrating everything else --> Cloudant Lite or Standard plan

Migration for Shared or Enteprise plans to Cloudant Lite or Standard plans on IBM Cloud is more involved. You need to:

- create a new Cloudant service on the IBM Cloud.
- replicate your data from the old service to the new.
- reconfigure your app to use the new service.
- switch off the old one.

Let's go through the steps:

### 1. Sign up for the IBM Cloud

If you haven't done so already, [sign up for an account on the IBM Cloud](https://www.ibm.com/cloud/). 

### 2. Create a Cloudant instance

Once inside your IBM Cloud account, add a Cloudant service to your account. 

![add Cloudant](assets/img/migrate4.png)

You'll find Cloudant in the "Databases" section of the catalog.

### 3. Is your app ready for IBM Cloud?

If you're moving from a Cloudant Enterprise service, you will need to revisit your app to make sure it's ready to deal with the capacity limits of the Standard plan.  Review the [docs](https://console.bluemix.net/docs/services/Cloudant/offerings/bluemix.html#provisioned-throughput-capacity) on how the Cloudant API works in the IBM Cloud - most importantly, you will want to make sure your application can handle a `429: too many requests` HTTP response if you should exceed your provisioned throughput capacity. 

Retrying requests that get a `429` response is ok for occasional traffic spikes that exceed your plan's capacity. If your app traffic is routinely generating `429` responses, there's a good chance you need to upgrade to a bigger plan.

Additionally, it's worth noting that the maximum individual document size is 1MB on IBM Cloud and you will receive a `413: request entity too large` if it is exceeded. Review the [docs](https://console.bluemix.net/docs/services/Cloudant/offerings/bluemix.html#request-and-document-size-limits) on Cloudant request and document size limits on the IBM Cloud. 

### 4. Migrate data from the old service to the new

Set up continuous replications from your existing service to your IBM Cloud account. See the replication [guide](https://console.bluemix.net/docs/services/Cloudant/guides/replication_guide.html#replication) and [API docs](https://console.bluemix.net/docs/services/Cloudant/api/replication.html#replication) on how to setup and monitor replication tasks.

Alternatively, check out the [couchreplicate](https://www.npmjs.com/package/couchreplicate) tool which is a command-line utility that helps you coordinate the transfer of data from one Cloudant account to another. It sets up multiple replication jobs between the source and target accounts, ensuring that only so many replication jobs proceed at any one time. If you need to migrate hundreds of databases then *couchreplicate* can help coordinate the replication jobs.

![couchreplicate](https://raw.githubusercontent.com/glynnbird/couchreplicate/HEAD/img/couchreplicate.gif)

Make sure all the data has replicated over and indexes have been built.

### 5. Testing

Make sure to conduct load and functional testing on your application to ensure there are no issues before migrating your production functionality.

### 6. Switch over

When ready to switch over, update your application with the new auto-generated account URL and credentials for the IBM Cloud instance. See the [provisioning tutorial](https://console.bluemix.net/docs/services/Cloudant/tutorials/create_service.html#creating-a-cloudant-instance-on-bluemix) for how to obtain the service credentials of an IBM Cloud instance.

### 7. Switch off the old service

 When your application is fully onboarded to the Cloudant instance in the IBM Cloud, contact Cloudant Support to inform us you won't be needing your old Cloudant account any longer so you won't be charged. We ask that customers delete all the data themselves prior to the Cloudant team deleting the account.

## FAQ

## Can I backup my data before doing anything?

IBM Cloudant recommends using the [couchbackup](https://console.bluemix.net/docs/services/Cloudant/guides/backup-cookbook.html#cloudant-nosql-db-backup-and-recovery) utility to export data to disk. [IBM Cloud Object Storage](https://www.ibm.com/cloud/object-storage) is a cheap and scalable solution for storing the resultant files. 

## Can I keep my username.cloudant.com domain and redirect it to the new service on the IBM Cloud?

No, this is not possible so users should plan to update their applications to use the new account URL and credentials that are generated on the Cloudant instances on th IBM Cloud.

## Who do I contact if I have any questions?

Contact [support@cloudant.com](mailto:support@cloudant.com) or open a ticket from within the Cloudant Dashboard if you have any questions about the migration, and we'll be pleased to give more details.