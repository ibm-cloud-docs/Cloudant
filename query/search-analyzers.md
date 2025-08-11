---

copyright:
  years: 2019, 2022
lastupdated: "2022-12-02"

keywords: search analyzers, keyword analyzer, simple analyzer, white space analyzer, classic analyzer, english analyzer, simple_asciifolding analyzer, normalize, store option, include_docs option, pick best analyzer

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Search analyzers
{: #search-analyzers}

{{site.data.keyword.cloudantfull}} Search is the free-text search technology that is built into the {{site.data.keyword.cloudant_short_notm}} database that is powered by [Apache Lucene](https://lucene.apache.org/){: external}. 
{: shortdesc}

When you create an {{site.data.keyword.cloudant_short_notm}} Search index, you must consider which fields from your documents need to be indexed, and how they are to be indexed.

One aspect of the indexing process is the choice of analyzer. An analyzer is code that can have the following effect:

- Make the search case-insensitive by ensuring the string is lowercase.
- Tokenize the string by breaking a sentence into individual words.
- Stem the words by removing language-specific word endings, for example, farmer becomes farm.
- Remove stop words by ignoring words like *a*, *is*, or *if*, which can make the index smaller and more efficient.

At indexing-time, source data is processed by using the analyzer logic sorts and stores data in the index. At query-time, the search terms are processed by using the same analyzer code before it interrogates the index.

## Testing the analyzer
{: #testing-the-analyzer}

If you want to see the effect of each analyzer, use the [{{site.data.keyword.cloudant_short_notm}} Search API call](/docs/Cloudant?topic=Cloudant-cloudant-search#testing-analyzer-tokenization) that applies to one of the built-in Lucene analyzers with a supplied string.

To look at each analyzer in turn, you can pass the following string to each analyzer to measure the effect:

```sh
"My name is Chris Wright-Smith. I live at 21a Front Street, Durham, UK - my email is chris7767@aol.com."
```
{: screen}

### Standard analyzer
{: #standard-analyzer}

The `standard` analyzer changes the string in the following ways: 

- Removes punctuation.
- Splits words based on spaces and punctuation.
- Removes stop words, including "is" and "at".
- Changes words to use lowercase letters.
- Note how "aol.com" stays intact.

```json
{"tokens":["my","name","josé","wright","smith","i","live","21a","front","street","durham","uk","my","email","jose7767","aol.com"]}
```
{: screen}

### Keyword analyzer
{: #keyword-analyzer}

With the `keyword` analyzer, the string stays intact. See the following example:

```json
{"tokens":["My name is José Wright-Smith. I live at 21a Front Street, Durham, UK - my email is jose7767@aol.com."]}
```
{: screen}

### Simple analyzer
{: #simple-analyzer}

The `simple` analyzer changes the string in the following ways:

- Removes punctuation.
- Splits words based on spaces and punctuation.
- No stop words removed (notice "is" and "at").
- Changes words to use lowercase letters.
- Note how `jose7767` changes to `jose` and `21a` changes to `a`.

```json
{"tokens":["my","name","is","josé","wright","smith","i","live","at","a","front","street","durham","uk","my","email","is","jose","aol","com"]}
```
{: screen}


### Simple ASCII-folding analyzer
{: #simple-asciifolding-analyzer}

The `simple_asciifolding` analyzer changes the string in the following ways:

- Removes punctuation.
- Splits words based on spaces and punctuation.
- No stop words removed (notice "is" and "at").
- Changes words to use lowercase letters.
- Converts non-ASCII characters to their closest ASCII equivalent.
- For example, `José` becomes `jose`.

```json
{"tokens":["my","name","is","jose","wright","smith","i","live","at","a","front","street","durham","uk","my","email","is","jose","aol","com"]}
```
{: screen}


### Whitespace analyzer
{: #whitespace-analyzer}

The `whitespace` analyzer changes the string in the following ways:

- Removes some punctuation.
- Splits words on spaces.
- No stop words removed (notice "is" and "at").
- Words remain case-sensitive.
- Note how email stays intact.

```json
{"tokens":["My","name","is","José","Wright-Smith.","I","live","at","21a","Front","Street,","Durham,","UK","-","my","email","is","jose7767@aol.com."]}
```
{: screen}
 
### Classic analyzer
{: #classic-analyzer}

The `classic` analyzer changes the string in the following ways:

- Removes punctuation.
- Splits words based on spaces and punctuation.
- Removes stop words (no "is" or "at").
- Changes words to use lowercase letters.
- Note how email stays intact.

```json
{"tokens":["my","name","josé","wright","smith","i","live","21a","front","street","durham","uk","my","email","jose7767@aol.com"]}
```
{: screen}

### English analyzer
{: #english-analyzer}

The `english` analyzer changes the string in the following ways:

- Removes punctuation.
- Splits words based on spaces and punctuation.
- [Stems](https://www.ibm.com/think/topics/stemming){: external} words using the Porter Stemming algorithm (for example, `fishing` becomes `fish`).
- Removes stop words (no "is" or "at").
- Changes words to use lowercase letters.

```json
{"tokens":["my","name","josé","wright","smith","i","live","21a","front","street","durham","uk","my","email","jose7767","aol.com"]}
```
{: screen}


Language-specific analyzers make the most changes to the source data. See the following two examples that use the `english` analyzer: 

```sh
The quick brown fox jumped over the lazy dog.
{"tokens":["quick","brown","fox","jump","over","lazi","dog"]}

Four score and seven years ago our fathers brought forth, on this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal.
{"tokens":["four","score","seven","year","ago","our","father","brought","forth","contin","new","nation","conceiv","liberti","dedic","proposit","all","men","creat","equal"]}
```
{: screen}

## Which analyzer must I pick?
{: #which-analyzer-must-i-pick}

It depends on your data. If your data is structured (email addresses, postal codes, names, and so on) in separate fields, then select an analyzer that retains the data you need to search.

Only index the fields that you need. Keeping the index small helps to improve performance.

Consider the common data sources and look at the best analyzer choices.

### Names
{: #names-sa}

It's likely that name fields must use an analyzer that doesn't stem words. The `whitespace` analyzer keeps the words' case (meaning the search terms must be full, case-sensitive matches) and leaves double-barreled names intact. If you want to split up double-barreled names, then the `standard` analyzer can do the job.

### Email addresses
{: #email-addresses-sa}

The built-in `email` analyzer serves this purpose, which changes everything to lowercase and then behaves like the Keyword analyzer. 

### Unique ID
{: #unique-id}

Order numbers, payment references, and UUIDs such as "A1324S", "PayPal0000445", and "ABC-1412-BBG" must be kept without any pre-processing, so the `keyword` analyzer is preferred.

### Country codes
{: #country-codes}

Country codes like "UK" must also use the `keyword` analyzer to prevent the removal of "stopwords" that match the country codes, for example, "IN" for India. The `keyword` analyzer is case-sensitive.

### Text
{: #text-sa}

It is best to process a block of free-form text with a language-specific analyzer, such as the `english` analyzer, or in a more general case, the `standard` analyzer.
