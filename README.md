# 🔒 Android Lockdown Mode (ANDLock)— Magisk Module

A powerful system-level **Lockdown Mode** for rooted Android devices built as a Magisk module. Designed to **disable all non-essential apps**, **restrict hardware and network access**, and optionally enable **ad-blocking** and **real-time malware monitoring**.

---

## 🚀 Features

- ✅ Disable all user-installed apps (except allowlisted ones)
- 🎤📷 Block microphone and camera access for all apps
- 📡 Disable Wi-Fi, mobile data, Bluetooth, NFC, and location
- 🌐 Optional: Force 2G-only network mode
- 🚫 Internet firewall using `iptables` (cut off all app network access)
- 📛 Ad-blocking using community-sourced `hosts` file
- 🔍 Malware & suspicious activity detection with on-device heuristics
- 🛡️ Root-based permission reversion (`revert` command)

---

## 📁 Folder Structure

```
.
├── module.prop               # Magisk module metadata
├── post-fs-data.sh           # Startup script for early boot tweaks
├── service.sh                # Main service loop for lockdown enforcement
├── uninstall.sh              # Cleanup logic when the module is removed
├── adblock.sh                # Hosts-based adblocking helper
├── blockinternet.sh          # Globally revoke network access
├── unblockinternet.sh        # Restore network access
├── cam_block.sh              # Disable camera HAL access
├── cam_unblock.sh            # Restore camera access
├── mic_block.sh              # Disable microphone input
├── mic_unblock.sh            # Restore microphone input
├── detect_malware.sh         # Heuristic malware / anomaly scanner
├── META-INF/                 # Magisk packaging metadata
│   └── com/google/android/ {update-binary, updater-script}
├── support_modules/
│   └── MemBacFro/            # Bundled dependency for permission hardening
│       ├── install.sh
│       ├── module.prop
│       ├── common/system.prop
│       └── META-INF/com/google/android/ {update-binary, updater-script}
└── system/
    ├── bin/lockdown          # CLI entrypoint exposed to `/system/bin`
    ├── etc/lockdown_allowlist.txt
    └── placeholder           # Ensures `/system` folder packaged correctly
```


---

## ⚙️ CLI Usage

After installing the module, open a terminal and run:

su -c lockdown [command]
Command	        Description
enable	        Activates lockdown mode
disable        	Restores normal mode and permissions

### Malware / Suspicious Activity Scan

- Every time lockdown mode starts, `detect_malware.sh` runs a heuristic scan against installed apps and running tooling commonly abused by malware.
- Findings are written to `/data/adb/modules/lockdown/logs/malware_scan.log`; review this file for severity, matched indicators, and follow-up actions.
- If nothing is flagged, the scan still records a timestamped entry confirming a clean result.

🤝 Contributors Welcome!
We actively welcome developers, testers, and security researchers to contribute. If you have ideas for new detection methods, eBPF integrations, or UI controls — fork this repo and send us a pull request!

🙏 Credits
Special thanks to the developers of:

Membacfro
For their early contributions to permission enforcement and background process hardening.

Your work has helped this module evolve into a more complete privacy and lockdown solution.

🛡️ Disclaimer
This tool modifies system-level behavior. It is intended for advanced users with proper backups. Use at your own risk.
