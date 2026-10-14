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
| `ghostty/` | terminal — config, cursor-tail shader. Reload config after edits with `cmd+shift+,` (symlinked config breaks the file watcher) |
| `tmux/` | `tmux.conf` — plugins installed at runtime by TPM (`prefix + I` first run) |
| `skhd/` | hotkey daemon — app-switching hotkeys |
| `agents/` | cross-tool agent command templates |
| `tig/` `vim/` | tool configs |
| `Brewfile` | curated package list (24 formulae, 4 casks, 1 tap) |
| `bootstrap.sh` | the setup script |

## Theming: every tool owns its colors

No central theme engine — each tool's colors live in its own package,
next to its config:

- **ghostty** — built-in `TokyoNight Night` theme, named by `theme =` in config
- **tmux** — selection/pane-border colors inline in `tmux.conf` (status bar is fixed tokyo-night `night`)
- **nvim** — tokyonight plugin, `nvim/.config/nvim/lua/plugins/tokyonight.lua`

## Notes for future me

- Ghostty: config edits need `cmd+shift+,` to apply (symlink → no file watcher)
- macOS system fonts cover SF Pro / SF Mono / SF Symbols; don't install them
- The archive of everything retired during the migration lives at
  `~/dotfiles-archive/` (not committed)

## Credits

Third-party components, with thanks:

- **cursor-tail shader** — from [sahaj-b/ghostty-cursor-shaders](https://github.com/sahaj-b/ghostty-cursor-shaders); based on [Inigo Quilez's 2D SDF article](https://iquilezles.org/articles/distfunctions2d/)
- **JetBrainsMono Nerd Font** — via the Brewfile cask ([JetBrains/JetBrainsMono](https://github.com/JetBrains/JetBrainsMono) + Nerd Font icons, OFL 1.1)

## License

[MIT](LICENSE) — my own configuration is free to use, copy, and adapt.
Vendored third-party components remain under their original licenses (see Credits).
