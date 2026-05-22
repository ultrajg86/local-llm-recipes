#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${SCRIPT_DIR}/.env"
source "${SCRIPT_DIR}/venv/bin/activate"

echo "=== vLLM 서버 시작 ==="
echo "모델: ${MODEL_ID}"
echo "포트: ${PORT}"
echo ""

ARGS=(
  --model "${MODEL_ID}"
  --served-model-name "${MODEL_NAME}"
  --port "${PORT}"
  --tool-call-parser "${TOOL_CALL_PARSER}"
  --enable-auto-tool-choice
  --host 0.0.0.0
)

if [ "${CPU_ONLY:-false}" = "true" ]; then
  ARGS+=(--device cpu)
  echo "⚠️  CPU 모드로 실행 (Apple Silicon)"
fi

if [ -n "${MAX_MODEL_LEN:-}" ]; then
  ARGS+=(--max-model-len "${MAX_MODEL_LEN}")
fi

python -m vllm.entrypoints.openai.api_server "${ARGS[@]}"
