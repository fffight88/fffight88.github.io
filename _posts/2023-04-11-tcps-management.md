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

