# 🚀 Good Mode AGY

**Good Mode AGY** adalah kumpulan tools dan skrip untuk meningkatkan pengalaman menggunakan [Google Antigravity CLI (`agy`)](https://antigravity.google) — termasuk fitur **multi-akun** yang tidak tersedia secara native.

---

## ✨ Fitur

- 🔄 **Multi-account manager** — simpan, ganti, dan kelola beberapa akun Antigravity CLI
- ⚡ **Ringan & tanpa dependensi** — pure Bash, tidak perlu Node/Python khusus
- 🤖 **Kompatibel Termux** — dirancang untuk Android via Termux
- 🔐 **Aman** — token disimpan lokal dengan permission ketat

---

## 📦 Instalasi

### 1. Clone repo

```bash
git clone https://github.com/bowowiwendi/good-mode-agy.git
cd good-mode-agy
```

### 2. Jalankan installer

```bash
bash scripts/install.sh
```

Script ini akan:
- Menyalin `agy-account` ke `~/bin/`
- Menambahkan `~/bin` ke `$PATH` di `.bashrc`

### 3. Reload shell

```bash
source ~/.bashrc
```

---

## 🛠️ Penggunaan `agy-account`

```
agy-account <command> [options]

Commands:
  list              Tampilkan semua akun tersimpan
  current           Tampilkan akun yang sedang aktif
  save              Simpan akun aktif saat ini ke profil
  add               Tambah akun baru (via proses auth agy)
  switch <id>       Ganti akun aktif (gunakan email atau nomor)
  remove <id>       Hapus akun tersimpan
  help              Tampilkan bantuan ini

Options:
  --no-color        Nonaktifkan output berwarna (untuk CI/pipe)
```

### Contoh

```bash
# Simpan akun yang sedang aktif
agy-account save

# Lihat daftar semua akun
agy-account list
# Output:
# === Antigravity CLI Accounts ===
# * 1. akun1@gmail.com
#   2. akun2@gmail.com

# Ganti ke akun ke-2
agy-account switch 2

# Atau ganti dengan email
agy-account switch akun2@gmail.com

# Tambah akun baru
agy-account add
```

---

## 📁 Struktur Direktori

```
good-mode-agy/
├── bin/
│   └── agy-account       # Script utama multi-account manager
├── docs/
│   └── multi-account.md  # Panduan lengkap multi-akun
├── scripts/
│   └── install.sh        # Installer otomatis
├── .gitignore
├── LICENSE
└── README.md
```

---

## 🗂️ Penyimpanan Profil Akun

Setiap akun disimpan di:
```
~/.gemini/accounts/<email>/
  oauth-token         # Token OAuth agy
  credentials.json    # Kredensial terenkripsi
  google_accounts.json
  settings.json       # Settings per-akun
  meta.json           # Info akun (email, tanggal ditambah)
```

---

## 🤝 Kontribusi

Pull request dan issue sangat welcome! Silakan fork dan kembangkan.

---

## 📄 Lisensi

MIT License — lihat [LICENSE](LICENSE)
