#!/usr/bin/env bash
set -euo pipefail

echo "=== Ollama + Continue.dev 삭제 ==="
echo ""

# ~/.continue/config.json 삭제 여부 확인
if [ -f "${HOME}/.continue/config.json" ]; then
  printf "~/.continue/config.json 을 삭제할까요? [y/N] "
  read -r ans
  if [[ "${ans}" =~ ^[Yy]$ ]]; then
    rm -f "${HOME}/.continue/config.json"
    echo "✓ ~/.continue/config.json 삭제"
  else
    echo "  ~/.continue/config.json 유지"
  fi
fi

# Ollama 제거 여부 확인
if command -v ollama &>/dev/null; then
  echo ""
  echo "⚠️  Ollama는 다른 레시피(ollama-aider, ollama-claude-code 등)에서도 사용됩니다."
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
echo "  Continue.dev VS Code 확장은 VS Code 확장 탭에서 직접 제거하세요."
