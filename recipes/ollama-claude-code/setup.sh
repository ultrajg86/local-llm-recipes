#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${SCRIPT_DIR}/.env"

echo "=== Ollama + Claude Code 설치 ==="

# Ollama
if ! command -v ollama &>/dev/null; then
  echo "Ollama 설치 중..."
  brew install ollama
  echo "✓ Ollama 설치 완료"
else
  echo "✓ Ollama 이미 설치됨"
fi

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
echo "설치 완료! 다음 단계:"
echo "  1. ./start_server.sh  (터미널 1)"
echo "  2. ./start_agent.sh   (터미널 2)"
