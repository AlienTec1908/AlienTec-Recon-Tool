#!/bin/bash

# ===== Colors =====
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
BLUE="\e[34m"
RESET="\e[0m"

# ===== Banner =====
clear
echo -e "${BLUE}
 █████╗ ██╗     ██╗███████╗███╗  ██╗████████╗███████╗ ██████╗ 
██╔══██╗██║     ██║██╔════╝████╗ ██║╚══██╔══╝██╔════╝██╔═══██╗
███████║██║     ██║█████╗  ██╔██╗██║   ██║   █████╗  ██║     
██╔══██║██║     ██║██╔══╝  ██║╚██╗██║   ██║   ██╔══╝  ██║  ██║
██║  ██║███████╗██║███████╗██║ ╚████║   ██║   ███████╗╚██████╔╝
╚═╝  ╚═╝╚══════╝╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝ ╚═════╝ 
                      AlienTec Recon PRO${RESET}
"

# ============================================================
# VARIABLES
# ============================================================

TARGET_IP=""
TARGET_DOMAIN=""
SCAN_MODE="external"
IPV6_MODE=false

RUN_TCP=false
RUN_UDP=false
RUN_HEADERS=false
RUN_COOKIES=false
RUN_GOBUSTER=false
RUN_NIKTO=false

SKIP_NMAP=false
SKIP_GOBUSTER=false
SKIP_NIKTO=false
SKIP_CURL=false

RUN_ALL=false

# ============================================================
# USAGE
# ============================================================

usage() {
  echo "AlienTec Recon PRO – Usage"
  echo "-----------------------------------------"
  echo "./recon.sh --ip <target> [options]"
  echo ""
  echo "Required:"
  echo "  --ip <addr>             IPv4 Adresse"
  echo ""
  echo "Optional:"
  echo "  --domain <domain>       Ziel-Domain"
  echo "  --ipv6                  IPv6 Scan aktivieren"
  echo "  --mode internal|external  Pentest Mode"
  echo "  --all                   Alle Module"
  echo "  --tcp                   Full TCP Scan"
  echo "  --udp                   UDP Scan"
  echo "  --headers               HTTP Header Scan"
  echo "  --cookies               Cookie Dump"
  echo "  --gobuster              Directory Bruteforce"
  echo "  --nikto                 Nikto Scan"
  echo "  --skip-nmap             Nmap überspringen"
  echo "  --skip-gobuster         Gobuster überspringen"
  echo "  --skip-nikto            Nikto überspringen"
  echo "  --skip-curl             HTTP Module überspringen"
  echo "  --help                  Diese Hilfe"
  echo ""
  exit 1
}

# ============================================================
# ARGUMENT PARSER
# ============================================================

while [[ $# -gt 0 ]]; do
  case "$1" in
    --help) usage ;;
    --ip) TARGET_IP="$2"; shift ;;
    --domain) TARGET_DOMAIN="$2"; shift ;;
    --ipv6) IPV6_MODE=true ;;
    --mode) SCAN_MODE="$2"; shift ;;
    --tcp) RUN_TCP=true ;;
    --udp) RUN_UDP=true ;;
    --headers) RUN_HEADERS=true ;;
    --cookies) RUN_COOKIES=true ;;
    --gobuster) RUN_GOBUSTER=true ;;
    --nikto) RUN_NIKTO=true ;;
    --skip-nmap) SKIP_NMAP=true ;;
    --skip-gobuster) SKIP_GOBUSTER=true ;;
    --skip-nikto) SKIP_NIKTO=true ;;
    --skip-curl) SKIP_CURL=true ;;
    --all) RUN_ALL=true ;;
  esac
  shift
done

# Map ALL → all flags
if [[ "$RUN_ALL" == true ]]; then
  RUN_TCP=true
  RUN_UDP=true
  RUN_HEADERS=true
  RUN_COOKIES=true
  RUN_GOBUSTER=true
  RUN_NIKTO=true
fi

[[ -z "$TARGET_IP" ]] && usage

LOGDIR="logs"
mkdir -p "$LOGDIR"

echo -e "[+] Starting AlienTec Recon PRO..."
echo "Mode: $SCAN_MODE"
echo "Target IP: $TARGET_IP"

# ============================================================
# MODULE DEFINITIONS
# ============================================================

# ---- BASIC NMAP (only port numbers)
run_basic_nmap() {
  echo
  echo "============================================================"
  echo " NMAP SCAN (Basic Ports)"
  echo "============================================================"
  echo
  echo -e "${YELLOW}[+] Running Basic Nmap (only port numbers)...${RESET}"
  
  # 🛠️ Korrigiert: Nutzt tee /dev/tty, um die Statusmeldungen im Terminal anzuzeigen
  # 2>&1 leitet STDERR zu STDOUT, tee dupliziert alles an /dev/tty, 
  # dann wird es gefiltert und in die Datei geschrieben.
  nmap -p- --open -T4 "$TARGET_IP" 2>&1 | tee /dev/tty | grep -Eo '^[0-9]+' > basic_nmap.txt
}

# ---- FULL TCP NMAP (complete detail)
run_full_tcp_scan() {
  echo
  echo "============================================================"
  echo " NMAP SCAN (Full TCP & OS/Service)"
  echo "============================================================"
  echo
  echo -e "${YELLOW}[+] Full TCP Scan...${RESET}"
  
  # 🛠️ Korrigiert: Nutzt tee /dev/tty für vollständige Ausgabe in Konsole und Datei
  nmap -p- -sV -sC -O -T4 "$TARGET_IP" 2>&1 | tee /dev/tty | grep -v 'Starting Nmap' > full_tcp.txt
}

# ---- UDP SCAN
run_udp_scan() {
  echo
  echo "============================================================"
  echo " UDP SCAN"
  echo "============================================================"
  echo
  echo -e "${YELLOW}[+] UDP Scan...${RESET}"
  
  # 🛠️ Korrigiert: Nutzt tee /dev/tty für vollständige Ausgabe in Konsole und Datei
  nmap -sU --top-ports 200 "$TARGET_IP" 2>&1 | tee /dev/tty | grep -v 'Starting Nmap' > udp_scan.txt
}

# ---- HTTP HEADERS
run_headers() {
  echo
  echo "============================================================"
  echo " HTTP HEADER SCAN"
  echo "============================================================"
  echo
  echo -e "${YELLOW}[+] Fetching HTTP headers (Port 80)...${RESET}"
  
  # Korrigiert: 2>&1 leitet STDERR zu STDOUT um.
  curl -I "http://$TARGET_IP" 2>&1 | tee /dev/tty | grep -E '^< |^>' | grep -v 'Host: ' > headers.txt
}

# ---- COOKIES DUMP
run_cookies() {
  echo
  echo "============================================================"
  echo " COOKIE DUMP"
  echo "============================================================"
  echo
  echo -e "${YELLOW}[+] Fetching cookies (Port 80)...${RESET}"
  
  # Korrigiert: 2>&1 hinzugefügt, um Header zuverlässiger zu erfassen.
  curl -s -I "http://$TARGET_IP" 2>&1 | tee /dev/tty | grep -i set-cookie > cookies.txt
}

# ---- GOBUSTER (Directory Bruteforce)
run_gobuster() {
  echo
  echo "============================================================"
  echo " DIRECTORY BRUTEFORCE (GOBUSTER)"
  echo "============================================================"
  echo
  echo -e "${YELLOW}[+] Running Gobuster...${RESET}"
  
  # 🛠️ Korrigiert: Nutzt tee /dev/tty für vollständige Ausgabe in Konsole und Datei
  gobuster dir -u "http://$TARGET_IP" -w /usr/share/wordlists/dirb/common.txt 2>&1 | tee /dev/tty | grep -v 'Starting gobuster' > gobuster.txt
}

# ---- NIKTO SCAN
run_nikto() {
  echo
  echo "============================================================"
  echo " NIKTO SCAN"
  echo "============================================================"
  echo
  echo -e "${YELLOW}[+] Running Nikto...${RESET}"
  
  # 🛠️ Korrigiert: Nutzt tee /dev/tty für vollständige Ausgabe in Konsole und Datei
  nikto -h "$TARGET_IP" 2>&1 | tee /dev/tty | grep -v 'Running Nikto' > nikto.txt
}

# ============================================================
# EXECUTION FLOW
# ============================================================

# BASIC always (unless skipped)
if [[ "$SKIP_NMAP" != true ]]; then
  run_basic_nmap
fi

[[ "$RUN_TCP" == true ]] && [[ "$SKIP_NMAP" != true ]] && run_full_tcp_scan
[[ "$RUN_UDP" == true ]] && [[ "$SKIP_NMAP" != true ]] && run_udp_scan

# HTTP CURL MODULES
[[ "$RUN_HEADERS" == true ]] && [[ "$SKIP_CURL" != true ]] && run_headers
[[ "$RUN_COOKIES" == true ]] && [[ "$SKIP_CURL" != true ]] && run_cookies

[[ "$RUN_GOBUSTER" == true ]] && [[ "$SKIP_GOBUSTER" != true ]] && run_gobuster
[[ "$RUN_NIKTO" == true ]] && [[ "$SKIP_NIKTO" != true ]] && run_nikto

# ============================================================
# SUMMARY
# ============================================================

echo ""
echo "=============================================="
echo " AlienTec Recon PRO – Summary"
echo "=============================================="
echo "Basic Scan Ports: $(wc -l < basic_nmap.txt 2>/dev/null)"
echo "Full TCP Scan:    $(wc -l < full_tcp.txt 2>/dev/null)"
echo "UDP Scan:         $(wc -l < udp_scan.txt 2>/dev/null)"
echo "Headers:          $(wc -l < headers.txt 2>/dev/null)"
echo "Cookies:          $(wc -l < cookies.txt 2>/dev/null)"
echo "Gobuster:         $(wc -l < gobuster.txt 2>/dev/null)"
echo "Nikto:            $(wc -l < nikto.txt 2>/dev/null)"
echo ""
echo "✔ AlienTec Recon PRO completed."
echo "=============================================="
