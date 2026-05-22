#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${SCRIPT_DIR}/.env"

echo "=== vLLM + Claude Code 설치 ==="

# Python 가상환경
if [ ! -d "${SCRIPT_DIR}/venv" ]; then
  python3 -m venv "${SCRIPT_DIR}/venv"
  echo "✓ Python 가상환경 생성"
fi
source "${SCRIPT_DIR}/venv/bin/activate"

# vLLM 설치
pip install vllm --quiet
echo "✓ vLLM 설치 완료"

# Claude Code 설치
if ! command -v claude &>/dev/null; then
  npm install -g @anthropic-ai/claude-code
  echo "✓ Claude Code 설치 완료"
else
  echo "✓ Claude Code 이미 설치됨"
fi

# ~/.claude/settings.json 설정
mkdir -p "${HOME}/.claude"
cat > "${HOME}/.claude/settings.json" << EOF
{
  "env": {
    "ANTHROPIC_BASE_URL": "http://localhost:${PORT}",
    "ANTHROPIC_API_KEY": "dummy"
  }
}
EOF
echo "✓ ~/.claude/settings.json 설정 완료"

echo ""
echo "설치 완료! 다음 단계:"
echo "  1. ./start_server.sh  (터미널 1)"
echo "  2. ./start_agent.sh   (터미널 2)"
