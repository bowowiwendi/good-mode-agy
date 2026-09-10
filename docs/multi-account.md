# Panduan Lengkap Multi-Akun di Antigravity CLI

## Latar Belakang

Antigravity CLI (`agy`) hanya mendukung satu akun aktif per sesi. Tool `agy-account` hadir
untuk mengatasi keterbatasan ini dengan mengelola beberapa profil kredensial secara aman.

---

## Cara Kerja

Setiap akun disimpan sebagai "profil" di direktori:
```
~/.gemini/accounts/<email_sanitized>/
```

Saat Anda melakukan `switch`, tool ini akan:
1. Membackup token akun aktif ke direktori profilnya
2. Menyalin token akun target ke lokasi aktif agy
3. Memperbarui `google_accounts.json`

---

## Workflow Menambah Akun Baru

```bash
# Terminal 1 - jalankan perintah ini
agy-account add
# Script akan backup akun lama dan menunggu token baru

# Terminal 2 - login dengan akun berbeda
agy
# Ikuti proses auth, login dengan Google account yang berbeda

# Kembali ke Terminal 1
# Script otomatis mendeteksi token baru dan menyimpannya
```

---

## Tips

- Gunakan `agy-account save` setelah pertama kali setup untuk menyimpan akun awal
- Token expired akan menyebabkan error saat `switch` — login ulang diperlukan
- Untuk CI/scripting gunakan flag `--no-color`
