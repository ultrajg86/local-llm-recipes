# vLLM + Claude Code

vLLM 서버를 로컬에서 실행하고 Claude Code를 연결하는 레시피입니다.
vLLM은 Anthropic 호환 API(`/v1/messages`)를 네이티브로 지원하므로 별도 프록시가 필요 없습니다.

> **Apple Silicon**: vLLM은 CPU 모드로 동작합니다. Ollama/llama.cpp보다 느릴 수 있습니다.
> 성능이 중요하다면 [ollama-claude-code](../ollama-claude-code/) 또는 [llamacpp-claude-code](../llamacpp-claude-code/)를 추천합니다.

## 사전 요구사항

| 항목 | 최소 버전 | 설치 |
|------|-----------|------|
| Python | 3.9+ | `brew install python3` |
| Node.js | 18+ | `brew install node` |
| 디스크 | 20GB+ | 모델 다운로드 공간 |
| RAM | 16GB+ | 7B 모델 기준 |

## 실행 방법

```bash
# 1. 설치 (최초 1회)
./setup.sh

# 2. 모델 설정 (.env 편집)
#    MODEL_ID: HuggingFace 모델 ID
#    MODEL_NAME: 서버 별칭 (슬래시 불가)

# 3. 서버 시작 (터미널 1)
./start_server.sh

# 4. Claude Code 실행 (터미널 2)
./start_agent.sh

# 특정 디렉토리에서 시작
./start_agent.sh --cd /path/to/project
```

## .env 설정

```bash
MODEL_ID="Qwen/Qwen2.5-Coder-7B-Instruct"  # HuggingFace 모델 ID
MODEL_NAME="my-model"                         # 별칭 (슬래시 불가)
PORT=8000
TOOL_CALL_PARSER="hermes"                     # Qwen: hermes / Llama3: llama3_json
CPU_ONLY="true"                               # Apple Silicon: true 권장
MAX_MODEL_LEN=4096
```

## 추천 모델

| 모델 | Tool Parser | 특징 |
|------|-------------|------|
| `Qwen/Qwen2.5-Coder-7B-Instruct` | `hermes` | 코딩 특화, 기본 추천 |
| `Qwen/Qwen2.5-7B-Instruct` | `hermes` | 범용 |
| `meta-llama/Llama-3.1-8B-Instruct` | `llama3_json` | Meta 공식 |

## 문제 해결

**서버 연결 실패**
→ `./start_server.sh` 가 실행 중인지 확인. 로그에 `Uvicorn running on http://0.0.0.0:8000` 확인.

**OutOfMemoryError**
→ `.env`에서 더 작은 모델 선택 또는 `MAX_MODEL_LEN` 값을 줄이세요.

**Tool calling 오작동**
→ `.env`의 `TOOL_CALL_PARSER`를 모델에 맞게 변경하세요.

**모델명 오류 (슬래시 포함)**
→ `MODEL_NAME`에는 슬래시(`/`) 사용 불가. `my-model`처럼 별칭을 사용하세요.

## 참고

- [vLLM Claude Code 공식 문서](https://docs.vllm.ai/en/latest/serving/integrations/claude_code/)
- [vLLM Tool Calling 문서](https://docs.vllm.ai/en/latest/features/tool_calling/)
