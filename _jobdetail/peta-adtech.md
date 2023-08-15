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
   - DB명: peta_adtech
   - 페타측의 crontab 작동 시간은 17시 30분으로 얘기됨.
2. 매일 17시40분 cron으로 중간테이블에서 정보를 가져와 `b2b_icm` 데이터베이스의 테이블에 insert하는데 이 때
   - 각 주문의 order_num 생성, 업데이트
   - 묶음주문의 t_serial 생성, 업데이트
   - `progress` "주문접수"로 업데이트
   - `tcps_sent` "Y"로 업데이트
   - 각 주문의 썸네일링크주소와 pdf파일링크주소에서 파일을 다운받아 
3. 매일 17시29분 cron으로 `b2b_icm`의 테이블에서 다음의 정보를 가져와 중간테이블에 업데이트한다.
   - `progress` 값이 다르면 최신 값으로 업데이트
   - `progress` 값을 `발송완료` 로 업데이트할 때 `deliv_date`와 `tracking_num`을 함께 업데이트한다.
   

## 2023/7/6 생산팀미팅

페타측에서 이미자파일과 pdf파일의 링크만 받아서 생산팀에서 클릭하면 페타측 서버에서 다운받아 오는 방식은 우리회사 서버의 용량을 별도로 차지하지 않으므로 효율적이나, 주문의 이미지를 한꺼번에 다운받는 `전체압축기능` 사용이 제한되므로 기존대로 파일을 우리회사 서버에 업로드하는 방식으로 바꿈. 즉, ___생산팀에서 주문을 클릭했을 때 가져오는 방식이 아니라 cron으로 중간테이블에서 주문정보를 가져오는 동시에 해당 링크에 접속하여 파일을 다운받아 우리 서버에 저장해두는 방식.

<br>
<br>

## 페타애드텍용 DB 정보

### 접속 & 계정정보(페타애드텍에서 사용하는 계정)

- 페타측 외부아이피 : 1.229.161.132 / 182.162.22.184
- Host Address : 52.79.207.19
- User : petaadt
- Password (초기) : peta1234!@#$
- Port : 3306
- Database : peta_adtech  
- 허용된 권한 : select, insert, update, delete, create

<br>
<br>

## 소스코드 예제

### 묶음주문번호(`t_serial`) 생성 로직

```php
$c_serial = 377;  // 페타애드텍의 tcps상 고객사시리얼
$t_serial = $c_serial.time();
```

### 주문번호(`order_num`) 생성 로직

```php
$order_num_peta = $o_data['order_num_peta']; // 페타측의 order_num을 테이블에서 가져와서 대입
$order_num = "PA".$order_num_peta;
```

