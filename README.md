# 🔒 Android Lockdown Mode — Magisk Module

A powerful system-level **Lockdown Mode** for rooted Android devices built as a Magisk module. Designed to **disable all non-essential apps**, **restrict hardware and network access**, and optionally enable **Universal GMS Doze**, **ad-blocking**, and **real-time malware monitoring**.

---

## 🚀 Features

- ✅ Disable all user-installed apps (except allowlisted ones)
- 🎤📷 Block microphone and camera access for all apps
- 📡 Disable Wi-Fi, mobile data, Bluetooth, NFC, and location
- 🌐 Optional: Force 2G-only network mode
- 🚫 Internet firewall using `iptables` (cut off all app network access)
- 🧠 Includes Universal GMS Doze module to reduce Google background drain
- 📛 Ad-blocking using community-sourced `hosts` file
- 🔍 Advanced malware/suspicious activity detection
- 🛡️ Root-based permission reversion (`revert` command)

---

## 📁 Folder Structure

lockdown/<br>
├── module.prop<br>
├── post-fs-data.sh<br>
├── service.sh<br>
├── uninstall.sh<br>
├── system.prop<br>
├── bin/<br>
│ └── lockdown # CLI control tool<br>
├── lockdown/<br>
│ ├── adblock.sh # Hosts-based adblock script<br>
│ ├── detect_malware.sh # Advanced malware detection<br>
│ └── gmsdoze/ # Embedded Universal GMS Doze module<br>
│ └── module.prop # (id=universal-gms-doze)<br>
└── system/<br>
│ └── etc/<br>
│   └── lockdown_allowlist.txt<br>


---

## ⚙️ CLI Usage

After installing the module, open a terminal and run:

su -c lockdown [command]
Command	        Description
enable	        Activates lockdown mode
disable        	Restores normal mode and permissions

🤝 Contributors Welcome!
We actively welcome developers, testers, and security researchers to contribute. If you have ideas for new detection methods, eBPF integrations, or UI controls — fork this repo and send us a pull request!

🙏 Credits
Special thanks to the developers of:

Universal GMS Doze
For their excellent work in optimizing Google services' power usage.

Membacfro
For their early contributions to permission enforcement and background process hardening.

Your work has helped this module evolve into a more complete privacy and lockdown solution.

🛡️ Disclaimer
This tool modifies system-level behavior. It is intended for advanced users with proper backups. Use at your own risk.
