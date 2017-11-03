---

copyright:
  years: 2015, 2017
lastupdated: "2017-11-03"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-03-20 -->

# Provisioned Throughput Capacity

Your {{site.data.keyword.cloudantfull}} account is capped by the provisioned 
throughput capacity. This means that there is an upper limit to how many lookups, writes 
and queries you are allowed to make every second. You can change (increase and decrease) your 
provisioned throughput capacity either in the {{site.data.keyword.cloudant_short_notm}} 
dashboard on the Account page under the Capacity tab, or via an API endpoint.

*Note*: Changing your provisioned throughput capacity affects your monthly bill. If 
you use the API endpoint, there are no additional confirmation steps, and changes take 
effect instantly. The provisioned throughput capacity is charged hourly, where the cost 
is calculated as the cost of the most expensive throughput capacity provisioned during each hour.

## Viewing

To see the currently provisioned throughput capacity, send a `GET` request to 
`https://$ACCOUNT.cloudant.com/_api/v2/plan`, which reports back with the current 
plan definition and a list of the most recent historical changes, including the 
throughput multiplier.

In the example below, the current setting is `40` times the throughput allowance 
of the base plan.

    ```$ curl 'https://$ACCOUNT.cloudant.com/_api/v2/user/plan'
    {
        "name": "Bluemix Standard Plan",
        "data_charging_model": "overage",
        "plan_multiple_allowed": true,
        "plan_multiple_max": 50,                <<----- max allowed throughput multiplier
        "data_quota": "20GB",
        "throughput": {                         <<----- base plan throughput allowance
          "lookup": 100,
          "write": 50,
          "query": 5
        },
        "history": [
        [
          "2016-10-06T10:48:48",
          "billing.tiered.bluemix.standard",
          25                                    <<----- throughput multiplier
        ],
        [
          "2017-05-10T17:47:56",
          "billing.tiered.bluemix.standard",
          40                                    <<----- throughput multiplier
        ]
      ]
    }
    ```

## Modification

To change your provisioned throughput capacity, send a `PUT` request to 
`https://$ACCOUNT.cloudant.com/_api/v2/plan` with a JSON body holding the 
name of the base plan and your chosen throughput multiplier as an integer 
between 1 and 50 inclusive.

    ```curl -XPUT -H "Content-Type: application/json" \
            'https://$ACCOUNT.cloudant.com/_api/v2/user/plan' \
            -d '{"plan":"billing.tiered.bluemix.standard","plan_multiple":45}'
    ```