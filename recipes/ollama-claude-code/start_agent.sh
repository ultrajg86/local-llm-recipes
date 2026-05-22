#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${SCRIPT_DIR}/.env"

# 프록시 헬스체크
if ! curl -sf "http://localhost:${LITELLM_PORT}/health" > /dev/null 2>&1; then
  echo "[ERROR] LiteLLM 프록시에 연결할 수 없습니다. (포트: ${LITELLM_PORT})"
  echo "→ ./start_server.sh 를 먼저 실행하세요."
  exit 1
fi

echo "=== Claude Code 시작 ==="
echo "프록시: http://localhost:${LITELLM_PORT}"
echo ""

ANTHROPIC_BASE_URL="http://localhost:${LITELLM_PORT}" \
ANTHROPIC_API_KEY="dummy" \
ANTHROPIC_AUTH_TOKEN="dummy" \
ANTHROPIC_DEFAULT_OPUS_MODEL="${PROXY_MODEL_NAME}" \
ANTHROPIC_DEFAULT_SONNET_MODEL="${PROXY_MODEL_NAME}" \
ANTHROPIC_DEFAULT_HAIKU_MODEL="${PROXY_MODEL_NAME}" \
claude "$@"
