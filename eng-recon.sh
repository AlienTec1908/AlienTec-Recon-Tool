#!/bin/bash

mgn="\033[35m"
ylw="\033[33m"
rd="\033[31m"
grn="\033[32m"
rst="\033[0m"

clear
echo -e "${mgn}
 █████╗ ██╗     ██╗███████╗███╗  ██╗████████╗███████╗ ██████╗ 
██╔══██╗██║     ██║██╔════╝████╗ ██║╚══██╔══╝██╔════╝██╔═══██╗
███████║██║     ██║█████╗  ██╔██╗██║   ██║   █████╗  ██║     
██╔══██║██║     ██║██╔══╝  ██║╚██╗██║   ██║   ██╔══╝  ██║  ██║
██║  ██║███████╗██║███████╗██║ ╚████║   ██║   ███████╗╚██████╔╝
╚═╝  ╚═╝╚══════╝╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝ ╚═════╝ 
                      AlienTec Recon Tool${rst}
"

echo "-----------------------------------------"
echo -e "${ylw}tools used:${rst} Nmap, Gobuster, Nikto, Curl"
echo "-----------------------------------------"

tools_needed=("nmap" "gobuster" "nikto" "curl")
missing_tool=false
echo -e "${ylw}[+] Check if all tools are installed...${rst}"
for tool in "${tools_needed[@]}"; do
    if ! command -v "$tool" &> /dev/null; then
        echo -e "${rd}[!] Error: The tool '$tool' is not installed.${rst}"
        missing_tool=true
    fi
done
if [[ "$missing_tool" == true ]]; then
    echo -e "${rd}[!] Please install the missing tools and try again.${rst}"
    exit 1
fi
echo -e "${grn}[+] All dependencies are met.${rst}\n"
printf "${ylw}Usage: ./recon.sh --ip <target> [options]\n\n${rst}"

victim_ip=""
domain=""
mode="external"
specific_scan_requested=false

do_tcp=false
do_udp=false
grab_headers=false
grab_cookies=false
bust_dirs=false
do_nikto=false
no_nmap=false
no_buster=false
no_nikto=false
no_curl=false
all_modules=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --help)
      echo "AlienTec Recon Tool - Detailed help"
      echo "-----------------------------------------"
echo "Usage: ./recon.sh --ip <target-ip> [modules] [skips]"
      echo ""
      echo "Main parameters:"
      echo "  --ip <addr>       Required. The IP address of the target."
      echo "  --domain <name>   Optional. The hostname of the target."
      echo ""
      echo "Scan modules (If none are specified, default web scans will run):"
      echo "  --all             Runs ALL available scan modules."
      echo "  --tcp             Performs a deep Nmap TCP scan."
      echo "  --udp             Performs an Nmap UDP scan."
      echo "  --headers         Retrieves the HTTP headers."
      echo "  --cookies         Extracts cookies."
      echo "  --gobuster        Launches a Gobuster directory scan."
      echo "  --nikto           Launches a Nikto web vulnerability scan."
      echo ""
      echo "Skip options:"
      echo "  --skip-nmap       Skips all Nmap-based scans."
      echo "  --skip-curl       Skips the HTTP scans (headers, cookies)."
      echo "  --skip-gobuster   Skips the Gobuster scan."
      echo "  --skip-nikto      Skips the Nikto scan."
      exit 0
      ;;
    --ip) victim_ip="$2"; shift ;;
    --domain) domain="$2"; shift ;;
    --mode) mode="$2"; shift ;;
    --tcp) do_tcp=true; specific_scan_requested=true ;;
    --udp) do_udp=true; specific_scan_requested=true ;;
    --headers) grab_headers=true; specific_scan_requested=true ;;
    --cookies) grab_cookies=true; specific_scan_requested=true ;;
    --gobuster) bust_dirs=true; specific_scan_requested=true ;;
    --nikto) do_nikto=true; specific_scan_requested=true ;;
    --skip-nmap) no_nmap=true ;;
    --skip-gobuster) no_buster=true ;;
    --skip-nikto) no_nikto=true ;;
    --skip-curl) no_curl=true ;;
    --all) all_modules=true ;;
  esac
  shift
done

if [[ "$all_modules" == true ]]; then
  do_tcp=true
  do_udp=true
  grab_headers=true
  grab_cookies=true
  bust_dirs=true
  do_nikto=true
elif [[ "$specific_scan_requested" == false ]]; then
  grab_headers=true
  grab_cookies=true
  bust_dirs=true
fi

if [[ -z "$victim_ip" ]]; then
    echo "Error: --ip <addr> is required. Use --help for more info."
    exit 1
fi

findingsdir="Findings_from_Scans_$victim_ip"
mkdir -p "$findingsdir"

if [[ "$no_nmap" != true ]]; then
    echo -e "${mgn}▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬${rst}"
    echo -e "${mgn}:::::::::::::::::::::::::::: Nmap - Basis Scan :::::::::::::::::::::::::::${rst}"
    echo -e "${mgn}▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬${rst}\n"
    nmap -p- --open -T4 "$victim_ip" 2>&1 | tee "$findingsdir/nmap_basic_ports.txt"
    echo -e "\n"
fi

if [[ "$do_tcp" == true && "$no_nmap" != true ]]; then
    echo -e "${mgn}▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬${rst}"
    echo -e "${mgn}:::::::::::::::::::::::: Nmap - Voll-TCP-Scan ::::::::::::::::::::::::${rst}"
    echo -e "${mgn}▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬${rst}\n"
    nmap -p- -sV -sC -O -T4 "$victim_ip" 2>&1 | tee "$findingsdir/nmap_full_tcp.txt"
    echo -e "\n"
fi

if [[ "$do_udp" == true && "$no_nmap" != true ]]; then
    echo -e "${mgn}▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬${rst}"
    echo -e "${mgn}::::::::::::::::::::::::::: Nmap - UDP-Scan ::::::::::::::::::::::::::::${rst}"
    echo -e "${mgn}▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬${rst}\n"
    nmap -sU --top-ports 200 "$victim_ip" 2>&1 | tee "$findingsdir/nmap_udp.txt"
    echo -e "\n"
fi

echo -e "${ylw}[+] Searching for web ports for further scans...${rst}
web_ports=$(grep '^[0-9]' "$findingsdir/nmap_basic_ports.txt" 2>/dev/null | grep -E 'http|www' | awk -F'/' '{print $1}')

for port in $web_ports; do
    echo -e "${grn}[+] Web port found: $port. Starting web scans...${rst}\n

    if [[ "$grab_headers" == true && "$no_curl" != true ]]; then
        echo -e "${mgn}▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬${rst}"
        echo -e "${mgn}::::::::::::: Curl - HTTP Header (Port $port) :::::::::::::${rst}"
        echo -e "${mgn}▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬${rst}\n"
        curl -s -I "http://$victim_ip:$port" 2>&1 | tee -a "$findingsdir/http_headers.txt"
        echo -e "\n"
    fi

    if [[ "$grab_cookies" == true && "$no_curl" != true ]]; then
        echo -e "${mgn}▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬${rst}"
        echo -e "${mgn}::::::::::::::: Curl - Cookies (Port $port) :::::::::::::::${rst}"
        echo -e "${mgn}▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬${rst}\n"
        curl -s -I "http://$victim_ip:$port" 2>&1 | grep -i 'set-cookie' | tee -a "$findingsdir/http_cookies.txt"
        echo -e "\n"
    fi

    if [[ "$bust_dirs" == true && "$no_buster" != true ]]; then
        echo -e "${mgn}▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬${rst}"
        echo -e "${mgn}::::::::::::::: Gobuster - Scan (Port $port) :::::::::::::::${rst}"
        echo -e "${mgn}▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬${rst}\n"
        gobuster dir -u "http://$victim_ip:$port" -w /usr/share/wordlists/dirb/common.txt 2>&1 | tee -a "$findingsdir/gobuster_p$port.txt"
        echo -e "\n"
    fi

    if [[ "$do_nikto" == true && "$no_nikto" != true ]]; then
        echo -e "${mgn}▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬${rst}"
        echo -e "${mgn}::::::::::::::: Nikto - Scan (Port $port) :::::::::::::::::${rst}"
        echo -e "${mgn}▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬${rst}\n"
        nikto -h "http://$victim_ip:$port" 2>&1 | tee -a "$findingsdir/nikto_p$port.txt"
        echo -e "\n"
    fi
done

echo -e "${grn}▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬${rst}"
echo -e "${grn}:::::::::::::::::::::: Scan - findings :::::::::::::::::::::::${rst}"
echo -e "${grn}▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬${rst}\n"
echo -e "Offene Ports:\t\t$(wc -l < "$findingsdir/nmap_basic_ports.txt" 2>/dev/null | tr -d ' ')"
echo -e "TCP Scan Details:\t$(wc -l < "$findingsdir/nmap_full_tcp.txt" 2>/dev/null | tr -d ' ')"
echo -e "UDP Scan Details:\t$(wc -l < "$findingsdir/nmap_udp.txt" 2>/dev/null | tr -d ' ')"
echo -e "HTTP Header:\t\t$(wc -l < "$findingsdir/http_headers.txt" 2>/dev/null | tr -d ' ')"
echo -e "Cookies:\t\t$(wc -l < "$findingsdir/http_cookies.txt" 2>/dev/null | tr -d ' ')"

for port in $web_ports; do
    echo -e "Gobuster (Port $port):\t$(wc -l < "$findingsdir/gobuster_p$port.txt" 2>/dev/null | tr -d ' ')"
    echo -e "Nikto (Port $port):\t$(wc -l < "$findingsdir/nikto_p$port.txt" 2>/dev/null | tr -d ' ')"
done
echo -e "\n"

echo -e "${grn}▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬${rst}"
echo -e "${grn}:::::::::::::::::::::::::::::::: Done ::::::::::::::::::::::::::::::::::${rst}"
echo -e "${grn}▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬${rst}\n"
echo "All output in the directory: $findingsdir"
