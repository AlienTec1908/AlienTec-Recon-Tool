# AlienTec 👽 Recon-Tool

<h3>Do you like AlienTec Recon? Give the project a star ⭐ to support its development!</h3>

[![GitHub stars](https://img.shields.io/github/stars/AlienTec1908/AlienTec-Recon-Tool?style=social)](https://github.com/AlienTec1908/AlienTec-Recon-Tool/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/AlienTec1908/AlienTec-Recon-Tool?style=social)](https://github.com/AlienTec1908/AlienTec-Recon-Tool/network/members)
[![GitHub license](https://img.shields.io/github/license/AlienTec1908/AlienTec-Recon-Tool)](LICENSE)
---
 
<div align="center">
  <img src="recontools.png" width="400" alt="ultimate Recon">
 
</div>


## ⚡️ Overview

**AlienTec Recon Tool** is an **automated Bash script** for performing basic to advanced **reconnaissance and information gathering scans** on a target system. It leverages powerful tools like **Nmap**, **Gobuster**, and **Nikto** to identify open ports, HTTP headers, cookies, and potential vulnerabilities.

The tool is designed to be modular, offering flexible options to run exactly the scans you need.

---

## 🛠️ Modules & Features

The script combines the capabilities of industry-standard tools to provide a comprehensive overview of the target.

| Module | Description | Tool | Option | Emoji |
| :--- | :--- | :--- | :--- | :--- |
| **Basic Nmap** | Fast service and version scan. Always active by default unless skipped. | `nmap -T4 -sV` | `--skip-nmap` | 🔍 |
| **Full TCP Scan**| Scans all **65535 TCP ports** for the most comprehensive port overview. | `nmap -p-` | `--tcp` | 🌐 |
| **UDP Scan** | Scans the top **200 UDP ports** for open services. | `nmap -sU --top-ports 200` | `--udp` | 📨 |
| **HTTP Headers** | Fetches **HTTP headers** from the target website (e.g., server type, policies). | `curl -I` | `--headers` | 🛡️ |
| **Cookies Dump** | Extracts **Set-Cookie** headers for session or tracking information. | `curl -s -I` | `--cookies` | 🍪 |
| **Directory Busting**| Performs a **brute-force search** for common directories and files. | `gobuster dir` | `--gobuster` | 📁 |
| **Vulnerability Check** | Runs a web server scan for known vulnerabilities and misconfigurations. | `nikto -h` | `--nikto` | 🚨 |

---

    
## 🚀 Prerequisites

To run the AlienTec Recon Tool, you need the following tools on your system (ideally Kali Linux, Parrot OS, or another pentesting distribution):

```bash
# Check if Nmap, Gobuster, and Nikto are installed
sudo apt update
sudo apt install nmap gobuster nikto -y

---

```markdown
A highly modular, professional reconnaissance toolkit for pentesters, red teamers, and security researchers.

## 🚀 Features
- Fully modular (run each scan individually or combined)
- IPv4 & IPv6 support
- Nmap Security Scans (Web, Vuln, Full TCP/UDP)
- Gobuster Directory Bruteforcing
- HTTP Header & Cookie Scans
- Automatic log folders & timestamps
- Fault-tolerant & colored CLI output
- Selectable Internal/External mode
- Banner + parameter help directly in the CLI

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

✔ AlienTec Recon Tool completed at 2025‑12‑04 23:51
Logfile saved in logs/2025-12-04_23-51/
```

---
---
### ❤️ Deine Unterstützung macht den Unterschied

Schön, dass du das AlienTec Recon-Tool nutzt! Dieses Projekt ist aus Leidenschaft entstanden und wird immer als kostenlose Open-Source-Version zur Verfügung stehen.

Die Entwicklung, Pflege und der Ausbau mit neuen Features kosten allerdings viel Zeit. Wenn du also einen Mehrwert aus dem Tool ziehst, ziehe bitte in Erwägung, das Projekt zu unterstützen. Dein Support fließt direkt in die Weiterentwicklung und beschleunigt auch die Arbeit an der geplanten Pro-Version.

Ganz egal, wie du supportest – ob mit einem kleinen Beitrag oder einem Stern ⭐ für das Repository – ich danke dir für deinen Support, Bruder!

**[➡️ Werde jetzt zum Supporter via GitHub Sponsors](https://github.com/sponsors/AlienTec1908)**
---
## 🐉 Projektstatus
Aktive Weiterentwicklung · an einer Pro‑Version · Community‑Friendly

---

## 📜 License
MIT License
