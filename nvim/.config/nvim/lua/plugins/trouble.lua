-- trouble.nvim — the IDE "Problems panel": every LSP diagnostic in the
-- project in one pretty, navigable list. Sits alongside the built-in
-- quickfix tools; `[d`/`]d` walk errors in-file, this shows everything.
--
-- Loaded lazily by <leader>xx only. Themable — tokyonight styles it
-- automatically like the rest of the UI.
return {
  "folke/trouble.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "Trouble",
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Diagnostics (this file)" },
    { "<leader>XX", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (project)" },
  },
  opts = {},
}
