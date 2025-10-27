 pm list packages | cut -d ":" -f 2 | while read pkg; do
        appops set "$pkg" CAMERA allow
        echo "[Permited] $pkg (camera)"
        done