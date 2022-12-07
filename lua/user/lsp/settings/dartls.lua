local util = require "lspconfig.util"

return {
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
}
