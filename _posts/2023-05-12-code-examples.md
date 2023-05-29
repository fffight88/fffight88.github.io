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