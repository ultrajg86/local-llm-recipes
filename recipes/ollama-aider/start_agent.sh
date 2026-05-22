#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${SCRIPT_DIR}/.env"
source "${SCRIPT_DIR}/venv/bin/activate"

# 서버 헬스체크
if ! curl -sf "http://localhost:${OLLAMA_PORT}/api/tags" > /dev/null 2>&1; then
  echo "[ERROR] Ollama 서버에 연결할 수 없습니다. (포트: ${OLLAMA_PORT})"
  echo "→ ./start_server.sh 를 먼저 실행하세요."
  exit 1
fi

echo "=== Aider 시작 ==="
echo "모델: ollama/${OLLAMA_MODEL}"
echo "서버: ${OLLAMA_BASE_URL}"
echo ""

aider \
  --model "ollama/${OLLAMA_MODEL}" \
  --openai-api-base "${OLLAMA_BASE_URL}/v1" \
  --openai-api-key "ollama" \
  "$@"
