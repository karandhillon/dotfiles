-- =============================================================================
-- KEYMAPS CONFIGURATION
-- Location: nvim/lua/config/keymaps.lua
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 1. General Keymaps
-- -----------------------------------------------------------------------------

-- Rapid Exit: Use 'jj' to exit insert mode quickly without reaching for Esc
vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit Insert Mode" })

-- Convenience: Quick save with Leader + w
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save File" })

-- Buffer Management: Close current buffer (keeps window layout)
vim.keymap.set("n", "<leader>bk", "<cmd>bd<cr>", { desc = "Buffer Kill (Close)" })


-- -----------------------------------------------------------------------------
-- 2. Telescope (Fuzzy Finder)
-- -----------------------------------------------------------------------------
local builtin = require('telescope.builtin')

-- File & Text Search
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Global Search (Grep)' })
vim.keymap.set('n', '<leader>fs', builtin.grep_string, { desc = 'Search Word Under Cursor' })

-- Navigation & History
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'List Open Buffers' })
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = 'Recent Files (History)' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Search Help Documentation' })

-- In-File Search: Fuzzy search inside the current active buffer
vim.keymap.set('n', '<leader>/', function()
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = 'Fuzzy Search in Current File' })
