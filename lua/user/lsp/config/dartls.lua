local util = require "lspconfig.util"

return {
  on_setup = function(server)
    server:setup({
      cmd = { "dart", "language-server", "--protocol=lsp" },
      filetypes = { "dart" },
      init_options = {
        closingLabels = true,
        flutterOutline = true,
        onlyAnalyzeProjectsWithOpenFiles = true,
        outline = true,
        suggestFromUnimportedLibraries = true
      },
      root_dir = util.root_pattern { "pubspec.yaml" },
      settings = {
        dart = {
          completeFunctionCalls = true,
          showTodos = true
        }
      },
      on_attach = function(client, _)
        -- 禁用格式化功能，交给专门插件插件处理
        client.server_capabilities.document_formatting = false
        client.server_capabilities.document_range_formatting = false
      end,
    })
  end,
}

