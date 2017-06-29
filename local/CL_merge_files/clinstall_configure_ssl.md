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

# Configuring SSL

Use these instructions to configure Secure Sockets Layer (SSL)
for your Cloudant&reg; Local installation, especially if you access
the Cloudant database across an untrusted network. If your
network is trusted, configuring SSL/HTTPS is optional. You can
use HTTP requests (that is, port 80) instead.
{:shortdesc}

SSL is a standard security technology for establishing an
encrypted link between a server and a client, such as between a
website and a browser. SSL is used to ensure that sensitive
information is transmitted securely over the internet. SSL uses a
cryptographic system that uses two keys to encrypt data: a public
key that is available to anyone, and a secret key that is known
only to the recipient of the message.

## Configure SSL on your load balancers

Configure SSL for Cloudant&reg; Local on each load balancer in your
cluster. If you use SSL, and you use two load balancers (that is,
a primary and failover load balancer), you must configure SSL on
both load balancers.
{:shortdesc}

### Generating an RSA private key

RSA is a public-key cryptosystem and is widely used for secure
data transmission. RSA involves a public key and a private key.
The public key is available to anyone and is used to encrypt
messages, while the private key is required to decrypt the
messages. RSA also signs a Certificate Signing Request or CSR.

This example shows how this command is used to generate an RSA
key.

``` sh
[root@lb1centos haproxy]# openssl genrsa -out rsa.key 1024
Generating RSA private key, 1024 bit long modulus
.++++++
...................++++++
e is 65537 (0x10001)
[root@lb1centos haproxy]#
```
{:codeblock}

1.  Generate an RSA private key in the `/etc/haproxy` directory by
    using the openssl toolkit.

    The key is 1024 bit and is stored in PEM format, which is
    readable as ASCII text.
    
    >   **Note:** PEM is a container format that can include just the public certificate, or it can include an entire certificate chain, including a public key, private key, and root certificates. PEM was originally developed to secure email, and the PEM acronym was derived from the phrase Privacy Enhanced Email.
    
2.  Generate an RSA key by using the openssl `genrsa` command.

    ``` sh
    openssl genrsa -out rsa.key 1024
    ```
    {:codeblock}

    This example shows how this command is used to generate an RSA
    key.

    ``` sh
    [root@lb1centos haproxy]# openssl genrsa -out rsa.key 1024
    Generating RSA private key, 1024 bit long modulus
    .++++++
    ...................++++++
    e is 65537 (0x10001)
    [root@lb1centos haproxy]#
    ```
    {:codeblock}

### Generating a CSR

Generate a certificate signing request (CSR) by using the RSA
private key. In a production environment, the CSR is sent to a
certificate authority (CA) who supplies a signed certificate to
reassure users that the certificate is valid. In the Cloudant&reg;
Local environment, the CSR is self-signed because the certificate
is for internal use only. The **openssl** toolkit is used to generate
the CSR.
{:shortdesc}

1.  Generate a CSR by using the `openssl req` command.

    ``` sh
    openssl req -new -key rsa.key -out rsa.csr
    ```
    {:codeblock}

    During the CSR generation process, you are prompted for
    several pieces of information, such as your company name,
    email address, and a "challenge password." When prompted for a
    Common Name, enter the domain name for the system where you
    want to install the certificate, for example a load balancer.

2.  Reply to the prompts with information for your environment.

    The following example shows how this command generates a CSR.

    ``` sh
    [root@lb1centos haproxy]# openssl req -new -key rsa.key -out rsa.csr
    You are about to be asked to enter information that will be incorporated into your certificate request.
    Enter a Distinguished Name or a DN.
    There are a number of fields, but you can leave some blank.
    Some fields have a default value, if you enter '.', the field is left blank.
    -----
    Country Name (2 letter code) [XX]:US
    State or Province Name (full name) []:New Jersey
    Locality Name (eg, City) [Default City]:Princeton
    Organization Name (eg, company) [Default Company Ltd]:IBM
    Organizational Unit Name (eg, section) []:Cloudant
    Common Name (eg, your name or your server's host name) []:lb1centos.princeton.usnj.ibm.com
    Email Address []:smith at us dot ibm dot com
    
    Enter the following 'extra' attributes to be sent with your certificate request.
    A challenge password []:
    An optional company name []:
    [root@lb1centos haproxy]#
    ```
    {:codeblock}

### Generating a self-signed certificate

If required, create a self-signed certificate for your internal
use.
{:shortdesc}

When a self-signed certificate is used for a website, an error
message is displayed in the browser when a user attempts to
connect to the site. The message warns the user that the
certificate for the specified website is signed by an unknown and
untrusted certificate authority. In a production environment, a
CSR is sent to a certificate authority (CA) for certification.
After the CA confirms that the site is valid, the CA returns a
signed certificate to reassure users that the certificate for the
site is valid.

Use this command to generate a self-signed certificate that is
valid for 365 days, and that is suitable for testing.

``` sh
openssl x509 -req -days 365 -in rsa.csr -signkey rsa.key -out rsa.crt
```
{:codeblock}

This example shows how this command is used to generate a
self-signed certificate.

``` sh
[root@lb1centos haproxy]# openssl x509 -req -days 365 -in rsa.csr -signkey rsa.key -out rsa.crt
Signature ok
subject=/C=US/ST=New Jersey/L=Princeton/O=IBM/OU=Cloudant/CN=lb1centos.princeton.usnj.ibm.com/
emailAddress=silvagni at us dot ibm dot com
Getting Private key
[root@lb1centos haproxy]# 
```
{:codeblock}

### Combining the RSA certificate and key

The RSA certificate and key must be combined into a single file
for use in HAProxy 1.5 and higher.
{:shortdesc}

Combine the RSA certificate (`/etc/haproxy/rsa.crt`) and RSA key
(`/etc/haproxy/rsa.key`) into a new single file
(`/etc/haproxy/certificate.pem`) for use in HAProxy. Put the
certificate in the `certificate.pem` file first, with the key as
the final portion of the file.

Use this command to combine the files in the correct order.

``` sh
cat /etc/haproxy/rsa.crt /etc/haproxy/rsa.key > /etc/haproxy/certificate.pem
```
{:codeblock}

### Securing the RSA key and certificate

The RSA key and certificate must be protected by using
appropriate access permissions.
{:shortdesc}

Ensure that the RSA key and certificate are owned by `root`, belong
to group `root`, and have permissions set to `0400`.

``` sh
chown root:root /etc/haproxy/rsa.* /etc/haproxy/certificate.pem
chmod 0400 /etc/haproxy/rsa.* /etc/haproxy/certificate.pem
```
{:codeblock}

This example shows how these commands are used to ensure that the
RSA key and certificate are owned by `root`, group `root`, and
permissions are set to `0400`.

``` sh
[root@lb1centos haproxy]# chown root:root /etc/haproxy/rsa.* /etc/haproxy/certificate.pem
[root@lb1centos haproxy]# chmod 0400 /etc/haproxy/rsa.* /etc/haproxy/certificate.pem
[root@lb1centos haproxy]# ls -la
total 44
drwxr-xr-x.  2 root root 4096 Sep 29 15:35 .
drwxr-xr-x. 89 root root 4096 Sep 29 15:35 ..
-r--------.  1 root root 1884 Sep 29 15:26 certificate.pem
-rw-r--r--.  1 root root 8552 Sep 25 02:23 haproxy.cfg
-rwxrwx---.  1 root root 7471 Sep 19 01:35 haproxy-cloudant.cfg
-r--------.  1 root root  997 Sep 29 15:25 rsa.crt
-r--------.  1 root root  781 Sep 29 15:24 rsa.csr
-r--------.  1 root root  887 Sep 29 15:23 rsa.key
[root@lb1centos haproxy]# 
```
{:codeblock}

### Configuring HAProxy for SSL connections

Configure HAProxy for SSL connections. The RSA key and
certificate must be protected by using appropriate access
permissions. HAProxy 1.5 includes native support for SSL
connections.
{:shortdesc}

The `haproxy.cfg` file that is delivered with Cloudant&reg; Local
includes commented-out configuration lines. You must uncomment
those lines to enable SSL.

After you modify the `haproxy.cfg` file, you must restart HAProxy.

1.  As root, open the `haproxy.cfg` file on each load balancer.

    ``` sh
    /etc/haproxy/haproxy.cfg
    ```
    {:codeblock}

2. In the `haproxy.cfg` file, uncomment the two lines in the
   example by removing the `#` at the start of the line.

    ``` sh
    #bind :443 ssl crt /etc/haproxy/certificate.pem
    #redirect scheme https if dashboard_assets !{ ssl_fc }
    ```
    {:codeblock}

### Validating your SSL connection

Check that your SSL connection is working correctly.
{:shortdesc}

1.  Connect to a load balancer with a browser by using the https
    protocol.

    ``` sh
    https://lb1centos.princeton.usnj.ibm.com/dashboard.html
    ```
    {:codeblock}

2.  Enter your database administration credentials at the
    Cloudant&reg; Dashboard.

    If your SSL connection is working correctly, the Cloudant
    Local dashboard opens in your browser.
    
    >   **Note:** If you are using self-signed security certificates, your browser warns you that the SSL certificates are not from a recognized certificate authority.

### Confirming your untrusted certificate

If you use a certificate that was validated by a certificate
authority (CA), this step is not needed.
{:shortdesc}

<ol><li>If you use a self-signed certificate, confirm your certificate
    when the following untrusted connection message opens.
<p>![Example of an untrusted connection message.](images/ssl_8a.jpg)</p> 
</li>
<li>Click `Add Exception` on the `This Connection is Untrusted` message.</li>
<li>To add a security exception, perform the follow steps when the
    `Add Security Exception` window opens.
<ol type="a">
<li>Select the `Permanently store this exception` check box so the exception is stored for future use.</li>
<li>Click `Confirm Security Exception` to confirm the exception.</li>
<p>![Example shows how to add an exception for an untrusted site.](images/ssl_8b.jpg)</p>
</ol>   
</li></ol>

### Viewing the load balancer

Check that you can view the load balancer correctly.
{:shortdesc}

If you are using a properly signed certificate, or you accepted
an "untrusted" certificate, one of the following screens open.

*   If you specified `https://cloudantlocal.cloudant.com` or a
    similar URL, a load balancer welcome message opens, similar to
    the example.

    ![Example of a load balancer welcome message.](images/ssl_9.jpg)

*   If you specified a URL that includes the Dashboard component,
    `/dashboard.html`, the Cloudant&reg; Dashboard (or the Login screen
    for the dashboard) opens. This example shows the
    user-specified `dashboard.html` as part of the URL.

    ![Example of the Cloudant Dashboard Login screen.](images/20170722-dashboardlogin.jpg)
    
### Connecting load balancer and database nodes by using SSL

If you use SSL for communication between your Cloudant&reg; Local
load balancer and database nodes, enable the secure communication
on each load balancer node by making these load balancer
configuration changes.
{:shortdesc}

<ol><li>Copy the `ca.pem` file to each load balancer node.
<p>For more information about creating the `ca.pem` file, see
    [Generating the certificate authority file for a database node](generate_db_ca.html).</p>
    
</li>
<li>Update the `haproxy.cfg` file.
<ol type="a"><li>Find the section label.
<p>
`######`<br>
`# NOTE: Specify the appropriate host names and IP addresses below.`<br>
`######`</p></li>
<li>Verify that all the database nodes are included in the list.</li>
<li>For each server, change the port from `5984` to `6984`.</li>
<li>Add the following text to the end of each "server" line.
<p>`ssl verify required ca-file /<file_location>/ca.pem`
</p></li></ol>
<li>Save and close the `haproxy.cfg` file.</li>
<li>Restart **haproxy**.</li></ol>


## Configure SSL on your database nodes

Configure Secure Sockets Layer (SSL) for Cloudant&reg; Local on each
database node in your cluster. This method enables SSL
communication between load balancers and database nodes.
{:shortdesc}

### Generating the certificate authority file for a database node

If you are using self-signed certificates, generate a certificate
authority file for the database nodes.
{:shortdesc}

If you are using certificates that are provided by a third party,
you can proceed directly to [Copying the SSL security files to the database node](ssl_copy_files.html).

To use self-signed certificates on database nodes, you must
generate a certificate authority (CA) file. Only one CA file is
required. The same file is used by all the database nodes and all
the load balancer nodes within your cluster. The file can be
generated on any server.

To generate a self-signed CA file, use the following commands:

``` sh
openssl genrsa -out privkey.key
openssl req -new -x509 -key privkey.key -out ca.pem
```
{:codeblock}

The resulting `ca.pem` file is used on each database node and each
load balancer node.

>   **Note:** To use the `ca.pe`m file on a load balancer node, follow the
    instructions in [Connecting load balancer and database nodes by using SSL](connect_lb_and_db_using_ssl.html).

### Generating the server certificate file for a database node

If you are using self-signed certificates, generate a unique
server certificate file for each database node.
{:shortdesc}

If you are using certificates that are provided by a third party,
you can proceed directly to Copying the SSL security files to the
database node.

Each database node requires its own server certificate file to
identify itself. A unique name is required for each server
certificate. In the instructions that follow, replace each
instance of the phrase `serverX` with whatever name you choose. You
can use any name that is unique to your cluster.

To generate server certificate file, use the following commands.

``` sh
openssl genrsa -out serverX.key 
openssl req -new -key serverX.key -out serverX.req
openssl x509 -req -in serverX.req -CA ca.pem -CAkey privkey.key -set_serial 01 -out serverX.pem
```
{:codeblock}

The `ca.pem` file was generated while [Generating the certificate
authority file for a database node](generate_db_ca.html).

>   **Note:** The `serverX.key` file is the "secret" necessary to unlock
    self-generated certificates. Be careful to protect this file with
    appropriate access controls and security permissions.

### Copying the SSL security files to the database node

To enable SSL security, the prerequisite security certificate
files must be available on the database node.
{:shortdesc}

Copy the following files to any convenient location within the
file system of the respective database node.

``` sh
ca.pem
serverX.key
serverX.pem
```
{:codeblock}

>   **Note:** The `serverX.key` file is the "secret" necessary to unlock
    self-generated certificates. Be careful to protect this file with
    appropriate access controls and security permissions.

The `ca.pem` file is the certificate authority (CA) file, generated
in the
[Generating the certificate authority file for a database node](generate_db_ca.html)
step, or provided by a third party. The same `ca.pem` file is
used by all the database nodes.

The `serverX.key` and `serverX.pem` files are unique and specific to
each database node. The files were generated while
[Generating the server certificate file for a database node](generate_db_server_cert.html),
or provided by a third party.

### Enabling SSL security on the database node

Configure the database node to use the SSL security files.
{:shortdesc}

<ol><li>Update the `/opt/cloudant/etc/local.ini` file on each database node.
<ol type="a"><li>Enable the `https` daemon by modifying the `httpsd` line in the `[daemons]` section.
<p>`[daemons]`<br>
`httpsd = {chttpd, start_link, [https]}`
</p>
</li>
<li>Provide links to the `ca.pem`, `serverX.key` and `serverX.pem` files.
<p>`[ssl]`<br>
`cacert_file = /<filelocation>/ca.pem`<br>
`cert_file = /<filelocation>/serverX.pem`<br>
`key_file = /<filelocation>/serverX.key`</p></li></ol>
<li>Save and close the `/opt/cloudant/etc/local.ini` file.</li>
<li>Restart Cloudant&reg; on the database node.
<p>**Note:** For more information about configuring Cloudant Local for SSL-based secure connections, see [Secure Socket Level Options ![External link icon](images/launch-glyph.svg "External link icon")](http://docs.couchdb.org/en/latest/config/http.html#secure-socket-level-options).
</p></li></ol>

### Connecting load balancer and database nodes by using SSL

If you use SSL for communication between your Cloudant&reg; Local
load balancer and database nodes, enable the secure communication
on each load balancer node by making these load balancer
configuration changes.
{:shortdesc}

<ol><li>Copy the `ca.pem` file to each load balancer node.
<p>For more information about creating the `ca.pem` file, see
    [Generating the certificate authority file for a database node](generate_db_ca.html).</p>
    
</li>
<li>Update the `haproxy.cfg` file.
<ol type="a"><li>Find the section label.
<p>
`######`<br>
`# NOTE: Specify the appropriate host names and IP addresses below.`<br>
`######`</p></li>
<li>Verify that all the database nodes are included in the list.</li>
<li>For each server, change the port from `5984` to `6984`.</li>
<li>Add the following text to the end of each "server" line.
<p>`ssl verify required ca-file /<file_location>/ca.pem`
</p></li></ol>
<li>Save and close the `haproxy.cfg` file.</li>
<li>Restart **haproxy**.</li></ol>
