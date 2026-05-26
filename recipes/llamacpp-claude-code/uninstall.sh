#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== llama.cpp + Claude Code 삭제 ==="
echo ""

# venv 삭제 (항상)
if [ -d "${SCRIPT_DIR}/venv" ]; then
  rm -rf "${SCRIPT_DIR}/venv"
  echo "✓ Python 가상환경(venv) 삭제"
else
  echo "  venv 없음 (건너뜀)"
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

# llama.cpp 제거 여부 확인
if command -v llama-server &>/dev/null; then
  echo ""
  echo "⚠️  llama.cpp를 제거하면 GGUF 모델 서빙이 불가능해집니다."
  printf "llama.cpp(brew)를 제거할까요? [y/N] "
  read -r ans
  if [[ "${ans}" =~ ^[Yy]$ ]]; then
    brew uninstall llama.cpp
    echo "✓ llama.cpp 제거"
  else
    echo "  llama.cpp 유지"
  fi
fi

echo ""
echo "삭제 완료."
echo "  GGUF 모델 파일(~/models/)은 수동으로 삭제하세요."
