#!/bin/bash

# Fonction permettant d'effectuer un balayage du réseau à l'aide de tcpdump
capture_ip_addresses() {
    local duration=${1:-10} # Durée d'écoute de tcpdump, par défaut 10 secondes
    local interface=${2:-$(ip route | grep '^default' | awk '{print $5}' | head -n 1)} # Interface par défaut
    local tcpdump_file="tcpdump_output.txt" # Fichier de stockage de la sortie tcpdump

    # Démarrer tcpdump sur l'interface par défaut pour une certaine durée, capturant seulement les adresses IP qui commencent par 192.168
    printf "Starting tcpdump for %d seconds on interface %s, filtering for IP addresses starting with 192.168...\n" "$duration" "$interface"
    sudo timeout "$duration" tcpdump -i "$interface" -n 'src net 192.168' -w - 2>/dev/null | tcpdump -r - -n 2>/dev/null | awk '{print $3}' | sed 's/:[0-9]*$//' | grep -Eo '192\.168\.[0-9]{1,3}\.[0-9]{1,3}' | sort -u > "$tcpdump_file"
}

# Fonction permettant à l'utilisateur de sélectionner une adresse IP pour le scan nmap
select_and_scan() {
    local tcpdump_file="tcpdump_output.txt" # Fichier où sont stockées les adresses IP capturées
    local ip_list=($(cat "$tcpdump_file")) # Convertir le contenu du fichier en tableau
    local choice
    
    while true; do
        printf "Select an IP address to scan or choose '0' to exit:\n"
        local index=1
        for ip in "${ip_list[@]}"; do
            printf "%d) %s\n" "$index" "$ip"
            ((index++))
        done
        printf "0) Exit\n"

        read -p "Enter your choice: " choice
        # Check if user wants to exit
        if [[ "$choice" -eq 0 ]]; then
            printf "Exiting.\n"
            break
        fi

        # Validate user input
        if ! [[ "$choice" =~ ^[0-9]+$ ]] || [ "$choice" -lt 1 ] || [ "$choice" -gt "${#ip_list[@]}" ]; then
            printf "Invalid selection. Please try again.\n" >&2
        else
            local selected_ip="${ip_list[$choice-1]}"
            perform_nmap_scan "$selected_ip"
        fi
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

    # Capturing IP addresses
    capture_ip_addresses "$scan_duration" "$network_interface"

    # Selection de l'adresse IP
    select_and_scan
}

# Execution de la fonction principale
main
