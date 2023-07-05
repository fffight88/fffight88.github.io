---
layout: post
title: "G7 유지보수"
img: "/assets/img/jobdetail/g7_login.png"
tags: [g7]
color: lightgreen
published: true
---
타라그래픽스의 영업/결제모듈 G7 관리방법

***목차***
- [접속정보](#접속정보)
  - [웹서버(AWS EC2)](#웹서버aws-ec2)
  - [DB서버(서비스)(AWS RDS)](#db서버서비스aws-rds)
  - [DB서버(개발용)(AWS RDS)](#db서버개발용aws-rds)
  - [GitLab](#gitlab)
  - [Jenkins](#jenkins)
- [주기적](#주기적)
  - [첫번째](#첫번째)
- [요청있을 때](#요청있을-때)
  - [각 화면별 매출액이 안 맞을 때](#각-화면별-매출액이-안-맞을-때)
    - [매출확정목록과 기간별매출조회 매출액이 다를 때](#매출확정목록과-기간별매출조회-매출액이-다를-때)
- [특정 시점](#특정-시점)
  - [조직변경, 인사발령 후](#조직변경-인사발령-후)
    - [거래처 정보, 고객 정보 이관](#거래처-정보-고객-정보-이관)
    - [선매출 잔액 이관](#선매출-잔액-이관)
    - [임시계정 생성](#임시계정-생성)
    - [임시계정에서 본계정으로 접수자 변경](#임시계정에서-본계정으로-접수자-변경)
  - [정전, 사무실이전 등 IP가 바뀌었을 때](#정전-사무실이전-등-ip가-바뀌었을-때)


<br>

***

<br>

## 접속정보

### 웹서버(AWS EC2)

- 서버아이피    : 52.78.86.185
- 서버계정      : ec2-user
- 암호          : (없음)
- 인증키        : Seoul_01_Webserver(Graphics).pem
<br>
<br>

### DB서버(서비스)(AWS RDS)

- DB 호스트주소 : seoul-01-db-mysql.cnr8rmvlx27e.ap-northeast-2.rds.amazonaws.com
- DB 계정 : grpbo
- 암호 : grpbonpos
- 데이터베이스 : grpbo
<br>
<br>

### DB서버(개발용)(AWS RDS)

- DB 호스트주소 : taxdb.cnr8rmvlx27e.ap-northeast-2.rds.amazonaws.com
- DB 계정 : g7tax
- 암호 : xkfkdkagh1!
- 데이터베이스 : dz_db
<br>
<br>

### GitLab

- http://gitlab.openprintmarket.com:8090/
- fffight88 / xkfkdkagh1!
- C:\Windows\System32\drivers\etc\hosts 파일을 관리자권한 편집기로 열어서 다음을 삽입
> 52.68.111.103 gitlab.openprintmarket.com
<br>
<br>

### Jenkins

- http://jenkins.openprintmarket.com:8091/
- fffight88 / xkfkdkagh1!
- C:\Windows\System32\drivers\etc\hosts 파일을 관리자권한 편집기로 열어서 다음을 삽입
> 52.68.111.103 jenkins.openprintmarket.com
<br>
<br>


<br>

***

<br>

## 주기적

### 첫번째

<br>

***

<br>

## 요청있을 때

### 각 화면별 매출액이 안 맞을 때

1. `매출확정목록`은 `bo_sales` 테이블에 등록된 매출이 발생한 주문의 데이터를 이용
2. `기간별 매출조회`는 `bo_sales` 테이블에 등록된 매출이 발생한 주문의 데이터와  `bo_sales`에 올라간 주문의 작업세부내용을 `remake_bo_order_job` 테이블에서 가져와서 이용
3. `지점 월 매출목표 및 실적`과 `부서별 월 매출목표 및 실적`은 `remake_bo_order`, `remake_bo_order_job` 테이블에서 매출확정상태인 주문의 데이터를 이용
4. `영업사원 월 매출목표 및 실적`과 `영업사원 월별 거래처별 매출실적`은 현재 해당지점에 등록된 영업사원계정별 매출을 기준으로 표기하기 때문에, 만약 해당지점 소속이지만 영업사원이 아닌 계정(예: 운영매니저, 지점계정, 생산매니저 등)이 등록한 매출은 `지점` 및 `부서` 통계화면에는 적용이 되지만 `영업사원` 통계화면에는 적용이 안되므로 매출액이 다르게 보일 수 있으며 이는 정상이다.

#### 매출확정목록과 기간별매출조회 매출액이 다를 때

두 가지는 같은 테이블에서 데이터를 가져오므로 매출액이 서로 다를 수가 없는데도 다른 경우가 있다. 이 때는 가장 큰 원인이 어떤 주문의 작업세부내용을 수정했는데 통신오류로 인해 수정된 내용이 job 계열의 테이블에 업데이트되지 않은 것이다.
1. `영업지원` -> `차액 추적`
2. `차액추적`에는 `bo_sales`상에서의 실제 매출액과 `remake_bo_order` 및 `remake_bo_order_job`상에서의 주문금액의 총합을 비교하여 맞지 않는 주문을 검색, 화면에 띄운다. 이 때 거의 대부분 실제로 결제하여 `bo_sales` 테이블에 기록된 금액이 맞는 금액이 된다. 따라서 원인은 위에 언급한 대로 작업내역을 수정했는데 통신오류 등의 원인으로 제대로 업데이트가 되지 않은 것이므로, `remake_bo_order_job` 테이블에서 현실과 맞게 작업부수, 수량 등을 수정하거나 작업삭제처리를 해주는 등으로 수정해준다. ___ 영세율업체로 등록된 업체로부터 발생한 매출은 이 기능에서 조회하지 않으니 이 화면에 보이는 게 없는데도 차액이 발생한다면 영세율업체의 매출을 먼저 확인해볼 것 ___


<br>

***

<br>

## 특정 시점

### 조직변경, 인사발령 후 

#### 거래처 정보, 고객 정보 이관
G7의 사업자관리, 고객관리 화면에서 정보 변경이 가능하므로 한 두개등 소량이면 영업사업들이 스스로 한다. 다만, 대량으로 이관해야 할 경우에는 DB에서 쿼리를 이용해 처리해야 한다.
`SQLYOG`의 `liveserver` 탭 -> `고객사 및 고객정보이관` 탭 참조
<br>
<br>

#### 선매출 잔액 이관
선매출을 결제한 후 한 번도 사용하지 않은 건이라면 선매출취소버튼을 눌러 취소할 수 있지만 한 번이라도 사용했다면 선매출취소버튼이 뜨지 않으므로 이 때에는 인위적으로 DB에 마이너스 금액으로 된 데이터를 삽입해서 0원으로 처리해야 한다. 처리해야 하는 건이 있을 때는 회계팀에서 선매출번호 등을 적어서 처리해달라고 요청이 온다.

1. grpbo.bo_prepayment 테이블에서
2. 요청받은 선매출주문 번호로 select하여 결과를 출력한다.
3. 쿼리 또는 DBMS의 기능으로 한 줄을 추가하여 각종 정보와 함께 남은 금액에 상당하는 마이너스 금액을 입력한다.
4. G7상에 잘 반영되었는지 확인한다. 
<br>
<br>

#### 임시계정 생성
아직 처리되지 않은 계산서 및 매출 건이 있기 때문에 쓰던 계정을 바로 새로운 근무지로 변경하면 안 된다. '해당사원명(임시)' 라는 이름으로 계정을 생성한 후 그 계정을 새로운 근무지 소속으로 넣어주고 당사자가 사용하게 한다. 한편 기존에 사용하던 계정은 소속을 변경하지 말고 그대로 두다가 해당 지점에서 접수자를 임시계정에서 본계정으로 바꿔달라고 할 때 새로운 소속으로 변경함과 동시에 접수자가 임시계정으로 되어있는 주문들의 접수자를 본계정으로 업데이트한다.
<br>
<br>

#### 임시계정에서 본계정으로 접수자 변경
`SQLYOG`의 `liveserver` 탭 -> `접수자 일괄변경` 탭 참조
<br>
<br>


### 정전, 사무실이전 등 IP가 바뀌었을 때

1. 바뀐 지점의 직원에게 네이버에서 `내아이피주소`를 쳐서 나온 아이피를 받는다.
2. bo_inbound 에서 각 지점별 등록되어있는 IP를 수정하거나 새로 추가한다.

<br>

***

<br>