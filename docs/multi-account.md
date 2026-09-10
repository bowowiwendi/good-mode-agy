# Panduan Lengkap Multi-Akun & Fitur GMA (Good Mode AGY)

## 📌 Latar Belakang

Google Antigravity CLI (`agy`) pada dasarnya hanya mendukung satu akun aktif per sesi. Dalam workflow pengembangan, kita sering kali membutuhkan beberapa akun Google untuk:
- Memisahkan pekerjaan pribadi dan profesional/proyek.
- Mengatasi batasan kuota request harian (*rate limit*) per akun secara transparan.

**GMA (Good Mode AGY)** hadir untuk memberikan solusi multi-akun instan, aman, dan tanpa repot di lingkungan Android (Termux).

---

## ⚙️ Cara Kerja

Setiap akun yang pernah diotentikasi disimpan sebagai profil terisolasi di direktori:
```
~/.gemini/accounts/<email_sanitized>/
```

Ketika Anda menjalankan perintah `gma switch` atau `gma next`:
1. **Sesi Aktif Disimpan Otomatis**: Token dan preferensi akun yang sedang aktif disimpan ke folder profilnya.
2. **Kredensial Target Dipasang**: Token OAuth target disalin ke lokasi aktif `~/.gemini/antigravity-cli/antigravity-oauth-token` dengan izin berkas ketat (`chmod 600`).
3. **Konfigurasi Disinkronkan**: Berkas `google_accounts.json` dan kredensial disesuaikan agar `agy` mengenali sesi baru seketika tanpa perlu restart shell.

---

## 🚀 Alur Menambah Akun Baru

Dengan GMA v1.2.0, proses penambahan akun di Termux berjalan sepenuhnya di foreground:

```bash
gma add
```

1. Akun Anda yang sedang aktif akan dibackup otomatis terlebih dahulu.
2. GMA akan memanggil proses autentikasi Google.
3. Buka URL login di browser smartphone Anda.
4. Selesaikan proses login dan salin kode otorisasi jika diberikan.
5. Tempel kode di terminal Termux lalu tekan **Enter**.
6. GMA secara otomatis mendeteksi email akun baru dan menyimpannya ke daftar profil.

---

## ⚡ Rotasi Akun Otomatis (Auto-Switch)

GMA menyediakan dua mekanisme rotasi saat menghadapi limit kuota:

### 1. Manual Quick-Rotate
```bash
gma next
```
Perintah ini akan langsung memindahkan sesi aktif ke akun berikutnya secara melingkar (*round-robin*).

### 2. Auto-Switch Protected Execution
```bash
gma run -p "Pertanyaan atau instruksi Anda"
```
Jika akun yang sedang aktif mengembalikan error `RESOURCE_EXHAUSTED`, `429`, atau `Quota exceeded`, GMA akan:
- Mendeteksi error kuota tersebut.
- Otomatis berpindah ke akun berikutnya di daftar.
- Mencoba kembali instruksi Anda hingga berhasil atau seluruh akun tersimpan habis.

---

## 📦 Pencadangan dan Pemulihan (Backup & Restore)

Anda dapat memindahkan profil akun antar perangkat atau mencadangkannya dengan aman:

```bash
# Ekspor semua akun tersimpan ke berkas terkompresi:
gma export ~/gma-accounts-backup.tar.gz

# Impor akun pada perangkat atau sesi lain:
gma import ~/gma-accounts-backup.tar.gz
```

---

## 📱 Menu Interaktif TUI

Untuk penggunaan sehari-hari yang praktis di layar ponsel, cukup ketik:
```bash
gma
```
Menu interaktif akan memandu Anda memilih akun, mengecek kuota, melakukan backup, maupun menjalankan CLI tanpa perlu mengingat parameter perintah.
