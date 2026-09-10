#!/data/data/com.termux/files/usr/bin/bash
# install.sh - Installer untuk GMA (Good Mode AGY)
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

echo "================================================="
echo " 🚀 GMA (Good Mode AGY) v1.2.0 - Installer"
echo "================================================="
echo ""

# Buat ~/bin jika belum ada
mkdir -p "$HOME/bin"

# 1. Copy binary ke ~/bin
echo "[1/4] Memasang binary 'gma' dan 'agy-account' ke ~/bin/ ..."
cp "$PROJECT_DIR/bin/gma" "$HOME/bin/gma"
chmod +x "$HOME/bin/gma"

cp "$PROJECT_DIR/bin/agy-account" "$HOME/bin/agy-account"
chmod +x "$HOME/bin/agy-account"
echo "      ✓ Berhasil dipasang ke ~/bin/"

# 2. Tambah ~/bin ke PATH di ~/.bashrc
echo "[2/4] Mengecek konfigurasi PATH di ~/.bashrc ..."
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

# 3. Copy ke AGY CLI bin jika ada
AGY_BIN_DIR="$HOME/.gemini/antigravity-cli/bin"
if [[ -d "$AGY_BIN_DIR" ]]; then
    echo "[3/4] Menyalin ke direktori AGY bin ($AGY_BIN_DIR) ..."
    cp "$PROJECT_DIR/bin/gma" "$AGY_BIN_DIR/gma"
    chmod +x "$AGY_BIN_DIR/gma"
    cp "$PROJECT_DIR/bin/agy-account" "$AGY_BIN_DIR/agy-account"
    chmod +x "$AGY_BIN_DIR/agy-account"
    echo "      ✓ Langsung aktif dan siap digunakan!"
else
    echo "[3/4] Skipping AGY CLI bin (direktori tidak ditemukan)"
fi

echo "[4/4] Instalasi selesai!"
echo ""
echo "================================================="
echo " Siap digunakan! Coba salah satu perintah berikut:"
echo "   gma              - Buka Menu Interaktif TUI"
echo "   gma list         - Tampilkan semua akun tersimpan"
echo "   gma next         - Auto-rotate ke akun berikutnya"
echo "   gma status       - Cek status & token aktif"
echo "   gma run <args>   - Jalankan AGY dengan auto-switch"
echo "================================================="
