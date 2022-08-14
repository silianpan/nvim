local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

-- local servers = {
--   emmet_ls = require("user.lsp.settings.emmet_ls"), -- lua/lsp/config/lua.lua
--   jsonls = require("user.lsp.settings.jsonls"),
--   pyright = require("user.lsp.settings.pyright"),
--   solang = require("user.lsp.settings.solang"),
--   solc = require("user.lsp.settings.solc"),
--   sumneko_lua = require("user.lsp.settings.sumneko_lua"),
-- }

-- -- 自动安装 Language Servers
-- for name, config in pairs(servers) do
--   local server_is_found, server = lsp_installer.get_server(name)
--   if server_is_found then
--     if not server:is_installed() then
--       print("Installing " .. name)
--       server:install()
--     else
--       if type(config) == "table" and config.on_init then
--         config.on_init(server)
--         print("onInit " .. type(config))
--       end
--     end
--   end
-- end

-- TODO: add something to installer later
-- require("lspconfig").motoko.setup {}

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }

  if server.name == "jsonls" then
    local jsonls_opts = require "user.lsp.settings.jsonls"
    opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
  end

  if server.name == "sumneko_lua" then
    local sumneko_opts = require "user.lsp.settings.sumneko_lua"
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
  end

  if server.name == "pyright" then
    local pyright_opts = require "user.lsp.settings.pyright"
    opts = vim.tbl_deep_extend("force", pyright_opts, opts)
  end

  if server.name == "jdtls" then
    -- ftplugin/java.lua已经安装，这里会出现重复安装
    -- opts['init_options'] = {
    --   bundles = {
    --       vim.fn.glob(
    --           vim.loop.os_homedir() ..
    --               '/.config/nvim/java-debug/com.microsoft.java.debug.plugin/target/' ..
    --               'com.microsoft.java.debug.plugin-0.36.0.jar'),
    --   },
    -- }
    return
  end

  if server.name == "solang" then
    local solang_opts = require "user.lsp.settings.solang"
    opts = vim.tbl_deep_extend("force", solang_opts, opts)
  end

  if server.name == "solc" then
    local solc_opts = require "user.lsp.settings.solc"
    opts = vim.tbl_deep_extend("force", solc_opts, opts)
  end

  if server.name == "emmet_ls" then
    local emmet_ls_opts = require "user.lsp.settings.emmet_ls"
    opts = vim.tbl_deep_extend("force", emmet_ls_opts, opts)
  end

  -- This setup() function is exactly the same as lspconfig's setup function.
  -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  server:setup(opts)
end)


-- 2022-08-14新增

-- 安装列表
-- { key: 服务器名， value: 配置文件 }
-- key 必须为下列网址列出的 server name，不可以随便写
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
local servers = {
  sumneko_lua = require("user.lsp.config.lua"), -- lua/lsp/config/lua.lua
  bashls = require("user.lsp.config.bash"),
  pyright = require("user.lsp.config.pyright"),
  html = require("user.lsp.config.html"),
  cssls = require("user.lsp.config.css"),
  emmet_ls = require("user.lsp.config.emmet"),
  jsonls = require("user.lsp.config.json"),
  tsserver = require("user.lsp.config.ts"),
  volar = require("user.lsp.config.volar"),
  -- rust_analyzer = require("user.lsp.config.rust"),
  -- remark_ls = require("user.lsp.lang.markdown"),
}

-- 自动安装 Language Servers
for name, config in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found then
    if not server:is_installed() then
      print("Installing " .. name)
      server:install()
    else
      if type(config) == "table" and config.on_init then
        config.on_init(server)
        print("onInit " .. type(config))
      end
    end
  end
end

lsp_installer.on_server_ready(function(server)
  local config = servers[server.name]
  if config == nil then
    return
  end
  if type(config) == "table" and config.on_setup then
    -- 自定义初始化配置文件必须实现on_setup 方法
    config.on_setup(server)
  else
    -- 使用默认参数
    server:setup({})
  end
end)
