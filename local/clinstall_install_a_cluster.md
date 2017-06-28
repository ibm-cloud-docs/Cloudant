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

# Installing a cluster

Install and configure a Cloudant&reg; Local cluster.
{:shortdesc}

You use the Cluster Admin and Support Tool (CAST) which manages
the installation, configuration, and support of a Cloudant Local
cluster and its individual nodes.

## Before you begin

Before you install Cloudant&reg; Local, confirm that your system
meets the following requirements.
{:shortdesc}

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

## Installing Cloudant Local packages

To install (or uninstall) Cloudant&reg; Local, you must be a root
user or use the `sudo` command.
{:shortdesc}


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

## Installing the first database node

Install and configure the first database node in the cluster.
{:shortdesc}

1. Run the CAST installation command to install the first
   database node of the cluster.

   ``` sh
   cast system install -p dbadmin_password -db
   ```
   {:codeblock}

### Options

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

## Installing additional database nodes

You can add a database node to your cluster after the first node
is installed.
{:shortdesc}

Run the `cast system install` command to add a database node.

``` sh
cast system install -c cluster_dbnode.yaml -db
```
{:codeblock}

### Options

Flag                  | Purpose
----------------------|--------
`-db` _or_ `--dbnode` | Flag to install a database node.
`-c` _or_ `--config`  | The cluster configuration file exported from the first node.
`--maintenance`       | Start the system in maintenance mode. 

You added a database node. Next, you must join the cluster.

## Joining nodes in a cluster

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

## Initializing the cluster

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


## Installing load balancer nodes

Install and configure each load balancer node in the cluster by
following these steps.

1. Install a load balancer node by running the following command.

    ``` sh
    cast system install -lb
    ```
    {:codeblock}

### Options

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