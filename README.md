# llama-cpp-server-py

Simple Python binding for [llama.cpp server](https://github.com/ggerganov/llama.cpp/blob/master/examples/server/README.md)


## Installation

### Prerequisites

- C/C++ development tools
- CMake
- Python 3.8 or later

Please make `CC` and `CXX` environment variables point to the C and C++ compilers, respectively. For example, in bash:
```
export CC=`which gcc`"
export CXX=`which g++`"
```

### Install

```bash
pip install llama-cpp-server-py
```

If you want to accelerate the inference speed, and you have a GPU, you can install the following dependencies:
    
```bash
CMAKE_ARGS="-DGGML_CUDA=ON" pip install llama-cpp-server-py
```

## Usage

```python
import logging
import sys
from llama_cpp_server_py_core import (
    ServerProcess,
    ServerConfig,
    LlamaCppServer,
    CompletionRequest,
    CompletionResponse,
    ChatCompletionRequest,
)

logging.basicConfig(
    stream=sys.stdout,
    level=logging.INFO,
    format="%(asctime)s | %(levelname)s | %(name)s | %(message)s",
)

config = ServerConfig(
    model_file="/data/dl/llm/qwen/Qwen2.5-Coder-14B-Instruct-Q4_k_m.gguf",
    model_hf_repo=None,
    model_hf_file=None,
    n_gpu_layers=1000000000,
)

server = ServerProcess(config)
server.start(timeout_seconds=60)

ms = LlamaCppServer(server, config)
ms.health()

# Completion
result = ms.completion(CompletionRequest(prompt="hello", n_predict=20))
print(result)


## Streaming completion
for out in ms.stream_completion(
    CompletionRequest(prompt="hello", n_predict=20, stream=True)
):
    print(out)


## Chat completion
req = ChatCompletionRequest(
    messages=[
        {"role": "system", "content": "你是一个聊天机器人"},
        {"role": "user", "content": "你好"},
    ],
    max_tokens=20,
    stream=False,
)
result = ms.chat_completion(req)
print(result)

## Streaming chat completion
req = ChatCompletionRequest(
    messages=[
        {"role": "system", "content": "你是一个聊天机器人"},
        {"role": "user", "content": "你好"},
    ],
    max_tokens=20,
    stream=True,
)
for out in ms.stream_chat_completion(req):
    print(out)
```