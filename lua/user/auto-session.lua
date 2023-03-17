local status_ok, auto_session = pcall(require, "auto-session")
if not status_ok then
  return
end

local t_status_ok, telescope = pcall(require, "telescope")
if not t_status_ok then
  return
end

local l_status_ok, session_lens = pcall(require, "session-lens")
if not l_status_ok then
  return
end

local nt_status_ok, auto_session_nvim_tree = pcall(require, "auto-session-nvim-tree")
if not nt_status_ok then
  return
end

local function close_nvim_tree()
  -- 过时
  -- require("nvim-tree.view").close()
  require("nvim-tree.api").tree.close()
end

local function open_nvim_tree()
  -- 过时
  -- require('nvim-tree').open()
  require("nvim-tree.api").tree.open()
end

local opts = {
  log_level = "info",
  auto_session_enable_last_session = false,
  auto_session_root_dir = vim.fn.stdpath "data" .. "/sessions/",
  auto_session_enabled = true,
  auto_save_enabled = nil,
  auto_restore_enabled = nil,
  auto_session_suppress_dirs = {
    -- vim.fn.glob(vim.fn.stdpath "config" .. "/*"),
    os.getenv "HOME",
    -- os.getenv "HOME" .. "/Machfiles",
  },
  auto_session_use_git_branch = nil,
  -- the configs below are lua only
  bypass_session_save_file_types = { "alpha" },
  -- 2022-11-11新增
  pre_save_cmds = { close_nvim_tree },
  post_save_cmds = { open_nvim_tree },
  post_open_cmds = { open_nvim_tree },
  post_restore_cmds = { open_nvim_tree },
  cwd_change_handling = {
    restore_upcoming_session = true, -- <-- THE DOCS LIE!! This is necessary!!
  },
}

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

telescope.load_extension "session-lens"

session_lens.setup {
  path_display = { "shorten" },
  -- theme_conf = { border = false },
  previewer = false,
  prompt_title = "Sessions",
}

auto_session.setup(opts)

-- 加上会报错
-- auto_session_nvim_tree.setup(auto_session)
