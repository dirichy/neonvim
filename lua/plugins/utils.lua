return {
	{
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		lazy = true,
		config = function()
			require("nvim-web-devicons").setup({
				override_by_extension = {
					["neo-tree"] = {
						icon = "󱏒",
						color = "#bd19e6",
						name = "Neo-tree",
					},
					["log"] = {
						icon = "",
						color = "#81e043",
						name = "log",
					},
					["sty"] = {
						icon = "",
						color = "#006400",
						name = "sty",
					},
					["m"] = {
						icon = "ℳ",
						color = "#ff8000",
						name = "Matlab",
					},
					["fig"] = {
						icon = "",
						color = "#ff8000",
						name = "MatlabFig",
					},
					["aux"] = {
						icon = "",
						color = "#006400",
						name = "aux",
					},
					["norg"] = {
						icon = "",
						color = "#b34fee",
						name = "norg",
					},
					["lazy"] = {
						icon = "󰒲",
						color = "#0d69f2",
						name = "Lazy",
					},
					["tex"] = {
						icon = "",
						color = "#2c8217",
						name = "TeX",
					},
				},
			})
			require("nvim-web-devicons").set_icon_by_filetype({ ["neo-tree"] = "neo-tree", lazy = "lazy" })
		end,
	},
	{
		"monaqa/dial.nvim",
		keys = {
			{ "<c-a>", "<Plug>(dial-increment)" },
			{ "<c-x>", "<Plug>(dial-decrement)" },
		},
		config = function()
			local augend = require("dial.augend")
			require("dial.config").augends:register_group({
				default = {
					augend.integer.alias.decimal_int,
					augend.integer.alias.hex,
					augend.integer.alias.octal,
					augend.integer.alias.binary,
					augend.date.alias["%Y/%m/%d"],
					augend.date.alias["%Y-%m-%d"],
					augend.date.alias["%m/%d"],
					augend.date.alias["%H:%M"],
					augend.date.alias["%Y年%-m月%-d日"],
					augend.constant.new({
						elements = { "and", "or" },
						word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
						cyclic = true, -- "or" is incremented into "and" .
					}),
					augend.constant.new({
						elements = { "Sun", "Mon", "Tue", "Wed", "Tur", "Fri", "Sat" },
						word = true,
						cyclic = true,
					}),
					augend.constant.new({
						elements = { "monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday" },
						sord = true,
						cyclic = true,
					}),
					augend.constant.new({
						elements = { "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" },
						sord = true,
						cyclic = true,
					}),
					augend.constant.alias.bool,
					augend.constant.alias.alpha,
					augend.constant.alias.Alpha,
				},
			})
		end,
	},
	{
		"nvimtools/hydra.nvim",
		config = function()
			local Hydra = require("hydra")
			Hydra.setup({
				debug = false,
				exit = false,
				foreign_keys = nil,
				color = "red",
				timeout = false,
				invoke_on_body = false,
				hint = {
					show_name = true,
					position = { "bottom" },
					offset = 0,
					float_opts = {},
				},
				on_enter = nil,
				on_exit = nil,
				on_key = nil,
			})
			Hydra({
				name = "Move Screen",
				mode = "n",
				body = "z",
				hint = "z(l|h|L|H)",
				config = {},
				heads = {
					{ "l", "zl", { desc = "" } },
					{ "h", "zh", { desc = "" } },
					{ "L", "zL", { desc = "󰜴" } },
					{ "H", "zH", { desc = "󰜱" } },
					{ "j", "<c-e>", { desc = "" } },
					{ "k", "<c-y>", { desc = "" } },
					{ "J", "<c-d>", { desc = "󰜮" } },
					{ "K", "<c-u>", { desc = "󰜷" } },
				},
			})
		end,
	},
	{
		"gbprod/yanky.nvim",
		dependencies = {
			"kkharji/sqlite.lua",
		},
		keys = {
			{ "p", "<Plug>(YankyPutAfter)", desc = "Yanky Put After" },
			{ "P", "<Plug>(YankyPutBefore)", desc = "Yanky Put Before" },
			{ "y", "<Plug>(YankyYank)", desc = "Yanky Yank" },
			{
				"<leader>fy",
				function()
					require("telescope").extensions.yank_history.yank_history()
				end,
				desc = "Select Yanky History",
			},
		},
		--
		-- require("yanky").setup({
		--   picker = {
		--   }
		-- })
		opts = function()
			local utils = require("yanky.utils")
			local mapping = require("yanky.telescope.mapping")
			return {
				ring = {
					history_length = 1000,
					storage = "sqlite",
					storage_path = vim.fn.stdpath("data") .. "/databases/yanky.db", -- Only for sqlite storage
					sync_with_numbered_registers = true,
					cancel_event = "update",
					ignore_registers = { "_" },
					update_register_on_cycle = false,
				},
				picker = {
					select = {
						action = nil, -- nil to use default put action
					},
					telescope = {
						mappings = {
							default = mapping.put("p"),
							i = {
								["<c-v>"] = mapping.put("p"),
								["<c-b>"] = mapping.put("P"),
								["<c-d>"] = mapping.delete(),
								["<c-c>"] = mapping.set_register(utils.get_default_register()),
							},
							n = {
								p = mapping.put("p"),
								P = mapping.put("P"),
								d = mapping.delete(),
								y = mapping.set_register(utils.get_default_register()),
							},
						},
					},
				},
				system_clipboard = {
					sync_with_ring = true,
					clipboard_register = nil,
				},
				highlight = {
					on_put = true,
					on_yank = true,
					timer = 200,
				},
				preserve_cursor_position = {
					enabled = true,
				},
				textobj = {
					enabled = true,
				},
			}
		end,
		config = function(_, opts)
			require("yanky").setup(opts)
			require("telescope").load_extension("yank_history")
		end,
	},
	{
		"rainbowhxch/accelerated-jk.nvim",
		keys = { "j", "k", "h", "l" },
		config = function()
			require("accelerated-jk").setup({
				mode = "time_driven",
				enable_deceleration = false,
				acceleration_motions = { "j", "k", "l", "h" },
				acceleration_limit = 300,
				acceleration_table = { 7, 10, 13, 15, 17, 18, 19, 20 },
				-- when 'enable_deceleration = true', 'deceleration_table = { {200, 3}, {300, 7}, {450, 11}, {600, 15}, {750, 21}, {900, 9999} }'
				deceleration_table = { { 1000, 9999 } },
			})
		end,
	},
	{
		"folke/persistence.nvim",
		lazy = false,
		-- event = "ExitPre",
		keys = {
			{
				"<leader>qs",
				function()
					--HACK:Nrotree will break nvim-lastplace
					if package.loaded["neo-tree"] then
						vim.cmd([[Neotree close]])
					end
					vim.cmd([[lua require("persistence").load() ]])
				end,
				desc = "Load Session",
			},
			{ "<leader>ql", [[<cmd>lua require("persistence").load({ last = true})<cr>]], desc = "Load Last Session" },
			{
				"<leader>qd",
				[[<cmd>lua require("persistence").stop()<cr><cmd>qa<cr>]],
				desc = "Quit and not save this session",
			},
			{ "<leader>qS", [[<cmd>lua require("persistence").select()<cr>]], desc = "Select Load Session" },
		},
		config = true,
	},
	-- {
	-- 	"windwp/nvim-autopairs",
	-- 	event = "InsertEnter",
	-- 	keys = {
	-- 		{
	-- 			"<leader>ua",
	-- 			function()
	-- 				require("nvim-autopairs").toggle()
	-- 			end,
	-- 			desc = "Toggle Autopairs",
	-- 		},
	-- 	},
	-- 	config = function()
	-- 		local npairs = require("nvim-autopairs")
	-- 		local Rule = require("nvim-autopairs.rule")
	-- 		npairs.setup({
	-- 			check_ts = true,
	-- 			ts_config = {
	-- 				tex = { "inline_formula", "math_environment", "displayed_equation" },
	-- 				latex = { "inline_formula", "math_environment", "displayed_equation" },
	-- 			},
	-- 		})
	-- 		npairs.add_rules({
	-- 			Rule("``", "''", { "tex", "latex" }),
	-- 		})
	-- 	end,
	-- },
	{
		"ethanholz/nvim-lastplace",
		event = { "BufRead" },
		config = true,
		init = function()
			if package.loaded["nvim-lastplace"] then
				return
			end
			local stats = vim.uv.fs_stat(vim.fn.argv(0))
			if stats and stats.type == "file" then
				require("nvim-lastplace").setup()
			end
		end,
	},
	{
		"folke/flash.nvim",
		lazy = true,
		event = "VeryLazy",
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
		config = function()
			require("flash").setup()
			-- local map = vim.keymap.set
			-- for _, key in ipairs(keys) do
			-- 	map(key.mode, key[1], key[2], { desc = key.desc })
			-- end
		end,
	},
	-- {
	--     "kamykn/spelunker.vim",
	--     event = "VeryLazy",
	--     config = function()
	--         vim.g.spelunker_check_type = 2
	--     end,
	-- },
	-- {
	--     "ellisonleao/glow.nvim",
	--     event = "VeryLazy",
	--     config = true,
	-- },
	{
		"folke/which-key.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		event = "VeryLazy",
		config = function()
			local wk = require("which-key")
			wk.setup({
				icons = {
					rules = {
						{ plugin = "lazygit.nvim", icon = "󰊢", color = "orange" },
						{ plugin = "ccc.nvim", icon = "", color = "yellow" },
						{ plugin = "yazi.nvim", icon = "󰇥", color = "blue" },
						{ plugin = "latex.nvim", cat = "filetype", name = "tex" },
						{ pattern = "mason", icon = "", color = "green" },
						{ pattern = "playground", icon = "󰙨", color = "red" },
					},
				},
				win = {
					no_overlap = false,
				},
			})
			wk.add({
				{ "<leader>n", group = "Noice" },
				{ "<leader>o", group = "Open window" },
				{ "<leader>b", group = "Buffer" },
				{ "<leader>t", group = "LaTeX", icon = { cat = "filetype", name = "tex" } },
				{ "<leader>f", group = "Find", icon = { icon = "", color = "blue" } },
				{ "<leader>q", group = "Session" },
				{ "g", group = "Goto" },
				{ "<leader>u", group = "Toggle" },
				{ "<leader>ot", "<cmd>terminal<cr>", desc = "Open Terminal" },
				{ "<leader>ol", "<cmd>Lazy<cr>", desc = "Open Lazy" },
				-- { "<leader>om", "<cmd>Mason<cr>", desc = "Open Mason(for LSP install)", icon = "" },
			})
			wk.add(require("mapper").which_key_spec)
		end,
	},
	{
		"echasnovski/mini.ai",
		event = "VeryLazy",
		config = function()
			local ai = require("mini.ai")
			ai.setup({
				custom_textobjects = {},
			})
		end,
	},
	{
		"echasnovski/mini.comment",
		event = "VeryLazy",
		config = true,
	},
	{
		"s1n7ax/nvim-window-picker",
		opts = {
			hint = "floating-big-letter",
			filter_rules = {
				include_current_win = true,
				bo = {
					filetype = { "fidget", "neo-tree" },
				},
			},
		},
		keys = {
			{
				"<leader>S",
				function()
					local window_number = require("window-picker").pick_window()
					if window_number then
						vim.api.nvim_set_current_win(window_number)
					end
				end,
				desc = "Pick Window",
			},
		},
	},
	{
		"aserowy/tmux.nvim",
		keys = {
			{ "<C-h>", [[<cmd>lua require("tmux").move_left()<cr>]], desc = "Move Left" },
			{ "<C-j>", [[<cmd>lua require("tmux").move_bottom()<cr>]] },
			{ "<C-k>", [[<cmd>lua require("tmux").move_top()<cr>]] },
			{ "<C-l>", [[<cmd>lua require("tmux").move_right()<cr>]] },
		},
		opts = {
			copy_sync = {
				-- enables copy sync. by default, all registers are synchronized.
				-- to control which registers are synced, see the `sync_*` options.
				enable = true,

				-- ignore specific tmux buffers e.g. buffer0 = true to ignore the
				-- first buffer or named_buffer_name = true to ignore a named tmux
				-- buffer with name named_buffer_name :)
				ignore_buffers = { empty = false },

				-- TMUX >= 3.2: all yanks (and deletes) will get redirected to system
				-- clipboard by tmux
				redirect_to_clipboard = false,

				-- offset controls where register sync starts
				-- e.g. offset 2 lets registers 0 and 1 untouched
				register_offset = 0,

				-- overwrites vim.g.clipboard to redirect * and + to the system
				-- clipboard using tmux. If you sync your system clipboard without tmux,
				-- disable this option!
				sync_clipboard = true,

				-- synchronizes registers *, +, unnamed, and 0 till 9 with tmux buffers.
				sync_registers = true,

				-- syncs deletes with tmux clipboard as well, it is adviced to
				-- do so. Nvim does not allow syncing registers 0 and 1 without
				-- overwriting the unnamed register. Thus, ddp would not be possible.
				sync_deletes = true,

				-- syncs the unnamed register with the first buffer entry from tmux.
				sync_unnamed = true,
			},
			navigation = {
				-- cycles to opposite pane while navigating into the border
				cycle_navigation = true,

				-- enables default keybindings (C-hjkl) for normal mode
				enable_default_keybindings = true,

				-- prevents unzoom tmux when navigating beyond vim border
				persist_zoom = false,
			},
			resize = {
				-- enables default keybindings (A-hjkl) for normal mode
				enable_default_keybindings = true,

				-- sets resize steps for x axis
				resize_step_x = 1,

				-- sets resize steps for y axis
				resize_step_y = 1,
			},
		},
		config = true,
	},
	{
		"kkharji/sqlite.lua",
		lazy = true,
		config = false,
	},
	{
		"LunarVim/bigfile.nvim",
		lazy = false,
		config = function()
			-- default config
			require("bigfile").setup({
				filesize = 2, -- size of the file in MiB, the plugin round file sizes to the closest MiB
				pattern = { "*" }, -- autocmd pattern or function see <### Overriding the detection of big files>
				features = { -- features to disable
					"indent_blankline",
					"illuminate",
					"lsp",
					"treesitter",
					"syntax",
					"matchparen",
					"vimopts",
					"filetype",
				},
			})
		end,
	},
}
