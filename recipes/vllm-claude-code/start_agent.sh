#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${SCRIPT_DIR}/.env"

# 서버 헬스체크
if ! curl -sf "http://localhost:${PORT}/health" > /dev/null 2>&1; then
  echo "[ERROR] vLLM 서버에 연결할 수 없습니다. (포트: ${PORT})"
  echo "→ ./start_server.sh 를 먼저 실행하세요."
  exit 1
fi

echo "=== Claude Code 시작 ==="
echo "서버: http://localhost:${PORT}"
echo ""

ANTHROPIC_BASE_URL="http://localhost:${PORT}" \
ANTHROPIC_API_KEY="dummy" \
ANTHROPIC_AUTH_TOKEN="dummy" \
ANTHROPIC_DEFAULT_OPUS_MODEL="${MODEL_NAME}" \
ANTHROPIC_DEFAULT_SONNET_MODEL="${MODEL_NAME}" \
ANTHROPIC_DEFAULT_HAIKU_MODEL="${MODEL_NAME}" \
claude "$@"
