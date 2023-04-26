# TODO: Check to be sure xcode is installed first 


# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install OhMyZSH
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install OSX Developer Tools
xcode-select --install



# Install Apps
brew install hyper visual-studio-code google-chrome slack sourcetree docker arc spotify zoom github raycast


# Install VSCode Theming
code --install-extension GitHub.github-vscode-theme # Github theme
code --install-extension vscode-icons-team.vscode-icons

# JS Developer Extensions
code --install-extension christian-kohler.npm-intellisense # npm auto complete
code --install-extension dbaeumer.vscode-eslint


# Developer Tools
code --install-extension GitHub.copilot # GitHub Copilot 
code --install-extension GitHub.vscode-pull-request-github # Github Issues and PRs
code --install-extension streetsidesoftware.code-spell-checker # spell checking
code --install-extension oderwat.indent-rainbow # indent rainbows
code --install-extension ms-azuretools.vscode-docker # docker management
code --install-extension github.vscode-github-actions # github actions
code --install-extension eamodio.gitlens # gitlens
code --install-extension rangav.vscode-thunder-client # REST API Client

# Lanugague & File Support
code --install-extension golang.go # golang support
code --install-extension mikestead.dotenv # dotenv files
code --install-extension mechatroner.rainbow-csv #rainbow CSV files
code --install-extension bierner.markdown-preview-github-styles # markdown previewer


# Install CLI Tools
brew install node nvm zsh git gh awscli
brew tap heroku/brew && brew install heroku

# Install PHP Tools
sudo apachectl stop
sudo launchctl unload -w /System/Library/LaunchDaemons/org.apache.httpd.plist 2>/dev/null


# TODO: Add in PHP setup
# brew tap homebrew/php
# brew tap homebrew/dupes

# brew install httpd
# brew install php72 --with-httpd
# brew install php72-geoip php72-maxminddb php72-memcached php72-pdo-pgsql php72-redis \
# php72-yaml php72-http php72-gmagick composer watchman

# brew services start homebrew/php/php72
# sudo brew services start httpd


# Open Hyper to allow plugins
open /Applications/Hyper.app

# Global NPM Modules
npm install -g yarn

# add hyper plugins
hpm install hyperlayout hyperterm-working-directory



# Setup NVM
mkdir ~/.nvm
nvm install 14 --reinstall-packages-from=system
nvm install 16 --reinstall-packages-from=system
nvm install 18 --reinstall-packages-from=system



# Setup Sites and Development
mkdir ~/Sites && ~/Development




# Setup Profile
touch ~/.oh-my-zsh/custom/profile.zsh
cat <<EOF >~/.oh-my-zsh/custom/profile.zsh
export NVM_DIR="$HOME/.nvm"
  . "/usr/local/opt/nvm/nvm.sh"

alias profile="code ~/.oh-my-zsh/custom/profile.zsh"
alias sprofile="source ~/.oh-my-zsh/custom/profile.zsh"
alias g="git"
EOF

# Setup GIT Config
touch ~/.gitconfig
cat <<EOF >~/.gitconfig
[alias]
  co = checkout
  ci = commit
  st = status
  br = branch
  hist = log --pretty=format:\"%h %ad | %s%d [%an]\" --graph --date=short
  type = cat-file -t
  dump = cat-file -p
EOF

cat ~/.gitconfig
echo This is now your git configuration.

# Setup .npmrc
echo What is your name?
read name

echo What is your email?
read email

echo What is your website?
read website


touch ~/.npmrc
cat <<EOF >~/.npmrc
init.author.name=$name
init.author.email=$email
init.author.url=$website
save=true
save-exact=true
EOF

cat ~/.npmrc
echo This is now your npm configuration.
