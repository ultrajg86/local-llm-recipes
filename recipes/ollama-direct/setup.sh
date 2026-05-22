#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${SCRIPT_DIR}/.env"

echo "=== Ollama 설치 ==="

# Ollama
if ! command -v ollama &>/dev/null; then
  brew install ollama
  echo "✓ Ollama 설치 완료"
else
  echo "✓ Ollama 이미 설치됨"
fi

# Python 가상환경 (examples/chat.py용)
if [ ! -d "${SCRIPT_DIR}/venv" ]; then
  python3 -m venv "${SCRIPT_DIR}/venv"
  echo "✓ Python 가상환경 생성"
fi
source "${SCRIPT_DIR}/venv/bin/activate"
pip install openai --quiet
echo "✓ Python 의존성 설치 완료 (openai)"

echo ""
echo "설치 완료! ./start_server.sh 를 실행하세요."
