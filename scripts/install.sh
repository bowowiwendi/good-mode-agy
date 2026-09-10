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

# Copy script
echo "[1/3] Menyalin agy-account ke ~/bin/ ..."
cp "$BIN_SOURCE" "$BIN_TARGET"
chmod +x "$BIN_TARGET"
echo "      ✓ Selesai"

# Tambah ke PATH jika belum ada
echo "[2/3] Mengecek PATH di ~/.bashrc ..."
if ! grep -q 'export PATH="$HOME/bin:$PATH"' "$HOME/.bashrc" 2>/dev/null; then
    echo '' >> "$HOME/.bashrc"
    echo '# Good Mode AGY - bin directory' >> "$HOME/.bashrc"
    echo 'export PATH="$HOME/bin:$PATH"' >> "$HOME/.bashrc"
    echo "      ✓ PATH ditambahkan ke ~/.bashrc"
else
    echo "      ✓ PATH sudah ada di ~/.bashrc"
fi

echo "[3/3] Instalasi selesai!"
echo ""
echo "=============================="
echo "Jalankan: source ~/.bashrc"
echo "Lalu coba: agy-account help"
echo "=============================="
