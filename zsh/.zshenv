# Environment for EVERY zsh — including scripts. Plain variables and PATH
# only; nothing slow, nothing interactive (those live in .zshrc).

# rust/cargo
. "$HOME/.cargo/env"

# Homebrew (Apple Silicon): prepend so /opt/homebrew/bin precedes /usr/bin:/bin.
# Critical for tmux plugins that use `#!/usr/bin/env bash` shebangs — /bin/bash
# is ancient 3.2 on macOS (no associative arrays), which breaks tokyo-night-tmux.
# Here (not .zshrc) so zsh scripts spawned without an interactive parent find
# brew-installed tools too.
eval "$(/opt/homebrew/bin/brew shellenv)"

# Android SDK
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$PATH:$ANDROID_HOME/platform-tools"
export PATH="$PATH:$ANDROID_HOME/tools"
export PATH="$PATH:$ANDROID_HOME/Emulator"

# personal scripts + themify
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/.config/bin"   # themify + friends

# mise shims — lets non-interactive shells (nvim's tree-sitter calls, scripts,
# tmux panes) resolve mise-managed tools (node, npm:* CLIs) without waiting
# for the full `mise activate` in .zshrc. Harmless in interactive shells too:
# activation prepends the real install dirs ahead of the shims.
export PATH="$PATH:$HOME/.local/share/mise/shims"

# plain environment for tools and scripts
export JAVA_HOME="$(/usr/libexec/java_home)"
export EDITOR="nvim"
