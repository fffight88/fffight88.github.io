---
layout: post
title: "How to get my SSH-key for Git"
author: Victor Lo
tags: [git, sshkey, ssh-key, keygen]
categories: myjob
color: red
published: true
excerpt_separator: <!--more-->
---

Github 또는 Gitlab에서 사용할 public SSH-key 만들고 등록하기 <!--more-->

<br>

***

<br>

Github이나 Gitlab에서 clone 기능을 문제없이 사용하려면 SSH-key가 꼭 필요하다. SSH-key를 새로 만들고 등록하는 방법을 알아보자. 여기서는 Gitlab과 windows를 이용한다.

시작하기 전에 Gitlab 계정을 생성하고, Gitbash를 설치한다.

## [>>Git Bash 설치하기<<](https://git-scm.com/downloads)

설치과정 중 Git Bash를 선택할 수 있는 화면에서 선택하여 설치한다.

설치가 끝나면 Git Bash를 실행한 후 다음 셋 중 하나를 입력하는데, 1번부터 순서대로 시도해본다. 

> 1. ssh-keygen
> 2. ssh-keygen -t rsa -b 4096 -C "examaple@example.com"
> 3. ssh-keygen -t ed25519 -C "examaple@example.com"

![](/assets/img/feature-img/2023-05-12-ssh-key-generation-0.png)

입력을 요구하는 부분에서는 전부 그냥 엔터로 넘긴다. 이제, `c:\Users\user\.ssh` 로 가보면 파일이 두 개가 있는데 `id_rsa`는 private, `id_rsa.pub`는 public 키이고 깃랩에 등록해야 하는 키는 public 키이다.

Git Bash에서 `cat /c/Users/user/.ssh/id_rsa.pub` 를 입력하거나, `id_rsa.pub` 파일을 VS Code 등으로 열어보면

![](/assets/img/feature-img/2023-05-12-ssh-key-generation-1.png)

이런 식의 키가 만들어져 있다. 이것을 그대로 카피한 후 깃랩으로 가서 로그인을 하면

![](/assets/img/feature-img/2023-05-12-ssh-key-generation-2.png)

좌측 메뉴에서 `SSH Keys`를 선택하여 우측 상단의 `Add SSH Key` 버튼을 누른다.

![](/assets/img/feature-img/2023-05-12-ssh-key-generation-3.png)

Title에는 원하는 명칭을, Key 부분에 아까 확인했던 키를 붙여넣는데 앞뒤로 개행문자나 공백 등이 붙이지 않고 텍스트 그대로 붙여넣어야 한다. 그 후 `Add Key` 버튼을 누르면

![](/assets/img/feature-img/2023-05-12-ssh-key-generation-4.png)

잘 되는 경우도 있고 이렇게 빨갛게 에러메세지가 뜨는 경우가 있다. 이 때가 위의 세 가지 `ssh-keygen` 중 두 번째를 시도해 볼 때이다. `c:\Users\user\.ssh` 폴더의 파일 두 개를 삭제하고 두 번째 걸로 다시 시도하자. 두 번째 것도 안되면 세 번째 것으로 시도하자. `example@example.com` 에는 자신 계정의 이메일주소를 넣어줘야 한다.

![](/assets/img/feature-img/2023-05-12-ssh-key-generation-5.png)

성공했다면 위와 같은 화면이 보이고, 더 이상 다운로드하려면 SSH-key를 등록하라는 메세지가 뜨지 않을 것이다.