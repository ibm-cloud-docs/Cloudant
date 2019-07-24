---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: tradeoffs in partition tolerance, change approach to data, availability, consistency, theory

subcollection: cloudant

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:tip: .tip}
{:note: .note}
{:important: .important}
{:deprecated: .deprecated}

<!-- Acrolinx: 2017-01-24 -->

# CAP 定理
{: #cap-theorem}

{{site.data.keyword.cloudantfull}} 會使用[最終一致 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://en.wikipedia.org/wiki/Eventual_consistency){: new_window} 模型。
{: shortdesc}

若要瞭解此模型的運作方式，以及為何它是使用 {{site.data.keyword.cloudant_short_notm}} 的重要部分，請考量「一致性」的意義。

一致性是四個 ['ACID' ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://en.wikipedia.org/wiki/ACID){: new_window} 內容的其中一個，需有這些內容，才能可靠地處理及報告資料庫內的交易。

此外，一致性還是
<a href="http://en.wikipedia.org/wiki/CAP_Theorem" target="_blank"> "CAP" <img src="../images/launch-glyph.svg" alt="外部鏈結圖示" title="外部鏈結圖示"></a> 定理中的三個屬性之一。屬性為 **C**（一致性）、**A**（可用性），以及 **P**（分割區容錯）。此定理指出分散式電腦系統（例如 {{site.data.keyword.cloudant_short_notm}}）無法_同時_ 保證三個屬性：

-   一致性，其中所有節點可以同時看到相同的資料。
-   可用性，保證每個要求都會收到其是成功還是失敗的回應。
-   分割區容錯，其中系統會繼續作業，即使系統的任一個部分流失或失敗也一樣。

無法同時保證全部三個屬性，表示 {{site.data.keyword.cloudant_short_notm}} 不保證「一致性」屬性。
在最終一致的模型（如 {{site.data.keyword.cloudant_short_notm}}）中，系統的其他部分_最終_ 可以看到對某一部分系統所做的更新。
當更新傳播時，由於完全一致，可將系統說成「融合」。

最終一致性有利於效能。使用強大的一致性模型時，系統必須等待任何更新項目順利傳播完畢，然後寫入或更新要求才能完成。使用最終一致的模型時，寫入或更新要求幾乎可以立即返回，而整個系統中的傳播會「在幕後」繼續。

資料庫可能同時因為理論與實際的原因，而僅展示這三個屬性當中的兩項。設定一致性及可用性優先順序的資料庫很簡單：單一節點會儲存單一資料副本。但是，此模型難以調整，因為您必須升級節點，才能取得更多效能，而不是使用額外節點。因此，即使次要系統失效可關閉單一節點系統，然而任何流失訊息都表示流失相當資料。若要確保，系統必須變得更準確。

## 分割區容錯性的權衡
{: #tradeoffs-in-partition-tolerance}

設定一致性及分割區容錯優先順序的資料庫一般會套用
<a href="http://en.wikipedia.org/wiki/Master/slave_(technology)" target="_blank">主從 <img src="../images/launch-glyph.svg" alt="外部鏈結圖示" title="外部鏈結圖示"></a> 設定，在這種設定中，系統有許多節點，其中只有一個節點可選為主要節點。只有主要節點才能核准資料寫入，而所有次要節點都會從主要節點抄寫資料來處理讀取作業。如果主要節點失去與網路的連線，或無法與許多系統節點通訊，則剩餘的節點會選取新的主要節點。此選取處理程序在各個系統之間各有不同，而且可能是[重大問題 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://aphyr.com/posts/284-call-me-maybe-mongodb){: new_window} 的來源。


{{site.data.keyword.cloudant_short_notm}} 會設定可用性及分割區容錯的優先順序，方法為採用主從設定，因此每個節點都可以同時接受對其部分資料的寫入及讀取。
多個節點包含資料的每一個部分的副本。每一個節點都會利用其他節點複製資料。如果有某個節點變成無法存取，則其他節點可在網路恢復時取代其位置。如此一來，儘管發生任意節點失效，系統仍會及時傳回資料，並維護[最終一致性 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://en.wikipedia.org/wiki/Eventual_consistency){: new_window}。解除絕對一致性之優先順序的取捨為，所有節點都需要時間才能看到相同的資料。因此，部分回應可能包含舊資料，同時新的資料會透過系統傳播。

## 變更方法
{: #changing-the-approach}

維護一致的資料視圖是合乎邏輯且易於瞭解的，因為關聯式資料庫會替您完成此工作。期望與資料庫系統互動的 Web 型服務以此方式運作。但是，該期望不表示它們會以此方式運作。一致性不是給定的，需要一些工作才能變更此方法。

事實上，多數企業雲端服務不一定需要一致性。大型且大量使用的系統，會讓其系統的某個部分有很高的失敗機率。根據設定可用性及最終一致性優先順序之需求而設計的資料庫，更適合用來讓您的應用程式保持在線上。應用程式資料的一致性可在事後處理。MIT 的 Seth Gilbert 及 Nancy Lynch [推論 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://www.glassbeam.com/sites/all/themes/glassbeam/images/blog/10.1.1.67.6951.pdf){: new_window}，「今日大部分真實世界系統被迫不得不「大部分時間傳回大部分資料」。」

## 企業中的應用程式可用性與一致性
{: #application-availability-versus-consistency-in-the-enterprise}

看看這些通用的 Web 型服務，可知人們已預期高可用性，並樂意用此可用性來換取最終一致的資料，而他們往往並未意識自己正在這樣做。

許多應用程式為了可用性而誤導了使用者。考量 ATM：不一致的銀行資料就是可能透支而未意識到這一點的原因。如果網路中的每一個節點都必須中止，並在作業繼續之前記錄您的帳戶餘額，如此在整個銀行系統中呈現此帳戶餘額的一致視圖是很不切實際的。最好是讓系統高度可用。

銀行業已在 1980 年代就瞭解這一點，但是許多 IT 組織仍會擔心為了可用性而犧牲一致性。想一想您的銷售團隊在無法存取其 CRM 應用程式時而撥打支援電話的次數。現在，考量他們是否甚至注意到更新資料庫需要幾秒的時間，才能在整個應用程式中傳播資料。

可用性勝過一致性，超過您可能的預期。線上購物車系統、HTTP 快取及 DNS 就是其中的幾個範例。組織必須考量關閉時間的成本，例如使用者挫敗、生產力損失，以及錯過機會。

## 從理論到實作
{: #from-theory-to-implementation}

處理高可用性對雲端應用程式至關重要。否則，當您擴充時，全球資料庫一致性仍會是主要瓶頸。高可用性的應用程式需要與其資料維持連續不斷的聯絡，即使該資料並不是最新的。這就是最終一致性的概念，並沒有什麼可怕的。總體來說，有時候提供並非完全正確的答案好過完全不提供。

資料庫系統會以不同方式隱藏可用性與一致性的複雜性，但是它們始終在那裡。透過 {{site.data.keyword.cloudant_short_notm}} 資料庫即服務以及 CouchDB 和其他 NoSQL 資料庫所得到的觀點，就是開發人員最好能在設計處理程序的早期處理這些複雜性。
事先做好艱辛的工作，可以減少出人意料的事件，因為應用程式從第一天起就要做好擴充的準備。
