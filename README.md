# 🚀 GMA (Good Mode AGY) v1.3.0

**GMA (Good Mode AGY)** adalah toolkit serbaguna, manajer multi-akun cerdas, dan **True Auto-Switcher** untuk [Google Antigravity CLI (`agy`)](https://antigravity.google) di Android (Termux).

GMA menghadirkan fitur **True Auto-Switching Tanpa Perintah (Zero-Command Auto-Switch)**, **Multi-Akun**, **Konfigurasi Kustom per Akun**, **Notifikasi Status Bar Termux**, **Background Daemon**, **Native Lifecycle Hooks**, **Inspeksi Token**, serta **Menu Interaktif TUI**.

---

## ⚡ True Auto-Switch Tanpa Perintah (Zero-Command)

Salah satu kendala utama saat bekerja dengan Google Antigravity CLI adalah limit kuota mingguan/harian (`RESOURCE_EXHAUSTED (code 429): Individual quota reached`). Secara default, `agy` akan mencoba retry berulang kali hingga 20 menit secara sia-sia lalu berhenti, memaksa Anda keluar dan berganti akun secara manual.

**GMA v1.3.0 menyelesaikan masalah ini secara tuntas:**

1. 🔄 **Cukup Ketik `agy` Seperti Biasa (Transparent Wrapper)**  
   Setelah instalasi, GMA memasang wrapper transparan di `~/bin/agy`. Anda tidak perlu menghafal atau mengetik perintah khusus seperti `gma run`. Cukup jalankan `agy` atau `agy -p "..."` seperti biasa.
   
2. ⏱️ **Deteksi Limit Real-Time (1.5 Detik)**  
   Pemantau log aktif mendeteksi `RESOURCE_EXHAUSTED` dalam hitungan detik, langsung memutus loop retry 20 menit Google yang tidak ada gunanya.

3. 🤖 **Otomatis Beralih & Melanjutkan Percakapan (Tanpa Konfirmasi / Tanpa Perintah)**  
   GMA langsung merotasi kredensial ke akun berikutnya yang tersedia dan melanjutkan percakapan Anda (`agy --continue`) **tanpa memunculkan pertanyaan konfirmasi [Y/n]**. Sesi Anda berjalan mulus tanpa interupsi.

4. 🛡️ **Background Daemon (`gma daemon`)**  
   Daemon latar belakang yang dapat terus berjalan di Termux untuk memastikan peralihan akun tetap terjadi bahkan jika `agy` dipanggil dari sub-shell, skrip lain, atau tab berbeda.

5. 🪝 **Antigravity Native Lifecycle Hooks**  
   Terintegrasi langsung dengan mesin `hooks.json` bawaan Antigravity CLI (`~/.gemini/config/hooks.json`), menangani event `Stop` saat terjadi error kuota.

---

## ✨ Fitur Utama

- ⚡ **True Auto-Switching** — Beralih akun otomatis seketika saat kuota habis tanpa perlu perintah manual atau konfirmasi.
- 🔄 **Multi-Account Manager** — Simpan dan kelola banyak akun Google Antigravity CLI tanpa perlu login ulang.
- ⚙️ **Konfigurasi Kustom per Akun** — Beri alias/label (e.g. `Utama`, `Kerja`, `VIP`), tetapkan default model AI (e.g. `Gemini 3.8 Flash (High)`), serta atur akun mana saja yang diikutkan dalam rotasi (`gma config`).
- 🔔 **Notifikasi Status Bar Android** — Pop-up notifikasi dan getaran status bar Android saat akun otomatis berganti via `termux-notification`.
- 🛡️ **Daemon & Live Watcher** — Background service (`gma daemon`) dan real-time console watcher (`gma watch`).
- 📊 **Inspeksi Status & Token** — Cek masa berlaku token, refresh token, integritas file, dan tes ping API (`gma status`).
- 📱 **Menu Interaktif TUI** — Tampilan menu terminal interaktif 16 pilihan yang ramah layar smartphone (`gma`).
- 📦 **Backup & Restore Profil** — Ekspor dan impor seluruh akun tersimpan dalam format `.tar.gz` (`gma export` / `gma import`).

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

Installer otomatis ini akan:
- Memasang binary `gma`, `agy-account`, dan wrapper `agy` ke `~/bin/`
- Mengonfigurasi PATH dan auto-start daemon di `~/.bashrc`
- Mendaftarkan Antigravity Lifecycle Hook di `~/.gemini/config/hooks.json`
- Menyalakan daemon pemantau kuota di latar belakang

---

## 🛠️ Penggunaan

### 1. Penggunaan Sehari-hari (Otomatis Penuh)

Cukup gunakan perintah `agy` seperti biasa:
```bash
# Sesi interaktif biasa (otomatis auto-switch jika limit kuota):
agy

# Perintah prompt langsung (otomatis retry dengan akun lain jika limit):
agy -p "Buatkan skrip backup database"
```

### 2. Menu Interaktif TUI
Ketik:
```bash
gma
```
Antarmuka menu terminal akan terbuka:
```text
╔════════════════════════════════════════════════════════════╗
║            🚀 GMA (Good Mode AGY) v1.3.0                  ║
║      Multi-Account Manager & Auto-Switcher for Termux      ║
╚════════════════════════════════════════════════════════════╝
 Akun Aktif   : user@gmail.com [Utama] | Tersimpan: 10 akun
 Auto-Switch  : Aktif Penuh (Otomatis Tanpa Perintah)
 Daemon Watch : Aktif (PID: 25412) | Wrapper: Aktif di ~/bin/agy
------------------------------------------------------------
  1) 📋 Daftar Semua Akun Tersimpan (List)
  2) 🔄 Ganti Akun Aktif (Switch)
  3) ⏭️  Auto-Rotate ke Akun Berikutnya (Next)
  4) ⚙️  Konfigurasi Kustom Akun (Alias, Model, Auto-Rotate)
  5) ➕ Tambah Akun Baru (Add / Google Auth)
  6) 💾 Simpan Akun Aktif Saat Ini (Save)
  7) 📊 Cek Status & Token (Status / Quota)
  8) ⚡ Jalankan AGY Mode Auto-Switch Kuota (gma run)
  9) 🛡️ Kelola Auto-Switch Background Daemon
 10) ⚡ Pasang / Cek Transparent Wrapper 'agy'
 11) 👁️ Live Quota Watcher (Monitor Real-Time)
 12) 🔔 Uji Coba Notifikasi Termux
 13) 📦 Backup / Export Akun (.tar.gz)
 14) 📥 Restore / Import Akun (.tar.gz)
 15) 🗑️  Hapus Akun Tersimpan (Remove)
  0) 🚪 Keluar
------------------------------------------------------------
```

### 3. Tabel Perintah CLI

| Perintah | Deskripsi |
|---|---|
| `agy <args...>` | Jalankan Antigravity dengan auto-switch otomatis tanpa perintah |
| `gma` / `gma menu` | Membuka menu interaktif TUI |
| `gma run <args...>` | Eksekutor internal dengan proteksi auto-switch kuota |
| `gma daemon start\|stop\|status` | Kelola daemon pemantau kuota di latar belakang |
| `gma watch` | Pantau log kuota Antigravity secara real-time di layar |
| `gma wrapper install\|uninstall` | Pasang/copot transparent wrapper `~/bin/agy` |
| `gma list` / `ls` | Tampilkan daftar semua akun tersimpan beserta alias & model |
| `gma current` / `whoami` | Tampilkan akun yang sedang aktif saat ini |
| `gma switch <id\|alias\|email>` | Beralih ke akun tertentu via index, alias, atau email |
| `gma next` / `rotate` | Auto-rotate ke akun berikutnya secara manual |
| `gma config <id\|email>` | Atur alias, default model, status rotasi, atau catatan |
| `gma add` | Tambah akun baru via otentikasi Google |
| `gma save` | Simpan sesi akun aktif saat ini ke profil GMA |
| `gma remove <target>` | Hapus profil akun tersimpan |
| `gma status` [`--ping`] | Cek validitas token, status daemon, wrapper, & ping API |
| `gma test-notif` | Uji coba notifikasi Android status bar via Termux |
| `gma setup-hooks` | Pasang native lifecycle hook ke `~/.gemini/config/hooks.json` |
| `gma export [file.tgz]` | Backup seluruh profil akun ke arsip `.tar.gz` |
| `gma import <file.tgz>` | Pulihkan profil akun dari file backup `.tar.gz` |
| `gma raw <args...>` | Jalankan binary `agy` asli langsung tanpa intervensi GMA |
| `gma version` / `-v` | Tampilkan versi GMA |
| `gma help` / `-h` | Tampilkan bantuan lengkap |

---

## 💡 Contoh Penggunaan Populer

### Menyetel Alias dan Model AI pada Akun
```bash
# Beri alias "Utama" dan set model Gemini 3.8 Flash pada akun 1:
gma config 1 --alias Utama --model "Gemini 3.8 Flash (High)"

# Beralih langsung dengan memanggil alias:
gma switch Utama
```

### Melindungi Akun Penting dari Rotasi Otomatis
```bash
# Nonaktifkan rotasi pada akun 2 agar tidak digunakan sebagai akun cadangan:
gma config 2 --rotate off
```

### Memeriksa Status Daemon & Token
```bash
gma status
gma daemon status
```

### Mengaktifkan Notifikasi Android Termux
```bash
pkg install termux-api
gma test-notif
```

---

## 📁 Struktur Direktori

```text
good-mode-agy/
├── bin/
│   ├── agy               # Transparent wrapper dengan proteksi auto-switch
│   ├── gma               # Binary utama Good Mode AGY v1.3.0
│   └── agy-account       # Wrapper backward-compatibility
├── docs/
│   └── multi-account.md  # Panduan lengkap multi-akun & konfigurasi GMA
├── scripts/
│   └── install.sh        # Installer otomatis lengkap
├── .gitignore
├── LICENSE
└── README.md
```

---

## 📄 Lisensi

MIT License — lihat [LICENSE](LICENSE)
