---

copyright:
  years: 2017
lastupdated: "2017-07-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-05-04 -->

# Neuerungen in Cloudant

Bleiben Sie bei den Änderungen und Aktualisierungen für Cloudant auf dem Laufenden. {:shortdesc}

## Dedizierte Hardware

Eine neue [dedizierte Serviceinstanz](bluemix.html#dedicated-plan) ist verfügbar. 

## Build 6233

- Führt einen neuen Replikationsplaner ein.
  Neben den Leistungsvorteilen und zusätzlichen Endpunkten ändert der Planer die Art und Weise, in der der Replikationsstatus überwacht und berichtet wird.
  Insbesondere wird das Aufzeichnen von Statusaktualisierungen in einem Replikationsdokument nicht länger unterstützt.
  Weitere Informationen zu dieser wichtigen Änderung finden Sie in den Angaben zum [Replikationsplaner](../api/advanced_replication.html#the_replication_scheduler).
  Kontaktieren Sie den Cloudant-Support, indem Sie im Cloudant-Dashboard ein Ticket öffnen, wenn Sie Fragen oder Probleme haben. 

## Build 6069

- Früher hat ein fehlgeschlagener Replikationsjob zu einer Aktualisierung des Replikationsdokuments geführt,
  gefolgt von einem weiteren Versuch, eine neue Replikation zu starten.
  Unter bestimmten Umständen konnte dieses Verhalten unbegrenzt fortgesetzt werden, d. h. Sie hatten viele Duplikate derselben Fehlernachricht.
  Es wurde ein Fix eingeführt, damit das Replikationsdokument erst aktualisiert wird, wenn sich die Ursache des Fehlers geändert hat. 
- Falls das Entwurfsdokument, das einen geografisch-räumlichen Index angeben soll, ungültig ist,
  resultiert ein Versuch, Informationen zu dem Index mithilfe des
  [Endpunkts `_geo_info`](../api/cloudant-geo.html#obtaining-information-about-a-cloudant-geo-index)
  abzurufen, in einer [HTTP `404`](http.html#404)-Antwort. 
- Es wurde Unterstützung für den [`$allmatch`](../api/cloudant_query.html#the-allmatch-operator)-Operator hinzugefügt. 

## Build 5834

- Die maximale Länge einer Dokument-ID (`id`) ist jetzt 7168 Zeichen (7k). 

## Build 5728

- Cloudant ist toleranter gegenüber fehlerhaften Benutzerdokumenten, die in der Datenbank `_users` gespeichert sind.
  Benutzerdokumente sollten entsprechend den [Apache Software Foundation-CouchDB-Anforderungen ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://docs.couchdb.org/en/2.0.0/intro/security.html#users-documents){:new_window} strukturiert und befüllt werden. 

## Build 5638

-   Führt neue Abfrageparameter 'stable' und 'update' für Ansichten ein. 
-   Der Replikator führt nicht mehr unbegrenzt Neuversuche aus, wenn er keine Prüfpunkte in die Datenbank schreiben kann. 

## Build 5421

-	Der Feed mit den Änderungen unterstützt ansichtsbasierte Filter. 
-	Der Feed mit den Änderungen unterstützt den Filter `_doc_ids`. 
-	`POST`-Anforderungen werden für `_changes` unterstützt. 
-	Sowohl `_all_docs` als auch `_changes` unterstützen den Parameter `attachments=true`. 
-	Unterstützung für die `_users`-Datenbankfunktionen in CouchDB 1.6, einschließlich serverseitiges Hashing von Kennwörtern, wenn Dokumente in der Datenbank `_users` erstellt werden. 
-	`/_bulk_get`-Endpunkt zum Reduzieren der Anzahl von Anforderungen, die bei der Replikation auf mobile Clients verwendet werden. 
-	Die Metadaten von Entwurfsdokumenten enthalten ein Feld `update pending`. 
-	Cloudant Query gibt nicht länger einen Fehler zurück, wenn kein gültiger Index vorhanden ist. 

### Unterbrechungen/Verhaltensänderungen

Aktive Tasks

-   Indexer-Einträge in der Antwort `_active_tasks` berichten nicht länger das Feld `user`. 
-   Suchindexer-Einträge in der Antwort `_active_tasks` berichten nicht länger das Feld `user`. 

Ansichten

-   Die Unicode-Normalisierung von Schlüsselwerten ist zwischen reduzierter und nicht reduzierter Ansicht konsistent. Wenn in einem Dokument eine unformatierte Sortierung angegeben ist, kann sich die Reihenfolge der Ergebnisse infolge dieses Fix ändern. 
-   Wenn Sie eine Ansicht oder eine Datenbank `_all_docs` abfragen, ist es ein Fehler, den Parameter `keys` und einen der Parameter `key`, `startkey` und `endkey` anzugeben. 
-   Es ist ein Fehler, die Parameter `startkey` und `endkey` an eine Ansicht zu übergeben, wenn es nicht möglich ist, eine übereinstimmende Zeile zu finden. Wenn beispielsweise der Parameter `startkey` größer als der Parameter `endkey` für `descending=false` ist oder wenn der Parameter `startkey` kleiner als der Parameter `endkey` für `descending=true` ist, gibt Cloudant den Fehler `400 Bad Request` zurück. 
-   Wenn `dbcopy` in einem Ansichtsdokument konfiguriert ist, wird das Element automatisch in das Feld `options` in einem Entwurfsdokument umgewandelt.  

Entwurfsdokumente

-   Strengere Validierung von Entwurfsdokumenten. Diese Validierung sollte keine Probleme mit vorhandenen Entwurfsdokumenten auslösen, aber fehlerhafte Entwurfsdokumente können nicht gespeichert werden. 
-   Ansichten, die in einer nicht unterstützten Sprache geschrieben werden, antworten alle mit einem Fehler (`error`) vom Typ `unknown_query_language`. Früher wurde ein `reason`-Code vom Typ `unknown_query_language` zurückgegeben. 
-   Wenn ein Null-Reducer verwendet wird, um ein Datenbankentwurfsdokument zu speichern, antwortet das System mit der Fehlerursache `'(null)'`. Früher wurde `((new String("null")))` zurückgegeben. 
-   Wenn in einem Entwurfsdokument `updates` angegeben wird, darf es keinen Nullwert enthalten. 

Authentifizierung

-   Die `_session`-Metadaten `authentication_handlers` enthalten nicht mehr das Element `["delegated", "local"]`. 

Benutzerdokumente

-   Validieren Sie die Struktur von Benutzerdokumenten, die in der Datenbank `_users` erstellt werden. Nach dem DBNext-Upgrade müssen die Benutzerdokumente ASF-CouchdDB-Anforderungen erfüllen. Früher hat Cloudant die Struktur von Benutzerdokumenten nicht validiert.  

Replikation 

-   Replikatordokumente bewahren die letzte Fehlernachricht im JSON-Feld `_replication_state_reason` auf. Das Feld bleibt auch erhalten, nachdem die Replikation neu gestartet wird und den Status `triggered` hat. Dank dieser Änderung kann der Replikatorcode denselben Fehler wiedererkennen und ihn nicht wiederholt in das Dokument schreiben. 
-   Ein Fehler während der Replikation führt nicht dazu, dass das Replikationsdokument aktualisiert wird, es sei denn, die Ursache des Fehlers ändert sich. Wenn früher während der Replikation ein Fehler aufgetreten ist, begann eine Endlosschleife, die beträchtliche Shards generierte.   

Ergebnissatz

-   Der Endpunkt `_db_updates` gibt einen Ergebnissatz zurück, der einen Schlüssel namens `db_name` enthält. Früher wurde ein Ergebnissatz mit einem Schlüssel namens `dbname` zurückgegeben. 
-   Legen Sie die maximale Länge der Dokument-ID fest. Früher war es nicht möglich, eine maximale Dokument-ID-Länge zu definieren. 

`dbcopy`

- Die Funktion `dbcopy` kann unter manchen Umständen Probleme verursachen.
  Informationen zu der Funktion wurden aus der Dokumentation entfernt.
  Wir raten dringend von einer Verwendung von `dbcopy` ab. 
