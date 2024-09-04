return {
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
				formatters_by_ft = {
					lua = { "stylua" },
					-- Conform will run multiple formatters sequentially
					python = { "isort", "black" },
					-- You can customize some of the format options for the filetype (:help conform.format)
					rust = { "rustfmt", lsp_format = "fallback" },
					-- Conform will run the first available formatter
					javascript = { "prettierd", "prettier", stop_after_first = true },
					tex = { "latexindent" },
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
		commands = "ZenMode",
		keys = {
			{ "<leader>uz", "<cmd>ZenMode<cr>", desc = "Toggle ZenMode" },
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
}
