---
title: Grimbang (그림방)
layout: post
---

한 문장 프롬프트로 유튜브 썸네일 생성 + 텍스트 지시 기반 정밀 편집 SaaS의 핵심 기술 설계를 정리한 문서입니다.

---

### AI 파이프라인 설계

#### 핵심 성과
- ___5개 AI 모델 비교 분석 후 최적 모델 선정 → 품질·비용·기능 트레이드오프 해결___
- ___Kontext Max → Pro + Recraft Crisp 전환으로 API 호출당 45% 비용 절감 ($0.08 → $0.044)___
- ___듀얼 파이프라인(생성 + 정밀 편집) 설계로 단일 서비스에서 두 가지 워크플로우 지원___

#### 아키텍처

```
[생성 모드]
  사용자 프롬프트 + 참조 이미지(최대 10장)
    → Gemini 3.1 Flash (2K 네이티브 해상도)
    → 2회 실패 시 → Gemini 2.5 Flash (1K) 자동 Fallback
    → Supabase Storage 저장

[정밀 편집 모드]
  사용자 프롬프트 + 원본 이미지
    → 한글 감지 시 → Gemini 2.5 Flash 번역
    → FLUX Kontext Pro (텍스트 지시 기반 편집)
    → Recraft Crisp Upscale (2K 업스케일)
    → Sharp (원본 치수 복원, aspect ratio drift 방지)
    → Supabase Storage 저장
```

#### 모델 선정 근거

| 모델 | 비용/회 | 해상도 | 이미지 입력 | 선정 결과 |
|------|---------|--------|-------------|-----------|
| Gemini 3.1 Flash | $0.101 | 2K | 최대 10장 | **채택** — Elo #2, 생성+수정 통합 |
| Gemini 2.5 Flash | $0.039 | 1K | 지원 | Fallback용 |
| Imagen 4 Fast | $0.02 | - | 미지원 | 구도 제어 불가, 배제 |
| Imagen 4 Standard | $0.04 | - | 미지원 | 이미지 입력 불가, 배제 |

비용이 5배 높지만 2K 네이티브 해상도, 멀티모달 입력, ~90% 텍스트 렌더링 정확도, 생성과 수정을 하나의 모델로 처리하는 아키텍처 단순화 이점으로 Gemini 3.1 Flash를 채택.

#### 업스케일러 선정 근거

| 모델 | 비용/회 | 선정 결과 |
|------|---------|-----------|
| Recraft Crisp | $0.004 | **채택** — 텍스트 보존 테스트 1위, 최저가 |
| Topaz | $0.08 | 고품질이나 Kontext Max와 동일 비용, 배제 |
| Crystal | $0.016/MP | 텍스트 보존 미검증, 배제 |

Kontext Max($0.08)와 Pro($0.04)의 네이티브 출력 해상도가 동일(~1MP)함을 발견하여, Pro + Recraft Crisp($0.044)로 전환. 동일 품질에서 45% 비용 절감 달성.

#### 장애 대응 설계

파이프라인이 다단계(크레딧 차감 → 번역 → 편집 → 업스케일 → 저장)이므로, 각 단계별 실패 시나리오를 고려한 설계:

```
[크레딧 차감]
  → PostgreSQL 단일 UPDATE문 (UPDATE ... SET credits = credits - 1 WHERE credits > 0)
  → 잔액 확인과 차감을 한 문장으로 처리 → 동시 요청 시 행 잠금으로 이중 차감 방지

[파이프라인 실패 시]
  → 생성/편집 실패 → increment_credits()로 즉시 롤백
  → Storage 업로드 실패 → 크레딧 롤백
  → Gemini 3.1 Flash 실패 → Gemini 2.5 Flash 자동 Fallback
```

- **독립 크레딧 체계**: Generate Credits와 Precision Credits를 분리 운영하여 별도 구독 가능

#### 사용 기술
- Google Gemini API, fal.ai API (FLUX Kontext Pro, Recraft Crisp Upscale), Sharp, Supabase (PostgreSQL RPC, RLS), Polar Webhook

---

### 한글 NLP & 프롬프트 엔지니어링

#### 핵심 성과
- ___한국어 사용자가 별도 설정 없이 모국어로 자연스럽게 서비스 이용 가능___
- ___CTR 최적화 이론을 시스템 프롬프트에 압축하여 전문 디자이너 없이도 클릭을 유도하는 썸네일 자동 생성___
- ___참조 이미지 자동 분석으로 시리즈 콘텐츠 스타일 일관성 확보___

#### 한글 자동 번역 파이프라인

```
[사용자 입력]
  → 정규식으로 비라틴 문자 감지
    → 라틴 문자만 → 그대로 Kontext에 전달
    → 한글 포함 → Gemini 2.5 Flash (thinkingBudget: 0)로 번역
      → 번역 성공 → 영어 프롬프트를 Kontext에 전달
      → 번역 실패 → 원문 그대로 전달 (서비스 중단 방지)
```

- FLUX Kontext는 영어만 지원하지만, 사용자는 이를 인지할 필요 없이 한국어로 자연스럽게 입력

#### 시스템 프롬프트 설계

유튜브 썸네일 CTR 최적화 전문 지식을 70줄의 시스템 프롬프트에 압축:

| 영역 | 적용 규칙 |
|------|-----------|
| 구도 | Rule of Thirds, 최대 3개 시각 요소, 168x94px(모바일)에서도 인식 가능한 focal point |
| 색상 심리학 | Yellow+Black(최고 CTR) > Red+White > Blue+Orange 우선순위 |
| 스토리텔링 | 호기심 갭 — 핵심을 부분적으로 숨겨 클릭 유도, 썸네일은 감정, 제목은 맥락 |
| 텍스트 정책 | 기본적으로 이미지 내 텍스트 생성 금지 (hallucination 방지), 명시적 요청 시에만 렌더링 |
| 한국 시장 | 예능(variety show) 스타일 미학, Black Han Sans 타이포그래피 |

#### 참조 이미지 기반 스타일 일관성

- 이전 생성 썸네일을 첨부하면 Gemini 2.5 Flash로 색상, 구도, 조명, 감정 등을 사전 분석
- 분석 결과를 생성 프롬프트에 자동 주입 → 별도 스타일 관리 없이 시리즈 일관성 확보
- 최대 10장, 5MB/장, 30초 타임아웃 (실패해도 생성 진행 — Non-blocking)

#### 사용 기술
- Google Gemini API (3.1 Flash, 2.5 Flash), 프롬프트 엔지니어링, i18n (한/영 다국어 UI)