pm list packages | cut -d ":" -f 2 | while read pkg; do
    appops set "$pkg" CAMERA deny
    echo "[Restricted] $pkg (camera)"
done