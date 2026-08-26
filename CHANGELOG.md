# Changelog

All notable changes to LCARS Science Station are documented here.

## [1.0.0] - 2026-08-26

### Added
- Full LCARS-inspired telemetry dashboard (Electron, 100% local, zero cloud)
- Live system metrics: CPU (load/freq/cores), RAM/SWAP, GPU (load/VRAM/power), thermals, network, storage (btrfs), processes, power, node info
- Landscape and portrait layouts with automatic breakpoints
- `config.json` for customization: `refresh_ms`, `hostname_override`, `cachyos_repo_check`, `health_hosts`, `nav_command`, `electron_args`
- `install.sh` multi-distro installer (pacman / apt / dnf)
- `lcars.sh` launcher (system Electron preferred, local npm fallback)
- Window manager adapters in `wm/`: Mango, Hyprland, Sway
- Desktop entry + icon for application menus
- Live screenshots in `screenshots/`

### Requirements
- Linux (Wayland recommended, X11 works)
- Electron (system package or via `npm install`) — see README

---

Fan-made aesthetic. Not affiliated with or endorsed by Paramount/CBS.
Star Trek is a trademark of its owners.
