local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
nvim_tree.setup({
  sync_root_with_cwd = true,
  actions = {
    change_dir = {
      global = true,
    },
  },
  -- ignore_ft_on_setup = {
  --   "startify",
  --   "dashboard",
  --   "alpha",
  -- },
  filters = {
    custom = { ".git" },
    exclude = { ".gitignore" },
  },
  tab = {
    sync = {
      open = true,
    },
  },
  diagnostics = {
    enable = true,
  },
  update_focused_file = {
    enable = true,
    -- true，开启终端会报错
    update_root = false,
  },
})
