#!/bin/bash

pushd llama-cpp-server-py-core/llama.cpp

# Apply patch
git apply ../../patches/llama.cpp.patch

popd
echo "✅ Patch applied successfully"