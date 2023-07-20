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
  - [SHA-256 해쉬암호화](#sha-256-해쉬암호화)
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
<br>

### SHA-256 해쉬암호화

여기서는 카드결제시 요청을 보내는 Form 데이터로 예를 든다. 밑의 `hash()`와 `bin2hex()`는 IDE에서 출력되는 함수에 대한 설명을 붙여넣은 것.

```php
$ediDate = date('YmdHis');
$merchantID = "nicepay00m";
$price = 1004;
$merchanKey = "EYzu8jGGMfqaDEp76gSckuvnaHHu+bC4opsSN6lHv3b2lurNYkVXrZ7Z1AoqQnXI3eLuaUFyoRNC6FkrzVjceg==";

$hashString = bin2hex(hash('sha256', $ediDate.$merchantID.$price.$merchantKey, true));
```

```php
function hash(
    string $algo,
    string $data,
    bool|null $binary = false,
    array|null $options = []
): string
Generate a hash value (message digest)

https://www.php.net/manual/function.hash.php

@param $algo: Name of selected hashing algorithm (i.e. "md5", "sha256", "haval160,4", etc..). For a list of supported algorithms see hash_algos().

@param $data: Message to be hashed.

@param $binary: When set to true , outputs raw binary data. false outputs lowercase hexits.

@param $options: An array of options for the various hashing algorithms. Currently, only the "seed" parameter is supported by the MurmurHash variants.

@return Returns a string containing the calculated message digest as lowercase hexits unless binary is set to true in which case the raw binary representation of the message digest is returned.
```

```php
function bin2hex(string $string): string
Convert binary data into hexadecimal representation

Returns an ASCII string containing the hexadecimal representation of string. The conversion is done byte-wise with the high-nibble first.

https://www.php.net/manual/function.bin2hex.php

@param $string: A string.

@return Returns the hexadecimal representation of the given string.
```

<br>
<br>

<br>

***

<br>

## MySQL