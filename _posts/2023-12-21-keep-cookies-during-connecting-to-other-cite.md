---
layout: post
title: "페이지 이동하면 세션이 없어져요"
author: Victor Lo
tags: [cookie, session, 쿠키, 세션, 303 see other, 코드이그나이터, php]
categories: coding
color: lightblue
# feature-img: "/assets/img/feature-img/2023-06-02-mistel-md770-0.png"
# thumbnail: "/assets/img/feature-img/2023-06-02-mistel-md770-1.png"
published: true
excerpt_separator: <!--more-->
---

크로스사이트 간 페이지이동(POST, AJAX)시 세션(쿠키) 온전히 유지하는 방법(PHP, CodeIgnitor)<!--more-->
<br>

***

<br>

최근 회사b2b쇼핑몰의 모바일웹앱 개발 프로젝트를 수행하면서 나를 정말 멘붕으로 몰아넣었던 부분이 세가지가 있었다.

> 1. 레거시 프로젝트의 테스트서버 구축
> 2. 인코딩(EUC-KR) 문제
> 3. 303 see other 스테이터스와 함께 로그아웃, 로그인페이지로 리다이렉트

이 중 3번에 대해 기록해보려고 한다. (결론만 보실 분은 [결론](#결론)으로 이동)

* 개발환경: 웹, PHP5.6, CodeIgnitor3, MySQL, AWS(Apache2.4)
<br>

## 삽질내용
* 현상: pg사에 결제승인API 호출 후 데이터 리턴받을 때 파라미터로 보낸 리턴URI로 접속하는데, ___ 대여섯번에 한 번 ___ 은 로그아웃된 상태로 로그인 페이지로 리다이렉트됨(DevTool에 보면 `303 see other` 스테이터스가 뜸).
* 생각의 흐름
  1. 세션문제인가? 근데 세션문제이면 할 때마다 로그인 페이지로 연결되어야지 왜 대여섯번에 한번만 그래? 세션이 원인이 아닌 것 같아. (DevTool에서 쿠키 내용을 보지는 않고 넘어감)
  2. 파라미터 문제인가? (파라미터들을 pg사 개발매뉴얼과 대조해 봄) 아니야 파라미터 문제이면 여기 단계까지 오기 전에 이미 에러가 발생했을 거야.
  3. 이게 우리회사만 그런가, 다른 회사도 이런 경우가 있었나? (pg사 기술지원팀에 메일을 보내 이러한 히스토리가 있었는지 문의했더니 이런 경우에 대한 히스토리는 없고 우리회사의 코드쪽에 문제가 있는 것 같다는 답변만 들음) 
  4. CI의 Router 클래스 어딘가에서 문제가 발생하나? 아님 그 근처 로직 어딘가에 이상이 발생할 만한 여지가 있는가? (코드를 검토해 보았으나 이상은 못 찾음)
   * Router 클래스를 통해 어느 클래스의 어느 메소드로 연결해 줄 것인지가 정해짐.
  5. 아무래도 세션이 문제인 것 같은데? (DevTool에서 `303 see other` 스테이터스가 뜰 때 요청시의 세션값과 응답시의 세션값이 달라지고(즉, 세션값이 다른 새로운 세션이 생성), 두 세션의 데이터를 비교해보니 데이터가 다른 것을 발견) 세션 문제가 맞는 것 같아! 어떻게 세션을 유지시키지?
<br>

![DevTool의 쿠키 탭](C:\coding\workspace\fffight88.github.io\assets\img\feature-img\2023-12-21-keep-cookies-during-connecting-to-other-cite_1.png)
<br>

위 그림에서, 현재는 설정을 바꿔주었기에 `Secure`에 표시가 되어있고 `SameSite`에 `None` 이라는 값이 보이지만, 바꿔주기 전에는 표시도 되어있지 않았고 None이라는 값도 뜨지 않았다. 타 사이트간의 페이지이동시 쿠키데이터를 유지하려면 `SameSite`에 `None`값을 줘서 타 사이트간 이동시에도 쿠키데이터를 유지해야한다고 설정값을 줘야 하고, `SameSite=None` 옵션을 사용하려면 `Secure=True` 로 설정해줘야 한다고 한다.
<br>
<br>

## 결론
`application/config/config.php` 에서 cookie 설정주는 부분을 찾아 다음과 같이 수정하거나 추가한다.

```php
$config['cookie_secure'] = TRUE;
$config['cookie_path'] = '/; SameSite=None';
```
<br>

설정을 이렇게 바꾼 이후로는 더 이상 `303 see other`가 발생하지 않고 있다.