#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${SCRIPT_DIR}/.env"

# Ollama 서버 시작
if ! pgrep -x "ollama" > /dev/null 2>&1; then
  echo "Ollama 서버 시작 중..."
  ollama serve &
  sleep 3
else
  echo "✓ Ollama 이미 실행 중"
fi

# 모델 확인 및 다운로드
echo "모델 확인: ${OLLAMA_MODEL}"
ollama pull "${OLLAMA_MODEL}"

echo ""
echo "✓ Ollama 서버 실행 중 (포트: ${OLLAMA_PORT})"
echo ""
echo "직접 호출 예시:"
echo "  bash examples/chat.sh '안녕하세요'"
echo "  python3 examples/chat.py '안녕하세요'"
echo "  bash examples/stream.sh '파이썬으로 피보나치를 작성해줘'"

wait
