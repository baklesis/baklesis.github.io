#!/bin/bash
set -e

BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$BASE_DIR"

echo "=== Validating pt-shorts.gr ==="

# 1. CNAME check
echo ""
echo "[CNAME] Checking custom domain..."
cname_root=$(cat CNAME)
cname_docs=$(cat docs/CNAME)
if [ "$cname_root" != "pt-shorts.gr" ]; then
  echo "FAIL: Root CNAME is '$cname_root', expected 'pt-shorts.gr'"
  exit 1
fi
if [ "$cname_docs" != "pt-shorts.gr" ]; then
  echo "FAIL: docs/CNAME is '$cname_docs', expected 'pt-shorts.gr'"
  exit 1
fi
echo "[CNAME] OK"

# 2. Image reference check
echo ""
echo "[Images] Checking image references..."
errors=0
while IFS= read -r src; do
  if echo "$src" | grep -qP '^https?://'; then
    continue
  fi
  path="${src#./}"
  if [ ! -f "docs/$path" ] && [ ! -f "${path#/}" ]; then
    echo "FAIL: Missing image: $src"
    errors=$((errors + 1))
  fi
done < <(grep -oP 'src="([^"]+)"' docs/index.html | sed 's/^src="//;s/"$//')

if [ "$errors" -gt 0 ]; then
  echo "FAIL: $errors image(s) missing"
  exit 1
fi
echo "[Images] OK"

# 3. HTML validation
echo ""
echo "[HTML] Validating HTML..."
npx html-validate docs/index.html
echo "[HTML] OK"

echo ""
echo "=== All checks passed ==="
