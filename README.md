# 🚀 GMA (Good Mode AGY) v1.2.0

**GMA (Good Mode AGY)** adalah toolkit serbaguna dan manajer akun cerdas untuk meningkatkan pengalaman menggunakan [Google Antigravity CLI (`agy`)](https://antigravity.google) di Android (Termux).

GMA menghadirkan fitur **Multi-Akun**, **Auto-Switch saat Kuota Habis**, **Pemeriksaan Status Token**, **Menu Interaktif TUI**, serta **Backup & Restore**.

---

## ✨ Fitur Utama

- 🔄 **Multi-Account Manager** — Simpan, ganti, dan kelola banyak akun Antigravity CLI tanpa perlu login ulang.
- ⚡ **Auto-Switch / Rotasi Kuota** — Otomatis berpindah ke akun berikutnya (`gma next` / `gma run`) saat terkena rate limit atau limit kuota Google.
- 📊 **Inspeksi Status & Token** — Cek masa berlaku token, refresh token, integritas file, dan tes ping konektivitas API (`gma status`).
- 📱 **Menu Interaktif TUI** — Tampilan menu terminal interaktif yang mudah digunakan langsung di layar smartphone Termux (`gma`).
- 📦 **Backup & Restore Profil** — Ekspor dan impor seluruh akun tersimpan dengan aman dalam format `.tar.gz` ber-permission ketat (`gma export` / `gma import`).
- 🤖 **Didesain Khusus Termux** — Penanganan auth foreground dan path user-space yang stabil di Android.
- 🔁 **Kompatibilitas Penuh** — Mendukung perintah baru `gma` maupun perintah lama `agy-account`.

---

## 📦 Instalasi & Pembaruan

### 1. Masuk ke direktori repositori
```bash
cd ~/good-mode-agy
```

### 2. Jalankan installer
```bash
bash scripts/install.sh
```

Installer ini akan:
- Memasang binary `gma` dan `agy-account` ke `~/bin/`
- Mendaftarkan path ke `~/.bashrc`
- Memasang ke direktori bin internal AGY CLI agar langsung aktif

---

## 🛠️ Penggunaan

### 1. Menu Interaktif (Direkomendasikan di Termux)
Cukup jalankan:
```bash
gma
```
Akan muncul antarmuka menu:
```text
╔════════════════════════════════════════════════════════════╗
║            🚀 GMA (Good Mode AGY) v1.2.0                  ║
║      Multi-Account Manager & Auto-Switcher for Termux      ║
╚════════════════════════════════════════════════════════════╝
 Akun Aktif: user@gmail.com | Tersimpan: 9 akun
------------------------------------------------------------
  1) 📋 Daftar Semua Akun Tersimpan (List)
  2) 🔄 Ganti Akun Aktif (Switch)
  3) ⏭️  Auto-Rotate ke Akun Berikutnya (Next)
  4) ➕ Tambah Akun Baru (Add / Google Auth)
  5) 💾 Simpan Akun Aktif Saat Ini (Save)
  6) 📊 Cek Status & Token (Status / Quota)
  7) ⚡ Jalankan AGY Mode Proteksi Kuota (gma run)
  8) 🚀 Jalankan Antigravity CLI Interaktif
  9) 📦 Backup / Export Akun (.tar.gz)
 10) 📥 Restore / Import Akun (.tar.gz)
 11) 🗑️  Hapus Akun Tersimpan (Remove)
  0) 🚪 Keluar
------------------------------------------------------------
```

### 2. Perintah CLI

```bash
gma <command> [options]
# atau
agy-account <command> [options]
```

| Perintah | Deskripsi |
|---|---|
| `gma` / `gma menu` | Membuka menu interaktif TUI |
| `gma list` / `ls` | Tampilkan daftar semua akun tersimpan beserta nomor urut |
| `gma current` / `whoami` | Tampilkan akun yang sedang aktif saat ini |
| `gma switch <id\|email>` | Beralih ke akun tertentu berdasarkan index nomor atau email |
| `gma next` / `rotate` | Auto-rotate ke akun berikutnya secara round-robin |
| `gma add` | Tambah akun baru (menjalankan login Google di foreground) |
| `gma save` | Simpan sesi akun aktif saat ini ke direktori profil |
| `gma remove <id\|email>` | Hapus profil akun tersimpan |
| `gma status` [`--ping`] | Cek validitas token aktif dan ping kesiapan model API |
| `gma run <args...>` | Jalankan AGY dengan proteksi auto-switch bila kuota/rate limit habis |
| `gma export` [`file.tgz`] | Backup seluruh profil akun ke arsip `.tar.gz` |
| `gma import` `<file.tgz>` | Pulihkan profil akun dari file backup `.tar.gz` |
| `gma version` / `-v` | Tampilkan versi GMA |
| `gma help` / `-h` | Tampilkan bantuan lengkap |

---

## 💡 Contoh Penggunaan Populer

### Auto-Rotate saat Kuota Habis
```bash
# Beralih cepat ke akun berikutnya
gma next

# Atau jalankan prompt batch dengan auto-retry otomatis jika akun terkena limit:
gma run -p "Buatkan ringkasan kode ini"
```

### Memeriksa Status & Masa Token
```bash
gma status
# Atau dengan verifikasi live API:
gma status --ping
```

### Backup & Restore Akun
```bash
# Backup ke home
gma export ~/backup-akun-gma.tar.gz

# Restore di perangkat lain
gma import ~/backup-akun-gma.tar.gz
```

---

## 📁 Struktur Direktori

```text
good-mode-agy/
├── bin/
│   ├── gma               # Binary utama Good Mode AGY
│   └── agy-account       # Wrapper backward-compatibility
├── docs/
│   └── multi-account.md  # Panduan lengkap multi-akun & fitur GMA
├── scripts/
│   └── install.sh        # Installer otomatis
├── .gitignore
├── LICENSE
└── README.md
```

---

## 🗂️ Penyimpanan Profil Akun

Setiap akun tersimpan aman di:
```text
~/.gemini/accounts/<sanitized_email>/
├── oauth-token         # Token OAuth AGY
├── credentials.json    # Kredensial terenkripsi
├── google_accounts.json
├── settings.json       # Pengaturan per-akun
└── meta.json           # Metadata (email, waktu update)
```

---

## 📄 Lisensi

MIT License — lihat [LICENSE](LICENSE)
