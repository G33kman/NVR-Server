#!/bin/bash

# Variable value for the choice on what to install
local choice="$1"

# Check if Docker is already installed
if command -v docker &> /dev/null; then
  echo "Docker is already installed."
  # Check if Docker Compose is already installed
  if command $(docker compose &> /dev/null) && [ $? -eq 0 ]; then
    echo "SUCCESS: Docker Compose (v2) is installed."
    exit 0
  else
    echo "ERROR: Docker Compose (v2) not installed.."
    choice=2
  fi
else
  echo "Docker is not installed. Assuming both Docker and Docker Compose need to be installed."
  choice=1
fi

if choice != "0"; then
  sudo apt update
fi

case choice in
  # Option 1: Install both Docker and Docker Compose
  "1")
    echo "Installing Docker and Docker Compose..."
    sudo apt install -y docker-ce docker-compose-v2

    # Verify Installation
    if command -v docker &> /dev/null; then
      if command docker compose &> /dev/null; then
        echo "Docker and Docker Compose installation successful."
      fi
    else
      echo "Installation failed. Manual installation required..."
    fi
    ;;
  "2")
    echo "Installing Docker Compose only. Docker is already installed."
    sudo apt install -y docker-compose-v2
    
    # Verify Installation
    if command docker compose &> /dev/null; then
      echo "Docker and Docker Compose installation successful."
    fi
    ;;
  *)
    echo "Invalid option. exiting script."
esac
