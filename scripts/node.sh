#!/bin/bash

install_node() {
  # Install NVM using Homebrew
  echo "Installing NVM (Node Version Manager)..."
  brew install nvm

  # Create NVM directory
  mkdir -p ~/.nvm

  # Load NVM
  export NVM_DIR="$HOME/.nvm"
  [ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && . "$(brew --prefix)/opt/nvm/nvm.sh"
  [ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && . "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm"

  # Get latest stable Node.js versions
  echo "Fetching latest stable Node.js versions..."
  versions=($(nvm ls-remote | awk '/->/{gsub(/v/, ""); print $2}' | sort -rV | head -10))


  # Prompt user to select a version
  echo "Select a Node.js version to install:"
  select node_version in $versions; do
    if [[ -n $node_version ]]; then
      nvm install "$node_version"
      nvm use "$node_version"
      nvm alias default "$node_version"
      break
    else
      echo "Invalid selection. Please try again."
    fi
  done

  # Install plugins for Node.js development
  echo "Installing plugins for Node.js development..."
  if $vscode_installed; then
    echo "Installing Visual Studio Code extensions..."
    code --install-extension dbaeumer.vscode-eslint
  elif $jetbrains_installed; then
    echo "Installing JetBrains IDE plugins..."
    jb_plugin install NodeJS
    jb_plugin install EJS
    jb_plugin install eslint
    jb_plugin install prettier
    jb_plugin install TSLint
  fi

  echo "Node.js setup complete."
}
