# Panduan Lengkap Multi-Akun & Fitur GMA (Good Mode AGY)

## 📌 Latar Belakang

Google Antigravity CLI (`agy`) pada dasarnya hanya mendukung satu akun aktif per sesi. Dalam workflow pengembangan, kita sering kali membutuhkan beberapa akun Google untuk:
- Memisahkan pekerjaan pribadi, kantor, dan proyek riset.
- Mengatasi batasan kuota request harian (*rate limit*) per akun secara transparan.

**GMA (Good Mode AGY)** hadir untuk memberikan solusi multi-akun instan, aman, dan tanpa repot di lingkungan Android (Termux), dilengkapi dengan konfigurasi per akun dan notifikasi otomatis.

---

## ⚙️ Cara Kerja & Penyimpanan Profil

Setiap akun yang pernah diotentikasi disimpan sebagai profil terisolasi di direktori:
```text
~/.gemini/accounts/<email_sanitized>/
├── oauth-token         # Kredensial OAuth token
├── credentials.json    # Kredensial terenkripsi
├── google_accounts.json
├── settings.json       # Preferensi AGY
└── meta.json           # Metadata (alias, model default, status auto-rotate, catatan)
```

Ketika Anda beralih akun (`gma switch <target>` atau `gma next`):
1. **Sesi Aktif Disimpan Otomatis**: Kredensial sesi akun aktif saat ini dicadangkan ke foldernya.
2. **Kredensial Target Dipasang**: Berkas token akun tujuan disalin dengan permission aman (`chmod 600`).
3. **Penerapan Konfigurasi Kustom**: Jika akun tujuan memiliki konfigurasi model khusus di `meta.json`, GMA secara instan memperbarui model aktif pada berkas `settings.json`.
4. **Notifikasi Termux Dikirim**: Sinyal pergantian akun dikirimkan ke status bar ponsel.

---

## 🏷️ Konfigurasi Kustom per Akun

Anda dapat menyesuaikan tiap akun agar memiliki identitas dan perilaku khusus:

### 1. Alias / Nama Panggilan
Alih-alih mengetik email panjang, beri alias singkat seperti `Kerja`, `Utama`, atau `VIP`:
```bash
gma config 1 --alias Kerja
gma switch Kerja
```

### 2. Default Model AI per Akun
Setiap akun dapat diarahkan ke model tertentu secara otomatis saat diaktifkan:
```bash
# Akun 1 menggunakan Gemini 3.1 Pro:
gma config 1 --model "Gemini 3.1 Pro (High)"

# Akun 2 menggunakan Gemini 3.8 Flash:
gma config 2 --model "Gemini 3.8 Flash (High)"
```

### 3. Kontrol Auto-Rotate (Proteksi Akun)
Jika ada akun penting/berbayar yang tidak ingin Anda jadikan tumbal rotasi otomatis saat kuota akun lain habis:
```bash
gma config 1 --rotate off
```
Saat `gma next` atau `gma run` melakukan auto-switch kuota, akun ini akan dilewati.

---

## 🔔 Notifikasi Android Termux

GMA terintegrasi dengan subsistem notifikasi Android Termux (`termux-notification`).

### Persyaratan:
1. Pasang paket API:
   ```bash
   pkg install termux-api
   ```
2. Pastikan aplikasi Android pendamping **Termux:API** telah terpasang di perangkat Anda.

### Kejadian yang Memicu Notifikasi:
- Pergantian akun via `gma switch` atau `gma next`.
- Terdeteksinya error limit kuota (`429`, `RESOURCE_EXHAUSTED`).
- Ekspor / impor profil akun berhasil.
- Pengujian notifikasi (`gma test-notif`).

---

## 🚀 Alur Menambah Akun Baru

Proses penambahan akun di Termux berjalan sepenuhnya di foreground:
```bash
gma add
```
1. Akun aktif saat ini dibackup otomatis.
2. GMA menjalankan otentikasi Google.
3. Buka URL login di peramban (browser) ponsel.
4. Salin kode otorisasi dan tempel di terminal Termux lalu tekan Enter.
5. GMA mendeteksi token baru, menyimpannya ke profil, dan meminta Anda memberikan alias opsional.

---

## 📦 Pencadangan dan Pemulihan (Backup & Restore)

Pindahkan profil akun ke perangkat baru secara utuh:
```bash
# Ekspor:
gma export ~/gma-accounts-backup.tar.gz

# Impor:
gma import ~/gma-accounts-backup.tar.gz
```
