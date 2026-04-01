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