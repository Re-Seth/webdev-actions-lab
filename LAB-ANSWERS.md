# คำตอบแลป GitHub Actions + GitHub Pages

> ปรับถ้อยคำให้เป็นภาษาของตัวเองก่อนส่ง

## Exercise 4 (Automation): Workflow เริ่มเมื่อใด และ Job deploy ทำอะไร

**เริ่มเมื่อใด:** Workflow `Deploy Static Website` จะเริ่มทำงานใน 2 กรณี
1. มีการ `git push` เข้า branch `main` (`on: push: branches: [main]`)
2. กดรันเองจากแท็บ Actions → Run workflow (`workflow_dispatch`)

ถ้ามีการ push ซ้อนกันระหว่างที่ยัง deploy อยู่ `concurrency` จะยกเลิกรอบเก่าแล้วรันรอบใหม่แทน

**Job `deploy` ทำอะไร:** รันบนเครื่อง Runner `ubuntu-latest` แล้วทำทีละขั้นดังนี้
1. **Checkout source code**: ดึงโค้ดจาก Repository มาไว้บน Runner
2. **Check required files** (Challenge): ใช้ `test -f` ตรวจว่ามี `index.html`, `style.css`, `script.js` ถ้าไม่มีไฟล์ใดไฟล์หนึ่ง Workflow จะ Failed และจะไม่ deploy
3. **Setup Pages**: ตั้งค่าให้พร้อมสำหรับ GitHub Pages
4. **Upload static website**: แพ็กไฟล์ทั้งโฟลเดอร์ (`path: '.'`) เป็น Artifact
5. **Deploy to GitHub Pages**: นำ Artifact ไปเผยแพร่ แล้วส่ง URL ของเว็บออกมาที่ Environment `github-pages`

`permissions` ให้สิทธิ์เท่าที่จำเป็น คือ อ่านโค้ด (`contents: read`), เขียน Pages (`pages: write`) และขอ OIDC token เพื่อยืนยันตัวตนตอน deploy (`id-token: write`)

---

## คำถามท้ายแลป

### 1) GitHub Actions แตกต่างจาก GitHub Pages อย่างไร?
GitHub Actions เป็นระบบ **ทำงานอัตโนมัติ (CI/CD)** ที่รันคำสั่งตามเหตุการณ์ เช่น push แล้วสั่ง build, test หรือ deploy
GitHub Pages เป็น **บริการโฮสต์เว็บไซต์ Static** ที่ให้ URL สาธารณะ
ในแลปนี้ Actions คือคนส่งของ ส่วน Pages คือที่ปลายทางที่เว็บไปอยู่

### 2) เหตุใดจึงเลือก trigger ด้วย push ที่ branch main?
เพราะ `main` เป็น branch หลักที่เก็บโค้ดเวอร์ชันที่พร้อมใช้งานจริง การ deploy เฉพาะตอน push เข้า main ทำให้เว็บอัปเดตอัตโนมัติทุกครั้งที่มีโค้ดใหม่ที่ผ่านการตรวจแล้ว และงานที่ยังทำไม่เสร็จใน branch อื่นจะไม่ขึ้นเว็บจริง

### 3) ถ้าแก้ไฟล์ในเครื่องแต่ไม่ได้ push เว็บไซต์จะเปลี่ยนหรือไม่ เพราะเหตุใด?
**ไม่เปลี่ยน** เพราะ commit ที่อยู่แค่ในเครื่องยังไม่ถูกส่งขึ้น GitHub จึงไม่มีเหตุการณ์ `push` มากระตุ้น Workflow และ GitHub Actions ดึงโค้ดจาก Repository บน GitHub เท่านั้น ไม่ได้ดึงจากเครื่องเรา

### 4) เหตุใดโปรเจกต์ PHP + MySQL จึงไม่สามารถนำไปรันบน GitHub Pages ได้โดยตรง?
GitHub Pages ให้บริการแค่ไฟล์ Static (HTML/CSS/JS/รูปภาพ) ส่งไฟล์ให้เบราว์เซอร์ตามที่เป็นอยู่ ไม่มี PHP interpreter สำหรับประมวลผลโค้ดฝั่ง Server และไม่มีฐานข้อมูล MySQL ให้เชื่อมต่อ ถ้าจะใช้ต้องแยกเฉพาะหน้าเว็บ Static มาไว้บน Pages หรือย้ายไปใช้ Hosting ที่รองรับ PHP/MySQL

### 5) อธิบายขั้นตอนการค้นหาสาเหตุ เมื่อ Workflow มีสถานะ Failed
1. เปิดแท็บ **Actions** → คลิก run ที่ Failed (สีแดง)
2. คลิก Job `deploy` ดูว่า **step ไหน** ที่มีเครื่องหมาย ✗
3. เปิดดู **log ของ step นั้น** อ่านข้อความ error (เช่น `Missing index.html`, permission denied, YAML syntax error)
4. ตรวจสาเหตุที่พบบ่อย: ตำแหน่งไฟล์ `.github/workflows/deploy.yml`, การเยื้อง YAML, ชื่อ branch `main`, Settings → Pages ต้องตั้ง Source เป็น **GitHub Actions**, และ `permissions` ใน YAML
5. แก้ไขในเครื่อง → commit → push ใหม่ (หรือกด **Re-run jobs** ถ้าเป็นปัญหาชั่วคราว/แก้ใน Settings) แล้วตรวจว่าเป็นสีเขียว
