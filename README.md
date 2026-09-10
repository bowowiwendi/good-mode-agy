# 🚀 GMA (Good Mode AGY) v1.2.0

**GMA (Good Mode AGY)** adalah toolkit serbaguna dan manajer akun cerdas untuk meningkatkan pengalaman menggunakan [Google Antigravity CLI (`agy`)](https://antigravity.google) di Android (Termux).

GMA menghadirkan fitur **Multi-Akun**, **Konfigurasi Kustom per Akun**, **Notifikasi Termux**, **Auto-Switch saat Kuota Habis**, **Pemeriksaan Status Token**, **Menu Interaktif TUI**, serta **Backup & Restore**.

---

## ✨ Fitur Utama

- 🔄 **Multi-Account Manager** — Simpan, ganti, dan kelola banyak akun Antigravity CLI tanpa perlu login ulang.
- ⚙️ **Konfigurasi Kustom per Akun** — Beri alias/label (e.g. `Kerja`, `Utama`, `VIP`), tetapkan default model AI (e.g. `Gemini 3.8 Flash`, `Gemini 3.1 Pro`), serta atur apakah akun diikutkan dalam rotasi kuota (`gma config`).
- 🔔 **Notifikasi Status Bar Termux** — Memberikan notifikasi pop-up dan getaran pada status bar Android saat terjadi auto-switch, batas kuota tercapai, atau proses selesai (`termux-notification`).
- ⚡ **Auto-Switch / Rotasi Kuota** — Otomatis berpindah ke akun berikutnya (`gma next` / `gma run`) saat terkena rate limit atau batasan kuota Google.
- 📊 **Inspeksi Status & Token** — Cek masa berlaku token, refresh token, integritas file, dan tes ping konektivitas API (`gma status`).
- 📱 **Menu Interaktif TUI** — Tampilan menu terminal interaktif 13 pilihan yang mudah digunakan langsung di layar smartphone Termux (`gma`).
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
 Akun Aktif: user@gmail.com [Utama] | Tersimpan: 9 akun
------------------------------------------------------------
  1) 📋 Daftar Semua Akun Tersimpan (List)
  2) 🔄 Ganti Akun Aktif (Switch)
  3) ⏭️  Auto-Rotate ke Akun Berikutnya (Next)
  4) ⚙️  Konfigurasi Kustom Akun (Alias, Model, Auto-Rotate)
  5) ➕ Tambah Akun Baru (Add / Google Auth)
  6) 💾 Simpan Akun Aktif Saat Ini (Save)
  7) 📊 Cek Status & Token (Status / Quota)
  8) ⚡ Jalankan AGY Mode Proteksi Kuota (gma run)
  9) 🚀 Jalankan Antigravity CLI Interaktif
 10) 🔔 Uji Coba Notifikasi Termux
 11) 📦 Backup / Export Akun (.tar.gz)
 12) 📥 Restore / Import Akun (.tar.gz)
 13) 🗑️  Hapus Akun Tersimpan (Remove)
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
| `gma list` / `ls` | Tampilkan daftar semua akun tersimpan beserta alias & model |
| `gma current` / `whoami` | Tampilkan akun yang sedang aktif saat ini |
| `gma switch <id\|alias\|email>` | Beralih ke akun tertentu via index, alias, atau email |
| `gma next` / `rotate` | Auto-rotate ke akun berikutnya secara round-robin |
| `gma config` `<id\|email>` | Atur alias, default model, status rotasi, atau catatan |
| `gma test-notif` | Uji coba notifikasi Android status bar via Termux |
| `gma add` | Tambah akun baru (menjalankan login Google di foreground) |
| `gma save` | Simpan sesi akun aktif saat ini ke direktori profil |
| `gma remove <target>` | Hapus profil akun tersimpan |
| `gma status` [`--ping`] | Cek validitas token aktif dan ping kesiapan model API |
| `gma run <args...>` | Jalankan AGY dengan proteksi auto-switch bila kuota habis |
| `gma export` [`file.tgz`] | Backup seluruh profil akun ke arsip `.tar.gz` |
| `gma import` `<file.tgz>` | Pulihkan profil akun dari file backup `.tar.gz` |
| `gma version` / `-v` | Tampilkan versi GMA |
| `gma help` / `-h` | Tampilkan bantuan lengkap |

---

## 💡 Contoh Penggunaan Populer

### Memberikan Label Alias & Model Kustom pada Akun
```bash
# Set alias "Kerja" dan model Gemini 3.1 Pro pada akun nomor 1:
gma config 1 --alias Kerja --model "Gemini 3.1 Pro (High)"

# Beralih akun cukup dengan memanggil namanya:
gma switch Kerja
# -> GMA akan otomatis beralih akun dan menyetel model ke Gemini 3.1 Pro!
```

### Proteksi Akun Penting dari Auto-Rotate
```bash
# Matikan rotasi otomatis pada akun nomor 2 agar tidak dipakai rotasi kuota:
gma config 2 --rotate off
```

### Mengaktifkan Notifikasi Android Termux
```bash
# Pasang paket Termux API jika belum ada:
pkg install termux-api

# Tes notifikasi:
gma test-notif
```

### Auto-Rotate saat Kuota Habis
```bash
# Beralih cepat ke akun berikutnya:
gma next

# Atau jalankan prompt batch dengan auto-retry otomatis jika akun terkena limit:
gma run -p "Buatkan ringkasan kode ini"
```

### Backup & Restore Akun
```bash
# Backup ke home:
gma export ~/backup-akun-gma.tar.gz

# Restore di perangkat lain:
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
│   └── multi-account.md  # Panduan lengkap multi-akun & konfigurasi GMA
├── scripts/
│   └── install.sh        # Installer otomatis
├── .gitignore
├── LICENSE
└── README.md
```

---

## 📄 Lisensi

MIT License — lihat [LICENSE](LICENSE)
