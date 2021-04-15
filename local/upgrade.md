---

copyright:
  years: 2015, 2021
lastupdated: "2021-04-19"

keywords: upgrade, database node, load balancer node, cluster

subcollection: Cloudant

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
{:external: target="_blank" .external}

<!-- Acrolinx: 2021-04-19 -->

# Upgrade
{: #upgrade}

Complete the {{site.data.keyword.IBM}} Cloudant&reg; Data Layer Local Edition upgrade on each node independently.
{: shortdesc}

Select one of the following upgrade paths.

1.  [Upgrading {{site.data.keyword.cloudant_local_notm}}](#upgrading-cloudant-local).
2.  [Upgrading to a new cluster](#upgrading-to-a-new-cluster).

## Upgrading {{site.data.keyword.cloudant_local_notm}}
{: #upgrading-cloudant-local}

To upgrade {{site.data.keyword.cloudant_local_notm}}, complete the upgrade process on one
node at time until all the nodes of the cluster are upgraded. The
upgrade must be done when the cluster is offline to all
production traffic.

Since {{site.data.keyword.cloudant_local_notm}} draws upstream source code from CouchDB,
along with bug fixes and enhancements, it inherits commits that
can introduce runtime incompatibilities between different
released versions. Therefore, if your database nodes run code
from different releases concurrently, it is not always possible
to ensure that your cluster remains fully functional. To preserve
your production environment, perform an in-place upgrade to the
entire cluster during maintenance.

{{site.data.keyword.cloudant_local_notm}} does not support upgrades to online or live environments.
{: important}

For more information, see the steps to upgrade here, [Overview for upgrading a database
node and a load balancer node](#overview-for-upgrading-a-database-node-and-a-load-balancer-node).

## Upgrading to a new cluster
{: #upgrading-to-a-new-cluster}

When you upgrade to a new cluster, you provision new servers and
install the new release on the {{site.data.keyword.cloudant_local_notm}} cluster. Now, you
can replicate the data from the existing live cluster and start
by using the new cluster and following these steps.

1.  Build a new cluster.
2.  Install the most recent {{site.data.keyword.cloudant_local_notm}} software on that
    cluster.
3.  Replicate data from the existing cluster to the new cluster.

After you replicate and synchronize both clusters, you can switch
your application to use the new cluster. By upgrading to a new cluster, you avoid downtime that can be
prohibitive if the necessary downtime is unacceptable. You might
also use this time to upgrade the operating system for the new
server, add new hardware, or add more nodes to the cluster.

Regardless of the approach you choose, it is recommended that you
test your workloads on a cluster with the upgraded release.

## Overview for upgrading a database node and a load balancer node
{: #overview-for-upgrading-a-database-node-and-a-load-balancer-node}

Follow these steps to upgrade from {{site.data.keyword.cloudant_local_notm}} version
1.0.0.5 installation to {{site.data.keyword.cloudant_local_notm}} version 1.1.0.

After the upgrade is complete, you cannot roll back to an older version.
{: important}

You can upgrade only one node at a time, which can eliminate
downtime. Upgrading a node is similar to replacing a node in a
cluster.

Follow the basic upgrade steps for a database node.

1.  Put the database node that you want to upgrade in maintenance
    mode.

2.  Uninstall the existing {{site.data.keyword.cloudant_local_notm}} version binary files.

3.  Install the new {{site.data.keyword.cloudant_local_notm}} packages.

4.  Start the upgraded node in maintenance mode.

5.  Check the status of the node.

6.  Bring the node out of maintenance mode.

Follow the basic upgrade steps for a load balancer node.

1.  Confirm that load balancer failover operates correctly if one
    load balancer node is being upgraded.

2.  Uninstall the existing {{site.data.keyword.cloudant_local_notm}} version binary files.

3.  Install the new {{site.data.keyword.cloudant_local_notm}} packages and start the upgraded
    node.

4.  Check the status of the node and confirm that traffic is being
    serviced through the upgraded node.

## Upgrading a database node
{: #upgrading-to-a-database-node}

Follow these steps to upgrade each {{site.data.keyword.cloudant_local_notm}} database node.

1. Put the database node in maintenance mode.

   a. From the `/opt/cloudant` directory, put the database node in maintenance mode by running the command.

   ```sh
   cast node maintenance --true
   ```
   {: codeblock}

   b. Verify that the database node is in maintenance mode: `curl localhost:5984/_up`. 

   You see this response.
   ```sh
   {"status":"maintenance_mode"}
   ```
   {: codeblock}

   c. Verify that this node is not available for traffic from your load balancer URL.
   ```http
   https://load_balancer/_haproxy
   ```
   {: codeblock}

   The node status must be stopped for maintenance.

2. Uninstall the existing {{site.data.keyword.cloudant_local_notm}} version binary files.

   a. Uninstall the current version by running the command.

      ```sh
      cast system uninstall
      ```
      {: codeblock}

      This command also stops the services.
      
   b. Run the InstallShield uninstall command.

      ```sh
      /root/cloudant/uninstall/uninstall.bin
      ```
      {: codeblock}

   c. Check for {{site.data.keyword.cloudant_local_notm}} processes.

      ```sh
      ps -ef | grep clo
      ```
      {: codeblock}

   d. Stop any {{site.data.keyword.cloudant_local_notm}} processes that are running.

      ```sh
      kill -9 (pid)
      ```
      {: codeblock}

3. Install the database node by using the steps in [Installing the first database node](/docs/Cloudant?topic=Cloudant-install-ibm-cloudant-local#installing-the-first-database-node).

   Ensure that when you run the `cast system install` command you start the node with a maintenance mode flag and pass the current cluster configuration to your `dbnode.yaml` file.
   {: note}
   
   a. Find the current values of database node cluster credentials and IDs from the `local.ini`, `vm.args`, and `default.ini` files on other nodes or from the backup directories, such as `/opt/cloudant/etc.bak`.

   b. Configure these values as-is in the `dbnode.yaml` file. Use encrypted or hashed values for fields `admin`, `cloudant`, `httpd_auth`, and `cookie`. Leave the `uuid` and `monitor_role` values as `open_ssl`.
   
   c. After you configure the `dbnode.yaml` file, you can distribute and use it for other database node upgrades. For example, you can get a sample of `dbnode.yaml` from `/opt/cloudant/cast/samples/dbnode.yaml` and run the following command.

   ```sh
   cast system install --maintenance -db -c /<path_to>/dbnode.yaml
   ```
   {: codeblock}

4. Check status of the database node update.

   a. Verify the status of the database node.

      ```sh
      curl -X GET http://localhost:5984
      ```
      {: codeblock}

      The response shows the new version.
      
      ```sh
      {
            "couchdb": "Welcome",
            "version": "2.0.0",
            "vendor": {
                "name": "IBM Cloudant",
                "version": "1.1.0",
                "variant": "local"
            },
            "features": [
                "geo"
            ]
        }
        ```
        {: codeblock}

   b. Verify that the database node is in maintenance mode and is not receiving traffic on the load balancer.

   ```sh
   cast node maintenance
   ```
   {: codeblock}
       
   The response shows the status of the node.

   ```sh
   The node is IN maintenance mode.
   ```

   c. Verify the status of the upgraded node as a member of the cluster.

   ```sh
   cast cluster status
   ```
   {: codeblock}
        
   The response lists all the cluster nodes.

   d. Check the health of the database node by using the Weather report application, [Monitor cluster health with Weather report](/docs/Cloudant?topic=Cloudant-diagnose-troubleshoot#monitor-cluster-health-with-weatherreport).

5. Bring the database node out of maintenance mode and check its availability.

   a. Run the following command to bring the database node out of maintenance mode.

   ```sh
   cast node maintenance --false
   ```
   {: codeblock}

   The response shows the status of the node.
   ```sh
   The node is OUT of maintenance mode.
   ```

   b. Verify that the database node is up and available for traffic from your load balancer.

   ```http
   https://load_balancer/_haproxy
   ```
   {: codeblock}

   If the upgrade was successful, the response shows that the node is up and available.

## Upgrading a load balancer node
{: #upgrading-a-load-balancer-node}

Upgrade each {{site.data.keyword.cloudant_local_notm}} load balancer node by following
these steps.

1. Verify that the load balancer failover works correctly when one load balancer (in a cluster of two or more load balancers) is taken offline during an upgrade.

2. Uninstall the current version by running the command.

   ```sh
   cast system uninstall
   ```
   {: codeblock}

   This command also stops the services.
3. Run the InstallShield `uninstall` command.

   ```sh
   /root/cloudant/uninstall/uninstall.bin
   ```
   {: codeblock}

4. Install the new {{site.data.keyword.cloudant_local_notm}} packages and start the upgraded node, [Installing load balancer nodes](/docs/Cloudant?topic=Cloudant-install-ibm-cloudant-local#installing-load-balancer-nodes).

   a. Find the load balancer node's current credentials, cluster nodes, host name, and IP addresses in the current version of the `/etc/haproxy/haproxy.cfg` file.

   b. Configure the values in the `lbnode.yaml` file.

   You can get a sample from `/opt/cloudant/cast/samples/lbnode.yaml` file, and run the following command to install and pass the configuration.

   ```sh
   cast system install -lb -c /&lt;path_to&gt;/lbnode.yaml
   ```
   {: codeblock}
      
5. Verify that the load balancer is reachable through its URL and that all cluster nodes are listed and available to receive traffic by using this URL:  

   ```http
   https://upgrade_node_load_balancer/_haproxy
   ```
   {: codeblock}
   

