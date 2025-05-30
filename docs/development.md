# Development Guide

## Install rye

Make sure you have [rye](https://rye.astral.sh/guide/) installed. If you don't have it, you can install it using the following command:

```bash
curl -sSf https://rye.astral.sh/get | bash
```

## Install dependencies

Run flowing command in the root directory of the project to install the dependencies:

```bash
rye sync
``

If you want sync the cuda dependencies, you can use the following command:

```bash
CMAKE_ARGS="-DGGML_CUDA=ON" rye sync
```

## Build Development

To develop the project, you need to build the project.

```bash
cd llama-cpp-server-py-core
rye run build-cpp 
```

If you want build the project with cuda support, you can use the following command:

```bash
cd llama-cpp-server-py-core
CMAKE_ARGS="-DGGML_CUDA=ON" rye run build-cpp 
```
