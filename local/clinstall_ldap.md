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

# Authenticating with LDAP

Use these instructions to configure Lightweight Directory Access
Protocol (LDAP) authentication and authorization for Cloudant&reg;
Local.
{:shortdesc}

Cloudant Local has its own security model with a self-contained
authentication and authorization system. The authentication and
authorization system relies on ini files and user databases to
store user data, including user names (uids), passwords, and user
roles for accessing resources in the database. If your
organization uses an LDAP service for access control, you can
delegate authentication and authorization services to LDAP when
you access a Cloudant Local database. The `ldap_auth` configuration
allows you to use LDAP with Cloudant Local.

At a high level, when `ldap_auth` is configured, it replaces the
default basic and cookie authentication and authorization. It
ignores any administrator users who are configured in the `ini`
files and user databases. Instead, `ldap_auth` validates user
credentials by using the configured LDAP service. After you
authenticate your credentials with the LDAP service, `ldap_auth`
determines the user roles. The user roles determine what the user
is authorized to access, based on the LDAP groups where the user
is a member.

>   **Note:** You can use LDAP and the Metrics application together.
    However, the Metrics application requires that specific
    authentication credentials and roles exist in the LDAP database
    so that LDAP and the Metrics application work properly.

The Metrics application stores its authentication credentials in
the `metrics.ini` file. The Metrics application's default
authentication credentials include user name admin and password
pass. You must create a user in your LDAP database that has both
`_admin` and `server_admin` roles and whose credentials match the
credentials set in the `metrics.ini` file. See the [Cloudant Metrics
application](clinstall_config_metrics_app.html).


## Configuring LDAP authentication

You configure LDAP authentication and authorization in the `ini`
configuration file under the `ldap_auth` section.
{:shortdesc}

See the following configuration information example in the
`local.ini` file in `/opt/cloudant/etc`.

``` sh
[ldap_auth]
use_ssl = false
servers = 10.35.186.185
searcher_dn = cn=Manager,dc=example,dc=com
searcher_password = secretsanta
group_base_dn = dc=example,dc=com
```
{:codeblock}

1.  Configure at least one of the available parameters inside the
    `ldap_auth` section of an `ini` configuration file.

2.  Modify the parameters and their associated default values (in
    parentheses) in the following list.

    >   **Note:** The default values for parameters marked '&raquo;' are only useful for testing. Change the parameter's value to match your environment.

<!-- reset markdown parsing -->

*   &raquo; `group_base_dn` (ou=groups,dc=example,dc=com)

    Defines a directory location to use during a search
    for groups.

*   `group_classes` (posixGroup)

    Defines which `objectClasses` indicate a particular
    entry as a group during search.

*   `group_member_attribute` (memberUid)

    Defines which group attribute maps to user uid.

*   `group_role_attribute` (description)

    Defines which group attribute maps to a particular
    role.

*   `port` (389)

    LDAP server port for decrypted communication.

*   &raquo; `searcher_dn` (uid=ldapsearch,ou=users,dc=example,dc=com)

    Defines the distinguished name (DN) to use while
    `ldap_auth` searches for users and groups.

*   &raquo; `searcher_password` (secret)

    Defines the password for the `searcher_dn` parameter.

*   &raquo; `servers` (127.0.0.1)

    Supports one or more LDAP servers, which default to a
    single host, but might also be a comma-separated
    list.

    >   **Note:** All servers must use the same port, which is a limitation of the underlying `eldap` library.

*   `ssl_port` (636)

    LDAP server port for encrypted communication.

*   `timeout` (5000)

    Milliseconds to wait for a response from an LDAP
    server before an error occurs.

*   `use_ssl` (true)

    If true, use TLS to encrypt traffic to LDAP servers.

*   &raquo; `user_base_dn` (ou=users,dc=example,dc=com)

    Defines a directory location to use during a search
    for users.

*   `user_bind_dns` ([ ])

    Defines one or more base DNs into which the
    authenticating user's user name can be inserted as
    the `user_uid_attribute` and used to bind to it
    directly.

*   `user_classes` (person)

    Defines which `objectClasses` indicate a particular
    entry as a user during search.

*   `user_uid_attribute` (uid)

    Defines which attribute maps to a user name.

## Setting up `ldap_auth` to work with Cloudant Local

Cloudant&reg; Local LDAP authentication, `ldap_auth`, implements basic
and cookie-based authentication handlers to obtain the roles that
are associated with a particular user. Using `ldap_auth` with basic
authentication requires no client-side changes.
{:shortdesc}

A properly configured database automatically attempts to
authenticate with LDAP by using the supplied credentials.

1.  For cookie authentication, `POST` credentials to the `_session`
    endpoint to obtain an `AuthSession` cookie, which contains a
    signed hash of its contents: name, time issued, and authorized
    roles. Subsequent requests that use that cookie automatically
    use the roles in the cookie until it expires.

2.  Modify the following configuration parameters in the
    `[couch_httpd_auth]` section.

<!-- reset markdown parser -->

*   `secret`

    The shared secret that is used to sign the
    `AuthSession` cookie that is created when the cluster
    is provisioned.

*   `timeout` (600)

    Seconds until the `AuthSession` cookie expires.
    The default is 600 seconds.

## Optimizing LDAP Authentication and Authorization

The `ldap_auth` function uses two different modes of operation that
depend on whether the `user_bind_dns` parameter is defined. Both
modes return a list of roles that are associated with a user upon
successful authentication.
{:shortdesc}

By default, `ldap_auth` opens a connection to an LDAP server and
binds the connection handle with the `searcher` DN and password. It
then uses that connection to search for a user record with the
authenticating user name. If a matching user DN is found, it
opens a second connection to the server and attempts to bind that
connection by using the user name and password credentials. If
the bind is successful, it closes the connection and uses the
original "`searcher`" bound connection to search for groups that
contain the `group_member_attribute` parameter that matches the
user's user name. Those groups have a `group_role_attribute`
parameter that indicates the actual roles for the user.

If you know in advance that all your users' DNs can be
constructed by inserting their user names into the following
pattern, `$uid_attribute=$username,$user_bind_dn` (for example,
`uid=jay,ou=users,dc=example,dc=com`), you can configure multiple
`user_bind_dns` parameters. The `ldap_auth` function does not use the
`searcher` DN or `user_base_dn`. Instead, `ldap_auth` binds directly to
the constructed user DNs. If the bind is successful, the bound
connection is used again to make the same group search as
described earlier. This technique can eliminate extra network
round trips.

## Defining LDAP groups and roles

The method for defining groups and roles varies based on your
LDAP server. However, before Cloudant&reg; Local and LDAP function
together, you must define groups for each Cloudant role.
{:shortdesc}

Each role defines the tasks that a user can do. Some of
the available roles are defined in the following list.

*   `_reader`

    Read from a database.

*   `_writer`

    Update a database.

After the groups are defined, you must determine the users that
can perform the tasks in each role.
