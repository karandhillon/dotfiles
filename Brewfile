# Private-machine setup. (Work tooling lives at work — deliberately absent.)
# Install with:  brew bundle --file ~/dotfiles/Brewfile
# NOTE: brew refuses 3rd-party taps until trusted. Before the first bundle run:
#   brew trust asmvik/formulae

# ── taps ────────────────────────────────────────────────────────────────────
tap "asmvik/formulae"      # skhd

# ── hotkey daemon ───────────────────────────────────────────────────────────
brew "asmvik/formulae/skhd"

# ── dotfiles machinery ──────────────────────────────────────────────────────
brew "stow"
brew "gum"         # themify picker + reports
brew "shellcheck"

# ── daily CLI ───────────────────────────────────────────────────────────────
brew "git"
brew "git-lfs"
brew "gh"
brew "tig"
brew "lazygit"
brew "git-delta"
brew "difftastic"
brew "jq"
brew "fd"
brew "ripgrep"     # grep on steroids — also telescope's live_grep backend in nvim
brew "tree"
brew "btop"         # system monitor — spot Gradle daemons: / filter, t tree, Enter for cmdline
brew "bat"           # cat with syntax highlighting
brew "eza"           # ls with icons + git status
brew "zoxide"        # smarter cd (replaces cd via zsh init --cmd cd)
brew "zsh-autosuggestions"   # Fish-style history suggestions (sourced at end of .zshrc)
brew "fzf"           # fuzzy finder (cdi interactive picker, themify fallback)
brew "rsync"
brew "socat"
brew "fswatch"
brew "neovim"
brew "tmux"          # config in tmux/; plugins via TPM (bootstrap step 5)
brew "hunk"

# ── capture / media (screengif, screenshots) ───────────────────────────────
brew "ffmpeg"
brew "gifski"
brew "imagemagick@6"
brew "scrcpy"             # needs adb — comes with the Android SDK, not brew

# ── dev toolchain (mise) ───────────────────────────────────────────────────
# Language runtimes + npm CLIs (node, tree-sitter-cli, …) are managed by mise,
# NOT brew — see mise/.config/mise/config.toml. mise itself is the only brew
# formula in this category.
brew "mise"

# ── LSP servers (brew-managed, on PATH for nvim) ────────────────────────────────
# JetBrains' official Kotlin LSP (IntelliJ engine). Pre-alpha but weekly
# releases. Official homebrew-cask; the jetbrains/utils tap fails to tap
# (its formula has no Linux URL, which brew rejects).
cask "kotlin-lsp"
brew "tuicr"            # code-review TUI (vim keys, submits to GitHub/GitLab/…)

# ── apps ────────────────────────────────────────────────────────────────────
cask "ghostty"
cask "handy"              # speech to text

# ── fonts ────────────────────────────────────────────────────────────────────
# SF Pro / SF Mono / SF Symbols are SYSTEM fonts on modern macOS — verified
# via NSFont resolution with zero user font files; nothing to install. (The
# font-sf-pro/-mono casks are also broken on Tahoe: Apple's DMGs hit the
# hdiutil "Resource busy" bug.)
cask "font-jetbrains-mono-nerd-font" # ghostty + tmux icon glyphs (Nerd Font)
