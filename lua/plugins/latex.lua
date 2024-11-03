return {
	{
		not vim.fn.isdirectory("~/nvimtex.nvim/") and "dirichy/nvimtex.nvim",
		dir = vim.fn.isdirectory("~/nvimtex.nvim/") and "~/nvimtex.nvim",
		ft = { "tex", "latex" },
		keys = {
			{
				"<leader>tv",
				function()
					require("nvimtex.view.zathura")()
				end,
				desc = "Compile LaTeX File",
			},
			{
				"<leader>tb",
				function()
					vim.cmd.write()
					require("nvimtex.compile.arara")()
				end,
				desc = "Compile LaTeX File",
			},
		},
		config = function()
			require("nvimtex").setup()
		end,
	},
	{
		"dirichy/latex.nvim",
		ft = { "tex", "markdown", "norg" },
		config = function()
			require("latex_snip").setup()
		end,
	},
	{
		"dirichy/latex_concealer.nvim",
		ft = "tex",
		opts = {},
		config = true,
	},
	{
		"lervag/vimtex",
		lazy = false,
	},
	-- {
	--   "bamonroe/rnoweb-nvim",
	--   lazy=false,
	--   enabled=false,
	--   dependencies={
	--     "nvim-lua/plenary.nvim"
	--   },
	--   config=true,
	-- }
}
