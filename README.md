# AlienTec-Recon-Tool
# 👽 AlienTec Recon PRO

[![GitHub stars](https://img.shields.io/github/stars/YOUR_USERNAME/YOUR_REPO?style=social)](https://github.com/YOUR_USERNAME/YOUR_REPO/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/YOUR_USERNAME/YOUR_REPO?style=social)](https://github.com/YOUR_USERNAME/YOUR_REPO/network/members)
[![GitHub license](https://img.shields.io/github/license/YOUR_USERNAME/YOUR_REPO)](LICENSE)
---
 
<div align="center">
  <img src="recontools.png" width="400" alt="ultimative buffer">
 
</div>
---


---

## ⚡️ Übersicht

**AlienTec Recon PRO** ist ein **automatisches Bash-Skript** zur Durchführung von grundlegenden bis erweiterten **Aufklärungs- und Informationssammlungs-Scans** auf einem Zielsystem. Es nutzt leistungsstarke Tools wie **Nmap**, **Gobuster** und **Nikto**, um offene Ports, HTTP-Header, Cookies und mögliche Schwachstellen zu identifizieren.

Das Tool ist modular aufgebaut und bietet flexible Optionen, um genau die Scans durchzuführen, die Sie benötigen.

---

## 🛠️ Module & Funktionen

Das Skript kombiniert die Funktionen von Branchenstandards, um einen umfassenden Überblick über das Ziel zu erhalten.

| Modul | Beschreibung | Tool | Option | Emoji |
| :--- | :--- | :--- | :--- | :--- |
| **Basis Nmap** | Schneller Dienst- und Versionsscan. Standardmäßig immer aktiv, sofern nicht übersprungen. | `nmap -T4 -sV` | `--skip-nmap` | 🔍 |
| **Full TCP Scan** | Scannt alle **65535 TCP-Ports** für die umfassendste Portsicht. | `nmap -p-` | `--tcp` | 🌐 |
| **UDP Scan** | Scannt die Top **200 UDP-Ports** auf offene Dienste. | `nmap -sU --top-ports 200` | `--udp` | 📨 |
| **HTTP Headers** | Holt **HTTP-Header** der Ziel-Website (z.B. Servertyp, Richtlinien). | `curl -I` | `--headers` | 🛡️ |
| **Cookies Dump** | Extrahiert **Set-Cookie**-Header für Session- oder Tracking-Informationen. | `curl -s -I` | `--cookies` | 🍪 |
| **Directory Busting** | Führt **Brute-Force-Suche** nach gängigen Verzeichnissen und Dateien durch. | `gobuster dir` | `--gobuster` | 📁 |
| **Vulnerability Check** | Führt einen Webserver-Scan auf bekannte Schwachstellen und Konfigurationsfehler durch. | `nikto -h` | `--nikto` | 🚨 |

---

## 🚀 Installation & Voraussetzungen

Um AlienTec Recon PRO auszuführen, benötigen Sie folgende Tools auf Ihrem System (idealerweise Kali Linux, Parrot OS oder eine andere Pentesting-Distribution):

```bash
# Überprüfen Sie, ob Nmap, Gobuster und Nikto installiert sind
sudo apt update
sudo apt install nmap gobuster nikto -y
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

