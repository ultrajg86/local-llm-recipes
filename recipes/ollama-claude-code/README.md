# Ollama + Claude Code

Ollama로 모델을 서빙하고 LiteLLM 프록시를 통해 Claude Code와 연결하는 레시피입니다.
Apple Silicon에서 Metal GPU 가속을 활용하므로 **macOS에서 가장 추천하는 조합**입니다.

## 구조

```
Ollama (포트 11434) → LiteLLM 프록시 (포트 4000) → Claude Code
```

LiteLLM이 Anthropic API 형식 ↔ Ollama OpenAI 호환 API 형식을 변환합니다.

## 사전 요구사항

| 항목 | 설치 |
|------|------|
| Homebrew | [brew.sh](https://brew.sh) |
| Node.js 18+ | `brew install node` |
| Python 3.9+ | `brew install python3` |

## 실행 방법

```bash
# 1. 설치 (최초 1회)
./setup.sh

# 2. 서버 시작 (터미널 1)
#    Ollama + LiteLLM 프록시가 함께 시작됩니다
./start_server.sh

# 3. Claude Code 실행 (터미널 2)
./start_agent.sh

# 특정 디렉토리에서 시작
./start_agent.sh --cd /path/to/project
```

## .env 설정

```bash
OLLAMA_MODEL="qwen2.5-coder:7b"   # ollama pull 로 받은 모델명
OLLAMA_PORT=11434                   # Ollama 기본 포트 (변경 불필요)
LITELLM_PORT=4000                   # LiteLLM 프록시 포트
PROXY_MODEL_NAME="my-model"         # Claude Code에서 사용할 모델 별칭
```

## 추천 모델

| 모델 | RAM | 특징 |
|------|-----|------|
| `qwen2.5-coder:7b` | 8GB+ | 코딩 특화, 기본 추천 |
| `qwen2.5-coder:3b` | 4GB+ | 저사양용 |
| `llama3.1:8b` | 8GB+ | 범용, 다국어 우수 |

## 문제 해결

**LiteLLM 프록시 연결 실패**
→ `./start_server.sh` 실행 후 `LiteLLM proxy running on port 4000` 메시지 확인.

**Ollama 모델 없음**
→ `ollama pull qwen2.5-coder:7b` 로 모델을 먼저 다운로드하세요.

**Claude Code tool calling 오작동**
→ tool calling을 잘 지원하는 모델(qwen2.5-coder, llama3.1)로 변경하세요.

## 참고

- [Ollama 공식 사이트](https://ollama.com)
- [LiteLLM 문서](https://docs.litellm.ai)
- [Claude Code 설치 가이드](https://docs.anthropic.com/en/docs/claude-code/getting-started)
