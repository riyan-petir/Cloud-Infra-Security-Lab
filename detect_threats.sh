#!/bin/bash

echo "=================================================="
echo "       AUTOMATED THREAT DETECTION MONITOR        "
echo "=================================================="
echo ""

# 1. Cek Percobaan Login SSH Gagal
echo "[+] Checking for SSH Invalid User Attempts..."
SSH_FAILS=$(journalctl -u ssh 2>/dev/null | grep -iE "Invalid user|Failed password" | awk '{print $(NF-2)}' | sort | uniq -c | sort -nr)

if [ -z "$SSH_FAILS" ]; then
    echo "   [OK] No SSH brute force attempts detected."
else
    echo "   [ALERT] SSH Threat Detected!"
    echo "$SSH_FAILS"
fi

echo ""
# 2. Cek Percobaan Sudo Gagal
echo "[+] Checking for Failed Sudo Attempts..."
SUDO_FAILS=$(journalctl _COMM=sudo 2>/dev/null | grep -iE "incorrect|failed" | wc -l)

if [ "$SUDO_FAILS" -gt 0 ]; then
    echo "   [ALERT] Detected $SUDO_FAILS failed sudo attempt(s)!"
else
    echo "   [OK] No failed sudo attempts detected."
fi

echo ""
echo "=================================================="
