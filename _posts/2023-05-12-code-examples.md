---
layout: post
title: "Code Examples"
author: Victor Lo
tags: [code, coding, example]
categories: myjob
color: lightgray
published: true
excerpt_separator: <!--more-->
---

유용한 예제코드들 <!--more-->

- [Javascript, jQuery](#javascript-jquery)
  - [텍스트박스 일부문자만 허용하기](#텍스트박스-일부문자만-허용하기)
- [PHP](#php)
  - [separator로 구별한 숫자들로 구성된 문자열 처리](#separator로-구별한-숫자들로-구성된-문자열-처리)
- [MySQL](#mysql)
  - [AUTO\_INCREMENT 초기화 및 재부여](#auto_increment-초기화-및-재부여)
  - [새 계정 table/view/procedure 등의 리스트가 안보일 때](#새-계정-tableviewprocedure-등의-리스트가-안보일-때)


<br>

***

<br>

## Javascript, jQuery

### 텍스트박스 일부문자만 허용하기

연락처 입력을 위해 ***0~9, -*** 만을 허용할 경우

```javascript
$(function() {
    $('[name=example], #example, .example').on('input', function() {
        var value = $(this).val();
        if (/^[0-9\-]+$/.test(value)){

        } else {
            $(this).val(value.slice(0, -1));
        }	
    });
})
```

<br>

***

<br>

## PHP

### separator로 구별한 숫자들로 구성된 문자열 처리

separator로 구별한 숫자들로 구성된 문자열(`ex : 1000||2000||3000`)을 가져와서 천단위 구별쉼표를 붙여서 다시 배열로 담기. 처음 세 개의 원소는 항상 숫자이며 그 다음부터는 문자라고 가정한다.

- intval(param1) : 정수가 아닌 다른 자료형으로 인식하는 정수를 정수로 만들어 리턴
  - param1 : 다른 자료형으로 인식하고 있는 정수
- number_format(param1) : 정수에 천단위 쉼표를 붙여서 리턴
  - param1 : int, float

```PHP
$example = "1000||2000||3000||테스트"
$example_array = explode("||", $example); // 문자열을 쪼개서 배열로 담음
foreach ($example_array as $key => $value)
{
    if (!($value >= 0)) break; // 숫자가 아니면 루프문을 빠져나온다.
    $example_array_separated[] = number_format(intval($value)); // 문자열인 $value를 정수형으로 바꾸고 천단위쉼표를 붙여서 $example_array_separated 배열에 담는다.
}
```

이제 `$example_array_separated` 배열 안에는 천단위 쉼표가 적용된 숫자 세 개가 담겨있다.


<br>

***

<br>

## MySQL

### AUTO_INCREMENT 초기화 및 재부여

AUTO_INCREMENT를 초기화할 때는 반드시 새로 지정하는 시작값이 해당 컬럼에 이미 존재하는 값들 보다 커야 효과가 적용된다.

```MySQL
ALTER TABLE `테이블명` AUTO_INCREMENT = 초기시작값;
```

위와 같이 하면 원하는 값에서부터 AUTO_INCREMENT가 시작되고,

```mysql
set @count = 0;
update `테이블명` set `컬럼명` = @count:=@count+1;
```

위 `컬럼명`에 AUTO_INCREMENT를 적용하는 컬럼을 입력. 위와 같이 하면 초기시작값에서부터 차례대로 숫자를 부여받는다.

<br>
<br>

### 새 계정 table/view/procedure 등의 리스트가 안보일 때

특정한 DB에만 접근 가능한 계정을 만들었을 때 `mysql.user` 테이블에서는 모든 권한이 `N`으로 되어있고, `mysql.db` 테이블에서 그 특정한 db에 한해 해당 계정에 필요한 권한을 부여했을 것이다. 이렇게 했을 때 그 계정으로 접속했을 때 테이블 등 개체들이 리스트업이 되지 않을 수가 있다.

`mysql.proc` 테이블은 개체들의 정보를 담으며 이 테이블에 대해 `select`권한이 없으면 개체들의 목록을 불러오지 못한다. 따라서, 

1. `mysql.tables_priv`
2. `host`, `user` 컬럼을 채우고 `Db` = 'mysql', `Table_name` = 'proc', `Grantor` = 'root계정명', `Table_priv`와 `Column_priv`에는 'Select'를 넣어서 한 줄을 삽입한다.
3. `FLUSH PRIVILEGES;`를 실행한다.

<br>
<br>