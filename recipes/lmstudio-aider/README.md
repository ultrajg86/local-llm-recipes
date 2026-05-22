# LM Studio + Aider

LM Studio의 내장 OpenAI 호환 서버에 Aider를 직접 연결하는 레시피입니다.
LM Studio가 OpenAI 호환 API를 제공하므로 **별도 프록시가 필요 없습니다**.

> **⚠️ 주의**: LM Studio 서버는 앱에서 수동으로 시작해야 합니다.

## 구조

```
LM Studio 앱 (포트 1234, 수동 시작) → Aider (직접 연결)
```

## 사전 요구사항

| 항목 | 설치 |
|------|------|
| LM Studio | [lmstudio.ai](https://lmstudio.ai/) |
| Python 3.9+ | `brew install python3` |
| git | `brew install git` |

## LM Studio 설정 (최초 1회)

1. LM Studio 앱 실행
2. 모델 검색 및 다운로드
3. 좌측 메뉴 → **Local Server** (↔ 아이콘)
4. 모델 선택 → **Start Server** 클릭
5. 로드된 모델명을 `.env`의 `MODEL_NAME`에 입력

## 실행 방법

```bash
# 1. 설치 (최초 1회)
./setup.sh

# 2. LM Studio에서 모델 로드 및 서버 시작 (수동)

# 3. .env 에서 MODEL_NAME 업데이트

# 4. 서버 연결 확인 (선택)
./start_server.sh

# 5. Aider 실행
./start_agent.sh

# 특정 파일과 함께 시작
./start_agent.sh main.py utils.py
```

## .env 설정

```bash
LMSTUDIO_PORT=1234                        # LM Studio 기본 포트
MODEL_NAME="qwen2.5-coder-7b-instruct"   # LM Studio에서 로드한 모델명
```

## 문제 해결

**Aider 연결 실패**
→ LM Studio에서 Local Server가 실행 중인지 확인.

**모델을 찾을 수 없음**
→ `MODEL_NAME`이 LM Studio에 실제 로드된 모델명과 일치하는지 확인.
   LM Studio → Local Server → 상단 모델명 참고.

**응답이 이상함 / Tool calling 오작동**
→ LM Studio에서 tool calling을 잘 지원하는 모델(Qwen2.5-Coder, Llama3.1)을 사용하세요.

## 참고

- [LM Studio 공식 사이트](https://lmstudio.ai)
- [Aider 공식 문서](https://aider.chat)
- [Aider OpenAI 호환 API 연결](https://aider.chat/docs/llms/openai-compat.html)
