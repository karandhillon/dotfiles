-- LSP — language intelligence (completions, go-to-def, hover, diagnostics).
-- Server binaries are brew/mise-managed OUTSIDE nvim (see Brewfile /
-- mise config); this file only wires nvim's built-in LSP client to them.
--
-- kotlin_lsp: JetBrains' official Kotlin LSP (IntelliJ engine, pre-alpha,
-- weekly releases). Preset comes from nvim-lspconfig; we override:
--   cmd — brew's formula symlinks the binary as `kotlin-lsp`, while the
--         preset assumes upstream's `intellij-server` name
--   single_file_support — JetBrains' recommendation: the server needs a
--         Gradle/Maven project root, loose .kt files get no client
return {
  "neovim/nvim-lspconfig",
  config = function()
    vim.lsp.config("kotlin_lsp", {
      cmd = { "kotlin-lsp", "--stdio" },
      single_file_support = false,
    })
    vim.lsp.enable("kotlin_lsp")

    -- Standard LSP keys, only in buffers with an attached server
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(event)
        local function map(lhs, rhs, desc)
          vim.keymap.set("n", lhs, rhs, { buffer = event.buf, desc = "LSP: " .. desc })
        end
        map("gd", vim.lsp.buf.definition, "go to definition")
        map("gr", function()
          -- fuzzy-searchable references via telescope (lazy-loads on first use)
          require("telescope.builtin").lsp_references()
        end, "references")
        map("K", vim.lsp.buf.hover, "hover docs")
        map("<leader>rn", vim.lsp.buf.rename, "rename symbol")
        map("<leader>ca", vim.lsp.buf.code_action, "code action")
      end,
    })
  end,
}
