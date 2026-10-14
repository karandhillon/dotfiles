# dotfiles

My macOS setup in one repo, linked into `~` with [GNU stow](https://www.gnu.org/software/stow/).
One folder per tool; each folder mirrors where its files live under `~`.

## New machine

```sh
git clone https://github.com/karandhillon/dotfiles ~/dotfiles
cd ~/dotfiles && ./bootstrap.sh
```

`bootstrap.sh` is safe to re-run. It installs Homebrew + the `Brewfile`, stows every
package, installs tmux plugins and mise tools, starts skhd, then prints a pass/fail
report and the few manual steps macOS insists on.

## Layout

| Folder | Links to | What |
|---|---|---|
| `zsh/` | `~/.zshenv`, `~/.zshrc`, `~/.zshrc.d/` | shell — env + PATH in `.zshenv`, interactive setup in `.zshrc`, add-ons in `.zshrc.d/` |
| `git/` | `~/.config/git/` | identity, delta pager, `st` / `co` / `lg` aliases, gh as credential helper |
| `nvim/` | `~/.config/nvim/` | editor — one file per plugin in `lua/plugins/` |
| `tmux/` | `~/.config/tmux/` | prefix is `` ` ``; plugins installed by TPM into `plugins/` (gitignored) |
| `ghostty/` | `~/.config/ghostty/` | terminal + cursor-trail shader |
| `tig/` | `~/.config/tig/` | git TUI |
| `ideavim/` | `~/.config/ideavim/` | vim keys in Android Studio |
| `mise/` | `~/.config/mise/` | runtime versions (node, tree-sitter) |
| `skhd/` | `~/.config/skhd/` | global hotkeys — `alt-1` Ghostty, `alt-2` Chrome |
| `Brewfile` | — | every brew formula and app, grouped by purpose |
| `bootstrap.sh` | — | new-machine setup |

Machine-only shell settings go in `~/.zshrc.d/local.zsh` — loaded automatically, gitignored.

## Theme

Tokyonight **night** everywhere: Ghostty's built-in theme, the `tokyonight.nvim`
plugin, and the `tokyo-night-tmux` bar. Nothing to sync — each tool names it once.

## State that stays out of the repo

- tmux plugins → `~/.config/tmux/plugins/` (gitignored, reinstalled by bootstrap)
- tmux sessions → `~/.local/share/tmux/resurrect/`
- nvim plugins → `~/.local/share/nvim/` (versions pinned in `lazy-lock.json`)

## Credits

- Cursor-trail shader — [sahaj-b/ghostty-cursor-shaders](https://github.com/sahaj-b/ghostty-cursor-shaders), based on [Inigo Quilez's 2D SDF article](https://iquilezles.org/articles/distfunctions2d/)
- JetBrains Mono Nerd Font — [JetBrains/JetBrainsMono](https://github.com/JetBrains/JetBrainsMono) + Nerd Font icons (OFL 1.1)

## License

[MIT](LICENSE). Vendored third-party pieces keep their own licenses.
