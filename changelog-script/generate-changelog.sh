#!/bin/bash
# generate-changelog.sh
# ใช้ Codex สรุป commit ของอาทิตย์ที่ผ่านมาเป็น CHANGELOG entry
#
# Usage:
#   ./generate-changelog.sh                          # print to stdout
#   ./generate-changelog.sh > weekly-changelog.md    # save to file
#
# Requires: codex CLI logged in

set -e

if ! command -v codex &> /dev/null; then
  echo "Error: codex not found. Install: brew install codex" >&2
  exit 1
fi

codex exec \
  --sandbox read-only \
  --ask-for-approval never \
  --json \
  "Read the last 7 days of git log in this repo and write a concise
   CHANGELOG entry in markdown format. Group commits by type
   (feat / fix / chore / docs). Output only the markdown — no preamble."
