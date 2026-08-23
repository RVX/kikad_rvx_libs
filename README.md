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

## ── SETUP ──────────────────────────────────────────────────────────────────

---

## 🐧 Manjaro / Linux

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

## 🪟 Windows 11 (work)

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

## 🍎 macOS

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

## ── DAILY WORKFLOW ─────────────────────────────────────────────────────────

---

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

## ── REFERENCE ──────────────────────────────────────────────────────────────

---

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

## Troubleshooting

| Symptom | Fix |
|---|---|
| Symbol shows as "not found" | Check `RVX_LIBS` is set in Preferences → Configure Paths |
| 3D model missing in PCB view | Check `RVX_3D` path variable is set |
| Library out of date | Run `git pull` in the repo folder |
| Windows path error | Use forward slashes `/` not backslashes `\` in KiCad paths |
