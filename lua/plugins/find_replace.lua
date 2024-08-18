return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},
		keys = {
			{ "<leader>fr", "<cmd>lua require('telescope.builtin').oldfiles()<cr>", desc = "Find Recent flies" },
			{ "<leader><space>", "<cmd>lua require('telescope.builtin').buffers({ sort_mru = true })<cr>" },
			{
				"<leader>fb",
				function()
					-- You can pass additional configuration to telescope to change theme, layout, etc.
					require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
						winblend = 10,
						previewer = false,
					}))
				end,
				desc = "Find in current Buffer",
			},
			{
				"<leader>/",
				function()
					-- You can pass additional configuration to telescope to change theme, layout, etc.
					require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
						winblend = 10,
						previewer = false,
					}))
				end,
				desc = "Find in current Buffer",
			},
			{ "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", desc = "Find Files" },
			{ "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", desc = "Live Grep" },
			{ "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", desc = "Find Help" },
			{ "<leader>f?", "<cmd>lua require('telescope.builtin').builtin()<cr>", desc = "Find What to find" },
			{ "<leader>fm", "<cmd>lua require('telescope.builtin').marks()<cr>", desc = "Find Mark" },
			{ "<leader>qf", "<cmd>lua require('telescope.builtin').quickfix()<cr>" },
			{ "<leader>fk", "<cmd>lua require('telescope.builtin').keymaps()<cr>", desc = "Find Keymap" },
			{ "<leader>fc", "<cmd>lua require('telescope.builtin').commands()<cr>", desc = "Find Command" },
		},
		config = function()
			require("telescope").setup({
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
						-- the default case_mode is "smart_case"
					},
				},
			})
			require("telescope").load_extension("fzf")
		end,
	},
	{
		"MagicDuck/grug-far.nvim",
		cmd = { "GrugFar" },
		keys = {
			{ "<leader>or", "<cmd>GrugFar<cr>", desc = "Open Replace Window" },
		},
		config = function()
			require("grug-far").setup({})
		end,
	},
}
