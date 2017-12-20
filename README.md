# Developer Setups
This is currently a repo for storing setups to developer machines. Right now it works well for OSX Node.js and PHP developers. Below you will find a roadmap on future updates. I am sure these will require other commiters to assist in perferred setups but will act as a guide to start.

The thought is to allow this script to run as best it can without any other software needing to be installed. 

(Warning this is a first pass. Needs more love. Use at your own risk.)


## BETA Setup

### OSX Node.js Developer
```
# run setup script
$ ./setups/osx-nodejs-dev.sh
``` 

### Software Installed
- Xcode Developer Tools
- Hyper Terminal (a few plugins)
- Visual Code (multiple extensions)
- Chrome
- Slack
- Source Tree
- Docker
- Node (latest, and some base global modules)
- NPM (.npmrc setup)
- nvm (node version manager, node 5,6 and 8)
- zsh
- git (.gitconfig setup)
- heroku tools
- PHP72 (and some base packages)
- OhMyZsh (and some profile shortcuts)



-------------------------------------------------------
## Roadmap

### Languages / Platforms
- [ ] nodejs
- [ ] php
- [ ] swift
- [ ] golang
- [ ] java 
- [ ] android
- [ ] ruby
- [ ] Python
- [ ] C++
- [ ] C
- [ ] scala
- [ ] lua
- [ ] rust
- [ ] makefile
- [ ] R
- [ ] kotlinlang

### IDES
- [ ] visualcode
- [ ] atom
- [ ] brackets
- [ ] sublime
- [ ] androidstudio


and whatever else you all dream up! :)

### Future Ideas
Setup command and options like brew does with allowing multiple
```
$ dev-setup base node visualcode java androidstudio browsers slack

```
