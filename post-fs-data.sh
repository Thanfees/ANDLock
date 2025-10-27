#!/system/bin/sh

# Define the embedded GMS Doze module path
GMS_SRC="/data/adb/modules/lockdown/support_modules/gmsdoze"
GMS_DEST="/data/adb/modules/universal-gms-doze"

# Check and install GMS Doze if not already present
if [ -d "$GMS_SRC" ] && [ ! -d "$GMS_DEST" ]; then
    cp -r "$GMS_SRC" "$GMS_DEST"
    chmod -R 755 "$GMS_DEST"
    touch "$GMS_DEST/update"
    echo "[Lockdown] Installed embedded Universal GMS Doze module."
else
    echo "[Lockdown] GMS Doze already present or source missing."
fi

MEMFRO_SRC="/data/adb/modules/lockdown/support_modules/MemBacFro"
MEMFRO_DEST="/data/adb/modules/MemBacFro"

# Check and install GMS Doze if not already present
if [ -d "$MEMFRO_SRC" ] && [ ! -d "$MEMFRO_DEST" ]; then
    cp -r "$MEMFRO_SRC" "$MEMFRO_DEST"
    chmod -R 755 "$MEMFRO_DEST"
    touch "$MEMFRO_DEST/update"
    echo "[Lockdown] Installed memory freezer module."
else
    echo "[Lockdown] memory freezer already present or source missing."
fi
