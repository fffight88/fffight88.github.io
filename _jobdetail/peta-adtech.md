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

## 합의된 설계사항
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

## TCPS 주문목록화면

### get_page_list_t_order()