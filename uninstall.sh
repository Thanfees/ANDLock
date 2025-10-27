#!/system/bin/sh
# Don't modify anything after this
if [ -f $INFO ]; then
  while read LINE; do
    if [ "$(echo -n $LINE | tail -c 1)" == "~" ]; then
      continue
    elif [ -f "$LINE~" ]; then
      mv -f $LINE~ $LINE
    else
      rm -f $LINE
      while true; do
        LINE=$(dirname $LINE)
        [ "$(ls -A $LINE 2>/dev/null)" ] && break 1 || rm -rf $LINE
      done
    fi
  done < $INFO
  rm -f $INFO
fi

## gms doze uninstall
# GMS components
GMS="com.google.android.gms"
GC1="auth.managed.admin.DeviceAdminReceiver"
GC2="mdm.receivers.MdmDeviceAdminReceiver"
NLL="/dev/null"

# Enable collective device administrators
for U in $(ls /data/user); do
for C in $GC1 $GC2 $GC3; do
pm enable --user $U "$GMS/$GMS.$C" &> $NLL
done
done

# Remove GMS from battery optimization
dumpsys deviceidle whitelist +com.google.android.gms &> $NLL

exit 0
)

# Remove all module files after un-installation
rm -rf /data/adb/universal-gms-doze
rm -rf /data/adb/modules/universal-gms-doze


# Magisk uninstall script for Lockdown Mode Module
# Cleans up flags, resets settings, and optionally re-enables apps/services.

LOCKDOWN_FLAG="/data/adb/modules/lockdown/.lockdown_enabled"
HOSTS_PATH="/system/etc/hosts"
BACKUP_HOSTS="/data/adb/modules/lockdown/backup_hosts"
ALLOWLIST="/system/etc/lockdown_allowlist.txt"

echo "[*] Removing Lockdown Mode settings..."

# Remove lockdown flag
if [ -f "$LOCKDOWN_FLAG" ]; then
    rm -f "$LOCKDOWN_FLAG"
    echo "[-] Lockdown flag removed"
fi

# Restore heads-up notifications
settings put global heads_up_notifications_enabled 1

# Re-enable mic and camera for all apps
pm list packages -3 | cut -d ":" -f 2 | while read pkg; do
    appops set "$pkg" CAMERA allow
    appops set "$pkg" RECORD_AUDIO allow
done

# Re-enable WiFi, data, Bluetooth
svc wifi enable
svc data enable
rfkill unblock all

# Restore preferred network mode (to default, e.g., 9 = LTE/WCDMA)
settings put global preferred_network_mode 9

# Restore location and NFC
settings put secure location_mode 3
settings put global nfc_on 1

# Re-enable previously disabled user apps
pm list packages -3 | cut -d ":" -f 2 | while read pkg; do
    if [ "$pkg" != "com.android.vending" ] && [ "$pkg" != "com.google.android.gms" ]; then
        pm enable "$pkg"
    fi
done

# Restore original hosts file if backup exists
if [ -f "$BACKUP_HOSTS" ]; then
    cp -f "$BACKUP_HOSTS" "$HOSTS_PATH"
    echo "[*] Restored original hosts file"
fi

# Clean up allowlist if necessary
if [ -f "$ALLOWLIST" ]; then
    rm -f "$ALLOWLIST"
    echo "[-] Removed lockdown allowlist"
fi

# Restore original hosts file if adblock was used
ORIGINAL_HOSTS="/data/adb/modules/lockdown/hosts.original"
if [ -f "$ORIGINAL_HOSTS" ]; then
    cp -f "$ORIGINAL_HOSTS" /system/etc/hosts
    echo "[*] Restored original /etc/hosts"
fi


echo "[*] Lockdown Module cleanup complete."
