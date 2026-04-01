---
title: AllviA Admin
layout: post
---

B2B 교육 플랫폼 관리자 시스템의 핵심 기술 설계를 정리한 문서입니다. 학생·강사·기관 통합 관리를 위한 엔터프라이즈급 보안, 감사 로깅, 권한 제어, AI 협업 개발 프로세스를 다룹니다.

---

### Harness Engineering — AI 협업 개발

#### 핵심 성과
- ___Claude Code + OpenSpec 기반 체계적 워크플로우로 1인 풀스택 엔터프라이즈 시스템 구축___
- ___19개 참조 문서를 CLAUDE.md로 관리하여 AI가 프로젝트 맥락을 완전히 이해한 상태에서 코드 생성___
- ___요구사항 명세 → AI 구현 → 검증의 반복 사이클로 일관된 코드 품질 유지___
- ___Playwright E2E 테스트를 AI가 자동 작성·실행하여 UI 흐름 전체를 검증___

#### AI 협업 아키텍처

```
[OpenSpec 워크플로우]
  요구사항 정의 (spec.md)
    → Change 생성 (Delta: ADDED/MODIFIED/REMOVED)
    → openspec validate --strict (명세 검증)
    → Claude Code 구현 (CLAUDE.md 컨텍스트 주입)
    → 코드 리뷰 & E2E테스트 & 디버깅
    → openspec archive (아카이브)
```

#### CLAUDE.md 컨텍스트 시스템

| 문서 | 역할 | 트리거 |
|------|------|--------|
| 02-code-conventions.md | Java 코드 스타일, 네이밍 규칙 | 새 클래스/메서드 생성 시 |
| 02a-api-request-spec.md | API 요청 DTO 작성 규칙 | Request DTO 생성 시 |
| 02b-api-response-spec.md | API 응답 DTO 작성 규칙 | Response DTO 생성 시 |
| 02c-code-modification-safety.md | 기존 코드 수정 안전 가이드 | 공통 모듈 수정 시 |
| 03-view-controller-pattern.md | View Controller 패턴 | Controller 작성 시 |
| 04-database-conventions.md | DB, Entity, SQL 규칙 | Entity/SQL 작성 시 |
| 05-admin-csr-architecture.md | Alpine.js 프론트엔드 아키텍처 | Admin 프론트엔드 작업 시 |
| 14-ai-assistant-guidelines.md | 구현 전 체크리스트 | Service/Controller 구현 전 |

- **총 19개 참조 문서**가 트리거 조건별로 자동 로딩 → AI가 매번 동일한 코드 컨벤션과 아키텍처를 따름
- Change ID에 날짜 prefix 강제 (`YYYY-MM-DD-descriptive-name`) → 변경 이력 자동 정렬

#### E2E 테스트 자동화

```
[Playwright E2E 테스트 흐름]
  AI가 테스트 가이드(16-playwright-test-guide.md) 참조
    → 페이지 시나리오별 테스트 코드 자동 작성
    → 로그인 → 메뉴 탐색 → CRUD 동작 → 결과 검증
    → MCP(Playwright) 연동으로 브라우저 직접 제어
    → 실패 시 스크린샷 캡처 + 원인 분석 → 코드 수정 → 재실행
    → E2E 테스트 레포트 작성 & 웹에 표시
```

- AI가 테스트 코드 작성부터 실행, 실패 디버깅까지 전 과정을 자율 수행
- 수동 QA 없이 기능 구현 직후 E2E 검증 가능
- 브라우저 제어 시 서브에이전트 간 충돌 후 무한대기 문제 피하기 위해 MCP서버 다중화
- AI가 단일 & 병렬작업 여부 판단 후 필요한 개수만큼 MCP서버 활성화하여 각 서브에이전트에게 할당

#### 사용 기술
- Claude Code (CLAUDE.md, OpenSpec), Playwright (E2E 테스트), Spring Boot 3.3.0, Java 21

---

### 보안 & 암호화 아키텍처

#### 핵심 성과
- ___RSA+AES 하이브리드 암호화로 민감 데이터 전송 구간 전체 암호화___
- ___이메일 OTP 2차 인증 + 계정 잠금으로 다단계 보안 구현___
- ___서버 세션 기반 인증으로 관리자 상태를 안전하게 관리___
- ___로드밸런서의 stickiness 설정 활성화를 통해 다중 서버 환경의 세션 정착성 확보___

#### 인증 흐름

```
[로그인 프로세스]
  아이디/비밀번호 입력
    → 비밀번호 검증 (BCrypt 해싱)
    → 5회 실패 시 → 계정 잠금 (자동 비활성화)
    → 성공 시 → 이메일 OTP 발송 (6자리, 5분 TTL)
    → OTP 검증 성공
    → HttpSession 생성 (서버 메모리, 30분 TTL)

[세션 관리]
  요청마다 → HttpSession 검증
  세션 만료 → 재로그인 요구
  쿠키 정책 → Secure + SameSite=Lax (CSRF 방어)
```

#### 하이브리드 암호화 파이프라인

```
[키 교환 단계]
  클라이언트 → GET /api/encryption/key
    → 서버: RSA 2048-bit 키쌍 생성
    → Public Key를 클라이언트에 전달
    → Private Key를 Redis에 저장 (24시간 TTL, 세션별 격리)

[요청 암호화]
  클라이언트:
    → AES-256-CBC 대칭키 랜덤 생성
    → 요청 본문을 AES로 암호화
    → AES 키를 RSA Public Key로 암호화
    → { encryptedData, encryptedKey, iv } 전송

[서버 복호화]
  EncryptionFilter:
    → Redis에서 RSA Private Key 조회
    → RSA로 AES 키 복호화
    → AES로 요청 본문 복호화
    → 원본 요청으로 Controller에 전달

[응답 암호화]
  → 응답 본문을 동일한 AES 키로 암호화
  → 클라이언트가 보관 중인 AES 키로 복호화
```

#### 보안 설정

| 항목 | 설정값 | 근거 |
|------|--------|------|
| 세션 타임아웃 | 30분 | 관리자 업무 패턴 고려 |
| RSA 키 TTL | 24시간 | 일 1회 키 갱신, 세션보다 긴 수명 |
| 쿠키 정책 | Secure + SameSite=Lax | CSRF 방어 + HTTPS 전용 |
| 로그인 실패 제한 | 5회 | 무차별 대입 방지 |
| OTP 유효시간 | 5분 | 실시간 이메일 확인 강제 |

#### 사용 기술
- Spring Security, HttpSession (서버 메모리), RSA 2048-bit, AES-256-CBC, Redis (키 TTL 관리), BCrypt

---

### AOP 감사 로깅 & 권한 제어

#### 핵심 성과
- ___AspectJ 기반 자동 감사 로깅으로 모든 데이터 변경 사항을 불변 기록으로 보존___
- ___커스텀 @RequirePermission 어노테이션으로 메서드 레벨 권한 제어 구현___
- ___인터셉터 체인으로 요청 흐름 전체에 보안·감사·국제화 정책 적용___

#### 감사 로깅 아키텍처

```
[AOP 인터셉션]
  AdminAuditAspect (@Around)
    → Repository.save() 호출 감지
    → 변경 전/후 엔티티 상태 비교 (delta 추출)
    → 감사 로그 생성:
      ├── 관리자 ID (세션에서 추출)
      ├── IP 주소 (SHA-256 해싱 → 개인정보 보호)
      ├── 타임스탬프
      ├── 대상 엔티티 + 변경 필드
      └── 변경 전/후 값 (delta)
    → 민감 필드 자동 제외:
      ├── 비밀번호, 토큰
      ├── 감사 필드 (createdAt, modifiedAt 등)
      └── 개인정보 필드
    → 불변 감사 로그 DB 저장

[JPA Auditing 연동]
  @CreatedBy / @CreatedAt / @ModifiedBy / @ModifiedAt
    → 모든 Entity에 자동 적용
    → AuditorAware에서 현재 로그인 관리자 ID 주입
```

#### 권한 제어 시스템

```
[@RequirePermission 어노테이션]
  @RequirePermission(menuCode = "STUDENT", actions = {Action.READ, Action.UPDATE})
  @GetMapping("/students")
  public ApiResponse<StudentListResponse> getStudents() { ... }

[런타임 검증 흐름]
  HTTP 요청 수신
    → PermissionCheckInterceptor.preHandle()
    → 핸들러 메서드에서 @RequirePermission 추출
    → 현재 관리자의 권한 그룹 조회
    → menuCode + actions 매칭 검증
    → Visang Super Admin → IP 화이트리스트 추가 검증
    → 기관 레벨 접근 제한 적용
    → 통과 시 → Controller 실행
    → 실패 시 → 403 Forbidden 반환
```

#### 인터셉터 체인

```
[요청 처리 순서]
  HTTP 요청
    → ① LocaleChangeInterceptor (?lang=ko → 로케일 변경)
    → ② MenuCodeInterceptor (URL → 메뉴 코드 매핑, 네비게이션 활성화)
    → ③ PermissionCheckInterceptor (@RequirePermission 검증)
    → ④ AdminActionInterceptor (감사 컨텍스트 생성, IP 해싱)
    → Controller → Service → Repository
    → AdminAuditAspect (데이터 변경 감사 로그)
    → 응답 반환
```

| 순서 | 인터셉터 | 역할 |
|------|----------|------|
| ① | LocaleChangeInterceptor | 다국어 전환 처리 |
| ② | MenuCodeInterceptor | URL-메뉴 매핑, 사이드바 활성화 |
| ③ | PermissionCheckInterceptor | @RequirePermission 기반 RBAC 검증 |
| ④ | AdminActionInterceptor | 감사 로그용 컨텍스트(관리자 ID, 해싱 IP) 생성 |

#### 사용 기술
- Spring AOP (AspectJ), JPA Auditing, Spring MVC Interceptor, 커스텀 어노테이션

---

### 멀티테넌트 & 확장성

#### 핵심 성과
- ___기관별 데이터 격리로 멀티테넌트 환경에서 안전한 데이터 접근 보장___
- ___6개 언어 다국어 지원으로 글로벌 교육 시장 대응___
- ___S3 Presigned URL + Excel 대량 등록으로 대규모 데이터 처리 효율화___

#### 멀티테넌트 데이터 격리

```
[기관별 접근 제어]
  관리자 로그인
    → 할당된 기관 목록 로딩
    → 모든 쿼리에 기관 필터 자동 적용
    → QueryDSL Predicate로 타입 세이프 필터링

  예시:
    HQ 관리자 → 전체 기관 접근
    기관 관리자 A → 기관 A 데이터만 조회/수정 가능
    기관 관리자 B → 기관 B 데이터만 조회/수정 가능
```

#### 파일 업로드 아키텍처

```
[S3 Presigned URL 직접 업로드]
  클라이언트 → POST /api/files/presigned-url
    → 서버: 컨텍스트별 S3 경로 생성
      ├── site-bg/      (사이트 배경)
      ├── site-logo/     (사이트 로고)
      ├── post-attachment/ (게시글 첨부)
      └── help-attachment/ (문의 첨부)
    → Presigned URL 발급 (PUT 권한, 만료 시간 설정)
    → 클라이언트가 S3에 직접 업로드 (백엔드 무경유)
    → 업로드 완료 후 → POST /api/files/complete
    → 메타데이터 DB 저장

[파일 검증]
  MIME 타입 + 확장자 이중 검증
    ├── 이미지: jpg, png, webp
    ├── 동영상: mp4, webm
    └── 문서: pdf, docx
  기관별 파일 격리 (S3 경로에 기관 ID 포함)
```

#### Excel 대량 등록

```
[Bulk Registration 흐름]
  Excel 템플릿 다운로드
    → 사용자가 데이터 입력 (학생/강사 정보)
    → Excel 업로드 → Apache POI 파싱
    → 행별 유효성 검증:
      ├── 필수 필드 확인
      ├── 이메일/전화번호 형식 검증
      ├── 중복 데이터 체크
      └── 기관 소속 확인
    → 트랜잭션 내 일괄 등록
    → 결과 리포트:
      ├── 성공: 152건
      ├── 실패: 3건
      └── 실패 상세 (행 번호 + 사유)
```

#### 다국어 (i18n) 시스템

| 언어 | 코드 | 파일 |
|------|------|------|
| 한국어 | ko | messages_ko.properties |
| English | en | messages_en.properties |
| 日本語 | ja | messages_ja.properties |
| Tiếng Việt | vi | messages_vi.properties |
| O'zbek | uz | messages_uz.properties |
| Монгол | mn | messages_mn.properties |

```
[로케일 처리 흐름]
  사용자 → ?lang=vi (URL 파라미터)
    → LocaleChangeInterceptor 감지
    → CookieLocaleResolver로 쿠키에 저장
    → 이후 요청은 쿠키 기반 자동 적용
    → MessageSource에서 해당 언어 메시지 로딩
    → Thymeleaf 템플릿에서 #{message.key}로 렌더링
    → Excel 내보내기 시에도 i18n 헤더 적용
```

#### 사용 기술
- QueryDSL 5.0 (타입 세이프 쿼리), AWS S3 (Presigned URL), Apache POI 5.2.5 (Excel), Spring i18n (MessageSource, CookieLocaleResolver), Kafka (비동기 이벤트)
