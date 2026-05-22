#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${SCRIPT_DIR}/.env"

echo "=== Ollama + Aider 설치 ==="

# Ollama
if ! command -v ollama &>/dev/null; then
  brew install ollama
  echo "✓ Ollama 설치 완료"
else
  echo "✓ Ollama 이미 설치됨"
fi

# Python 가상환경 + Aider
if [ ! -d "${SCRIPT_DIR}/venv" ]; then
  python3 -m venv "${SCRIPT_DIR}/venv"
  echo "✓ Python 가상환경 생성"
fi
source "${SCRIPT_DIR}/venv/bin/activate"

pip install aider-chat --quiet
echo "✓ Aider 설치 완료"

echo ""
echo "설치 완료! 다음 단계:"
echo "  1. ./start_server.sh  (터미널 1)"
echo "  2. ./start_agent.sh   (터미널 2)"
