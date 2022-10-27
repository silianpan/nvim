return {
  on_setup = function(server)
    server:setup({
      filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'},
      init_options = {
        documentFeatures = {
          documentColor = false,
          documentFormatting = {
            defaultPrintWidth = 100
          },
          documentSymbol = true,
          foldingRange = true,
          linkedEditingRange = true,
          selectionRange = true
        },
        languageFeatures = {
          callHierarchy = true,
          codeAction = true,
          codeLens = true,
          completion = {
            defaultAttrNameCase = "kebabCase",
            defaultTagNameCase = "both"
          },
          definition = true,
          diagnostics = true,
          documentHighlight = true,
          documentLink = true,
          hover = true,
          implementation = true,
          references = true,
          rename = true,
          renameFileRefactoring = true,
          schemaRequestService = true,
          semanticTokens = false,
          signatureHelp = true,
          typeDefinition = true
        },
        -- typescript = {
        --   serverPath = ""
        -- }
      },
      on_attach = function(client, bufnr)
        -- 禁用格式化功能，交给专门插件插件处理
        client.server_capabilities.document_formatting = false
        client.server_capabilities.document_range_formatting = false
        client.server_capabilities.documentFormattingProvider = false -- 0.8 and later
        local function buf_set_keymap(...)
          vim.api.nvim_buf_set_keymap(bufnr, ...)
        end
        -- 绑定快捷键
        require("keybindings").mapLSP(buf_set_keymap)
      end,
    })
  end,
}
