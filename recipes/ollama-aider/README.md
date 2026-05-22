# Ollama + Aider

Ollama로 모델을 서빙하고 Aider 코딩 에이전트와 연결하는 레시피입니다.
Aider는 Ollama의 OpenAI 호환 API를 직접 지원하므로 **별도 프록시가 필요 없습니다**.

## 사전 요구사항

| 항목 | 설치 |
|------|------|
| Homebrew | [brew.sh](https://brew.sh) |
| Python 3.9+ | `brew install python3` |
| git | `brew install git` |

## 실행 방법

```bash
# 1. 설치 (최초 1회)
./setup.sh

# 2. 서버 시작 (터미널 1)
./start_server.sh

# 3. Aider 실행 (터미널 2)
./start_agent.sh

# 특정 파일과 함께 시작
./start_agent.sh file1.py file2.py

# git 없이 실행
./start_agent.sh --no-git
```

## .env 설정

```bash
OLLAMA_MODEL="qwen2.5-coder:7b"      # 사용할 모델
OLLAMA_PORT=11434                      # Ollama 기본 포트
OLLAMA_BASE_URL="http://localhost:11434"
```

## Aider 주요 기능

- 파일을 채팅창에 추가하여 코드 수정 요청
- git 커밋 자동 생성
- `/add <파일>`, `/drop <파일>`, `/undo` 등의 명령어 지원

```bash
# Aider 실행 후 명령어 예시
> /add main.py          # 파일 추가
> 이 함수를 리팩터링해줘
> /undo                 # 마지막 변경 취소
```

## 문제 해결

**Ollama 연결 실패**
→ `ollama list` 로 서버 상태 확인. `ollama serve` 가 실행 중이어야 합니다.

**모델 없음 오류**
→ `.env`의 `OLLAMA_MODEL`과 `ollama list` 출력값이 일치하는지 확인.

**응답이 느림**
→ 더 작은 모델(`qwen2.5-coder:3b`)로 변경하거나, `ollama ps` 로 현재 실행 중인 모델 확인.

## 참고

- [Aider 공식 문서](https://aider.chat)
- [Aider + Ollama 설정 가이드](https://aider.chat/docs/llms/ollama.html)
