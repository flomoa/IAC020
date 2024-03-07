#!/bin/bash

# Fonction permettant d'effectuer un balayage du réseau à l'aide de tcpdump
capture_ip_addresses_and_scan() {
    local duration=${1:-10} # Durée d'écoute de tcpdump, par défaut 10 secondes
    local interface=${2:-$(ip route | grep '^default' | awk '{print $5}' | head -n 1)} # Interface par défaut
    local tcpdump_file="tcpdump_output.txt" # File to store tcpdump output

    # Démarrer tcpdump sur l'interface par défaut pour une certaine durée, capturant seulement les adresses IP qui commencent par 192.168
    printf "Starting tcpdump for %d seconds on interface %s, filtering for IP addresses starting with 192.168...\n" "$duration" "$interface"
    sudo timeout "$duration" tcpdump -i "$interface" -n 'src net 192.168' -w - 2>/dev/null | tcpdump -r - -n 2>/dev/null | awk '{print $3}' | sed 's/:[0-9]*$//' | grep -Eo '192\.168\.[0-9]{1,3}\.[0-9]{1,3}' | sort -u > "$tcpdump_file"
    
    # Read the list of captured IP addresses and perform nmap scan on each
    local ip_list=($(cat "$tcpdump_file")) # Convert file content to array
    for ip in "${ip_list[@]}"; do
        perform_nmap_scan "$ip"
    done
}

# Fonction permettant d'effectuer un scan nmap sur l'IP sélectionnée
perform_nmap_scan() {
    local ip=$1
    local nmap_results_file="nmap_results_${ip//./_}.txt" # Unique file for each IP address

    printf "Scanning %s, results will be stored in %s:\n" "$ip" "$nmap_results_file"
    echo "PORT   STATE SERVICE VERSION" > "$nmap_results_file"
    sudo nmap -sV -sS "$ip" | awk '/^[0-9]+\/(tcp|udp)/ || /^Service Info:/ {print}' >> "$nmap_results_file"
    cat "$nmap_results_file"
}

# Fonction principale de contrôle du flux
main() {
    # Setting initial variables
    local scan_duration=30 # Durée du tcpdump
    local network_interface="eth0" # Interface par défaut

    # Capturing IP addresses and performing scans
    capture_ip_addresses_and_scan "$scan_duration" "$network_interface"
}

# Execution de la fonction principale
main
