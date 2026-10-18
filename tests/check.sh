#!/usr/bin/env bash
# ชุดเทสต์ของเว็บไซต์ Static: รันได้ทั้งบน GitHub Actions และในเครื่อง (Git Bash)
#   bash tests/check.sh

pass=0
fail=0

check() {
  local desc="$1"; shift
  if "$@" > /dev/null 2>&1; then
    echo "PASS  $desc"
    pass=$((pass + 1))
  else
    echo "FAIL  $desc"
    fail=$((fail + 1))
  fi
}

echo "== Files =="
for f in index.html style.css script.js; do
  check "มีไฟล์ $f" test -f "$f"
done

echo "== HTML =="
check "มี <!doctype html>"            grep -qi '<!doctype html>' index.html
check "มี <title>"                    grep -q '<title>.*</title>' index.html
check "มี meta viewport"              grep -q 'name="viewport"' index.html
check "โหลด style.css แบบ relative"   grep -q 'href="style.css"' index.html
check "โหลด script.js แบบ relative"   grep -q 'src="script.js"' index.html
check "ไม่ใช้ absolute path /style.css หรือ /script.js" \
      bash -c '! grep -qE "(href|src)=\"/(style\.css|script\.js)\"" index.html'
check "แก้ชื่อแล้ว (ไม่มี YOUR NAME)" bash -c '! grep -q "YOUR NAME" index.html'
check "แก้รหัสนิสิตแล้ว (ไม่มี YOUR ID)" bash -c '! grep -q "YOUR ID" index.html'

echo "== Sections (Exercise 2) =="
for id in about skills contact; do
  check "มี section #$id" grep -q "id=\"$id\"" index.html
done

echo "== JavaScript (Exercise 3) =="
check "มีปุ่ม #helloBtn"   grep -q 'id="helloBtn"' index.html
check "มีปุ่ม #themeBtn"   grep -q 'id="themeBtn"' index.html
check "มี #status"          grep -q 'id="status"' index.html
if command -v node > /dev/null 2>&1; then
  check "script.js ไม่มี syntax error" node --check script.js
fi

echo "== Security =="
check "ไม่มีไฟล์ .env ใน repo" bash -c '! find . -name ".env*" -not -path "./.git/*" | grep -q .'

echo
echo "ผลรวม: $pass passed, $fail failed"
[ "$fail" -eq 0 ]
