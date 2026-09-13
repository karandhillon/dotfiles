# tmux package

`.config/tmux/tmux.conf` only — `plugins/` (TPM installs) and `resurrect/`
(session state) are intentionally **not** tracked; bootstrap re-creates them
(TPM clone + `prefix I`).

## Status bar

`janoamaral/tokyo-night-tmux` (TPM), **stock** — fixed to the `night` theme.
The bar is deliberately not theme-switched; `themify` only recolors tmux's
copy-mode selection and pane borders (subtle elements that harmonize with any
theme). The previously patched sora/cendre variants were retired; the patched
copy is archived at `~/dotfiles-archive/tmux-tokyo-night-patched` if ever
wanted again.
