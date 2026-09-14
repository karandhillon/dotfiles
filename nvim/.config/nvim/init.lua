-- <leader> must be set BEFORE lazy.setup() — lazy bakes it into its
-- keymaps (keys = {...} specs) at setup time; later changes come too late
-- and every <leader> map would silently fall back to vim's default `\`.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Line numbers: hybrid mode — current line shows its absolute number,
-- every other line shows distance from cursor (jumps like 5j / d7d become
-- readable at a glance)
vim.opt.number = true
vim.opt.relativenumber = true

-- Escape insert mode with jj
vim.keymap.set("i", "jj", "<Esc>")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = { { import = "plugins" } },
})
