########################################
# zinit
ZINIT_DIR="$HOME/.local/share/zinit"
if [ ! -e $ZINIT_DIR ]; then
  NO_EDIT=false \
    NO_TUTORIAL=false \
    bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
fi

[ -e $ZINIT_DIR ] && source $ZINIT_DIR/zinit.git/zinit.zsh

########################################
# tmux
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
EXA_DIR="$HOME/.exa"
EXA_LINUX_URL="https://github.com/ogham/exa/releases/download/v0.10.1/exa-linux-x86_64-v0.10.1.zip"
EXA_LINUX_BIN="bin/exa"
EXA_MAC_URL="https://github.com/ogham/exa/releases/download/v0.10.1/exa-macos-x86_64-v0.10.1.zip"
EXA_MAC_BIN="bin/exa"
if [ ! -e $EXA_DIR ]; then
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

########################################
# fzf
if [ ! -e $HOME/.fzf ]; then
  echo "no fzf at ~/.fzf, installing..."
  git clone https://github.com/junegunn/fzf.git $HOME/.fzf
  $HOME/.fzf/install --no-update-rc --no-completion --no-key-bindings
fi
PATH+=":$HOME/.fzf/bin"

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
