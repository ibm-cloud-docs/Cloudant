---

copyright:
  years: 2015, 2017
lastupdated: "2017-01-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# CouchApps

Cloudant kann unformatierte Dateidaten, z. B. Bilder, hosten und über HTTP bereitstellen,
d. h. es kann alle statischen Dateien hosten, die erforderlich sind, um eine Website auszuführen,
genau wie ein Web-Server.
{:shortdesc}

Da diese Dateien unter Cloudant gehostet würden,
könnte das clientseitige JavaScript auf Cloudant-Datenbanken zugreifen.
Eine auf diese Weise konzipierte Anwendung hat eine zweistufige Architektur,
die aus dem Client - typischerweise einem Browser - und der Datenbank besteht.
In der CouchDB-Community wird dies als CouchApp bezeichnet. 

Die meisten Web-Apps haben drei Stufen:
den Client,
den Server
und die Datenbank.
Das Platzieren des Servers zwischen den Client und die Datenbank unterstützt Authentifizierung,
Autorisierung,
Asset-Management,
Verwendung von Drittanbieter-Web-Apps,
Bereitstellung besonders ausgereifter Endpunkte
usw.
Diese Trennung ermöglicht eine noch größere Komplexität, ohne zusätzliche Bedenken.
Ihr Kunde kann sich also ausschließlich auf die Darstellung der Daten konzentrieren,
während Ihre Datenbank das Speichern und Bereitstellen von Daten abwickelt. 

CouchApps überzeugen durch ihre Einfachheit,
aber Web-Apps benötigen regelmäßig die Unterstützung einer dreistufigen Architektur.
Wann eignet sich was? 

## Eine CouchApp eignet sich, wenn...

-   Ihr Server sowieso nur eine API für Cloudant bereitgestellt hätte. 
-   Sie damit einverstanden sind, die
    [cookie-basierte Authentifizierung](../api/authentication.html) von Cloudant zu verwenden. 
-   Sie damit einverstanden sind, die Cloudant-Datenbanken [`_users` und `_security`](../api/authorization.html)
    zum Verwalten von Benutzern und Berechtigungen zu verwenden. 
-   Sie keine Cron-Jobs oder andere regelmäßige Tasks planen müssen. 

Eine Einführung in CouchApps finden Sie im Kapitel zum [Verwalten von Anwendungen unter Cloudant ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://cloudant.com/blog/app-management/){:new_window}. 

## Eine dreistufige Anwendung eignet sich, wenn...

-   Sie differenziertere Berechtigungen benötigen, als die Datenbank `_security` zulässt. 
-   Sie eine andere Authentifizierungsmethode als die Basisauthentifizierung oder die Cookieauthentifizierung benötigen, z. B. Oauth oder ein Drittanbieter-Anmeldesystem. 
-   Sie die regelmäßige Ausführung von Tasks außerhalb des Clients planen müssen. 

Sie können Ihre Serverebene mit einer beliebigen gewünschten Technologie schreiben.
Eine Liste der Bibliotheken für die Arbeit mit Cloudant ist [verfügbar](../libraries/index.html). 
