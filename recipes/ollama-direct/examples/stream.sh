#!/usr/bin/env bash
# 스트리밍 응답을 출력합니다.
# 사용법: bash examples/stream.sh "메시지"

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "${SCRIPT_DIR}/.env"

MESSAGE="${1:-파이썬으로 피보나치 수열을 구하는 함수를 작성해주세요.}"

curl -s "http://localhost:${OLLAMA_PORT}/v1/chat/completions" \
  -H "Content-Type: application/json" \
  -d "{
    \"model\": \"${OLLAMA_MODEL}\",
    \"messages\": [{\"role\": \"user\", \"content\": \"${MESSAGE}\"}],
    \"stream\": true
  }" | while IFS= read -r line; do
    line="${line#data: }"
    [ -z "${line}" ] || [ "${line}" = "[DONE]" ] && continue
    python3 -c "
import sys, json
try:
    delta = json.loads(sys.argv[1])['choices'][0]['delta']
    print(delta.get('content', ''), end='', flush=True)
except: pass
" "${line}"
  done
echo ""
