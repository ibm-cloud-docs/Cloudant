---

copyright:
  years: 2025, 2025
lastupdated: "2025-10-16"

keywords: quickjs, migration, spidermonkey, javascript

subcollection: Cloudant

---

# Migration to QuickJS from SpiderMonkey
{: #faq-migration-to-quickjs-from-spidermonkey}

To support ES2023 JavaScript features and speed up index building,
{{site.data.keyword.cloudant_short_notm}} is replacing the
[SpiderMonkey][sm-qjs] JavaScript engine with [QuickJS][qjs-qjs].
{: shortdesc }

[sm-qjs]: https://spidermonkey.dev/
[qjs-qjs]: https://bellard.org/quickjs/

Some JavaScript features available in the SpiderMonkey engine are not available in QuickJS. When these are used, design documents must be updated to replace these features with QuickJS-compatible JavaScript. {{site.data.keyword.cloudant_short_notm}} have analysed all customer JavaScript functions and have identified that less than 1% of customers will need to do this.
{: important}

## Do I need to take action?

{{site.data.keyword.cloudant_short_notm}} have already migrated the majority
of instances that are already using QuickJS-compatible JavaScript to a QuickJS
environment. These customers have no further action needed.

To check whether your instance has been migrated, execute the following call:

```sh
$ curl -XGET https://$ACCOUNT.cloudant.com/
{
  "couchdb":"Welcome",
  "version":"3.5.0+cloudant",
  "vendor":{"name":"IBM Cloudant","version":"8665","variant":"paas"},
  "features":["quickjs","search","access-ready","iam","partitioned"],
  "features_flags":["partitioned"]
}
```

Check the `features` array:

- If `quickjs` is included in the `features` array, your instance is
   already using QuickJS and no action is needed.
- If your instance does **not** have `quickjs` in the `features` array, you may
   need to make changes to your design documents to ensure they stay working as
   expected through the transition to QuickJS.

Actions to take if your instance is not already using QuickJS:

- Please read [below][below-qjs] for details on the JavaScript changes in QuickJS. Check your design documents for JavaScript using these features.
- Test your code in the QuickJS engine following the details [here](#testing-in-quickjs).
- If you are still unsure, open a [support ticket][support-qjs] and our team will be happy to advise on any changes you might need to make.

[below-qjs]: #jsengine-dep-details
[support-qjs]: https://cloud.ibm.com/unifiedsupport/cases/form

## When will the migration be complete for all instances?

SpiderMonkey will be removed for any remaining environments
**6th October 2026**. After this date, all JavaScript in all
{{site.data.keyword.cloudant_short_notm}} environments will be executed with
QuickJS.

Most environments are already using QuickJS; see [this
question](#do-i-need-to-take-action) to find out whether you are using a QuickJS
environment already.

Ensure you are receiving {{site.data.keyword.cloudant_short_notm}} notifications
to receive updates to the timeline.

## Will there be any downtime during migration?

There will be zero downtime during migration. After the migration, JavaScript
code with incompatible JavaScript will see errors or unexpected changes to
results.

Indexes will not need to be rebuilt during the migration.

## What happens if I don’t update incompatible code before migration?

There are two classes of change:

1. Changes that result in exceptions and errors being thrown. In these cases,
    documents will not be indexed, and requests that use JavaScript will
    receive error responses.
2. Changes that alter results (eg, `parseInt`). In this case, documents
    will still be indexed, and requests will still return successfully.
    However, the indexes and responses may contain unexpected values.

## Does this affect only indexing or also query execution?

It affects all uses of JavaScript in {{site.data.keyword.cloudant_short_notm}}.

## Are there any performance differences beyond index build speed?

Our testing does not indicate major changes for other operations.

QuickJS does not change the published limits for query execution.

## What level of support does QuickJS have for ES2023 and ES2024?

[test262.fyi](https://test262.fyi/#|qjs), which runs daily tests of
compatibility levels, reports 95% compatibility with both editions.

## How can I test my design docs in QuickJS without impacting production?
{: #testing-in-quickjs}

Two ways to test your JavaScript are:

1. Upload a **new** design document containing your view, setting the `language` field to `javascript_quickjs`:

    ```jsonc
    {
      "language": "javascript_quickjs",
      // other design document fields: views, indexes etc. ...
      "views": {
        // define your views...
      }
    }
    ```

    This must be in a new design document; changing / setting this field in
    an existing design document will cause all indexes in the document to
    be rebuilt!
    {: attention}

2. Test locally by running QuickJS in your local environment.

    Read [QuickJS for faster index builds](https://blog.cloudant.com/2024/10/29/QuickJS-for-Faster-Index-Builds.html){: external}) on the {{site.data.keyword.cloudant_short_notm}} blog for details on how to do this.


## Details of JavaScript changes in the QuickJS engine
{: #jsengine-dep-details}

The list below contains the behaviour differences and incompatible functionality
between SpiderMonkey and QuickJS. Compare the information in this list with your
design documents to understand if your code needs updating.

The changes are split into changes that will cause exceptions and those which
instead cause changes in output.

### Changes causing exceptions in existing code

* Invalid expressions following `function(){...}` expressions used to be
   ignored, but when executed by QuickJS will throw a syntax error.

    Previously this would have compiled and discarded the unparsable
    code (`sfsdfsdfsdfsdf`):

    ```jsonc
    // Inside a view definition
    {
      "map": "function(doc) { emit(doc.foo, doc.bar); } sfsdfsdfsdfsdf"
    }
    ```

    In QuickJS, this will instead cause JavaScript execution to fail.

* `for each (var x in ...)` expressions are removed. Usages should be
    changed as follows:

    When using `for each` with an array:

    ```js
    js> arr = ['a','b','c']
    ["a", "b", "c"]

    // Old code
    > for each(let e in arr) {print(e)}
    a
    b
    c

    // New code
    js> for(let i in arr) {print(arr[i])}
    a
    b
    c
    ```

    When using `for each` with an object:

    ```js
    js> obj ={'a':'x', 'b':'y'}
    ({a:"x", b:"y"})

    // Old code
    js> for each(let e in obj) {print(e)}
    x
    y

    // New code
    js> for(let x in obj) {print(obj[x])}
    x
    y
    ```

* `Array.concat` is removed, use `Array.prototype.concat` instead:

    ```js
    // Old code
    Array.concat([0], [1,2,3])

    // New code
    [0].concat([1,2,3])
    ```

* The `toSource()` method is removed.

    `toSource()` is a SpiderMonkey‑specific method that returns a source‑code string for an object. QuickJS does not expose this method, so `content[k].toSource()` throws an error: `TypeError: content[k].toSource is not a function`.

    For the majority of use-cases, use `JSON.stringify` instead.

* String `substring(val, start, end)` is removed.

    Old code:

    ```js
    js> String.substring("abcd", 1, 2)
    "b"
    ```

    Use `String.prototype.substring(start, end)` instead:

    ```js
    js> "abcd".substring(1, 2)
    "b"
    ```

* The `toISOString()` throws an error on invalid `Date` objects.

    ```js
    // Old behavior
    js>  (new Date(undefined)).toISOString()
    "Invalid Date"

    // New behavior -- error
    js> (new Date(undefined)).toISOString()
    typein:1:23 RangeError: invalid date
    Stack:
      @typein:1:23
    ```

* The `Date.prototype.toLocaleFormat()` function is deprecated.

    Previous result:
    ```js
    > d = new Date("Dec 1, 2015 3:22:46 PM")
    (new Date(1449001366000))

    > d.toLocaleFormat("%Y-%m-%d")
    "2015-12-01"
    ```

    New result:
    ```js
    > d = new Date("Dec 1, 2015 3:22:46 PM")
    (new Date(1449001366000))

    > d.toLocaleFormat("%Y-%m-%d")
    typein:2:3 TypeError: d.toLocaleFormat is not a function
    ```

    A better way to emit a timestamp is using `Date.prototype.toISOString()`:

    ```js
    > to_iso(new Date("05 October 2011 14:48 UTC"))
    "2011-10-05T14:48:00.000Z"

    > to_iso(new Date("2011-10-05T14:48:00.000Z"))
    "2011-10-05T14:48:00.000Z"

    > to_iso(new Date("some_invalid_date"))
    RangeError: invalid date
    ```

    Date validity can be checked before calling functions on the `Date` by using
    `isNaN(new Date("..."))`.

    To build a custom format use the `Date.prototype.getUTC...()` methods:

    ```js
    > d = new Date("05 October 2011 14:48 UTC")
    > (d.getUTCMonth() + 1) + "/" + d.getUTCDate() + "/" + d.getUTCFullYear()
    "10/5/2011"
    ```

* Constant values leak out of nested scopes

    In SpiderMonkey `const` values leak from nested expression scopes. Referencing them in SpiderMonkey produces undefined, while in QuickJS this raises a `ReferenceError`.

    ```js
    // Old behavior - note the existence of value leaks, not the content
    js> f = function(doc){if(doc.x === 'x') { const value='inside_if'}; print(value)};
    js> f({'x':'y'})
    undefined

    // New behavior - error
    js> f = function(doc){if(doc.x === 'x') {const value='inside_if';}; print(value)};
    js> f({'x':'y'})
    typein:1:23 TypeError: can't access property "x", doc is undefined
    ```

* Callable regular expressions

    SpiderMonkey allowed calling regular expression as a function. The call worked the same as calling the .exec() method.

    ```js
    // Old behavior
    js> /.*abc$/("abc")
    ["abc"]

    // New behavior - error, call exec() explicitly
    js> /.*abc$/("abc")
    typein:1:9 TypeError: /.*abc$/ is not a function
    Stack:
      @typein:1:9
    js> /.*abc$/.exec("abc")
    ["abc"]
    ```

* E4X (ECMAScript for XML) is deprecated

    Previous result:
     ```js
    > var xml = <root><x></x></root>

    > xml.(x)
    <root>
      <x/>
    </root>
    ```

    New result:
    ```js
    > var xml = <root><x></x></root>
    typein:1:11 SyntaxError: expected expression, got '<':

### Changes causing unexpected results

* Zero-prefixed input with `parseInt()`.

    The parseInt() function in SpiderMonkey treats a leading 0 as octal (base
    8) prefix. It then parses the following input as an octal number. QuickJS
    assumes a base 10 as a default even when parsing numbers with leading zeros.

    This can be a stumbling block especially when parsing months and days in a date string. One way to mitigate this discrepancy is to use an explicit base.

    ```js
    // Old behavior
    js> parseInt("08")
    0
    js> parseInt("09")
    0
    js> parseInt("010")
    8
    js> parseInt("08", 10)
    8

    // New behavior
    js> parseInt("08")
    8
    js> parseInt("09")
    9
    js> parseInt("010")
    10
    js> parseInt("08", 10)
    8
    ```

* `RegExp.$1...$9` regular expressions feature is deprecated. The `$1`...`$9`
   properties will return `undefined`. For example:

    Previous result:
    ```js
    > v="abc"
    "abc"

    > v.match(/(b)/)
    ["b", "b"]

    > RegExp.$1
    "b"
    ```

    New result:
    ```js
    > v="abc"
    "abc"

    > v.match(/(b)/)
    ["b", "b"]

    > RegExp.$1
    undefined
    ```

* `Date.prototype.toString()` result doesn't include the timezone name, just the offset. For example:

    Previous result:
    ```js
    > (new Date()).toString();
    "Thu Sep 05 2024 17:04:03 GMT-0400 (EDT)"
    ```

    New result:
    ```js
    > (new Date()).toString();
    "Thu Sep 05 2024 17:03:23 GMT-0400"
    ```

* `Date.prototype.toLocaleString()` used to ignore locale strings, the new version will return the correct format:

    Previous result:
    ```js
    > (new Date("2019-01-15T19:32:52.915Z")).toLocaleString('en-US')
    "Tue Jan 15 14:32:52 2019"
    ```

    New result:
    ```js
    > (new Date("2019-01-15T19:32:52.915Z")).toLocaleString('en-US')
    "01/15/2019, 02:32:52 PM"
    ```

* Object key order changed:

    Previous result:
    ```js
    > r={}; ["Xyz", "abc", 1].forEach(function(v) {r[v]=v;}); Object.keys(r)
    ["Xyz", "abc", "1"]
    ```

    New result:
    ```js
    > r={}; ["Xyz", "abc", 1].forEach(function(v) {r[v]=v;}); Object.keys(r)
    ["1", "Xyz", "abc"]
    ```

* `String.prototype.match(undefined)` used to return `null`, and now will return `[""]`:

    Previous result:
    ```js
    > "abc".match(undefined)
    null
    ```

    New result
    ```js
    > "abc".match(undefined)
    [""]
    ```
