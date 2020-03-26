# 少し凝った zshrc a little edited by sititou70
# License : MIT
# http://mollifier.mit-license.org/

########################################
# 環境変数
export LANG=ja_JP.UTF-8
export DOTFILES_PATH="$HOME/dotfiles"

# 色を使用出来るようにする
autoload -Uz colors
colors

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified


########################################
# 補完
# 補完機能を有効にする
autoload -U compinit
compinit -C
zstyle ':completion:*:default' menu select=2

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin


########################################
# オプション
# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# beep を無効にする
setopt no_beep

# フローコントロールを無効にする
setopt no_flow_control

# Ctrl+Dでzshを終了しない
setopt ignore_eof

# '#' 以降をコメントとして扱う
setopt interactive_comments

# cd したら自動的にpushdする
setopt auto_pushd

# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups


########################################
# key binndings
# skipping word when press Ctrl+ArrowKey
bindkey "^[^[[C" forward-word
bindkey "^[^[[D" backward-word
## for MAC
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

# substring search
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[OA" history-beginning-search-backward-end
bindkey "^[OB" history-beginning-search-forward-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end


########################################
# exa
alias ll='ls -alh'

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


########################################
# alias
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias mkdir='mkdir -p'

alias grep='grep --color'

alias tree='tree -sh'

# enable alias after sudo
alias sudo='sudo '


########################################
# dircolors setting
type dircolors > /dev/null
if [ "$?" = "0" ]; then
  eval $(dircolors ~/.dircolors)
  if [ -n "$LS_COLORS" ]; then
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
  fi
fi

########################################
# fzf history search
if [ ! -e ~/.fzf ];
then
  echo "no fzf at ~/.fzf, installing..."
  git clone https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
fi

function select-history() {
  BUFFER=$(history -n -r 1 | ~/.fzf/bin/fzf --no-sort --height 40% +m --query "$LBUFFER" --prompt=" > ")
  CURSOR=$#BUFFER
}

zle -N select-history
bindkey '^r' select-history


########################################
# powerline-go
POWERLINE_GO_LINUX_URL="https://github.com/justjanne/powerline-go/releases/download/v1.11.0/powerline-go-linux-amd64"
POWERLINE_GO_MAC_URL="https://github.com/justjanne/powerline-go/releases/download/v1.11.0/powerline-go-darwin-amd64"
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
        -cwd-mode plain
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
# software settings
# n
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

# goenv(git clone https://github.com/syndbg/goenv.git ~/.goenv)
export GOENV_ROOT="$HOME/.goenv"
if [ -e $GOENV_ROOT ]; then
  export PATH="$GOENV_ROOT/bin:$PATH"
  eval "$(goenv init -)"
  export PATH="$GOROOT/bin:$PATH"
  export PATH="$PATH:$GOPATH/bin"
fi


########################################
# launch tmux
type tmux > /dev/null
if [ "$TMUX" = "" -a "$?" = "0" ]; then
  tmux a || tmux
  exit
fi
