local status_ok, bufjump = pcall(require, "bufjump")
if not status_ok then
	vim.notify("没有找到 bufjump")
	return
end
bufjump.setup()

local opts = { silent=true, noremap=true }
vim.api.nvim_set_keymap("n", "<C-n>", "<cmd>lua require('bufjump').backward()<cr>", opts)
vim.api.nvim_set_keymap("n", "<C-p>", "<cmd>lua require('bufjump').forward()<cr>", opts)
