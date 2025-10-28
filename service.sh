#!/system/bin/sh

LOCKDOWN_FLAG="/data/adb/modules/lockdown/.lockdown_enabled"
ALLOWLIST="/system/etc/lockdown_allowlist.txt"
ADB_MODULE_DIR="/data/adb/modules/lockdown"

echo "[Lockdown] Starting Lockdown Mode..."

# Check if lockdown is enabled
if [ ! -f "$LOCKDOWN_FLAG" ]; then
    echo "[Lockdown] Lockdown flag not set. Exiting."
    exit 0
fi

# Step 0: Run malware / suspicious activity scan
if [ -f "$ADB_MODULE_DIR/detect_malware.sh" ]; then
    sh "$ADB_MODULE_DIR/detect_malware.sh"
else
    echo "[Warning] detect_malware.sh not found in module directory"
fi

# Step 1: Disable non-allowlisted third-party apps
echo "[Lockdown] Disabling third-party apps..."
pm list packages -3 | cut -d ":" -f 2 | while read pkg; do
    if ! grep -q "$pkg" "$ALLOWLIST"; then
        pm disable "$pkg"
        echo "[App Disabled] $pkg"
    fi
done

# Step 2: Deny mic and camera access
pm list packages | cut -d ":" -f 2 | while read pkg; do
    appops set "$pkg" CAMERA deny
    appops set "$pkg" RECORD_AUDIO deny
    echo "[Restricted] $pkg (camera + mic)"
done

# Step 3: Force-stop non-allowlisted services
echo "[Lockdown] Force stopping background services..."
if [ -f "$ALLOWLIST" ]; then
    dumpsys activity services | grep "packageName=" | cut -d'=' -f2 | cut -d' ' -f1 | while read service; do
        if ! grep -q "$service" "$ALLOWLIST"; then
            am force-stop "$service" >/dev/null 2>&1
            echo "[Service Stopped] $service"
        fi
    done
else
    echo "[Warning] Allowlist file not found at $ALLOWLIST"
fi

# Step 4: UI and hardware restrictions
echo "[Lockdown] Applying system restrictions..."
settings put global heads_up_notifications_enabled 0
settings put global preferred_network_mode 1 && echo "[✓] Forced 2G mode"
settings put secure location_mode 0 && echo "[✓] Location disabled"
settings put global nfc_on 0 && echo "[✓] NFC disabled"


# Step 5: Apply ad-blocking
echo "[Lockdown] Applying ad-blocking hosts file..."
if [ -f "$ADB_MODULE_DIR/adblock.sh" ]; then
    sh "$ADB_MODULE_DIR/adblock.sh"
else
    echo "[Warning] adblock.sh not found in module directory"
fi

echo "[✓] Lockdown Mode ENABLED successfully"
echo "[✓] Lockdown Mode script completed"
