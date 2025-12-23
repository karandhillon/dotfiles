# Paths & Environment Variables
export ZSH="$HOME/.oh-my-zsh"
export JAVA_HOME="/usr/lib/jvm/java-17-openjdk"
export ANDROID_HOME="$HOME/Android/Sdk"
export ANDROID_AVD_HOME="$HOME/.config/.android/avd"
export ANDROID_EMULATOR_HOME="$HOME/.config/.android"

# System Path
export PATH="$PATH:$HOME/.local/bin:$JAVA_HOME/bin:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools"

# Oh My Zsh Setup
ZSH_THEME="robbyrussell"
plugins=(git ssh-agent)

# SSH Agent Plugin Configuration
zstyle :omz:plugins:ssh-agent identities id_ed25519
zstyle :omz:plugins:ssh-agent lifetime 4h

source $ZSH/oh-my-zsh.sh

# Aliases
alias ls='eza -la --group-directories-first --icons --octal-permissions --header'
alias vim="nvim"

# To enable vim motions in zsh
bindkey -v
