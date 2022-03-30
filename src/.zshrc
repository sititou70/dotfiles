########################################
# basics
export LANG=ja_JP.UTF-8
export DOTFILES_PATH="$HOME/dotfiles"

# use color
autoload -Uz colors
colors

# history
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt share_history
setopt hist_ignore_all_dups

# word separator
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

# completion
autoload -Uz compinit && compinit -C
zstyle ':completion:*:default' menu select=2
## enable after sudo
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
## completion in the middle name
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# etc
setopt print_eight_bit
setopt no_beep
setopt no_flow_control
setopt ignore_eof
setopt interactive_comments

########################################
# key binndings
# skipping word when press Ctrl+ArrowKey
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
## for MAC
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

bindkey "^H" backward-kill-word

# substring search
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

# enable alias after sudo
alias sudo='sudo '

# open
type xdg-open >/dev/null
if [ "$?" = "0" ]; then
  alias open='xdg-open'
fi

# git graph
alias gitgraph-all='git log --graph --oneline --date-order --all'
alias gitgraph-all-merges='git log --graph --oneline --date-order --merges --all'
alias gitgraph-all-decoration='git log --graph --oneline --date-order --simplify-by-decoration --all'
alias gitgraph-fzf="git for-each-ref --format='%(refname:short)' | fzf -m | xargs git log --graph --oneline --date-order"
alias gitgraph-fzf-merges="git for-each-ref --format='%(refname:short)' | fzf -m | xargs git log --graph --oneline --date-order --merges"
alias gitgraph-fzf-decoration="git for-each-ref --format='%(refname:short)' | fzf -m | xargs git log --graph --oneline --date-order --simplify-by-decoration"

########################################
# coreutils for Mac (brew install coreutils)
type brew >/dev/null
if [ "$?" = "0" ]; then
  COREUTILS_PATH="$(brew --prefix coreutils)/libexec/gnubin"
  [ -e "$COREUTILS_PATH" ] && PATH="$COREUTILS_PATH:$PATH"
fi

########################################
# dircolors setting
type dircolors >/dev/null
if [ "$?" = "0" ]; then
  eval $(dircolors ~/.dircolors)

  if [ -n "$LS_COLORS" ]; then
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
  fi
fi

########################################
# gpg-agent
type gpgconf >/dev/null
if [ "$?" = "0" ]; then
  export GPG_TTY=$(tty)
  gpgconf --launch gpg-agent
  export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
fi

########################################
# install tmux
TMUX_DIR="$HOME/.tmux"
TMUX_LINUX_BIN="https://github.com/tmux/tmux/releases/download/3.1b/tmux-3.1b-x86_64.AppImage"

if [ ! -e $TMUX_DIR -a $(uname -m) = "x86_64" ]; then
  echo installing tmux...
  mkdir $TMUX_DIR
  cd $TMUX_DIR

  case ${OSTYPE} in
  linux*)
    wget $TMUX_LINUX_BIN
    mv $(basename $TMUX_LINUX_BIN) tmux
    chmod 744 tmux
    ;;
  esac

  cd ..
fi

[ -e $TMUX_DIR ] && PATH+=":$TMUX_DIR"

########################################
# exa
# install
EXA_DIR="$HOME/.exa"
EXA_LINUX_URL="https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip"
EXA_LINUX_BIN="exa-linux-x86_64"
EXA_MAC_URL="https://github.com/ogham/exa/releases/download/v0.9.0/exa-macos-x86_64-0.9.0.zip"
EXA_MAC_BIN="exa-macos-x86_64"
if [ ! -e $EXA_DIR -a $(uname -m) = "x86_64" ]; then
  echo installing exa...
  mkdir $EXA_DIR
  cd $EXA_DIR

  case ${OSTYPE} in
  linux*)
    wget $EXA_LINUX_URL
    unzip $(basename $EXA_LINUX_URL)
    rm -rf $(basename $EXA_LINUX_URL)
    ;;
  darwin*)
    wget $EXA_MAC_URL
    unzip $(basename $EXA_MAC_URL)
    rm -rf $(basename $EXA_MAC_URL)
    ;;
  esac

  cd ..
fi

# ls alias
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

# exacolors
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
# install fzf
if [ ! -e $HOME/.fzf ]; then
  echo "no fzf at ~/.fzf, installing..."
  git clone https://github.com/junegunn/fzf.git $HOME/.fzf
  $HOME/.fzf/install
fi
PATH+=":$HOME/.fzf/bin"

########################################
# powerline-go
POWERLINE_GO_LINUX_URL="https://github.com/justjanne/powerline-go/releases/download/v1.17.0/powerline-go-linux-amd64"
POWERLINE_GO_MAC_URL="https://github.com/justjanne/powerline-go/releases/download/v1.17.0/powerline-go-darwin-amd64"
POWERLINE_GO_DIR="$HOME/.powerline-go"
POWERLINE_GO_BIN="powerline-go"
if [ ! -e $POWERLINE_GO_DIR -a $(uname -m) = "x86_64" ]; then
  echo installing powerline go
  mkdir $POWERLINE_GO_DIR

  case ${OSTYPE} in
  linux*)
    wget -O $POWERLINE_GO_DIR/$POWERLINE_GO_BIN $POWERLINE_GO_LINUX_URL
    ;;
  darwin*)
    wget -O $POWERLINE_GO_DIR/$POWERLINE_GO_BIN $POWERLINE_GO_MAC_URL
    ;;
  esac

  chmod 700 $POWERLINE_GO_DIR/$POWERLINE_GO_BIN
fi

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

## history search
function select-history() {
  BUFFER=$(
    history -n -r 1 |
      fzf \
        +m \
        -e \
        --height 50% \
        --prompt=" > " \
        --query "$LBUFFER" \
        --no-sort
  )
  CURSOR=$#BUFFER
}

zle -N select-history
bindkey '^r' select-history

## fzf file search
function search-file() {
  file_path=$(
    find . -type f |
      fzf \
        +m \
        -e \
        --height 50% \
        --prompt=" > " \
        --no-sort \
        --reverse
  )
  LBUFFER+="\"$file_path\""
}

zle -N search-file
bindkey '^f' search-file

## cd to dir
function cdf() {
  target="$(
    find . -type d |
      fzf \
        +m \
        -e \
        --height 50% \
        --prompt=" > " \
        --no-sort \
        --reverse
  )"
  [ "$target" = "" ] && return

  cd "$target"
}

## open file
function opf() {
  target="$(
    find . -type f |
      fzf \
        +m \
        -e \
        --height 50% \
        --prompt=" > " \
        --no-sort \
        --reverse
  )"
  [ "$target" = "" ] && return

  open "$target"
}

########################################
# software settings
# n (curl -L https://git.io/n-install | bash)
export N_PREFIX="$HOME/n"
[[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"

# goenv (git clone https://github.com/syndbg/goenv.git ~/.goenv)
export GOENV_ROOT="$HOME/.goenv"
if [ -e $GOENV_ROOT ]; then
  export PATH="$GOENV_ROOT/bin:$PATH"
  eval "$(goenv init -)"
  export PATH="$GOROOT/bin:$PATH"
  export PATH="$PATH:$GOPATH/bin"
fi

# rust (curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh)
[ -e $HOME/.cargo/env ] && source $HOME/.cargo/env

# joke
source $DOTFILES_PATH/src/joke.zshrc

########################################
# launch tmux
type tmux >/dev/null
if [ "$TMUX" = "" -a "$?" = "0" ]; then
  tmux a || tmux
  exit
fi
