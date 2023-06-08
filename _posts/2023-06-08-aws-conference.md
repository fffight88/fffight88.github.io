---
layout: post
title: "AWSome day"
author: Victor Lo
tags: [aws, awsomeday]
color: gold
# feature-img: "/assets/img/feature-img/2023-06-02-mistel-md770-0.png"
# thumbnail: "/assets/img/feature-img/2023-06-02-mistel-md770-1.png"
published: true
excerpt_separator: <!--more-->
---

AWS 온라인 컨퍼런스인 AWSome day 액기스만 추출 <!--more-->

## 1강 AWS 클라우드 소개

### 리전 선택 고려사항
* 준수해야 할 규정이 있는 경우 : 지역 기준 등
* 지연 시간 : 주요고객층과 가까운 리전. 지연 시간
* 서비스 제공 유무 : 모든 서비스가 모든 리전에 제공되지는 않음
* 서비스 비용 : 리전마다 다름

### AWS Edge Infra
* AWS Outposts : 온프레미스에 대응
* AWS Local
* AWS WaveLength : 5G 서비스


## 2강 : EC2

### 비용
* 온디맨드
* 예약형
* Savings plan : 온디맨드대비 66퍼센트까지 절약
* 스팟 : 온디맨드대비 90퍼센트까지 절약

### 관리형 vs 비관리형
서비스가 내장되어있느냐 안되어있느냐

### 과금유형
* 규모나 요청횟수가 적으면 서버리스 애플리케이션이 효율적
* 
### Lambda 
* 완전관리형, Stateless, 여러 언어 지원. 
* 사진업로드 - S3 - 람다 - 이미지 인식 - s3

### 블럭/파일/객체 : EBS/EFS,FSx/S3,S3 Glacier

### S3
* 객체수준 스토리지
* 파일, 폴더 X. 모두 수평적인 레벨
* 최소 3개의 가용영역에 자동 저장
* 기본적으로 퍼블릭액세스 불가 - 옵션 조정 가능

### EFS
* Linux 기반 파일 시스템
* 서버리스 - 용량관리필요 x
* 관리형 서비스
* 요청 수가 많아도 동일한 서비스

### FSx for Windows
* 윈도우즈 파일시스템
* 완전관리형
* SMB 프로톹콜

### FSx for Lustre
* Luster 파일시스템

### EBS
* EC2용
* SSD. HDD 지원
* 스냅샷 기능


## 3강 : DB

### 관계형

#### RDS

#### Amazon Aurora
* MySQL, PostgreSQL
* 상용DB 대비 90퍼센트까지 절약
* 표준 MySql보다 5배빠름
* 64TB까지 자동확장

#### Amazon Redshift : 

### 비관계형(NoSQL)

#### DynamoDB
* 완전관리형 NoSQL - 별도로 관리/운영 x
* 낮은 지연 시간 : 10밀리초 미만. 요청규모에 맞게 테이블 자동 조정
* 액세스권한제어 : IAM
* 유연성

#### EC2, S3, DynamoDB 연동 예시
웹사이트 > EC2 instance 웹서버 > S3버켓 > DynamoDB 

1. 미디어 컨텐츠 저장할 S3 버켓 생성
2. DB생성 - DynamoDB
3. 웹서버 생성 - EC2
   - Termination protection : 실수로 종료되지 않게 보호
   - 범용적으로 많이 사용되는 것 : t2.micro
4. EC2인스턴스 IP로 접속


## 4강 : VPC, 서브넷, 보안

### VPC : AWS cloud의 개인 네트워크 공간

### 가용영역

### 서브넷
- 퍼블릭
- 프라이빗

### ELB
- 로드밸런서로 부하를 분산시킴

### 인프라 보안
- VPC 라우팅 테이블
- 네트워크 액세스 제어 목록(서브넷 앞에)
- 보안 그룹 (인스턴스 수준)

### AWS Cloud VPN
- 온프레미스 데이터센터와 연결

### AWS DIrect COnnect
- 인터넷이 아닌 사설 경로를 통한 접속
- 안정적

### IAM
- 사용자, 그룹, 역할에 세분화된 권한 할당
- 임시 계정 공유

### AWS CloudTrail
- AWS계정의 사용자활동 및 API 사용 추적
- 규정준수감사, 보안분석, 문제해결에 유용
- 로그파일은 Amazon S3버킷으로 전송됨

### AWS Trsted Advisor
- 비용최적화, 보안, 성능, 내결함성, 서비스한도 등의 권장사항을 안내하는 서비스


## 5강 : 혁신

### AWS IoT Core: Greengrass

### 기계학습(Machin Learning) : SageMaker

### 블록체인 : Amazon Managed Blockchain (Hyerledger, Etherium)

### 위성통신서비스 : AWS Ground Station

### 5G 서비스 : AWS Wavelength



## 용어
* 자동 크기 조정
* 탄력성

