#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
PYTHONPATH=src python -m gbt_god_view info
PYTHONPATH=src python -m gbt_god_view check --payload '{}'
PYTHONPATH=src python -m gbt_god_view run   --payload '{}'
