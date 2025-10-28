#!/system/bin/sh

MEMFRO_SRC="/data/adb/modules/lockdown/support_modules/MemBacFro"
MEMFRO_DEST="/data/adb/modules/MemBacFro"

# Deploy memory freezer support module if it is bundled but not yet active
if [ -d "$MEMFRO_SRC" ] && [ ! -d "$MEMFRO_DEST" ]; then
    cp -r "$MEMFRO_SRC" "$MEMFRO_DEST"
    chmod -R 755 "$MEMFRO_DEST"
    touch "$MEMFRO_DEST/update"
    echo "[Lockdown] Installed memory freezer module."
else
    echo "[Lockdown] memory freezer already present or source missing."
fi
