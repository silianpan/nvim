-- vim.g.registers_return_symbol = "\n" --'⏎' by default
-- vim.g.registers_tab_symbol = "\t" --'·' by default
-- vim.g.registers_space_symbol = " " --' ' by default


-- 2022-10-02注释掉
-- vim.g.registers_delay = 0 --0 by default, milliseconds to wait before opening the popup window
-- vim.g.registers_register_key_sleep = 0 --0 by default, seconds to wait before closing the window when a register key is pressed
-- vim.g.registers_show_empty_registers = 1 --1 by default, an additional line with the registers without content
-- vim.g.registers_trim_whitespace = 1 --1 by default, don't show whitespace at the begin and end of the registers
-- vim.g.registers_hide_only_whitespace = 1 --0 by default, don't show registers filled exclusively with whitespace
-- vim.g.registers_window_border = "rounded" --'none' by default, can be 'none', 'single','double', 'rounded', 'solid', or 'shadow' (requires Neovim 0.5.0+)
-- vim.g.registers_window_min_height = 3 --3 by default, minimum height of the window when there is the cursor at the bottom
-- vim.g.registers_window_max_width = 100 --100 by default, maximum width of the window
-- vim.g.registers_normal_mode = 1 --1 by default, open the window in normal mode
-- vim.g.registers_visual_mode = 1 --1 by default, open the window in visual mode
-- vim.g.registers_insert_mode = 1 --1 by default, open the window in insert mode


-- vim.g.registers_show = "*+\"" --'*+\"-/_=#%.0123456789abcdefghijklmnopqrstuvwxyz' by default, which registers to show and in what order


local registers_ok, registers = pcall(require, "registers")
if not registers_ok then
	return
end

registers.setup {
  show = "*+\"-/_=#%.0123456789abcdefghijklmnopqrstuvwxyz:",
  show_empty = true,
  register_user_command = true,
  system_clipboard = true,
  trim_whitespace = true,
  hide_only_whitespace = true,
  show_register_types = true,

  bind_keys = {
      normal = registers.show_window({ mode = "motion" }),
      visual = registers.show_window({ mode = "motion" }),
      insert = registers.show_window({ mode = "insert" }),
      registers = registers.apply_register({ delay = 0.1 }),
      return_key = registers.apply_register(),
      escape = registers.close_window(),
      ctrl_n = registers.move_cursor_down(),
      ctrl_p = registers.move_cursor_up(),
      ctrl_j = registers.move_cursor_down(),
      ctrl_k = registers.move_cursor_up(),
  },

  symbols = {
      newline = "⏎",
      space = " ",
      tab = "·",
      register_type_charwise = "ᶜ",
      register_type_linewise = "ˡ",
      register_type_blockwise = "ᵇ",
  },

  window = {
      max_width = 100,
      highlight_cursorline = true,
      border = "none",
      transparency = 10,
  },

  sign_highlights = {
      cursorline = "Visual",
      selection = "Constant",
      default = "Function",
      unnamed = "Statement",
      read_only = "Type",
      expression = "Exception",
      black_hole = "Error",
      alternate_buffer = "Operator",
      last_search = "Tag",
      delete = "Special",
      yank = "Delimiter",
      history = "Number",
      named = "Todo",
  },
}
