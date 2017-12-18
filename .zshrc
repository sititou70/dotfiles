# 少し凝った zshrc a little edited by sititou70
# License : MIT
# http://mollifier.mit-license.org/

########################################
# 環境変数
export LANG=ja_JP.UTF-8

# 色を使用出来るようにする
autoload -Uz colors
colors

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# 1行表示
PROMPT=$'%{\e[0;37m%}%~%{\e[0;36m%}% $ %{\e[0m%}'


# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

########################################
# 補完
# 補完機能を有効にする
autoload -U compinit
compinit
zstyle ':completion:*:default' menu select=2

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin


########################################
# vcs_info
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

# zstyle ':vcs_info:*' formats '%F{green}[%b]%f'
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats $'%F%{\e[0;36m%}% [%b]%{\e[0m%}%f'
zstyle ':vcs_info:*' actionformats '%F{red}[%b|%a]%f'

function _save_command_line() {
  _pre_command_line=$1
}
add-zsh-hook preexec _save_command_line

function _update_vcs_info_msg() {
  case "${_pre_command_line}" in
    cd*|git\ checkout*|git\ mrege*|git\ pull*|git\ branch\ -m*)
      if test -d .git
      then
        LANG=en_US.UTF-8 vcs_info
        RPROMPT="${vcs_info_msg_0_}"
      else
        RPROMPT=""
      fi
    ;;
  esac
  _pre_command_line=""
}
add-zsh-hook precmd _update_vcs_info_msg


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
# エイリアス
alias ls='ls --color=auto'
alias la='ls -a'
alias ll='ls -al'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias mkdir='mkdir -p'

# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '

########################################
#another settings

# dircolors setting
eval $(dircolors ~/.dircolors)
if [ -n "$LS_COLORS" ]; then
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi

# skipping word when press Ctrl+ArrowKey
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

