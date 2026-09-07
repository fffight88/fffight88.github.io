---
title: Engineering
layout: landing
description: 기술 상세 포트폴리오
image: assets/images/project.jpg
nav-menu: true
weight: 3
---

<!-- Main -->
<div id="main">

<!-- cc-baseline -->
<section id="cc-baseline">
	<div class="inner">
		<header class="major">
			<h2>cc-baseline</h2>
		</header>
		<p><i><b>Claude Code 하네스 번들 인스톨러 — 개발환경 표준화 사이드 프로젝트</b></i></p>
		<p>머신이 바뀌어도 동일한 AI 코딩 환경을 재현하기 위한 도구. 행동규칙·에이전트·스킬·훅·MCP 설정을 하나의 번들로 묶어, 기존 설정을 덮어쓰지 않고 병합 설치하는 npx 인스톨러</p>
		<br>
		<div id="cc-baseline-details" class="spotlights">
			<header class="major">
				<h4>5-에이전트 QA 파이프라인 설계</h4>
			</header>
			<p>design-director(방향 결정) → publisher(마크업·CSS 작성) → security-auditor + code-reviewer(병렬 리뷰) → e2e-tester(동작 검증)의 5단계 파이프라인을 정의. 각 게이트의 소유자를 <b>중복제거 매트릭스</b>로 명시하여 에이전트끼리 같은 검사를 반복하지 않도록 했고, 모든 이슈에 <code>decision_type</code>(auto / design / business)을 부여해 자동 수정 대상과 사용자 판단이 필요한 항목을 분리.</p>
			<ul class="actions" style="text-align: center;">
				<li><a href="all_posts.html#5-에이전트-qa-파이프라인-설계" class="button">자세히 보기</a></li>
			</ul>
			<header class="major">
				<h4>런타임 결함 게이트 (§0 Pre-pass)</h4>
			</header>
			<p>정적 리뷰로는 구조적으로 잡히지 않는 결함군(화이트라벨 화면, 미바인딩 핸들러로 인한 <code>ReferenceError</code>, 동작하지 않는 버튼)을 잡기 위해 e2e-tester에 필수 사전검사를 내장. 모든 화면 전환·클릭 후 런타임 불변식(에러 페이지 없음 / 4xx·5xx 없음 / 콘솔 에러 0)을 단언하고, 클릭 가능한 요소를 전수 열거해 관측 가능한 반응이 없으면 FAIL 처리 — 삭제·로그아웃·결제 등 파괴적 컨트롤은 자동 제외.</p>
			<ul class="actions" style="text-align: center;">
				<li><a href="all_posts.html#런타임-결함-게이트-설계" class="button">자세히 보기</a></li>
			</ul>
			<header class="major">
				<h4>비파괴 병합 & 자가 진단</h4>
			</header>
			<p>사용자의 기존 <code>~/.claude</code> 설정을 보존하는 것이 설계의 제1원칙. 문서는 마커블록 치환, 훅은 <code>_ccBaselineId</code> 기준 중복 수렴, MCP는 키 단위 병합으로 처리하며 설치 전 타임스탬프 백업을 남김. 실제로 세션종료 훅이 23회 중복 등록된 설치 사례를 발견해, 첫 항목만 교체하고 멈추던 병합 로직을 전량 수렴 방식으로 수정하고 <code>--doctor</code>가 중복 등록을 경고하도록 보강.</p>
			<ul class="actions" style="text-align: center;">
				<li><a href="all_posts.html#비파괴-병합--자가-진단" class="button">자세히 보기</a></li>
			</ul>
			<header class="major">
				<h4>보안 스캔 & 감사 리포트 자동화</h4>
			</header>
			<p>semgrep(SAST) · gitleaks(시크릿) · trivy(SCA)를 실제로 실행해 JSON + Markdown 구조화 리포트를 생성. 스캐너가 설치되어 있지 않으면 조용히 건너뛰지 않고 <code>scanner-gap</code> 이슈로 명시 보고하며, 에이전트·커맨드 정의 파일 자체의 <b>프롬프트 인젝션 패턴</b>도 점검 대상에 포함. 결과 JSON은 심각도순 색상 코딩된 HTML 리포트로 변환되어 스캔 종료 시 자동으로 열림.</p>
			<ul class="actions" style="text-align: center;">
				<li><a href="all_posts.html#보안-스캔--감사-리포트-자동화" class="button">자세히 보기</a></li>
			</ul>
		</div>
		<br>
		<h4>Tech Stack</h4>
		<ul>
			<li><b>Runtime:</b> Node.js 18+ (외부 의존성 0 — 내장 모듈만 사용)</li>
			<li><b>CLI:</b> bin/cli.js (인자 파싱), src/install.js (설치 오케스트레이션), src/conflict-checker.js (훅 충돌 감지)</li>
			<li><b>Merge:</b> 마커블록 마크다운 병합, settings.json 훅 중복제거 병합, mcpServers 키 병합</li>
			<li><b>Templates:</b> CLAUDE.md, memory 16개, agents 5개, commands 4개 (총 33개 파일)</li>
			<li><b>Integration:</b> Claude Code Hooks, MCP (Playwright ×5 병렬), terminal-notifier</li>
			<li><b>Scanners:</b> semgrep, gitleaks, trivy (자동 설치)</li>
			<li><b>Install:</b> <code>npx</code> 단일 명령 설치, <code>--dry-run</code> / <code>--doctor</code> / <code>--uninstall</code> 지원</li>
		</ul>

		<h4>개발기간</h4>
		<p>2026년 4월 ~ 진행 중</p>
	</div>
</section>

<!-- Grimbang -->
<section id="grimbang">
	<div class="inner">
		<header class="major">
			<h2>Grimbang (그림방)</h2>
		</header>
		<p><i><b>AI 유튜브 썸네일 생성 SaaS — 바이브코딩 1인 풀스택 개발 (Prompt Engineering)</b></i></p>
		<p>"Your Sentence, Becomes Art." — 한 문장의 프롬프트로 유튜브 썸네일을 생성하고, 자연어 지시만으로 정밀 편집까지 수행하는 SaaS 서비스</p>
		<br>
		<div id="grimbang-details" class="spotlights">
			<header class="major">
				<h4>AI 파이프라인 아키텍처</h4>
			</header>
			<p>5개 AI 모델 비교 후 Gemini 3.1 Flash를 단일 생성 모델로 선정 (Global Elo #2, 2K 네이티브). 정밀 편집은 Kontext Pro + Recraft Crisp 2단계 파이프라인으로 <b>45% 비용 절감</b>. PostgreSQL 단일 UPDATE문으로 크레딧 원자적 차감 및 실패 시 자동 롤백. Gemini 3.1 실패 시 2.5 Flash 자동 Fallback.</p>
			<ul class="actions" style="text-align: center;">
				<li><a href="all_posts.html#ai-파이프라인-설계" class="button">자세히 보기</a></li>
			</ul>
			<header class="major">
				<h4>한글 NLP & Prompt Engineering</h4>
			</header>
			<p>비라틴 문자 자동 감지 → Gemini 2.5 Flash 번역 → Kontext 전달 파이프라인. 유튜브 CTR 이론(Rule of Thirds, 색상 심리학, 호기심 갭)을 70줄 시스템 프롬프트에 압축하여 전문가 수준 썸네일 자동 생성.</p>
			<ul class="actions" style="text-align: center;">
				<li><a href="all_posts.html#한글-nlp--프롬프트-엔지니어링" class="button">자세히 보기</a></li>
			</ul>
		</div>
		<br>
		<h4>Tech Stack</h4>
		<ul>
			<li><b>Frontend:</b> Next.js 16, React 19, Tailwind CSS v4, TypeScript 5</li>
			<li><b>Backend:</b> Next.js API Routes (Serverless), Vercel</li>
			<li><b>Database & Auth:</b> Supabase (Google OAuth, PostgreSQL, Storage)</li>
			<li><b>AI:</b> Google Gemini 3.1 Flash (생성), fal.ai FLUX Kontext Pro + Recraft Crisp Upscale (정밀 편집)</li>
			<li><b>Payments:</b> Polar (구독 결제)</li>
		</ul>

		<h4>개발기간</h4>
		<p>2026년 2월초 ~ 3월말</p>

		<p><a href="https://grimbang.art" target="_blank">서비스 바로가기</a> &nbsp;|&nbsp; <a href="https://github.com/fffight88/grimbang-public" target="_blank">GitHub</a></p>
	</div>
</section>

<!-- AllviA Admin -->
<section id="allviA-admin">
	<div class="inner">
		<header class="major">
			<h2>AllviA Admin</h2>
		</header>
		<p><i><b>B2B 교육 플랫폼 관리자 시스템 — 바이브코딩 1인 풀스택 개발 (Harness Engineering)</b></i></p>
		<p>학생·강사·기관을 통합 관리하는 멀티테넌트 어드민 대시보드. AOP 기반 감사 로깅, RSA+AES 하이브리드 암호화, 선언적 RBAC, 6개 언어 다국어 지원까지 엔터프라이즈 수준의 보안·컴플라이언스를 구현한 관리 시스템</p>
		<br>
		<div id="allvia-admin-details" class="spotlights">
			<header class="major">
				<h4>Harness Engineering — AI 협업 개발</h4>
			</header>
			<p>Claude Code를 핵심 개발 파트너로 활용하여 1인 풀스택 개발을 실현. OpenSpec 기반 요구사항 명세 → AI 구현 → 검증의 체계적 워크플로우를 구축하고, 19개 참조 문서(코드 컨벤션, DB 규칙, 보안 가이드 등)를 CLAUDE.md로 관리하여 AI가 프로젝트 맥락을 완전히 이해한 상태에서 코드를 생성. AOP 감사 로깅, 암호화 파이프라인, i18n 시스템까지 엔터프라이즈급 기능을 빠르게 구현.</p>
			<ul class="actions" style="text-align: center;">
				<li><a href="all_posts.html#harness-engineering--ai-협업-개발" class="button">자세히 보기</a></li>
			</ul>
			<header class="major">
				<h4>보안 & 암호화 아키텍처</h4>
			</header>
			<p>서버 세션 기반 인증에 이메일 OTP 2차 인증(6자리, 5분 TTL)을 결합. 민감 데이터 전송 시 세션별 RSA 2048-bit 키 교환 후 AES-256-CBC로 요청/응답 전체를 암호화하며, 키는 Redis에 24시간 TTL로 관리. 5회 로그인 실패 시 계정 잠금 + IP SHA-256 해싱으로 개인정보 보호.</p>
			<ul class="actions" style="text-align: center;">
				<li><a href="all_posts.html#보안--암호화-아키텍처" class="button">자세히 보기</a></li>
			</ul>
			<header class="major">
				<h4>AOP 감사 로깅 & 선언적 RBAC</h4>
			</header>
			<p>AspectJ가 Repository.save()를 인터셉트하여 모든 데이터 변경을 자동 기록 — 관리자 ID, 해싱된 IP, 타임스탬프, 엔티티 변경분(delta)을 불변 감사 로그로 저장하며 비밀번호·토큰 등 민감 필드는 자동 제외. 커스텀 <code>@RequirePermission</code> 어노테이션으로 메뉴 코드 + CRUD 액션을 선언적으로 제어하고, 인터셉터 체인이 런타임에 권한을 검증.</p>
			<ul class="actions" style="text-align: center;">
				<li><a href="all_posts.html#aop-감사-로깅--권한-제어" class="button">자세히 보기</a></li>
			</ul>
			<header class="major">
				<h4>멀티테넌트 & 확장성</h4>
			</header>
			<p>기관별 데이터 격리(관리자당 접근 가능 기관 필터링), QueryDSL 타입 세이프 동적 쿼리, S3 Presigned URL 직접 업로드(백엔드 무경유), Apache POI 기반 Excel 대량 등록(행별 성공/실패 피드백), Kafka 비동기 이벤트 처리. 6개 언어(한/영/일/베트남/우즈벡/몽골) i18n을 Cookie 기반 로케일로 지원.</p>
			<ul class="actions" style="text-align: center;">
				<li><a href="all_posts.html#멀티테넌트--확장성" class="button">자세히 보기</a></li>
			</ul>
		</div>
		<br>
		<h4>Tech Stack</h4>
		<ul>
			<li><b>Backend:</b> Spring Boot 3.3.0, Java 21, Gradle (멀티모듈)</li>
			<li><b>Database:</b> PostgreSQL, Spring Data JPA, QueryDSL 5.0, Hibernate</li>
			<li><b>Cache & Session:</b> Redis (암호화 키 TTL, 캐시)</li>
			<li><b>Security:</b> Spring Security, HttpSession, RSA+AES 하이브리드 암호화</li>
			<li><b>Infra:</b> AWS S3 (Presigned URL), Kafka (비동기 메시징)</li>
			<li><b>Frontend:</b> Thymeleaf, Alpine.js, KendoUI Grid</li>
			<li><b>API:</b> Springdoc OpenAPI 3.0, OpenAPI Generator (JS 클라이언트 자동 생성)</li>
		</ul>

		<h4>개발기간</h4>
		<p>2025년 11월 ~ 2026년 3월</p>
	</div>
 </section>
</div>