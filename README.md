# RVX KiCad Custom Libraries

Custom symbols, footprints, and 3D models for KiCad.  
Works across KiCad versions and operating systems using a single path variable.

---

## What is in this repo

```
kikad_rvx_libs/
├── rvx_symbols/        ← Custom schematic symbols   (.kicad_sym)
├── rvx_footprints/     ← Custom PCB footprints       (.kicad_mod / .pretty/)
├── rvx_3dmodels/       ← Custom 3D models            (.step / .wrl)
├── KicadLib/           ← SPICE models + extra parts
├── jano_kicad_lib/     ← Jano's shared library
└── TEA_KICAD/          ← TEA library parts
```

> **Not included** (intentional): `kicad-symbols`, `kicad-footprints`, `kicad-packages3D`  
> Those are the official KiCad libraries — let KiCad manage them automatically.

---

## How it works — one variable rules them all

```
GitHub repo  ──clone──►  local folder on your machine
                               │
                    KiCad variable: RVX_LIBS
                    points here ──────────────►  KiCad finds all libraries
```

You set `RVX_LIBS` once in KiCad. Every library path uses `${RVX_LIBS}/...`.  
When you switch machine or reinstall KiCad, you only need to set that one variable again.

---

# Setup by Operating System

---

## Manjaro / Linux

### Step 1 — Clone the repo

```bash
mkdir -p ~/kicad_libs
git clone https://github.com/RVX/kikad_rvx_libs.git ~/kicad_libs/rvx
```

### Step 2 — Add the path variable in KiCad

Open KiCad → **Preferences → Configure Paths → + (Add)**

| Name | Path |
|---|---|
| `RVX_LIBS` | `/home/YOUR_USERNAME/kicad_libs/rvx` |

> Replace `YOUR_USERNAME` with your actual Linux username.

### Step 3 — Add symbol libraries

KiCad → **Preferences → Manage Symbol Libraries → Global Libraries → + (Add)**

| Nickname | Library Path |
|---|---|
| `rvx_symbols` | `${RVX_LIBS}/rvx_symbols` |
| `KicadLib_SPICE` | `${RVX_LIBS}/KicadLib/Basic_SPICE/Basic_SPICE.kicad_sym` |
| `jano_lib` | `${RVX_LIBS}/jano_kicad_lib/my_lib/my_lib.kicad_sym` |
| `TEA_KICAD` | `${RVX_LIBS}/TEA_KICAD` |

### Step 4 — Add footprint libraries

KiCad → **Preferences → Manage Footprint Libraries → Global Libraries → + (Add)**

| Nickname | Library Path |
|---|---|
| `rvx_footprints` | `${RVX_LIBS}/rvx_footprints` |

### Step 5 — Add the 3D models path

KiCad → **Preferences → Configure Paths → + (Add)**

| Name | Path |
|---|---|
| `RVX_3D` | `${RVX_LIBS}/rvx_3dmodels` |

---

## Windows 11

### Step 1 — Install Git for Windows (if not already)

Download from: https://git-scm.com/download/win  
Install with default settings.

### Step 2 — Clone the repo

Open **PowerShell** or **Git Bash**:

```powershell
mkdir C:\kicad_libs
git clone https://github.com/RVX/kikad_rvx_libs.git C:\kicad_libs\rvx
```

### Step 3 — Add the path variable in KiCad

Open KiCad → **Preferences → Configure Paths → + (Add)**

| Name | Path |
|---|---|
| `RVX_LIBS` | `C:\kicad_libs\rvx` |

### Step 4 — Add symbol libraries

KiCad → **Preferences → Manage Symbol Libraries → Global Libraries → + (Add)**

| Nickname | Library Path |
|---|---|
| `rvx_symbols` | `${RVX_LIBS}/rvx_symbols` |
| `KicadLib_SPICE` | `${RVX_LIBS}/KicadLib/Basic_SPICE/Basic_SPICE.kicad_sym` |
| `jano_lib` | `${RVX_LIBS}/jano_kicad_lib/my_lib/my_lib.kicad_sym` |
| `TEA_KICAD` | `${RVX_LIBS}/TEA_KICAD` |

### Step 5 — Add footprint libraries

KiCad → **Preferences → Manage Footprint Libraries → Global Libraries → + (Add)**

| Nickname | Library Path |
|---|---|
| `rvx_footprints` | `${RVX_LIBS}/rvx_footprints` |

### Step 6 — Add the 3D models path

KiCad → **Preferences → Configure Paths → + (Add)**

| Name | Path |
|---|---|
| `RVX_3D` | `${RVX_LIBS}/rvx_3dmodels` |

> **Note:** KiCad on Windows accepts forward slashes `/` in paths — no need to use `\`.

---

## macOS

### Step 1 — Install Git (if not already)

```bash
xcode-select --install
```

Or install via Homebrew: `brew install git`

### Step 2 — Clone the repo

```bash
mkdir -p ~/kicad_libs
git clone https://github.com/RVX/kikad_rvx_libs.git ~/kicad_libs/rvx
```

### Step 3 — Add the path variable in KiCad

Open KiCad → **Preferences → Configure Paths → + (Add)**

| Name | Path |
|---|---|
| `RVX_LIBS` | `/Users/YOUR_USERNAME/kicad_libs/rvx` |

> Replace `YOUR_USERNAME` with your macOS username (`whoami` in Terminal tells you).

### Steps 4–6

Identical to the Manjaro steps above (same KiCad menus, same `${RVX_LIBS}/...` paths).

---

# Daily Workflow

## Keeping libraries up to date

Before starting a new design session, pull the latest libraries:

**Linux / macOS:**
```bash
cd ~/kicad_libs/rvx
git pull
```

**Windows:**
```powershell
cd C:\kicad_libs\rvx
git pull
```

## Adding or modifying a library

After editing a symbol, footprint, or 3D model:

```bash
cd ~/kicad_libs/rvx          # or C:\kicad_libs\rvx on Windows
git add -A
git commit -m "describe what you added or changed"
git push
```

Then on your other machine: `git pull`

---

# Reference

## Variable cheat sheet

| KiCad Variable | What it points to | Set in |
|---|---|---|
| `RVX_LIBS` | Root of this repo clone | Preferences → Configure Paths |
| `RVX_3D` | `${RVX_LIBS}/rvx_3dmodels` | Preferences → Configure Paths |

## Clone locations by machine

| Machine | Clone path |
|---|---|
| Manjaro (home) | `~/kicad_libs/rvx` → `/home/USERNAME/kicad_libs/rvx` |
| Windows 11 (work) | `C:\kicad_libs\rvx` |
| macOS (remote) | `~/kicad_libs/rvx` → `/Users/USERNAME/kicad_libs/rvx` |

## When KiCad upgrades

Your libraries are **safe** — they live in your own folder, not inside KiCad.  
After a KiCad reinstall, just:
1. Open KiCad
2. Re-add the `RVX_LIBS` path variable (Preferences → Configure Paths)
3. Re-add libraries via Manage Symbol / Footprint Libraries
4. Done — the files were never touched

## KiCad 9 to 10 Migration Notes (Flatpak)

Some third-party footprints still reference old variables such as:

- `${KICAD8_3RD_PARTY}`
- `${KICAD9_3RD_PARTY}`
- `${KIPRJMOD}/EASYEDA_MODELS/...`

This can cause red X markers in 3D models even when the files exist elsewhere.

### Stable path strategy

Use two roots instead of one:

1. **PCM content root** (KiCad-managed downloads in Flatpak)
2. **RVX custom root** (this repo)

Recommended mapping:

| Variable | Should point to |
|---|---|
| `KICAD8_3RD_PARTY` | `/home/USER/.var/app/org.kicad.KiCad/data/kicad/10.0/3rdparty` |
| `KICAD9_3RD_PARTY` | `/home/USER/.var/app/org.kicad.KiCad/data/kicad/10.0/3rdparty` |
| `KICAD10_3RD_PARTY` | RVX repo root (`RVX_LIBS`) |
| `KICAD_3RD_PARTY` | RVX repo root (`RVX_LIBS`) |

This keeps old library references working while preserving your custom library layout.

### One-command repair after updates

From repo root:

```bash
cd ~/kicad_libs/rvx
bash scripts/kicad_fix_3rdparty_compat.sh
```

What this script does:

1. Reapplies Flatpak overrides for KiCad 8/9/10 third-party variables.
2. Keeps symbol directory variables stable for Flatpak KiCad.
3. Refreshes project-level compatibility links used by `${KIPRJMOD}/EASYEDA_MODELS/...`.
4. Verifies representative JLCPCB and SparkFun model paths.

### If one footprint still shows a red X

Run this quick search to find unresolved model references:

```bash
rg -n "\$\{KIPRJMOD\}/EASYEDA_MODELS|\$\{KICAD8_3RD_PARTY\}|\$\{KICAD9_3RD_PARTY\}" /path/to/project --glob "*.kicad_pcb" --glob "*.kicad_mod"
```

Then add an alias model file (symlink) to the expected name in the compatibility pool.

## Should we install all JLCPCB, LCSC, EasyEDA catalogs?

Short answer: **yes, but selectively**.

### Why selective is better

1. Full catalogs increase 3D load time, indexing time, and noise in library pickers.
2. JLCPCB and LCSC ecosystems overlap heavily (many parts are the same sourcing world).
3. EasyEDA imports often duplicate footprints/models you already have from JLC packages.

### Real size data from this system

Current KiCad PCM 3rdparty totals:

- Footprints: about **111 MB**
- 3D models: about **328 MB**
- Symbols: about **68 MB**

Current package examples:

- CDFER JLCPCB package:
    - Footprints: **~0.9 MB**
    - 3D models: **~115 MB**
    - Symbols: **~6.4 MB**
- SparkFun package:
    - Footprints: **~8.4 MB**
    - 3D models: **~214 MB**
    - Symbols: **~4.1 MB**

### Practical recommendation

1. Keep **JLCPCB core** package enabled (good manufacturing alignment).
2. Use EasyEDA/LCSC import tools **on demand** for only the parts you need.
3. Periodically clean unused packages to keep KiCad fast and predictable.
4. Keep this repo as your curated, stable layer for project-critical parts.

## Troubleshooting

| Symptom | Fix |
|---|---|
| Symbol shows as "not found" | Check `RVX_LIBS` is set in Preferences → Configure Paths |
| 3D model missing in PCB view | Check `RVX_3D` path variable is set |
| Library out of date | Run `git pull` in the repo folder |
| Windows path error | Use forward slashes `/` not backslashes `\` in KiCad paths |
