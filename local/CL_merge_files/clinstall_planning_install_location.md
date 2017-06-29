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

# Plan your Cloudant Local installation

Plan your implementation and verify that your nodes and load
balancers are properly configured before you install Cloudant&reg;
Local.
{:shortdesc}

After you develop an installation plan and verify that your nodes
and load balancers are properly configured, see [Installing a
cluster](clinstall_install_a_cluster.html).

## Factors to consider

Like most applications, Cloudant&reg; Local consists of two parts:
the application and the data it manages. After installation, the
application does not change often, but the data will change and
grow over time. Therefore, it is helpful to plan your
installation carefully before you install the product.
{:shortdesc}

In particular, consider the following aspects.

*  Any organizational policies that you might have regarding the
   installation of software and data. For example, you might have
   a policy against installing databases on the root partition of
   a system.
*  Current and expected storage requirements. For example, while
   the target system might have enough storage space for the
   initial installation, subsequent use and data growth might
   exceed the available space.
*  Simplification of maintenance and backup. For example, by
   keeping the application software and data locations separate,
   it is often easier to run backup and maintenance tasks.

If you install Cloudant Local on a dedicated system, you will
have more control over where data is stored and how future
capacity is assured. If you install Cloudant Local on an existing
or shared system, it is important to consider your installation
plan. In the future, you might not have full control over
available space and future storage space.

When you consider these factors in your plan, you are better able
to identify installation locations and any storage partition
requirements.

## Changing the default directories

The Cloudant&reg; Local packages create the Cloudant
software and database directories.
The software
directory contains the Cloudant binary files, scripts,
configuration files, and other executable files. The database
directory stores your data files.
{:shortdesc}

The packages create the Cloudant Local software and database
directories in the following locations.

*  The software is installed in a directory named `/opt/cloudant`.
*  The database is installed in a directory named `/srv/cloudant`.

<code></code>

<ol><li>Move these directories, if needed, to another drive or
    partition by creating at least one mount point for the
    Cloudant software and database directories.
<ol type=a><li>If you want the Cloudant software and database directories on the same mount point, create one mount point for the two directories.</li>
<li>If you want the Cloudant software and database directories on separate mount points, create two mount points, one for the software directory and another for the database directory.
</li></ol>
</li>
<li>(Optional) Move the database location by running <code>cast database relocate</code>.
<ol type=a><li>Display the help text by running the help command, <code>cast database relocate --help</code>.
</li>
<li>Ensure that the new directory location is owned by `cloudant:cloudant` and is applied to all database nodes with the same path and name.</li>
</ol></li> 
<li>Create the following Cloudant directories on at least one mount point.
<p>To install Cloudant Local on a mount point, or move the
    product to a mount point after it is installed, install
    Cloudant Local on a partition other than your root partition.</p>
<ol type=a><li>Make a Cloudant software directory named <code>/<your_mount_point>/opt/</code>.
<p>The <code>/cloudant</code> directory is automatically appended.</p></li>
<li>Make a Cloudant database directory named <code>/<your_mount_point>/srv/cloudant</code>.
<p>The <code>/cloudant</code> directory is automatically appended.</p>
<p>For example, if your mount point for both directories is <code>/export/local</code>, use the following commands to create the
    Cloudant directories.</p>
<p>**Note**: The first command makes the Cloudant software directory on the mount point. The second command makes the Cloudant database directory on the mount point. You can put both directories on one mount point, or you can put the two directories on separate mount points.
</p>
<p><code>mkdir /export/local/opt/cloudant<br>
mkdir /export/local/srv/cloudant</code></p> </li>
      </ol></li>

<li>Install Cloudant Local on each database or load balancer node in your implementation. See [Installing a cluster](clinstall_install_a_cluster.html).</li>   
</ol>

## Verifying node configuration

Before you install Cloudant&reg; Local on any database or load
balancer node, you must verify that all nodes in your cluster are
named and configured properly with static IP addresses. When
Cloudant is installed, it is configured to start automatically.
If your nodes are not named and configured correctly, the wrong
node names are included in the memberships for your Cloudant
cluster.
{:shortdesc}

Run the `hostname -f` command on each node in your cluster to
verify that the node is named and configured correctly. The
`hostname -f` command returns a Fully Qualified Domain Name (FQDN),
such as `db1.domain.com`. If the displayed host name is incorrect,
select from the following instructions.

<ol><li>If your operating system is Red Hat or CentOS, follow these steps.
<ol type="a">
<li>Append the following line to the <code>/etc/hosts</code> file on each node.
<p><code>node IP address<br>
hostname</code></p>

<ul type="1">
<li>Specify the external IP address for the node, <code>node IP address</code>, not the loop-back interface IP address.</li>
<li>Specify the appropriate host name, <code>hostname</code>, such as the one in the following example.
<p><code>107.170.185.247 db2.millay-centos65-cloudant-local.com</code></p></li></ul></li>

<li>Confirm that the correct host name is specified in the <code>/etc/sysconfig/network</code> file.</li>
<li>Use the <code>hostname -f</code> command to confirm that the name is correct.</li>
<li>If the host name is correct, restart the server for the new entry to take effect. If not, correct the invalid host name.</li></ol>
</li>

<li>If your operating system is Debian or Ubuntu, confirm that your DNS entries are set up correctly and follow these steps.
<ol type=a>
<li>In the <code>/etc/hosts</code> file, edit the line that starts with <code>127.0.1.1</code> and change the entry to suit your environment as in the following example.
<p><code>127.0.1.1 db1.clustername.domain.net db1</code></p></li>
<li>Edit the <code>/etc/hostname</code> file and change the content of that file to reflect the short-form host name. 
<p>Do not change the fully qualified name. For example, in the previous step, the short-form host name is <code>db1</code>.</p></li>
<li>Run the <code>sudo hostname --file /etc/hostname</code> command to update the operating system host name, based on the name that is specified in the <code>/etc/hostname</code> file.</li>
<li>Confirm that the correct host name is specified with the <code>hostname -f</code> command. 
<p>If the specified host name is incorrect, correct it and repeat the previous step. </p>
<p>** Note:** You can configure your database nodes for either local logging or remote logging to a separate syslog logging server. The default setting is local, but the local setting is recommended only in test environments. In a production environment, you must use remote logging to ensure optimum system performance. If you want to set up logging, see [Configuring logging](clinstall_configuring_logging.html).</p></li>
</ol></li></ol>

## Load balancer prerequisites

Before you install Cloudant&reg; Local, verify that you meet the load
balancer prerequisites.
{:shortdesc}


1. You must install and configure a load balancer on a separate
   server from the ones that are used in the Cloudant cluster. To
   ensure uninterrupted service, you can install a second
   (failover) load balancer server.

2. If you are deploying multiple load balancers in a failover
   configuration, confirm that all load balancers are on the same
   Layer 2 LAN segment. This step is required for VRRP-based
   failover to function correctly.

3. Confirm that DNS entries exist for both the public and private
   IP addresses for each Load Balancer node.

4. Record the following information for your primary load
   balancer (Load Balancer 1) for future reference.

   *  Public DNS Name
   *  Public IP
   *  Private DNS Name
   *  Private IP

   >    **Note:** If you use a single IP address per node, complete only the "Public" lines for your primary and secondary load balancers. The "Public" IP addresses for these database nodes do not have to be public IP spaces. They are public only in the sense that they provide the actual database service. In general, this network would be a separate network segment from the "private" side of the servers, where all node-to-node and out-of-band communication takes place.

   If you use a failover load balancer, record the same
   information for your second load balancer (Load Balancer 2).

   *  Public DNS Name
   *  Public IP
   *  Private DNS Name
   *  Private IP

5. Confirm that the virtual IP address is available for the load
   balancers to share. This address is the IP address that
   clients use to access the cluster. Record this IP address for
   future reference.

   *  Virtual IP address
