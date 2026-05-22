# llama.cpp + Claude Code

llama.cpp 서버로 모델을 서빙하고 LiteLLM 프록시를 통해 Claude Code와 연결하는 레시피입니다.
Apple Silicon의 **Metal GPU를 최대한 활용**하므로 macOS에서 가장 높은 추론 성능을 냅니다.

## 구조

```
llama-server (포트 8080) → LiteLLM 프록시 (포트 4000) → Claude Code
```

## 사전 요구사항

| 항목 | 설치 |
|------|------|
| Homebrew | [brew.sh](https://brew.sh) |
| Node.js 18+ | `brew install node` |
| Python 3.9+ | `brew install python3` |
| GGUF 모델 파일 | 아래 참고 |

## 모델 다운로드

```bash
pip install huggingface_hub

# Qwen2.5-Coder-7B (Q4_K_M 양자화, 약 4.7GB)
huggingface-cli download Qwen/Qwen2.5-Coder-7B-Instruct-GGUF \
  qwen2.5-coder-7b-instruct-q4_k_m.gguf \
  --local-dir ~/models
```

다운로드 후 `.env`의 `MODEL_PATH`를 확인하세요.

## 실행 방법

```bash
# 1. 설치 (최초 1회)
./setup.sh

# 2. .env에서 MODEL_PATH 설정

# 3. 서버 시작 (터미널 1)
#    llama-server + LiteLLM 프록시가 함께 시작됩니다
./start_server.sh

# 4. Claude Code 실행 (터미널 2)
./start_agent.sh
```

## .env 설정

```bash
MODEL_PATH="${HOME}/models/qwen2.5-coder-7b-instruct-q4_k_m.gguf"
LLAMA_PORT=8080
CONTEXT_SIZE=4096
GPU_LAYERS=-1        # -1: 전체 Metal GPU / 0: CPU 전용
LITELLM_PORT=4000
PROXY_MODEL_NAME="my-model"
```

## GPU_LAYERS 설정 가이드

| 설정 | 동작 | 권장 상황 |
|------|------|---------|
| `-1` | 전체 레이어 Metal GPU | RAM 16GB+ |
| `0` | CPU 전용 | RAM 8GB 이하 |
| `20` | 일부만 GPU | RAM 부족 시 조정 |

## 문제 해결

**모델 파일을 찾을 수 없음**
→ `.env`의 `MODEL_PATH`가 정확한 절대경로인지 확인하세요.

**메모리 부족**
→ `GPU_LAYERS=0`(CPU 모드) 또는 더 작은 양자화(`Q2_K`) 모델 사용.

**LiteLLM 프록시 연결 실패**
→ `start_server.sh` 로그에서 `LiteLLM proxy running on port 4000` 확인.

## 참고

- [llama.cpp GitHub](https://github.com/ggerganov/llama.cpp)
- [GGUF 모델 목록 (HuggingFace)](https://huggingface.co/models?library=gguf)
- [LiteLLM 문서](https://docs.litellm.ai)
