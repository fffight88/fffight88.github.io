---
layout: post
title: "페타애드텍 작업 관련 미팅준비 자료"
author: Victor Lo
tags: [페타]
categories: myjob
color: green
published: false
excerpt_separator: <!--more-->
---

페타애드텍 작업 관련 미팅준비 자료 <!--more-->

<br>

***

<br>

## TCPS 주문목록화면

### get_page_list_t_order()



1. 주문번호 생성시 페타애드텍 구분자 - inc파일 통해서 시리얼넘버 생성
2. 중간테이블 : t_order용 p_order용
3. 전송여부 플래그
4. 주문접수시 - 오더번호 업데이트
5. 필요한 코드값 페타애드텍에 제공
6. 30초마다 ajax통신으로 중간테이블에서 우리테이블에 insert