# TODO: Check to be sure xcode is installed first 


# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install OhMyZSH
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install OSX Developer Tools
xcode-select --install



# Install Apps
brew cask install hyper visual-studio-code google-chrome slack sourcetree docker


# Install VSCode Extenstions
code --install-extension msjsdiag.debugger-for-chrome
code --install-extension robertohuertasm.vscode-icons
code --install-extension dbaeumer.vscode-eslint 
code --install-extension zhuangtongfa.material-theme
code --install-extension HookyQR.beautify
code --install-extension PeterJausovec.vscode-docker
code --install-extension Zignd.html-css-class-completion
code --install-extension felixfbecker.php-intellisense
code --install-extension eg2.vscode-npm-script
code --install-extension humao.rest-client
code --install-extension esbenp.prettier-vscode
code --install-extension christian-kohler.npm-intellisense


# Install CLI Tools
brew install node nvm zsh git heroku/brew/heroku 

# Install PHP Tools
sudo apachectl stop
sudo launchctl unload -w /System/Library/LaunchDaemons/org.apache.httpd.plist 2>/dev/null

brew tap homebrew/php
brew tap homebrew/dupes

brew install httpd
brew install php72 --with-httpd
brew install php72-geoip php72-maxminddb php72-memcached php72-pdo-pgsql php72-redis \
php72-yaml php72-http php72-gmagick composer

brew services start homebrew/php/php72
sudo brew services start httpd


# Open Hyper to allow plugins
open /Applications/Hyper.app

# Global NPM Modules
npm install -g eslint browserify webpack hyperlayout hpm-cli yo nodemon node-inspector

# add hyper plugins
hpm install hyperlayout hyperterm-working-directory



# Setup NVM
mkdir ~/.nvm
nvm install 5 --reinstall-packages-from=system
nvm install 6 --reinstall-packages-from=system
nvm install 8 --reinstall-packages-from=system



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