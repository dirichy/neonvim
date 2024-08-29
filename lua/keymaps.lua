local util = require("util")
-- Key mappings --
vim.keymap.set("n", "<A-Tab>", "<cmd>bNext<CR>")

vim.keymap.set("v", "J", "<cmd>m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", "<cmd>m '<-2<CR>gv=gv")

vim.keymap.set({ "v", "n" }, "<leader>y", '"+y')
vim.keymap.set({ "n" }, "<leader>qq", "<cmd>qa<cr>", { desc = "Quit" })

vim.keymap.set("n", "<leader>uc", util.opt_toggle_fun("conceallevel", 2, 0, "conceal"), { desc = "Togglt Cocneal" })
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
vim.keymap.set("t", "<Esc><Esc>","<C-\\><C-n>",{desc = "Enter Normal Mode"})
