# Cloud-Infra-Security-Lab
Hands-on labs and documentation for Cloud &amp; Infrastructure Security, including Linux Server Hardening, AWS IAM Auditing, and Automated Threat Monitoring.
# 🛡️ Linux Server Hardening & Network Security Lab

## 📌 Overview
Project ini mendokumentasikan langkah-langkah *hardening* (penguatan keamanan) pada sistem operasi Linux dan konfigurasi firewall jaringan berdasarkan prinsip **Principle of Least Privilege (PoLP)** dan **Zero Trust Architecture**.

---

## 🛠️ Key Implementations

### 1. User Management & Access Control (PoLP)
- Mengkonfigurasi hak akses file sensitif menggunakan permission `600` (`-rw-------`).
- Memverifikasi pembatasan akses user non-root (`auditor`) untuk mencegah eskalasi wewenang yang tidak sah.

![File Permissions](./02-file-permissions.png)

---

### 2. SSH Daemon Hardening
- Mengubah mekanisme autentikasi SSH menggunakan **Key-Based Authentication (RSA 4096-bit)**.
- Mencegah serangan *brute-force* dengan mematikan autentikasi password (`PasswordAuthentication no`).
- Mencegah akses langsung sebagai administrator (`PermitRootLogin no`).

![SSH Hardening](./03-ssh-hardening.png)

---

### 3. Network Control & Firewall (UFW)
- Menerapkan kebijakan *Default Deny Incoming* untuk memblokir seluruh lalu lintas masuk yang tidak dikenal.
- Membuka akses terbatas secara spesifik hanya pada port esensial: **Port 22 (SSH)**, **Port 80 (HTTP)**, dan **Port 443 (HTTPS)**.

![UFW Firewall](./04-ufw-firewall.png)

---

## 💻 Tech Stack & Tools
- **OS Target:** Parrot OS / Debian Linux
- **Virtualization:** Oracle VirtualBox
- **Security Tools:** UFW (Uncomplicated Firewall), OpenSSH Server, Linux ACL
