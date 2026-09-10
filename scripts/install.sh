#!/data/data/com.termux/files/usr/bin/bash
# install.sh - Installer untuk Good Mode AGY
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
BIN_SOURCE="$PROJECT_DIR/bin/agy-account"
BIN_TARGET="$HOME/bin/agy-account"

echo "=============================="
echo " Good Mode AGY - Installer"
echo "=============================="
echo ""

# Buat ~/bin jika belum ada
mkdir -p "$HOME/bin"

# Copy script ke ~/bin
echo "[1/4] Menyalin agy-account ke ~/bin/ ..."
cp "$BIN_SOURCE" "$BIN_TARGET"
chmod +x "$BIN_TARGET"
echo "      ✓ Selesai"

# Tambah ~/bin ke PATH jika belum ada
echo "[2/4] Mengecek PATH di ~/.bashrc ..."
if ! grep -q 'export PATH="$HOME/bin:$PATH"' "$HOME/.bashrc" 2>/dev/null; then
    echo '' >> "$HOME/.bashrc"
    echo '# Good Mode AGY - bin directory' >> "$HOME/.bashrc"
    echo 'export PATH="$HOME/bin:$PATH"' >> "$HOME/.bashrc"
    echo "      ✓ PATH ditambahkan ke ~/.bashrc"
else
    echo "      ✓ PATH sudah ada di ~/.bashrc"
fi

# Juga tambah ke .bash_profile jika ada (Termux kadang pakai ini)
if [[ -f "$HOME/.bash_profile" ]]; then
    if ! grep -q 'export PATH="$HOME/bin:$PATH"' "$HOME/.bash_profile" 2>/dev/null; then
        echo '' >> "$HOME/.bash_profile"
        echo '# Good Mode AGY - bin directory' >> "$HOME/.bash_profile"
        echo 'export PATH="$HOME/bin:$PATH"' >> "$HOME/.bash_profile"
        echo "      ✓ PATH ditambahkan ke ~/.bash_profile"
    fi
fi

# Install ke AGY CLI bin (sudah ada di PATH, langsung bisa dipakai tanpa reload shell)
AGY_BIN_DIR="$HOME/.gemini/antigravity-cli/bin"
if [[ -d "$AGY_BIN_DIR" ]]; then
    echo "[3/4] Menyalin agy-account ke $AGY_BIN_DIR (langsung aktif) ..."
    cp "$BIN_SOURCE" "$AGY_BIN_DIR/agy-account"
    chmod +x "$AGY_BIN_DIR/agy-account"
    echo "      ✓ Selesai - langsung bisa dipakai tanpa source!"
else
    echo "[3/4] Skipping AGY CLI bin (direktori tidak ditemukan)"
fi

echo "[4/4] Instalasi selesai!"
echo ""
echo "=============================="
echo "Jalankan sekarang: agy-account help"
echo "(Jika tidak ditemukan, jalankan: source ~/.bashrc)"
echo "=============================="
