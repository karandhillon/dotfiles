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
--   cmd_env — the EAP server must run on its bundled JBR 25, but it uses
--         that same JVM to auto-detect a Gradle daemon JVM
--         (GradleToolingApiHelper.findTheMostCompatibleJdk picks the highest
--         compatible JDK it can find = JBR 25). a work project's
--         settings.gradle.kts hard-rejects anything but Zulu 21, which killed
--         every Gradle import → no source index → `gd` silently did nothing.
--         This system property (checked first by the server) pins the Gradle
--         JVM to Zulu 21. Also requires
--         `android.disallowKotlinSourceSets=false` in ~/.gradle/gradle.properties
--         (the LSP's model build trips AGP's built-in-Kotlin guard; normal
--         builds are unaffected).
return {
  "neovim/nvim-lspconfig",
  config = function()
    vim.lsp.config("kotlin_lsp", {
      cmd = {
        "kotlin-lsp",
        "--system-path", vim.fn.stdpath("state") .. "/kotlin-lsp",
        "--stdio",
      },
      single_file_support = false,
      cmd_env = {
        IJ_JAVA_OPTIONS = "-Dcom.jetbrains.ls.imports.gradle.java.home=/Library/Java/JavaVirtualMachines/zulu-21.jdk/Contents/Home",
      },
    })
    vim.lsp.enable("kotlin_lsp")

    -- kotlin-lsp's native launcher (and, if closed mid-import, its JVM)
    -- can outlive nvim and keep holding the workspace index LOCK — the
    -- next `nvim .` then fails with "LOCK: Resource temporarily
    -- unavailable". On exit, kill only OUR launcher (parent = this nvim)
    -- plus true orphans (parent = 1); other live nvim sessions keep theirs.
    vim.api.nvim_create_autocmd("VimLeave", {
      callback = function()
        local me = tostring(vim.fn.getpid())
        local pids = vim.fn.systemlist("pgrep -f 'kotlin-lsp --system-path'") or {}
        for _, pidstr in ipairs(pids) do
          local pid = pidstr:match("%d+")
          if pid then
            local ok, out = pcall(vim.fn.systemlist, ("ps -o ppid= -p %s"):format(pid))
            local ppid = ok and out and out[1] and out[1]:match("%d+") or nil
            if ppid == me or ppid == "1" then
              -- TERM the launcher first, then any JVM child it left behind
              vim.fn.system(("kill -TERM %s; pkill -TERM -P %s"):format(pid, pid))
            end
          end
        end
      end,
    })

    -- Standard LSP keys, only in buffers with an attached server
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(event)
        local function map(lhs, rhs, desc)
          vim.keymap.set("n", lhs, rhs, { buffer = event.buf, desc = "LSP: " .. desc })
        end
        map("<leader>gd", vim.lsp.buf.definition, "go to definition")
        map("<leader>gr", function()
          -- fuzzy-searchable references via telescope (lazy-loads on first use)
          require("telescope.builtin").lsp_references()
        end, "references")
        map("K", vim.lsp.buf.hover, "hover docs")
        map("<leader>rn", vim.lsp.buf.rename, "rename symbol")
        -- code action: using nvim 0.11+ default `gra` instead — frees the
        -- <leader>ca prefix so <leader>caob has no timeout collision
      end,
    })
  end,
}
