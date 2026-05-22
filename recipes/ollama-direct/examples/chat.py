#!/usr/bin/env python3
"""
Ollama OpenAI 호환 API를 Python으로 호출하는 예제입니다.
사용법: python3 examples/chat.py "메시지"
"""
import sys
from pathlib import Path
from openai import OpenAI

# .env 파일에서 설정 로드
env_path = Path(__file__).parent.parent / ".env"
env: dict[str, str] = {}
for line in env_path.read_text().splitlines():
    line = line.strip()
    if line and not line.startswith("#") and "=" in line:
        k, _, v = line.partition("=")
        env[k.strip()] = v.strip().strip('"').replace("${HOME}", str(Path.home()))

OLLAMA_PORT = env.get("OLLAMA_PORT", "11434")
OLLAMA_MODEL = env.get("OLLAMA_MODEL", "qwen2.5:7b")

client = OpenAI(
    base_url=f"http://localhost:{OLLAMA_PORT}/v1",
    api_key="ollama",
)


def chat(message: str) -> str:
    response = client.chat.completions.create(
        model=OLLAMA_MODEL,
        messages=[{"role": "user", "content": message}],
    )
    return response.choices[0].message.content


def chat_stream(message: str) -> None:
    stream = client.chat.completions.create(
        model=OLLAMA_MODEL,
        messages=[{"role": "user", "content": message}],
        stream=True,
    )
    for chunk in stream:
        content = chunk.choices[0].delta.content
        if content:
            print(content, end="", flush=True)
    print()


if __name__ == "__main__":
    message = sys.argv[1] if len(sys.argv) > 1 else "안녕하세요! 간단한 Python 함수를 작성해주세요."
    print(f"모델: {OLLAMA_MODEL}")
    print(f"질문: {message}")
    print("-" * 40)
    chat_stream(message)
