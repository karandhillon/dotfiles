-- which-key — keymap cheat-sheet: press <leader> (or any incomplete
-- key sequence) and a popup lists every available action, using the
-- `desc` fields already attached to our keymaps.
-- Fuzzy searching keymaps lives in telescope instead: <leader>fk
-- (see telescope.lua) — which-key has no built-in fuzzy filter.
return {
  "folke/which-key.nvim",
  event = "VeryLazy", -- load once the UI is up; zero startup cost
  opts = {},
}
