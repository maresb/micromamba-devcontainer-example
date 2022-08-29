#!/bin/bash

set -euf -o pipefail

# Change to script directory
cd "$(dirname "${BASH_SOURCE[0]}")"

rm -f conda-lock.yml
conda-lock -f .devcontainer/dev-conda-environment.yaml -f conda-environment.yaml
