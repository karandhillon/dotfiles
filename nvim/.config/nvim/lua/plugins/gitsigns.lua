-- gitsigns — git state in the editing surface:
--   • sign column marks added/changed/deleted lines vs HEAD
--   • ]h / [h            jump next/prev hunk
--   • <leader>hs / hr    stage / reset hunk under cursor
--   • <leader>hp         preview hunk inline
--   • <leader>hb         blame the current line
--   • <leader>tb         toggle whole-file line blame
-- (these are the plugin's defaults; no custom config needed)
return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" }, -- only when a file is opened
  opts = {},
}
