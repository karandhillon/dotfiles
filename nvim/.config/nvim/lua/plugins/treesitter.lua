return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    -- Install parsers (no-op if already installed). Requires the
    -- tree-sitter CLI on PATH — provided by mise (npm:tree-sitter-cli).
    require("nvim-treesitter").install({
      "bash", "css", "go", "html", "java", "javascript", "json",
      "kotlin", "lua", "python", "tsx", "typescript", "yaml",
    })

    -- Enable treesitter highlighting for every filetype that has a parser
    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })
  end,
}
