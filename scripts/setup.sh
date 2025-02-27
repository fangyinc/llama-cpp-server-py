#!/bin/bash

# Initialize submodules
git submodule update --init --recursive

# Apply patch
./scripts/apply-patch.sh