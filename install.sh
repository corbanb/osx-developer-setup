#!/bin/bash

# Check if the main.sh script is present in the current directory
if [ -f "./main.sh" ]; then
  # Use the local script
  cp ./main.sh devbot
else
  # Download the devbot script from GitHub
  curl -L -o devbot "https://raw.githubusercontent.com/yourusername/devbot-repo/main/main.sh"
fi

# Make the script executable
chmod +x devbot

# Set the installation path for devbot
INSTALL_PATH="$HOME/.local/bin"

# Create the target directory if it doesn't exist
mkdir -p "$INSTALL_PATH"

# Move the script to the target directory
mv devbot "$INSTALL_PATH/devbot"

echo "Devbot 🤖 is installed at '$INSTALL_PATH/devbot'."
echo "------"
echo ""
echo ""
echo "To use the 'devbot' command, please add '$INSTALL_PATH' to your PATH variable."
echo ""
echo "For example, you can update your shell configuration file as follows:"
echo ""
if [[ "$SHELL" == *"zsh"* ]]; then
  CONFIG_FILE="$HOME/.zshrc"
  echo "echo 'export PATH=\"$INSTALL_PATH:\$PATH\"' >> $CONFIG_FILE"
  echo "Or you could add 'export PATH=\"$INSTALL_PATH:\$PATH\"' to your $CONFIG_FILE file manually."
  echo ""
elif [[ "$SHELL" == *"bash"* ]]; then
  CONFIG_FILE="$HOME/.bash_profile"
  echo "echo 'export PATH=\"$INSTALL_PATH:\$PATH\"' >> $CONFIG_FILE"
  echo "Or you could add 'export PATH=\"$INSTALL_PATH:\$PATH\"' to your $CONFIG_FILE file manually."
  echo ""
else
  echo "Unknown shell. Please add '$INSTALL_PATH' to your PATH manually."
fi

echo "After updating the configuration file, restart your terminal session or run 'source $CONFIG_FILE'."
