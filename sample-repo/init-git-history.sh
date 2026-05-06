#!/bin/bash
# init-git-history.sh
# สร้าง git history ที่มี commit หลาย type — สำหรับ Lab 3C (codex exec changelog)
#
# Run นี้ครั้งเดียว หลัง clone/copy folder นี้ไปแล้ว
#
# Usage:
#   cd sample-repo/
#   ./init-git-history.sh
set -e

if [ -d .git ]; then
  echo "✗ .git already exists — refusing to overwrite. Delete it first if you want to re-init."
  exit 1
fi

git init -q
git config user.email "lab@codex.course"
git config user.name "Lab User"

# Helper: commit with a fake date (so all commits look like the past 7 days)
commit_at() {
  local days_ago=$1
  local message=$2
  local date
  date=$(python3 -c "import datetime; print((datetime.datetime.now() - datetime.timedelta(days=$days_ago)).strftime('%Y-%m-%d %H:%M:%S'))")
  GIT_AUTHOR_DATE="$date" GIT_COMMITTER_DATE="$date" git commit -q -m "$message"
}

# Day 7 — initial scaffold
git add package.json .gitignore README.md
commit_at 7 "chore: initial project scaffold"

# Day 6 — first example
git add examples/01-basic-chat.js
commit_at 6 "feat(examples): add basic chat completion example"

# Day 5 — streaming
git add examples/02-streaming.js
commit_at 5 "feat(examples): add streaming chat example"

# Day 4 — docs topic
git add docs/topics.md
commit_at 4 "docs: list covered topics + out-of-scope items"

# Day 3 — function calling + vision
git add examples/03-function-calling.js
commit_at 3 "feat(examples): add function calling demo with weather tool"
git add examples/04-vision.js
commit_at 3 "feat(examples): add vision multimodal example"

# Day 2 — embeddings
git add examples/05-embeddings.js
commit_at 2 "feat(examples): add embeddings + cosine similarity helper"

# Day 1 — small fixes
printf "\n" >> README.md
git add README.md
commit_at 1 "docs: minor readme tweak"

# Day 0 — version bump (actually change version 0.2.0 → 0.3.0 if exists, else just amend timestamp)
if grep -q '"version": "0.3.0"' package.json; then
  # Already bumped — make a different small chore (touch a comment in topics.md)
  printf "\n<!-- last touched: regen %s -->\n" "$(date +%Y-%m-%d)" >> docs/topics.md
  git add docs/topics.md
  commit_at 0 "chore: refresh topics doc"
else
  sed -i.bak 's/"version": "[^"]*"/"version": "0.3.0"/' package.json && rm -f package.json.bak
  git add package.json
  commit_at 0 "chore: bump version to 0.3.0"
fi

echo "✓ Created $(git rev-list --count HEAD) commits over 7 days"
echo "  Try: git log --oneline"
