---
layout: post
title: "페타애드텍 명함주문 솔루션 TCPS 연동 작업"
tags: [페타, peta]
img: "/assets/img/jobdetail/peta_adtech_logo.png"
color: green
published: true
---

페타애드텍 명함주문 솔루션 TCPS 연동 작업

<br>

***

<br>

## 설계
1. 타라측 DB에 중간테이블 생성, 서로의 주문데이터를 inset, update 및 select 할 수 있도록 권한 설정
   - 타라의 service용 DB와는 별개의 페타애드텍 전용 db를 생성하여, 현재 작업중인 명함 뿐 아니라 다른 주문들도 앞으로 이 DB를 이용할 예정
2. 개별주문번호 생성시 페타애드텍 구분자 넣어서 생성
3. 주문접수시 중간테이블에 타라측 개별주문번호와 묶음주문번호 업데이트
4. 5분마다 cron으로 중간테이블에서 타라테이블에 insert
5. 

<br>
<br>

## 페타애드텍용 DB 정보

### 접속 & 계정정보

- 페타측 외부아이피 : 
- Host Address : 52.79.207.19
- User : petaadt
- Password (초기) : peta1234!@#$
- Port : 3306
- Database : peta_adtech  
- 허용된 권한 : select, insert, update, delete, create

<br>
<br>

## peta_adtech 내 테이블 정보

* 배송지가 같은 p_order는 같은 묶음주문번호를 가짐
* 페타측에서 주문데이터를 올릴 때 개별주문번호와 묶음주문번호를 함께 올려야

1. p_order_temp

2. t_order_temp

<br>
<br>

## 명함 단가 입력방법

* 현재 TCPS에서 명함의 단가는 `단가관리 - 명함견적관리` 에서 합의한대로 명함 스펙과 단가 등을 입력 후 `제품관리 - 템플릿수정` 에서 해당 명함의 디테일한 이미지 등을 주면서 앞에서 정한 견적을 선택하면 그 템플릿은 하나의 제품으로 `tpa001_bg` 테이블에 오르게 됨. 즉, 다음의 기능들을 이용해 DB에 등록해야 주문할 때 자동적으로 가격이 책정되고 통계 등에 반영됨.
  * `회원관리 - 기업회원등록`에서 고객사로 등록
  * `단가관리 - 명함견적관리`에서 명함견적 등록
  * `제품관리 - 템플릿등록/수정`에서 제품등록

* 관련 테이블
  * `paper_gram_code` : pg(paper&gram) code 등록
  * `mem_sale_detail` : 명함견적관리 화면에서 만든 견적 등록
  * `mem_sale_detail_price` : 등록한 견적의 수량과 가격이 등록됨

* `p_order` 테이블에는 주문한 명함의 템플릿번호에 따라 여러가지 정보가 기재됨

* 즉, TCPS 화면을 사용하지 않더라도 고객사정보, 단가정보, 제품정보를 다 등록하고 데이터를 가져오면서 데이터 내용에 따라 템플릿번호도 함께 p_order 테이블에 삽입이 되어야 함.

<br>
<br>

## TCPS 주문목록화면

### get_page_list_t_order()