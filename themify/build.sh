#!/usr/bin/env bash
set -euo pipefail

# Regenerate ghostty theme files from themify's palette confs.
# Run this after editing themes/*.conf. The output is COMMITTED, so a fresh
# checkout works without running this — it exists to keep the generated
# themes in sync with the palette.

ROOT="$(cd "$(dirname "$0")" && pwd)"
THEMES="$ROOT/.config/bin/themes"
GHOSTTY_THEMES="$ROOT/../ghostty/.config/ghostty/themes"
PI_THEMES="$ROOT/../pi/.pi/agent/themes"

for d in "$GHOSTTY_THEMES" "$PI_THEMES"; do
  [[ -d "$d" ]] || {
    echo "themify/build.sh: themes dir not found: $d" >&2
    exit 1
  }
done

PI_TINTS=(MIST BORDER_DIM SEARCH_BG USER_MSG_BG CUSTOM_MSG_BG BGREEN \
          TOOL_PENDING_BG TOOL_SUCCESS_BG TOOL_ERROR_BG THINKING_OFF INFO_BG)

for conf in "$THEMES"/*.conf; do
  name="$(basename "$conf" .conf)"
  # shellcheck disable=SC1090
  source "$conf"

  # fail fast: this theme must define the full ANSI set
  for i in $(seq 0 15); do
    role="ANSI_$i"
    if [[ -z "${!role:-}" ]]; then
      echo "themify/build.sh: $name.conf is missing color role: $role" >&2
      exit 1
    fi
  done
  for role in "${PI_TINTS[@]}"; do
    if [[ -z "${!role:-}" ]]; then
      echo "themify/build.sh: $name.conf is missing pi tint role: $role" >&2
      exit 1
    fi
  done

  out="$GHOSTTY_THEMES/$name"
  {
    echo "# GENERATED from themify/themes/$name.conf by themify/build.sh — edit the conf, not this file"
    echo "background = $BG"
    echo "foreground = $FG"
    echo "cursor-color = $ACCENT"
    echo "cursor-text = $BG"
    echo "selection-foreground = $ANSI_15"
    echo "selection-background = $BG_SEL"
    for i in $(seq 0 15); do
      role="ANSI_$i"
      printf 'palette = %d=%s\n' "$i" "${!role}"
    done
  } > "$out"
  echo "generated $out"

  # --- pi theme (vars from the palette; colors reference var names, so the
  # section below is a static template identical for every theme) ---
  out="$PI_THEMES/$name.json"
  cat > "$out" <<EOF
{
  "\$schema": "https://raw.githubusercontent.com/earendil-works/pi/main/packages/coding-agent/src/modes/interactive/theme/theme-schema.json",
  "name": "$name",
  "vars": {
    "bg": "$BG",
    "fg": "$FG",
    "panel": "$BG_ALT",
    "borderDim": "$BORDER_DIM",
    "slate": "$FG_MUTED",
    "mist": "$MIST",
    "blue": "$BLUE",
    "bblue": "$ANSI_12",
    "cyan": "$TEAL",
    "bcyan": "$ANSI_14",
    "green": "$GREEN",
    "bgreen": "$BGREEN",
    "magenta": "$MAGENTA",
    "bmagenta": "$ANSI_13",
    "red": "$RED",
    "bred": "$ANSI_9",
    "yellow": "$YELLOW",
    "byellow": "$ANSI_11"
  },
  "colors": {
    "accent": "blue",
    "border": "slate",
    "borderAccent": "bblue",
    "borderMuted": "borderDim",
    "success": "green",
    "error": "red",
    "warning": "yellow",
    "muted": "mist",
    "dim": "slate",
    "text": "",
    "thinkingText": "mist",

    "selectedBg": "panel",
    "scrollbarTrack": "borderDim",
    "scrollbarThumb": "slate",
    "searchMatchBg": "$SEARCH_BG",
    "searchMatchText": "fg",
    "userMessageBg": "$USER_MSG_BG",
    "userMessageText": "fg",
    "customMessageBg": "$CUSTOM_MSG_BG",
    "customMessageText": "fg",
    "customMessageLabel": "bmagenta",
    "toolPendingBg": "$TOOL_PENDING_BG",
    "toolSuccessBg": "$TOOL_SUCCESS_BG",
    "toolErrorBg": "$TOOL_ERROR_BG",
    "toolTitle": "bblue",
    "toolOutput": "mist",

    "mdHeading": "bmagenta",
    "mdLink": "blue",
    "mdLinkUrl": "mist",
    "mdCode": "cyan",
    "mdCodeBlock": "fg",
    "mdCodeBlockBorder": "slate",
    "mdQuote": "mist",
    "mdQuoteBorder": "slate",
    "mdHr": "slate",
    "mdListBullet": "bblue",

    "toolDiffAdded": "bgreen",
    "toolDiffRemoved": "bred",
    "toolDiffContext": "mist",

    "syntaxComment": "slate",
    "syntaxKeyword": "magenta",
    "syntaxFunction": "blue",
    "syntaxVariable": "bblue",
    "syntaxString": "green",
    "syntaxNumber": "byellow",
    "syntaxType": "bcyan",
    "syntaxOperator": "fg",
    "syntaxPunctuation": "mist",

    "thinkingOff": "$THINKING_OFF",
    "thinkingMinimal": "slate",
    "thinkingLow": "cyan",
    "thinkingMedium": "blue",
    "thinkingHigh": "magenta",
    "thinkingXhigh": "bmagenta",
    "thinkingMax": "bred",

    "bashMode": "yellow"
  },
  "export": {
    "pageBg": "$BG",
    "cardBg": "$BG_ALT",
    "infoBg": "$INFO_BG"
  }
}
EOF
  echo "generated $out"
done
