#!/bin/bash

echo "=================================================="
echo "       AUTOMATED INCIDENT RESPONSE TOOL          "
echo "=================================================="
echo ""

# Cek apakah skrip dijalankan sebagai root / sudo
if [ "$EUID" -ne 0 ]; then
  echo "[!] Harap jalankan skrip ini menggunakan sudo!"
  exit 1
fi

# 1. Isolasi Jaringan (Blokir IP)
read -p "[?] Masukkan IP Penyerang yang ingin diblokir (kosongkan jika tidak ada): " TARGET_IP
if [ -n "$TARGET_IP" ]; then
    ufw deny from "$TARGET_IP" to any >/dev/null 2>&1
    echo "[+] [SUCCESS] IP $TARGET_IP berhasil diblokir di UFW Firewall."
fi

# 2. Hentikan Proses Bahaya (Kill PID)
read -p "[?] Masukkan PID Proses yang ingin dibunuh (kosongkan jika tidak ada): " TARGET_PID
if [ -n "$TARGET_PID" ]; then
    kill -9 "$TARGET_PID" >/dev/null 2>&1
    echo "[+] [SUCCESS] Proses dengan PID $TARGET_PID berhasil dibunuh."
fi

# 3. Kunci Akun User Terinfeksi
read -p "[?] Masukkan Username yang ingin dikunci (kosongkan jika tidak ada): " TARGET_USER
if [ -n "$TARGET_USER" ]; then
    passwd -l "$TARGET_USER" >/dev/null 2>&1
    pkill -u "$TARGET_USER" >/dev/null 2>&1
    usermod -s /usr/sbin/nologin "$TARGET_USER" >/dev/null 2>&1
    echo "[+] [SUCCESS] Akun $TARGET_USER berhasil dikunci & akses shell dicabut."
fi

echo ""
echo "=================================================="
echo "       REMEDIATION PROCESS COMPLETED              "
echo "=================================================="
