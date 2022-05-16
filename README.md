# Cloudant

Please use https://github.ibm.com/cloud-docs/Cloudant for contributions.
Pushes to https://github.com/ibm-cloud-docs/Cloudant are only allowed
by members of documentation team.

# Build & CI

## Jenkins


Jenkins is used to publish docs to staging and to production.
The setup is managed by IBM Cloud Documentation team.

https://wcp-ace-docs-jenkins.swg-devops.com/job/Docs-build/job/Docs-build-Cloudant/


## Travis

Travis is used to keep github.com and github.ibm.com repositories in sync.
The setup is managed by Cloudant infra team.

https://travis.ibm.com/Bluemix-Docs

## Documentation

Please use https://github.ibm.com/cloud-docs/Cloudant for contributions to the documentation. Pushes to https://github.com/ibm-cloud-docs/Cloudant are only allowed by members of the documentation team. See [Documentation Update Process](https://github.ibm.com/cloud-docs/Cloudant/wiki/Documentation-Update-Process) for instructions. 

If you are not an IBM employee and want to make a documentation contribution, go to the [IBM Cloudant documentation](https://cloud.ibm.com/docs/services/Cloudant?topic=Cloudant-getting-started-with-cloudant#getting-started-with-cloudant) and click `Feedback` on the page where you want to comment. 

### Example update guide

1. Tags

    1. Add `{{site.data.keyword.attribute-definition-list}}` tag - this enables the language
       switchers
    2. Remove the other tags, but keep the one listed in point i - other tags are set globally
       now, so we do not need e.g.
       `{:new_window: target="_blank"}`, `{:shortdesc: .shortdesc}`, `{:codeblock: .codeblock}` etc.
2. Example snippets:
    1. Go code snippets and text should be the last among the lang examples because go have go related text sections and display can be messed up otherwise
    2. Use the `{: node}` tag after `{: codeblock}` tag instead of `{: javascript}`, if you want to
       display the
       language tabs in
       order in docs which is `curl, Java, Node, Python, Go`
    3. Use `require` (node built-in CommonJS modules) instead of `import` (ES module) in the **javascript** examples
    4. The **Example template** can be useful to keep above suggestions.
       <details>
       <summary><b>Example template:</b></summary>

       `````
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
       `````

</details>

3. One example per one header: Put one example switcher under one (`h2`, `h3`, `h4`, ...) header 
   because otherwise that mixes the order of the language switchers/does not display them accurately (see https://github.ibm.com/Bluemix/Bluemix-doc-framework/issues/4256 bug description)
4. Consistency
    1. Try to keep consistency between curl and the language examples. E.g if you write an
       example
       for **post**Change, the curl example should have the `POST` verb too: `curl -X POST
       $SERVICE_URL/... -H "Content-Type: application/json"
       --data '{...}' `
5. Placeholders
    1. Use placeholders in the general `http` codeblocks, like `$SERVICE_URL`, `$DATABASE`,
       `$VIEW_NAME` etc.
    2. Try to keep the placeholders consistent at least within one documentation. E.g. do not
       use `design-doc`, `$DESIGN_ID`, `$DDOC`, `$DDOCS` in the same document, try to use the
       mostly used among the whole docs (e.g. in this example case `$DDOC`). See also
       https://github.ibm.com/cloud-docs/Cloudant/issues/1005 for more info.
    3. Try to use `$SERVICE_URL` placeholder in the beginning of each path (in `http` and language
       blocks
       too)
    4. Try to avoid placeholders in the `curl`, `java`, `node`, `python`, `go` examples except for the
       "special"
       `$SERVICE_URL`, use realistic data instead if you can e.g. `animaldb` instead of the `$DATABASE` placeholder etc
6. PR process:
    1. Read [Documentation Update Process](https://github.ibm.com/cloud-docs/Cloudant/wiki/Documentation-Update-Process)
    2. Pull `publish` for your feature branch, and keep up-to-date with it
    3. If your modifications are ready you can check them on staging 
       1. by switching on the `draft`
          branch and merging your feature branch's content to it, push to `draft` and it should be
          available within a ~half hour
       2. asking a documentation team member to do a) for you
    4. Link the staging content to your PR description to ease the review process
    5. When PR is approved, merge the content of your branch to `draft` once again before merging to `publish`
