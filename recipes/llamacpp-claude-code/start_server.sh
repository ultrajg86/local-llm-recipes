#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${SCRIPT_DIR}/.env"

# 모델 파일 경로 확인 (~ 확장)
EXPANDED_MODEL_PATH="${MODEL_PATH/#\~/$HOME}"
if [ ! -f "${EXPANDED_MODEL_PATH}" ]; then
  echo "[ERROR] 모델 파일을 찾을 수 없습니다: ${EXPANDED_MODEL_PATH}"
  echo "→ .env 의 MODEL_PATH 를 확인하세요."
  echo "→ setup.sh 의 안내를 참고하여 모델을 다운로드하세요."
  exit 1
fi

# llama-server 백그라운드 실행
echo "=== llama-server 시작 ==="
echo "모델: ${EXPANDED_MODEL_PATH}"
echo "포트: ${LLAMA_PORT} / 컨텍스트: ${CONTEXT_SIZE} / GPU 레이어: ${GPU_LAYERS}"
echo ""

llama-server \
  --model "${EXPANDED_MODEL_PATH}" \
  --port "${LLAMA_PORT}" \
  --ctx-size "${CONTEXT_SIZE}" \
  --n-gpu-layers "${GPU_LAYERS}" \
  --host 0.0.0.0 &

LLAMA_PID=$!
echo "llama-server PID: ${LLAMA_PID}"

# 서버 기동 대기 (최대 30초)
echo "서버 기동 대기 중..."
for i in $(seq 1 30); do
  if curl -sf "http://localhost:${LLAMA_PORT}/health" > /dev/null 2>&1; then
    echo "✓ llama-server 기동 완료"
    break
  fi
  sleep 1
done

# LiteLLM 프록시 시작
source "${SCRIPT_DIR}/venv/bin/activate"

cat > /tmp/litellm_llamacpp_config.yaml << EOF
model_list:
  - model_name: ${PROXY_MODEL_NAME}
    litellm_params:
      model: openai/${PROXY_MODEL_NAME}
      api_base: http://localhost:${LLAMA_PORT}/v1
      api_key: dummy
litellm_settings:
  drop_params: true
EOF

echo "=== LiteLLM 프록시 시작 (포트: ${LITELLM_PORT}) ==="
litellm --config /tmp/litellm_llamacpp_config.yaml --port "${LITELLM_PORT}"
