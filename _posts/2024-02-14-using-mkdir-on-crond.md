---
layout: post
title: "cron에서 mkdir()이 실행되지 않을 때"
author: Victor Lo
tags: [cron, 크론, mkdir, php, 권한]
categories: coding
color: pink
published: true
excerpt_separator: <!--more-->
---

cron에서 mkdir()이 실행되지 않을 때<!--more-->
<br>

***

<br>

협력사로부터 주문정보와 매출정보를 주고받을 때 crond를 이용하는데, 주문정보는 가져오지만 시안이 담긴 파일을 못가져오는 상황이 발생, 이방법 저방법 시도하면서 해결한 스토리

(결론만 보실 분은 [결론](#결론)으로 이동)

* 개발환경: 웹, PHP5.6, MySQL, AWS(Apache2.4)
<br>
<br>

## 삽질내용

<br>
<br>

## 결론
* 해당 cron을 등록한 계정이 실행하려는 파일과 그 파일이 들어있는 폴더 접근 권한이 있느냐 없느냐
* 즉, 실행하려는 파일과 그 파일이 들어있는 폴더의 소유자를 해당 cron을 등록한 계정으로 하거나 그룹을 cron을 등록한 계정이 속해있는 그룹으로 설정한다. 이 때 권한을 `0777`로 바꿀 필요가 없다.
  > `example` 이라는 사용자계정이 `user` 라는 그룹에 속해있다면 - `chown example:user /파일경로` <br>
  > `example` 이라는 계정이 속한 그룹을 확인하려면 - `groups example`
* 실험 결과 위 작업은 대상 파일과 그 파일의 부모폴더 까지만 하면 되고 더 상위의 폴더에는 안해도 되는 것으로 보임.
* 계정별 등록한 cron 작업내용을 보려면 `/var/spool/cron` 폴더내에 계정명으로 된 파일 확인
* 파일이나 폴더의 권한을 0777로 바꾸는 방법은 사용하지 말 것. 보안상 매우 취약해진다.
* `/var/log/cron`에서 로그를 확인할 수 있다.
* crontab 파일 보기 - `crontab -l`, crontab 파일 수정 - `crontab -e`
<br>
<br>

## 논외 - 찾아보면서 알게 된 내용
* cron으로 실행할 파일을 작성할 때 `$_SERVER` 변수를 사용할 수 없다. 웹으로 실행할 때만 사용가능함.
  > 예) 폴더경로를 지정할 때 `$_SERVER['document_root']/하위경로...` 처럼 주면 안되고 절대경로로 하드코딩해야.
* 웹으로 파일을 실행할 때도 `mkdir()`이 안되는 등 권한문제가 발생할 수 있는데, apache로 웹서버를 돌리면 보통 기본적으로 계정명:그룹명이 apache:apache로 설정되어 있다.
* 웹에서의 계정명:그룹명을 확인하려면 `/etc/httpd/conf/httpd.conf` 파일에서 확인할 수 있다.
  > User xxxx <br>
  > Group xxxx

<br>
<br>

## 참고문헌
1. [https://finance-it.tistory.com/106](https://finance-it.tistory.com/106)
2. [https://stackoverflow.com/questions/5246114/php-mkdir-permission-denied-problem](https://stackoverflow.com/questions/5246114/php-mkdir-permission-denied-problem)