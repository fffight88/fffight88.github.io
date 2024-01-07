---
layout: post
title: "XAMPP - How to get desired domain on my server"
author: Victor Lo
tags: [xampp, vhost, hosts]
categories: server management
color: red
published: true
excerpt_separator: <!--more-->
---

XAMPP 사용시 자신의 웹서버 또는 로컬 서버에서 특정 IP에 원하는 도메인 부여하기 <!--more-->

<br>

***

<br>

- httpd-vhosts.conf 파일을 연다.

`C:\xampp\apache\conf\extra\httpd-vhosts.conf`
- 아래 태그를 추가하고 저장한다. 태그 사이에 다른 속성을 더 추가할 수 있지만 아래의 두 가지 속성은 필수임.

 ```xml
<VirtualHost *: 80> 
  DocumentRoot "c:/xampp/htdocs/example/"
  ServerName example.example
</VirtualHost>
```
- `C:\Windows\System32\drivers\etc\hosts` 파일을 관리자모드의 편집기에서 연다.
- `[IP주소] [원하는 도메인명]`을 한 줄 추가하고 저장한다.

> 예시 : `127.0.0.1 example.example`

- 서버를 재시작한다.