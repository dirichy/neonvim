local util = require("util")
-- Key mappings --
local map = vim.keymap.set
--Let search forward or backward the 'n' and 'N' behave samely.
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
--Add undo point.
local commas = { ",", ".", "?", ";", "，", "。", "？", "！", "!", "；" }
for _, comma in ipairs(commas) do
	map("i", comma, comma .. "<c-g>u")
end

--go visual mode after indenting in visual mode.
map("v", ">", ">gv")
map("v", "<", "<gv")

--Add comment below or above
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

map("n", "]e", function()
	vim.diagnostic.goto_next({ float = false, severity = vim.diagnostic.severity.ERROR })
end, { desc = "Goto Next Error" })
map("n", "[e", function()
	vim.diagnostic.goto_prev({ float = false, severity = vim.diagnostic.severity.ERROR })
end, { desc = "Goto Prev Error" })
map("n", "]w", function()
	vim.diagnostic.goto_next({ float = false, severity = vim.diagnostic.severity.WARN })
end, { desc = "Goto Next Warning" })
map("n", "[w", function()
	vim.diagnostic.goto_prev({ float = false, severity = vim.diagnostic.severity.WARN })
end, { desc = "Goto Prev Warning" })

map("v", "J", "<cmd>m '>+1<CR>gv=gv")
map("v", "K", "<cmd>m '<-2<CR>gv=gv")

map({ "v", "n" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
map({ "n" }, "<leader>qq", "<cmd>qa<cr>", { desc = "Quit" })
--Toggles
map("n", "<leader>uc", util.opt_toggle_fun("conceallevel", 2, 0, "conceal"), { desc = "Toggle Cocneal" })
map("n", "<leader>up", util.opt_toggle_fun("paste", true, false, "paste"), { desc = "Toggle Paste" })
map("n", "<leader>uw", util.opt_toggle_fun("warp", true, false, "wrap"), { desc = "Toggle Wrap" })

--Inspect
map("n", "<leader>si", vim.show_pos, { desc = "Show Inspect" })
map("n", "<leader>sI", "<cmd>InspectTree<cr>", { desc = "Show InspectTree" })

map("n", "<leader>-", "<c-w>s", { desc = "Split down" })
map("n", "<leader>|", "<c-w>v", { desc = "Split right" })
map("n", "<leader>tt", function()
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
map("n", "<Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Enter Normal Mode" })
