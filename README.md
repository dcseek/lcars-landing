# LCARS Science Station

A Star Trek: Strange New Worlds-inspired system telemetry dashboard for Linux.
Electron app, runs on any Wayland/X11 compositor — CPU, RAM, GPU, thermals,
network, storage, processes and system info in a single fullscreen panel.

100% local. No cloud, no account, no telemetry. Ever.

## Requirements

- Linux (Wayland recommended, X11 works)
- Node.js + npm **or** a system Electron package
- `lspci`, `ping` (optional: only for GPU name and health checks)

## Install (any distro)

```bash
unzip lcars-science-station-v1.0.0.zip
cd lcars-science-station
./install.sh       # detects your distro, installs deps + Electron
./lcars.sh
```

`install.sh` supports:

| Distro | What it installs |
|---|---|
| Arch / CachyOS | `electron` via pacman (system Electron, no npm needed) |
| Debian / Ubuntu | Electron runtime libs via apt + local Electron via `npm install` |
| Fedora | Electron runtime libs via dnf + local Electron via `npm install` |

`lcars.sh` uses system Electron if available, otherwise the local `npm install` copy.

Config lives at `~/.config/lcars-dashboard/config.json` (created on first run
with defaults — copy `config.json.example` there and edit).

## Window manager integration

Pick your WM, add the matching lines from `wm/`:

| WM | File | What it does |
|---|---|---|
| Mango | `wm/mango.conf` | fullscreen on chosen monitor, nofocus |
| Hyprland | `wm/hyprland.conf` | `windowrulev2` monitor + fullscreen |
| Sway | `wm/sway.conf` | `for_window` fullscreen + move to output |
| KDE / GNOME / others | — | just run `./lcars.sh`, resize to taste |

Tip for a vertical/portrait monitor: rotate it in your compositor settings
(KDE/GNOME: Settings → Display; Hyprland: `bind = ..., monitor, HDMI-A-1, transform, 1`),
then the dashboard layout adapts automatically (portrait breakpoints built-in).

## Configuration (`config.json`)

```json
{
  "refresh_ms": 1000,
  "hostname_override": "",
  "cachyos_repo_check": false,
  "health_hosts": [],
  "nav_command": null,
  "electron_args": []
}
```

- `refresh_ms` — metrics polling interval
- `hostname_override` — display a custom name in the title
- `cachyos_repo_check` — CachyOS/Chaotic/AUR mirror health panel (needs pacman)
- `health_hosts` — list of `{"label": "ROUTER", "host": "192.168.1.1"}` to ping
  (shown in the NODE panel, click "HOST METRICS")
- `nav_command` — command launched by the sidebar "btop" button
  (e.g. `["setsid","foot","--app-id=lcars-btop","btop"]`); `null` disables it
- `electron_args` — extra flags for Electron (e.g.
  `["--enable-features=UseOzonePlatform"]` for NVIDIA/XWayland flicker)

## Troubleshooting

- **NVIDIA flicker / blank window** → add `"electron_args": ["--enable-features=UseOzonePlatform"]` to config.json
- **Window opens on the wrong monitor** → use the `windowrulev2`/`for_window`
  lines from `wm/` for your compositor
- **No thermals shown** → your CPU/GPU needs a hwmon driver (k10temp, amdgpu,
  nvme); the panel fills itself with what the kernel exposes
- **Health panel empty** → add hosts to `health_hosts`
- **Page-flip errors on a VM (virtio-gpu)** → `export WLR_DRM_NO_ATOMIC=1` before starting sway

---

Fan-made aesthetic. Not affiliated with or endorsed by Paramount/CBS.
Star Trek is a trademark of its owners.
