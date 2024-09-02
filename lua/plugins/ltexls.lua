return {
	"barreiroleo/ltex_extra.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
	},
	ft = { "tex", "latex", "bib" },
	config = function() end,
	keys = {
		{
			"<leader>tc",
			function()
				vim.api.nvim_exec2("w", {})
				vim.api.nvim_exec2("LtexCheckDocument", {})
			end,
			desc = "Latex Check English",
		},
	},
}
