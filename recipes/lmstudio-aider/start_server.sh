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
echo ""

if ! curl -sf "http://localhost:${LMSTUDIO_PORT}/v1/models" > /dev/null 2>&1; then
  echo "[ERROR] LM Studio 서버에 연결할 수 없습니다. (포트: ${LMSTUDIO_PORT})"
  echo "→ LM Studio에서 Local Server를 시작했는지 확인하세요."
  exit 1
fi

echo "✓ LM Studio 서버 실행 중 (포트: ${LMSTUDIO_PORT})"
echo "  ./start_agent.sh 를 실행하세요."
