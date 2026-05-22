# local-llm-recipes

로컬에서 LLM을 실행하고 다양한 AI 에이전트와 연결하는 **레시피 모음**입니다.
macOS (Apple Silicon) 기준으로 작성되었습니다.

## 레시피 목록

| 레시피 | 러너 | 에이전트 | 난이도 | 추천 대상 |
|--------|------|----------|--------|-----------|
| [ollama-claude-code](recipes/ollama-claude-code/) | Ollama | Claude Code | ★★☆ | 입문 추천 |
| [ollama-aider](recipes/ollama-aider/) | Ollama | Aider | ★☆☆ | 터미널 코딩 |
| [ollama-continue](recipes/ollama-continue/) | Ollama | Continue.dev | ★☆☆ | VS Code 통합 |
| [ollama-direct](recipes/ollama-direct/) | Ollama | curl / Python | ★☆☆ | API 레퍼런스 |
| [vllm-claude-code](recipes/vllm-claude-code/) | vLLM | Claude Code | ★★☆ | OpenAI 호환 서버 |
| [llamacpp-claude-code](recipes/llamacpp-claude-code/) | llama.cpp | Claude Code | ★★★ | Apple Silicon 최고 성능 |
| [lmstudio-claude-code](recipes/lmstudio-claude-code/) | LM Studio | Claude Code | ★★☆ | GUI 선호 |
| [lmstudio-aider](recipes/lmstudio-aider/) | LM Studio | Aider | ★☆☆ | GUI + 코딩 에이전트 |

## 러너 비교

| 러너 | macOS 지원 | GPU 가속 | 설치 | 특징 |
|------|-----------|---------|------|------|
| **Ollama** | ✅ 최적화 | Metal | `brew install ollama` | 가장 간편, 모델 관리 포함 |
| **vLLM** | ⚠️ CPU 전용 | ❌ | pip | OpenAI 호환, Anthropic API 지원 |
| **llama.cpp** | ✅ 최적화 | Metal | `brew install llama.cpp` | 최경량, GGUF 포맷 |
| **LM Studio** | ✅ 최적화 | Metal | GUI 앱 | 수동 조작 필요, GUI 제공 |

## 에이전트 비교

| 에이전트 | 실행 방식 | Tool Calling | 특징 |
|----------|-----------|--------------|------|
| **Claude Code** | 터미널 | ✅ 필수 | 최강 코딩 에이전트 |
| **Aider** | 터미널 | 선택 | git 통합, 경량 |
| **Continue.dev** | VS Code 확장 | 선택 | 편집기 통합 |
| **curl / Python** | 스크립트 | ❌ | 자유로운 커스텀 |

> **Claude Code + Ollama / llama.cpp** 조합은 [LiteLLM](https://github.com/BerriAI/litellm) 프록시를 통해 Anthropic API 형식으로 변환합니다.

## 공통 추천 모델

→ [shared/models.md](shared/models.md)

## 레시피 구조 (공통)

각 레시피 폴더는 동일한 구조를 따릅니다:

```
recipes/<name>/
├── .env              # 모델 및 포트 설정
├── setup.sh          # 최초 1회 설치
├── start_server.sh   # LLM 서버 시작
├── start_agent.sh    # 에이전트 시작
└── README.md         # 해당 레시피 전용 가이드
```

```bash
# 공통 실행 흐름
cd recipes/<name>
./setup.sh            # 최초 1회
./start_server.sh     # 터미널 1
./start_agent.sh      # 터미널 2
```

## 구조

```
vllm/
├── .env              # 모델 및 설정값
├── setup.sh          # 최초 1회 설치 스크립트
├── start_server.sh   # vLLM 서버 시작
├── start_claude.sh   # Claude Code 시작 (서버 연결)
└── README.md
```

## 사전 요구사항

| 항목 | 최소 버전 | 설치 방법 |
|------|-----------|-----------|
| Python | 3.9 이상 | `brew install python3` |
| Node.js | 18 이상 | `brew install node` |
| 디스크 | 20GB 이상 | 모델 다운로드 공간 |
| RAM | 16GB 이상 | 7B 모델 기준 |

> **Apple Silicon (M1/M2/M3)**: CPU 모드로 동작합니다. `.env`에서 `CPU_ONLY=true` 설정을 권장합니다.

---

## 1단계: 설치 (최초 1회)

```bash
cd vllm
chmod +x setup.sh start_server.sh start_claude.sh
./setup.sh
```

설치 스크립트가 자동으로 수행하는 작업:
- Python 가상환경 생성 (`venv/`)
- vLLM 설치
- Claude Code 설치 (`npm install -g @anthropic-ai/claude-code`)
- `~/.claude/settings.json` 설정 파일 생성

---

## 2단계: 모델 설정

`.env` 파일에서 사용할 모델을 선택합니다:

```bash
# .env 파일 편집
MODEL_ID="Qwen/Qwen2.5-7B-Instruct"   # HuggingFace 모델 ID
MODEL_NAME="my-model"                   # 서버에서 사용할 별칭 (슬래시 없어야 함)
```

### 추천 모델 (tool calling 지원)

| 모델 | 크기 | Tool Parser | 특징 |
|------|------|-------------|------|
| `Qwen/Qwen2.5-7B-Instruct` | ~15GB | `hermes` | 균형 좋음, 기본 추천 |
| `Qwen/Qwen2.5-3B-Instruct` | ~6GB | `hermes` | 빠름, 저사양용 |
| `meta-llama/Llama-3.1-8B-Instruct` | ~16GB | `llama3_json` | Meta 공식 |
| `microsoft/Phi-3.5-mini-instruct` | ~8GB | `hermes` | 경량, 성능 우수 |

### Apple Silicon 설정

```bash
# .env 파일에서 CPU 모드 활성화
CPU_ONLY="true"
MAX_MODEL_LEN=4096   # 메모리 절약
```

---

## 3단계: 서버 시작

**터미널 1** — vLLM 서버 실행:
```bash
./start_server.sh
```

첫 실행 시 모델을 HuggingFace에서 다운로드합니다 (수 GB, 시간 소요).

서버 시작 확인:
```
INFO:     Started server process
INFO:     Uvicorn running on http://0.0.0.0:8000
```

---

## 4단계: Claude Code 실행

**터미널 2** — Claude Code 실행:
```bash
./start_claude.sh
```

또는 작업 디렉토리를 지정하여 실행:
```bash
./start_claude.sh --cd /path/to/your/project
```

---

## 수동 실행 방법

환경변수를 직접 설정하여 실행:

```bash
ANTHROPIC_BASE_URL=http://localhost:8000 \
ANTHROPIC_API_KEY=dummy \
ANTHROPIC_AUTH_TOKEN=dummy \
ANTHROPIC_DEFAULT_OPUS_MODEL=my-model \
ANTHROPIC_DEFAULT_SONNET_MODEL=my-model \
ANTHROPIC_DEFAULT_HAIKU_MODEL=my-model \
claude
```

---

## 문제 해결

### 서버 연결 실패
```
[ERROR] vLLM 서버에 연결할 수 없습니다
```
→ `start_server.sh` 가 실행 중인지 확인하세요.

### 메모리 부족 오류
```
OutOfMemoryError
```
→ `.env`에서 작은 모델을 선택하거나 `MAX_MODEL_LEN`을 줄이세요.

### Tool calling 오작동
→ `.env`에서 `TOOL_CALL_PARSER`를 모델에 맞게 변경하세요.
- Qwen 계열: `hermes`
- Llama 3 계열: `llama3_json`
- Mistral 계열: `mistral`

### Apple Silicon에서 실행 오류
→ `.env`에서 `CPU_ONLY=true`로 설정 후 재시작하세요.

### 모델명 오류 (슬래시 포함)
```
Model not found
```
→ `MODEL_NAME`에는 슬래시(`/`)를 사용할 수 없습니다. `my-model`처럼 별칭을 사용하세요.

---

## 참고 링크

- [vLLM 공식 문서](https://docs.vllm.ai/en/latest/serving/integrations/claude_code/)
- [Claude Code 설치 가이드](https://docs.anthropic.com/en/docs/claude-code/getting-started)
- [vLLM Tool Calling 문서](https://docs.vllm.ai/en/latest/features/tool_calling/)
