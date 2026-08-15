# 🛡️ Cloud & Linux Infrastructure Security Lab

Repositori ini mendokumentasikan implementasi langsung (*hands-on*) pengamanan infrastruktur server Linux, analisis log ancaman, serta alur mitigasi dan respon insiden (*Incident Response*) berbasis standar NIST SP 800-61.

---

## 📌 Roadmap & Capaian Lab

| Modul | Fokus Materi | Tool / Perintah Kunci | Output / Artefak |
| :--- | :--- | :--- | :--- |
| **Week 1-2** | Hardening & Access Control | SSH Key-Only, UFW, Sudoers, File Permissions | Sistem tervaksinasi dari celah akses default |
| **Week 3** | Log Analysis & Threat Detection | `journalctl`, `rsyslog`, `grep`, `awk` | Skrip otomatis `detect_threats.sh` |
| **Week 4** | Incident Response & Remediation | `ss`, `kill` (SIGSTOP/SIGKILL), `passwd`, `usermod` | Skrip respon otomatis `incident_response.sh` |

---

## 🔄 Alur Respon Insiden (Incident Response Lifecycle)

```mermaid
flowchart TD
    A[MULAI: Notifikasi Indikasi Insiden] --> B[HARI 16: Initial Assessment / Triage]
    
    subgraph Triage ["1. Deteksi & Analisis Awal (Hari 16)"]
        B --> B1["Cek Koneksi Aktif: sudo ss -tulpn"]
        B --> B2["Cek Proses Mencurigakan: ps aux --sort=-%cpu"]
        B --> B3["Cek Sesi User Aktif: w / who"]
    end

    B --> C{Apakah Ada Ancaman Aktif?}
    C -- Tidak --> D["Dokumentasi & Monitor Normal"]
    C -- Ya --> E["HARI 17 & 18: Isolation / Containment"]

    subgraph Containment ["2. Isolasi Ancaman (Hari 17 & 18)"]
        E --> E1["Isolasi Proses (Hari 17)"]
        E1 --> E1a["Freeze Proses: kill -19 PID"]
        E1 --> E1b["Kill Paksa Proses: kill -9 PID"]
        
        E --> E2["Isolasi Jaringan (Hari 18)"]
        E2 --> E2a["Blokir IP Penyerang: sudo ufw deny from IP"]
    end

    E --> F["HARI 19: Eradication & Remediation"]

    subgraph Eradication ["3. Pembersihan & Penutupan Celah (Hari 19)"]
        F --> F1["Usir Sesi Penyerang: sudo pkill -u USER"]
        F --> F2["Kunci Password User: sudo passwd -l USER"]
        F --> F3["Cabut Akses Shell: sudo usermod -s /usr/sbin/nologin USER"]
    end

    F --> G["HARI 20: Otomatisasi & Dokumentasi"]

    subgraph Automation ["4. Respon Otomatis & Archiving (Hari 20)"]
        G --> G1["Jalankan Skrip: sudo ./incident_response.sh"]
        G2["Push Portofolio ke GitHub: git push"]
        G1 --> G2
    end

    G --> H[SELESAI: Penanganan Insiden Tuntas]
