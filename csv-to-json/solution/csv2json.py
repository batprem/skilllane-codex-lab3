#!/usr/bin/env python3
"""Convert CSV to JSON.

Usage:
    python csv2json.py input.csv [-o output.json] [--pretty]
"""
import argparse
import csv
import json
import sys


def csv_to_json(input_path: str, output_path: str | None, pretty: bool) -> None:
    with open(input_path, encoding="utf-8") as f:
        reader = csv.DictReader(f)
        rows = list(reader)

    indent = 2 if pretty else None
    output_text = json.dumps(rows, ensure_ascii=False, indent=indent)

    if output_path:
        with open(output_path, "w", encoding="utf-8") as f:
            f.write(output_text)
        print(f"✓ Wrote {len(rows)} rows to {output_path}", file=sys.stderr)
    else:
        print(output_text)


def main() -> None:
    p = argparse.ArgumentParser(description="Convert CSV to JSON")
    p.add_argument("input", help="Input CSV file")
    p.add_argument("-o", "--output", help="Output JSON file (default: stdout)")
    p.add_argument("--pretty", action="store_true", help="Pretty-print with indentation")
    args = p.parse_args()
    csv_to_json(args.input, args.output, args.pretty)


if __name__ == "__main__":
    main()
