#!/usr/bin/env bash
#
# bootstrap — dress a fresh Mac from this repo. Two-step setup:
#   git clone <repo> ~/dotfiles && cd dotfiles && ./bootstrap.sh
#
# Design:
#   • idempotent — every step is safe to re-run on an already-set-up machine
#   • fail-safe  — a failing step records the failure and the run CONTINUES;
#                  only a broken Homebrew aborts early (nothing else works
#                  without it). The final report lists every pass/fail/skip.
#   • honest     — no silent skipping: skips say why, failures say what to do

set -uo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"

G=$'\033[32m'; R=$'\033[31m'; Y=$'\033[33m'; B=$'\033[1m'; D=$'\033[2m'; N=$'\033[0m'
declare -a NAMES STATUSES NOTES
COUNT=0

begin() { # step-name
  COUNT=$((COUNT + 1))
  NAMES[COUNT]="$1"
  STATUSES[COUNT]="?"
  NOTES[COUNT]=""
  printf '%s %-40s' "$(printf '%s…%s' "$D" "$N")" "${NAMES[COUNT]}"
}

finish() { # rc note   (rc 0=pass, 2=skip, else=fail)
  local rc=$1 note="${2:-}"
  NOTES[COUNT]="$note"
  case $rc in
    0) STATUSES[COUNT]="pass"; printf '\r%s✓%s %-40s%s%s%s\n' "$G" "$N" "${NAMES[COUNT]}" "$D" "$note" "$N" ;;
    2) STATUSES[COUNT]="skip"; printf '\r%s−%s %-40s%s%s%s\n' "$Y" "$N" "${NAMES[COUNT]}" "$D" "$note" "$N" ;;
    *) STATUSES[COUNT]="fail"; printf '\r%s✗%s %-40s%s%s%s\n' "$R" "$N" "${NAMES[COUNT]}" "$R" "$note" "$N" ;;
  esac
}

abort() { # nothing works without Homebrew
  printf '\n%sABORTED:%s %s\n' "$R" "$N" "$1"
  exit 1
}

# ── 1. preflight ────────────────────────────────────────────────────────────
begin "preflight (macOS, repo, Homebrew)"
[[ "$(uname -s)" == "Darwin" ]] || abort "this bootstrap is for macOS"
[[ -f "$ROOT/Brewfile" ]] || abort "run from inside the dotfiles repo (cd ~/dotfiles && ./bootstrap.sh)"
if ! command -v brew >/dev/null 2>&1; then
  printf '\n%sHomebrew not found — installing (needs your password once):%s\n' "$D" "$N"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" \
    || abort "Homebrew installation failed — resolve and re-run"
  eval "$(command -v brew shellenv 2>/dev/null)" 2>/dev/null || true
fi
command -v brew >/dev/null 2>&1 || abort "brew still not on PATH — open a new shell and re-run"
finish 0 "$(brew --version | head -1)"

# ── 2. trust third-party taps ───────────────────────────────────────────────
begin "trust third-party taps"
rc=0
brew trust asmvik/formulae >/dev/null 2>&1 || rc=1
brew trust felixkratz/formulae >/dev/null 2>&1 || rc=1
brew trust jetbrains/utils >/dev/null 2>&1 || rc=1
finish $rc "asmvik (yabai fork, skhd) + felixkratz (sketchybar, borders) + jetbrains (kotlin-lsp)"

# ── 3. packages ─────────────────────────────────────────────────────────────
begin "brew bundle (packages, apps, fonts)"
out="$(brew bundle --file "$ROOT/Brewfile" 2>&1)"; rc=$?
fresh=$(grep -c '^Installing' <<<"$out" || true)
using=$(grep -c '^Using' <<<"$out" || true)
if (( rc != 0 )); then
  finish $rc "$(grep -E 'failed' <<<"$out" | head -1)"
else
  finish 0 "$fresh new, $using already present"
fi

# ── 4. stow the packages ────────────────────────────────────────────────────
begin "stow packages into ~"
fails=""
count=0
for pkg in "$ROOT"/*/; do
  name="$(basename "$pkg")"
  count=$((count + 1))
  if ! stow_out="$(stow --dir "$ROOT" --target ~ "$name" 2>&1)"; then
    fails+="$name: $(grep -o 'existing target.*' <<<"$stow_out" | head -1); "
  fi
done
if [[ -n "$fails" ]]; then
  finish 1 "CONFLICT — move these aside and re-run: $fails"
else
  finish 0 "$count packages"
fi

# ── 5. sketchybar event providers (C binaries, excluded from git) ──────────
begin "build sketchybar event providers"
sb="$ROOT/sketchybar/.config/sketchybar/helpers"
rc=0
for d in "$sb/event_providers" "$sb/menus"; do
  make -C "$d" >/dev/null 2>&1 || { rc=1; break; }
done
finish $rc "cpu_load, network_load, menus"

# ── 6. tmux plugins ─────────────────────────────────────────────────────────
begin "tmux plugins (TPM)"
tpm="$HOME/.config/tmux/plugins/tpm"
if [[ ! -d "$tpm" ]]; then
  git clone --depth 1 https://github.com/tmux-plugins/tpm "$tpm" 2>/dev/null || { finish 1 "TPM clone failed"; tpm=""; }
fi
if [[ -n "$tpm" ]]; then
  if out="$("$tpm/bin/install_plugins" 2>&1)"; then
    finish 0 "$(grep -c 'Installing' <<<"$out" || true) plugins installed/verified"
  else
    finish 2 "run prefix+I once inside tmux (TPM wants a live server)"
  fi
fi

# ── 7. mise tools (node, npm CLIs — versions in mise/.config/mise/config.toml) ─
# mise itself comes from the Brewfile (step 3); its config is stowed (step 4).
# `mise install` reads the stowed config and installs anything missing —
# idempotent, like `brew bundle`. Tool versions are pinned in the repo, not
# imperatively installed.
begin "mise tools (node, tree-sitter-cli, …)"
if command -v mise >/dev/null 2>&1; then
  out="$(mise install 2>&1)"; rc=$?
  finish $rc "$(mise ls --current 2>/dev/null | awk '{printf "%s ", $1}' | sed 's/ $//')"
else
  finish 1 "mise missing — brew bundle step failed?"
fi

# ── 8. services ─────────────────────────────────────────────────────────────
begin "start services (sketchybar, borders, yabai, skhd)"
note=""
rc=0
for s in sketchybar borders; do
  out="$(brew services start "$s" 2>&1)" || true
  if grep -qi 'already started' <<<"$out"; then note+="$s already; "; else note+="$s started; "; fi
done
for s in yabai skhd; do
  if "$s" --start-service >/dev/null 2>&1; then
    note+="$s ok; "
  else
    rc=1; note+="$s FAILED; "
  fi
done
finish $rc "$note"

# ── 9. report ───────────────────────────────────────────────────────────────
printf '\n%s────────────────────────────────── REPORT ──────────────────────────────────%s\n' "$B" "$N"
passed=0; failed=0; skipped=0
for i in $(seq 1 "$COUNT"); do
  case "${STATUSES[$i]}" in
    pass) passed=$((passed+1)); sym="$(printf '%s✓%s' "$G" "$N")" ;;
    skip) skipped=$((skipped+1)); sym="$(printf '%s−%s' "$Y" "$N")" ;;
    *)    failed=$((failed+1));  sym="$(printf '%s✗%s' "$R" "$N")" ;;
  esac
  printf '%s  %-40s %s\n' "$sym" "${NAMES[$i]}" "${NOTES[$i]}"
done
printf '\n'
if (( failed > 0 )); then
  printf '%s  %d passed, %d failed, %d skipped — fix the ✗ lines above and re-run (safe)%s\n' "$R" "$passed" "$failed" "$skipped" "$N"
else
  printf '%s  %d passed, %d skipped — machine is dressed%s\n' "$G" "$passed" "$skipped" "$N"
fi

# ── manual steps (macOS requires human clicks — cannot be scripted) ────────
cat <<EOF

${B}One-time manual steps${N} (macOS insists on human clicks):
  1. System Settings → Privacy & Security → Accessibility:
     enable ${B}yabai${N}, ${B}skhd${N}, ${B}sketchybar${N}, ${B}borders${N}
     (they appear there after their first run — this bootstrap counts as one)
  2. Optionally set ${B}Ghostty${N} as your default terminal
  3. Start a ${B}new terminal window${N} (picks up PATH: themify, aliases)
  4. Ghostty ignores config edits while config lives behind a symlink —
     reload after edits with ${B}cmd+shift+,${N}
  5. Colors: ${B}themify${N} (picker) or ${B}themify <sora|cendre|mocha|nord|gruvbox|dracula|kanagawa>${N}

${D}Fonts need nothing: SF Pro/Mono are macOS system fonts; Google Sans Code
ships in this repo (fonts/), sketchybar-app-font comes via the Brewfile.${N}
EOF
exit $(( failed > 0 ? 1 : 0 ))
