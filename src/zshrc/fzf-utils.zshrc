# history search
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

# fzf file search
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

# cd to dir
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

# open file
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
