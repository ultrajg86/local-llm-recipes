#!/usr/bin/env bash
set -euo pipefail

echo "=== llama.cpp + Claude Code 설치 ==="

# llama.cpp
if ! command -v llama-server &>/dev/null; then
  echo "llama.cpp 설치 중..."
  brew install llama.cpp
  echo "✓ llama.cpp 설치 완료"
else
  echo "✓ llama.cpp 이미 설치됨"
fi

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Python 가상환경 + LiteLLM
if [ ! -d "${SCRIPT_DIR}/venv" ]; then
  python3 -m venv "${SCRIPT_DIR}/venv"
  echo "✓ Python 가상환경 생성"
fi
source "${SCRIPT_DIR}/venv/bin/activate"

pip install "litellm[proxy]" --quiet
echo "✓ LiteLLM 설치 완료"

# Claude Code
if ! command -v claude &>/dev/null; then
  npm install -g @anthropic-ai/claude-code
  echo "✓ Claude Code 설치 완료"
else
  echo "✓ Claude Code 이미 설치됨"
fi

echo ""
echo "⚠️  GGUF 모델 파일을 별도로 다운로드해야 합니다:"
echo "   pip install huggingface_hub"
echo "   huggingface-cli download Qwen/Qwen2.5-Coder-7B-Instruct-GGUF \\"
echo "     qwen2.5-coder-7b-instruct-q4_k_m.gguf --local-dir ~/models"
echo "   다운로드 후 .env 의 MODEL_PATH 를 확인하세요."
echo ""
echo "설치 완료! 다음 단계:"
echo "  1. .env 에서 MODEL_PATH 설정"
echo "  2. ./start_server.sh  (터미널 1)"
echo "  3. ./start_agent.sh   (터미널 2)"
