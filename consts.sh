# settings
DOTFILES_DIR="$HOME/dotfiles"

FILES="
src/.bashrc -> $HOME/.bashrc
src/zshrc/.zshrc -> $HOME/.zshrc
src/.vimrc -> $HOME/.vimrc
src/.tmux.conf -> $HOME/.tmux.conf
src/.gitconfig -> $HOME/.gitconfig
src/.dircolors -> $HOME/.dircolors
src/.ezacolors -> $HOME/.ezacolors
src/terminator.config -> $HOME/.config/terminator/config
src/vscode/settings.json -> $HOME/.config/Code/User/settings.json
src/vscode/settings.json -> $HOME/Library/Application\ Support/Code/User/settings.json
src/vscode/keybindings.json -> $HOME/.config/Code/User/keybindings.json
src/vscode/keybindings.mac.json -> $HOME/Library/Application\ Support/Code/User/keybindings.json
src/sshcontrol -> $HOME/.gnupg/sshcontrol
src/gpg-agent.conf -> $HOME/.gnupg/gpg-agent.conf
src/karabiner.json -> $HOME/.config/karabiner/karabiner.json
src/intellij-idea/keymaps -> $HOME/.config/JetBrains/*/keymaps
src/intellij-idea/keymaps -> $HOME/Library/Application\ Support/JetBrains/*/keymaps
src/nvtop.interface.ini -> $HOME/.config/nvtop/interface.ini
"

# colors
RED="\e[31m"
GREEN="\e[32m"
RESET="\e[m"
