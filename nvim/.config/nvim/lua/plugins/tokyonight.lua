-- Colorscheme — tokyonight "night", the same palette as Ghostty and the tmux bar.
return {
  "folke/tokyonight.nvim",
  lazy = false,                -- load at startup
  priority = 1000,             -- before all other plugins
  opts = { style = "night" },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd.colorscheme("tokyonight")
  end,
}
