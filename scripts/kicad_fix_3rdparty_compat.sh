#!/usr/bin/env bash
set -euo pipefail

APP_ID="org.kicad.KiCad"
PCM_ROOT="/home/rvx/.var/app/org.kicad.KiCad/data/kicad/10.0/3rdparty"
USER_LIB_ROOT="/home/rvx/Documents/kikad_rvx_libs"
CFG10="/home/rvx/.var/app/org.kicad.KiCad/config/kicad/10.0/kicad_common.json"
CFG9="/home/rvx/.config/kicad/9.0/kicad_common.json"
EASYEDA_POOL="/home/rvx/Documents/kicad_projects_vic/JULIAN_CHARRIERE/DREAMMACHINE_LEDBAR/RP2350B/RP2350B-Dev-Board-main/EasyEDA.pretty/EasyEDA.3dshapes"
RP2350_PRETTY="/home/rvx/Documents/kicad_projects_vic/JULIAN_CHARRIERE/DREAMMACHINE_LEDBAR/RP2350B/RP2350B-Dev-Board-main/RP2350 Dev Board.pretty"
JLC3D="$PCM_ROOT/3dmodels/com_github_CDFER_JLCPCB-Kicad-Library/JLCPCB.3dshapes"

PROJECT_DIRS=(
  "/home/rvx/Documents/kicad_projects_vic/JULIAN_CHARRIERE/DREAMMACHINE_LEDBAR/Dreammachine_Rpi_Shield_APPEND.kicad_pro"
  "/home/rvx/Documents/kicad_projects_vic/JULIAN_CHARRIERE/DREAMMACHINE_LEDBAR/Dreammachine_Rpi_Shield_APEND_DAC_AMP/Dreammachine_Rpi_Shield_APPEND_DAC_AMP.kicad_pro"
)

PCB_FILES=(
  "/home/rvx/Documents/kicad_projects_vic/JULIAN_CHARRIERE/DREAMMACHINE_LEDBAR/Dreammachine_Rpi_Shield_APPEND.kicad_pro/Dreammachine_Rpi_Shield_APPEND.kicad_pro.kicad_pcb"
  "/home/rvx/Documents/kicad_projects_vic/JULIAN_CHARRIERE/DREAMMACHINE_LEDBAR/Dreammachine_Rpi_Shield_APEND_DAC_AMP/Dreammachine_Rpi_Shield_APPEND_DAC_AMP.kicad_pro/Dreammachine_Rpi_Shield_APPEND_DAC_AMP.kicad_pro.kicad_pcb"
)

flatpak override --user \
  --env=KICAD8_3RD_PARTY="$PCM_ROOT" \
  --env=KICAD9_3RD_PARTY="$PCM_ROOT" \
  --env=KICAD10_3RD_PARTY="$USER_LIB_ROOT" \
  --env=KICAD_3RD_PARTY="$USER_LIB_ROOT" \
  --env=KICAD10_SYMBOL_DIR=/app/extensions/Library/Symbols/symbols \
  --env=KICAD_SYMBOL_DIR=/app/extensions/Library/Symbols/symbols \
  "$APP_ID"

echo "Flatpak overrides refreshed."

echo "Verifying representative model paths..."
if [ -f "$PCM_ROOT/3dmodels/com_github_CDFER_JLCPCB-Kicad-Library/JLCPCB.3dshapes/C_1206.step" ]; then
  echo "OK: CDFER model found"
else
  echo "WARN: CDFER model not found"
fi

if [ -f "$PCM_ROOT/3dmodels/com_github_sparkfun_SparkFun-KiCad-Libraries/Semiconductor-Standard.3dshapes/TSSOP-20_4.4x6.5mm_P0.65mm.step" ]; then
  echo "OK: SparkFun model found"
else
  echo "WARN: SparkFun model not found"
fi

echo "Refreshing project-local EASYEDA compatibility links..."
mkdir -p "$EASYEDA_POOL"

for d in "${PROJECT_DIRS[@]}"; do
  if [ -d "$d" ]; then
    ln -sfn "$EASYEDA_POOL" "$d/EASYEDA_MODELS"
    ln -sfn "$RP2350_PRETTY" "$d/RP2350 Dev Board.pretty"
    echo "OK: linked compatibility paths in $d"
  else
    echo "WARN: project folder missing: $d"
  fi
done

linked_count=0
missing_count=0

mapfile -t easyeda_models < <(
  for pcb in "${PCB_FILES[@]}"; do
    [ -f "$pcb" ] || continue
    sed -n 's#.*\${KIPRJMOD}/EASYEDA_MODELS/\([^" )]*\).*#\1#p' "$pcb"
  done | sort -u
)

echo "EASYEDA refs discovered: ${#easyeda_models[@]}"

for model_name in "${easyeda_models[@]}"; do
  [ -n "$model_name" ] || continue

  if [ -e "$EASYEDA_POOL/$model_name" ]; then
    continue
  fi

  exact_candidate="$JLC3D/$model_name"
  mapped_candidate=""
  if [[ "$model_name" =~ ^([A-Z])([0-9]{4})_.*\.step$ ]]; then
    mapped_candidate="$JLC3D/${BASH_REMATCH[1]}_${BASH_REMATCH[2]}.step"
  fi

  if [ -e "$exact_candidate" ]; then
    ln -sfn "$exact_candidate" "$EASYEDA_POOL/$model_name"
    echo "OK: alias $model_name -> $(basename "$exact_candidate")"
    linked_count=$((linked_count + 1))
  elif [ -n "$mapped_candidate" ] && [ -e "$mapped_candidate" ]; then
    ln -sfn "$mapped_candidate" "$EASYEDA_POOL/$model_name"
    echo "OK: alias $model_name -> $(basename "$mapped_candidate")"
    linked_count=$((linked_count + 1))
  else
    echo "WARN: unresolved EASYEDA model alias: $model_name"
    missing_count=$((missing_count + 1))
  fi
done

echo "EASYEDA aliases linked: $linked_count"
echo "EASYEDA aliases unresolved: $missing_count"

echo "Configs to keep in sync:"
echo "$CFG10"
echo "$CFG9"
