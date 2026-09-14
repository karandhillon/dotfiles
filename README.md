# dotfiles

Everything that defines my machine, in one repo. macOS, managed with
[GNU stow](https://www.gnu.org/software/stow/). Private-machine profile —
work tooling deliberately absent.

## New machine: two steps

```sh
git clone <this-repo> ~/dotfiles
cd dotfiles && ./bootstrap.sh
```

`bootstrap.sh` is idempotent (safe to re-run) and fail-safe: every step
reports pass/fail/skip, failures don't abort the run, and the final report
tells you exactly what worked and what needs attention. It ends with the
one-time manual steps macOS insists on (Accessibility permissions etc).

## The packages

| Package | What it is |
|---|---|
| `zsh/` | shell — `.zshrc` core + `.zshrc.d/` drop-in modules (`aliases.zsh`). Env lives in `.zshenv`. ~0.1s startup, no frameworks. Machine/work-specific config goes in a gitignored `.zshrc.d/work.zsh` — the drop-in loop sources it automatically, so it never ships |
| `ghostty/` | terminal — config, cursor-tail shader, generated theme files. Reload config after edits with `cmd+shift+,` (symlinked config breaks the file watcher) |
| `tmux/` | `tmux.conf` — plugins installed at runtime by TPM (`prefix + I` first run) |
| `yabai/` `skhd/` `borders/` `sketchybar/` | the window-manager stack. Sketchybar's C event providers build via `make` (bootstrap does this) |
| `themify/` | **the theme engine + every color that exists** — see below |
| `pi/` | pi agent config (settings, extensions, prompts, themes). Runtime state (sessions, auth, trust) gitignored |
| `agents/` | cross-tool agent command templates |
| `tig/` `vim/` | tool configs |
| `Brewfile` | curated package list (36 formulae, 4 casks, 3 taps) |
| `bootstrap.sh` | the setup script |

## Theming: one file per theme, every tool follows

```sh
themify                 # gum picker with color previews
themify <name>          # sora | cendre | mocha | nord | gruvbox | dracula | kanagawa
```

Every color in the setup lives in `themify/.config/bin/themes/<name>.conf`
(42 roles: core, status, hues, surfaces, ANSI slots, pi tints).

- **sketchybar** reads the conf at runtime (a pure renderer — zero colors in the bar)
- **ghostty + pi themes** are *generated* from the conf: run
  `themify/build.sh` after editing a palette (output is committed, so
  checkouts work without running it)
- **borders gradient, tmux selection/copy-mode, cursor trail** recolor live

The tmux status bar is deliberately fixed (stock tokyo-night `night`);
only its selection and pane borders follow the theme.

## Notes for future me

- Ghostty: config edits need `cmd+shift+,` to apply (symlink → no file watcher)
- yabai is the [asmvik fork](https://github.com/asmvik/yabai) (no SIP
  requirement), runs via its own launchd service — `yabai --restart-service`
- macOS system fonts cover SF Pro / SF Mono / SF Symbols; don't install them
- pi's session/auth state is inside `pi/` but gitignored — safe to clone public-adjacent
- The archive of everything retired during the migration lives at
  `~/dotfiles-archive/` (not committed)

## Credits

Third-party components, with thanks:

- **themify** engine — imported from [Aejkatappaja/dotfiles](https://github.com/Aejkatappaja/dotfiles) (WTFPL), then extended
- **cursor-tail shader** — from [sahaj-b/ghostty-cursor-shaders](https://github.com/sahaj-b/ghostty-cursor-shaders); based on [Inigo Quilez's 2D SDF article](https://iquilezles.org/articles/distfunctions2d/)
- **sketchybar** stack and helpers — [FelixKratz/SketchyBar](https://github.com/FelixKratz/SketchyBar) and SbarLua
- **yabai** — the [asmvik fork](https://github.com/asmvik/yabai)
- **JetBrainsMono Nerd Font** — via the Brewfile cask ([JetBrains/JetBrainsMono](https://github.com/JetBrains/JetBrainsMono) + Nerd Font icons, OFL 1.1)

## License

[MIT](LICENSE) — my own configuration is free to use, copy, and adapt.
Vendored third-party components remain under their original licenses (see Credits).
