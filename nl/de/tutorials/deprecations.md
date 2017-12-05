---

copyright:
  years: 2017
lastupdated: "2017-07-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-07-12 -->

# Unterbrechungen und Verhaltensänderungen

In diesem Dokument sind die Änderungen im Verhalten von Cloudant-Releases dokumentiert.
{:shortdesc}

## Inkompatibilität zwischen CouchDB Version 1.6 und Cloudant Version 2.0.0

-   Es besteht eine Inkompatibilität zwischen den aktuellen Versionen von Cloudant und CouchDB 1.6-basierter Codebasis. Wenn Sie in der  
    älteren Version von Cloudant einen Abfrageparameter ("reduce=false") zum Anforderungshauptteil hinzufügen, wird der Parameter
    im Anforderungshauptteil ignoriert, während der Parameter in der Anforderungs-URL berücksichtigt wird. In aktuellen Versionen von
    Cloudant wird der Abfrageparameter ("reduce=false") im Anforderungshauptteil nicht ignoriert. 

## Überarbeitete Fehlernachrichten

- Die Fehlernachricht, die ausgegeben wird, wenn Sie versuchen, einen Dokumentanhang einer nicht vorhandenen Revision hinzuzufügen, wurde in einen 409-Fehler mit den folgenden Informationen geändert: 

	```
	{"error":"not_found","reason":"missing_rev"}
	```

## X-Frame-Options

Die Einstellung `X-Frame-Options` ist ein Antwortheader, der steuert, ob eine HTTP-Antwort in ein Element `<frame>`, `<iframe>` oder `<object>` eingebettet werden kann. Diese Sicherheitsfunktion verhindert Clickjacking. 

Sie können diese Option auf der Grundlage Ihrer CORS-Einstellungen konfigurieren. Wenn CORS aktiviert ist, wird `X-Frame-Options` automatisch aktiviert und sendet standardmäßig den Antwortheader `X-Frame-Options: DENY`. Wenn ein HOST-Header einer Anforderung mit der URL übereinstimmt, die im Ursprungsabschnitt von CORS aufgeführt ist, wird ein `X-Frame-Options: ALLOW-FROM URL`-Antwortheader zurückgegeben. 
 
Diese Änderung kann sich auf Kunden auswirken, die direkt über den Browser auf die Datenbank zugreifen. Wenn die Fehlernachricht 'X-Frame-Options: DENY' angezeigt wird
und Ihren Service unterbricht, müssen Sie CORS aktivieren und die [CORS-Konfiguration festlegen](../api/cors.html#setting-the-cors-configuration). Nachdem Sie CORS aktiviert haben, fügen Sie den Wert des HOST-Headers hinzu, den Sie in der Anforderung an die Liste der zulässigen `Ursprünge` senden. 

## Aktive Tasks

-   Indexer-Einträge in der Antwort `_active_tasks` berichten nicht länger das Feld `user`. 
-   Suchindexer-Einträge in der Antwort `_active_tasks` berichten nicht länger das Feld `user`. 

## Ansichten

-   Die Unicode-Normalisierung von Schlüsselwerten ist zwischen reduzierter und nicht reduzierter Ansicht konsistent. Wenn in einem Dokument eine unformatierte Sortierung angegeben ist, kann sich die Reihenfolge der Ergebnisse infolge dieses Fix ändern. 
-   Wenn Sie eine Ansicht oder eine Datenbank `_all_docs` abfragen, ist es ein Fehler, den Parameter `keys` und einen der Parameter `key`, `startkey` und `endkey` anzugeben. 
-   Es ist ein Fehler, die Parameter `startkey` und `endkey` an eine Ansicht zu übergeben, wenn es nicht möglich ist, eine übereinstimmende Zeile zu finden. Wenn beispielsweise der Parameter `startkey` größer als der Parameter `endkey` für `descending=false` ist oder wenn der Parameter `startkey` kleiner als der Parameter `endkey` für `descending=true` ist, gibt Cloudant den Fehler `400 Bad Request` zurück. 
-   Wenn `dbcopy` in einem Ansichtsdokument konfiguriert ist, wird das Element automatisch in das Feld `options` in einem Entwurfsdokument umgewandelt.  

## Entwurfsdokumente

-   Strengere Validierung von Entwurfsdokumenten. Diese Validierung sollte keine Probleme mit vorhandenen Entwurfsdokumenten auslösen, aber fehlerhafte Entwurfsdokumente können nicht gespeichert werden. 
-   Ansichten, die in einer nicht unterstützten Sprache geschrieben werden, antworten alle mit einem Fehler (`error`) vom Typ `unknown_query_language`. Früher wurde ein `reason`-Code vom Typ `unknown_query_language` zurückgegeben. 
-   Wenn ein Null-Reducer verwendet wird, um ein Datenbankentwurfsdokument zu speichern, antwortet das System mit der Fehlerursache `'(null)'`. Früher wurde `((new String("null")))` zurückgegeben. 
-   Wenn in einem Entwurfsdokument `updates` angegeben wird, darf es keinen Nullwert enthalten. 

## Authentifizierung

-   Die `_session`-Metadaten `authentication_handlers` enthalten nicht mehr das Element `["delegated", "local"]`. 

## Benutzerdokumente

-   Validieren Sie die Struktur von Benutzerdokumenten, die in der Datenbank `_users` erstellt werden. Nach dem DBNext-Upgrade müssen die Benutzerdokumente ASF-CouchdDB-Anforderungen erfüllen. Früher hat Cloudant die Struktur von Benutzerdokumenten nicht validiert.  

## Replikation 

-   Replikatordokumente bewahren die letzte Fehlernachricht im JSON-Feld `_replication_state_reason` auf. Das Feld bleibt auch erhalten, nachdem die Replikation neu gestartet wird und den Status `triggered` hat. Dank dieser Änderung kann der Replikatorcode denselben Fehler wiedererkennen und ihn nicht wiederholt in das Dokument schreiben. 
-   Ein Fehler während der Replikation führt nicht dazu, dass das Replikationsdokument aktualisiert wird, es sei denn, die Ursache des Fehlers ändert sich. Wenn früher während der Replikation ein Fehler aufgetreten ist, begann eine Endlosschleife, die beträchtliche Shards generierte.   

## Ergebnissatz

-   Der Endpunkt `_db_updates` gibt einen Ergebnissatz zurück, der einen Schlüssel namens `db_name` enthält. Früher wurde ein Ergebnissatz mit einem Schlüssel namens `dbname` zurückgegeben. 
-   Legen Sie die maximale Länge der Dokument-ID fest. Früher war es nicht möglich, eine maximale Dokument-ID-Länge zu definieren. 

## `dbcopy`

- Die Funktion `dbcopy` kann unter manchen Umständen Probleme verursachen.
  Informationen zu der Funktion wurden aus der Dokumentation entfernt.
  Wir raten dringend von einer Verwendung von `dbcopy` ab. 
