---
layout: post
title: "G7/TCPS 빈번한 요청 및 오류 해결방법"
tags: [g7,tcps]
img: "/assets/img/jobdetail/g7_tcps_frequent_request_and_error.png"
color: yellow
published: true
---

# G7

## 상태값 변경 (공통)

![](/assets/img/jobdetail/status_change.png)

1. 작업표시줄에 돌고래를 클릭하면 `sqlyog`가 열린다.
2. `g7_mariadb` db를 선택하고 `데이터조회` 탭을 선택
3. 보통 주문번호 또는 택스번호를 주면서 요청해온다. 주문번호면 `-- 3. 오더번호로 order_serial 찾기`에서, 택스번호면 `-- 2. tax_no로 order_serial 찾기`에서 주문시리얼을 검색한다(주문번호 또는 택스번호를 요청받은 것으로 변경하고 `F8`을 눌러 실행).
4. 주문상태값 변경이면 [주문 및 작업 상태값변경](#주문-및-작업-상태값변경)

### 주문 및 작업 상태값변경

### 세금계산서 상태값변경


<br><br>

# TCPS

## 주문 취소(=삭제) 처리

![](/assets/img/jobdetail/order_cancel.png)

1. 좌측 gnb 메뉴에서 `주문관리>주문목록` 오픈
2. `검색어` 란에 요청받은 검색어(주로 주문번호)를 입력하여 검색
3. 해당 주문의 `진행상황` 컬럼의 체크박스를 체크하고 드롭박스에서 `주문취소` 선택
4. 취소사유를 묻는 팝업이 뜨면 '담당자 요청' 정도로 기재하고 진행
5. 해당 주문의 주문제목에 적색 취소선이 그어진 것을 확인하고 요청자에게 통보

<br>

## 생산처 지정 / 변경

![](/assets/img/jobdetail/manufacturing_branch_change1.png)
<!-- ![](/assets/img/jobdetail/manufacturing_branch_change2.png) -->
<br>
<br>
<img src="/assets/img/jobdetail/manufacturing_branch_change2.png" alt="생산처지정 팝업" style="display: block; margin-left: auto; margin-right: auto;">

1. 좌측 gnb 메뉴에서 `주문관리>주문목록` 오픈
2. `검색어` 란에 요청받은 검색어(주로 주문번호)를 입력하여 검색
3. 해당 주문의 `생산처지정` 버튼을 누르면 팝업이 뜬다.
4. 생산처 드롭박스에서 요청받은 생산처를 선택 후 저장 버튼을 누른다.
5. `생산처`가 올바르게 변경되었는지 확인하고 요청자에게 통보

<br>
