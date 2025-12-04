# AlienTec-Recon-Tool
# AlienTec Recon PRO

Ein hochmodulares, professionelles Reconnaissance‑Toolkit für Pentester, Red Teamer und Security Researcher.

## 🚀 Features
- Vollständig modular (jeder Scan einzeln oder kombiniert)
- IPv4 & IPv6 Unterstützung
- Nmap Security Scans (Web, Vuln, Full TCP/UDP)
- Gobuster Directory Bruteforcing
- HTTP Header & Cookie Scans
- Automatische Log‑Ordner & Zeitstempel
- Fehlertolerant & farbige CLI‑Ausgabe
- Interner/Externer Modus wählbar
- Banner + Parameterhilfe direkt im CLI

---

## 📦 Installation
```bash
chmod +x recon.sh
```

Optionaler Auto‑Installer (wird später ins Skript eingebaut):
- prüft ob notwendige Tools existieren
- fragt **immer** vor Installation

---

## 🧠 Usage
```bash
./recon.sh --ip 192.168.1.50 --domain example.com --all
```

### 🏁 Parameter
| Flag           | Beschreibung                                  |
| -------------- | ---------------------------------------------- |
| --ip           | Ziel‑IPv4 Adresse (required)                   |
| --domain       | Ziel‑Domain (optional)                         |
| --ipv6         | IPv6 Scan aktivieren                           |
| --tcp          | Full TCP Scan                                  |
| --udp          | UDP Scan                                       |
| --headers      | HTTP Header Scan                               |
| --cookies      | Cookie Dump                                     |
| --gobuster     | Directory Bruteforce                           |
| --nikto        | Webserver‑Scan (optional Modul)                |
| --mode internal| Interner Pentest                               |
| --mode external| Externer Pentest                               |
| --skip-*       | Beliebige Module ausschließen                  |
| --all          | Alle Module ausführen                          |

---

## 🔥 Beispielkommandos

### Minimal
```bash
./recon.sh --ip 10.0.0.5
```

### Externer Web‑Pentest
```bash
./recon.sh --ip 8.8.8.8 --domain google.com --headers --cookies --gobuster
```

### Interner Host‑Security‑Scan
```bash
./recon.sh --ip 192.168.2.199 --tcp --udp --all
```

---

## 📁 Logs
Alle Scans werden automatisch gespeichert in:

```
logs/YYYY-MM-DD_HH-MM-SS/
```

---

## 🏁 Abschluss‑Report (wird am Ende angezeigt)
Beispiel:

```
[+] Nmap Web Scan Findings: 4 ✔
[+] Nmap Vuln Scan Findings: 2 ✔
[+] TCP Ports Open: 7 ✔
[+] UDP Ports Open: 3 ✔
[+] Gobuster Hits: 12 ✔
[+] Header Issues: 5 ✔
[+] Cookie Issues: 1 ✔

✔ AlienTec Recon PRO completed at 2025‑12‑04 23:51
Logfile saved in logs/2025-12-04_23-51/
```

---

## 🐉 Projektstatus
Aktive Weiterentwicklung · Pro‑Version · Community‑Friendly

---

## 📜 License
MIT License

