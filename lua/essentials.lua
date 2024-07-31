local option = vim.opt
local buffer = vim.b
local global = vim.g
-- Globol Settings --
global.maplocalleader = ","
option.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,terminal"
option.foldmethod = "expr"
option.foldexpr = "nvim_treesitter#foldexpr()"
option.foldlevelstart = 99
option.showmode = false
option.backspace = { "indent", "eol", "start" }
option.tabstop = 2
option.shiftwidth = 2
option.expandtab = true
option.shiftround = true
option.autoindent = true
option.smartindent = true
option.number = true
option.relativenumber = true
option.wildmenu = true
option.hlsearch = false
option.confirm = true
option.ignorecase = true
option.smartcase = true
option.completeopt = { "menuone", "noselect" }
option.cursorline = true
option.termguicolors = true
option.signcolumn = "yes"
option.autoread = true
option.title = true
option.swapfile = true
option.backup = false
option.updatetime = 50
option.mouse = "a"
option.undofile = true
option.undodir = vim.fn.expand("$HOME/.local/share/nvim/undo")
option.exrc = true
option.wrap = false
option.splitright = true

-- Buffer Settings --
buffer.fileenconding = "utf-8"

-- Global Settings --
global.mapleader = " "

-- Key mappings --
vim.keymap.set("n", "<A-Tab>", "<cmd>bNext<CR>")

vim.keymap.set("v", "J", "<cmd>m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", "<cmd>m '<-2<CR>gv=gv")

vim.keymap.set({ "v", "n" }, "<leader>y", '"+y')
vim.keymap.set({ "n" }, "<leader>qq", "<cmd>qa<cr>")
vim.keymap.set("n", "<leader>tt", function()
	local api = vim.api

	local bnr = vim.fn.bufnr("%")
	local ns_id = api.nvim_create_namespace("demo")

	local line_num = 5
	local col_num = 5

	local opts = {
		end_line = 10,
		id = 1,
		-- virt_text = { { [[sss  aaa]], "IncSearch" } },
		-- virt_text_pos = 'eol',
		virt_lines = {
			{ { "    ||||", "IncSearch" } },
			{ { "    || |", "IncSearch" } },
			{ { "    |  |", "IncSearch" } },
		},
		virt_text_win_col = 10,
	}

	local mark_id = api.nvim_buf_set_extmark(bnr, ns_id, line_num, col_num, opts)
end)
vim.keymap.set("n", "<Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
