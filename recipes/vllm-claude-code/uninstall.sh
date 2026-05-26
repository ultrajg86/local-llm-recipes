#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== vLLM + Claude Code 삭제 ==="
echo ""

# venv 삭제 (항상)
if [ -d "${SCRIPT_DIR}/venv" ]; then
  rm -rf "${SCRIPT_DIR}/venv"
  echo "✓ Python 가상환경(venv) 삭제"
else
  echo "  venv 없음 (건너뜀)"
fi

# ~/.claude/settings.json 삭제 여부 확인
if [ -f "${HOME}/.claude/settings.json" ]; then
  printf "~/.claude/settings.json 을 삭제할까요? [y/N] "
  read -r ans
  if [[ "${ans}" =~ ^[Yy]$ ]]; then
    rm -f "${HOME}/.claude/settings.json"
    echo "✓ ~/.claude/settings.json 삭제"
  else
    echo "  ~/.claude/settings.json 유지"
  fi
fi

# Claude Code 제거 여부 확인
if command -v claude &>/dev/null; then
  printf "Claude Code(npm global)를 제거할까요? [y/N] "
  read -r ans
  if [[ "${ans}" =~ ^[Yy]$ ]]; then
    npm uninstall -g @anthropic-ai/claude-code
    echo "✓ Claude Code 제거"
  else
    echo "  Claude Code 유지"
  fi
fi

echo ""
echo "삭제 완료."
