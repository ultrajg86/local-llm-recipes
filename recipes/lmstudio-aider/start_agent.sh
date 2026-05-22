#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${SCRIPT_DIR}/.env"
source "${SCRIPT_DIR}/venv/bin/activate"

# 서버 헬스체크
if ! curl -sf "http://localhost:${LMSTUDIO_PORT}/v1/models" > /dev/null 2>&1; then
  echo "[ERROR] LM Studio 서버에 연결할 수 없습니다. (포트: ${LMSTUDIO_PORT})"
  echo "→ LM Studio에서 Local Server를 시작하세요."
  exit 1
fi

echo "=== Aider 시작 ==="
echo "모델: ${MODEL_NAME}"
echo "서버: ${LMSTUDIO_BASE_URL}"
echo ""

aider \
  --model "openai/${MODEL_NAME}" \
  --openai-api-base "${LMSTUDIO_BASE_URL}/v1" \
  --openai-api-key "lm-studio" \
  "$@"
