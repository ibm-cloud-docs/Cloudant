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

# Installing

To install Cloudant&reg; Local, you must ensure that your system
meets the system requirements, plan your installation, install
and configure a database node and load balancer node, and
initialize a cluster.
{:shortdesc}

## Requirements

Before you install Cloudant&reg; Local, confirm that your system
meets the installation requirements. The requirements include
cluster server requirements, supported platforms, hardware
requirements, single node requirements, and user requirements for
installing the product.

### Hardware requirements

Cloudant&reg; Local hardware requirements vary based on different
factors for the database and load balancers.

#### _x86_64 hardware requirements

The following hardware requirements apply to the x86_64
architecture.

##### Database Nodes

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

>   **Note:** A storage area network (SAN) is not recommended. If you use
    a centralized location to store all the database files, such as a
    SAN, you might lose high-availability. If the SAN goes down, all
    of your database nodes are unavailable. However, if all of your
    database nodes use directly attached storage, you can lose
    two-thirds of your system and remain operational.

For the operating system and Cloudant binaries, the disk that is
allocated must be 10 GB in RAID 1.

##### Load Balancer Nodes

*  The minimum requirements are dual-core processor and 4 GB RAM,
   1 TB local hard disk drive with enough disk space for the OS
   and any log files kept locally,
   and a 1-gigabit network.
*  For larger implementations, the minimum requirements include a
   quad-core processor and 8 GB RAM, 1 TB local hard disk drive,
   and a 1-gigabit network.

#### Linux on IBM System z

Confirm that your environment meets the following hardware
requirements.

##### Models

*  z13&trade;
*  zEnterprise&reg; - zBC12 and zEC12
*  zEnterprise - z114 and z196

##### Processors and Memory

*  Database Nodes
   *  2 IFLs in SMT mode
   *  8 GB memory for each node
*  Load Balancer Nodes
   *  2 IFLs
   *  4 GB memory for each node

### Software requirements

The following tasks can help you maintain your Cloudant&reg; Local
cluster.

#### Cluster server requirements

A minimum of five servers are recommended to create a fully
functional Cloudant cluster that ensures 24 x 7 availability.

##### Database Nodes

*  Cloudant Local must be installed on at least three database
   nodes for replication purposes.
*  (Optional) Cloudant Local can be installed on as many other
   nodes as needed to scale for your business requirements.

##### Load Balancers

*  One load balancer must be installed on a server that is
   separate from the servers that are used in the Cloudant
   cluster.
*  It is a good practice to install two load balancers in case
   the primary load balancer fails. If a second load balancer is
   installed, you must install it on a separate server to ensure
   uninterrupted service.

### Supported architecture and platforms

You can install Cloudant Local on the following platforms.

#### x86_64 architecture

##### Debian-derived Linux distributions

*  Ubuntu Server 12.04 (precise)
*  Ubuntu Server 14.04 (trusty)

##### Red Hat-derived Linux distributions

*  Red Hat Enterprise Linux Server 6.x
*  Red Hat Enterprise Linux Server 7.x
*  Community ENTerprise Operating System (CentOS) 6.x
*  Community ENTerprise Operating System (CentOS) 7.x
*  Oracle Enterprise Linux Operating System (OEL) 6.x
*  Oracle Enterprise Linux Operating System (OEL) 7.x

##### SUSE Linux distributions

*  SUSE Linux Enterprise Server (SLES) 12

#### IBM System z s390x architecture

##### Linux on IBM&reg; System z&reg;

*  Linux on IBM System z - Red Hat Enterprise Linux 7.x
*  SUSE Linux Enterprise Server (SLES) 12

### Cloudant Local architecture and ports

The components of Cloudant&reg; Local use these communication paths
and ports.

The following diagram shows the architecture of a Cloudant Local
implementation.

*  Three database nodes that are identified as DB1, DB2, and DB3.
*  Two load balancers that are identified as LB1 and LB2.

![Example illustrates the communication paths and ports that are
  used by the components of Cloudant Local.](images/cloudant_architecture.jpg)
  
### Single-node implementation requirements

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

## Plan your Cloudant Local installation

Plan your implementation and verify that your nodes and load
balancers are properly configured before you install Cloudant&reg;
Local.

After you develop an installation plan and verify that your nodes
and load balancers are properly configured, see [Installing a
cluster](clinstall_install_a_cluster.html).

### Factors to consider

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

### Changing the default directories

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

### Verifying node configuration

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

### Load balancer prerequisites

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

## Installing the product

Use these instructions to install Cloudant&reg; Local on a database
and a load balancer node in either a multi-node cluster or a
single-node implementation.

### Installing a cluster

Install and configure a Cloudant&reg; Local cluster.

You use the Cluster Admin and Support Tool (CAST) which manages
the installation, configuration, and support of a Cloudant Local
cluster and its individual nodes.

#### Before you begin

Before you install Cloudant&reg; Local, confirm that your system
meets the following requirements.


*  You must be the root user, or have sudo privileges, to install
   Cloudant Local. If you are not the root user, prefix all
   commands with the `sudo` command.

*  If security restrictions prevent you from accessing
   third-party repositories, you must download and install the
   required third-party packages before you start the
   installation.

*  The Cloudant Local installation on RHEL/CentOS systems
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

#### Installing Cloudant Local packages

To install (or uninstall) Cloudant&reg; Local, you must be a root
user or use the `sudo` command.



<ol>
<li>Download the self-extracting archive file for the OS version you want to
   install.</li>
<li>Ensure that the self-extracting archive file has executable permissions,
   and if not, change the mode to execute by running this command.
   <p><code>chmod +x cloudant-1.1.0-984-el6-x86_64.bin</code></p></li>
<li>Install the Cloudant Local packages (`cloudant-<version>-<os>-<arch>.bin`) and install CAST.
<ol type="a"><li>To install the Cloudant Local packages by using an interactive wizard, run the following command.
<p><code>./cloudant-1.1.0-984-el6-x86_64.bin</code></p></li>
<li>To install the Cloudant Local packages (`cloudant-<version>-<os>-<arch>.bin`) silently, and implicitly accept the IBM&reg; License Agreement, run the following command. The properties file you specify determines whether this instance of Cloudant Local is used for production or development purposes.
<p><code>./cloudant-1.1.0-984-el6-x86_64.bin -- -s</code></p></li></ol></li>
</ol>

### Installing the first database node

Install and configure the first database node in the cluster.
{:shortdesc}

1. Run the CAST installation command to install the first
   database node of the cluster.

   ``` sh
   cast system install -p dbadmin_password -db
   ```
   {:codeblock}

#### Options

Flag                  | Purpose
----------------------|--------
`-db` _or_ `--dbnode` | Flag to install a database node.
`-p` _or_ `--password` | An optional flag to specify the database admin password. If you do not provide a password, the password defaults to `pass`.

2. Run the `export` command to export configuration values to a
   file.

   ``` sh
   cast cluster export cluster_dbnode.yaml
   ```
   {:codeblock}

   >    **Note**: For each additional database node in the cluster, you must use the same configuration file. To join the nodes together into a cluster, the configuration file must be the same on each host and contain the same passwords and cookie values for each user.

3. Copy the resulting `cluster_dbnode.yaml` file to a place that is
   accessible when you install more database nodes.

### Installing additional database nodes

You can add a database node to your cluster after the first node
is installed.
{:shortdesc}

Run the `cast system install` command to add a database node.

``` sh
cast system install -c cluster_dbnode.yaml -db
```
{:codeblock}

#### Options

Flag                  | Purpose
----------------------|--------
`-db` _or_ `--dbnode` | Flag to install a database node.
`-c` _or_ `--config`  | The cluster configuration file exported from the first node.
`--maintenance`       | Start the system in maintenance mode. 

You added a database node. Next, you must join the cluster.

### Joining nodes in a cluster

After you install and configure all the database nodes, you must
join them together to form the cluster.
{:shortdesc}

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

During a new installation and after all the database nodes are
joined to the cluster, you must initialize the cluster.
{:shortdesc}

1. Run the following command from one of the database nodes to
   initialize the cluster.

   ``` sh
   cast cluster init
   ```
   {:codeblock}

2. Install a load balancer.


### Installing load balancer nodes

Install and configure each load balancer node in the cluster by
following these steps.

1. Install a load balancer node by running the following command.

    ``` sh
    cast system install -lb
    ```
    {:codeblock}

#### Options

Flag                  | Purpose
----------------------|--------
`-lb` _or_ `--lbnode` | Flag to install a load balancer node.


2.  Copy the load balancer node configuration file,
    `/opt/cloudant/cast/samples/lbnode.yaml`.

3.  Update the host name and IP address values for each database
    node in the cluster under the Nodes section of the
    configuration file.

4.  Replace the host name with the FQDN.

    ``` sh
    hostname: xxx.xx
    ipaddress: xxx
    ```
    {:codeblock}

5.  Change the default admin password from `pass` as shown in the
    sample.

    ``` sh
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
    ```
    {:codeblock}

6.  Save the configuration file and update the node with the new
    values by running the following command.

    ``` sh
    cast node config lbnode.yaml
    ```
    {:codeblock}

    After you run the `cast node config` command, the load balancer
    node is configured. After you complete the installation of the
    database nodes and initialize the cluster, verify the
    installation by [Starting the Cloudant Local Dashboard](clinstall_start_cl_dashboard.html).

## Installing a single node

If you want to install Cloudant&reg; Local in a single-node
implementation instead of a cluster, you must install the load
balancer and database nodes to run on the same node. In most
cases, a stand-alone node is installed for development or
demonstration purposes and uses the default configuration
settings.

>   **Note:** This implementation is not recommended for a production environment.

<!-- Reset markdown parser. -->

1.  Install a single node by running the following command.

    ``` sh
    cast system install -p dbadmin_password -lb -db
    ```
    {:codeblock}

### Options

Flag                  | Purpose
----------------------|--------
`-db` _or_ `--dbnode` | Flag to install a database node.
`-lb` _or_ `--lbnode` | Flag to install a load balancer node.
`-p` _or_ `-password` | (Optional) flag to set the database admin password. If you do not provide a password, the password defaults to `pass`. 
    
2.  Run the following command to initialize the single node cluster.

    ``` sh
    cast cluster init
    ```
    {:codeblock}
    
## Installing Cloudant Local offline

Install Cloudant&reg; Local offline by following these instructions.

An online system has internet access and full access to the package
repositories, while an offline system has no access to the internet.
You must download the third-party dependencies, bundle them into a `tar`
file, and transfer them to the offline system for installation.

### Prerequisites

Before you install Cloudant Local offline, you must meet the
following prerequisites.

1.  You must be a root user or have sudo privileges.

2.  You must run a download-only or dry-run installation.  
    You run a dry-run installation from a system that has internet
    access and runs the same version of the operating system as the
    target system. The new system is called the online system.

#### Installing Third-party Package Dependencies

Cloudant&reg; Local depends on several third-party packages. Before
you install Cloudant Local, the third-party packages must be
installed on the offline system. You can use the dry-run
installation option to bundle and transfer the dependencies to
your offline system. The dry-run installation option is supported
by the operating system package managers that Cloudant Local
uses.

Before you begin,
you must configure access to the following external repositories
on the online system.

*   Operating system-specific package repositories (EPEL, and so on)
*   Python Package Index (PyPI) site

#### Installing Red Hat dependencies

For Red Hat and CentOS platforms, you must bundle the
dependencies and transfer them to the offline system.

<ol>
<li>Log in to your Red Hat online system to install the Red Hat dependencies.
<ol type="a"> 
<li>Install the EPEL repository.
<p>
```
yum install epel-release
```
</p></li>
<li>Run the Cloudant&reg; Self-Extracting Archive. See [Installing Cloudant Local packages](clinstall_extract_cl_install_packages.html).
<p>
`
./cloudant-<version>-<os>-<arch>.bin
`
</p></li>
</ol>
</li>
<li>Bundle the dependencies into a compressed (tar) file by running the following commands.
<p>
`yum install createrepo` <br>
`mkdir cloudant-deps` <br>
`yum reinstall -y --downloadonly --downloaddir=cloudant-deps cloudant-dbnode cloudant-lbnode iptables-services python2-pip` <br>
`createrepo cloudant-deps` <br>
`tar -czvf cloudant-deps.tar.gz cloudant-deps`
</p></li>
<li>Copy the file to the offline system.
<p>
`cp cloudant-deps.tar.gz offline.system.com:/tmp`</p></li>
<li>Log in to the offline system.</li>
<li>Set up the repository for the Cloudant&reg; dependencies.
<p>
`cd /tmp` <br>
`tar -xvf cloudant-deps.tar.gz`<br>
<br>
`echo "[cloudant-deps]" >> /etc/yum.repos.d/cloudant-deps.repo`<br>
`echo "name=IBM, Cloudant Dependencies" >> /etc/yum.repos.d/cloudant-deps.repo`<br>
`echo "baseurl=file:///tmp/cloudant-deps" >> /etc/yum.repos.d/cloudant-deps.repo`<br>
`echo "enabled = 1" >> /etc/yum.repos.d/cloudant-deps.repo`<br>
`echo "gpgcheck = 0" >> /etc/yum.repos.d/cloudant-deps.repo`<br>
<br>
`yum clean all`
</p>
</li></ol>


#### Installing SUSE dependencies

You must bundle the SUSE dependencies and transfer them to the
offline system.

<ol>
<li>Log in to your SUSE online system to install the SUSE dependencies.
<ol type="a">
<li>Download `pip-9.0.1.tar.gz` file from [https://pypi.python.org/pypi/pip ![External link icon](images/launch-glyph.svg "External link icon")](https://pypi.python.org/pypi/pip).</li>
<li>Install `python-pip`.
<p>`tar -xvf pip-9.0.1.tar.gz`<br>
`cd pip-9.0.1.tar.gz`<br>
`python setup.py install`
</p></li>
<li>Run the Cloudant&reg; Self-Extracting Archive.
<p>`./cloudant-<version>-<os>-<arch>.bin`</p></li>
</ol></li>
<li>Download and bundle the dependencies into a compressed (tar)
    file by running the following commands.
<p>`zypper -n install createrepo`<br>
`mkdir cloudant-deps`<br>
`zypper --pkg-cache-dir=cloudant-deps download java-1_7_0-openjdk java-1_7_0-openjdk-headless java-1_7_0-openjdk-devel curl rsyslog lcms2 timezone-java python-setuptools python-base python-pip python-setuptools`<br>
`createrepo cloudant-deps`<br>
`tar -czvf cloudant-deps.tar.gz cloudant-deps`</p>    </li>
<li>Copy the compressed (tar) file to the offline system.
<p>`scp cloudant-deps.tar.gz <offline.system.com>:/tmp`<br>
`scp pip-9.0.1.tar.gz <offline.system.com>:/tmp`</p></li>
<li>Log in to the offline system.</li>
<li>Set up the repository for the Cloudant dependencies.
<p>`cd /tmp`<br>
`tar -xvf cloudant-deps.tar.gz`<br>
`zypper -n addrepo —no-gpgcheck /tmp/cloudant-deps cloudant-deps`<br>
`zypper refresh`<br>
`zypper install python-pip`<br>
`tar -xvf pip-9.0.1.tar.gz`<br>
`cd pip-9.0.1`<br>
`python setup.py install`</p></li>
</ol>

#### Installing Ubuntu dependencies

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
    
    ``` sh
    ./cloudant-<version>-<os>-<arch>.bin
    ```
    {:codeblock}

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

7.  Install the Cloudant dependencies.
    
    ``` sh
    cd /tmp
    tar -xvf cloudant-deps.tar.gz
    dpkg -i cloudant-deps/*
    ```
    {:codeblock}
    
#### Installing Python dependencies

After you transfer the third-party dependencies, you must
transfer the Python dependencies from the online system.

>   **Note:** You must apply these steps to each platform in your environment.

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

### Running the Cloudant self-extracting archive</title>

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

After you install the third-party repositories on the offline system,
you can continue installing the database and load balancer node.

1.  [Install the first database node](clinstall_install_first_db_node.html).

2.  [Install load balancer nodes](clinstall_install_load_balancer_nodes.html).

3.  Verify that the installation was successful by starting the
    Cloudant&reg; Dashboard that uses the load balancer node URL,
    `http://loadbalancer_url/dashboard.html`.

## Starting the Cloudant Local Dashboard

Start the Cloudant&reg; Local Dashboard to verify that Cloudant Local
was successfully installed on each load balancer.
{:shortdesc}

1.  Start and stop the dashboard by using the following commands.

    ``` sh
    cast node start
    cast node stop
    ```
    {:codeblock}

2.  Enter the following URL in a web browser to access the dashboard.

    ``` sh
    http://your_load_balancer_IP_address/dashboard.html
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

4.  Enter your database administration credentials at the Cloudant Dashboard.

    When you successfully authenticate to the Cloudant Local
    Dashboard, your installation is complete.
    
## Uninstalling Cloudant Local

Uninstall Cloudant&reg; Local with the `cast system uninstall` command.

<ol>
<li>Stop the database node before you run the `cast system uninstall` command.
<p>`cast node stop`</p></li>
<li>To uninstall Cloudant Local, log in with the same user
    ID that you used during your first installation.
    <p>For example, if you installed Cloudant Local as the
    root user, you must uninstall Cloudant Local as the
    root user.</p></li>
<li>Run the `cast system uninstall` command to uninstall Cloudant
    Local services and the CAST tool.
    <p>`cast system uninstall`</p></li>
<li>Verify that no processes are running.
<p>If any processes are running, reboot the system to clean up hanging processes.</p>
<ol type="a">
<li>Log in as the root user or a user with sudo privileges.</li>
<li>Run the `sudo reboot` command.
<p>`sudo reboot`</p>
<p>Cloudant Local is uninstalled.</p></li>
</ol></li>
</ol>
