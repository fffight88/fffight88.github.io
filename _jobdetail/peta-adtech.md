---
layout: post
title: "파일접수명함주문 연동 API - 페타애드텍"
tags: [파일명함, peta, 페타]
img: "/assets/img/jobdetail/peta_adtech_logo.png"
color: green
published: true
---

페타애드텍(377) 명함주문 솔루션 - 타라생산모듈 연동 작업. 대부분의 고객사들과는 달라 TCPS 고객사사이트를 거치지 않고 서버로 주문파일을 직접 전송받아 바로 생산페이지에 띄우는 방식. 이와 같은 방식으로 주문접수하길 원하는 고객사가 나타난다면 본 API를 재사용하면 된다.

<br>

***

<br>

## 설계

1. 타라측 DB에 중간테이블 생성, 서로의 주문데이터를 insert, update 및 select 할 수 있도록 권한 설정
   - 타라의 service용 DB와는 별개의 페타애드텍 전용 db를 생성하여, 현재 작업중인 명함 뿐 아니라 다른 주문들도 앞으로 이 DB를 이용할 예정
   - DB명: peta_adtech
   - 페타측의 crontab 작동 시간은 ~~17시 30분~~ 정오, 17시로 얘기됨.
2. 매일 ~~17시40분~~ 12시10분, 17시10분 cron으로 중간테이블에서 정보를 가져와 `b2b_icm` 데이터베이스의 테이블에 insert하는데 이 때
   - 각 주문의 order_num 생성, 업데이트
   - 묶음주문의 t_serial 생성, 업데이트
   - `progress` "주문접수"로 업데이트
   - `tcps_sent` "Y"로 업데이트
   - 각 주문의 썸네일링크주소와 pdf파일링크주소에서 파일을 다운받아 tcps 라이브서버의 주문파일 저장해두는 곳에 저장해둔다.
3. 매일 ~~17시 20분~~ 11시50분, 16시50분 cron으로 `b2b_icm`의 테이블에서 다음의 정보를 가져와 중간테이블에 업데이트한다.
   - `progress` 값이 다르면 최신 값으로 업데이트(주문접수/담당지정/발송완료/주문취소 네가지 상태값만 사용)
   - `progress` 값을 `발송완료` 로 업데이트할 때 `deliv_date`와 `tracking_num`, `courier`를 함께 업데이트한다. 생산팀에서는 한진택배만 사용.
   - `progress` 값을 `주문취소` 로 업데이트할 때 `del_reason`, `total_amt`를 함께 업데이트한다.
4. 3번의 업데이트가 성공적으로 끝나면
   - `p_order` 테이블에서 업데이트한 주문의 `is_shoot` 컬럼값을 'y'로  변경
   - 해당 주문의 정보를 `p_order_shoot_log`에 기록
5. 현재 페타애드텍에서 넘어오는 주문은 아직 명함밖에 없으므로 명함주문을 위주로 로직을 만들었으나, 차후 기타 맞춤제품 주문시에도 적용이 가능하도록 테이블구조를 잡아놓았음.
6. 타 고객사와의 연동에 본 API를 사용할 때는 파일을 복사하여 다른 파일명으로 크론탭에 등록하는 방식으로 사용하는 것을 추천: 각 고객사마다 별도의 데이터베이스를 만들어 그 DB에 대한 접속권한만을 줄 예정이기 때문.

<br>
<br>

## 2023/7/6 생산팀미팅

페타측에서 이미자파일과 pdf파일의 링크만 받아서 생산팀에서 클릭하면 페타측 서버에서 다운받아 오는 방식은 우리회사 서버의 용량을 별도로 차지하지 않으므로 효율적이나, 주문의 이미지를 한꺼번에 다운받는 `전체압축기능` 사용이 제한되므로 기존대로 파일을 우리회사 서버에 업로드하는 방식으로 바꿈. 즉, ***생산팀에서 주문을 클릭했을 때 가져오는 방식이 아니라 cron으로 중간테이블에서 주문정보를 가져오는 동시에 해당 링크에 접속하여 파일을 다운받아 우리 서버에 저장해두는 방식.***

<br>
<br>

## 2023/8/30 전략영업팀 

* 페타 주문정보 insert 시각 및 시행횟수 변경: 기존에는 매일 17시 30분 1회였으나, 매일 정오, 17시 2회로 변경
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
$t_serial_peta = $tdata[`t_serial_peta`]; // 페타측의 t_serial을 테이블에서 가져와서 대입
$t_serial = $c_serial.$t_serial_peta();
```

<br>
<br>

### 주문번호(`order_num`) 생성 로직

```php
$order_num_peta = $pdata['order_num_peta']; // 페타측의 order_num을 테이블에서 가져와서 대입
$order_num = "PA".$order_num_peta;
```

<br>
<br>

### 주문파일 저장폴더 지정 로직

```php
$namecard_files_folder_path = $_SERVER['DOCUMENT_ROOT'] . "templ_storage/tpa001/" . date("ymd") . "/" . $mem_id . "_" . $t_serial;
if (file_exists($namecard_files_folder_path) == false) mkdir($namecard_files_folder_path, 0777, true);
```

<br>
<br>

### 데이터베이스 접근 클래스 PDO

[https://www.php.net/manual/en/class.pdo.php](https://www.php.net/manual/en/class.pdo.php) 참조

```php
// DB접속로직
$host = $example_host;
$database = $example_database;
$user_name = $example_username;
$user_password = $example_password;
$pdo = new PDO("mysql:host=$host; dbname=$database", $user_name, $user_password);
$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); // 에러 모드 설정

// 쿼리에 변수선언 및 매칭, 쿼리 실행
$var = 'example_var';
$query = "SELECT * FROM `example_table` WHERE `example_column` = :var"; // :변수명 형태로 변수 선언
$stmt = $pdo->prepare($query); // 변수에 쿼리 담기
$stmt->bindParam(':var', $var, PDO::PARAM_STR); // 쿼리문에 선언된 변수명에 실제 변수 매칭하기. 세번째 파라메터 생략가능. 두번째 파라메터에 변수가 아니라 값을 직접 주고싶을 때에는 bindParam() 아닌 bindValue() 사용
$stmt->execute(); // 쿼리 실행

// try~catch 블록에서 catch블록 에러 표시방법
try
{

}
catch (PDOException $e)
{
   echo "Error: " . $e->getMessage() . "<br>";
   die();
}
```