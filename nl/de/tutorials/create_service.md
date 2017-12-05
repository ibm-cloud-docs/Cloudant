---

copyright:
  years: 2017
lastupdated: "2017-05-17"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# Cloudant-Instanz unter Bluemix erstellen

In diesem Lernprogramm erfahren Sie, wie Sie eine {{site.data.keyword.cloudantfull}}-Serviceinstanz
mithilfe des {{site.data.keyword.Bluemix_notm}}-Dashboards erstellen und wo Sie die für die Zusammenarbeit
Ihrer Anwendungen mit der Datenbank wichtigen Informationen finden.
{:shortdesc}

Für den Zugriff auf eine {{site.data.keyword.cloudant_short_notm}}-Serviceinstanz benötigen Sie einen Satz von [Serviceberechtigungsnachweisen](#the-service-credentials).
Die Berechtigungsnachweise werden im Rahmen des Erstellens einer Serviceinstanz generiert. 

Sie können auch jederzeit diese Berechtigungsnachweise abrufen, indem Sie auf Ihr {{site.data.keyword.cloudant_short_notm}}-Konto zugreifen. 

## Serviceinstanz erstellen

1.  Melden Sie sich bei Ihrem {{site.data.keyword.Bluemix_notm}}-Konto an. <br/>
Das {{site.data.keyword.Bluemix_notm}}-Dashboard finden Sie hier:
    [http://bluemix.net ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://bluemix.net){:new_window}.
    Nach der Authentifizierung mit Ihrem Benutzernamen und Ihrem Kennwort wird das {{site.data.keyword.Bluemix_notm}}-Dashboard geöffnet: <br/>
    ![{{site.data.keyword.Bluemix_notm}}-Dashboard](images/img0001.png)

2.  Klicken Sie auf den Link `Katalog`: <br/>
    ![{{site.data.keyword.Bluemix_notm}}-Katalog-Link](images/img0002.png)<br/>
    Eine Liste der verfügbaren Services, die unter {{site.data.keyword.Bluemix_notm}} verfügbar sind, wird angezeigt. 

3.  Klicken Sie auf den Eintrag `Daten und Analysen` unter der Überschrift `Services`: <br/>
    ![{{site.data.keyword.Bluemix_notm}}-Daten- und Analyseservices](images/img0003.png)<br/>
    Es wird eine Liste der Daten- und Analyseservices angezeigt,
    die unter {{site.data.keyword.Bluemix_notm}} verfügbar sind. 

4.  Klicken Sie auf den {{site.data.keyword.cloudant_short_notm}}-Service: <br>
    ![{{site.data.keyword.Bluemix_notm}} {{site.data.keyword.cloudant_short_notm}}-Serviceauswahl](images/img0004.png)

5.  Geben Sie im Servicekonfigurationsfenster einen Servicenamen ein.
    In diesem Beispiel lautet der Servicename `Cloudant Service 2017`: <br/>
    ![{{site.data.keyword.cloudant_short_notm}}-Servicename und -berechtigungsnachweise](images/img0005.png)

6.  Standardmäßig wird der Service mithilfe des Preistarifs 'Lite' erstellt, der kostenlos ist, aber nur begrenzte Kapazität bereitstellt.
    Andere Preistarife,
    mit höherer Kapazität,
    [sind verfügbar](../offerings/bluemix.html). <br/>
Klicken Sie auf die Schaltfläche `Erstellen`, um den Service zu erstellen: <br/>
    ![{{site.data.keyword.cloudant_short_notm}}-Servicenamen und -berechtigungsnachweise erstellen](images/img0006.png)

7.  Eine Serviceseite wird angezeigt, auf der bestätigt wird, dass Ihr neuer
    {{site.data.keyword.cloudant_short_notm}}-Service verfügbar ist.
    Klicken Sie auf die Registerkarte `Serviceberechtigungsnachweise`, um auf die Informationen zuzugreifen, die Ihre Anwendung für eine Verbindung mit dem Service benötigt: <br/>
    ![Auf die {{site.data.keyword.cloudant_short_notm}}-Serviceberechtigungsnachweise zugreifen](images/img0007.png)

8.  Das Fenster 'Serviceberechtigungsnachweise' wird geöffnet.
    Klicken Sie auf das Dropdownmenü `Berechtigungsnachweise anzeigen`, um die Berechtigungsnachweise anzuzeigen, die für den Zugriff auf den Service erforderlich sind: <br/>
    ![{{site.data.keyword.cloudant_short_notm}}-Serviceberechtigungsnachweise anzeigen](images/img0008.png)

9.  Die Seite mit den Details zu den Serviceberechtigungsnachweisen wird geöffnet: <br/>
    ![{{site.data.keyword.cloudant_short_notm}}-Serviceberechtigungsnachweise](images/img0009.png)

>   **Hinweis**: Die Serviceberechtigungsnachweise in diesen Beispielen
    wurden definiert, als ein Cloudant-Service zu Demonstrationszwecken unter Bluemix erstellt wurde.
    Die Berechtigungsnachweise werden hier reproduziert, um zu zeigen, wie sie im Dashboard angezeigt würden. Der
    Cloudant-Service zu Demonstrationszwecken wurde jedoch entfernt,
    deshalb sind diese Berechtigungsnachweise nicht mehr gültig.
    Sie _müssen_ Ihre eigenen Serviceberechtigungsnachweise angeben und verwenden.

## Serviceberechtigungsnachweise

>   **Hinweis**: Serviceberechtigungsnachweise sind wertvoll. 
    Wenn ein Benutzer oder eine Anwendung Zugriff auf die Berechtigungsnachweise hat,
    kann er oder sie letztlich alles mit der Serviceinstanz tun, was im bzw. ihr einfällt,
    z. B. unechte Daten erstellen oder wertvolle Informationen löschen.
    Schützen Sie diese Berechtigungsnachweise sorgfältig.

Die Serviceberechtigungsnachweise bestehen aus fünf Feldern: 

Feld           | Zweck
-----------|--------
`host`     | Von Anwendungen verwendeter Hostname zum Suchen der Serviceinstanz. 
`username` | Für Anwendungen erforderlicher Benutzername zum Zugreifen auf die Serviceinstanz. 
`password` | Für Anwendungen erforderliches Kennwort zum Zugreifen auf die Serviceinstanz. 
`port`     | HTTP-Portnummer für den Zugriff auf die Serviceinstanz auf dem Host. In der Regel '443' zum Erzwingen von HTTPS-Zugriff. 
`url`      | Zeichenfolge, die die anderen Berechtigungsnachweise in einer einzigen URL zusammenfasst, bereit für die Verwendung durch Anwendungen.

Um eine Anwendung zu erstellen, die auf Ihre Serviceinstanz zugreifen kann, benötigen Sie diese Berechtigungsnachweise. 

## Serviceberechtigungsnachweise suchen

Sie können die Berechtigungsnachweise für einen Service, der Ihrem Konto zugeordnet ist, jederzeit abrufen. 

1.  Melden Sie sich dafür zunächst bei Bluemix an.
    Das {{site.data.keyword.Bluemix}}-Dashboard finden Sie hier:
    [http://bluemix.net ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://bluemix.net){:new_window}.
    Nach der Authentifizierung mit Ihrem Benutzernamen und Ihrem Kennwort wird das {{site.data.keyword.Bluemix_notm}}-Dashboard geöffnet: <br/>
    ![{{site.data.keyword.Bluemix_notm}}-Dashboard](images/img0001.png)

2.  Blättern Sie im Dashboard nach unten, bis Sie den Abschnitt erreichen, in dem alle Ihre Services aufgelistet sind: <br/>
    ![{{site.data.keyword.Bluemix_notm}}-Serviceliste](images/img0010.png)

3.  In diesem Beispiel wird nach den Serviceberechtigungsnachweisen für die {{site.data.keyword.cloudant_short_notm}}-Serviceinstanz
    gesucht, die zu einem früheren Zeitpunkt im Lernprogramm erstellt wurde und `Cloudant Service 2017` heißt.
    Klicken Sie auf die entsprechende Zeile: <br/>
    ![{{site.data.keyword.cloudant_short_notm}}-Service auswählen](images/img0011.png)

3.  Das Fenster 'Serviceberechtigungsnachweise' wird geöffnet.
    Klicken Sie auf das Dropdownmenü `Berechtigungsnachweise anzeigen`, um die Berechtigungsnachweise anzuzeigen, die für den Zugriff auf den Service erforderlich sind: <br/>
    ![{{site.data.keyword.cloudant_short_notm}}-Serviceberechtigungsnachweise anzeigen](images/img0008.png)

4.  Die Seite mit den Details zu den Serviceberechtigungsnachweisen wird geöffnet: <br/>
    ![{{site.data.keyword.cloudant_short_notm}}-Serviceberechtigungsnachweise](images/img0009.png)

>   **Hinweis**: Die Serviceberechtigungsnachweise in diesen Beispielen
    wurden definiert, als ein Cloudant-Service zu Demonstrationszwecken unter Bluemix erstellt wurde.
    Die Berechtigungsnachweise werden hier reproduziert, um zu zeigen, wie sie im Dashboard angezeigt würden. Der
    Cloudant-Service zu Demonstrationszwecken wurde jedoch entfernt,
    deshalb sind diese Berechtigungsnachweise nicht mehr gültig.
    Sie _müssen_ Ihre eigenen Serviceberechtigungsnachweise angeben und verwenden.
