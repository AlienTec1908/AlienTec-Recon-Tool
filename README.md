# AlienTec Recon-Tool

<h3>Do you like AlienTec Recon? Give the project a star to support its development!</h3>

[[GitHub stars](https://img.shields.io/github/stars/AlienTec1908/AlienTec-Recon-Tool?style=social)](https://github.com/AlienTec1908/AlienTec-IQхɝ̤)mm!Ոɭt輽̹͡ѡՈɭ̽QQIQ屔ͽt輽ѡՈQQIQݽɬ̤)mm!Ո͕t輽̹͡ѡՈ͔QQIQt1%
9M(((񍱅􉍕ѕȈ(񥵜Ɍɕѽ̹ݥѠձѥєI((𽍱((=ٕ٥((QIQ́ѽѕ	͍͠ɥШȁəɵͥѼمɕͅɵѥѡɥ̨͍хɝЁѕ%ЁٕɅ́ݕəհѽ́9ѕȨ9ѼѼѥ䁽̰!QQ@̰̰tential vulnerabilities.

The tool is designed to be modular, offering flexible options to run exactly the scans you need.

---

<h3>Your Support Makes a Difference</h3>

Thanks for using the AlienTec Recon-Tool! This is a passion project and will always be available as a free, open-source version.

However, its development, maintenance, and the addition of new features take a lot of time. If you find value in this tool, please consider supporting the project. Your support directly funds development and also accelerates the work on the planned Pro version.

No matter how you support - with a small contribution or a star for the repository - thank you for your support!

**[Become a Supporter now via GitHub Sponsors](https://github.com/sponsors/AlienTec1908)*2*---

## Modules & Features

The script combines the capabilities of industry-standard tools to provide a comprehensive overview of the target.

| Module | Description | Tool | Option |
 | :--- | :--- | :--- | :--- |
| **Basic Nmap**| Fast service and version scan. Always active by default unless skipped. | `nmap -T4 -sV` | `--skip-nmap` |
| **Full TCP Scan**| Scans all **65535 TCP ports** for the most comprehensive port overview. | `nmap -p-` | `--tcp` |
| **UDP Scan**| Scans the top **200 UdP port** for open services. | `nmap -sU --top-ports 200` | `--udp` |
| **HTTP Headers**| Fetches **HTTP headers** from the target website (e.g., server type, policies). | `curl -I` | `--headers` |
| **Cookies Dump**| Extracts **Set-Cookie** headers for session or tracking information. | `curl -s -I` | `--cookies` |
| **Directory Busting**| Performs a **brute-force search** for common directories and files. | `gobuster dir` | `--gobuster` |
| **Vulnerability Check**| Runs a web server scan for known vulnerabilities and misconfigurations. | `nikto -h` | `--nikto` |

---

## Prerequisites

To run the AlienTec Recon Tool, you need the following tools on your system (ideally Kali Linux, Parrot OS, or another pentesting distribution):
```bash
# Check if Nmap, Gobuster, and Nikto are installed
sudo apt update
sudo apt install nmap gobuster nikto -y
```

A highly modular, professional reconnaissance toolkit for pentesters, red teamers, and security researchers.

## Features
- Fully modular (run each scan individually or combined)
- IPv4& IPv6 support
- Nmap Security Scans (Web, Vuln, Full TCP/UDP)
- Gobuster Directory Bruteforcing
- HTTP Header & Cookie Scans
- Automatic log folders & timestamps
- Fault-tolerant & colored CLI output
- Selectable Internal/External mode
- Banner + parameter help directly in the CLI

---

## Installation
```bash
chmod +x recon.sh
```

Optional Auto-Installer (to be integrated into the script later):
- checks if necessary tools exist
- **always asks** before  installation

---

## Usage
```./recon.sh --ip 192.168.1.50 --domain example.com --all```

### Parameters
| Flag | Description |
 | :--- | :--- |
| `--ip` | Target IPv4 address (required) |
| `--domain` | Target domain (optional) |
| `--ipv6` | Enable IPv6 scan |
| `--tcp` | Full TCP Scan |
| `--udp` | UDP Scan |
| `--headers` | HTTP Header Scan |
| `--cookies` | Cookie Dump |
| `--gobuster` | Directory Bruteforce |
| `--nikto` | Web server scan (optional module) |
| `--mode internal` | Internal Pentest |
| `--mode external` | External Pentest |
| `--skip-*` | Exclude any module |
| `--all` | Execute all modules |

---

## Example Commands

### Minimal
```./recon.sh --ip 10.0.0.5```@

### External Web-Pentest
```./recon.sh  --ip 8.8.8.8 --domain google.com --headers --cookies --gobuster
```

### Internal Host-Security-Scan
```./recon.sh --ip 192.168.2.199 --tcp --udp --all
```

---

## Logs
All scans are automatically saved in:

`b
logs/YYYY-MM-DD_HH-MM-SS/
```

---

## Final Report (displayed at the end)

Example:
```
[+] Nmap Web Scan Findings: 4 ❦
+] Nmap Vuln Scan Findings: 2 ❦
[+] TCP Ports Open: 7 ➦
+] UDP Ports Open: 3 ❦
+] Gobuster Hits: 12 ❦
[+] Header Issues: 5 ❦
+] Cookie Issues: 1 ➦

㝦AlienTec Recon Tool completed at 2025-12-04 23:51
Logfile saved in logs/2025-12-04_23-50/
```

---
## Project Status
Active Development ° Pro version in progress »0Community-Friendly

---

## License
MIT License
