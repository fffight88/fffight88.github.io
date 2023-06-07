---
layout: post
title: "Coding Tips & Knowhow"
author: Victor Lo
tags: [javascript, php, mysql]
categories: code
color: lightblue
excerpt_separator: <!--more-->
---
초보/신입 개발자가 코딩할 때 사소하지만 간과하기 쉬운 내용 정리 <!--more-->

***목차***

- [JavaScript](#javascript)
  - [반복문으로 뿌려지는 데이터를 대상으로 jQuery 사용 시 주의할 점](#반복문으로-뿌려지는-데이터를-대상으로-jquery-사용-시-주의할-점)
- [PHP](#php)
  - [연관배열에서 값을 가져올 때 주의할 점](#연관배열에서-값을-가져올-때-주의할-점)
  - [문자열처리 함수사용시 한글 깨짐](#문자열처리-함수사용시-한글-깨짐)
- [MySQL](#mysql)
  - [UPDATE 문에서 주의사항](#update-문에서-주의사항)

<br>

***

<br>

## JavaScript

### 반복문으로 뿌려지는 데이터를 대상으로 jQuery 사용 시 주의할 점

- 반복문으로 여러 개의 데이터가 뿌려지는 경우 각각의 데이터를 포함하는 태그, 즉 `<td>`나 `<input>` 등의 태그는 DB로부터 기본키 따위의 유니크한 데이터를 넘겨받아 이를 `name`이나 `data-`속성 등으로 가지고 있게 해야 편하다. 이런 과정 없이는 추후에 화면단에 뿌려진 데이터를 input 등으로 이용하기 위해 선택하려 할 때 애를 먹게 된다.
   
<br>

- jQuery 함수의 시작점이 되는 객체, 즉 `$(this)`로부터 위 1번에서 설명한 유니크한 데이터를 물고 있는 객체까지 가는 길을 잘 보아야 한다. 즉 `parent()`, `children()`, `siblings()` 등의 함수를 적절히 사용할 줄 알아야 하며 `[속성=값]` 등의 선택자도 마찬가지인데, 별거아니지만 꼭 기억할 것은 '값'의 부분에 변수를 넣고 싶다면 그냥 변수명을 입력할 것이 아니라 `' + 변수명 + '`를 이용해야 한다. 예를 들어
   
```javascript
var name = "yourGreatName";
$(this).parent().siblings('td[name=name]').children('input').val();
```

이렇게 하면 아무런 일도 일어나지 않고, 

```javascript
var name = "yourGreatName";
$(this).parent().siblings('td[name=' + name + ']').children('input').val();
```

이런 식으로 써줘야 한다. 

<br>

***

<br>

## PHP

### 연관배열에서 값을 가져올 때 주의할 점
***feat.Array to String 에러***
```php
$where_in = array(
    '0' => array(
        '0' => "POA001",
        '1' => "POA002",
        '2' => "POA003"
    ),
    '1' => array(
        '0' => "POA004",
        '1' => "POA005",
        '2' => "POA006"
    )
);
```

iteration을 할 때 `for` 또는 `foreach`를 사용하는데, `for`는 약간 귀찮지만 좀 더 직관적이어서 이해하기 쉽지만 `foreach`는 살짝 **헷갈릴** 때가 있다.

예를 들어, 위 연관 배열에서 값에 해당하는 내용들만 뽑아 새로운 일차원 배열을 만든다고 하면, `for`문을 이용하면 어렵지 않다.


```php
$where_in_values = array();
for ($i=0; $i<count($where_in); $i++)
{
    for ($j=0; $j<count($where_in[$i]); $j++)
    {
        $where_in_values = $where_in[$i][$j];
    }
}
print_r($where_in_values);
```

> Array ( [0] => POA001 [1] => POA002 [2] => POA003 [3] => POA004 [4] => POA005 [5] => POA006 )

계속...

<br>
<br>

### 문자열처리 함수사용시 한글 깨짐

요즘 개발할 때 한글 인코딩을 거의 "UTF-8"로 하는데 이 때 한글은 2바이트가 아니라 3바이트가 된다. 한글이 깨지는 대부분의 원인이 여기에 있다. 한글을 문자열처리 함수에 사용해야 할 때는 mb_string 함수들을 사용하자. 물론 mb_string 라이브러리를 설치해야 한다.

> 예: substring("안녕하세요", 0, 2) 가 아니라 mb_substring("안녕하세요", 0, 2)

<br>

***

<br>

## MySQL

### UPDATE 문에서 주의사항
***You can't specify target table 'example_table' for update in FROM clause***

mysql에서는 업데이트의 대상이 되는 테이블의 이름을 where절에서 직접 사용하려 하면 위의 에러메세지가 뜨면서 쿼리가 먹히지 않는다. 즉,

```sql
UPDATE `example_table` SET `example_col1` = '387' WHERE `example_col2` IN (
	SELECT `example_col2` FROM `example_table` WHERE `example_col1` = '386');
```

위와 같이 쿼리를 입력하면 에러가 발생하므로, 이 때는 where절 안의 from절 테이블에 별칭을 줘서 조회를 하게 하는 방식으로 해결한다.

```sql
UPDATE `example_table` SET `example_col1` = '387' WHERE `example_col2` IN (
	SELECT `a`.`example_col2` FROM (
		SELECT * FROM `example_table` WHERE `example_col1` = '386') AS a);
```

