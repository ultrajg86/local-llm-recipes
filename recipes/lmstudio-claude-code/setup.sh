#!/usr/bin/env bash
set -euo pipefail

echo "=== LM Studio + Claude Code 설치 ==="
echo ""
echo "⚠️  LM Studio 앱을 먼저 설치해야 합니다:"
echo "   https://lmstudio.ai/"
echo "   설치 후 모델을 다운로드하고 Local Server를 활성화하세요."
echo ""

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Python 가상환경 + LiteLLM
if [ ! -d "${SCRIPT_DIR}/venv" ]; then
  python3 -m venv "${SCRIPT_DIR}/venv"
  echo "✓ Python 가상환경 생성"
fi
source "${SCRIPT_DIR}/venv/bin/activate"

pip install "litellm[proxy]" --quiet
echo "✓ LiteLLM 설치 완료"

# Claude Code
if ! command -v claude &>/dev/null; then
  npm install -g @anthropic-ai/claude-code
  echo "✓ Claude Code 설치 완료"
else
  echo "✓ Claude Code 이미 설치됨"
fi

echo ""
echo "설치 완료! 다음 단계:"
echo "  1. LM Studio 실행 → 모델 로드 → Local Server 시작"
echo "  2. .env 에서 MODEL_NAME 을 LM Studio에서 로드한 모델명으로 수정"
echo "  3. ./start_server.sh  (터미널 1)"
echo "  4. ./start_agent.sh   (터미널 2)"
