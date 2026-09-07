---
layout: page
title: Project
description: 수행했던 프로젝트
image: assets/images/pic11.jpg
nav-menu: true
weight: 2
---

<!-- Style-->
<style>
	div {
		display: flow-root;
	}
</style>

<!-- Main -->
<div id="main" class="alt">

	<!-- One -->
	<section id="one">
		<div class="inner">
			<header class="major">
				<h1>Project</h1>
			</header>
			<div>
				<h2>한국어능력시험 학습 플랫폼 masterTOPIK 관리자페이지 풀스택 개발</h2>
			</div>
			<div>
				<h4>직접 개발한 하네스(cc-baseline)를 이용해 개발·납품한 첫 프로젝트</h4>
				<span class="image left"><img src="{% link assets/images/mastertopik.png %}" alt="" /></span>
				<ul style="overflow: hidden;">
					<li>Classic ASP 약 1,000개 파일 규모의 레거시 관리자 시스템을 Java(Spring Boot)로 전환하는 프로젝트에서 기능 정합(parity) 검증·QA·결함 수정 및 신규 화면 개발 담당</li>
					<li>Claude Code 기반 멀티에이전트 파이프라인(퍼블리싱 → 코드리뷰 + 보안감사 → E2E 테스트)과 커스텀 스킬을 직접 설계·운영하여 페이지 단위 개발–QA 사이클 자동화</li>
					<li>관리자 메뉴 47개 전수 QA 및 UI 디자인 베이스라인(시각 정합 기준) 수립, Playwright 기반 E2E 라이브 검증 체계 구축</li>
					<li>권한·IP 접근통제 구현, 개인정보 파기 관리, 결제·정산·환불·회원지표 등 핵심 화면 QA 및 다수 버그의 근본 원인 해결</li>
					<li>보안 망분리(VDI) 환경 제약 하에서 텍스트 패치 기반 코드 반영 워크플로 수립, 개발환경·전달자료에 맞춘 커스텀 스킬 다수 제작으로 업무 플로우 단순화</li>
					<li>Java 8, Spring Boot 2, MSSQL, JPA/QueryDSL, Mustache, Spring Security, OpenAPI Generator, Playwright, Claude Code (MCP · Skills), GitLab, Docker</li>
				</ul>
			</div>
			<hr>
			<div>
				<h2>AI 코딩 에이전트 하네스 설계 및 개발 (cc-baseline)</h2>
			</div>
			<div>
				<h4>개발환경 표준화를 위한 Claude Code 하네스 번들 인스톨러</h4>
				<p>
					<span class="image left"><img src="{% link assets/images/cc_baseline.png %}" alt="" /></span>
					<span>
						<li>행동규칙·에이전트·스킬·훅을 단일 npx 명령으로 설치하는 Claude Code 하네스 번들 인스톨러 (JS ~2,700줄, 템플릿 33개 파일)</li>
						<li>5개 에이전트 파이프라인(design-director → publisher → security-auditor + code-reviewer → e2e-tester) 설계 및 게이트별 책임 경계·중복제거 매트릭스 정의</li>
						<li>기존 ~/.claude 설정을 덮어쓰지 않는 마커블록 병합 및 훅 ID 중복제거 전략, --dry-run / --doctor / --uninstall 지원</li>
						<li>Node.js 18+ 기반, 외부 의존성 없이 내장 모듈만으로 구현 (설치 전 타임스탬프 백업 자동 생성)</li>
					</span>
				</p>
				<ul class="actions" style="text-align: center; clear: both;">
					<li><a href="engineering.html#cc-baseline" class="button">기술 포트폴리오 보러 가기</a></li>
				</ul>
			</div>
			<hr>
			<div>                                                                         
				<h2>AI 유튜브 썸네일 생성 SaaS 풀스택 개발 (그림방)</h2>                  
			</div>                                                                        
			<div>                                                                         
				<h4>바이브 코딩(Prompt Engineering) 이용한 사이드 프로젝트</h4>             
				<p>                                                                       
					<span class="image left"><img src="{% link assets/images/grimbang.png%}" alt="" /></span>                                                          
					<span>
						<li>한 문장 프롬프트로 유튜브 썸네일 생성 + 텍스트 지시 기반 정밀 편집 SaaS (API 6개, 코드 ~6,400줄)</li>                                       
						<li>Gemini 3.1 Flash 2K 생성 → Kontext Pro + Recraft Crisp 업스케일 2단계 편집 파이프라인 설계 (Fallback·자동 롤백 포함)</li>            
						<li>Supabase RPC 원자적 크레딧 차감, Google OAuth 인증, 한글→영어 자동 번역 파이프라인, 다국어(i18n) 지원</li>                                  
						<li>Next.js 16, React 19, Tailwind CSS v4, TypeScript 5, Supabase (Auth/DB/Storage), Gemini API, fal.ai API, Vercel</li>                       
					</span>                                                 
				</p>
				<ul class="actions" style="text-align: center;">
					<li><a href="engineering.html#grimbang" class="button">기술 포트폴리오 보러 가기</a></li>
				</ul>
			</div>
			<hr>             
			<div>
				<h2>글로벌 교육 플랫폼 Admin 시스템 설계 및 풀스택 개발</h2>
			</div>
			<div>
				<h4>바이브 코딩(Harness Engineering) 이용한 1인 집중개발</h4>
				<p>
					<span class="image left"><img src="{% link assets/images/allvia_admin.png %}" alt="" /></span>
					<span>
						<li>교육기관·강사·학생·권한·게시판·서비스문의 등 대부분의 메뉴 설계 및 구현 (REST API 116개, 코드 ~12,800줄)</li>
						<li>RSA+AES256 하이브리드 요청/응답 암호화, 로그인 보안(계정잠금/2FA) 등 보안 아키텍처 설계·구현</li>
						<li>6개 언어 다국어(i18n) 지원, 메뉴/버튼 접근제어 및 3depth 구조, OpenAPI Generator 클라이언트 자동 동기화 체계 구축</li>
						<li>Java 21, Spring Boot 3.3, JPA/QueryDSL, PostgreSQL, Thymeleaf, Alpine.js, KendoUI, Web Crypto API</li>
					</span>
				</p>
				<ul class="actions" style="text-align: center; clear: both;">
					<li><a href="engineering.html#allviA-admin" class="button">기술 포트폴리오 보러 가기</a></li>
				</ul>
			</div>
			<hr>
            <div>
                <h2>Enterprise 솔루션 통합 관리 및 레거시 현대화 (ERP/MES/B2B솔루션)</h2>
            </div>
			<div>
				<h4>ERP / MES / B2B솔루션 통합 유지보수 및 기능개발</h4>
				<p>
					<span class="image left"><img src="{% link assets/images/tcps_mes.png %}" alt="" /></span>
					<span>
						<li>수주·회계·인사 관리 ERP, 실시간 공정관리 MES, B2B 상업/디지털인쇄 솔루션의 유지보수 및 기능개발 담당</li>
						<li>복잡한 엔터프라이즈 도메인 로직의 분석·설계·구현 경험</li>
						<li>PHP 5, CodeIgniter 3, MySQL, AWS (EC2/RDS), JavaScript</li>
					</span>
				</p>
			</div>
		</div>
	</section>
</div>