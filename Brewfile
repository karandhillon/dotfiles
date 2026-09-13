# Private-machine setup. (Work tooling lives at work — deliberately absent.)
# Install with:  brew bundle --file ~/dotfiles/Brewfile
# NOTE: brew refuses 3rd-party taps until trusted. Before the first bundle run:
#   brew trust asmvik/formulae
#   brew trust felixkratz/formulae

# ── taps ────────────────────────────────────────────────────────────────────
tap "asmvik/formulae"      # yabai fork (no-SIP) + skhd
tap "felixkratz/formulae"  # sketchybar + borders

# ── window manager stack ────────────────────────────────────────────────────
brew "asmvik/formulae/yabai"
brew "asmvik/formulae/skhd"
brew "felixkratz/formulae/sketchybar"
brew "felixkratz/formulae/borders"

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
brew "tree"
brew "bat"           # cat with syntax highlighting
brew "eza"           # ls with icons + git status
brew "zoxide"        # smarter cd (replaces cd via zsh init --cmd cd)
brew "zsh-autosuggestions"   # Fish-style history suggestions (sourced at end of .zshrc)
brew "fzf"           # fuzzy finder (cdi interactive picker, themify fallback)
brew "rsync"
brew "socat"
brew "fswatch"

# ── capture / media (screengif, screenshots, bar volume widget) ────────────
brew "ffmpeg"
brew "gifski"
brew "imagemagick@6"
brew "scrcpy"             # needs adb — comes with the Android SDK, not brew
brew "switchaudio-osx"    # sketchybar volume widget

# ── sketchybar runtime ──────────────────────────────────────────────────────
brew "lua"

# ── apps ────────────────────────────────────────────────────────────────────
cask "ghostty"
cask "handy"              # speech to text

# ── fonts ────────────────────────────────────────────────────────────────────
# SF Pro / SF Mono / SF Symbols are SYSTEM fonts on modern macOS — verified
# via NSFont resolution with zero user font files; nothing to install. (The
# font-sf-pro/-mono casks are also broken on Tahoe: Apple's DMGs hit the
# hdiutil "Resource busy" bug.)
cask "font-sketchybar-app-font"    # app icons in the spaces item
# Google Sans Code (ghostty's font) ships in this repo: fonts/ package.
