---

copyright:
  years: 2015, 2018
lastupdated: "2018-06-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-02-23 -->

# {{site.data.keyword.Bluemix_notm}}의 {{site.data.keyword.cloudant_short_notm}} 데디케이티드 하드웨어 플랜 인스턴스 작성 및 활용

이 튜토리얼은 {{site.data.keyword.Bluemix}} 대시보드를 사용하여 {{site.data.keyword.cloudantfull}} 데디케이티드 하드웨어 플랜 인스턴스를 작성하는 방법 및 그 위에 실행할 하나 이상의 표준 플랜 인스턴스를 뒤이어 프로비저닝하는 방법을 보여줍니다. 

{{site.data.keyword.cloudant_short_notm}} 데디케이티드 하드웨어 플랜 인스턴스를 작성하면 사용자의
단독 사용을 위한 데디케이티드 하드웨어에서 {{site.data.keyword.cloudant_short_notm}} 환경의 프로비저닝이 야기됩니다. 
서비스 인스턴스가 {{site.data.keyword.Bluemix_notm}} 대시보드에서 작성되지만 사용자는 데디케이티드 하드웨어 플랜 인스턴스에 직접 액세스할 수 없으며 이를 위해 서비스 신임 정보를 가질 수 없음을 참고하십시오. 하나 이상의
표준 플랜 인스턴스를 프로비저닝하여 작성된 {{site.data.keyword.cloudant_short_notm}} 데디케이티드
하드웨어 플랜 인스턴스를 사용할 수 있습니다.

## {{site.data.keyword.cloudant_short_notm}} 데디케이티드 하드웨어 플랜 인스턴스 작성

1.  {{site.data.keyword.Bluemix_notm}} 계정에 로그인하십시오.<br/>
{{site.data.keyword.Bluemix_notm}} 대시보드는
    [http://bluemix.net ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](http://bluemix.net){:new_window}에 있습니다.
    사용자 이름 및 비밀번호를 사용하여 인증하면 {{site.data.keyword.Bluemix_notm}} 대시보드가 표시됩니다.<br/>
    ![{{site.data.keyword.Bluemix_notm}} 대시보드](images/img0001.png)

2.  `Catalog` 링크를 클릭하십시오.<br/>
    ![{{site.data.keyword.Bluemix_notm}} 카탈로그 링크](images/img0002.png)<br/>
    {{site.data.keyword.Bluemix_notm}}에서 사용 가능한 서비스의 목록이 표시됩니다.

3.  `Services` 표제 아래의 `Data & Analytics` 항목을 클릭하십시오.<br/>
    ![{{site.data.keyword.Bluemix_notm}} Data & Analytics 서비스](images/img0003.png)<br/>
    {{site.data.keyword.Bluemix_notm}}에서 사용 가능한 Data & Analytics 서비스의 목록이 표시됩니다.

4.  {{site.data.keyword.cloudant_short_notm}} 서비스를 클릭하십시오.<br/>
    ![{{site.data.keyword.Bluemix_notm}} {{site.data.keyword.cloudant_short_notm}} 서비스 선택사항](images/img0004.png)<br/>
    서비스 작성 페이지가 표시됩니다. 

5.  페이지 맨 아래의 가격 책정 플랜 목록에서 `Dedicated Hardware` 하드웨어 플랜을 선택하십시오.<br/>
    ![가격 책정 플랜](../tutorials/images/pricing_plan.png)
    
6.  페이지 맨 위에서 다음 매개변수를 기입하십시오. <br/>
    -   서비스 이름을 입력하십시오.<br/>
    -   배치할 지역 및 영역을 지정하십시오.<br/>
    -   배치할 위치를 선택하십시오.<br/>
    -   HIPAA가 필수인지에 대한 질문에 예 또는 아니오로 답변하십시오. HIPAA는 미국 지역에서만 유효함을 참고하십시오.<br/> 
     
    **참고**: 동일한 지역 및 영역에서 표준 플랜 인스턴스를 배치 및 프로비저닝합니다.    
    ![데디케이티드 하드웨어 구성](../tutorials/images/select_deployment_location.png)<br/>
    프로비저닝 프로세스를 시작하십시오. 
    
7.  페이지 맨 아래에서 `Create` 단추를 클릭하여 프로비저닝을 시작하십시오. <br/>
    **참고**: 청구는 일할계산되므로 **Create** 단추를 클릭하기 전에 환경에 프로비저닝하고 지불하기를 원하는지를 확인하십시오.<br/>
    ![데디케이티드 하드웨어 프로비저닝](../tutorials/images/create_button_provision.png)<br/>
    **참고**: 프로비저닝 동안 {{site.data.keyword.Bluemix_notm}} 대시보드에서 인스턴스 옆에 회전하는 바퀴 모양이 표시됩니다. 베어메탈 서버에 데디케이티드 하드웨어 플랜 인스턴스를 프로비저닝하도록 요청이 전송됩니다. 프로비저닝 시간은 비동기이며 최대 5일이 걸릴 수 있습니다. ![데디케이티드 하드웨어 대체 버전 프로비저닝](../tutorials/images/create_button_provision2.png)<br/>
    
## 데디케이티드 하드웨어 환경에 표준 플랜 인스턴스 프로비저닝

1.  {{site.data.keyword.Bluemix_notm}} 계정에 로그인하십시오.<br/>
{{site.data.keyword.Bluemix_notm}} 대시보드는
    [http://bluemix.net ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](http://bluemix.net){:new_window}에 있습니다.
    사용자 이름 및 비밀번호를 사용하여 인증하면 {{site.data.keyword.Bluemix_notm}} 대시보드가 표시됩니다.<br/>
    ![{{site.data.keyword.Bluemix_notm}} 대시보드](images/img0001.png)

2.  `Catalog` 링크를 클릭하십시오.<br/>
    ![{{site.data.keyword.Bluemix_notm}} 카탈로그 링크](images/img0002.png)<br/>
    {{site.data.keyword.Bluemix_notm}}에서 사용 가능한 서비스의 목록이 표시됩니다.

3.  `Services` 표제 아래의 `Data & Analytics` 항목을 클릭하십시오.<br/>
    ![{{site.data.keyword.Bluemix_notm}} Data & Analytics 서비스](images/img0003.png)<br/>
    {{site.data.keyword.Bluemix_notm}}에서 사용 가능한 Data & Analytics 서비스의 목록이 표시됩니다.

4.  {{site.data.keyword.cloudant_short_notm}} 서비스를 클릭하십시오.<br>
    ![{{site.data.keyword.Bluemix_notm}} {{site.data.keyword.cloudant_short_notm}} 서비스 선택사항](images/img0004.png)<br/>
    서비스 작성 페이지가 표시됩니다.  

5.  페이지 맨 아래의 가격 책정 플랜에서 `Standard`를 클릭하십시오. <br/>
    **참고**: 데디케이티드 하드웨어 환경에 라이트 플랜 인스턴스를 프로비저닝할 수 없습니다.<br/>
    ![표준 가격 책정 플랜](../tutorials/images/standard_pricing_plan.png)
    
6.  표준 플랜 인스턴스에서와 같이 서비스 이름, 신임 정보 이름 등을 입력하여 페이지 맨 위에 있는 매개변수를 채우십시오. 
`환경 선택` 드롭 다운을 사용하여 기본 지역 멀티 테넌트 환경에 프로비저닝할지 또는 프로비저닝한 데디케이티드 하드웨어 환경에 프로비저닝할지를 결정하십시오.<br/>
    ![표준 인스턴스 구성](../tutorials/images/select_environment.png)
    
7.  페이지 맨 아래의 `Create` 단추를 클릭하십시오.<br/>
몇 초 후에 선택한 환경에 인스턴스가 프로비저닝됩니다.<br/>
    ![표준 인스턴스 프로비저닝](../tutorials/images/create_button_provision_standard.png)
    
8.  멀티 테넌트 {{site.data.keyword.cloudant_short_notm}} 인스턴스에서와 같이 서비스 신임 정보를 얻고 {{site.data.keyword.cloudant_short_notm}} 대시보드에 액세스하십시오. 
    서비스 신임 정보의 위치를 찾는 방법에 대한 자세한 정보는 [여기 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://console.bluemix.net/docs/services/Cloudant/tutorials/create_service.html#locating-your-service-credentials){:new_window}를 참조하십시오. 
     
