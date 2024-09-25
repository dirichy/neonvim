return {
	{
		"dirichy/latex.nvim",
		ft = { "tex", "markdown", "norg" },
		keys = {
			{
				"<leader>tb",
				function()
					vim.cmd.write()
					require("latex.compile.arara")()
				end,
				desc = "Compile LaTeX File",
			},
		},
		config = function()
			require("latex").setup()
		end,
	},
	{
		"dirichy/latex_concealer.nvim",
		ft = "tex",
		config = true,
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
