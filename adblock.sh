#!/system/bin/sh

ORIGINAL_HOSTS="/data/adb/modules/lockdown/hosts.original"
ADBLOCK_HOSTS="/data/adb/modules/lockdown/hosts.adblock"

# Backup original hosts if not already done
if [ ! -f "$ORIGINAL_HOSTS" ]; then
    cp /system/etc/hosts "$ORIGINAL_HOSTS"
fi

# Download adblock hosts file if not already downloaded
if [ ! -f "$ADBLOCK_HOSTS" ]; then
    curl -s -L -o "$ADBLOCK_HOSTS" "https://o0.pages.dev/Pro/hosts.txt"
fi

# Bind the adblock hosts file to /system/etc/hosts
mount -o bind "$ADBLOCK_HOSTS" /system/etc/hosts

echo "[✓] Ad-blocking hosts file applied."
