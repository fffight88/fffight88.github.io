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
  - [요청쿼리에서 한글이 url인코딩 안되게 하기](#요청쿼리에서-한글이-url인코딩-안되게-하기)
    - [버전 6이상](#버전-6이상)
    - [버전 5이하](#버전-5이하)
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

### 요청쿼리에서 한글이 url인코딩 안되게 하기

요즘 보통 `json_encode()` 함수를 이용하여 json 형식으로 많이 송수신하는데, 파라메터 중에 한글로 된 데이터가 있다면 한글을 멀티바이트 문자로 인식하므로 `json_encode()`를 거치면서 (보통) `\uXXXX` 형식으로 인코딩된다. 그럼 요청을 수신하는 측에서는 디코딩을 해야하는 불편이 있어 인코딩이 안되게 해달라고 요청하기도 한다.

#### 버전 6이상

PHP의 버전이 6이상이라면 아주 간단하게 해결이 가능하다. `json_encode()` 함수의 파라메터가 추가되면서 이를 해결할 수 있는 옵션을 부여할 수 있게 되었다.

```php
$post_data = json_encode($post_data, JSON_UNESCAPED_UNICODE);
```

위와 같이 두 번째 파라메터로 옵션을 추가해주면 한글을 인코딩하지 않은 상태 그대로 전송이 가능하다. 아래는 두 번째 파라메터에 들어가는 옵션에 대한 설명.

```php
json_encode(mixed $value, int|null $flags = 0, int|null $depth = 512): bool|string
$flags: Bitmask consisting of JSON_FORCE_OBJECT , JSON_HEX_QUOT , JSON_HEX_TAG , JSON_HEX_AMP , JSON_HEX_APOS , JSON_INVALID_UTF8_IGNORE , JSON_INVALID_UTF8_SUBSTITUTE , JSON_NUMERIC_CHECK , JSON_PARTIAL_OUTPUT_ON_ERROR , JSON_PRESERVE_ZERO_FRACTION , JSON_PRETTY_PRINT , JSON_UNESCAPED_LINE_TERMINATORS , JSON_UNESCAPED_SLASHES , JSON_UNESCAPED_UNICODE , JSON_THROW_ON_ERROR . The behaviour of these constants is described on the JSON constants page.


Returns the JSON representation of a value
Returns a string containing the JSON representation of the supplied `value`. If the parameter is an `array` or `object`, it will be serialized recursively.
```

#### 버전 5이하

버전이 5이하이면 `json_encode()` 함수에 두 번째 파라메터로 옵션을 지정할 수 없고 옵션을 줘서 해 보면 오류가 발생한다. 이 때에는 아래의 함수를 추가하여 `json_encode()` 함수를 이 함수의 파라메터로 준다.

***아래 정규표현식에서 `/e`수정자를 볼 수 있는데 이는 7미만의 버전에서만 사용가능하며 7버전부터는 `preg_replace_callback()` 함수를 이용하여 `/e` 수정자없이도 콜백함수를 호출할 수 있다.***

```php
function han($s)
{
  return reset(json_decode('{"s":"' . $s . '"}'));
}

function to_han($str)
{
  return preg_replace('/(\\\u[a-f0-9]+)+/e', 'han("$0")', $str);
}

$post_data = to_han(json_encode($post_data));
```

1. `$post_data` 가 `json_encode()` 를 거쳐서 하나의 json문자열로 인코딩되는데 이 때 물론 한글은 유니코드 방식으로 자동으로 인코딩된다.
2. 1번에서 반환된 json문자열이 `to_han()` 함수를 거치는데 이 함수는 주어진 문자열에서 유니코드 이스케이프 시퀀스(보통 \uXXXX 형식)를 추출한 결과를 `han()` 의 인자로 주면서 호출한다. 즉 유니코드 이스케이프 시퀀스를 만날 때마다 `han()` 함수를 호출한 후 반환값으로 치환한다.
3. `han()` 함수에서는 유니코드 이스케이프 시퀀스를 디코딩하여 주어진 방식의 문자열로 만들어준다.
4. 따라서 `to_han()` 함수를 거치고 나면 유니코드 이스케이프 시퀀스가 모두 한글로 바뀐 json문자열이 반환된다.

<br>
<br>

<br>

***

<br>

## MySQL