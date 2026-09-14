-- Colorscheme — tokyonight "night", deliberately matching the tmux status
-- bar, which is FIXED to tokyo-night "night" and never theme-switched.
-- (Historical note: the retired themify engine had an nvim hook that
-- anchored on nvim/lua/plugins/colorscheme.lua and rewrote its colorscheme
-- line on theme switches — this file is deliberately NOT named that, so
-- no future engine revives that hook by accident.)
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
