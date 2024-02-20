#!/bin/bash

echo "Checking system prerequisites for Spotify Backstage..."

# Check Operating System
os_type=$(uname)
echo "Operating System: $os_type"

# Check for GNU-like build environment
echo "Checking for GNU-like build environment..."
if command -v make >/dev/null && (command -v gcc >/dev/null || command -v clang >/dev/null); then
    echo "Build tools are available."
else
    echo "Build tools (make and gcc/clang) are missing."
fi

# Elevated rights - This is more advisory, as a script cannot easily determine if it has rights to install dependencies
echo "Ensure you have elevated rights to install dependencies."

# Check for curl or wget
echo "Checking for curl or wget..."
if command -v curl >/dev/null || command -v wget >/dev/null; then
    echo "curl or wget is installed."
else
    echo "curl and wget are missing."
fi

# Node.js and nvm check
echo "Checking for Node.js..."
if command -v nvm >/dev/null; then
    echo "nvm is installed."
    node_version=$(nvm current)
    echo "Node.js version: ${node_version}" # Added double quotes here
elif command -v node >/dev/null; then
    node_version=$(node -v)
    echo "Node.js is installed directly without nvm: ${node_version}" # Added double quotes here
else
    echo "Node.js is missing. nvm is recommended for managing Node.js versions."
fi

# Check for yarn
echo "Checking for Yarn..."
if command -v yarn >/dev/null; then
    yarn_version=$(yarn -v)
    echo "Yarn is installed: ${yarn_version}" # Added double quotes here
else
    echo "Yarn is missing."
fi

# Check for Docker
echo "Checking for Docker..."
if command -v docker >/dev/null; then
    echo "Docker is installed."
else
    echo "Docker is missing."
fi

# Check for Git
echo "Checking for Git..."
if command -v git >/dev/null; then
    echo "Git is installed."
else
    echo "Git is missing."
fi

# Function to check open ports
check_port() {
    local port=$1
    if lsof -i:"$port" &>/dev/null; then
        echo "Port $port is open."
    else
        echo "Port $port is not open or in use."
    fi
}

# Check if ports 3000 and 7007 are open
echo "Checking if ports 3000 and 7007 are open..."
check_port 3000
check_port 7007
