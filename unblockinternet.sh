# Remove previously added iptables rule
iptables -D OUTPUT -m owner --uid-owner 10000:99999 -j REJECT
echo "[Lockdown] Internet access restored for all apps."
