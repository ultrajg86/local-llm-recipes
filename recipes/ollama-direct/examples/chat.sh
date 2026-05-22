#!/usr/bin/env bash
# 단일 메시지를 Ollama에 전송하고 응답을 출력합니다.
# 사용법: bash examples/chat.sh "메시지"

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "${SCRIPT_DIR}/.env"

MESSAGE="${1:-안녕하세요! 간단한 Python 함수를 작성해주세요.}"

curl -s "http://localhost:${OLLAMA_PORT}/v1/chat/completions" \
  -H "Content-Type: application/json" \
  -d "{
    \"model\": \"${OLLAMA_MODEL}\",
    \"messages\": [{\"role\": \"user\", \"content\": \"${MESSAGE}\"}],
    \"stream\": false
  }" | python3 -c "
import sys, json
data = json.load(sys.stdin)
print(data['choices'][0]['message']['content'])
"
