-- =============================================================================
-- LAZY.NVIM BOOTSTRAPPER
-- Location: nvim/lua/config/lazy.lua
-- =============================================================================

-- 1. Bootstrap lazy.nvim (Automatic installation if missing)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- 2. Setup plugins using the LazyVim spec
require("lazy").setup({
  spec = {
    -- Core LazyVim framework and its default plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- Import your custom plugins from lua/plugins/*.lua
    { import = "plugins" },
  },

  defaults = {
    -- Plugins are NOT lazy-loaded by default (LazyVim handles loading strategy)
    lazy = false,
    -- Use latest git commits for plugins (bleeding edge but usually stable)
    version = false,
  },

  -- 3. UI and Installation Settings
  install = {
    colorscheme = { "tokyonight", "habamax" }
  },

  -- 4. Automatic Update Checker
  checker = {
    enabled = true, -- Periodically check for plugin updates
    notify = false, -- Don't show a popup every time an update is found
  },

  -- 5. Performance Optimizations
  performance = {
    rtp = {
      -- Disable built-in Vim plugins that are rarely used to speed up startup
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
        -- "matchit",    -- Uncomment if you don't use % to jump between tags
        -- "netrwPlugin",-- Uncomment if you use a different file explorer like nvim-tree
      },
    },
  },
})
