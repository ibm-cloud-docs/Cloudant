# Cloudant

Please use https://github.ibm.com/cloud-docs/Cloudant for contributions.
Pushes to https://github.com/ibm-cloud-docs/Cloudant are only allowed
by members of documentation team.

# Build & CI

## Jenkins


Jenkins is used to publish docs to staging and to production.
The setup is managed by IBM Cloud Documentation team.

https://wcp-docs-team-jenkins.swg-devops.com/job/build/job/cloud-docs/job/Cloudant/

Jenkins is also used to keep github.com and github.ibm.com repositories in sync.

https://wcp-docs-team-jenkins.swg-devops.com/job/mirror/job/cloud-docs/job/Cloudant

## Documentation

Please use https://github.ibm.com/cloud-docs/Cloudant for contributions to the documentation. Pushes to https://github.com/ibm-cloud-docs/Cloudant are only allowed by members of the documentation team. See [Documentation Update Process](https://github.ibm.com/cloud-docs/Cloudant/wiki/Documentation-Update-Process) for instructions.

If you are not an IBM employee and want to make a documentation contribution, go to the [IBM Cloudant documentation](https://cloud.ibm.com/docs/services/Cloudant?topic=Cloudant-getting-started-with-cloudant#getting-started-with-cloudant) and click `Feedback` on the page where you want to comment.

### Example update guide

1. **Tags**
    1. Add `{{site.data.keyword.attribute-definition-list}}` tag - this enables the language switchers.
    2. Remove the other tags, but keep the one listed inline (i) above. Other tags are set globally now, so we do not need, for example, `{:new_window: target="_blank"}`, `{:shortdesc: .shortdesc}`, `{:codeblock: .codeblock}` or any others.
2. **Example snippets**
    1. Go code snippets and text should be the last of the language examples because Go has Go-related text sections that don't display correctly otherwise.
    2. Use the `{: node}` tag after `{: codeblock}` tag instead of `{: javascript}`. This keeps the order of the language switcher tabs as:`curl`, `Java`, `Node`, `Python`, and `Go`.
    3. Use `require` (Node built-in CommonJS modules) instead of `import` (ES module) in the **javascript** examples.
    4. The following **Example template** can be helpful where the previous suggestions are included.
       <details>
       <summary><b>Example template:</b></summary>

       ``````
       ```sh
       
       ```
       {: codeblock}
       {: curl}
       
       ```java
       
       ```
       {: codeblock}
       {: java}
       
       ```javascript
       const { CloudantV1 } = require('@ibm-cloud/cloudant');
       
       ...
       ```
       {: codeblock}
       {: node}
       
       ```python
       
       ```
       {: codeblock}
       {: python}
       
       ```go
       
       ```
       {: codeblock}
       {: go}
       
       The previous Go example requires the following import block:
       {: go}
       
       ```go
       import (
         "encoding/json"
         "fmt"
         "github.com/IBM/cloudant-go-sdk/cloudantv1"
       )
       ```
       {: codeblock}
       {: go}
       ``````

</details>

3. **One example per header**
   1. Add one example switcher under each (`h2`, `h3`, `h4`, ...) header because any other order affects the order of the language switchers, and the language switcher does not display correctly.
4. **Consistency**
    1. Try to keep consistency between the curl and language examples. For example, if you write an example for **post**Change, the curl example should have the `POST` verb too: `curl -X POST $SERVICE_URL/... -H "Content-Type: application/json" --data '{...}' `.
5. **Placeholders**
    1. Use placeholders in the general `http` code blocks, like `$SERVICE_URL`, `$DATABASE`, `$VIEW_NAME` and so on.
     2. Try to keep the placeholders consistent at least within one document, e.g., do not use `design-doc`, `$DESIGN_ID`, `$DDOC`, `$DDOCS` in the same document. Try to use the most used in the whole doc (in this example, case `$DDOC`).
    3. Try to use the `$SERVICE_URL` placeholder at the beginning of each path (in `http` and language blocks too).
    4. Try to avoid placeholders in the `curl`, `java`, `node`, `python`, `go` examples except for the "special" `$SERVICE_URL`, use realistic data instead if you can e.g. `animaldb` instead of the `$DATABASE` placeholder etc
