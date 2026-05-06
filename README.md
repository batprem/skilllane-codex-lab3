# Lab 3 — CLI Deep Dive

> ใช้กับ Module 3 (CLI Deep Dive)

Module 3 มี 4 sub-labs (3A/B/C/D) — folder นี้รวม starter + solution + **sample-repo** สำหรับใช้ใน lab

## โครงสร้าง

```
sample-repo/             ← repo ตัวอย่าง ใช้ได้ Lab 3A / 3C / 3D
csv-to-json/             ← Lab 3B (starter + solution)
changelog-script/        ← Lab 3C (script template)
```

## Setup ก่อนเริ่ม (1 ครั้ง)

```bash
cd sample-repo/
./init-git-history.sh    # สร้าง git history 8 commits ใน 7 วันที่ผ่านมา
git log --oneline        # ดู commit ที่ seed แล้ว
```

## Lab 3A — Approval & Sandbox

ใช้ `sample-repo/` (เล็กกว่า openai-cookbook + control ได้) หรือ clone cookbook ก็ได้

**รอบ 1 — read-only:**
```bash
cd sample-repo/
codex --sandbox read-only --ask-for-approval untrusted
```
prompt:
```
Summarize what kind of examples this repo contains, group by topic.
```
สังเกต: Codex อ่านได้ แต่ถ้าพยายามแก้ไฟล์จะ block

**รอบ 2 — workspace-write + on-request:**
```bash
codex --full-auto
```
prompt:
```
Create a file SUMMARY.md with the topic grouping you produced last time.
```

**รอบ 3 — danger-full-access** (VM/container เท่านั้น!):
```bash
codex --sandbox danger-full-access --ask-for-approval never
```
prompt:
```
Run `npm install` to verify dependencies install correctly.
```

## Lab 3B — Session Resume & Fork (CSV → JSON CLI)

ใช้ `csv-to-json/`

```bash
cd csv-to-json/starter
codex
```

prompt:
```
Help me design a CLI in Python that converts CSV to JSON. Outline the
modules first, then we'll implement step by step.
```

ออกด้วย `Ctrl+D` แล้วลองในวันถัดไป:
```bash
codex resume --last
```

ลอง fork:
```bash
codex resume --all   # กด f เพื่อ fork
```

แล้วลอง alternative:
```
Actually, use Click instead of argparse.
```

**Reference solution:** `csv-to-json/solution/csv2json.py` — argparse version

## Lab 3C — codex exec ใน Script

ใช้ `changelog-script/` รันใน `sample-repo/` (ที่มี git history แล้ว)

```bash
cd sample-repo/
../changelog-script/generate-changelog.sh > weekly-changelog.md
cat weekly-changelog.md
```

Script ใช้ `codex exec --json` รัน Codex แบบ non-interactive — สรุป commit 7 วันที่ผ่านมา

## Lab 3D — /review Workflow

ใช้ `sample-repo/` — README.md ตั้งใจเขียนให้แย่ มีจุดให้ refactor หลายอย่าง:

```bash
cd sample-repo/
codex
```
prompt:
```
Refactor README.md so that it has a "Quickstart" section at top
that helps a brand new user run the first example. Improve formatting
and add prerequisite notes.
```

อย่าเพิ่ง commit — พิมพ์:
```
/review
```

Codex จะ spawn subagent อ่าน diff โดยไม่รู้บริบท → จะวิจารณ์งาน → รับ feedback แล้วให้ Codex หลักแก้ตาม

## ✅ Checkpoint

- [ ] เลือก approval/sandbox ให้เหมาะกับ context ได้
- [ ] ใช้ codex resume ได้ทั้ง --last, --all, --fork
- [ ] เขียน codex exec script ได้ 1 อัน
- [ ] เคยใช้ /review แล้ว 1 ครั้ง
