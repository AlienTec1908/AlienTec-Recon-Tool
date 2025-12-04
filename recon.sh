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
 █████╗ ██╗     ██╗███████╗███╗   ██╗████████╗███████╗ ██████╗ 
██╔══██╗██║     ██║██╔════╝████╗  ██║╚══██╔══╝██╔════╝██╔═══██╗
███████║██║     ██║█████╗  ██╔██╗ ██║   ██║   █████╗  ██║      
██╔══██║██║     ██║██╔══╝  ██║╚██╗██║   ██║   ██╔══╝  ██║   ██║
██║  ██║███████╗██║███████╗██║ ╚████║   ██║   ███████╗╚██████╔╝
╚═╝  ╚═╝╚══════╝╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝ ╚═════╝ 
                      AlienTec Recon PRO${RESET}
"

# ===== Variables =====
TARGET_IP=""
TARGET_DOMAIN=""
SCAN_MODE="external"

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

# ===== Usage =====
usage() {
  echo "Usage: ./recon.sh --ip <target> [options]"
  exit 1
}

# ===== Parse Args =====
while [[ $# -gt 0 ]]; do
  case "$1" in
    --ip) TARGET_IP="$2"; shift ;;
    --domain) TARGET_DOMAIN="$2"; shift ;;
    --mode) SCAN_MODE="$2"; shift ;;
    --tcp) RUN_TCP=true ;;
    --udp) RUN_UDP=true ;;
    --headers) RUN_HEADERS=true ;;
    --cookies) RUN_COOKIES=true ;;
    --gobuster) RUN_GOBUSTER=true ;;
    --nikto) RUN_NIKTO=true ;;
    --all) RUN_ALL=true ;;
    --skip-gobuster) SKIP_GOBUSTER=true ;;
    --skip-nmap) SKIP_NMAP=true ;;
    --skip-nikto) SKIP_NIKTO=true ;;
    --skip-curl) SKIP_CURL=true ;;
  esac
  shift
done

# ===== Map ALL → all flags =====
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
LOGFILE="$LOGDIR/$(date +'%Y-%m-%d_%H-%M-%S').log"

echo -e "[+] Starting AlienTec Recon PRO..."
echo "Mode: $SCAN_MODE"
echo "Target IP: $TARGET_IP"

# ====================================================
# MODULE FUNCTIONS
# ====================================================

run_basic_nmap() {
  echo -e "${YELLOW}[+] Running basic Nmap scan...${RESET}"
  nmap -T4 -sV "$TARGET_IP" -oN basic_nmap.txt
}

run_full_tcp_scan() {
  echo -e "${YELLOW}[+] Full TCP ports...${RESET}"
  nmap -p- -T4 "$TARGET_IP" -oN full_tcp.txt
}

run_udp_scan() {
  echo -e "${YELLOW}[+] UDP Scan...${RESET}"
  nmap -sU --top-ports 200 "$TARGET_IP" -oN udp_scan.txt
}

run_headers() {
  echo -e "${YELLOW}[+] Fetching HTTP headers...${RESET}"
  curl -I "http://$TARGET_IP" > headers.txt 2>/dev/null
}

run_cookies() {
  echo -e "${YELLOW}[+] Dumping cookies...${RESET}"
  curl -s -I "http://$TARGET_IP" | grep -i set-cookie > cookies.txt
}

run_gobuster() {
  echo -e "${YELLOW}[+] Running Gobuster...${RESET}"
  gobuster dir -u "http://$TARGET_IP" -w /usr/share/wordlists/dirb/common.txt -o gobuster.txt
}

run_nikto() {
  echo -e "${YELLOW}[+] Running Nikto scan...${RESET}"
  nikto -h "$TARGET_IP" -o nikto.txt
}

# ====================================================
# EXECUTION FLOW
# ====================================================

# Always run basic Nmap unless skipped
if [[ "$SKIP_NMAP" != true ]]; then
  run_basic_nmap
fi

# TCP
[[ "$RUN_TCP" == true ]] && [[ "$SKIP_NMAP" != true ]] && run_full_tcp_scan

# UDP
[[ "$RUN_UDP" == true ]] && [[ "$SKIP_NMAP" != true ]] && run_udp_scan

# Headers
[[ "$RUN_HEADERS" == true ]] && [[ "$SKIP_CURL" != true ]] && run_headers

# Cookies
[[ "$RUN_COOKIES" == true ]] && [[ "$SKIP_CURL" != true ]] && run_cookies

# Gobuster
[[ "$RUN_GOBUSTER" == true ]] && [[ "$SKIP_GOBUSTER" != true ]] && run_gobuster

# Nikto
[[ "$RUN_NIKTO" == true ]] && [[ "$SKIP_NIKTO" != true ]] && run_nikto

# ====================================================
# SUMMARY
# ====================================================
echo ""
echo "============================================================"
echo " AlienTec Recon PRO – Scan Summary"
echo "============================================================"
echo ""
echo "Date: $(date +'%Y-%m-%d')"
echo "Time: $(date +'%H:%M:%S')"

echo "Nmap Basic Scan:       $(wc -l < basic_nmap.txt 2>/dev/null) lines"
echo "Nmap Full TCP:         $(wc -l < full_tcp.txt 2>/dev/null) lines"
echo "Nmap UDP:              $(wc -l < udp_scan.txt 2>/dev/null) lines"
echo "Gobuster:              $(wc -l < gobuster.txt 2>/dev/null) lines"
echo "HTTP Headers:          $(wc -l < headers.txt 2>/dev/null) lines"
echo "Cookie Dump:           $(wc -l < cookies.txt 2>/dev/null) lines"
echo "Nikto Scan:            $(wc -l < nikto.txt 2>/dev/null) lines"
echo ""
echo "✔ AlienTec Recon PRO completed."
echo "Logfile saved at: $LOGFILE"
echo "============================================================"
