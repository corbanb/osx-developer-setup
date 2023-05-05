#!/bin/bash

# Language information array
languages=("node" "ruby" "python" "go" "php" "rust")

language_info() {
  local language="$1"
  case "$language" in
    "node")
      echo "Node.js: JavaScript runtime"
      ;;
    "ruby")
      echo "Ruby: Dynamic, object-oriented programming language"
      ;;
    "python")
      echo "Python: High-level, general-purpose programming language"
      ;;
    "go")
      echo "Go: Statically typed, compiled language"
      ;;
    "php")
      echo "PHP: Popular general-purpose scripting language"
      ;;
    "rust")
      echo "Rust: Systems programming language"
      ;;
    *)
      echo "Error: Invalid language"
      ;;
  esac
}

list_languages() {
  echo "Available languages:"
  for lang in "${languages[@]}"; do
    echo "  $lang"
  done
}


usage() {
  echo "Usage: devbot [OPTIONS] [SUBCOMMAND] [ARGS]"
  echo
  echo "Options:"
  echo "  -v           Enable verbose logging"
  echo
  echo "Subcommands:"
  echo "  setup        Set up tools for specified languages or start the interactive setup"
  echo "  info         Display information about a specific language"
  echo "  dotfiles     Install dotfiles (.gitconfig, .npmrc, profile.zsh)"
  echo "  list         List all available languages"
  echo "  help         Show this help message"
  echo
  echo "Examples:"
  echo "  devbot setup"
  echo "  devbot setup node ruby"
  echo "  devbot info node"
  echo "  devbot dotfiles"
  echo "  devbot list"
  echo "  devbot help"
}

download_and_source() {
  local script_name="$1"
  local script_url="https://raw.githubusercontent.com/yourusername/devbot/main/scripts/$script_name"

  if [ -f "scripts/$script_name" ]; then
    source "scripts/$script_name"
    verbose_log "Sourced $script_name from local repository."
  else
    local tmp_script_file
    tmp_script_file=$(mktemp)
    curl -s -o "$tmp_script_file" "$script_url" && source "$tmp_script_file"
    rm -f "$tmp_script_file"ls
    verbose_log "Sourced $script_name from remote repository."
  fi
}



# ... (check_requirements, download_and_source, usage, display_languages_info, select_languages, install, list_languages functions) ...

# Function to display a progress bar
progress_bar() {
  local total="$1"
  local current="$2"
  local width=50

  local filled=$((current * width / total))
  local empty=$((width - filled))

  printf "["
  for ((i = 1; i <= filled; i++)); do
    printf "#"
  done
  for ((i = 1; i <= empty; i++)); do
    printf " "
  done
  printf "] %d%%\r" $((current * 100 / total))
}

# Function to control the verbosity of the logs
verbose_log() {
  if [ "$verbose" = true ]; then
    echo "$@"
  fi
}

check_requirements() {
  if ! command -v brew >/dev/null 2>&1; then
    echo "Error: Homebrew is not installed. Please install it and try again."
    echo "Visit https://brew.sh for installation instructions."
    exit 1
  fi

  vscode_installed=false
  jetbrains_installed=false

  if command -v code >/dev/null 2>&1; then
    vscode_installed=true
  fi

  if command -v jb >/dev/null 2>&1 || command -v jb-plugin >/dev/null 2>&1; then
    jetbrains_installed=true
  fi

  if ! $vscode_installed && ! $jetbrains_installed; then
    echo "Neither Visual Studio Code nor JetBrains IDEs were detected."
    read -p "Do you want to install Visual Studio Code? (y/n) " install_vscode
    if [[ $install_vscode =~ ^[Yy]$ ]]; then
      brew install --cask visual-studio-code
    else
      read -p "Do you want to install a JetBrains IDE like IntelliJ IDEA? (y/n) " install_jetbrains
      if [[ $install_jetbrains =~ ^[Yy]$ ]]; then
        echo "Visit the JetBrains Toolbox page at https://www.jetbrains.com/toolbox-app/ for installation instructions."
      else
        echo "Error: You need to have either Visual Studio Code or a JetBrains IDE installed to use this script."
        exit 1
      fi
    fi
  fi
}

install_dotfiles() {
  # symlink dotfiles from ./dotfiles/ to ~/ (home directory)
  # if the file already exists, back it up to ~/dotfiles_backup/
  # if the file is a directory, back it up to ~/dotfiles_backup/ and then delete it
  # if the file is a symlink, delete it
  # then symlink the file from ./dotfiles/ to ~/
  echo "Installing dotfiles..."
  # get current working directory

  local dotfiles_dir="$PWD/dotfiles"
  local dotfiles_backup_dir="$HOME/dotfiles_backup"
  mkdir -p "$dotfiles_backup_dir"

  for file in $(find "$dotfiles_dir" -maxdepth 1 -type f -name ".*"); do
    local filename
    filename=$(basename "$file")
    if [ -f "$HOME/$filename" ]; then
      verbose_log "Backing up $filename to $dotfiles_backup_dir"
      mv "$HOME/$filename" "$dotfiles_backup_dir"
    elif [ -d "$HOME/$filename" ]; then
      verbose_log "Backing up $filename to $dotfiles_backup_dir"
      mv "$HOME/$filename" "$dotfiles_backup_dir"
    elif [ -L "$HOME/$filename" ]; then
      verbose_log "Deleting existing symlink $filename"
      rm "$HOME/$filename"
    fi
    verbose_log "Creating symlink for $filename"
    ln -sf "$file" "$HOME/$filename"
  done

  echo "Dotfiles installed."

  # next we need to look for .zsh files and symlink them into $HOME/.oh-my-zsh/custom/
  # if the file already exists, back it up to ~/dotfiles_backup/
  # if the file is a directory, back it up to ~/dotfiles_backup/ and then delete it
  # if the file is a symlink, delete it
  # then symlink the file from ./dotfiles/ to $HOME/.oh-my-zsh/custom/
  echo "Installing custom ZSH files..."
  local zsh_custom_dir="$HOME/.oh-my-zsh/custom"
  mkdir -p "$zsh_custom_dir"

  for file in $(find "$dotfiles_dir" -maxdepth 1 -type f -name "*.zsh"); do
    local filename
    filename=$(basename "$file")
    if [ -f "$zsh_custom_dir/$filename" ]; then
      verbose_log "Backing up $filename to $dotfiles_backup_dir"
      mv "$zsh_custom_dir/$filename" "$dotfiles_backup_dir"
    elif [ -d "$zsh_custom_dir/$filename" ]; then
      verbose_log "Backing up $filename to $dotfiles_backup_dir"
      mv "$zsh_custom_dir/$filename" "$dotfiles_backup_dir"
    elif [ -L "$zsh_custom_dir/$filename" ]; then
      verbose_log "Deleting existing symlink $filename"
      rm "$zsh_custom_dir/$filename"
    fi
    verbose_log "Creating symlink for $filename"
    ln -sf "$file" "$zsh_custom_dir/$filename"
  done

}


# Main function
main() {
  local subcommand="$1"

  if [ "$1" = "--help" ]; then
    usage
    exit 1
  fi

  if [ "$1" = "-v" ]; then
    verbose=true
    shift
    subcommand="$1"
  else
    verbose=false
  fi

  case "$subcommand" in
    setup)
      check_requirements
      if [ -n "$2" ]; then
        for specified_language in "${@:2}"; do
          if [[ " ${languages[*]} " =~ " ${specified_language} " ]]; then
            download_and_source "$specified_language.sh"
            install_$specified_language
          else
            echo "Error: Invalid language '$specified_language'."
            usage
            exit 1
          fi
        done
      else
        display_languages_info
        select_languages
        install
      fi
      ;;
    info)
      local specified_language="$2"
      if [[ -n "$specified_language" ]] && [[ " ${languages[*]} " =~ " ${specified_language} " ]]; then
        echo "Information for $specified_language:"
        language_info "$specified_language"
      else
        echo "Error: Invalid language '$specified_language'."
        usage
        exit 1
      fi
      ;;
    list)
      list_languages
      ;;
    dotfiles)
      install_dotfiles
      ;;
    *)
      echo "In order to run the and install using devbot learn more using --help"
      ;;
  esac
}


# Run the main function
main "$@"