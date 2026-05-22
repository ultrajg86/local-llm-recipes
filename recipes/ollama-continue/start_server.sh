#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${SCRIPT_DIR}/.env"

echo "=== Ollama 서버 시작 ==="

if pgrep -x "ollama" > /dev/null 2>&1; then
  echo "✓ Ollama 이미 실행 중 (포트: ${OLLAMA_PORT})"
  echo "  VS Code에서 Continue 패널(Cmd+L)을 열어 사용하세요."
else
  ollama serve
fi
