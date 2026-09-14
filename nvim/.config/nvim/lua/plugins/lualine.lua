-- lualine — statusline worth reading: mode, git branch, file, LSP
-- diagnostics, position. Theme matches the editor (tokyonight).
-- icons off: the terminal font (Google Sans Code) is not a Nerd Font,
-- so icon glyphs would render as tofu boxes.
return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      theme = "tokyonight",
      icons_enabled = false,
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
