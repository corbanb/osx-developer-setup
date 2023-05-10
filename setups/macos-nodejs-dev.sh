# TODO: Check to be sure xcode is installed first 


# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# Install OhMyZSH
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# Install OSX Developer Tools
xcode-select --install


# Install Apps
brew install google-chrome arc 
brew install discord slack zoom 
brew install notion raycast
brew install visual-studio-code postman sourcetree github
brew install spotify 1password
brew install docker hyper iterm2

# Install VSCode Theming
code --install-extension GitHub.github-vscode-theme
code --install-extension vscode-icons-team.vscode-icons

# JS Developer Extensions
code --install-extension christian-kohler.npm-intellisense 
code --install-extension dbaeumer.vscode-eslint
code --install-extension yoavbls.pretty-ts-errors

# Developer Tools
code --install-extension GitHub.copilot 
code --install-extension GitHub.vscode-pull-request-github 
code --install-extension streetsidesoftware.code-spell-checker
code --install-extension oderwat.indent-rainbow 
code --install-extension ms-azuretools.vscode-docker 
code --install-extension github.vscode-github-actions 
code --install-extension eamodio.gitlens 
code --install-extension rangav.vscode-thunder-client 

# Lanugague & File Support
code --install-extension golang.go 
code --install-extension mikestead.dotenv 
code --install-extension mechatroner.rainbow-csv 
code --install-extension bierner.markdown-preview-github-styles 

# Install CLI Tools
brew tap heroku/brew
brew install node nvm zsh git gh awscli pnpm heroku

# TODO: Add in PHP setup
# Install PHP Tools
# sudo apachectl stop
# sudo launchctl unload -w /System/Library/LaunchDaemons/org.apache.httpd.plist 2>/dev/null

# brew tap homebrew/php
# brew tap homebrew/dupes

# brew install httpd
# brew install php72 --with-httpd
# brew install php72-geoip php72-maxminddb php72-memcached php72-pdo-pgsql php72-redis \
# php72-yaml php72-http php72-gmagick composer watchman

# brew services start homebrew/php/php72
# sudo brew services start httpd


## TODO: break out the details for terminal setup
# # Open Hyper to allow plugins
# open /Applications/Hyper.app

# # add hyper plugins
# hpm install hyperlayout hyperterm-working-directory


# Global NPM Modules
npm install -g yarn


# Setup NVM
mkdir ~/.nvm
nvm install 14 --reinstall-packages-from=system
nvm install 16 --reinstall-packages-from=system
nvm install 18 --reinstall-packages-from=system

# Setup Sites and Development
mkdir ~/Sites && mkdir ~/Development

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
