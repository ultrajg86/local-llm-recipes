# LM Studio + Claude Code

LM Studio의 내장 서버를 사용하고 LiteLLM 프록시를 통해 Claude Code와 연결하는 레시피입니다.
LM Studio는 GUI로 모델을 관리하므로 **CLI에 익숙하지 않은 분께 추천**합니다.

> **⚠️ 주의**: LM Studio 서버는 앱에서 수동으로 시작해야 합니다. 스크립트로 자동화가 불가능합니다.

## 구조

```
LM Studio 앱 (포트 1234, 수동 시작) → LiteLLM 프록시 (포트 4000) → Claude Code
```

## 사전 요구사항

| 항목 | 설치 |
|------|------|
| LM Studio | [lmstudio.ai](https://lmstudio.ai/) |
| Node.js 18+ | `brew install node` |
| Python 3.9+ | `brew install python3` |

## LM Studio 설정 (최초 1회)

1. LM Studio 앱 실행
2. 상단 검색창에서 모델 검색 및 다운로드 (예: `Qwen2.5-Coder-7B-Instruct`)
3. 좌측 메뉴 → **Local Server** (↔ 아이콘)
4. 다운로드한 모델 선택 → **Start Server** 클릭
5. 서버 주소 확인: `http://localhost:1234`
6. 모델명 확인 → `.env`의 `MODEL_NAME`에 입력

## 실행 방법

```bash
# 1. 설치 (최초 1회)
./setup.sh

# 2. LM Studio에서 모델 로드 및 서버 시작 (수동)

# 3. .env 에서 MODEL_NAME 업데이트

# 4. LiteLLM 프록시 시작 (터미널 1)
./start_server.sh

# 5. Claude Code 실행 (터미널 2)
./start_agent.sh
```

## .env 설정

```bash
LMSTUDIO_PORT=1234                        # LM Studio 기본 포트
MODEL_NAME="qwen2.5-coder-7b-instruct"   # LM Studio에서 로드한 모델명
LITELLM_PORT=4000                          # LiteLLM 프록시 포트
PROXY_MODEL_NAME="my-model"               # Claude Code에서 사용할 별칭
```

## MODEL_NAME 확인 방법

LM Studio → Local Server → 상단에 현재 로드된 모델명이 표시됩니다.
해당 값을 `.env`의 `MODEL_NAME`에 입력하세요.

## 문제 해결

**LM Studio 서버 연결 실패**
→ LM Studio 앱에서 Local Server 탭을 열고 "Start Server"를 클릭했는지 확인.

**모델을 찾을 수 없음**
→ `MODEL_NAME`이 LM Studio에서 실제로 로드된 모델명과 일치하는지 확인.

**LiteLLM 프록시 오류**
→ LM Studio 서버가 실행 중인 상태에서 `start_server.sh`를 실행하세요.

## 참고

- [LM Studio 공식 사이트](https://lmstudio.ai)
- [LiteLLM 문서](https://docs.litellm.ai)
