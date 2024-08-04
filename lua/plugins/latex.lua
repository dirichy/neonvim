return {
	{
		"dirichy/latex.nvim",
		ft = "tex",
		keys = {
			{
				"<leader>tb",
				'<cmd>lua require("latex.compile.arara")()<cr>',
				desc = "Compile LaTeX File",
			},
		},
		config = function()
			require("latex").setup()
		end,
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
