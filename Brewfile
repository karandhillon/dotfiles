# Everything brew installs on this machine.
# Install:  brew bundle --file ~/dotfiles/Brewfile   (bootstrap.sh runs this)
# Language runtimes (node, tree-sitter) live in mise, not here — see mise/.

# ── taps ────────────────────────────────────────────────────────────────────
tap "asmvik/formulae"                # skhd (brew refuses it until: brew trust asmvik/formulae)

# ── dotfiles machinery ──────────────────────────────────────────────────────
brew "stow"                          # links each package into ~
brew "mise"                          # runtime versions — mise/.config/mise/config.toml
brew "shellcheck"                    # lint bootstrap.sh and other shell scripts

# ── shell ───────────────────────────────────────────────────────────────────
brew "zsh-autosuggestions"           # gray history suggestions while typing
brew "zoxide"                        # smarter cd (replaces cd; cdi = picker)
brew "fzf"                           # fuzzy finder — fz, cdi
brew "fd"                            # fast find — feeds fz
brew "ripgrep"                       # fast grep — telescope live_grep
brew "bat"                           # cat with syntax colors — aliased as cat
brew "eza"                           # ls with icons — aliased as ls
brew "tree"
brew "jq"
brew "btop"                          # system monitor

# ── git ─────────────────────────────────────────────────────────────────────
brew "git"
brew "git-lfs"
brew "git-delta"                     # diff pager — wired in git/.config/git/config
brew "gh"                            # GitHub CLI (also sets up the SSH key)
brew "tig"                           # git TUI

# ── editor + terminal ───────────────────────────────────────────────────────
brew "neovim"
brew "tmux"                          # plugins via TPM (bootstrap step 5)
cask "ghostty"
cask "font-jetbrains-mono-nerd-font" # icons in ghostty, tmux, nvim

# ── media ───────────────────────────────────────────────────────────────────
brew "ffmpeg"                        # convert / trim video
brew "gifski"                        # high-quality GIFs from video
brew "scrcpy"                        # mirror an Android device (needs adb from the Android SDK)

# ── apps + hotkeys ──────────────────────────────────────────────────────────
brew "asmvik/formulae/skhd"          # global hotkeys — skhd/
cask "handy"                         # speech to text
