# Deny all outbound traffic for all user apps
iptables -I OUTPUT -m owner --uid-owner 10000:99999 -j REJECT
echo "[Lockdown] Internet access blocked for all apps."
