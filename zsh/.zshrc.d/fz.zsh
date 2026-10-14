# fz — the fd | fzf | nvim/bat file picker.
#
#   fz              fuzzy-find files under $PWD, Enter opens in nvim
#   fz <pattern>    same, with the pattern prefilled in the search box
#   fz <dir>        search under <dir> instead (fz ~/dotfiles config)
#
# Keys inside fzf:
#   enter      open selection in nvim — fzf is replaced by nvim, :q lands
#              back at the shell
#   ctrl-o     open in nvim, :q returns *into fzf* to pick another file
#   ctrl-b     page through the whole file in bat (q returns to fzf) —
#              for when the 200-line preview isn't enough
#   tab        mark/unmark files; nvim opens all marked at once
#   ctrl-d/u   scroll the bat preview half a page
#
# No --height: fzf's `become()` (Enter) is incompatible with it; full-screen
# is the right layout for a dedicated picker anyway.
fz() {
  local root="$PWD" query=()
  if (( $# )); then
    [[ -d $1 ]] && { root=$1; shift; }
    query=("--query=$*")
  fi

  fd --type f --hidden --follow \
     --exclude .git --exclude node_modules . "$root" \
    | fzf --multi \
        "${query[@]}" \
        --prompt 'fz❯ ' \
        --preview 'bat --color=always --style=numbers --line-range :200 {}' \
        --preview-window 'right,60%,border-left' \
        --layout=reverse --info=inline \
        --bind 'ctrl-d:preview-page-down,ctrl-u:preview-page-up' \
        --bind 'ctrl-b:execute(bat --paging=always {} < /dev/tty > /dev/tty 2>&1)' \
        --bind 'ctrl-o:execute(nvim {+} < /dev/tty > /dev/tty 2>&1)' \
        --bind 'enter:become(nvim {+})'
}
