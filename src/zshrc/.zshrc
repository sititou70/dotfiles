export DOTFILES_PATH="$HOME/dotfiles"

########################################
# path settings
addpath() {
  path=("$1" $path)
}
typeset -U path PATH

########################################
# brew for M1 Mac
addpath "/opt/homebrew/bin"

########################################
# install toolchains
source $DOTFILES_PATH/src/zshrc/install-toolchains.zsh

########################################
# plugins
[ -e $ZPLUG_DIR ] && source $ZPLUG_DIR/init.zsh

zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "g-plane/pnpm-shell-completion", hook-build:"./zplug.zsh", defer:2
zplug "greymd/docker-zsh-completion"
zplug "nnao45/zsh-kubectl-completion"
zplug "gradle/gradle-completion"

if ! zplug check --verbose; then
  zplug install
fi
zplug load

########################################
# basics
export LANG=ja_JP.UTF-8

## use color
autoload -Uz colors
colors

## history
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt share_history
setopt hist_ignore_all_dups

## word separator
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

## completion
zstyle ':completion:*:default' menu select=2
### enable after sudo
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
### completion in the middle name
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

## etc
setopt print_eight_bit
setopt no_beep
setopt no_flow_control
setopt ignore_eof
setopt interactive_comments

########################################
# key binndings
## skipping word when press Ctrl+ArrowKey
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
### for Mac
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

bindkey "^H" backward-kill-word

## substring search
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[OA" history-beginning-search-backward-end
bindkey "^[OB" history-beginning-search-forward-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

########################################
# alias
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias grep='grep --color'
alias tree='tree -sh'
alias beep='echo -en "\a"'

## enable alias after sudo
alias sudo='sudo '

########################################
# coreutils for Mac (brew install coreutils)
if type brew >/dev/null; then
  addpath "$(brew --prefix coreutils)/libexec/gnubin"
fi

########################################
# dircolors setting
if type dircolors >/dev/null; then
  eval $(dircolors ~/.dircolors)

  if [ -n "$LS_COLORS" ]; then
    zstyle ':completion:*' list-colors $(echo "$LS_COLORS" | sed -e "s/:/ /g")
  fi
fi

########################################
# gpg-agent
if type gpgconf >/dev/null; then
  export GPG_TTY=$(tty)
  gpgconf --launch gpg-agent
  export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
fi

########################################
# exa
## ls alias
alias ll='ls -alh'
if [ -e $EXA_DIR ]; then
  case ${OSTYPE} in
  linux*)
    alias ls="$EXA_DIR/$EXA_LINUX_BIN --icons --classify --sort=type"
    ;;
  darwin*)
    alias ls="$EXA_DIR/$EXA_MAC_BIN --icons --classify --sort=type"
    ;;
  esac

  alias ll="ls -alhg --git --time-style long-iso --color-scale"
fi

## exacolors
EXA_COLORS_FILE="$HOME/.exacolors"
if [ -e $EXA_COLORS_FILE ]; then
  export EXA_COLORS=$(
    cat $EXA_COLORS_FILE |
      grep -v -e "^#" |
      grep -v -e "^$" |
      xargs echo |
      sed -e "s/ /:/g"
  )
fi

########################################
# powerline-go
function powerline_precmd() {
  PS1="$(
    $POWERLINE_GO_DIR/$POWERLINE_GO_BIN \
      -shell zsh \
      -modules 'ssh,git,cwd' \
      -cwd-mode plain \
      -east-asian-width \
      -alternate-ssh-icon
  )"
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
  install_powerline_precmd
fi

########################################
# fzf utils
source $DOTFILES_PATH/src/zshrc/fzf-utils.zsh

########################################
# dotfiles bin
addpath "$DOTFILES_PATH/src/bin"

########################################
# software settings
## n
### install: curl -L https://git.io/n-install | bash
### uninstall: rm -rf ~/n
export N_PREFIX="$HOME/n"
addpath "$N_PREFIX/bin"

## goenv
### install: git clone https://github.com/syndbg/goenv.git ~/.goenv
### uninstall: rm -rf ~/.goenv
export GOENV_ROOT="$HOME/.goenv"
if [ -e $GOENV_ROOT ]; then
  eval "$(goenv init -)"
  addpath "$GOENV_ROOT/bin"
  addpath "$GOROOT/bin"
  addpath "$GOPATH/bin"
fi

## rust
### install: curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
### uninstall: rustup self uninstall
[ -e $HOME/.cargo/env ] && source $HOME/.cargo/env

## sdkman
### install: curl -s "https://get.sdkman.io" | bash
### uninstall: rm -rf ~/.sdkman
export SDKMAN_DIR="$HOME/.sdkman"
[ -e $SDKMAN_DIR ] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

## cabal(Ubuntu)
### install: sudo apt install cabal-install libffi-dev
### uninstall: sudo apt remove cabal-install libffi-dev
addpath "$HOME/.cabal/bin"
## idris
### install: cabal update; cabal install -f FFI idris

## opem
### install: sudo apt install opam
### install: brew install opam
[ -e "$HOME/.opam/opam-init/init.zsh" ] && source "$HOME/.opam/opam-init/init.zsh" >/dev/null 2>/dev/null

## Docker Desktop
[ -e $HOME/.docker/init-zsh.sh ] && source $HOME/.docker/init-zsh.sh || true

## Temporary local binary
addpath "$HOME/bin"

## joke
source $DOTFILES_PATH/src/zshrc/joke.zsh

########################################
# launch tmux
if type tmux >/dev/null && [ "$TMUX" = "" ]; then
  tmux a || tmux
  exit
fi
