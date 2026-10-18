# webdev-actions-lab

LAB: GitHub Actions + GitHub Pages: เว็บไซต์ Static ที่ Deploy อัตโนมัติทุกครั้งที่ push เข้า `main`

## สิ่งที่ทำไว้แล้วในโฟลเดอร์นี้
- [x] Part A: `index.html`, `style.css`, `script.js` + `git init` / commit "Create starter website"
- [x] Part B: `.github/workflows/deploy.yml` + commit "Add automatic deployment workflow"
- [x] Part D: เปลี่ยน `<h1>` และสีปุ่ม + commit "Update home page design"
- [x] Exercise 2: ส่วน About Me, Skills, Contact
- [x] Exercise 3: ปุ่ม Toggle Theme (Dark/Light) และปุ่ม Say Hello เปลี่ยนข้อความวน
- [x] Exercise 4 + คำถามท้ายแลป: ดู `LAB-ANSWERS.md`
- [x] Challenge: step `Check required files` ใช้ `test -f` ก่อน Deploy

## สิ่งที่ต้องทำเอง
1. **Exercise 1:** แก้ `YOUR NAME`, `YOUR ID`, อีเมล และ `YOUR_USERNAME` ใน `index.html` แล้ว commit
2. สร้าง Repository ว่างบน GitHub ชื่อ `webdev-actions-lab` (Public, **ไม่ต้อง** Add README)
3. เชื่อม remote และ push:
   ```bash
   git remote add origin https://github.com/YOUR_USERNAME/webdev-actions-lab.git
   git push -u origin main
   ```
4. Repository → **Settings → Pages** → Source เลือก **GitHub Actions**
5. แท็บ **Actions** → ถ้า run แรก Failed เพราะยังไม่ได้เปิด Pages ให้กด **Re-run jobs** → รอให้เป็นสีเขียว
6. เปิด `https://YOUR_USERNAME.github.io/webdev-actions-lab/` แล้วทดสอบปุ่ม
7. Part D (ทดสอบ CD): แก้ไขอะไรเล็กน้อย → commit → push → ดูว่า Actions รันใหม่เองและเว็บอัปเดต (Ctrl+F5)

## สิ่งที่ต้องส่ง
(ก) Repository URL (ข) GitHub Pages URL (ค) Screenshot แท็บ Actions ที่สำเร็จ (ง) Screenshot หน้าเว็บ (จ) คำตอบจาก `LAB-ANSWERS.md`
