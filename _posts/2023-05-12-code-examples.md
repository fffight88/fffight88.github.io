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

```php
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