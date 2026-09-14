-- blink.cmp — completion engine: turns LSP/buffer/path candidates into an
-- auto-popup fuzzy menu while typing.
--
-- Architecture (see the "three worlds" note in the session that added this):
-- Lua glue coordinates; the fuzzy matching hot path is a compiled Rust
-- module (prebuilt binary, downloaded automatically with a pinned version —
-- no cargo needed). LSP candidates come from nvim's built-in client, so this
-- works with kotlin_lsp with zero changes to lsp.lua.
--
-- Sources: lsp (project-aware, slow-ish, the smart one) + path + snippets +
-- buffer words (instant, dumb-but-handy). All merged and ranked by Rust.
return {
  "saghen/blink.cmp",
  version = "1.*", -- pin: prebuilt Rust binaries ship per release
  opts = {
    keymap = {
      -- NOTE: blink 1.x's super-tab preset makes Tab ACCEPT the top item
      -- (VS Code-style) instead of cycling. We override to the classic
      -- behavior: Tab/S-Tab walk the list, Enter accepts, Tab still
      -- indents when no menu is open (fallback), and plain Tab in visual
      -- mode keeps indenting (mappings are insert-mode scoped by blink).
      preset = "super-tab",
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      ["<CR>"] = { "accept", "fallback" }, -- Enter accepts, else newline
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
  },
}
