# Ollama + Continue.dev

Ollama로 모델을 서빙하고 VS Code의 Continue.dev 확장과 연결하는 레시피입니다.
Continue.dev는 Ollama를 네이티브로 지원하므로 **별도 프록시가 필요 없습니다**.

> Continue.dev는 VS Code 확장으로 실행되므로 별도의 `start_agent.sh`가 없습니다.

## 사전 요구사항

| 항목 | 설치 |
|------|------|
| Homebrew | [brew.sh](https://brew.sh) |
| VS Code | [code.visualstudio.com](https://code.visualstudio.com) |
| Continue.dev 확장 | [마켓플레이스](https://marketplace.visualstudio.com/items?itemName=Continue.continue) |

## 실행 방법

```bash
# 1. 설치 (최초 1회)
#    Ollama 설치 + 모델 다운로드 + Continue.dev config 생성
./setup.sh

# 2. VS Code에서 Continue.dev 확장 설치
#    확장 마켓플레이스에서 "Continue" 검색

# 3. Ollama 서버 시작
./start_server.sh

# 4. VS Code에서 Continue 패널 열기
#    단축키: Cmd+L
```

## .env 설정

```bash
OLLAMA_MODEL="qwen2.5-coder:7b"   # 사용할 모델
OLLAMA_PORT=11434                   # Ollama 기본 포트
```

## Continue.dev 주요 기능

| 단축키 | 기능 |
|--------|------|
| `Cmd+L` | 채팅 패널 열기 |
| `Cmd+Shift+L` | 선택 코드를 채팅에 추가 |
| `Cmd+I` | 인라인 코드 편집 |
| `Tab` | 자동완성 수락 |

## config.json 수동 수정

`~/.continue/config.json` 파일을 직접 편집하거나 VS Code에서 Continue 패널 → 설정 아이콘으로 접근할 수 있습니다.

```json
{
  "models": [
    {
      "title": "Ollama (qwen2.5-coder:7b)",
      "provider": "ollama",
      "model": "qwen2.5-coder:7b",
      "apiBase": "http://localhost:11434"
    }
  ]
}
```

## 문제 해결

**Continue에서 모델 연결 안 됨**
→ `./start_server.sh` 로 Ollama가 실행 중인지 확인. `ollama list` 로 모델 확인.

**자동완성이 작동 안 함**
→ `tabAutocompleteModel` 설정이 config.json에 있는지 확인.

**임베딩 오류**
→ `ollama pull nomic-embed-text` 로 임베딩 모델을 별도 다운로드하세요.

## 참고

- [Continue.dev 공식 문서](https://docs.continue.dev)
- [Continue + Ollama 설정](https://docs.continue.dev/reference/Model%20Providers/ollama)
