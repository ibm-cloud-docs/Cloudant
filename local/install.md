---

copyright:
  years: 2015, 2019
lastupdated: "2019-05-29"

keywords: install, requirements, supported architecture, supported platforms, database node, cluster, load balancer

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

<!-- Acrolinx: 2018-05-31 -->

# Install
{: #install-ibm-cloudant-local}

To install {{site.data.keyword.IBM}} Cloudant&reg; Data Layer Local Edition ({{site.data.keyword.cloudant_local_notm}}), you must ensure that your system
meets the system requirements, plan your installation, install
and configure a database node and load balancer node, and
initialize a cluster.
{:shortdesc}

## Requirements
{: #requirements-install}

Before you install {{site.data.keyword.cloudant_local_notm}}, confirm that your system
meets the installation requirements. The requirements include
cluster server requirements, supported platforms, hardware
requirements, single node requirements, and user requirements for
installing the product.

### Hardware requirements
{: #hardware-requirements-install}

{{site.data.keyword.cloudant_local_notm}} hardware requirements vary based on different
factors for the database and load balancers.

#### _x86_64 hardware requirements
{: #_86_64-hardware-requirements}

The following hardware requirements apply to the `x86_64`
architecture.

##### Database Nodes
{: #database-nodes-hardware-reqs}

*  The minimum requirements include four cores and eight threads,
   such as Xeon E3-1270 V2, 8 GB of RAM and 1-GB network.
*  For larger implementations, the minimum requirements include
   12 cores and 24 threads, such as dual Xeon E5 2620, 64 GB of
   RAM, and local SSD drives to meet data volume requirements of
   your usage and a 1-GB network.

Disk space requirements for the data vary based on how much data
you want to store. At minimum, the standard per-node storage
setup is as follows.

*  If you use spinning disks, 4 x 600 GB 15k SAS drives in RAID 0
   can provide about 2.2 TB of usable storage.
*  If you use solid-state drives (SSDs), 2 x 800 GB SSDs in RAID
   0 can provide about 1.5 TB of usable storage.
*  An ext4 file system that is mounted with the noatime option is
   recommended for performance reasons.

A storage area network (SAN) is not recommended. If you use a centralized location to store all the database files, such as a SAN, you might lose high-availability. If the SAN goes down, all of your database nodes are unavailable. However, if all of your database nodes use directly attached storage, you can lose two-thirds of your system and remain operational.
{: note}

For the operating system and {{site.data.keyword.cloudantfull}} binaries, the disk that is allocated must be 10 GB in RAID 1.

##### Load Balancer Nodes
{: #load-balancer-nodes-install}

*  The minimum requirements are dual-core processor and 4 GB RAM,
   1 TB local hard disk drive with enough disk space for the OS
   and any log files kept locally,
   and a 1-gigabit network.
*  For larger implementations, the minimum requirements include a
   quad-core processor and 8 GB RAM, 1 TB local hard disk drive,
   and a 1-gigabit network.

#### Linux on {{site.data.keyword.IBM_notm}} System z
{: #linux-on-ibm-system-z-hardware-reqs}

Confirm that your environment meets the following hardware
requirements.

##### Models
{: #models}

*  z13
*  zEnterprise - zBC12 and zEC12
*  zEnterprise - z114 and z196

##### Processors and Memory
{: #processors-and-memory}

*  Database Nodes
   *  2 IFLs in SMT mode
   *  8 GB memory for each node
*  Load Balancer Nodes
   *  2 IFLs
   *  4 GB memory for each node

### Software requirements
{: #software-requirements-install}

The following tasks can help you maintain your {{site.data.keyword.cloudant_local_notm}}
cluster.

#### Cluster server requirements
{: #cluster-server-requirements}

A minimum of five servers are recommended to create a fully
functional {{site.data.keyword.cloudant_short_notm}} cluster that ensures 24 x 7 availability.

##### Database Nodes
{: #database-nodes-software-reqs}

*  {{site.data.keyword.cloudant_local_notm}} must be installed on at least three database
   nodes for replication purposes.
*  (Optional) {{site.data.keyword.cloudant_local_notm}} can be installed on as many other
   nodes as needed to scale for your business requirements.

##### Load Balancers
{: #load-balancers-install}

*  One load balancer must be installed on a server that is
   separate from the servers that are used in the Cloudant
   cluster.
*  It is a good practice to install two load balancers in case
   the primary load balancer fails. If a second load balancer is
   installed, you must install it on a separate server to ensure
   uninterrupted service.

### Supported architecture and platforms
{: #supported-architecture-and-platforms}

You can install {{site.data.keyword.cloudant_local_notm}} on the following platforms.

#### x86_64 architecture
{: #x86-64-architecture-install}

The following requirements apply to the x86_64 architecture.

##### Debian-derived Linux distributions
{: #debian-derived-linux-distributions}

*  Ubuntu Server 12.04 (precise)
*  Ubuntu Server 14.04 (trusty)

##### Red Hat-derived Linux distributions
{: #red-hat-derived-linux-distributions}

*  Red Hat Enterprise Linux Server 6.x
*  Red Hat Enterprise Linux Server 7.x
*  Community ENTerprise Operating System (CentOS) 6.x
*  Community ENTerprise Operating System (CentOS) 7.x
*  Oracle Enterprise Linux Operating System (OEL) 6.x
*  Oracle Enterprise Linux Operating System (OEL) 7.x

    The package maintainer [changed the application binary interface](https://bugs.centos.org/view.php?id=14720#c31914) of the `js` library starting with version 1.8.5-20, which renders that version and subsequent versions incompatible with the  installer binaries. To find out which version is installed, after executing the installer (but before any `cast` commands), run the following command: `yum list js`. If the version of js.x86_64 under the heading 'Installed Packages' is 1.8.5-20.el7 or later, revert to a compatible package by *running* the following example commands as root or by using sudo. 
    {: note}
    
    ```sh
    curl http://vault.centos.org/7.4.1708/os/x86_64/Packages/js-1.8.5-19.el7.x86_64.rpm -o /tmp/js-1.8.5-19.el7.x86_64.rpm
    ```
    {: codeblock}

    ```sh
    rpm --force -Uvh /tmp/js-1.8.5-19.el7.x86_64.rpm
    ```
    {: codeblock}

    This issue only affects database nodes.
    {: important}

##### SUSE Linux distributions
{: #suse-linux-distributions}

*  SUSE Linux Enterprise Server (SLES) 12

#### {{site.data.keyword.IBM_notm}} System z s390x architecture
{: #ibm-system-z-s390x-architecture}

##### Linux on {{site.data.keyword.IBM_notm}} System z
{: #linux-on-ibm-system-z-supported-arch}

*  Linux on {{site.data.keyword.IBM_notm}} System z - Red Hat Enterprise Linux 7.x
*  SUSE Linux Enterprise Server (SLES) 12

### {{site.data.keyword.cloudant_local_notm}} architecture and ports
{: #ibm-cloudant-local-architecture-and-ports}

The components of {{site.data.keyword.cloudant_local_notm}} use these communication paths
and ports.

The following diagram shows the architecture of {{site.data.keyword.cloudant_local_notm}}
implementation.

*  Three database nodes that are identified as DB1, DB2, and DB3.
*  Two load balancers that are identified as LB1 and LB2.

![Example illustrates the communication paths and ports that are
  used by the components of {{site.data.keyword.cloudant_local_notm}}.](images/cloudant_architecture.jpg)
  
### Single-node implementation requirements
{: #single-node-implementation-requirements}

In a single-node implementation, a database node and a load
balancer node are installed on a single node. This setup is only
recommended for trial testing and development.

If you use a single-node implementation for this purpose, a
single-core VM with 2 GB of RAM is sufficient to run the
product.

A single-node implementation is not recommended in a production
environment. However, if you use a single-node implementation in
a production environment, the requirements are the same as for a
database node.

## Plan your {{site.data.keyword.cloudant_local_notm}} installation
{: #plan-your-ibm-cloudant-local-installation}

Plan your implementation and verify that your nodes and load
balancers are properly configured before you install {{site.data.keyword.cloudant_local_notm}}.

After you develop an installation plan and verify that your nodes
and load balancers are properly configured, see [Installing a
cluster](#installing-a-cluster-install).

### Factors to consider
{: #factors-to-consider-install}

Like most applications, {{site.data.keyword.cloudant_local_notm}} consists of two parts:
the application and the data it manages. After installation, the
application does not change often, but the data will change and
grow over time. Therefore, it is helpful to plan your
installation carefully before you install the product.

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

If you install {{site.data.keyword.cloudant_local_notm}} on a dedicated system, you will
have more control over where data is stored and how future
capacity is assured. If you install {{site.data.keyword.cloudant_local_notm}} on an existing
or shared system, it is important to consider your installation
plan. In the future, you might not have full control over
available space and future storage space.

When you consider these factors in your plan, you are better able
to identify installation locations and any storage partition
requirements.

### Changing the default directories
{: #changing-the-default-directories}

The {{site.data.keyword.cloudant_local_notm}} packages create the Cloudant
software and database directories.
The software
directory contains the {{site.data.keyword.cloudant_short_notm}} binary files, scripts,
configuration files, and other executable files. The database
directory stores your data files.

The packages create the {{site.data.keyword.cloudant_local_notm}} software and database
directories in the following locations.

*  The software is installed in a directory named `/opt/cloudant`.
*  The database is installed in a directory named `/srv/cloudant`.


<ol><li>Move these directories, if needed, to another drive or
    partition by creating at least one mount point for the
    {{site.data.keyword.cloudant_short_notm}} software and database directories.
<ol type=a><li>If you want the {{site.data.keyword.cloudant_short_notm}} software and database directories on the same mount point, create one mount point for the two directories.</li>
<li>If you want the {{site.data.keyword.cloudant_short_notm}} software and database directories on separate mount points, create two mount points, one for the software directory and another for the database directory.
</li></ol>
</li>
<li>(Optional) Move the database location by running <code>cast database relocate</code>.
<ol type=a><li>Display the help text by running the help command, <code>cast database relocate --help</code>.
</li>
<li>Ensure that the new directory location is owned by `cloudant:cloudant` and is applied to all database nodes with the same path and name.</li>
</ol></li> 
<li>Create the following {{site.data.keyword.cloudant_short_notm}} directories on at least one mount point.
<p>To install {{site.data.keyword.cloudant_local_notm}} on a mount point, or move the
    product to a mount point after it is installed, install
    {{site.data.keyword.cloudant_local_notm}} on a partition other than your root partition.</p>
<ol type=a><li>Make an {{site.data.keyword.cloudant_short_notm}} software directory named <code>/<your_mount_point>/opt/</code>.
<p>The <code>/cloudant</code> directory is automatically appended.</p></li>
<li>Make an {{site.data.keyword.cloudant_short_notm}} database directory named <code>/<your_mount_point>/srv/cloudant</code>.
<p>The <code>/cloudant</code> directory is automatically appended.</p>
<p>For example, if your mount point for both directories is <code>/export/local</code>, use the following commands to create the
    {{site.data.keyword.cloudant_short_notm}} directories.</p>
<p>The first command makes the {{site.data.keyword.cloudant_short_notm}} software directory on the mount point. The second command makes the {{site.data.keyword.cloudant_short_notm}} database directory on the mount point. You can put both directories on one mount point, or you can put the two directories on separate mount points.
</p>
<p><code>mkdir /export/local/opt/cloudant</code></p>
<p><code>mkdir /export/local/srv/cloudant</code></p></li>
</ol></li>

<li>Install {{site.data.keyword.cloudant_local_notm}} on each database or load balancer node in your implementation. For more information, see [Installing a cluster](#installing-a-cluster-install).</li>   
</ol>

### Verifying node configuration
{: #verifying-node-configuration}

Before you install {{site.data.keyword.cloudant_local_notm}} on any database or load
balancer node, you must verify that all nodes in your cluster are
named and configured properly with static IP addresses. When
{{site.data.keyword.cloudant_short_notm}} is installed, it is configured to start automatically.
If your nodes are not named and configured correctly, the wrong
node names are included in the memberships for your Cloudant
cluster.

Run the `hostname -f` command on each node in your cluster to
verify that the node is named and configured correctly. The
`hostname -f` command returns a Fully Qualified Domain Name (FQDN),
such as `db1.domain.com`. If the displayed host name is incorrect,
select from the following instructions.

<ol><li>If your operating system is Red Hat or CentOS, follow these steps.
<ol type="a">
<li>Append the following line to the <code>/etc/hosts</code> file on each node.
<p><code>node IP address</code></p>
<p><code>hostname</code></p>

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
<li>Edit the <code>/etc/hostname</code> file and change the content of that file to reflect the short-form host name. Do not change the fully qualified name. For example, in the previous step, the short-form host name is <code>db1</code>.
</li>
<li>Run the <code>sudo hostname --file /etc/hostname</code> command to update the operating system host name, based on the name that is specified in the <code>/etc/hostname</code> file.</li>
<li>Confirm that the correct host name is specified with the <code>hostname -f</code> command. If the specified host name is incorrect, correct it and repeat the previous step.</li></ol></li></ol>

You can configure your database nodes for either local logging or remote logging to a separate syslog logging server. The default setting is local, but the local setting is recommended only in test environments. In a production environment, you must use remote logging to ensure optimum system performance. If you want to set up logging, see [Configuring logging](/docs/services/Cloudant?topic=cloudant-configure-ibm-cloudant-data-layer-local-edition#configuring-logging).
{: note}

### Load balancer prerequisites
{: #load-balancer-prerequisites}

Before you install {{site.data.keyword.cloudant_local_notm}}, verify that you meet the load
balancer prerequisites.

1. You must install and configure a load balancer on a separate
   server from the ones that are used in the {{site.data.keyword.cloudant_short_notm}} cluster. To
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

   If you use a single IP address per node, complete only the "Public" lines for your primary and secondary load balancers. The "Public" IP addresses for these database nodes do not have to be public IP spaces. They are public only in the sense that they provide the actual database service. In general, this network would be a separate network segment from the "private" side of the servers, where all node-to-node and out-of-band communication takes place.
   {: note}

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

## Installing {{site.data.keyword.cloudant_local_notm}}
{: #installing-ibm-cloudant-local-install}

Use these instructions to install {{site.data.keyword.cloudant_local_notm}} on a database
and a load balancer node in either a multi-node cluster or a
single-node implementation.

### Installing a cluster
{: #installing-a-cluster-install}

Install and configure an {{site.data.keyword.cloudant_local_notm}} cluster.

You use the Cluster Admin and Support Tool (CAST), which manages
the installation, configuration, and support of an {{site.data.keyword.cloudant_local_notm}}
cluster and its individual nodes.

#### Before you begin
{: #before-you-begin-install}

Before you install {{site.data.keyword.cloudant_local_notm}}, confirm that your system
meets the following requirements.


*  You must be the root user, or have sudo privileges, to install
   {{site.data.keyword.cloudant_local_notm}}. If you are not the root user, prefix all
   commands with the `sudo` command.

*  If security restrictions prevent you from accessing
   third-party repositories, you must download and install the
   required third-party packages before you start the
   installation.

*  The {{site.data.keyword.cloudant_local_notm}} installation on RHEL/CentOS systems
   requires that you enable the EPEL repository.

   *  If the repository is not already enabled on your system,
      run this command to install and enable EPEL.

      ``` sh
      sudo yum -y install epel-release
      ```
      {:codeblock}
      
   *  When the installation is complete,
      you can remove EPEL with this command.

      ``` sh
      sudo yum erase epel-release
      ```
      {:codeblock}

#### Installing {{site.data.keyword.cloudant_local_notm}} packages
{: #installing-ibm-cloudant-local-packages}

To install (or uninstall) {{site.data.keyword.cloudant_local_notm}}, you must be a root
user or use the `sudo` command.

<ol>
<li>Download the self-extracting archive file for the OS version you want to
   install.</li>
<li>Ensure that the self-extracting archive file has executable permissions,
   and if not, change the mode to execute by running this command.
<p><code>chmod +x cloudant-1.1.0-984-el6-x86_64.bin</code></p></li>
<li>Install the {{site.data.keyword.cloudant_local_notm}} packages (<code>cloudant-<em>version</em>-<em>os</em>-<em>arch</em>.bin</code>) and install CAST.
<ol type="a"><li>To install the {{site.data.keyword.cloudant_local_notm}} packages by using an interactive wizard, run the following command.
<p><code>./cloudant-1.1.0-984-el6-x86_64.bin</code></p></li>
<li>To install the {{site.data.keyword.cloudant_local_notm}} packages (<code>cloudant-<em>version</em>-<em>os</em>-<em>arch</em>.bin</code>) silently, and implicitly accept the {{site.data.keyword.IBM_notm}} License Agreement, run the following command. The properties file you specify determines whether this instance of {{site.data.keyword.cloudant_local_notm}} is used for production or development purposes.
<p><code>./cloudant-1.1.0-984-el6-x86_64.bin -- -s</code></p></li></ol></li>
</ol>

### Installing the first database node
{: #installing-the-first-database-node}

Install and configure the first database node in the cluster.

<ol><li>Run the CAST installation command to install the first
   database node of the cluster.
<p><pre>
   cast system install -p dbadmin_password -db
</pre></p>
    <p>See the options for the first database node in the following table: 

<table>
<caption style="caption-side:top">Table 1. Options for the first database node</caption>
<thead>
<tr>
<th>Flag</th>
<th>Purpose</th>
</tr>
</thead>
<tbody>
<tr>
<td><code>-db</code> or <code>--dbnode</code>
</td>
<td>Flag to install a database node.</td>
</tr>
<tr>
<td><code>-p</code> or <code>--password</code></td>
<td>An optional flag to specify the database admin password. If you do not provide a password, the password defaults to <code>pass</code>.</td>
</tr>
</tbody></table>
</p></li>
<li>Run the <code>export</code> command to export configuration values to a file.
<pre>cast cluster export cluster_dbnode.yaml</pre>
<p><strong>Note</strong>: For each additional database node in the cluster, you must use the same configuration file. To join the nodes together into a cluster, the configuration file must be the same on each host and contain the same passwords and cookie values for each user.</p></li>
<li>Copy the resulting <code>cluster_dbnode.yaml</code> file to a place that is accessible when you install more database nodes.</li></ol>

### Installing additional database nodes
{: #installing-additional-database-nodes}

You can add a database node to your cluster after the first node
is installed.

Run the `cast system install` command to add a database node.

``` sh
cast system install -c cluster_dbnode.yaml -db
```
{:codeblock}

See the options for additional database nodes in the following table: 

<table>
<caption style="caption-side:top">Table 2. Options for additional database nodes</caption>
<thead>
<tr>
<th>Flag</th>
<th>Purpose</th>
</tr>
</thead>
<tbody>
<tr>
<td><code>-db</code> or <code>--dbnode</code>
</td>
<td>Flag to install a database node.</td>
</tr>
<tr>
<td><code>-c</code> or <code>--config</code>
</td>
<td>The cluster configuration file exported from the first node.</td>
</tr>
<tr>
<td><code>--maintenance</code>
</td>
<td>Start the system in maintenance mode. </td>
</tr>
</tbody></table>

You added a database node. Next, you must join the cluster.

### Joining nodes in a cluster
{: #joining-nodes-in-a-cluster}

After you install and configure all the database nodes, you must
join them together to form the cluster.

1. Log in to the first database node.

2. Run the `cast cluster add` command for each node in the cluster
   except for the database node from which you are running the
   command.

   ``` sh
   cast cluster add FQDN1 FQDN2
   ```
   {:codeblock}

   For example, if your environment includes three database
   nodes, the Fully Qualified Domain Name (FQDN) might be `db1.vm`,
   `db2.vm`, or `db3.vm`. In this case, if you are on the `db1.vm`
   node, you must add both database nodes, `db2.vm` and `db3.vm`, by
   running the following command.

   ``` sh
   cast cluster add db2.vm db3.vm
   ```
   {:codeblock}

3. Verify the status of each cluster by running the following
   command.

   ``` sh
   cast cluster status
   ```
   {:codeblock}

   Each node in the cluster shows an online or offline status. An
   offline status indicates that the node did not join the
   cluster correctly. If a node did not join the cluster
   correctly, remove the node, and repeat the installation and
   configuration steps.

4. If you need to remove a node from the cluster, run the
   following command.

   ``` sh
   cast cluster remove FQDN1 FQDN2
   ```
   {:codeblock}

   For example, this command adds `db2.vm` and `db3.vm`.

   ``` sh
   cluster remove db2.vm db3.vm
   ```
   {:codeblock}

   After you join the cluster the first time, you must initialize
   it.

### Initializing the cluster
{: #initializing-the-cluster}

During a new installation and after all the database nodes are
joined to the cluster, you must initialize the cluster.

1. Run the following command from one of the database nodes to
   initialize the cluster.

   ``` sh
   cast cluster init
   ```
   {:codeblock}

2. Install a load balancer.


### Installing load balancer nodes
{: #installing-load-balancer-nodes}

Install and configure each load balancer node in the cluster by
following these steps.
 
<ol><li>Install a load balancer node by running the following command.
<p><code>cast system install -lb</code></p>
<p>See the options for the load balancer node in the following table: </p>
<table>
<caption style="caption-side:top">Table 3. Options for the load balancer node</caption>
<thead>
<tr>
<th>Flag</th>
<th>Purpose</th>
</tr>
</thead>
<tbody>
<tr>
<td><code>-lb</code> or <code>--lbnode</code>
</td>
<td>Flag to install a load balancer node.</td>
</tr>
</table>
</li>
<li>Copy the load balancer node configuration file, <code>/opt/cloudant/cast/samples/lbnode.yaml</code>.</li>
<li>Update the host name and IP address values for each database node in the cluster under the Nodes section of the configuration file.</li>
<li>Replace the host name with the FQDN.
<pre><code>
hostname: xxx.xx
ipaddress: xxx
</code></pre></li>
<li>Change the default admin password from `pass` as shown in the sample.
<pre><code>
# Sample CAST input file for configuring a load balancer in a three-node database cluster.
    
    lbnode:
    
    users: 
    haproxy_stat: pass 
    
    nodes: 
    - hostname: db1.vm 
    ipaddress: 192.168.211.101 
    
    - hostname: db2.vm 
    ipaddress: 192.168.211.102 
    
    - hostname: db3.vm 
    ipaddress: 192.168.211.103
</code></pre></li>
<li>Save the configuration file and update the node with the new values by running the following command.
<code>cast node config lbnode.yaml</code>
<p>After you run the `cast node config` command, the load balancer
    node is configured. After you complete the installation of the
    database nodes and initialize the cluster, verify the
    installation by [Starting the {{site.data.keyword.cloudant_local_notm}} Dashboard](#starting-the-ibm-cloudant-local-dashboard).</p></li>
</ol>


## Installing a single node
{: #installing-a-single-node}

If you want to install {{site.data.keyword.cloudant_local_notm}} in a single-node
implementation instead of a cluster, you must install the load
balancer and database nodes to run on the same node. In most
cases, a stand-alone node is installed for development or
demonstration purposes and uses the default configuration
settings.

This implementation is not recommended for a production environment.
{: important}

<ol><li>Install a single node by running the following command.
<pre><code>cast system install -p dbadmin_password -lb -db</code></pre>
<table>
<caption style="caption-side:top">Table 4. Options for a single node</caption>
<thead>
<tr>
<th>Flag</th>
<th>Purpose</th>
</tr>
</thead>
<tbody>
<tr>
<td><code>-db</code> or <code>--dbnode</code>
</td>
<td>Flag to install a database node.</td>
</tr>
<tr>
<td><code>-lb</code> or <code>--lbnode</code>
</td>
<td>Flag to install a load balancer node.</td>
</tr>
<tr>
<td><code>-p</code> or <code>--password</code>
</td>
<td>(Optional) flag to set the database admin password. If you do not provide a password, the password defaults to `pass`. </td></tr>
</table>
</li>
<li>Run the following command to initialize the single node cluster.
<pre><code>cast cluster init</code></pre></li></ol>
    
## Installing {{site.data.keyword.cloudant_local_notm}} offline
{: #installing-ibm-cloudant-local-offline}

Install {{site.data.keyword.cloudant_local_notm}} offline by following these instructions.

An online system has internet access and full access to the package repositories, while an offline system has no access to the internet. You must download the third-party dependencies, bundle them into a `tar` file, and transfer them to the offline system for installation.

### Prerequisites
{: #prerequisites-offline}

Before you install {{site.data.keyword.cloudant_local_notm}} offline, you must meet the following prerequisites.

1.  You must be a root user or have sudo privileges.

2.  You must run a download-only or dry-run installation.  
    You run a dry-run installation from a system that has internet
    access and runs the same version of the operating system as the
    target system. The new system is called the online system.

### Installing Third-party Package Dependencies
{: #installing-third-party-package-dependencies}

{{site.data.keyword.cloudant_local_notm}} depends on several third-party packages. Before you install {{site.data.keyword.cloudant_local_notm}}, the third-party packages must be installed on the offline system. You can use the dry-run installation option to bundle and transfer the dependencies to your offline system. The dry-run installation option is supported by the operating system package managers that {{site.data.keyword.cloudant_local_notm}} uses.

Before you begin, you must configure access to the following external repositories on the online system.

*   Operating system-specific package repositories (EPEL, and so on)
*   Python Package Index (PyPI) site

#### Installing Red Hat dependencies
{: #installing-red-hat-dependencies}

For Red Hat and CentOS platforms, you must bundle the dependencies and transfer them to the offline system.

<ol>
<li>Log in to your Red Hat online system to install the Red Hat dependencies.
<ol type="a"> 
<li>Install the EPEL repository.
<p><code>yum install epel-release</code>
</p></li>
<li>Run the {{site.data.keyword.cloudant_short_notm}} Self-Extracting Archive. See [Installing {{site.data.keyword.cloudant_local_notm}} packages](#installing-ibm-cloudant-local-packages).
<p><code>./cloudant-<version>-<os>-<arch>.bin</code>
</p></li>
</ol>
</li>
<li>Bundle the dependencies into a compressed (tar) file by running the following commands.
<p>
<pre><code>yum install createrepo
mkdir cloudant-deps
yum reinstall -y --downloadonly --downloaddir=cloudant-deps cloudant-dbnode cloudant-lbnode iptables-services python2-pip
createrepo cloudant-deps
tar -czvf cloudant-deps.tar.gz cloudant-deps</code></pre>
</p></li>
<li>Copy the file to the offline system.
<p>
<code>cp cloudant-deps.tar.gz offline.system.com:/tmp</code></p></li>
<li>Log in to the offline system.</li>
<li>Set up the repository for the {{site.data.keyword.cloudant_short_notm}} dependencies.
<p>
<pre><code>cd /tmp
tar -xvf cloudant-deps.tar.gz
<br>
echo "[cloudant-deps]" >> /etc/yum.repos.d/cloudant-deps.repo
echo "name=IBM, Cloudant Dependencies" >> /etc/yum.repos.d/cloudant-deps.repo
echo "baseurl=file:///tmp/cloudant-deps" >> /etc/yum.repos.d/cloudant-deps.repo
echo "enabled = 1" >> /etc/yum.repos.d/cloudant-deps.repo<
echo "gpgcheck = 0" >> /etc/yum.repos.d/cloudant-deps.repo
<br>
yum clean all</code></pre>
</p>
</li></ol>


#### Installing SUSE dependencies
{: #installing-suse-dependencies}

You must bundle the SUSE dependencies and transfer them to the
offline system.

<ol>
<li>Log in to your SUSE online system to install the SUSE dependencies.
<ol type="a">
<li>Download <code>pip-9.0.1.tar.gz</code> file from <a href="https://pypi.python.org/pypi/pip" target="_blank">PiPI <img src="images/launch-glyph.svg" alt="External link icon"></a>.</li>
<li>Install <code>python-pip</code>.
<p><pre><code>tar -xvf pip-9.0.1.tar.gz
cd pip-9.0.1.tar.gz
python setup.py install</code></pre>
</p></li>
<li>Run the {{site.data.keyword.cloudant_short_notm}} self-extracting archive.
<p><code>./cloudant-&lt;version&gt;-&lt;os&gt;-&lt;arch&gt;.bin</code></p></li>
</ol>
<li>Download and bundle the dependencies into a compressed (tar) file by running the following commands.
<p><pre><code>zypper -n install createrepo
mkdir cloudant-deps
zypper --pkg-cache-dir=cloudant-deps download java-1_7_0-openjdk java-1_7_0-openjdk-headless java-1_7_0-openjdk-devel curl rsyslog lcms2 timezone-java python-setuptools python-base python-pip python-setuptools
createrepo cloudant-deps
tar -czvf cloudant-deps.tar.gz cloudant-deps</code></pre</p></li>
<li>Copy the compressed (tar) file to the offline system.
<p><pre><code>scp cloudant-deps.tar.gz <var>offline.system.com</var>:/tmp
scp pip-9.0.1.tar.gz <var>offline.system.com</var>:/tmp</code></pre></p></li>
<li>Log in to the offline system.</li>
<li>Set up the repository for the {{site.data.keyword.cloudant_short_notm}} dependencies.
<p><pre><code>cd /tmp
tar -xvf cloudant-deps.tar.gz
zypper -n addrepo —no-gpgcheck /tmp/cloudant-deps cloudant-deps
zypper refresh
zypper install python-pip
tar -xvf pip-9.0.1.tar.gz
cd pip-9.0.1
python setup.py install</code></pre></p></li>
</ol>

#### Installing Ubuntu dependencies
{: #installing-ubuntu-dependencies}

Retrieve the Ubuntu dependencies from the Ubuntu online system.

1.  Log in to the Ubuntu online system.

2.  Retrieve the dependencies required by the self-extracting archive/CAST tool.
    
    ``` sh
    apt-get update
    apt-get download apt-offline python-apt
    dpkg -i apt-offline*
    apt-offline set cast-deps.sig --install-packages openjdk-6-jre python-pip iptables-persistent python-pip-whl fgetty runit curl
    apt-offline get cast-deps.sig --no-checksum -d cloudant-deps
    ```
    {:codeblock}

3.  Run the self-extracting archive.
    
    <code>./cloudant-&lt;version&gt;-&lt;os&gt;-&lt;arch&gt;.bin</code>

4.  Retrieve the remaining dependencies that are required by the self-extracting archive/CAST tool.
    
    ``` sh
    apt-offline set cloudant-deps.sig --install-packages cloudant-lbnode cloudant-dbnode
    apt-offline get cloudant-deps.sig --no-checksum -d cloudant-deps
    rm cloudant-deps/*cloudant*
    tar -czvf cloudant-deps.tar.gz cloudant-deps
    ```
    {:codeblock}

5.  Copy the self-extracting archive and all its dependencies to the offline system.
    
    ``` sh
    scp python-apt* offline.system.com:/tmp
    scp cloudant-deps.tar.gz offline.system.com:/tmp
    scp cloudant-version-os-arch.bin offline.system.com:/tmp
    ```
    {:codeblock}

6.  Log in to the offline system.

7.  Install the {{site.data.keyword.cloudant_short_notm}} dependencies.
    
    ``` sh
    cd /tmp
    tar -xvf cloudant-deps.tar.gz
    dpkg -i cloudant-deps/*
    ```
    {:codeblock}
    
#### Installing Python dependencies
{: #installing-python-dependencies}

After you transfer the third-party dependencies, you must
transfer the Python dependencies from the online system.

You must apply these steps to each platform in your environment.
{: important}

1.  Download and install the `pip2pi` Python module to create a local PyPI repository.
    
    ``` sh
    pip install pip --upgrade
    pip install pip2pi
    ```
    {:codeblock}

2.  Create a text file named `requirements.txt`.

3.  Add the Python module to the `requirements.txt` file.

    ``` sh
    pip==9.0.1
    virtualenv==15.0.3
    wheel==0.29.0
    ```
    {:codeblock}

4.  Download and create the `PyPi` simple repository.
    
    ``` sh
    mkdir cloudant-python-deps
    pip2pi cloudant-python-deps -r requirements.txt
    ```
    {:codeblock}

5.  Bundle the PyPI repository into a compressed (tar) file.

    ``` sh
    tar -czvf cloudant-python-deps.tar.gz cloudant-python-deps
    ```
    {:codeblock}

6.  Copy the files to the offline system.

    ``` sh
    scp cloudant-python-deps.tar.gz offline.system.com:/tmp
    ```
    {:codeblock}

7.  Log in to the offline system.

8.  Setup the local PyPI repository.

    ``` sh
    cd /tmp
    tar -xvf cloudant-python-deps.tar.gz
    
    mkdir ~/.pip
    echo "[global]" > ~/.pip/pip.conf
    echo "index-url = file:///tmp/cloudant-python-deps/simple" >> ~/.pip/pip.conf
    ```
    {:codeblock}

### Running the {{site.data.keyword.cloudant_short_notm}} self-extracting archive
{: #running-the-ibm-cloudant-self-extracting-archive}

After you install all the dependencies on the offline system,
you must run the self-extracting archive.

1.  Log in to the offline system.

2.  Transfer the self-extracting archive.

    ``` sh
    scp cloudant-version-os-arch.bin offline.system.com:/tmp
    ```
    {:codeblock}

3.  Run the self-extracting archive.

    ``` sh
    cd /tmp
    ./cloudant-<version>-<os>-<arch>.bin
    ```
    {:codeblock}

4.  Only perform this step on an Ubuntu system.</cmd>
    
    ``` sh
    cd /tmp
    dpkg -x python-apt* apt
    cp -r apt/usr/* /opt/cloudant/cast/venv
    ```
    {:codeblock}

### Installing the database and load balancer
{: #installing-the-database-and-load-balancer}

After you install the third-party repositories on the offline system,
you can continue installing the database and load balancer node.

1.  [Install the first database node](#installing-the-first-database-node).

2.  [Install load balancer nodes](#installing-load-balancer-nodes).

3.  Verify that the installation was successful by starting the
    {{site.data.keyword.cloudant_short_notm}} Dashboard that uses the load balancer node URL,
    `http://loadbalancer_url/dashboard.html`.

## Starting the {{site.data.keyword.cloudant_local_notm}} Dashboard
{: #starting-the-ibm-cloudant-local-dashboard}

Start the {{site.data.keyword.cloudant_local_notm}} Dashboard to verify that {{site.data.keyword.cloudant_local_notm}}
was successfully installed on each load balancer.

1.  Start and stop the dashboard by using the following commands.

    ``` sh
    cast node start
    cast node stop
    ```
    {:codeblock}

2.  Enter the following URL in a web browser to access the dashboard.

    ``` sh
    http://<your_load_balancer_IP_address>/dashboard.html
    ```
    {:codeblock}

    In this URL, `your_load_balancer_IP_address` is the fully
    qualified host name of your load balancer.

3.  Include the `/dashboard.html` part of the URL to display the
    dashboard. If you omit `/dashboard.html`, the standard Cloudant
    welcome message is displayed instead of the dashboard.

    ``` json
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
    {:codeblock}

4.  Enter your database administration credentials at the {{site.data.keyword.cloudant_short_notm}} Dashboard.

    When you successfully authenticate to the {{site.data.keyword.cloudant_local_notm}}
     Dashboard, your installation is complete.
    
## Uninstalling {{site.data.keyword.cloudant_local_notm}}
{: #uninstalling-ibm-cloudant-local}

Uninstall {{site.data.keyword.cloudant_local_notm}} with the `cast system uninstall` command.

<ol>
<li>Stop the database node before you run the <code>cast system uninstall</code> command.
<p><code>cast node stop</code></p></li>
<li>To uninstall {{site.data.keyword.cloudant_local_notm}}, log in with the same user
    ID that you used during your first installation.
    For example, if you installed {{site.data.keyword.cloudant_local_notm}} as the
    root user, you must uninstall {{site.data.keyword.cloudant_local_notm}} as the
    root user.</li>
<li>Run the <code>cast system uninstall</code> command to uninstall {{site.data.keyword.cloudant_local_notm}} services and the CAST tool.
    <p><code>cast system uninstall</code></p></li>
<li>Verify that no processes are running. If any processes are running, reboot the system to clean up hanging processes.
<ol type="a">
<li>Log in as the root user or a user with sudo privileges.</li>
<li>Run the <code>sudo reboot</code> command.
<p><code>sudo reboot</code></p>
</li>
</ol><p>{{site.data.keyword.cloudant_local_notm}} is uninstalled.</p>
</li>
</ol>


