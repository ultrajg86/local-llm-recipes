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
echo "  터미널 2에서 ./start_agent.sh 를 실행하세요."

# 서버를 포그라운드로 유지
wait
