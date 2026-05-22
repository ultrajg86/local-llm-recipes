#!/usr/bin/env bash
set -euo pipefail

echo "=== LM Studio + Aider 설치 ==="
echo ""
echo "⚠️  LM Studio 앱을 먼저 설치해야 합니다:"
echo "   https://lmstudio.ai/"
echo ""

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Python 가상환경 + Aider
if [ ! -d "${SCRIPT_DIR}/venv" ]; then
  python3 -m venv "${SCRIPT_DIR}/venv"
  echo "✓ Python 가상환경 생성"
fi
source "${SCRIPT_DIR}/venv/bin/activate"

pip install aider-chat --quiet
echo "✓ Aider 설치 완료"

echo ""
echo "설치 완료! 다음 단계:"
echo "  1. LM Studio 실행 → 모델 로드 → Local Server 시작"
echo "  2. .env 에서 MODEL_NAME 을 LM Studio 모델명으로 수정"
echo "  3. ./start_server.sh 로 서버 연결 확인"
echo "  4. ./start_agent.sh 로 Aider 실행"
