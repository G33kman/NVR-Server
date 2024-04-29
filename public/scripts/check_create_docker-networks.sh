#!/bin/bash

# Define a multi-dimensional array to store network information
networks=(
    [0]="internal 10.2.0.0/24 10.2.0.1 10.2.0.2/25"
    [1]="backend 10.2.1.0/24 10.2.1.1 10.2.1.2/25"
    [2]="frontend 10.2.2.0/24 10.2.2.1 10.2.2.2/25"
)

# Function to retrieve Docker networks excluding default networks
get_networks() {
  docker network ls --format '{{.Name}}' | grep -v '^bridge$\|^docker_gwbridge$\|^host$\|^ingress$\|^none$'
}

# Function to display the list of networks with numbering to remove
show_networks_create() {
    echo "Which network would you like to create:"
    local count=1
    for network in "${networks[@]}"; do
        echo "$count): $network"
        (( count++ ))
    done
    echo "${count}): CREATE ALL NETWORKS"
    echo "0): CANCEL SCRIPT"
}

# Function to display the list of networks with numbering to create
show_networks_remove() {
    echo "Which network would you like to remove:"
    get_networks
    local count=1
    for current_network in "${current_networks[@]}"; do
        echo "$count): $current_network"
        (( count++ ))
    done
    echo "${count}): REMOVE ALL NETWORKS"
    echo "0): CANCEL SCRIPT"
}

# Function to create or remove networks
create_or_remove_networks() {
    local choice
    echo "Would you like to create a network or remove a network?"
    echo "1) Create a Network"
    echo "2) Remove a Network"
    echo "3) List Networks"
    echo "0) Cancel Script"
    read -p "Please enter a number: " -r choice

    if [[ $choice -eq 0 ]]; then
        echo "Cancellation requested. Exiting."
        return
    elif [[ $choice -eq 1 ]]; then
        clear
        echo "--- Create network selected ---"
        create_networks
    elif [[ $choice -eq 2 ]]; then
        echo "Remove network selected"
        echo "====================="
        show_networks_remove
        echo "====================="
        remove_networks
    elif [[ $choice -eq 3 ]]; then
        clear
        echo "Existing Networks:"
        echo "====================="
        get_networks
        echo "====================="
        create_or_remove_networks
    else
        echo "Invalid choice. Please enter a valid number."
        create_or_remove_networks
    fi
}

# Function to remove a network
remove_networks() {
    local choice
    read -p "Enter the number of the network to remove, or '0' to cancel: " choice
    if [[ $choice -eq 0 ]]; then
        echo "Cancellation requested. Exiting."
        return
    elif [[ $choice -eq $(( ${#current_networks[@]} + 1 )) ]]; then
        echo "Removing all networks..."
        for network in "${current_networks[@]}"; do
            echo "Removing network: $network"
            sudo docker network rm "$network"
        done
    elif [[ $choice -le ${#current_networks[@]} ]]; then
        local selected_network="${current_networks[$(($choice - 1))]}"
        echo "Removing network: $selected_network"
        sudo docker network rm "$selected_network"
    else
        echo "Invalid choice. Please enter a valid number."
        remove_networks
    fi
}

# Function to prompt user for network creation
create_networks() {
    local choice
    echo "Which network would you like to create:"
    for index in "${!networks[@]}"; do
        read -r network_name subnet gateway ip_range <<< "${networks[$index]}"
        echo "$((index + 1)): $network_name"
    done
    echo "$(( ${#networks[@]} + 1 )): CREATE ALL NETWORKS"
    echo "0: CANCEL SCRIPT"
    read -p "Enter the number of the network to create, or '0' to cancel: " choice
    case $choice in
        0)
            echo "Cancellation requested. Exiting."
            return
            ;;
        [1-$(( ${#networks[@]}))])
            read -r network_name subnet gateway ip_range <<< "${networks[$(($choice - 1))]}"
            create_network "$network_name" "$subnet" "$gateway" "$ip_range"
            ;;
        all)
            for i in "${!networks[@]}"; do
                create_network "${networks[$i]}"
            done
            ;;
        *)
            echo "Invalid choice. Please enter a valid number."
            create_networks
            ;;
    esac
}

# Function to create all networks
create_all_networks() {
    for network_info in "${networks[@]}"; do
        read -r network_name subnet gateway ip_range <<< "$network_info"
        create_network "$network_name" "$subnet" "$gateway" "$ip_range"
    done
}

# Function to create a docker network
create_network() {
    local network_name=$1
    local subnet=$2
    local gateway=$3
    local ip_range=$4
    echo "Creating network: $network_name"
    sudo docker network create --subnet=$subnet --gateway=$gateway --ip-range=$ip_range $network_name
}

#=====================
# Main Script
#=====================

# Retrieve networks
current_networks=($(get_networks))

create_or_remove_networks