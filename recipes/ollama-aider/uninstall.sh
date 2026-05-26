#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Ollama + Aider 삭제 ==="
echo ""

# venv 삭제 (항상)
if [ -d "${SCRIPT_DIR}/venv" ]; then
  rm -rf "${SCRIPT_DIR}/venv"
  echo "✓ Python 가상환경(venv) 삭제"
else
  echo "  venv 없음 (건너뜀)"
fi

# Ollama 제거 여부 확인
if command -v ollama &>/dev/null; then
  echo ""
  echo "⚠️  Ollama는 다른 레시피(ollama-claude-code, ollama-continue 등)에서도 사용됩니다."
  printf "Ollama(brew)를 제거할까요? [y/N] "
  read -r ans
  if [[ "${ans}" =~ ^[Yy]$ ]]; then
    brew uninstall ollama
    echo "✓ Ollama 제거"
  else
    echo "  Ollama 유지"
  fi
fi

echo ""
echo "삭제 완료."
