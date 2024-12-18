#!/bin/bash
set -e

# Install dependencies
apt-get update
apt-get install -y cmake build-essential ninja-build libgomp1 git zip
git config --global --add safe.directory /workspace

# Build with CMake
cd /workspace/llama.cpp
cmake -S . -B build -G Ninja \
    -DCMAKE_BUILD_TYPE=Release \
    -DGGML_NATIVE=OFF \
    -DGGML_CUDA=ON \
    -DCMAKE_EXE_LINKER_FLAGS=-Wl,--allow-shlib-undefined \
    -DLLAMA_FATAL_WARNINGS=ON
cmake --build build -j $(nproc)