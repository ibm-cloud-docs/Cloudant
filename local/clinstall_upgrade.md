---

copyright:
  years: 2015, 2017
lastupdated: "2017-02-20"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# Upgrade

Complete the Cloudant&reg; Local upgrade on each node independently.
{:shortdesc}

Select one of the following upgrade paths.

1.  [Upgrading to Cloudant Local](#upgrading-to-cloudant-local).
2.  [Upgrade to a new cluster](#upgrade-to-a-new-cluster).

## Upgrading to Cloudant Local

To upgrade Cloudant Local, complete the upgrade process on one
node at time until all the nodes of the cluster are upgraded. The
upgrade must be done when the cluster is offline to all
production traffic.

Since Cloudant Local draws upstream source code from CouchDB,
along with bug fixes and enhancements, it inherits commits that
can introduce runtime incompatibilities between different
released versions. Therefore, if your database nodes run code
from different releases concurrently, it is not always possible
to ensure that your cluster remains fully functional. To preserve
your production environment, perform an in-place upgrade to the
entire cluster during maintenance.

>   **Note:** Cloudant Local does not support upgrades to online or live environments.

See the steps to upgrade here, [Overview for upgrading a database
node and a load balancer node](#overview-for-upgrading-a-database-node-and-a-load-balancer-node).

## Upgrading to a new cluster

When you upgrade to a new cluster, you provision new servers and
install the new release to the Cloudant Local cluster. Now, you
can replicate the data from the existing live cluster and start
by using the new cluster by following these steps.

1.  Build a new cluster.
2.  Install the most recent Cloudant Local software on that
    cluster.
3.  Replicate data from the existing cluster to the new cluster.

After you replicate and synchronize both clusters, you can switch
your application to use the new cluster.

By upgrading to a new cluster, you avoid downtime that can be
prohibitive if the necessary downtime is unacceptable. You might
also use this time to upgrade the operating system for the new
server, add new hardware, or add more nodes to the cluster.

Regardless of the approach you choose, it is recommended that you
test your workloads on a cluster with the upgraded release.

## Overview for upgrading a database node and a load balancer node

Follow these steps to upgrade from a Cloudant Local version
1.0.0.5 installation to Cloudant Local version 1.1.0.

>   **Note:** After the upgrade is complete, you cannot roll back to an older version.

You can upgrade only one node at a time, which can eliminate
downtime. Upgrading a node is similar to replacing a node to a
cluster.

Follow the basic upgrade steps for a database node.

1.  Put the database node that you want to upgrade in maintenance
    mode.

2.  Uninstall the existing Cloudant Local version binaries.

3.  Install the new Cloudant Local packages.

4.  Start the upgraded node in maintenance mode.

5.  Check the status of the node.

6.  Bring the node out of maintenance mode.

Follow the basic upgrade steps for a load balancer node.

1.  Confirm that load balancer failover operates correctly if one
    load balancer node is being upgraded.

2.  Uninstall the existing Cloudant Local version binaries.

3.  Install the new Cloudant Local packages and start the upgraded
    node.

4.  Check the status of the node and confirm that traffic is being
    serviced through the upgraded node.

## Upgrading a database node

Follow these steps to upgrade each Cloudant&reg; Local database node.
{:shortdesc}

<ol>
<li>Put the database node in maintenance mode.
<ol type=a>
<li>From the `/opt/cloudant` directory, put the database node
        in maintenance mode by running the command.
        <p>`cast node maintenance --true`</p></li>
<li>Verify that the database node is in maintenance mode: `curl localhost:5984/_up`.
<p>You see this response.</p>
<p>`{"status":"maintenance_mode"}`</p></li>
<li>Verify that this node is not available for traffic from
        your load balancer URL.
        <p>`http://load_balancer/_haproxy`</p>
<p>The node status must be stopped for maintenance.</p></li>
</ol>
</li>
<li>Uninstall the existing Cloudant Local version binary files.
<ol type=a>
<li>Uninstall the current version by running the command.
<p>`cast system uninstall`</p>
<p>This command also stops the services.</p></li>
<li>Run the InstallShield uninstall command.
<p>`/root/cloudant/uninstall/uninstall.bin`</p></li>
<li>Check for Cloudant processes.
<p>`ps -ef | grep clo`</p></li>
<li>Stop any Cloudant processes that are running.
<p>`kill -9 (pid)`</p></li>
</ol>
</li>
<li>Install the database node by using the steps in [Installing the
    first database node](clinstall_install_first_db_node.html).

<p>**Note:** Ensure that when you run the `cast system install` command you start the node with a maintenance mode flag and pass the current cluster configuration to your `dbnode.yaml` file.</p>
<ol type=a>
<li>Find the current values of database node cluster
        credentials and IDs from the `local.ini`, `vm.args`, and
        `default.ini` files on other nodes or from the backed-up
        directories, such as `/opt/cloudant/etc.bak`.</li>
<li>Configure these values as-is in the `dbnode.yaml` file.
<p>Use encrypted or hashed values for fields `admin`,
        `cloudant`, `httpd_auth` and `cookie`. Leave the `uuid` and
        `monitor_role` values as `open_ssl`.</p>
</li>
<li>After you configure the `dbnode.yaml` file, you can
        distribute and use it for other database node upgrades.
<p>For example, you can get a sample of `dbnode.yaml` from
        `/opt/cloudant/cast/samples/dbnode.yaml` and run the
        following command.</p>
<p>`cast system install --maintenance -db -c /{path_to}/dbnode.yaml`</p>
</li>
</ol>  
</li>
<li>Check status of the database node update.
<ol type=a>
<li>Verify the status of the database node.

<p>`curl -X GET http://localhost:5984`</p>
<p>The response shows the new version.</p>

<p>        `{`<br>
            `"couchdb": "Welcome",`<br>
            `"version": "2.0.0",`<br>
            `"vendor": {`<br>
                `"name": "IBM Cloudant",`<br>
                `"version": "1.1.0",`<br>
                `"variant": "local"`<br>
            `},`<br>
            `"features": [`<br>
                `"geo"`<br>
            `]`<br>
        `}`</li>
<li>Verify that the database node is in maintenance mode and
        is not receiving traffic on the load balancer.
<p>`cast node maintenance`</p>
<p>The response shows the status of the node.</p>
<p>`The node is IN maintenance mode.`</p></li>
<li>Verify the status of the upgraded node as a member of the
        cluster.
<p>`cast cluster status`</p>
<p>The response lists all the cluster nodes.</p></li>
<li>Check the health of the database node by using the
        Weatherreport application, [Monitor cluster health with
        Weatherreport](clinstall_checking_health_cluster_with_weatherreport.html).</li>
</ol>
</li>
<li>Bring the database node out of maintenance mode and check its
    availability.
<ol type=a>
<li>Run the following command to bring the database node out
        of maintenance mode.
<p>`cast node maintenance --false`</p>
<p>The response shows the status of the node.</p>
<p>`The node is OUT of maintenance mode.`</p>
        </li>
<li>Verify that the database node is up and available for
        traffic from your load balancer.
<p>`http://{load_balancer}/_haproxy`</p>
<p>If the upgrade was successful, the response shows that
        the node is up and available.</p></li>
</ol>
</li>
</ol>

## Upgrading a load balancer node

Upgrade each Cloudant&reg; Local load balancer node by following
these steps.
{:shortdesc}

<ol>
<li>Verify that the load balancer failover works correctly when
    one of two or more load balancers are taken offline during an
    upgrade.</li>
<li>Uninstall the current version by running the command.
<p>`cast system uninstall`</p>
<p>This command also stops the services.</p></li>
<li>Run the InstallShield `uninstall` command.
<p>`/root/cloudant/uninstall/uninstall.bin`</p></li>
<li>Install the new Cloudant Local packages and start the upgraded
    node, [Installing load balancer nodes](clinstall_install_load_balancer_nodes.html).
<ol type=a>
<li>Find the load balancer node's current credentials,
        cluster nodes, host name, and IP addresses in the current
        version of the `/etc/haproxy/haproxy.cfg` file.
</li>
<li>Configure the values in the `lbnode.yaml` file.

<p>You can get a sample from
        `/opt/cloudant/cast/samples/lbnode.yaml` file, and run the
        following command to install and pass the configuration.</p>
<p>`cast system install -lb -c /{path_to}/lbnode.yaml`</p></li>
</ol>
</li>
<li>Verify that the load balancer is reachable through its URL and
    that all cluster nodes are listed and available to receive
    traffic by using this URL:  
<p>`http://{upgrade node load balancer}/_haproxy`</p></li>
</ol>
