# Ollama + Direct (curl / Python)

Ollama API를 curl 또는 Python으로 직접 호출하는 레퍼런스 레시피입니다.
에이전트 없이 **API를 직접 다루거나 커스텀 스크립트**를 만들 때 참고하세요.

## 실행 방법

```bash
# 1. 설치 (최초 1회)
./setup.sh

# 2. 서버 시작
./start_server.sh

# 3. 예제 실행 (새 터미널)
bash examples/chat.sh "파이썬으로 정렬 알고리즘 구현해줘"
bash examples/stream.sh "빠른 피보나치 함수 작성해줘"
python3 examples/chat.py "리스트 컴프리헨션 예제를 보여줘"
```

## 예제 파일

| 파일 | 설명 |
|------|------|
| `examples/chat.sh` | curl로 단일 요청 전송 |
| `examples/stream.sh` | curl로 스트리밍 응답 출력 |
| `examples/chat.py` | Python openai 라이브러리 사용 |

## API 엔드포인트

Ollama는 OpenAI 호환 API를 `http://localhost:11434/v1` 에 노출합니다.

```bash
# 모델 목록 확인
curl http://localhost:11434/v1/models

# 채팅 완성 (직접 호출)
curl http://localhost:11434/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "qwen2.5:7b",
    "messages": [{"role": "user", "content": "안녕?"}]
  }'

# Ollama 네이티브 API (generate)
curl http://localhost:11434/api/generate \
  -d '{"model": "qwen2.5:7b", "prompt": "안녕?"}'
```

## Python 커스텀 예제

```python
from openai import OpenAI

client = OpenAI(base_url="http://localhost:11434/v1", api_key="ollama")

# 멀티턴 대화
messages = []
while True:
    user_input = input("You: ")
    messages.append({"role": "user", "content": user_input})
    response = client.chat.completions.create(
        model="qwen2.5:7b",
        messages=messages,
    )
    reply = response.choices[0].message.content
    messages.append({"role": "assistant", "content": reply})
    print(f"AI: {reply}")
```

## 참고

- [Ollama API 문서](https://github.com/ollama/ollama/blob/main/docs/api.md)
- [Ollama OpenAI 호환 엔드포인트](https://github.com/ollama/ollama/blob/main/docs/openai.md)
