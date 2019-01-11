---

copyright:
  years: 2015, 2018
lastupdated: "2018-10-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:tip: .tip}

<!-- Acrolinx: 2017-05-10 -->


# {{site.data.keyword.cloud_notm}}에서의 {{site.data.keyword.cloudant_short_notm}} 데디케이티드 하드웨어 플랜 인스턴스 작성 및 활용

이 튜토리얼에서는 {{site.data.keyword.cloud}} 대시보드를 사용하는 {{site.data.keyword.cloudantfull}} 데디케이티드 하드웨어 플랜 인스턴스를 작성하는 방법과,
그 후 {{site.data.keyword.cloud_notm}} 카탈로그 또는 {{site.data.keyword.cloud_notm}} CLI를 사용하여 해당 인스턴스에서 실행되는
하나 이상의 표준 플랜 인스턴스를 프로비저닝하는 방법을 보여줍니다.  

{{site.data.keyword.cloudant_short_notm}} 데디케이티드 하드웨어 플랜 인스턴스를 작성하면 사용자의
단독 사용을 위한 데디케이티드 하드웨어에서 {{site.data.keyword.cloudant_short_notm}} 환경의 프로비저닝이 야기됩니다. 서비스 인스턴스는
{{site.data.keyword.cloud_notm}} 대시보드에서 작성되지만 사용자는 데디케이티드 하드웨어 플랜
인스턴스에 직접 액세스할 수 없으며 이에 대한 서비스 인증 정보를 보유하지 않습니다. 하나 이상의
표준 플랜 인스턴스를 프로비저닝하여 작성된 {{site.data.keyword.cloudant_short_notm}} 데디케이티드
하드웨어 플랜 인스턴스를 사용할 수 있습니다.

## {{site.data.keyword.cloudant_short_notm}} 데디케이티드 하드웨어 플랜 인스턴스 작성

1.  {{site.data.keyword.cloud_notm}} 계정에 로그인하십시오.<br/>
{{site.data.keyword.cloud_notm}} 대시보드는
    [http://bluemix.net ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](http://bluemix.net){:new_window}에 있습니다.
    사용자 이름 및 비밀번호를 사용하여 인증하면 {{site.data.keyword.cloud_notm}} 대시보드가 표시됩니다.<br/>
    ![{{site.data.keyword.cloud_notm}} 대시보드](images/img0001.png)

2.  `Create resource` 단추를 클릭하십시오. <br/>
    ![{{site.data.keyword.cloud_notm}} Create resource 단추](images/img0002.png)<br/>
    
3.  {{site.data.keyword.cloud_notm}} 카탈로그를 보고 사용 가능한 서비스를 확인하십시오. `Databases` 카테고리를 클릭하십시오.
    ![{{site.data.keyword.cloud_notm}} 카탈로그](images/img0000.png)

4.  {{site.data.keyword.cloudant_short_notm}} 서비스를 클릭하십시오.<br/>
    ![{{site.data.keyword.cloud_notm}} {{site.data.keyword.cloudant_short_notm}} 서비스 선택사항](images/img0003.png)<br/>
    서비스 작성 페이지가 표시됩니다.

5.  페이지 맨 아래의 가격 플랜 목록에서 `Dedicated Hardware` 플랜을 선택하십시오. <br/>
    ![가격 플랜](../tutorials/images/pricing_plan.png)
    
6.  페이지 맨 위에서 다음 매개변수를 기입하십시오. <br/>
    -   서비스 이름을 입력하십시오. <br/>
    -   배치할 지역/위치를 지정하십시오. <br/>
    -   리소스 그룹을 선택하십시오. </br>
    -   배치할 위치를 선택하십시오.<br/>
    -   HIPAA 필요 여부 응답에 대해 `yes` 또는 `no`를 선택하십시오. <br/>
   
    HIPAA는 미국 지역에 대해서만 유효합니다. {{site.data.keyword.IBM}}은 HIPAA 제어를 구현하기 위해 데디케이티드 또는 베어메탈 클러스터를 프로비저닝할 수 있습니다. 클러스터는 {{site.data.keyword.IBM_notm}}과 체결된 BAA(Business Associate Addendum) 계약이 확인된 후에만 프로비저닝됩니다. 이 계약은 서비스 설명 조항에 설명되어 있습니다. HIPAA 데이터 관리를 위한 클러스터의 프로비저닝에는 예상된 5일 기간보다 더 오랜 시간이 소요될 수 있습니다.
    {: tip}
    
    표준 플랜 인스턴스는 동일한 지역 및 영역에서 프로비저닝합니다.
    {: tip}

    ![데디케이티드 하드웨어 구성](../tutorials/images/select_deployment_location.png)
        
7.  `Create` 단추를 클릭하여 프로비저닝 프로세스를 시작하십시오. <br/>

    청구는 일할계산되므로 **Create** 단추를 클릭하기 전에 인스턴스를 환경에 프로비저닝하고 비용을 지불할 것인지 확인하십시오.
    {: tip}

    ![데디케이티드 하드웨어 프로비저닝](../tutorials/images/create_button_provision.png)

    프로비저닝 중에는 {{site.data.keyword.cloud_notm}} 대시보드의 인스턴스 옆에 회전하는 바퀴가 표시됩니다. 베어메탈 서버에 데디케이티드 하드웨어 플랜 인스턴스를 프로비저닝하도록 요청이 전송됩니다. 프로비저닝 시간은 비동기이며 최대 5일이 걸릴 수 있습니다.
    {: tip}   

    ![데디케이티드 하드웨어 대체 버전 프로비저닝](../tutorials/images/create_button_provision2.png)
    
## 데디케이티드 하드웨어 환경에 표준 플랜 인스턴스 프로비저닝

1.  {{site.data.keyword.cloud_notm}} 계정에 로그인하십시오.<br/>
{{site.data.keyword.cloud_notm}} 대시보드는
    [http://bluemix.net ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](http://bluemix.net){:new_window}에 있습니다.
    사용자 이름 및 비밀번호를 사용하여 인증하면 {{site.data.keyword.cloud_notm}} 대시보드가 표시됩니다.<br/>
    ![{{site.data.keyword.cloud_notm}} 대시보드](images/img0001.png)

2.  `Create resource` 단추를 클릭하십시오. <br/>
    ![{{site.data.keyword.cloud_notm}} Create resource](images/img0002.png)<br/>
    {{site.data.keyword.cloud_notm}}에서 사용 가능한 서비스의 목록이 표시됩니다.

3.  `Databases` 카테고리를 클릭하고 `Cloudant` 서비스를 선택하십시오. <br/>
    ![{{site.data.keyword.cloud_notm}} {{site.data.keyword.cloudant_short_notm}} 서비스 선택사항](images/img0003.png)</br>
    서비스 작성 페이지가 표시됩니다.<br/>  

4.  가격 플랜에서 `Standard`를 클릭하십시오. <br/>
    ![표준 가격 플랜](../tutorials/images/standard_pricing_plan.png)
    
    데디케이티드 하드웨어 환경에는 Lite 플랜 인스턴스를 프로비저닝할 수 없습니다.
    {: tip}
    
5.  다음 매개변수를 채우십시오. <br/>
    -   서비스 이름을 입력하십시오. <br/>
    -   배치할 지역/위치를 지정하십시오. <br/>
    -   리소스 그룹을 선택하십시오. </br>
    -   인증 방법을 선택하십시오. </br>
    -   환경을 선택하십시오. </br>
    ![표준 인스턴스 구성](../tutorials/images/select_environment.png)
    
6.  `Create` 단추를 클릭하십시오. <br/>
몇 초 후에 선택한 환경에 인스턴스가 프로비저닝됩니다.<br/>
    ![표준 인스턴스 프로비저닝](../tutorials/images/create_button_provision_standard.png)
    
7.  멀티 테넌트 {{site.data.keyword.cloudant_short_notm}} 인스턴스에서와 같이 서비스 인증 정보를 얻고 {{site.data.keyword.cloudant_short_notm}} 대시보드에 액세스하십시오. 
    
    자세한 정보는 [서비스 인증 정보를 찾는 방법](../tutorials/create_service.html#locating-your-service-credentials){:new_window}을 참조하십시오.  
    
## {{site.data.keyword.cloud_notm}} CLI를 사용하여 데디케이티드 하드웨어 환경에 표준 플랜 인스턴스 프로비저닝

{{site.data.keyword.cloud_notm}} CLI를 사용하려면 로그인해야 합니다. 로그인하여 대상 리소스 그룹을 설정하는 방법에 대한 자세한 정보는 [{{site.data.keyword.cloud_notm}} 계정에 로그인](create_service_cli.html#logging-in-to-your-ibm-cloud-account){:new_window}을 참조하십시오.  

{{site.data.keyword.cloudant_short_notm}} 데디케이티드 하드웨어 플랜 환경에 {{site.data.keyword.cloudant_short_notm}} 표준 플랜 인스턴스를 작성하려는 경우 기본 명령 형식은 다음과 같습니다. 


필드 |설명
------|------------
`NAME`| 사용자가 인스턴스에 지정하는 임의의 이름입니다. 
`SERVICE_NAME` | `cloudantnosqldb`
`PLAN_NAME` |표준 플랜
`LOCATION` | 배치할 위치(예: us-south, us-east 또는 eu-gb)입니다. 

다음 명령 예를 참조하십시오.  

```sh
ibmcloud resource service-instance-create NAME SERVICE_NAME SERVICE_PLAN_NAME LOCATION [-p, --parameters @JSON_FILE | JSON_STRING ]
```

데디케이티드 하드웨어 환경에 배치되는 {{site.data.keyword.cloudant_short_notm}} 인스턴스에는 두 개의 추가 매개변수가 있습니다. 

매개변수 |설명
----------|------------
`environment_crn` | 이 매개변수는 {{site.data.keyword.cloudant_short_notm}} 데디케이티드 하드웨어 플랜 인스턴스의 CRN으로 설정해야 합니다. {{site.data.keyword.cloud_notm}} 대시보드에서 {{site.data.keyword.cloudant_short_notm}} 데디케이티드 하드웨어 플랜 인스턴스의 관리 탭에 있는 CLI 명령 예를 보고 CRN을 판별할 수 있습니다. 또는 `ibmcloud resource service-instance SERVICE_INSTANCE_NAME` 명령을 사용하여 CRN을 판별할 수도 있습니다. 
`legacyCredentials` | 인스턴스가 레거시 및 IAM 인증 정보를 둘 다 사용하는지 또는 IAM 인증 정보만 사용하는지 결정하는, 기본값이 true인 선택적 매개변수입니다. 인증 방법 선택에 대한 세부사항은 [IAM 안내서 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](../guides/iam.html#ibm-cloud-identity-and-access-management-iam-){:new_window}를 참조하십시오. 

다음 명령 예를 참조하십시오.  

```sh
ibmcloud resource service-instance-create cloudant_on_ded_hardware_cli cloudantnosqldb standard us-south -p '{"environment_crn":"crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b43434444bb7e2abb0841ca25d28ee4c:301a3118-7678-4d99-b1b7-4d45cf5f7b29::","legacyCredentials":false}'
```
     
