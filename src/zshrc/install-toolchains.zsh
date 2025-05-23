########################################
# zplug
ZPLUG_DIR="$HOME/.zplug"
if [ ! -e $ZPLUG_DIR ]; then
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

  # wait for the installation to complete
  for i in $(seq 10); do
    [ -e $ZPLUG_DIR/init.zsh ] && break
    sleep 1
  done
fi

########################################
# fzf
if [ ! -e $HOME/.fzf ]; then
  echo "no fzf at ~/.fzf, installing..."
  git clone https://github.com/junegunn/fzf.git $HOME/.fzf
  $HOME/.fzf/install --no-update-rc --no-completion --no-key-bindings
fi
addpath "$HOME/.fzf/bin"

########################################
# powerline-go
POWERLINE_GO_LINUX_URL="https://github.com/justjanne/powerline-go/releases/download/v1.22.1/powerline-go-linux-amd64"
POWERLINE_GO_MAC_URL="https://github.com/justjanne/powerline-go/releases/download/v1.22.1/powerline-go-darwin-amd64"
POWERLINE_GO_DIR="$HOME/.powerline-go"
POWERLINE_GO_BIN="powerline-go"
if [ ! -e $POWERLINE_GO_DIR ]; then
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
