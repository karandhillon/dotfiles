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

-- Sync yank/paste with the macOS clipboard (⌘C/⌘V world). nvim shells out
-- to pbcopy/pbpaste (built into macOS) as its clipboard provider.
vim.opt.clipboard = "unnamedplus"

-- Indentation basics (like font size — plain editor settings, no smarts):
-- Tab inserts spaces, indent steps are 4 columns wide. Matches how the
-- codebase is written. NOTE: Enter auto-indent is NOT here — waiting for
-- nvim-treesitter to ship a kotlin indents.scm upstream (main-branch
-- rewrite is growing language support). Until then, new lines start at col 0.
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

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
