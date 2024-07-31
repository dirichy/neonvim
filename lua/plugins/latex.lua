return {
	{
		"dirichy/latex.nvim",
		ft = "tex",
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
