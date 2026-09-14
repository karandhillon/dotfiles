-- bufferline — visual buffer tabs along the top of nvim: every open
-- buffer as a tab with devicon + close button; click to switch, and
-- <leader>1..9 jumps straight to that ordinal. Pairs with lualine
-- (bottom) to complete the IDE-style frame. tokyonight theme matches
-- the rest of the setup; icons from JetBrainsMono Nerd Font.
return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  keys = {
    { "<leader>1", "<cmd>BufferLineGoToBuffer 1<cr>", desc = "Buffer 1" },
    { "<leader>2", "<cmd>BufferLineGoToBuffer 2<cr>", desc = "Buffer 2" },
    { "<leader>3", "<cmd>BufferLineGoToBuffer 3<cr>", desc = "Buffer 3" },
    { "<leader>4", "<cmd>BufferLineGoToBuffer 4<cr>", desc = "Buffer 4" },
    { "<leader>5", "<cmd>BufferLineGoToBuffer 5<cr>", desc = "Buffer 5" },
  },
  opts = {
    options = {
      mode = "buffers",
      themable = true, -- let the colorscheme style it
      numbers = "ordinal",
      diagnostics = "nvim_lsp", -- error/warn counts on the tab
      separator_style = "thin",
      show_buffer_close_icons = true,
      always_show_bufferline = true,
      offsets = {
        -- keep the tab strip aligned when a sidebar-style window opens
        { filetype = "oil", text = "Files", highlight = "Directory" },
      },
    },
  },
}
