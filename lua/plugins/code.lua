return {
	{
		"stevearc/aerial.nvim",
		keys = {
			{ "<leader>oa", "<cmd>AerialToggle!<cr>", desc = "Open AerialToggle!" },
			{ "]a", "<cmd>AerialNext<cr>", desc = "Aerial Next" },
			{ "[a", "<cmd>AerialPrev<cr>", desc = "Aerial Prev" },
			{ "<leader>fa", "<cmd>Telescope aerial<cr>", desc = "Find Aerial" },
		},
		-- Optional dependencies
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("aerial").setup({
				autojump = true,
				close_on_select = true,
			})
			require("telescope").load_extension("aerial")
		end,
	},
	{
		"danymat/neogen",
		keys = {
			{ "<leader>id", "<cmd>Neogen<cr>", desc = "Insert Doc" },
		},
		config = function()
			require("neogen").setup({ snippet_engine = "luasnip" })
		end,
		-- Uncomment next line if you want to follow only stable versions
		-- version = "*"
	},
	--TODO:config this plugin
	{
		"folke/todo-comments.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},
	{
		"stevearc/conform.nvim",
		event = "CmdlineEnter",
		keys = {
			{
				"<leader>F",
				function()
					require("conform").format({ bufnr = 0 })
				end,
				desc = "Format Code",
			},
		},
		config = function()
			require("conform").setup({
				formatters = { ["tex-fmt"] = {
					command = "tex-fmt",
					args = { "--stdin" },
				} },
				formatters_by_ft = {
					lua = { "stylua" },
					-- Conform will run multiple formatters sequentially
					python = { "isort", "black" },
					-- You can customize some of the format options for the filetype (:help conform.format)
					rust = { "rustfmt", lsp_format = "fallback" },
					-- Conform will run the first available formatter
					javascript = { "prettierd", "prettier", stop_after_first = true },
					tex = { "tex-fmt" },
					c = { "clang-format" },
				},
			})
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*",
				callback = function(args)
					require("conform").format({ bufnr = args.buf })
				end,
			})
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		keys = {
			{
				"<leader>uz",
				function()
					--HACK:Neotree will break ZenMode
					if package.loaded["neo- tree"] then
						vim.cmd.Neotree("close")
					end
					vim.cmd.ZenMode()
				end,
				desc = "Toggle ZenMode",
			},
		},
		opts = {
			plugins = {
				tmux = { enabled = true },
				kitty = {
					enabled = true,
					font = "+4",
				},
			},
		},
		config = true,
	},
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
}
