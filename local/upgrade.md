---

copyright:
  years: 2015, 2019
lastupdated: "2019-08-26"

keywords: upgrade, database node, load balancer node, cluster

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
{:external: target="_blank" .external}

<!-- Acrolinx: 2017-05-10 -->

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
using the new cluster by following these steps.

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

2.  Uninstall the existing {{site.data.keyword.cloudant_local_notm}} version binaries.

3.  Install the new {{site.data.keyword.cloudant_local_notm}} packages.

4.  Start the upgraded node in maintenance mode.

5.  Check the status of the node.

6.  Bring the node out of maintenance mode.

Follow the basic upgrade steps for a load balancer node.

1.  Confirm that load balancer failover operates correctly if one
    load balancer node is being upgraded.

2.  Uninstall the existing {{site.data.keyword.cloudant_local_notm}} version binaries.

3.  Install the new {{site.data.keyword.cloudant_local_notm}} packages and start the upgraded
    node.

4.  Check the status of the node and confirm that traffic is being
    serviced through the upgraded node.

## Upgrading a database node
{: #upgrading-to-a-database-node}

Follow these steps to upgrade each {{site.data.keyword.cloudant_local_notm}} database node.

<ol>
<li>Put the database node in maintenance mode.
<ol type=a>
<li>From the <code>/opt/cloudant</code> directory, put the database node
        in maintenance mode by running the command.
        <p><code>cast node maintenance --true</code></p></li>
<li>Verify that the database node is in maintenance mode: <code>curl localhost:5984/_up</code>.
<p>You see this response.</p>
<p><code>{"status":"maintenance_mode"}</code></p></li>
<li>Verify that this node is not available for traffic from
        your load balancer URL.
        <p><code>https://&lt;load_balancer&gt;/_haproxy</code></p>
<p>The node status must be stopped for maintenance.</p></li>
</ol>
</li>
<li>Uninstall the existing {{site.data.keyword.cloudant_local_notm}} version binary files.
<ol type=a>
<li>Uninstall the current version by running the command.
<p><code>cast system uninstall</code></p>
<p>This command also stops the services.</p></li>
<li>Run the InstallShield uninstall command.
<p><code>/root/cloudant/uninstall/uninstall.bin</code></p></li>
<li>Check for Cloudant processes.
<p><code>ps -ef | grep clo</code></p></li>
<li>Stop any Cloudant processes that are running.
<p><code>kill -9 (pid)</code></p></li>
</ol>
</li>
<li>Install the database node by using the steps in [Installing the first database node](/docs/services/Cloudant?topic=cloudant-install-ibm-cloudant-local#installing-the-first-database-node).

<p><strong>Note</strong>: Ensure that when you run the <code>cast system install</code> command you start the node with a maintenance mode flag and pass the current cluster configuration to your <code>dbnode.yaml</code> file.</p>
<ol type=a>
<li>Find the current values of database node cluster
        credentials and IDs from the <code>local.ini</code>, <code>vm.args</code>, and
        <code>default.ini</code> files on other nodes or from the backup
        directories, such as <code>/opt/cloudant/etc.bak</code>.</li>
<li>Configure these values as-is in the <code>dbnode.yaml</code> file.
<p>Use encrypted or hashed values for fields <code>admin</code>,
        <code>cloudant</code>, <code>httpd_auth</code> and <code>cookie</code>. Leave the <code>uuid</code> and
        <code>monitor_role</code> values as <code>open_ssl</code>.</p>
</li>
<li>After you configure the <code>dbnode.yaml</code> file, you can
        distribute and use it for other database node upgrades.
<p>For example, you can get a sample of <code>dbnode.yaml</code> from
        <code>/opt/cloudant/cast/samples/dbnode.yaml</code> and run the
        following command.</p>
<p><code>cast system install --maintenance -db -c /&lt;path_to&gt;/dbnode.yaml<code/></p>
</li>
</ol>  
</li>
<li>Check status of the database node update.
<ol type=a>
<li>Verify the status of the database node.

<p><code>curl -X GET http://localhost:5984<code></p>
<p>The response shows the new version.</p>

<p>      <pre>  <code>{
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
        }</code></pre></li>
<li>Verify that the database node is in maintenance mode and
        is not receiving traffic on the load balancer.
<p><code>cast node maintenance</code></p>
<p>The response shows the status of the node.</p>
<p><code>The node is IN maintenance mode.</code></p></li>
<li>Verify the status of the upgraded node as a member of the
        cluster.
<p><code>cast cluster status</code></p>
<p>The response lists all the cluster nodes.</p></li>
<li>Check the health of the database node by using the
        Weatherreport application, [Monitor cluster health with
        Weatherreport](/docs/services/Cloudant?topic=cloudant-diagnose-and-troubleshoot#monitor-cluster-health-with-weatherreport).</li>
</ol>
</li>
<li>Bring the database node out of maintenance mode and check its
    availability.
<ol type=a>
<li>Run the following command to bring the database node out
        of maintenance mode.
<p><code>cast node maintenance --false</code></p>
<p>The response shows the status of the node.</p>
<p><code>The node is OUT of maintenance mode.</code></p>
        </li>
<li>Verify that the database node is up and available for
        traffic from your load balancer.
<p><code>https://&lt;load_balancer&gt;/_haproxy</code></p>
<p>If the upgrade was successful, the response shows that
        the node is up and available.</p></li>
</ol>
</li>
</ol>

## Upgrading a load balancer node
{: #upgrading-a-load-balancer-node}

Upgrade each {{site.data.keyword.cloudant_local_notm}} load balancer node by following
these steps.

<ol>
<li>Verify that the load balancer failover works correctly when
    one load balancer (in a cluster of two or more load balancers) is taken offline during an
    upgrade.</li>
<li>Uninstall the current version by running the command.
<p><code>cast system uninstall</code></p>
<p>This command also stops the services.</p></li>
<li>Run the InstallShield <code>uninstall</code> command.
<p><code>/root/cloudant/uninstall/uninstall.bin</code></p></li>
<li>Install the new {{site.data.keyword.cloudant_local_notm}} packages and start the upgraded
    node, [Installing load balancer nodes](/docs/services/Cloudant?topic=cloudant-install-ibm-cloudant-local#installing-load-balancer-nodes).
<ol type=a>
<li>Find the load balancer node's current credentials,
        cluster nodes, host name, and IP addresses in the current
        version of the <code>/etc/haproxy/haproxy.cfg</code> file.
</li>
<li>Configure the values in the <code>lbnode.yaml</code> file.

<p>You can get a sample from
        <code>/opt/cloudant/cast/samples/lbnode.yaml</code> file, and run the
        following command to install and pass the configuration.</p>
<p><code>cast system install -lb -c /&lt;path_to&gt;/lbnode.yaml</code></p></li>
</ol>
</li>
<li>Verify that the load balancer is reachable through its URL and
    that all cluster nodes are listed and available to receive
    traffic by using this URL:  
<p><code>https://&lt;upgrade_node_load_balancer&gt;/_haproxy</code></p></li>
</ol>
