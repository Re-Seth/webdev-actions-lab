const status = document.querySelector('#status');
const messages = ['Hello from GitHub Pages!', 'Deployed by GitHub Actions', 'CI/CD works! แหละ'];
let count = 0;

// ปุ่ม 
document.querySelector('#helloBtn').addEventListener('click', () => {
  status.textContent = messages[count % messages.length];
  count++;
});

//Toggle Theme
const themeBtn = document.querySelector('#themeBtn');

function applyTheme(dark) {
  document.body.classList.toggle('dark', dark);
  themeBtn.textContent = dark ? 'Light' : 'Dark';
}

let saved = null;
try { saved = localStorage.getItem('theme'); } catch (e) {}
applyTheme(saved === 'dark');

themeBtn.addEventListener('click', () => {
  const dark = !document.body.classList.contains('dark');
  applyTheme(dark);
  try { localStorage.setItem('theme', dark ? 'dark' : 'light'); } catch (e) {}
});
