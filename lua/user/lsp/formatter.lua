local status, formatter = pcall(require, "formatter")
if not status then
  vim.notify("没有找到 formatter")
  return
end

formatter.setup({
  filetype = {
    lua = {
      function()
        return {
          exe = "stylua",
          args = {
            -- "--config-path "
            --   .. os.getenv("XDG_CONFIG_HOME")
            --   .. "/stylua/stylua.toml",
            "-",
          },
          stdin = true,
        }
      end,
    },
    rust = {
      -- Rustfmt
      function()
        return {
          exe = "rustfmt",
          args = { "--emit=stdout" },
          stdin = true,
        }
      end,
    },
    javascript = {
      -- prettier
      function()
        return {
          exe = "prettier",
          args = { "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), "--config ~/.prettierrc", "--single-quote", "--vue-indent-script-and-style" },
          stdin = true,
        }
      end,
    },
    vue = {
      -- prettier
      function()
        return {
          exe = "prettier",
          args = { "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), "--config ~/.prettierrc", "--single-quote", "--vue-indent-script-and-style" },
          stdin = true,
        }
      end,
    },
    typescript = {
      -- prettier
      function()
        return {
          exe = "prettier",
          args = { "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), "--config ~/.prettierrc", "--single-quote", "--vue-indent-script-and-style" },
          stdin = true,
        }
      end,
    },
    java = {
      function()
        return {
          exe = "java",
          -- Formatter uses '-' as stdin
          -- Windows Terminal need to change
          args = { "-jar", "/Users/liupan/.local/share/nvim/lsp_servers/jdtls/google-java-format-1.15.0-all-deps.jar", "-" },
          stdin = true,
      }
      end,
    },
  },
})

-- format on save
-- vim.api.nvim_exec(
--   [[
-- augroup FormatAutogroup
--   autocmd!
--   autocmd BufWritePost *.js,*.rs,*.lua,*.java FormatWrite
-- augroup END
-- ]],
--   true
-- )

-- vim.cmd [[
--   augroup format_on_save
--     autocmd! 
--     autocmd BufWritePre * lua vim.lsp.buf.format({ async = false }) 
--   augroup end
-- ]]
-- vim.notify "Enabled format on save"
