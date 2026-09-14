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
      preset = "super-tab", -- Tab cycles when menu open, indents when not
      ["<CR>"] = { "accept", "fallback" }, -- Enter accepts, else newline
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
  },
}
