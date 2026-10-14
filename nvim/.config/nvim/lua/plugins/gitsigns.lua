-- gitsigns — added/changed/deleted markers in the sign column.
return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" }, -- only when a file is opened
  opts = {},
}
