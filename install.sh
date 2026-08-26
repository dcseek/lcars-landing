#!/usr/bin/env bash
# LCARS Science Station — multi-distro installer
# Detects the package manager, installs Electron dependencies and the app.
set -e
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

install_deps() {
  if command -v pacman >/dev/null 2>&1; then
    # Arch/CachyOS: system electron bundles all runtime libs
    if ! command -v electron >/dev/null 2>&1; then
      sudo pacman -S --needed --noconfirm electron
    fi
    return 0
  fi

  if command -v apt-get >/dev/null 2>&1; then
    # Debian/Ubuntu: Electron runtime libs
    sudo apt-get update -qq
    sudo apt-get install -y libnss3 libasound2t64 libatk-bridge2.0-0t64 \
      libgtk-3-0t64 libgbm1 libxss1 libxshmfence1 libdrm2
    return 0
  fi

  if command -v dnf >/dev/null 2>&1; then
    # Fedora
    sudo dnf install -y nss alsa-lib at-spi2-atk gtk3 libXScrnSaver \
      libxshmfence mesa-libgbm libdrm
    return 0
  fi

  echo "Unsupported package manager. Install Electron dependencies manually." >&2
  return 1
}

install_app() {
  if command -v electron >/dev/null 2>&1; then
    echo "System Electron found: $(command -v electron)"
    return 0
  fi
  if [ -x "$DIR/node_modules/.bin/electron" ]; then
    echo "Local Electron already present"
    return 0
  fi
  if ! command -v npm >/dev/null 2>&1; then
    echo "npm not found. Install Node.js (nodejs+npm) or a system Electron." >&2
    exit 1
  fi
  echo "Downloading local Electron (npm install)..."
  (cd "$DIR" && npm install --no-audit --no-fund)
}

install_desktop() {
  local apps_dir="$HOME/.local/share/applications"
  local icons_dir="$HOME/.local/share/icons/hicolor/scalable/apps"
  mkdir -p "$apps_dir" "$icons_dir"
  cp "$DIR/lcars-dashboard.desktop" "$apps_dir/"
  cp "$DIR/icon.svg" "$icons_dir/lcars-dashboard.svg"
  sed -i "s|%%LCARS_BIN%%|$DIR/lcars.sh|; s|%%LCARS_ICON%%|lcars-dashboard|" \
    "$apps_dir/lcars-dashboard.desktop"
  echo "Desktop entry installed."
}

install_config() {
  local cfg_dir="$HOME/.config/lcars-dashboard"
  if [ -f "$cfg_dir/config.json" ]; then
    echo "Config already present: $cfg_dir/config.json"
    return 0
  fi
  mkdir -p "$cfg_dir"
  cp "$DIR/config.json.example" "$cfg_dir/config.json"
  echo "Default config created: $cfg_dir/config.json (edit to customize)."
}

install_deps
install_app
install_config
install_desktop
echo
echo "✅ Installation complete. Run it with:  $DIR/lcars.sh"
