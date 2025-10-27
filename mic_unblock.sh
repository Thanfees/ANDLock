 pm list packages | cut -d ":" -f 2 | while read pkg; do
        appops set "$pkg" RECORD_AUDIO allow
        echo "[Permited] $pkg (mic)"
        done