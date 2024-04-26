#!/bin/bash

# Use the owner name passed in
# Make sure to run the script passing in the username in
# Example: sudo ./path/to/the/script.sh $USER
username="$1"

# Base path for files to adjust ownership and permissions
folder_path="/home/docker/private/"

# Function to adjust permissions and ownership
adjust_permissions() {
  echo "adjusting ownership of files and folders to User: ${owner} and Group: to ${group}."
  sudo chown -R $owner:$group $folder_path

  echo "adjusting permissions of folder and files to $permissions."
  sudo chmod -R $permissions $folder_path

  echo "The files and folder permissions have been changed to:"
  ls -lR $folder_path
}

# Prompt the User
user_prompt() {
  echo "How would you like to adjust the file and folder ownership and permissions?"
  echo "1: Allow Editing"
  echo "2: Protect Files"
  read -p "Please enter only 1 or 2: " -r action
}

# Check if the user entered the question correctly
user_prompt
if [[ "$action" =~ ^(1|2)$ ]]; then
  case $action in
    1)
      owner="$username"
      group="sudo"
      permissions="775"
      adjust_permissions
      ;;
    2)
      owner="root"
      group="root"
      permissions="600"
      adjust_permissions
      ;;
    *)
      echo "ERROR: Incorrect response. Please enter 1 or 2."
      user_prompt
      ;;
  esac
else
  user_prompt
fi

echo "Script execution complete."
