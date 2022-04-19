# settings
DOTFILES_DIR="$HOME/dotfiles"

FILES="
src/.bashrc -> $HOME/.bashrc
src/zshrc/.zshrc -> $HOME/.zshrc
src/.vimrc -> $HOME/.vimrc
src/.tmux.conf -> $HOME/.tmux.conf
src/.gitconfig -> $HOME/.gitconfig
src/.dircolors -> $HOME/.dircolors
src/.exacolors -> $HOME/.exacolors
src/terminator.config -> $HOME/.config/terminator/config
src/vscode.settings.json -> $HOME/.config/Code/User/settings.json
src/vscode.settings.json -> $HOME/Library/Application Support/Code/User/settings.json
src/sshcontrol -> $HOME/.gnupg/sshcontrol
src/gpg-agent.conf -> $HOME/.gnupg/gpg-agent.conf
"

# colors
RED="\e[31m"
GREEN="\e[32m"
RESET="\e[m"
