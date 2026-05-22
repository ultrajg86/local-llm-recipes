#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${SCRIPT_DIR}/.env"

echo "=== Ollama + Continue.dev 설치 ==="

# Ollama
if ! command -v ollama &>/dev/null; then
  brew install ollama
  echo "✓ Ollama 설치 완료"
else
  echo "✓ Ollama 이미 설치됨"
fi

# 모델 다운로드
echo "모델 다운로드: ${OLLAMA_MODEL}"
ollama pull "${OLLAMA_MODEL}"
echo "✓ 모델 준비 완료"

# Continue.dev config 생성
CONTINUE_CONFIG_DIR="${HOME}/.continue"
mkdir -p "${CONTINUE_CONFIG_DIR}"

cat > "${CONTINUE_CONFIG_DIR}/config.json" << EOF
{
  "models": [
    {
      "title": "Ollama (${OLLAMA_MODEL})",
      "provider": "ollama",
      "model": "${OLLAMA_MODEL}",
      "apiBase": "http://localhost:${OLLAMA_PORT}"
    }
  ],
  "tabAutocompleteModel": {
    "title": "Ollama Autocomplete",
    "provider": "ollama",
    "model": "${OLLAMA_MODEL}",
    "apiBase": "http://localhost:${OLLAMA_PORT}"
  },
  "embeddingsProvider": {
    "provider": "ollama",
    "model": "nomic-embed-text",
    "apiBase": "http://localhost:${OLLAMA_PORT}"
  }
}
EOF
echo "✓ Continue.dev 설정 파일 생성: ${CONTINUE_CONFIG_DIR}/config.json"

echo ""
echo "다음 단계:"
echo "  1. VS Code에서 Continue.dev 확장 설치:"
echo "     https://marketplace.visualstudio.com/items?itemName=Continue.continue"
echo "  2. ./start_server.sh 실행"
echo "  3. VS Code에서 Continue 패널(Cmd+L) 열기"
