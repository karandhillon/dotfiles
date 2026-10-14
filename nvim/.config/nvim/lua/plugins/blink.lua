-- blink.cmp — autocompletion popup (LSP, file paths, snippets, buffer words).
-- Keys: Tab / Shift-Tab cycle the menu, Enter accepts. Without a menu open,
-- Tab indents as usual (fallback).
return {
  "saghen/blink.cmp",
  version = "1.*", -- pinned to releases: they ship the prebuilt fuzzy matcher
  opts = {
    keymap = {
      preset = "enter", -- Enter accepts; Ctrl-Space opens; Ctrl-e closes
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
  },
}
