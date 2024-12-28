#!/bin/bash

# Input and output files
user_list="user_list.txt"
credentials_file="credentials.txt"

# Check if the user list file exists
if [ ! -f "$user_list" ]; then
  echo "User list file ($user_list) not found!"
  exit 1
fi

# Clear the credentials file or create it if it doesn't exist
> "$credentials_file"

# Function to generate a random password
generate_random_password() {
  # Generate a random 12-character password containing letters and numbers
  password=$(tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 12)
  echo "$password"
}

# Read each username from the user list and create the user
while IFS= read -r username; do
  # Skip empty lines or lines starting with #
  if [[ -z "$username" || "$username" == \#* ]]; then
    continue
  fi

  # Check if the user already exists
  if id "$username" &>/dev/null; then
    echo "User '$username' already exists."
  else
    # Generate a random password for the new user
    password=$(generate_random_password)

    # Create the new user
    sudo useradd "$username" && echo "$username:$password" | sudo chpasswd

    # Save the username and password to the credentials file
    echo "$username:$password" >> "$credentials_file"

    # Output a success message
    echo "User '$username' created with password: $password"
  fi
done < "$user_list"

echo "User account creation complete. Credentials saved to $credentials_file."

