---

copyright:
  years: 2015, 2020
lastupdated: "2020-02-12"

keywords: stop and start service, add node, maintenance mode, rebalancing plan, remote access, run rebalancing plan, replace database node, replace load balancer node, tune automatic compacter, smoosh channels, metrics database

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

<!-- Acrolinx: 2020-02-12 -->

# Maintenance
{: #maintenance}

Maintain your {{site.data.keyword.IBM}} Cloudant&reg; Data Layer Local Edition ({{site.data.keyword.cloudant_local_notm}}) cluster by running the following
tasks.
{: shortdesc}

## Stop and start {{site.data.keyword.cloudant_local_notm}} services
{: #stop-and-start-ibm-cloudant-local-services}

Start, stop, and restart your {{site.data.keyword.cloudant_local_notm}} services with the
cast node command by specifying the correct option. You can also
display the status of various processes and test the {{site.data.keyword.cloudant_local_notm}} API.


*   Start all {{site.data.keyword.cloudant_local_notm}} services.

    ``` sh
    cast node start
    ```
    {: codeblock}

*   Stop all {{site.data.keyword.cloudant_local_notm}} services.

    ``` sh
    cast node stop
    ```
    {: codeblock}

*   Restart all {{site.data.keyword.cloudant_local_notm}} services. Use the `restart` command
    to restart your services after you change the configuration
    file.

    ``` sh
    cast node restart
    ```
    {: codeblock}

*   (Optional) Display the syntax help text for the CAST command.

    ``` sh
    cast system install --help
    ```
    {: codeblock}
    
## Add a node to a cluster
{: #add-a-node-to-a-cluster}

Follow these steps to add a node to the cluster.


### Using the modified configuration process
{: #using-the-modified-configuration-process}

Add a node to a cluster, rebalance shards, and configure a node
by using the modified configuration process. The node must be in
maintenance mode to prevent errors when it's brought into the
cluster. The load balancers must be configured to direct traffic to the
new node.

#### Provision the new node
{: #provision-the-new-node-}

1.  Install {{site.data.keyword.cloudant_local_notm}} on the database node that you're
adding, as described in [Installing additional database nodes](/docs/Cloudant?topic=cloudant-install-ibm-cloudant-local#installing-additional-database-nodes).

2.  Run the `cast system install` command by passing the
cluster configuration from your current `dbnode.yaml` file.

3.  Put the node in maintenance mode after installation.

    ``` sh
    cast node maintenance --true
    ```
    {: codeblock}

#### Confirm that the node is in maintenance mode
{: #confirm-that-the-node-is-in-maintenance-mode-}

1.  Run the following command to confirm that the node is in
maintenance mode.

    ``` sh
    cast node maintenance
    ```
    {: codeblock}
    
2.  See that the response shows the status of the node.
    
    ``` sh
    The node is IN maintenance mode.
    ```
    {: codeblock}

#### Add the new node to the nodes database on one of the existing nodes
{: #add-the-new-node-to-the-nodes-database-on-one-of-the-existing-nodes}

1.  SSH into one of the existing database nodes.

    ``` sh
    cast cluster add {new_node_hostname}
    ```
    {: codeblock}

2.  Add the new node to its nodes database.

3.  Verify that the node was successfully added to the nodes database.

    ``` sh
    cast cluster status
    ```
    {: codeblock}

####  Update the load balancer configuration
{: #update-the-load-balancer-configuration-}

The load balancers must know to direct traffic to the new
node.

1.  For each load balancer, add the new node to the list of
    nodes in the `lbnode.yaml` file.

2.  Restart `haproxy` after you save the changes.

3.  Verify that your load balancer can correctly access the new node.

    Configuration changes and restarts to the load balancer can affect traffic. How these changes are made depends on your setup. If you're running a failover load balancer, confirm that it's running correctly and you can access the cluster through it. Then, make the required changes, such as DNS settings, to reroute all traffic through the failover load balancer.
    {: note}

4.  Edit the `lbnode.yaml` file that was created during initial
    cluster installation to add the new database node.

5.  Run the `cast node` config command as seen in the example.

    ``` sh
    cast node config /opt/cloudant/cast/samples/lbnode.yaml
    ```
    {: codeblock}

#### Create a rebalancing plan
{: #create-a-rebalancing-plan}

1.  If you're using more than one load balancer, run the
    rebalancing process from any of your load balancers.

2.  If you don't have a configuration file for the
    rebalancer, save the newly created `rebal.ini` to the home directory
    for the user on the load balancer.

3.  Remove the line breaks from the comment lines that start
    with the number sign (`#`).

    See the format of the configuration file in the following
    example.

    ``` sh
    [cloudant]
    # System user that runs the db process
    db_user = cloudant
    # Server-wide database admin credentials. These have to be identical for every node of the cluster.
    rebal_user =
    rebal_password =
    # Default file name for rebalance plans.
    rebal_plan = rebalance_plan
    # Mapping between public and private host names for nodes. This plan is only needed if
    # the host names have a private and a public interface and the load balancer does
    # not have access to the private interface. If the private host name can be used,
    # these fields can remain blank. Otherwise, the private host name extension
    # is replaced with the public host name extension to arrive at the public host name.
    # If you're unsure, leave these empty.
    
    private_host_ext =
    public_host_ext =
    [rebal]
    # Set to true to disable prompts on failure and just continue
    batch_mode = false
    ```
    {: codeblock}

4.  Verify that the admin credentials in the configuration
    file, `rebal_user` and `rebal_password`, are correct by 
    logging in to one of the database nodes with SSH by
    running the following command.

     ``` sh
    curl http://{admin:password}@localhost:5986/_active_tasks
    ```
    {: codeblock}

5.  Replace `admin:password` in the preceding command with the credentials for the database administrator.
    If you specify the wrong credentials, you receive an error message.

#### Set up remote access for the rebalancer
{: #set-up-remote-access-for-the-rebalancer}

The rebalancer runs on the load balancer and needs SSH access to the database nodes to run the operations that are required to move shards between database nodes. The Cloudant Local installer creates a `cloudantrebal` user account on every database node in your cluster for the rebalancer. During installation, this account is configured with the permissions and path that are required to do the operations that the rebalancer needs to do with SSH. The `cloudantrebal` account eliminates some of the work an operator must do to set up a cluster rebalance.
{: note}

#### Generate a pair of public and private keys for SSH access
{: #generate-a-pair-of-public-and-private-keys-for-ssh-access}

On the load balancer, as the root user, generate a pair of public and private keys for SSH access to the rebalancer.
See the following example.

```
> cd ~/.ssh
> ssh-keygen -t rsa
```
{: codeblock}

### Setting up remote access for the rebalancer
{: #setting-up-remote-access-for-the-rebalancer}

The rebalancer runs on the load balancer. It needs SSH access to
the database nodes to run the operations that are required to
move shards between database nodes. The {{site.data.keyword.cloudant_local_notm}} installer
creates a `cloudantrebal` user account on every database node in
your cluster for the rebalancer. During installation, this
account is configured with the permissions and path that are
required to do the operations that the rebalancer requires with
SSH. The `cloudantrebal` account eliminates some of the work an
operator must do to set up a cluster rebalance.

<ol>
<li>On the load balancer, as a root user, generate a pair of
    public and private keys for SSH access to the rebalancer.
<p><code>>  cd ~/.ssh</code><br>
<code>>  ssh-keygen -t rsa</code></p>
<ol type=a>
<li>Enter a name for the key file, or leave it as the default.</li>
<li>Record the passphrase that you enter for the key creation. 
<p>The result is to produce two key files in the <code>~/.ssh</code> folder.</p>
<ul><li>A private key file with the default name <code>id_rsa</code>.</li>
<li>A public key file with the default name <code>id_rsa.pub</code>.</li></ul>
</li></ol></li>
<li>Add the public and private keys to every database node in your cluster.
<p><b>Note</b>: The controlling node is defined as the node where you run `rebal` (in this case your load balancer). The new node is the database node that you just added to the cluster.</p></li>
<li>Set up the public and private keys.
<p><b>Note</b>: The `rebal` command uses SSH to communicate between the controlling node and database nodes (existing and new), and also between nodes that run `rsync` to copy shards between nodes.</p>
<ol type=a><li>Create an authorized_keys file in <code>/opt/cloudantrebal/.ssh</code>.</li>
<li>Add the public key to the <code>/opt/cloudantrebal/.ssh/authorized_keys</code> file on all the database nodes, including the one you're adding.</li>
<li>Copy the public and private keys to `/opt/cloudantrebal/.ssh`.</li>
<li>Ensure that the `owner:group` is `cloudantrebal:Cloudant`.
<p>The private key has permission, `0600`, and the public key has permission, `0644`. See the following example.</p>
<p><pre><code>cloudantrebal@db1:~/.ssh$ ls -la
        total 20
        drwxr-xr-x 2 cloudantrebal cloudant 4096 Mar 27 23:57 .
        drwxr-xr-x 3 cloudantrebal cloudant 4096 Mar 27 23:57 ..
        -rw-r--r-- 1 cloudantrebal cloudant  395 Mar 27 23:57 authorized_keys
        -rw------- 1 cloudantrebal cloudant 1675 Mar 27 23:57 id_rsa
        -rw-r--r-- 1 cloudantrebal cloudant  395 Mar 27 23:57 id_rsa.pub
</code></pre></li>
<li>Test that you can SSH from your existing database nodes to the new node by using the following command.
<p><code>cloudantrebal@db1:~/.ssh$ ssh new-db-node.example.com</code></p></li>
</ol></li>
<li>On the load balancer, create the following entry in the <code>~/.ssh/config</code> file for the account that you're using to run the rebalancer.
<pre><code>Host *.yourcluster.yourdomain.com
User cloudantrebal
</code></pre></li>
<li>If you use <code>ssh-agent</code> to manage the SSH credentials for the
    rebalancer, ensure that you specify the private key by
    providing the file name to `ssh-add`.
<pre><code>> eval $(ssh-agent)
> ssh-add ~/.ssh/id_rsa
</code></pre></li>
<li>Enter the passphrase of the key when prompted.
<p><strong>Note</strong>: When you enter the passphrase for the key, the passphrase is saved for the current ssh session. You run the commands again if you open a new ssh session on the load balancer, for example, when you run the rebalance shards scripts in later steps.</p></li>
<li>Confirm that the database nodes are accessible with SSH from the load balancer, such as by configuring <code>ssh-agent</code>.</li>
<li>Verify the access by trying to SSH into all database nodes from the load balancer.</li>
</ol>
</li></ol>

### Creating a rebalancing plan
{: #creating-a-rebalancing-plan}

After the rebalancer is configured and the ssh-agent is set up,
you can start the rebalancing process by creating a rebalancing
plan.


1.  Create a working directory to hold the plan and log files and
    change to that working directory by specifying these commands.

    ``` sh
    mkdir rebaldir
    cd rebaldir
    ```
    {: codeblock}

2.  Create the plan by running `rebal plan expand` with one of the
    database nodes as an argument, as shown in the following
    example.

    ``` sh
    rebal plan expand 'db1.cluster001.example.com'
    ```
    {: codeblock}

3.  Check the output from this command for any error messages
    similar to this one.

    ``` sh
    Retrying SSH connection
    ```
    {: codeblock}

4.  If you receive a similar error message, check the `ssh-agent`
    configurations and confirm that you can SSH to all database
    nodes, without specifying a password.

    Your current directory now includes a `rebalance_plan` file that
    includes a list of shard moves.
    
### Putting a new node into production mode
{: #putting-a-new-node-into-production-mode}

You must take the new node out of maintenance mode so it can
serve traffic for the moved shards, while the rebalancing is in
progress.


1.  Run the cast node command to take the node out of maintenance
    mode.

    ``` sh
    cast node maintenance --false
    ```
    {: codeblock}

2.  Run the following command on the new database node to verify
    the status of that node.

    ``` sh
    cast node maintenance
    ```
    {: codeblock}

    If the node is functioning normally in production mode, you
    receive this response.

    ``` sh
    The node is OUT of maintenance mode.
    ```
    {: codeblock}

### Running a rebalancing plan
{: #run-a-rebalancing-plan}

Before you continue, confirm that no other shard moves are
running on the same cluster. Moving many shards of the same
database concurrently can lead to data loss.


<ol>
<li>Run your rebalancing plan, and replace <code>rebalance_plan_file_name</code>
    with the file name for your rebalance plan.
<p><strong>Note</strong>: The file name was specified earlier when you edited the <code>rebal.ini</code> file when you created a rebalancing plan. The command runs the shard moves identified in the plan. Shards moves are batched by database name with each batch that is run in a series. Many batches are run concurrently; the default is 20 batches that run at once. Progress and errors are logged to the <code>rebalance_plan.log</code>.
</br>
<code>rebal run <em>rebalance_plan_file_name</em></code></p>  </li>
<li>Monitor progress by using the <code>tail</code> command.
</br><code>tail -f rebalance_plan.log</code>
</li>
<li>To troubleshoot errors, check the log files for the presence
    of <code>sudo</code> or <code>tty</code> errors. If you find errors, do the following
    tasks for the <code>/etc/sudoers</code> file on all the database nodes.
<ol type=a>
<li>Search for a line that includes.
<p><code>Defaults requiretty</code></p></li>
<li>Modify the line to read.
<p><code>Defaults !requiretty</code></p></li>
<li>Add the following lines to the file.
<p><code>cloudantrebal   ALL=(ALL) NOPASSWD: ALL</code><br>
<code>%cloudant       ALL=(ALL) NOPASSWD: ALL</code></p>
</li>
</ol>
 </li>
<li>Check whether it's a problem with the configuration of <code>rebal</code>
    or <code>ssh-agent</code>.</li>
<li>Confirm that <code>ssh-agent</code> is set up correctly and that the <code>.rebal</code>
    file includes the proper credentials.
</li>
<li>Check whether more than one <code>erl_call: failed to connect to node</code>
    messages in the <code>dbname.out</code> files exist. If several messages
    exist, you might need to reduce the concurrency of the
    rebalancing process.
</br><code>rebal run --concurrency <em>rebalance_plan_file_name</em></code>
<p>This command reduces the number of concurrent shard moves to 5
    from the default of 20.</p></li>
<li>Run the rebalancing process again with the <code>rebal run</code> command
    and the appropriate <code>rebalance_plan_</code> file name. 
    <p>The problem
    might be a temporary issue, such as an unreachable or
    overloaded node, leading to a timeout. Rebalancing in this way
    doesn't cause a shard to have too few copies, but it might
    result in shards with more than the expected number of copies.</p></li>
<li>If you see <code>rsync</code> errors in the log file, verify that <code>rsync</code> is
    installed and operational on all database nodes. 
    <p>Otherwise,
    install <code>rsync</code> package on all the nodes. For example, on Red Hat
    platforms, use the <code>yum install rsync</code> command to install <code>rsync</code>.
    If you checked the configuration and tried to rerun the shard
    moves, but the problem persists, contact support.</p></li>
</ol>

### Verifying the new node
{: #verifying-the-new-node-with-weatherreport}

Confirm that the new node is set up correctly.

1.  Log in to the new node with SSH and run `Weatherreport`.

    ``` sh
    /opt/cloudant/bin/weatherreport
    ```
    {: codeblock}

2.  If errors are reported during the run, see the
    [information](/docs/Cloudant?topic=cloudant-diagnose-troubleshoot#monitor-cluster-health-with-weatherreport) for
    `Weatherreport` checks, or call support.

3.  After the run finishes, check the rebalancing logs that are
    described in the [Run rebalancing](#run-a-rebalancing-plan) step for any errors.

4.  Verify whether the shards for different databases are now
    distributed across the recently added node. The following
    command checks the shard map for a database.

    ``` sh
    curl -X GET http://localhost:5986/dbs/default%2Fdatabase_name | python -m json.tool | less
    ```
    {: codeblock}

    Look at the `by_node` key in the output from this command to
    determine whether the shards are spread evenly across the
    cluster nodes.

   Weatherreport is a command line application that provides information about the status of a dbcore node or cluster. Weatherreport is useful in troubleshooting cluster issues, such as increased latencies, low disk space, or node failures. For more information about Weatherreport, see [Monitor cluster health with Weatherreport](/docs/Cloudant?topic=cloudant-diagnose-troubleshoot#monitor-cluster-health-with-weatherreport).
   {: note}

## Replace a node
{: #replace-a-node}

Use these instructions to replace an {{site.data.keyword.cloudantfull}} database or load
balancer node.



### Replacing a database node
{: #replacing-a-database-node}

You can rebuild or replace a database node by using the following
instructions.


<ol>
<li>Run the following <code>safe_to_rebuild</code> command on the node to determine whether you can decommission the node: 
<p><code>/opt/cloudant/bin/weatherreport safe_to_rebuild</code>.</p>

<ol type=a>
<li>If you can rebuild or replace the node, no diagnostic messages are displayed in response to this command.
</li>
<li>If it's not safe, one or more shard ranges are reduced to one or zero live copies. 
<p>In that case, an error message (for one live copy) or a critical message (for zero live copies) is displayed with the shard ranges affected.</p>
</li>
<li>If any messages are returned, make sure that the shards
    have enough copies in live nodes before you replace the
    node.
<p><strong>Note</strong>: Weatherreport is a command line application that provides information about the status of an {{site.data.keyword.cloudant_short_notm}} node or cluster. It's useful in troubleshooting cluster issues, such as increased latencies, low disk space, or node failures. For more information about Weatherreport, see [Monitor cluster health with Weatherreport](/docs/Cloudant?topic=cloudant-diagnose-troubleshoot#monitor-cluster-health-with-weatherreport).</p>
</li>
</ol>
</li>
<li>If the node is running, stop any services that are running on
    the node and shut it down.</li>
<li>Repair or replace the node.</li>
<li>Install {{site.data.keyword.cloudant_local_notm}} on the database node, as described in
    [Installing additional database nodes](/docs/Cloudant?topic=cloudant-install-ibm-cloudant-local#installing-additional-database-nodes).</li>
<li>Run <code>cast system install</code>.

<ol type=a>
<li>Pass the <code>--maintenance</code> flag and the original <code>cluster_dbnode.yaml</code> file that was used to set up the node initially.
<p><code>cast system install --maintenance -db -c cluster_dbnode.yaml</code></p>
</li>
<li>(Optional) If you don't have the original <code>cluster_dbnode.yaml</code> file, you can generate a new one by running the <code>cast cluster export</code> command from an existing node.
<p><code>cast cluster export cluster_dbnode.yaml</code></p></li>
</ol>
</li>
<li>Confirm that the node is in maintenance mode by using the
    following command.
<p><code>cast node maintenance</code></p>
</li>
<li>If the node is in maintenance mode, the response shows the
    status of the nodes.
<p><code>The node is IN maintenance mode.</code></p></li>
<li>In maintenance mode, the node starts the process to bring
    itself back into a working state and ready for traffic.
<ol type=a>
<li>Monitor the process by checking the node's log files to
    determine how many <code>pending_changes</code> wait for the internal
    replication and indexing processes.
    <p>See the following example.</p>
<p><code><0.3333.0> - mem3_sync shards/00000000-3fffffff/dbname.1407441053 cloudant@db1.cluster001.cloudant.net {pending_changes,62}</code></p>
</li>
<li>Check the number of pending internal replication tasks by running the following command in a terminal window on one of the database nodes.
<p><code>/opt/cloudant/bin/weatherreport -a -d info internal_replication</code></p>
<p>If the internal replication is complete, the output from this command indicates that the number of pending internal replication jobs is 0 or close to 0 for the database node. Additionally, the active tasks section of the Metrics application shows the number of indexing processes.</p>
</li>
</ol>
</li>
<li>After the node reaches the point where only a few indexing tasks are running, take the node out of maintenance mode and put it in production mode.</li>
</ol>


### Replacing a load balancer node
{: #replacing-a-load-balancer-node}

You can rebuild or replace a load balancer node by using the
following instructions.



<ol>
<li>Stop traffic to the load balancer node before you remove it. You stop your load balancer based on your setup.
<ol type=a>
<li>If you run a failover load balancer, confirm that it's
    operating correctly and can access the cluster with that
    load balancer.</li>
<li>Make any required changes, such as changes to DNS
    settings, to reroute all traffic through the failover
    load balancer.</li>
</ol>
</li>
<li>If the node is running, stop any services that are running on
    the node and shut it down.</li>
<li>Repair or replace the node.</li>
<li>Install {{site.data.keyword.cloudant_local_notm}} on the load balancer node, as
    described in [Installing load balancer nodes](/docs/Cloudant?topic=cloudant-install-ibm-cloudant-local#installing-load-balancer-nodes).</li>
<li>Configure the <code>lbnode.yaml</code> file with your current cluster
    configuration when you run the <code>cast system install</code> commands.
</li>
<li>Verify that the replacement load balancer is operational.
<p>You can check by directly accessing the load balancer and
    confirming that you get a valid response.</p></li>
<li>Send traffic to the load balancer again.
<ol type=a>
<li>If you're running a failover load balancer, confirm that
    it's running correctly.</li>
<li>To reroute all traffic through the failover or
    replacement load balancer, make the required changes,
    such as DNS settings.</li>
</ol></li>
</ol>

## Tune the {{site.data.keyword.cloudant_local_notm}} automatic compactor
{: #tune-the-ibm-cloudant-local-automatic-compactor}

Read these instructions to understand how the {{site.data.keyword.cloudant_local_notm}}
automatic compactor works and how you can tune it. The automatic
compactor for {{site.data.keyword.cloudant_short_notm}} databases is an application that is called
Smoosh. Smoosh automatically selects and processes the compacting
of database shards on each node.


### Smoosh Channels
{: #smoosh-channels}

Smoosh uses the concept of channels. A channel is essentially a queue of pending compactions. Database and view compactions use separate channels. Each channel is assigned a configuration that defines whether a compaction ends up in the queue for the channel and how compactions are prioritized within that queue. Smoosh takes each channel and works through the compactions queued in each in priority order. Each channel is processed concurrently, so the priority levels only matter within each channel. Finally, each channel has an assigned number of active compactions, which defines how many compactions happen in parallel for that channel.

For example, a cluster with many database writes but few views
might require more active compactions to the database channels. A
channel is local to a dbcore node, so each node maintains and
processes an independent set of compactions.

### Channel configuration options
{: #channel-configuration-options}

You can configure channels by using the following processes and
options. The channel type is set with the priority configuration
setting.

#### Channel types
{: #channel-types}

Each channel has a basic type for the algorithm it uses
to select pending compactions for its queue and how it
prioritizes them. The following list describes two queue
types.

-   `ratio`

    Uses the ratio `total_bytes / user_bytes` as its
    driving calculation. The result `X` must be
    greater than some configurable value `Y` for a
    compaction to be added to the queue.
    Compactions are then prioritized for higher
    values of `X`.

-   `slack`

    Uses the `total_bytes - user_bytes` as its
    driving calculation. The result `X` must be
    greater than some configurable value `Y` for a
    compaction to be added to the queue.
    Compactions are prioritized for higher values
    of `X`.

    In both cases, `Y` is set with the `min_priority` configuration variable. The calculation of `X` is described in [Priority calculation](#priority-calculation). Both algorithms use the following two measures.

-   `user_bytes`

    The amount of data the user has in the file. It
    doesn't include storage, such as old revisions
    or on-disk b-tree structure.

-   `total_bytes`

    The size of the file on disk.

#### Further configuration options
{: #further-configuration-options}

Beyond its basic type, you can apply several other
configuration options to a queue. All options must be
set as strings. For all settings and defaults, see the
Smoosh configuration section.

#### Priority calculation
{: #priority-calculation}

The algorithm type and certain configuration options
feed into the priority calculation. The priority is
calculated when a compaction is enqueued. Since each
channel has a different configuration, each channel ends
up with a different priority value. The enqueue code
checks each channel in turn to see whether the
compaction passes its configured priority threshold
(`min_priority`). After a channel is found that can accept
the compaction, the compaction is added to the queue for
that channel and the enqueue process stops. The ordering of channels, based on the priority calculation, impacts where the compaction ends up. 

#### Background Detail
{: #background-detail}

To get metadata about a shard, you can query
`$host:5986/shards%2F$shard%2f$dbname`, where `$host` is the
database node on which the shard is `$shard` and `$dbname`
is the name of the database. To get a list of all shards
on a database, query the `/$dbname/_shards` endpoint.

``` sh
$ curl -X GET 'http://localhost:5986/shards%2F$shard%2Fdefault%2F$database.$timestamp'
```
{: codeblock}

You can find the string to replace the `$timestamp` value
in this directory: `/srv/cloudant/db/shards/`. Look for
file names that start with the database name and copy
the number that follows the database name. For example,
the following files are in a database that is named
`authorization2` under the directory, `/srv/cloudant/`.

``` sh
./db/shards/20000000-3fffffff/default/authorization2.1434466035.couch
./db/shards/c0000000-dfffffff/default/authorization2.1434466035.couch
./db/shards/a0000000-bfffffff/default/authorization2.1434466035.couch
./db/shards/e0000000-ffffffff/default/authorization2.1434466035.couch
./db/shards/80000000-9fffffff/default/authorization2.1434466035.couch
./db/shards/00000000-1fffffff/default/authorization2.1434466035.couch
./db/shards/40000000-5fffffff/default/authorization2.1434466035.couch
./db/shards/60000000-7fffffff/default/authorization2.1434466035.couchss
```
{: codeblock}

You can use the following query to collect shard
metadata for this example.

``` sh
curl -X GET 'http://localhost:5986shards%2F00000000-1fffffff%2Fdefault%2Fauthorization2.1434466035'
```
{: codeblock}

This command returns a JSON structure like the one shown
in the following example, where the `data_size` field
corresponds to `user_bytes` in the priority calculation
for `ratio` or `slack` channels.

``` json
{
    "committed_update_seq": 4,
    "compact_running": false,
    "compacted_seq": 0,
    "data_size": 1115,
    "db_name": "shards/00000000-1fffffff/exampleDB",
    "disk_format_version": 6,
    "disk_size": 2740400,
    "doc_count": 0,
    "doc_del_count": 0,
    "instance_start_time": "1412077801084432",
    "other": {
        "data_size": 0
    },
    "purge_seq": 0,
    "sizes": {
        "active": 1115,
        "external": 0,
        "file": 2740400
    },
    "update_seq": 4,
    "uuid": "a1995bbab83dee7072b69b640942a81b"
}
```
{: codeblock}

The `user_bytes` are called `data_size` in `db_info` blocks.
it's the total of all bytes that are used to store docs
and their attachments. Since files with `.couch` suffix only append,
every update adds data to the file. When you update a
b-tree, a new leaf node is written and all the nodes back
up the root. In this update, old data is never
overwritten and these parts of the file are no longer
live, including old b-tree nodes and document bodies.
Compaction takes this file and writes a new file that
includes only live data. The `disk_size` is the number of
bytes in the file as reported by `ls -al <file_name>`.

#### Defining a channel
{: #defining-a-channel}

You define a channel through normal dbcore
configuration, with some convention as to the parameter
names. Channel configuration is defined by using
`smoosh.channel_name` configuration options.
Defining a channel involves setting the options that you
want for the channel, then bringing it into the sets of
active channels for Smoosh by adding it to either
`db_channels` or `view_channels`. This process means that
Smoosh channels can be defined for a single node or
globally across a cluster by setting the configuration
to global or local.

-   `ratio_dbs`

    A ratio channel for databases that use the
    default settings.

-   `slack_dbs`

    A slack channel for databases that use the
    default settings.

-   `ratio_views`

    A ratio channel for views that use the default
    settings.

-   `slack_views`

    A slack channel for views that use the default
    settings.

This standard definition channel name must be added
often.

-   `big_dbs`

    A ratio channel for enqueuing only large
    database shards. The term large is applied based on the database shards' workload. In the following example, a new global channel is set up. It's important to choose good channel names. The following conventional channel names are defined by default if no other channel names are set. Channels have certain defaults for their configuration, which are defined in the Smoosh configuration section. It's only necessary to set up how this channel differs from those defaults. In the following example, the `min_size` and concurrency settings are set, and keep the priority as the default to ratio, along with the other defaults.

``` sh
# Define the new channel
(dbcore@db1.cluster001.cloudant.net)3> \
rpc:multicall(config, set, ["smoosh.big_dbs", "min_size", "20000000000"]).
{[ok,ok,ok],[]}
(dbcore@db1.cluster001.cloudant.net)3> \
rpc:multicall(config, set, ["smoosh.big_dbs", "concurrency", "2"]).
{[ok,ok,ok],[]}

# Add the channel to the db_channels set -- note we need to get the original
# value first so we can add the new one to the existing list.
(dbcore@db1.cluster001.cloudant.net)5> \

rpc:multicall(config, get, ["ioq", "compaction"]).
{[undefined,undefined,undefined],[]}

(dbcore@db1.cluster001.cloudant.net)6> \
rpc:multicall(config, set, ["smoosh", "db_channels", "ratio_dbs,big_dbs"]).
{[ok,ok,ok],[]}
```
{: codeblock}

#### Viewing active channels
{: #viewing-active-channels}

``` sh
(dbcore@db3.cluster001.cloudant.net)3> \
    rpc:multicall(config, get, ["ioq", "compaction"]).
    {[undefined,undefined,undefined],[]}
(dbcore@db3.cluster001.cloudant.net)4> \
rpc:multicall(config, get, ["ioq", "compaction"]).
{[undefined,undefined,undefined],[]}
```
{: codeblock}

#### Removing a channel
{: #removing-a-channel}

``` sh
# Remove it from the active set
(dbcore@db1.cluster001.cloudant.net)5> \
    rpc:multicall(config, get, ["ioq", "compaction"]).
{[undefined,undefined,undefined],[]}
(dbcore@db1.cluster001.cloudant.net)6> \
    rpc:multicall(config, set, ["smoosh", "db_channels", "ratio_dbs"]).
{[ok,ok,ok],[]}

# Delete the config -- you need to do each value
(dbcore@db1.cluster001.cloudant.net)3> \
rpc:multicall(config, delete, ["smoosh.big_dbs", "concurrency"]).
{[ok,ok,ok],[]}
(dbcore@db1.cluster001.cloudant.net)3> \
    rpc:multicall(config, delete, ["smoosh.big_dbs", "min_size"]).
{[ok,ok,ok],[]}
```
{: codeblock}

#### Getting channel configuration
{: #getting-channel-configuration}

``` sh
(dbcore@db1.cluster001.cloudant.net)1> \
    rpc:multicall(config, get, ["ioq", "compaction"]).
    {[undefined,undefined,undefined],[]}
```
{: codeblock}

#### Setting channel configuration
{: #setting-channel-configuration}

Set the channel configuration in the same way as defining a channel by setting the new value.

``` sh
dbcore@db1.cluster001.cloudant.net)2> \
    rpc:multicall(config, set, ["smoosh.ratio_dbs", "concurrency", "1"]).
{[ok,ok,ok],[]}
```
{: codeblock}

It can take time for the change to take effect on disk
usage.

### Main Smoosh settings
{: #main-smoosh-settings}

These settings are the main settings that you use with Smoosh.

*   `db_channels`
    
    A comma-separated list of channel names for databases.
    
*   `staleness`
    
    The number of minutes that the (expensive) priority calculation
    can be stale before it's recalculated.
    The default value is 5 minutes.
    
*   `view_channels`
    
    A comma-separated list of channel names for views.
    
Sometimes it's necessary to run the following processes.

*   `cleanup_index_files`
    
    `Smoosh` cleans up the files for indexes that were deleted.
    The setting defaults to false.
    The setting must not be changed unless the cluster is running low on disk space.
    Be cautious when you change this setting.
    
*   `wait_secs`
    
    The time a channel waits before compaction begins.
    This time allows Smoosh to observe and analyze what to compact first.
    You rarely need to change this setting from the default value,
    which is 30 seconds.

### Channel settings
{: #channel-settings}

A channel has several important settings that control runtime behavior.

*   `capacity`
    
    The maximum number of items the channel can
    hold (lowest priority item is removed to make room for new items).
    Default value is 9999.
    
*   `concurrency`
    
    The maximum number of jobs that can run concurrently.
    Default value is 1.
    
*   `max_priority`
    
    The value must have a priority less than this setting to be enqueued.
    Default value is infinity.
    
*   `max_size`
    
    The value must not be larger than the value
    specified in length to be enqueued.
    Default value is infinity.
    
*   `min_priority`
    
    The value must have a priority at least as high
    as this setting to be enqueued.
    Default value is 5.0 for `ratio` and 16 MB for `slack`.
    
*   `min_size`
    
    The value must be at least the value
    that is specified in length to be enqueued.
    Default value is 1 MB (1048576 bytes).
    
*   `priority`
    
    The method that is used to calculate priority.
    It can be ratio (calculated as `disk_size/data_size`)
    or slack (calculated as `disk_size-data_size`).
    Default value is ratio.

### Standard operating procedures
{: #standard-operating-procedures}

Operators must do a few standard things to respond to
issues. It's also useful
in some circumstances to define new channels with
certain properties (`big_dbs` is a common one) if Smoosh
isn't selecting and prioritizing compactions that well.

#### Checking the status of Smoosh
{: #checking-the-status-of-smoosh}

You can see the queued items for each channel by going
into remsh on a node and running the `smoosh:status`
command.

``` sh
> smoosh:status().
{ok,[{"ratio_dbs",
      [{active,1},
       {starting,0},
       {waiting,[{size,522},
         {min,{5.001569007970237,{1378,394651,323864}}},
         {max,{981756.5441159063,{1380,370286,655752}}}]}]},
     {"slack_views",
      [{active,1},
       {starting,0},
       {waiting,[{size,819},
         {min,{16839814,{1375,978920,326458}}},
         {max,{1541336279,{1380,370205,709896}}}]}]},
     {"slack_dbs",
      [{active,1},
       {starting,0},
       {waiting,[{size,286},
          {min,{19004944,{1380,295245,887295}}},
          {max,{48770817098,{1380,370185,876596}}}]}]},
     {"ratio_views",
      [{active,1},
       {starting,0},
       {waiting,[{size,639},
         {min,{5.0126340031149335,{1380,186581,445489}}},
         {max,{10275.555632057285,{1380,370411,421477}}}]}]}]}
```
{: codeblock}

The results give you the node-local status for each
queue. You can see more information under each channel,
such as what is shown in the following list.

-   Active

    Number of current compactions in the channel.

-   Starting

    Number of compactions that are beginning.

-   Waiting

    Number of queued compactions.

The minimum and maximum values show the effectiveness of
the queued jobs. The values for these items depend on
whether the queue is ratio or slack.

For ratio queues, the default minimum for Smoosh to
enqueue a compaction is 5. You
can guess from the previous example that 981,756 is high. This database
might be small, however, so it doesn't necessarily mean useful
compactions for reclaiming disk space.

For this example, many queued compactions are waiting,
but it's unknown which compaction would be most
effective to run to reclaim disk space. It's worth
noting that the waiting queue sizes are only meaningful
when compared to other factors on the cluster, such as
database number and size.

#### Smoosh IOQ priority
{: #smoosh-ioq-priority}

This setting is a global setting that affects all
channels. Increasing it allows each active compaction to
run faster as the compaction work is of a higher
priority relative to other jobs. Decreasing it has the
inverse effect. By this point, you know whether Smoosh
is having trouble processing each compaction. If it's falling behind (large queues),
try increasing compaction priority. The IOQ priority for
Smoosh is controlled through the IOQ compaction queue.

``` sh
> rpc:multicall(config, get, ["ioq", "compaction"]).
    {[undefined,undefined,undefined],[]}
```
{: codeblock}

The priority, conventionally, runs 0 - 1, though the priority
can be any positive number. The default for compaction
is 0.01. If it looks like Smoosh has too much work that
isn't getting through, you can increase the priority.
However, be careful that this order doesn't adversely
impact request performance.

``` sh
> rpc:multicall(config, set, ["ioq", "compaction", "0.5"]).
{[ok,ok,ok],[]}
```
{: codeblock}

In general, adjusting the Smoosh IOQ priority is a temporary measure. For some clusters, a change from the default might be required to help Smoosh keep up with particular workloads.

#### Granting specific channels more workers
{: #granting-specific-channels-more-workers}

Giving Smoosh a higher concurrency for each channel
allows a backlog in that channel to be processed. Some clusters run best when specific channels have more
workers. You must know
whether the biggest offenders are database or view
files when you assess disk space. Infer from your 
assessment whether it's
worth giving a specific Smoosh channel a higher
concurrency. See the current setting for a
channel in the following example.

``` sh
> 
rpc:multicall(config, get, ["ioq", "compaction"]).
    {[undefined,undefined,undefined],[]}
```
{: codeblock}

The undefined value means that the default is used.

If you know that databases are the major user of disk
space, you might want to increase a `_dbs` channel.
Experience shows `ratio_dbs` are often best, but you must
evaluate the databases based on their status. You can
increase the `ratio_dbs` setting by using the following
command.

``` sh
> rpc:multicall(config, set, ["smoosh.ratio_dbs", "concurrency", "2"]).
    {[ok,ok,ok],[]}
```
{: codeblock}

#### Suspending Smoosh
{: #suspending-smoosh}

If Smoosh is causing issues, you can suspend its
operation. Suspending Smoosh differs from stopping
(Smoosh) or setting the concurrency for all channels to
zero. Suspending Smoosh pauses ongoing compactions and
maintains the channel queues intact. For example, if the
compactions for a node are causing disk space issues,
you can suspend Smoosh while you determine which channel
is causing the problem. For example, a `big_dbs` channel
might be creating huge compaction-in-progress files if
there isn't much in the shard to compact, so it
is useful to use when you're testing to see whether
Smoosh is causing a problem.

``` sh
# suspend
smoosh:suspend().

# resume a suspended smoosh
smoosh:resume().
```
{: codeblock}

Suspend is implemented by calling
`erlang:suspend_process(Pid, [unless_suspending])` for
each compaction process in each channel. The
`resume_process` is called for resume.

#### Restarting Smoosh
{: #restarting-smoosh}

Restarting Smoosh is a last-resort solution. It's a
brute force approach where you hope that Smoosh rescans
the databases and makes the correct decision. If this step
is required, contact [support@cloudant.com](mailto:support@cloudant.com), since doing
this step can indicate a problem with Smoosh.

### Compaction Scheduling Algorithm
{: #compaction-scheduling-algorithm}

`Smoosh` determines whether to compact a database or a view it by evaluating the
item against the selection criteria of each channel in the order they are configured.
By default,
two channels for databases (`ratio_dbs` and `slack_dbs`) and two
channels for views (`ratio_views` and `slack_views`) exist.
`Smoosh` enqueues the new item to the first channel that accepts it.
If no channel accepts,
the item isn't enqueued for compaction.

### Example config commands
{: #example-config-commands}

Change the set of database channels.

``` sh
config:set("smoosh", "db_channels", "small_dbs,medium_dbs,large_dbs").
```
{: codeblock}

Change the set of database channels on all live nodes in the cluster.

``` sh
rpc:multicall(config, set, ["smoosh", "db_channels", "small_dbs,medium_dbs,large_dbs"]).
```
{: codeblock}

Change the concurrency of the `ratio_dbs` database channel to 2.

``` sh
config:set("smoosh.ratio_dbs", "concurrency", "2").
```
{: codeblock}

Change the concurrency of all live nodes in the cluster.

``` sh
rpc:multicall(config, set, ["smoosh.ratio_dbs", "concurrency", "2"]).
```
{: codeblock}

### Example API commands
{: #example-api-commands}

``` sh
smoosh:status()
```
{: codeblock}

This command prints the state of each channel,
how many jobs are currently running,
and how many jobs are enqueued,
including the lowest and highest priority of those enqueued items.
The idea is to provide,
at a glance,
sufficient insight into `Smoosh` that an operator can assess whether
`Smoosh` is adequately using the reclaimable space in the cluster.
In general,
Smoosh is working correctly if the status output includes items in the `ratio_dbs` and `ratio_views` channels. Due to the default settings,
`slack_dbs` and `slack_views` include items.

``` sh
smoosh:enqueue_all_dbs(), smoosh:enqueue_all_views()
```
{: codeblock}

You usually don't need to use these functions,
since `Smoosh` finds the best compaction candidates on its own.
However,
if you experience disk space issues,
these functions might help.
If they do,
that indicates a bug or configuration issue with `Smoosh`.
Check your configuration and contact support.

## Disks and file system layout on a DBCore node
{: #disks-and-file-system-layout-on-a-dbcore-node}

{{site.data.keyword.cloudant_local_notm}} stores files on a single partition. Learn more
about disks and file system layout on a DBCore node.


The partition layout of DBCore files includes the following
files.

*   CouchDB files for each shard of a database
*   View database files
*   Lucene search index files
*   Geo index files

### Database files
{: #database-files}

This example shows how a database node might look.

```
/srv/cloudant/db/dbs.couch            <---  node-local couch DB file of all DBs
/srv/cloudant/db/nodes.couch          <---  node-local couch DB file of all nodes in the cluster
/srv/cloudant/db/cluster001/          <--- cluster-based user
  users.couch                         <--- node-local couch DB file of users on this cluster
/srv/cloudant/db/shards/              <---- shards directory
  00000000-0aaaaaa9/                  <--- one dir per shard range
    cluster001/                       <--- all DBs for this user
      stats.1348021480.couch          <--- shard of cluster wide stats DB
      users.1348018682.couch          <--- older version of sharded users DB 
                                           (note timestamp in file name)
      users.1348020303.couch          <--- latest version of sharded users DB
    userfoo/                          <--- all DBs for user userfoo 
      testdb1.1351859018.couch        <--- sharded version testdb1 db for user userfoo
      testdb2.1348081688.couch
      testdb3.1348081700.couch
      testdb4.1348394170.couch
      testdb4.1348394460.couch
      ..
      testdb303.1348081734.couch
  0aaaaaaa-15555553
  ...
  eaaaaa9c-f5555545
  f5555546-ffffffff
```
{: codeblock}

### View Index files
{: #view-index-files}

```
/srv/cloudant/view_index/.shards/     <--- where view index shards are stored 
                                           (not different from DB files)
  00000000-0aaaaaa9/
  0aaaaaaa-15555553/                  <--- per shard directory
    cluster001/                       <--- cluster user 
      stats.1348021480_design         <--- stats DB design doc
      users.1348020303_design         <--- users DB design doc 
    userfoo/                          <--- user directory
      testdb1.1351859018_design       <--- design docs for DB testdb1
      testdb2.1348081688_design
      testdb3.1348081700_design
      testdb4.1348394460_design
      ... 
      testdb303.1348081734_design
  ...
  f5555546-ffffffff
```
{: codeblock}
 
### Search files
{: #search-files}

``` sh
/srv/cloudant/search_index/shards/    <--- search index shards
  00000000-0aaaaaa9/      
  0aaaaaaa-15555553/                  <--- per shard directory
    userfoo/                          <--- user directory
      testdb1.1350387023              <--- per user, per shard DB search index
      testdb2.1348081700
      testdb3.1354707402
      testdb4.1348081723
      testdb4.1351155794
  ...
  f5555546-ffffffff/
```
{: codeblock}

### Geo Index files
{: #geo-index-files}

Geo index files are stored in `/srv/cloudant/geo_index/`.

## Managing the Metrics database
{: #managing-the-metrics-database}

The metrics database will grow in size over time. Depending on
your retention requirements, you can manage growth and remove old
data as described here.



<ol>
<li>Discard metrics data.
<p><strong>Note</strong>: If you discard metrics data, you lose the performance data collected to date. You can no longer view the performance data from the Metrics dashboard. After this operation, disk space in the database will be available again, and new data will be collected as usual.</p>
<ol type=a>
<li>Stop the Metrics service on all database nodes.
<p><code>sv stop cloudant-local-metrics</code></p></li>
<li>Delete the Metrics database. 
    <p>You can delete the Metrics database from the {{site.data.keyword.cloudant_short_notm}}
    dashboard.</p></li>
<li>Create a Metrics database manually and name it `metrics`. 
    <p>You can create a new database from the {{site.data.keyword.cloudant_short_notm}} dashboard.</p></li>
<li>Restart the Metrics service on all database nodes.
<p><code>sv start cloudant-local-metrics</code></p>
<p>You can access the new metrics data from the Metrics dashboard via the URL.</p></li>
</ol>
</li>
<li>Keep old metrics data.
<p><strong>Note</strong>: With this option, the performance data that is collected to date is preserved and can be viewed from the Metrics dashboard. You can delete the data later if you need more disk space.</p>
<ol type=a>
<li>Create an empty second Metrics database on the cluster and name it <code>metrics2</code>.
<p>You can create an empty database from the {{site.data.keyword.cloudant_short_notm}} dashboard.</p></li>
<li>Log in as the <code>root</code> user.</li>
<li>Stop the Metrics service.
<p><code>sv stop cloudant-local-metrics</code></p></li>
<li>Update the <code>metrics.ini</code> file from <code>/opt/cloudant/etc</code> to specify the new Metrics database, <code>metrics2</code>, and save the file.</li>
<li>Restart the Metrics service on all database nodes.
<p><code>sv start cloudant-local-metrics</code></p>
<p>You can view new metrics data from the Metrics dashboard via the URL.</p></li>
<li>In the {{site.data.keyword.cloudant_short_notm}} dashboard, enter <code>metrics2</code> as the database name or <code>metrics</code> to view older data.
<p>Depending on your retention requirements, you can keep the Metrics database and delete it later when it's not needed.</p>

</li></ol></li></ol>

Besides the metrics database, the stats database grows in size over time although at a slower rate. The IOQ application periodically dumps its internal stats to disk via the stats database. Currently, {{site.data.keyword.cloudant_local_notm}} doesn't use that data. You can delete the database and not incur any loss of functionality. However, you might notice an error in the log that says the database doesn't exist. To prevent the error, you can re-create a new empty stats database.
{: note}

To manage the {{site.data.keyword.cloudant_short_notm}} Metrics application, see [{{site.data.keyword.cloudant_short_notm}} Metrics application](/docs/Cloudant?topic=cloudant-diagnose-troubleshoot#ibm-cloudant-metrics-application).
