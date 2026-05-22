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
echo "✓ 모델 준비 완료"

# LiteLLM config 동적 생성
source "${SCRIPT_DIR}/venv/bin/activate"

cat > /tmp/litellm_ollama_config.yaml << EOF
model_list:
  - model_name: ${PROXY_MODEL_NAME}
    litellm_params:
      model: ollama/${OLLAMA_MODEL}
      api_base: http://localhost:${OLLAMA_PORT}
litellm_settings:
  drop_params: true
EOF

echo "=== LiteLLM 프록시 시작 (포트: ${LITELLM_PORT}) ==="
litellm --config /tmp/litellm_ollama_config.yaml --port "${LITELLM_PORT}"
