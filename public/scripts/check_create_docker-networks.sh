#!/bin/bash

###############################################
# WARNING: NOT FINISHED                       #
###############################################

# =============================================
# VARIABLE SECTION
# =============================================
#
# Placeholder for the network name
v_network_name_current=""
#
# Network option state (0: List, 1: Create or 2: Remove)
v_network_option_state=0
#
# Placeholder for the network option text (Create or Remove)
v_network_option_text=""
#

# =============================================
# ARRAY SECTION
# =============================================
#
# Define the network data as an array
#
declare -A a_networks=(
  [0]="internal 10.2.0.0/24 10.2.0.1 10.2.0.2/25"
  [1]="backend 10.2.1.0/24 10.2.1.1 10.2.1.2/25"
  [2]="frontend 10.2.2.0/24 10.2.2.1 10.2.2.2/25"
)

# =============================================
# GENERAL FUNCTION SECTION
# =============================================

# When the exit option is selected
f_option_exit() {
    trap 'echo "Caught Ctrl+C or SIGTERM. Exiting..." && exit 1' INT TERM
}

# When the cancel option is selected
f_option_cancel() {
    echo "Cancel option selected. Returning to the network options menu..."
    f_menu_main
}

# Command to show the current Docker networks (minus the default networks)
f_command_network_list() {
    docker network ls --format '{{.Name}}' | grep -v '^bridge$\|^docker_gwbridge$\|^host$\|^ingress$\|^none$'
}

# Command to remove a docker network
f_is_empty_string() {

    # Check if the network_name variable is empty
    if [[ -n "$1" ]]; then
        echo "Variable value is '$1'"
        return 0
    else
        echo "[ERROR]: Variable is empty."
        return 1
    fi

}

# Sets the network option state text to Create or Remove. Otherwise sets it to empty ""
f_set_network_option_text() {
    local state=$v_network_option_state
    local text=$v_network_option_text

    # Checks how to set the network option text
    if [[ $state -eq 1 ]]; then
        $text="create"
    elif [[ $state -eq 2 ]]; then
        $text="remove"
    else
        $text=""
    fi

    # Sets the network option text string
    $v_network_option_text=$text
}

# Docker network list menu text
f_list_docker_networks() {
    echo "============================="
    echo "Docker Network List"
    echo "============================="
    echo ""
    echo "-----------------------------"
    f_command_network_list
    echo "-----------------------------"
}

# =============================================
# MAIN MENU FUNCTION SECTION
# =============================================

# Main menu text to show
f_menu_main_text() {
    echo "============================="
    echo "Docker Network Administration"
    echo "============================="
    echo ""
    echo "1) List Current Docker Networks"
    echo "2) Create Docker Networks"
    echo "3) Remove Docker Networks"
    echo "-----------------------------"
    echo "0) Exit Script"
}

# Main menu prompt the user for a selection
f_menu_main_prompt() {

    # Resets the network state
    if [[ $v_network_option_state -ne 0 ]]; then
        $v_network_name_current=0
    fi

    # Prompt the user to make a selection from the menu
    read -p "Please make a selection: " -r choice

    # Route the user to a menu depending on their choice
    case $choice in
        0)
            # Exit the Script
            f_option_exit
            ;;
        1)
            # List Docker Networks Menu
            f_list_docker_networks
            ;;
        2)
            # Create Docker Networks Menu
            $v_network_option_state=1
            ;;
        3)
            # Remove Docker Networks Menu
            $v_network_option_state=2
            ;;
        *)
            # Incorrect response
            $v_network_option_state=0
            echo "[WARN]: Incorrect response. Please enter a number."
            f_menu_main
            ;;
    esac

}

f_menu_main() {
    f_menu_main_text
    f_menu_main_prompt
}

# =============================================
# NETWORK FUNCTION SECTION
# =============================================

f_menu_network_text() {
    
    # Sets the network option text (create or remove)
    f_set_network_option_text

    # Creates the text to show for the network menu
    echo "=========================================="
    echo "Docker $v_network_option_text Network Menu"
    echo "=========================================="
    echo ""
    echo ""
    echo ""
}

# === Script Start === #
clear
f_menu_main