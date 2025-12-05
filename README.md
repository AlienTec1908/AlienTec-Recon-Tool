    
# 👽 AlienTec Recon PRO

[![GitHub stars](https://img.shields.io/github/stars/AlienTec1908/AlienTec-Recon-Tool?style=social)](https://github.com/AlienTec1908/AlienTec-Recon-Tool/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/AlienTec1908/AlienTec-Recon-Tool?style=social)](https://github.com/AlienTec1908/AlienTec-Recon-Tool/network/members)
[![GitHub license](https://img.shields.io/github/license/AlienTec1908/AlienTec-Recon-Tool)](LICENSE)

<div align="center">
  
  <!-- TIPP: Ersetze das Bild durch ein GIF, das dein Skript in Aktion zeigt! -->
  <img src="recontools.png" width="500" alt="AlienTec Recon PRO Banner">
 
</div>

---

AlienTec Recon PRO ist dein Schweizer Taschenmesser für die Netzwerkaufklärung. Es bündelt die Power von **Nmap**, **Gobuster** und **Nikto** in einem einzigen, einfach zu bedienenden Bash-Skript. Starte umfassende Scans mit nur einem Befehl und erhalte alle Ergebnisse sauber und automatisch in Log-Dateien gespeichert.

---

## 🚀 Quick Start (Installation in 30 Sekunden)

Du benötigst `nmap`, `gobuster` und `nikto`. Das Skript prüft automatisch, ob sie vorhanden sind.

```bash
# 1. Klone das Repository
git clone https://github.com/AlienTec1908/AlienTec-Recon-Tool.git

# 2. Wechsle in das Verzeichnis
cd AlienTec-Recon-Tool

# 3. Mach das Skript ausführbar
chmod +x recon.sh

# 4. Starte deinen ersten Scan!
./recon.sh --ip 10.0.0.5 --all```

---

## 🛠️ Features & Module

Das Skript ist modular aufgebaut. Wähle genau die Scans, die du brauchst.

| Modul | Beschreibung | Tool | Option | Emoji |
| :--- | :--- | :--- | :--- | :--- |
| **Basis Nmap** | Schneller Scan auf offene Ports, Dienste und Versionen. | `nmap` | (Standard) | 🔍 |
| **Full TCP Scan** | Scannt **alle 65535 TCP-Ports** für eine lückenlose Analyse. | `nmap` | `--tcp` | 🌐 |
| **UDP Scan** | Scannt die Top **200 UDP-Ports** auf offene Dienste. | `nmap` | `--udp` | 📨 |
| **HTTP Headers** | Holt **HTTP-Header** (z.B. Servertyp, Security Policies). | `curl` | `--headers` | 🛡️ |
| **Cookies Dump** | Extrahiert gesetzte **Cookies** für Session-Informationen. | `curl` | `--cookies` | 🍪 |
| **Directory Busting** | Sucht per Brute-Force nach versteckten Verzeichnissen und Dateien. | `gobuster` | `--gobuster` | 📁 |
| **Vulnerability Check** | Scannt den Webserver auf bekannte Schwachstellen (z.B. veraltete Software). | `nikto` | `--nikto` | 🚨 |

---

## 🧠 Usage & Parameter

Die grundlegende Syntax lautet:

```bash
./recon.sh --ip <Ziel-IP> [Optionen]

  

🏁 Alle Parameter
Flag	Beschreibung	Erforderlich?
--ip <addr>	Ziel‑IPv4 Adresse	Ja
--domain <domain>	Ziel‑Domain (für einige Scans nützlich)	Nein
--ipv6	Aktiviert den IPv6 Scan-Modus	Nein
--all	Führt alle verfügbaren Module aus	Nein
--tcp	Führt den vollständigen TCP-Portscan durch	Nein
--udp	Führt den UDP-Scan durch	Nein
--headers	Führt den HTTP-Header-Scan durch	Nein
--cookies	Führt den Cookie-Dump durch	Nein
--gobuster	Startet den Directory Brute-Force	Nein
--nikto	Startet den Nikto Web-Schwachstellenscan	Nein
--skip-nmap	Überspringt alle Nmap-basierten Scans	Nein
--skip-gobuster	Überspringt den Gobuster-Scan	Nein
--skip-nikto	Überspringt den Nikto-Scan	Nein
--skip-curl	Überspringt alle Curl-basierten Scans (Headers, Cookies)	Nein
--mode <mode>	internal oder external (zukünftige Funktion)	Nein
🔥 Beispiel-Kommandos
Minimaler Scan

Ein schneller Basis-Scan auf offene Ports und Dienste.
 Bash

    
./recon.sh --ip 10.0.0.5

  

Umfassender Web-Pentest

Alles, was man für einen externen Webserver-Check braucht.
 Bash

    
./recon.sh --ip 8.8.8.8 --domain google.com --headers --cookies --gobuster --nikto

  

Interner All-in-One Scan

Ein tiefer Scan eines Hosts im internen Netzwerk.
code Bash

    
./recon.sh --ip 192.168.2.199 --all

  

📁 Output & Logging

Alle Scan-Ergebnisse werden automatisch in einem eigenen Ordner mit Zeitstempel gespeichert, damit du nichts verlierst.

Speicherort:
 

    
logs/
└── basic_nmap.txt
└── full_tcp.txt
└── gobuster.txt
└── ...

  

Am Ende jedes Laufs erhältst du eine saubere Zusammenfassung direkt im Terminal:

Beispiel-Report:
code Bash

    
==============================================
 AlienTec Recon PRO – Summary
==============================================
Basic Scan Ports: 7
Full TCP Scan:    7
UDP Scan:         3
Headers:          10
Cookies:          1
Gobuster:         25
Nikto:            42

✔ AlienTec Recon PRO completed.
==============================================

  

📜 License

Dieses Projekt ist unter der MIT License lizenziert. Siehe die LICENSE-Datei für Details.
code Code
