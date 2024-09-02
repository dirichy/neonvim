return {
	{
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- setting the keybinding for LazyGit with 'keys' is recommended in
		-- order to load the plugin when the command is run for the first time
		keys = {
			{ "<leader>og", "<cmd>LazyGit<cr>", desc = "Open LazyGit" },
		},
		config = function()
			vim.g.lazygit_floating_window_winblend = 0 -- transparency of floating window
			vim.g.lazygit_floating_window_scaling_factor = 0.9 -- scaling factor for floating window
			vim.g.lazygit_floating_window_border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" } -- customize lazygit popup window border characters
			vim.g.lazygit_floating_window_use_plenary = 0 -- use plenary.nvim to manage floating window if available
			vim.g.lazygit_use_neovim_remote = 1 -- fallback to 0 if neovim-remote is not installed

			vim.g.lazygit_use_custom_config_file_path = 0 -- config file path is evaluated if this value is 1
			vim.g.lazygit_config_file_path = "" -- custom config file path
			-- OR
			-- vim.g.lazygit_config_file_path = {} -- table of custom config file paths
			require("telescope").load_extension("lazygit")
		end,
	},
	---@type LazySpec
	{
		"mikavilpas/yazi.nvim",
		-- event = "VeryLazy",
		keys = {
			-- 👇 in this section, choose your own keymappings!
			{
				"<leader>oy",
				function()
					require("yazi").yazi()
				end,
				desc = "Open Yazi",
			},
			{
				-- Open in the current working directory
				"<leader>oY",
				function()
					require("yazi").yazi(nil, vim.fn.getcwd())
				end,
				desc = "Open Yazi in nvim's working directory",
			},
			-- {
			-- 	"<c-up>",
			-- 	function()
			-- 		-- NOTE: requires a version of yazi that includes
			-- 		-- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
			-- 		require("yazi").toggle()
			-- 	end,
			-- 	desc = "Resume the last yazi session",
			-- },
		},
		---@type YaziConfig
		opts = {
			-- if you want to open yazi instead of netrw, see below for more info
			open_for_directories = false,

			-- enable these if you are using the latest version of yazi
			-- use_ya_for_events_reading = true,
			-- use_yazi_client_id_flag = true,

			keymaps = {
				show_help = "?",
			},
		},
	},
}
