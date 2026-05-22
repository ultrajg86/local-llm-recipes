# 추천 모델 목록

로컬 LLM 실행에 적합한 모델 목록입니다. **Tool Calling 지원 여부**는 Claude Code / Aider 같은 코딩 에이전트 사용 시 중요합니다.

## Ollama 모델 (ollama pull)

| 모델 | 크기 | Tool Calling | 특징 |
|------|------|-------------|------|
| `qwen2.5-coder:7b` | ~4.7GB | ✅ | 코딩 특화, 기본 추천 |
| `qwen2.5-coder:3b` | ~2GB | ✅ | 저사양용, 빠름 |
| `qwen2.5-coder:14b` | ~9GB | ✅ | 고성능, RAM 16GB+ 권장 |
| `qwen2.5:7b` | ~4.7GB | ✅ | 범용, 균형 좋음 |
| `llama3.1:8b` | ~4.7GB | ✅ | Meta 공식, 다국어 우수 |
| `mistral:7b` | ~4.1GB | ✅ | 경량, 영어 특화 |
| `phi3.5:3.8b` | ~2.2GB | ⚠️ 제한적 | Microsoft, 초경량 |

```bash
# 모델 다운로드
ollama pull qwen2.5-coder:7b

# 설치된 모델 확인
ollama list
```

---

## vLLM / llama.cpp (HuggingFace / GGUF)

| 모델 | HuggingFace ID | Tool Parser | 크기 |
|------|----------------|-------------|------|
| Qwen2.5-Coder-7B | `Qwen/Qwen2.5-Coder-7B-Instruct` | `hermes` | ~15GB |
| Qwen2.5-Coder-3B | `Qwen/Qwen2.5-Coder-3B-Instruct` | `hermes` | ~6GB |
| Qwen2.5-7B | `Qwen/Qwen2.5-7B-Instruct` | `hermes` | ~15GB |
| Llama-3.1-8B | `meta-llama/Llama-3.1-8B-Instruct` | `llama3_json` | ~16GB |
| Phi-3.5-mini | `microsoft/Phi-3.5-mini-instruct` | `hermes` | ~8GB |

### llama.cpp용 GGUF 다운로드

```bash
# Hugging Face CLI 설치
pip install huggingface_hub

# Qwen2.5-Coder-7B GGUF (Q4_K_M 권장)
huggingface-cli download Qwen/Qwen2.5-Coder-7B-Instruct-GGUF \
  qwen2.5-coder-7b-instruct-q4_k_m.gguf \
  --local-dir ~/models
```

---

## Apple Silicon 권장 설정

| RAM | 권장 모델 | 러너 |
|-----|-----------|------|
| 8GB | 3B 모델 | Ollama |
| 16GB | 7B 모델 | Ollama / llama.cpp |
| 32GB+ | 14B 모델 | Ollama / llama.cpp |

> **tip**: Apple Silicon에서는 Ollama 또는 llama.cpp가 Metal GPU를 활용하므로 vLLM보다 훨씬 빠릅니다.
