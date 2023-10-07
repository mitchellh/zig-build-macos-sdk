#!/usr/bin/env bash
set -euo pipefail

./update.sh
git diff
