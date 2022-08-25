local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

local filetypes = {
	'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'tsx', 'jsx', 'rescript',
	'xml',
	'php',
	'markdown',
	'glimmer','handlebars','hbs'
}
local skip_tags = {
'area', 'base', 'br', 'col', 'command', 'embed', 'hr', 'img', 'slot',
'input', 'keygen', 'link', 'meta', 'param', 'source', 'track', 'wbr','menuitem'
}

-- Windows Terminal
-- require"nvim-treesitter.install".compilers = { "clang" }

local ft_to_parser = require"nvim-treesitter.parsers".filetype_to_parsername
ft_to_parser.motoko = "typescript"

configs.setup({
	ensure_installed = "all", -- one of "all" or a list of languages
	-- Windows Terminal
	-- ensure_installed = { "bash", "c", "cpp", "cmake", "lua", "dart", "css", "go", "json", "html", "http", "java", "javascript", "json5", "julia", "kotlin", "make", "markdown", "vim", "vue", "yaml", "python", "scss", "tsx", "typescript", "php" }, -- one of "all" or a list of languages
	sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
	ignore_install = { "" }, -- List of parsers to ignore installing
	highlight = {
    -- use_languagetree = true,
		enable = true, -- false will disable the whole extension
		-- disable = { "css", "html" }, -- list of language that will be disabled
		disable = { "css", "markdown" }, -- list of language that will be disabled
		additional_vim_regex_highlighting = true,
	},
	autopairs = {
		enable = true,
	},
	-- 启用增量选择模块
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "<CR>",
      node_decremental = "<BS>",
      scope_incremental = "<TAB>",
    },
  },
	-- 启用代码缩进模块 (=)
	-- indent = { enable = true, disable = { "python", "css" } },
	indent = {
    enable = true,
  },
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
	autotag = {
		enable = true,
		disable = { "xml" },
		filetypes = filetypes,
		skip_tags = skip_tags,
	},
	rainbow = {
		enable = true,
		colors = {
			"Gold",
			"Orchid",
			"DodgerBlue",
			-- "Cornsilk",
			-- "Salmon",
			-- "LawnGreen",
		},
		disable = { "html" },
	},
	playground = {
		enable = true,
	},
})

-- 开启 Folding 模块
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- 默认不要折叠
-- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
vim.opt.foldlevel = 99
