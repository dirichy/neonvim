return {
	"norcalli/nvim-terminal.lua",
	event = "VeryLazy",
	config = function()
		require("terminal").setup({})
	end,
}
