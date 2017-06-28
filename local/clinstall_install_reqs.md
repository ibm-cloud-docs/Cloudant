---

copyright:
  years: 2015, 2017
lastupdated: "2017-02-08"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# Requirements

Before you install Cloudant&reg; Local, confirm that your system
meets the installation requirements. The requirements include
cluster server requirements, supported platforms, hardware
requirements, single node requirements, and user requirements for
installing the product.

## Hardware requirements

Cloudant&reg; Local hardware requirements vary based on different
factors for the database and load balancers.
{:shortdesc}

### _x86_64 hardware requirements

The following hardware requirements apply to the x86_64
architecture.

#### Database Nodes

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

#### Load Balancer Nodes

*  The minimum requirements are dual-core processor and 4 GB RAM,
   1 TB local hard disk drive with enough disk space for the OS
   and any log files kept locally,
   and a 1-gigabit network.
*  For larger implementations, the minimum requirements include a
   quad-core processor and 8 GB RAM, 1 TB local hard disk drive,
   and a 1-gigabit network.

### Linux on IBM System z

Confirm that your environment meets the following hardware
requirements.

#### Models

*  z13&trade;
*  zEnterprise&reg; - zBC12 and zEC12
*  zEnterprise - z114 and z196

#### Processors and Memory

*  Database Nodes
   *  2 IFLs in SMT mode
   *  8 GB memory for each node
*  Load Balancer Nodes
   *  2 IFLs
   *  4 GB memory for each node

## Software requirements

The following tasks can help you maintain your Cloudant&reg; Local
cluster.
{:shortdesc}

### Cluster server requirements

A minimum of five servers are recommended to create a fully
functional Cloudant cluster that ensures 24 x 7 availability.

#### Database Nodes

*  Cloudant Local must be installed on at least three database
   nodes for replication purposes.
*  (Optional) Cloudant Local can be installed on as many other
   nodes as needed to scale for your business requirements.

#### Load Balancers

*  One load balancer must be installed on a server that is
   separate from the servers that are used in the Cloudant
   cluster.
*  It is a good practice to install two load balancers in case
   the primary load balancer fails. If a second load balancer is
   installed, you must install it on a separate server to ensure
   uninterrupted service.

## Supported architecture and platforms

You can install Cloudant Local on the following platforms.

### x86_64 architecture

#### Debian-derived Linux distributions

*  Ubuntu Server 12.04 (precise)
*  Ubuntu Server 14.04 (trusty)

#### Red Hat-derived Linux distributions

*  Red Hat Enterprise Linux Server 6.x
*  Red Hat Enterprise Linux Server 7.x
*  Community ENTerprise Operating System (CentOS) 6.x
*  Community ENTerprise Operating System (CentOS) 7.x
*  Oracle Enterprise Linux Operating System (OEL) 6.x
*  Oracle Enterprise Linux Operating System (OEL) 7.x

#### SUSE Linux distributions

*  SUSE Linux Enterprise Server (SLES) 12

### IBM System z s390x architecture

#### Linux on IBM&reg; System z&reg;

*  Linux on IBM System z - Red Hat Enterprise Linux 7.x
*  SUSE Linux Enterprise Server (SLES) 12

## Single-node implementation requirements

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
