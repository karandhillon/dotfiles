-- trouble.nvim — the IDE "Problems panel": every LSP diagnostic in the
-- project in one pretty, navigable list. Sits alongside the built-in
-- quickfix tools; `[d`/`]d` walk errors in-file, this shows everything.
--
-- Loaded lazily by <leader>xx only. Themable — tokyonight styles it
-- automatically like the rest of the UI.
return {
  "folke/trouble.nvim",
  -- version="*" would pin the v3.7.1 tag, whose treesitter view calls
  -- TSHighlighter._on_line — removed in nvim 0.12. Track main until the
  -- fix (3fb3bd7, #656) is tagged; lazy-lock pins the exact commit anyway.
  branch = "main",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "Trouble",
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Diagnostics (this file)" },
    { "<leader>XX", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (project)" },
  },
  opts = {},
}
