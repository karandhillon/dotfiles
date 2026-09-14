# ── completion (cached: full rescan at most once a day) ─────────────────────
autoload -Uz compinit
if [[ -n $HOME/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# completion behavior + interactive # comments (oh-my-zsh used to provide these)
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
setopt interactive_comments

# ── prompt: the robbyrussell look, hand-rolled (➜ dir git:(branch)) ─────────
# No dirty ✗ marker: a per-prompt `git status` costs ~260ms in big repos.
# Ask `git st` / tig when you want to know — the prompt stays instant.
setopt prompt_subst   # evaluate $(...) in PROMPT (omz used to enable this)
PROMPT='%(?:%F{green}➜:%F{red}➜%s) %F{cyan}%~%f $(git_prompt_info)'

git_prompt_info() {
  local ref
  ref=$(command git symbolic-ref --short HEAD 2>/dev/null) \
    || ref=$(command git rev-parse --short HEAD 2>/dev/null) \
    || return 0
  ref=${ref//\%/%%}   # a % in a branch name must not eat prompt escapes
  print "%F{blue}git:(%f%F{red}${ref}%f%F{blue})%f"
}

# ── history: bigger, deduped, shared live across terminals ──────────────────
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt share_history hist_ignore_dups hist_ignore_space hist_reduce_blanks

# mise — manages node + other dev tool versions (see mise/.config/mise/config.toml).
# Replaces nvm: no lazy-loading hack needed, activation is single-digit ms.
# Interactive shells get dynamic per-directory PATH; non-interactive shells
# use the shims dir put on PATH in .zshenv.
eval "$(mise activate zsh)"

# ── zoxide: smarter cd (must come after compinit; docs' requirement) ───────
# cd keeps all normal behavior (~, .., -) and additionally jumps to
# frecency-matched dirs; cdi = interactive picker (fzf). Database is machine
# state: ~/Library/Application Support/zoxide/ — never committed.
eval "$(zoxide init zsh --cmd cd)"

# ── modules: ~/.zshrc.d/*.zsh — drop a file in to add a module ──────────────
# (graft's shell integration also installs itself here if ever re-enabled)
for f in ~/.zshrc.d/*.zsh(N); do
  source "$f"
done

# ── zsh-autosuggestions (Fish-style gray suggestions from history) ──────────
# Per upstream INSTALL.md (Homebrew): sourced at the END of .zshrc.
source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

