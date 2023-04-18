---
layout: post
title: "How To Manage TCPS"
author: Victor Lo
tags: [tcps]
categories: myjob
color: orange
published: false
---

***목차***

<!-- code_chunk_output -->

- [주기적](#주기적)
	- [서버용량 관리](#서버용량-관리)
- [요청있을 때](#요청있을-때)
	- [좌측 navigation bar에 맞춤제품 메뉴 추가하고 제품 등록하기(청년다방, 브레댄코, ...)](#좌측-navigation-bar에-맞춤제품-메뉴-추가하고-제품-등록하기청년다방-브레댄코-)
	- [좌측 navigation bar에 메뉴명 수정하기](#좌측-navigation-bar에-메뉴명-수정하기)
	- [맞춤제품 메뉴 등록이 처음인 고객사](#맞춤제품-메뉴-등록이-처음인-고객사)
	- [주문수정 알람기능 관리](#주문수정-알람기능-관리)
	- [가변템플릿 소제목 변경](#가변템플릿-소제목-변경)

<!-- /code_chunk_output -->
<br>

***

<br>

## 주기적

### 서버용량 관리







## 요청있을 때

### 좌측 navigation bar에 맞춤제품 메뉴 추가하고 제품 등록하기(청년다방, 브레댄코, ...)
> **"좌측에 xxxx 메뉴를 만들고 그 안에 맞춤제품번호 xxxx번(부터 xxxx번)을 추가해주세요"**

1. TCPS 실서버 db의 b2b_icm.tpa001_customize 테이블에서
2. where 조건에 `serial = 제품번호` 를 넣어 select로 검색하면
3. `p_code` 컬럼에서 해당 제품들의 코드 확인
4. `\application\config\config_tcps.php` 에서 `$config['고객사명_tpa013_p_codes']` 배열을 찾는다. 
   *(고객사명: 청년다방=>youngdabang, 브레댄코=>breadnco, ...)*
5. 배열 안에 다음 배열을 추가한다.
```php
array(
	'name' => "원하는 메뉴명",
	'p_code' => array("3번에서 확인한 코드값1", "3번에서 확인한 코드값2", ...)
)
```
<br>
<br>

### 좌측 navigation bar에 메뉴명 수정하기

1. TCPS 실서버 db의 b2b_icm.mem_c 테이블에서
2. where 조건에 `c_biz_com = '회사명'` 을 넣어 select로 검색하면
3. `serial` 컬럼에서 해당 고객사의 코드 확인
4. `\application\helpers\function_tcps_helper.php` 에서 `func_tcps_reset_config_code()` 를 찾는다.
5. 해당 고객사의 코드에 해당하는 if문을 찾아 원하는 부분을 수정한다.
6. 청년다방, 브레댄코 등 맞춤제품 부분의 메뉴가 커스터마이징 되어있는 고객사의 맞춤제품(TPA013) 메뉴명은 여기에서 바꿀 수 없고  [좌측 navigation bar에 맞춤제품 메뉴 추가하고 제품 등록하기(청년다방, 브레댄코, ...)](#좌측-navigation-bar에-맞춤제품-메뉴-추가하고-제품-등록하기청년다방-브레댄코-) 를 참조

<br>
<br>

### 맞춤제품 메뉴 등록이 처음인 고객사

<br>
<br>

### 주문수정 알람기능 관리

1. `\views\intra\common\admin2\footer.php` 에서 `$oea_check` 부분의 배열에 생산에 사용하는 계정명과 지점코드를 추가 또는 삭제
2. `\assets\intra\js\order_edit_alarm.js` 에서 기능의 상세 내용 확인 및 수정 가능
3. 관련 DB테이블 : `order_edit_alarm`

<br>
<br>

### 가변템플릿 소제목 변경

*여기서는 야놀자 명함 템플릿 변경을 예로 든다*

1. 적용하려는 제품군을 특정한다. (`serial` 또는 `p_code` 등...)
2. `application\controllers\Tpa001.php` 의 `edit_apply()`
3. 고객사페이지에서 입력하는 정보들은 `$input_data` 배열에 담겨진 상태로 xml파일 생성을 위해 파라메터로 전달된다. 따라서 분기문을 통해 원하는 상황에 원하는 텍스트로 보이게하거나 제거하는 등 처리가 가능하다.
4. `CTRL + F` -> ***야놀자 명함 템플릿 소제목 코드 변경*** 으로 검색해서 내용 참조

<br>
<br>
