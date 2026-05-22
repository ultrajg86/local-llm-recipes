#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${SCRIPT_DIR}/.env"

echo "=== LM Studio 서버 확인 ==="
echo ""
echo "📌 LM Studio 수동 설정이 필요합니다:"
echo "   1. LM Studio 앱 실행"
echo "   2. 좌측 메뉴 → Local Server (↔ 아이콘)"
echo "   3. 모델 선택 후 'Start Server' 클릭"
echo "   4. 서버 주소 확인: http://localhost:${LMSTUDIO_PORT}"
echo "   5. 로드된 모델명을 .env 의 MODEL_NAME 에 입력"
echo ""
echo "준비가 완료되면 엔터를 눌러 연결을 확인합니다..."
read -r

if ! curl -sf "http://localhost:${LMSTUDIO_PORT}/v1/models" > /dev/null 2>&1; then
  echo "[ERROR] LM Studio 서버에 연결할 수 없습니다. (포트: ${LMSTUDIO_PORT})"
  echo "→ LM Studio에서 Local Server를 시작했는지 확인하세요."
  exit 1
fi
echo "✓ LM Studio 서버 연결 확인"

# LiteLLM 프록시 시작
source "${SCRIPT_DIR}/venv/bin/activate"

cat > /tmp/litellm_lmstudio_config.yaml << EOF
model_list:
  - model_name: ${PROXY_MODEL_NAME}
    litellm_params:
      model: openai/${MODEL_NAME}
      api_base: ${LMSTUDIO_BASE_URL}/v1
      api_key: lm-studio
litellm_settings:
  drop_params: true
EOF

echo "=== LiteLLM 프록시 시작 (포트: ${LITELLM_PORT}) ==="
litellm --config /tmp/litellm_lmstudio_config.yaml --port "${LITELLM_PORT}"
