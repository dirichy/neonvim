return {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-cmdline",
		"chrisgrieser/cmp_yanky",
		{
			"saadparwaiz1/cmp_luasnip",
			-- dependencies = {
			-- 	"L3MON4D3/LuaSnip",
			-- },
		},
	},
	config = function()
		local luasnip = require("luasnip")
		local cmp = require("cmp")
		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "path" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "cmp_yanky" },
				{ name = "lazydev" },
			}),
			-- mapping = cmp.mapping.preset.insert({
			-- 	-- cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			-- }),
			experimental = {
				ghost_text = true,
			},
		})
		local key_mapper = require("mapper")

		key_mapper.map_keymap("i", "<cr>", function()
			cmp.confirm({ select = true })
		end, { desc = "Confirm selected cmp item", condition = cmp.visible, priority = 100 })
		key_mapper.map_keymap("i", "<up>", function()
			cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
		end, { condition = cmp.visible, desc = "Cmp Prev Item", priority = 100 })
		key_mapper.map_keymap("i", "<down>", function()
			cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
		end, { condition = cmp.visible, desc = "Cmp Next Item", priority = 100 })
		key_mapper.map_keymap("c", "<up>", function()
			cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
		end, { condition = cmp.get_active_entry, desc = "Cmp Prev Item", priority = 100 })
		key_mapper.map_keymap("c", "<down>", function()
			cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
		end, { condition = cmp.get_active_entry, desc = "Cmp Next Item", priority = 100 })
		key_mapper.map_keymap({ "i", "c" }, "<esc>", function()
			cmp.abort()
		end, { condition = cmp.visible, desc = "Close cmp windows", priority = 100 })
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
				{ name = "cmdline" },
			}),
		})
	end,
}
