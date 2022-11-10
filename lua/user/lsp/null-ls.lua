local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

-- https://github.com/prettier-solidity/prettier-plugin-solidity
-- npm install --save-dev prettier prettier-plugin-solidity

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
      filter = function(client)
          -- apply whatever logic you want (in this example, we'll only use null-ls)
          return client.name == "null-ls"
      end,
      bufnr = bufnr,
      async = true,
  })
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- add to your shared on_attach callback
local on_attach = function(client, bufnr)
  if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
              lsp_formatting(bufnr)
          end,
      })
  end
end

-- ----------------------- 异步格式化 start -------------------
-- local async_formatting = function(bufnr)
--   bufnr = bufnr or vim.api.nvim_get_current_buf()

--   vim.lsp.buf_request(
--       bufnr,
--       "textDocument/formatting",
--       vim.lsp.util.make_formatting_params({}),
--       function(err, res, ctx)
--           if err then
--               local err_msg = type(err) == "string" and err or err.message
--               -- you can modify the log message / level (or ignore it completely)
--               vim.notify("formatting: " .. err_msg, vim.log.levels.WARN)
--               return
--           end

--           -- don't apply results if buffer is unloaded or has been modified
--           if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_buf_get_option(bufnr, "modified") then
--               return
--           end

--           if res then
--               local client = vim.lsp.get_client_by_id(ctx.client_id)
--               vim.lsp.util.apply_text_edits(res, bufnr, client and client.offset_encoding or "utf-16")
--               vim.api.nvim_buf_call(bufnr, function()
--                   vim.cmd("silent noautocmd update")
--               end)
--           end
--       end
--   )
-- end

-- local on_attach = function(client, bufnr)
--   if client.supports_method("textDocument/formatting") then
--       vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
--       vim.api.nvim_create_autocmd("BufWritePost", {
--           group = augroup,
--           buffer = bufnr,
--           callback = function()
--               async_formatting(bufnr)
--           end,
--       })
--   end
-- end
-- ----------------------- 异步格式化 end -------------------

null_ls.setup {
  on_attach = on_attach,
  debug = false,
  sources = {
    formatting.prettier.with {
      extra_filetypes = { "toml", "solidity" },
      -- extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
      extra_args = { "--config ~/.prettierrc", "--single-quote", "--vue-indent-script-and-style" },
    },
    formatting.black.with { extra_args = { "--fast" } },
    formatting.stylua,
    formatting.shfmt,
    formatting.google_java_format,
    -- diagnostics.flake8,
    diagnostics.shellcheck,
  },
}

local unwrap = {
  method = null_ls.methods.DIAGNOSTICS,
  filetypes = { "rust" },
  generator = {
    fn = function(params)
      local diagnostics = {}
      -- sources have access to a params object
      -- containing info about the current file and editor state
      for i, line in ipairs(params.content) do
        local col, end_col = line:find "unwrap()"
        if col and end_col then
          -- null-ls fills in undefined positions
          -- and converts source diagnostics into the required format
          table.insert(diagnostics, {
            row = i,
            col = col,
            end_col = end_col,
            source = "unwrap",
            message = "hey " .. os.getenv("USER") .. ", don't forget to handle this" ,
            severity = 2,
          })
        end
      end
      return diagnostics
    end,
  },
}

null_ls.register(unwrap)
