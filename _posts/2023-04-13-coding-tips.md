---
layout: post
title: "Coding Tips & Knowhow"
author: Victor Lo
tags: [code]
categories: code
color: lightblue
excerpt_separator: <!--more-->
---
초보/신입 개발자가 코딩할 때 간과하기 쉬운 내용 정리 <!--more-->


***목차***

- [JavaScript](#javascript)
  - [반복문으로 뿌려지는 데이터를 대상으로 jQuery 사용 시 주의할 점](#반복문으로-뿌려지는-데이터를-대상으로-jquery-사용-시-주의할-점)
- [PHP](#php)
  - [연관배열에서 값을 가져올 때 주의할 점](#연관배열에서-값을-가져올-때-주의할-점)

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

iteration을 할 때 `for` 또는 `foreach`를 사용하는데, `for`는 약간 귀찮지만 좀 더 직관적이어서 이해하기 쉽지만 `foreach`는 살짝 헷갈릴 때가 있다.

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

***

<br>



