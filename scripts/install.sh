#!/data/data/com.termux/files/usr/bin/bash
# ==============================================================================
# 🚀 GMA (Good Mode AGY) v1.3.0 - Installer
# Multi-Account Manager & True Auto-Switcher for Antigravity CLI on Termux
# ==============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

echo "================================================="
echo " 🚀 GMA (Good Mode AGY) v1.3.0 - Installer"
echo " True Auto-Switch for Antigravity CLI on Termux"
echo "================================================="
echo ""

# Buat ~/bin jika belum ada
mkdir -p "$HOME/bin"

# 1. Pasang binary gma, agy-account, dan transparent wrapper agy ke ~/bin/
echo "[1/5] Memasang binary 'gma', 'agy-account', dan wrapper 'agy' ke ~/bin/ ..."
cp "$PROJECT_DIR/bin/gma" "$HOME/bin/gma"
chmod +x "$HOME/bin/gma"

cp "$PROJECT_DIR/bin/agy-account" "$HOME/bin/agy-account"
chmod +x "$HOME/bin/agy-account"

cp "$PROJECT_DIR/bin/agy" "$HOME/bin/agy"
chmod +x "$HOME/bin/agy"
echo "      ✓ Berhasil dipasang ke ~/bin/ (termasuk auto-switch wrapper 'agy')"

# 2. Tambah ~/bin ke PATH di ~/.bashrc & ~/.bash_profile
echo "[2/5] Mengecek konfigurasi PATH di ~/.bashrc ..."
if ! grep -q 'export PATH="$HOME/bin:$PATH"' "$HOME/.bashrc" 2>/dev/null; then
    echo '' >> "$HOME/.bashrc"
    echo '# Good Mode AGY (GMA) - bin directory' >> "$HOME/.bashrc"
    echo 'export PATH="$HOME/bin:$PATH"' >> "$HOME/.bashrc"
    echo "      ✓ PATH ditambahkan ke ~/.bashrc"
else
    echo "      ✓ PATH sudah aktif di ~/.bashrc"
fi

if [[ -f "$HOME/.bash_profile" ]]; then
    if ! grep -q 'export PATH="$HOME/bin:$PATH"' "$HOME/.bash_profile" 2>/dev/null; then
        echo '' >> "$HOME/.bash_profile"
        echo '# Good Mode AGY (GMA) - bin directory' >> "$HOME/.bash_profile"
        echo 'export PATH="$HOME/bin:$PATH"' >> "$HOME/.bash_profile"
        echo "      ✓ PATH ditambahkan ke ~/.bash_profile"
    fi
fi

# 3. Salin ke direktori AGY CLI bin jika ada
AGY_BIN_DIR="$HOME/.gemini/antigravity-cli/bin"
if [[ -d "$AGY_BIN_DIR" ]]; then
    echo "[3/5] Menyinkronkan ke direktori internal AGY bin ($AGY_BIN_DIR) ..."
    cp "$PROJECT_DIR/bin/gma" "$AGY_BIN_DIR/gma"
    chmod +x "$AGY_BIN_DIR/gma"
    cp "$PROJECT_DIR/bin/agy-account" "$AGY_BIN_DIR/agy-account"
    chmod +x "$AGY_BIN_DIR/agy-account"
    cp "$PROJECT_DIR/bin/agy" "$AGY_BIN_DIR/agy"
    chmod +x "$AGY_BIN_DIR/agy"
    echo "      ✓ Sinkronisasi ke internal AGY bin selesai"
else
    echo "[3/5] Skipping AGY CLI bin (direktori tidak ditemukan)"
fi

# 4. Pasang Antigravity Native Lifecycle Hook
echo "[4/5] Mengonfigurasi Native Lifecycle Hook Antigravity ..."
"$HOME/bin/gma" setup-hooks
echo "      ✓ Lifecycle Hook aktif di ~/.gemini/config/hooks.json"

# 5. Konfigurasi daemon auto-start di ~/.bashrc dan jalankan daemon sekarang
echo "[5/5] Mengaktifkan GMA Auto-Switch Background Daemon ..."
if ! grep -q 'gma daemon start --quiet' "$HOME/.bashrc" 2>/dev/null; then
    echo '' >> "$HOME/.bashrc"
    echo '# Auto-start GMA Auto-Switch Daemon in background' >> "$HOME/.bashrc"
    echo 'command -v gma &>/dev/null && gma daemon start --quiet 2>/dev/null || true' >> "$HOME/.bashrc"
    echo "      ✓ Auto-start daemon ditambahkan ke ~/.bashrc"
else
    echo "      ✓ Auto-start daemon sudah ada di ~/.bashrc"
fi

"$HOME/bin/gma" daemon start --quiet 2>/dev/null || true
echo "      ✓ Daemon pemantau limit kuota aktif di latar belakang"

echo ""
echo "================================================="
echo " 🎉 Instalasi Berhasil & Auto-Switch Aktif Penuh!"
echo "================================================="
echo " Sekarang Anda CUKUP mengetik perintah normal:"
echo "   agy              - Jalankan Antigravity biasa"
echo "                      (Saat kuota habis, akun OTOMATIS berganti"
echo "                       dan percakapan langsung dilanjutkan!)"
echo "   agy -p 'prompt'  - Jalankan batch prompt dengan auto-switch"
echo ""
echo " Perintah Manajemen GMA:"
echo "   gma              - Buka Menu Interaktif TUI"
echo "   gma list         - Tampilkan semua akun tersimpan"
echo "   gma status       - Cek status token, daemon, & wrapper"
echo "   gma daemon       - Kelola background monitor (status/start/stop)"
echo "   gma watch        - Live log watcher kuota real-time"
echo "================================================="
