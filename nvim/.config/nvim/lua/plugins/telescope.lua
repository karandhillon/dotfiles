-- Telescope — fuzzy finder UI for files, content search, nvim help, and
-- LSP results. Loaded lazily: only on <leader>f* keys or :Telescope, so
-- it costs nothing until first use.
--
-- live_grep shells out to rg (Brewfile); find_files is pure lua.
return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "Telescope",
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Grep content" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>",  desc = "Help" },
  },
}
