-- Colorscheme — tokyonight "night", deliberately matching the tmux status
-- bar, which is FIXED to tokyo-night "night" and never theme-switched
-- (see themify.md). The rest of the desktop themes around this constant.
--
-- Named tokyonight.lua (NOT colorscheme.lua) on purpose: themify's nvim
-- hook anchors on nvim/lua/plugins/colorscheme.lua and rewrites its
-- colorscheme line on theme switches — we don't want that, since no nvim
-- colorschemes exist for the original palettes (sora/cendre). This keeps
-- themify's nvim step skipping loudly, as it does today.
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
