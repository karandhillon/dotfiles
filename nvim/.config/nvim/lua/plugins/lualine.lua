-- lualine — statusline worth reading: mode, git branch, file, LSP
-- diagnostics, position. Theme matches the editor (tokyonight).
-- Icons on: the terminal font is JetBrainsMono Nerd Font (all icon
-- codepoints verified present) — the old tofu-box blocker is gone.
-- nvim-web-devicons supplies the per-filetype glyph.
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  opts = {
    options = {
      theme = "tokyonight",
      icons_enabled = true,
      component_separators = { left = "│", right = "│" },
      section_separators = {},
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch" },
      lualine_c = { "filename" },
      lualine_x = { "diagnostics", "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
  },
}
