---

copyright:
  years: 2015, 2017
lastupdated: "2017-02-17"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# Installing Cloudant Local offline

Install Cloudant&reg; Local offline by following these instructions.
{:shortdesc}

An online system has internet access and full access to the package
repositories, while an offline system has no access to the internet.
You must download the third-party dependencies, bundle them into a `tar`
file, and transfer them to the offline system for installation.

## Prerequisites

Before you install Cloudant Local offline, you must meet the
following prerequisites.

1.  You must be a root user or have sudo privileges.

2.  You must run a download-only or dry-run installation.  
    You run a dry-run installation from a system that has internet
    access and runs the same version of the operating system as the
    target system. The new system is called the online system.

## Installing Third-party Package Dependencies

Cloudant&reg; Local depends on several third-party packages. Before
you install Cloudant Local, the third-party packages must be
installed on the offline system. You can use the dry-run
installation option to bundle and transfer the dependencies to
your offline system. The dry-run installation option is supported
by the operating system package managers that Cloudant Local
uses.
{:shortdesc}

Before you begin,
you must configure access to the following external repositories
on the online system.

*   Operating system-specific package repositories (EPEL, and so on)
*   Python Package Index (PyPI) site

### Installing Red Hat dependencies

For Red Hat and CentOS platforms, you must bundle the
dependencies and transfer them to the offline system.
{:shortdesc}

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


### Installing SUSE dependencies

You must bundle the SUSE dependencies and transfer them to the
offline system.
{:shortdesc}
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

### Installing Ubuntu dependencies

Retrieve the Ubuntu dependencies from the Ubuntu online system.
{:shortdesc}

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
    
### Installing Python dependencies

After you transfer the third-party dependencies, you must
transfer the Python dependencies from the online system.
{:shortdesc}

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

## Running the Cloudant self-extracting archive</title>

After you install all the dependencies on the offline system,
you must run the self-extracting archive.
{:shortdesc}

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

## Installing the database and load balancer

After you install the third-party repositories on the offline system,
you can continue installing the database and load balancer node.
{:shortdesc}

1.  [Install the first database node](clinstall_install_first_db_node.html).

2.  [Install load balancer nodes](clinstall_install_load_balancer_nodes.html).

3.  Verify that the installation was successful by starting the
    Cloudant&reg; Dashboard that uses the load balancer node URL,
    `http://loadbalancer_url/dashboard.html`.
