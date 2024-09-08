return {
	{ "kamalsacranie/nvim-mapper", lazy = false, config = true },
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
		keys = { "j", "k" },
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
		lazy = true,
		event = "ExitPre",
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
		"rainzm/flash-zh.nvim",
		-- keys = { "s", "S", "r", "R", "/", "f", "F" },
		dependencies = "folke/flash.nvim",
		lazy = true,
		event = "VeryLazy",
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					if vim.g.curlang == "zh" then
						require("flash-zh").jump({
							chinese_only = false,
						})
					else
						require("flash").jump()
					end
				end,
				desc = "Flash between Chinese",
			},
			{
				"S",
				mode = { "n", "o", "x" },
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
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		keys = {
			{
				"<leader>e",
				function()
					require("neo-tree.command").execute({ toggle = true, dir = vim.fn.getcwd() })
				end,
				desc = "Open NeoTree",
				mode = { "n", "v" },
			},
			{
				"<leader>oe",
				function()
					require("neo-tree.command").execute({ toggle = true, dir = vim.fn.getcwd() })
				end,
				desc = "Open the neo-tree",
				mode = { "n", "v" },
			},
		},
		opts = {
			-- If a user has a sources list it will replace this one.
			-- Only sources listed here will be loaded.
			-- You can also add an external source by adding it's name to this list.
			-- The name used here must be the same name you would use in a require() call.
			sources = {
				"filesystem",
				"buffers",
				"git_status",
				-- "document_symbols",
			},
			add_blank_line_at_top = false, -- Add a blank line at the top of the tree.
			auto_clean_after_session_restore = true, -- Automatically clean up broken neo-tree buffers saved in sessions
			close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
			default_source = "filesystem", -- you can choose a specific source `last` here which indicates the last used source
			enable_diagnostics = true,
			enable_git_status = true,
			enable_modified_markers = true, -- Show markers for files with unsaved changes.
			enable_opened_markers = true, -- Enable tracking of opened files. Required for `components.name.highlight_opened_files`
			enable_refresh_on_write = true, -- Refresh the tree when a file is written. Only used if `use_libuv_file_watcher` is false.
			enable_cursor_hijack = false, -- If enabled neotree will keep the cursor on the first letter of the filename when moving in the tree.
			enable_normal_mode_for_inputs = false, -- Enable normal mode for input dialogs.
			git_status_async = true,
			-- These options are for people with VERY large git repos
			git_status_async_options = {
				batch_size = 1000, -- how many lines of git status results to process at a time
				batch_delay = 10, -- delay in ms between batches. Spreads out the workload to let other processes run.
				max_lines = 10000, -- How many lines of git status results to process. Anything after this will be dropped.
				-- Anything before this will be used. The last items to be processed are the untracked files.
			},
			hide_root_node = false, -- Hide the root node.
			retain_hidden_root_indent = false, -- IF the root node is hidden, keep the indentation anyhow.
			-- This is needed if you use expanders because they render in the indent.
			log_level = "info", -- "trace", "debug", "info", "warn", "error", "fatal"
			log_to_file = false, -- true, false, "/path/to/file.log", use :NeoTreeLogs to show the file
			open_files_in_last_window = true, -- false = open files in top left window
			open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "edgy", "trouble", "Outline" }, -- when opening files, do not use windows containing these filetypes or buftypes
			-- popup_border_style is for input and confirmation dialogs.
			-- Configurtaion of floating window is done in the individual source sections.
			-- "NC" is a special style that works well with NormalNC set
			popup_border_style = "NC", -- "double", "none", "rounded", "shadow", "single" or "solid"
			resize_timer_interval = 500, -- in ms, needed for containers to redraw right aligned and faded content
			-- set to -1 to disable the resize timer entirely
			--                           -- NOTE: this will speed up to 50 ms for 1 second following a resize
			sort_case_insensitive = false, -- used when sorting files and directories in the tree
			sort_function = nil, -- uses a custom function for sorting files and directories in the tree
			use_popups_for_input = true, -- If false, inputs will use vim.ui.input() instead of custom floats.
			use_default_mappings = true,
			-- source_selector provides clickable tabs to switch between sources.
			source_selector = {
				winbar = false, -- toggle to show selector on winbar
				statusline = false, -- toggle to show selector on statusline
				show_scrolled_off_parent_node = false, -- this will replace the tabs with the parent path
				-- of the top visible node when scrolled down.
				sources = {
					{ source = "filesystem" },
					{ source = "buffers" },
					{ source = "git_status" },
					{ soure = "document_symbols" },
				},
				content_layout = "start", -- only with `tabs_layout` = "equal", "focus"
				--                start  : |/ 󰓩 bufname     \/...
				--                end    : |/     󰓩 bufname \/...
				--                center : |/   󰓩 bufname   \/...
				tabs_layout = "equal", -- start, end, center, equal, focus
				--             start  : |/  a  \/  b  \/  c  \            |
				--             end    : |            /  a  \/  b  \/  c  \|
				--             center : |      /  a  \/  b  \/  c  \      |
				--             equal  : |/    a    \/    b    \/    c    \|
				--             active : |/  focused tab    \/  b  \/  c  \|
				truncation_character = "…", -- character to use when truncating the tab label
				tabs_min_width = nil, -- nil | int: if int padding is added based on `content_layout`
				tabs_max_width = nil, -- this will truncate text even if `text_trunc_to_fit = false`
				padding = 0, -- can be int or table
				-- padding = { left = 2, right = 0 },
				-- separator = "▕", -- can be string or table, see below
				separator = { left = "▏", right = "▕" },
				-- separator = { left = "/", right = "\\", override = nil },     -- |/  a  \/  b  \/  c  \...
				-- separator = { left = "/", right = "\\", override = "right" }, -- |/  a  \  b  \  c  \...
				-- separator = { left = "/", right = "\\", override = "left" },  -- |/  a  /  b  /  c  /...
				-- separator = { left = "/", right = "\\", override = "active" },-- |/  a  / b:active \  c  \...
				-- separator = "|",                                              -- ||  a  |  b  |  c  |...
				separator_active = nil, -- set separators around the active tab. nil falls back to `source_selector.separator`
				show_separator_on_edge = false,
				--                       true  : |/    a    \/    b    \/    c    \|
				--                       false : |     a    \/    b    \/    c     |
				highlight_tab = "NeoTreeTabInactive",
				highlight_tab_active = "NeoTreeTabActive",
				highlight_background = "NeoTreeTabInactive",
				highlight_separator = "NeoTreeTabSeparatorInactive",
				highlight_separator_active = "NeoTreeTabSeparatorActive",
			},
			--
			event_handlers = {
				{
					event = "before_render",
					handler = function(state)
						-- add something to the state that can be used by custom components
					end,
				},
				-- {
				--   event = "file_opened",
				--   handler = function(file_path)
				--     --auto close
				--     require("neo-tree.command").execute({ action = "close" })
				--   end,
				-- },
				-- {
				--   event = "file_opened",
				--   handler = function(file_path)
				--     --clear search after opening a file
				--     require("neo-tree.sources.filesystem").reset_search()
				--   end,
				-- },
				{
					event = "file_renamed",
					handler = function(args)
						-- fix references to file
						-- print(args.source, " renamed to ", args.destination)
					end,
				},
				{
					event = "file_moved",
					handler = function(args)
						-- fix references to file
						print(args.source, " moved to ", args.destination)
					end,
				},
				{
					event = "neo_tree_buffer_enter",
					handler = function()
						vim.cmd("highlight! Cursor blend=100")
					end,
				},
				{
					event = "neo_tree_buffer_leave",
					handler = function()
						vim.cmd("highlight! Cursor guibg=#5f87af blend=0")
					end,
				},
				{
					event = "neo_tree_window_before_open",
					handler = function(args)
						-- print("neo_tree_window_before_open", vim.inspect(args))
					end,
				},
				{
					event = "neo_tree_window_after_open",
					handler = function(args)
						vim.cmd("wincmd =")
					end,
				},
				{
					event = "neo_tree_window_before_close",
					handler = function(args)
						-- print("neo_tree_window_before_close", vim.inspect(args))
					end,
				},
				{
					event = "neo_tree_window_after_close",
					handler = function(args)
						vim.cmd("wincmd =")
					end,
				},
			},
			default_component_configs = {
				container = {
					enable_character_fade = false,
					width = "100%",
					right_padding = 0,
				},
				diagnostics = {
					symbols = {
						hint = "H",
						info = "I",
						warn = "!",
						error = "X",
					},
					highlights = {
						hint = "DiagnosticSignHint",
						info = "DiagnosticSignInfo",
						warn = "DiagnosticSignWarn",
						error = "DiagnosticSignError",
					},
				},
				indent = {
					indent_size = 2,
					padding = 1,
					-- indent guides
					with_markers = true,
					indent_marker = "│",
					last_indent_marker = "└",
					highlight = "NeoTreeIndentMarker",
					-- expander config, needed for nesting files
					with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeExpander",
				},
				icon = {
					folder_closed = "",
					folder_open = "",
					folder_empty = "󰉖",
					folder_empty_open = "󰷏",
					-- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
					-- then these will never be used.
					default = "*",
					highlight = "NeoTreeFileIcon",
				},
				modified = {
					symbol = "[+] ",
					highlight = "NeoTreeModified",
				},
				name = {
					trailing_slash = false,
					highlight_opened_files = false, -- Requires `enable_opened_markers = true`.
					-- Take values in { false (no highlight), true (only loaded),
					-- "all" (both loaded and unloaded)}. For more information,
					-- see the `show_unloaded` config of the `buffers` source.
					use_git_status_colors = true,
					highlight = "NeoTreeFileName",
				},
				git_status = {
					symbols = {
						-- Change type
						added = "✚", -- NOTE: you can set any of these to an empty string to not show them
						deleted = "✖",
						modified = "",
						renamed = "󰁕",
						-- Status type
						untracked = "",
						ignored = "",
						unstaged = "󰄱",
						staged = "",
						conflict = "",
					},
					align = "right",
				},
				-- If you don't want to use these columns, you can set `enabled = false` for each of them individually
				file_size = {
					enabled = true,
					required_width = 64, -- min width of window required to show this column
				},
				type = {
					enabled = true,
					required_width = 110, -- min width of window required to show this column
				},
				last_modified = {
					enabled = true,
					required_width = 88, -- min width of window required to show this column
				},
				created = {
					enabled = false,
					required_width = 120, -- min width of window required to show this column
				},
				symlink_target = {
					enabled = false,
				},
			},
			renderers = {
				directory = {
					{ "indent" },
					{ "icon" },
					{ "current_filter" },
					{
						"container",
						content = {
							{ "name", zindex = 10 },
							{
								"symlink_target",
								zindex = 10,
								highlight = "NeoTreeSymbolicLinkTarget",
							},
							{ "clipboard", zindex = 10 },
							{
								"diagnostics",
								errors_only = true,
								zindex = 20,
								align = "right",
								hide_when_expanded = true,
							},
							{ "git_status", zindex = 10, align = "right", hide_when_expanded = true },
							{ "file_size", zindex = 10, align = "right" },
							{ "type", zindex = 10, align = "right" },
							{ "last_modified", zindex = 10, align = "right" },
							{ "created", zindex = 10, align = "right" },
						},
					},
				},
				file = {
					{ "indent" },
					{ "icon" },
					{
						"container",
						content = {
							{
								"name",
								zindex = 10,
							},
							{
								"symlink_target",
								zindex = 10,
								highlight = "NeoTreeSymbolicLinkTarget",
							},
							{ "clipboard", zindex = 10 },
							{ "bufnr", zindex = 10 },
							{ "modified", zindex = 20, align = "right" },
							{ "diagnostics", zindex = 20, align = "right" },
							{ "git_status", zindex = 10, align = "right" },
							{ "file_size", zindex = 10, align = "right" },
							{ "type", zindex = 10, align = "right" },
							{ "last_modified", zindex = 10, align = "right" },
							{ "created", zindex = 10, align = "right" },
						},
					},
				},
				message = {
					{ "indent", with_markers = false },
					{ "name", highlight = "NeoTreeMessage" },
				},
				terminal = {
					{ "indent" },
					{ "icon" },
					{ "name" },
					{ "bufnr" },
				},
			},
			nesting_rules = {},
			-- Global custom commands that will be available in all sources (if not overridden in `opts[source_name].commands`)
			--
			-- You can then reference the custom command by adding a mapping to it:
			--    globally    -> `opts.window.mappings`
			--    locally     -> `opt[source_name].window.mappings` to make it source specific.
			--
			-- commands = {              |  window {                 |  filesystem {
			--   hello = function()      |    mappings = {           |    commands = {
			--     print("Hello world")  |      ["<C-c>"] = "hello"  |      hello = function()
			--   end                     |    }                      |        print("Hello world in filesystem")
			-- }                         |  }                        |      end
			--
			-- see `:h neo-tree-custom-commands-global`
			commands = {}, -- A list of functions

			window = { -- see https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup for
				-- possible options. These can also be functions that return these options.
				position = "left", -- left, right, top, bottom, float, current
				width = 20, -- applies to left and right positions
				height = 15, -- applies to top and bottom positions
				auto_expand_width = true, -- expand the window when file exceeds the window width. does not work with position = "float"
				popup = { -- settings that apply to float position only
					size = {
						height = "80%",
						width = "50%",
					},
					position = "50%", -- 50% means center it
					-- you can also specify border here, if you want a different setting from
					-- the global popup_border_style.
				},
				same_level = false, -- Create and paste/move files/directories on the same level as the directory under cursor (as opposed to within the directory under cursor).
				insert_as = "child", -- Affects how nodes get inserted into the tree during creation/pasting/moving of files if the node under the cursor is a directory:
				-- "child":   Insert nodes as children of the directory under cursor.
				-- "sibling": Insert nodes  as siblings of the directory under cursor.
				-- Mappings for tree window. See `:h neo-tree-mappings` for a list of built-in commands.
				-- You can also create your own commands by providing a function instead of a string.
				mapping_options = {
					noremap = true,
					nowait = true,
				},
				mappings = {
					-- ["<space>"] = {
					--   "toggle_node",
					--   nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
					-- },
					["<2-LeftMouse>"] = "open",
					["<cr>"] = "open",
					-- ["<cr>"] = { "open", config = { expand_nested_files = true } }, -- expand nested file takes precedence
					["<esc>"] = "cancel", -- close preview or floating neo-tree window
					["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = false } },
					["l"] = "focus_preview",
					["S"] = "open_split",
					-- ["S"] = "split_with_window_picker",
					["s"] = "open_vsplit",
					-- ["sr"] = "open_rightbelow_vs",
					-- ["sl"] = "open_leftabove_vs",
					-- ["s"] = "vsplit_with_window_picker",
					["t"] = "open_tabnew",
					-- ["<cr>"] = "open_drop",
					-- ["t"] = "open_tab_drop",
					["w"] = "open_with_window_picker",
					["C"] = "close_node",
					["z"] = "close_all_nodes",
					--["Z"] = "expand_all_nodes",
					["R"] = "refresh",
					["a"] = {
						"add",
						-- some commands may take optional config options, see `:h neo-tree-mappings` for details
						config = {
							show_path = "none", -- "none", "relative", "absolute"
						},
					},
					["A"] = "add_directory", -- also accepts the config.show_path and config.insert_as options.
					["d"] = "delete",
					["r"] = "rename",
					["y"] = "copy_to_clipboard",
					["x"] = "cut_to_clipboard",
					["p"] = "paste_from_clipboard",
					["c"] = "copy", -- takes text input for destination, also accepts the config.show_path and config.insert_as options
					["m"] = "move", -- takes text input for destination, also accepts the config.show_path and config.insert_as options
					["e"] = "toggle_auto_expand_width",
					["q"] = "close_window",
					["?"] = "show_help",
					["<"] = "prev_source",
					[">"] = "next_source",
				},
			},
			filesystem = {
				window = {
					mappings = {
						["H"] = "toggle_hidden",
						["/"] = "fuzzy_finder",
						["D"] = "fuzzy_finder_directory",
						--["/"] = "filter_as_you_type", -- this was the default until v1.28
						["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
						-- ["D"] = "fuzzy_sorter_directory",
						["f"] = "filter_on_submit",
						["<C-x>"] = "clear_filter",
						["<bs>"] = "navigate_up",
						["."] = "set_root",
						["[g"] = "prev_git_modified",
						["]g"] = "next_git_modified",
						["i"] = "show_file_details",
						["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
						["oc"] = { "order_by_created", nowait = false },
						["od"] = { "order_by_diagnostics", nowait = false },
						["og"] = { "order_by_git_status", nowait = false },
						["om"] = { "order_by_modified", nowait = false },
						["on"] = { "order_by_name", nowait = false },
						["os"] = { "order_by_size", nowait = false },
						["ot"] = { "order_by_type", nowait = false },
					},
					fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
						["<down>"] = "move_cursor_down",
						["<C-n>"] = "move_cursor_down",
						["<up>"] = "move_cursor_up",
						["<C-p>"] = "move_cursor_up",
					},
				},
				async_directory_scan = "auto", -- "auto"   means refreshes are async, but it's synchronous when called from the Neotree commands.
				-- "always" means directory scans are always async.
				-- "never"  means directory scans are never async.
				scan_mode = "shallow", -- "shallow": Don't scan into directories to detect possible empty directory a priori
				-- "deep": Scan into directories to detect empty or grouped empty directories a priori.
				bind_to_cwd = true, -- true creates a 2-way binding between vim's cwd and neo-tree's root
				cwd_target = {
					sidebar = "tab", -- sidebar is when position = left or right
					current = "window", -- current is when position = current
				},
				check_gitignore_in_search = true, -- check gitignore status for files/directories when searching
				-- setting this to false will speed up searches, but gitignored
				-- items won't be marked if they are visible.
				-- The renderer section provides the renderers that will be used to render the tree.
				--   The first level is the node type.
				--   For each node type, you can specify a list of components to render.
				--       Components are rendered in the order they are specified.
				--         The first field in each component is the name of the function to call.
				--         The rest of the fields are passed to the function as the "config" argument.
				filtered_items = {
					visible = false, -- when true, they will just be displayed differently than normal items
					force_visible_in_empty_folder = false, -- when true, hidden files will be shown if the root folder is otherwise empty
					show_hidden_count = true, -- when true, the number of hidden items in each folder will be shown as the last entry
					hide_dotfiles = true,
					hide_gitignored = true,
					hide_hidden = true, -- only works on Windows for hidden files/directories
					hide_by_name = {
						".DS_Store",
						"thumbs.db",
						--"node_modules",
					},
					hide_by_pattern = { -- uses glob style patterns
						--"*.meta",
						--"*/src/*/tsconfig.json"
					},
					always_show = { -- remains visible even if other settings would normally hide it
						".gitignore",
						".nvim.lua",
					},
					never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
						-- ".DS_Store",
						--"thumbs.db"
					},
					never_show_by_pattern = { -- uses glob style patterns
						--".null-ls_*",
					},
				},
				find_by_full_path_words = false, -- `false` means it only searches the tail of a path.
				-- `true` will change the filter into a full path
				-- search with space as an implicit ".*", so
				-- `fi init`
				-- will match: `./sources/filesystem/init.lua
				--find_command = "fd", -- this is determined automatically, you probably don't need to set it
				--find_args = {  -- you can specify extra args to pass to the find command.
				--  fd = {
				--  "--exclude", ".git",
				--  "--exclude",  "node_modules"
				--  }
				--},
				---- or use a function instead of list of strings
				--find_args = function(cmd, path, search_term, args)
				--  if cmd ~= "fd" then
				--    return args
				--  end
				--  --maybe you want to force the filter to always include hidden files:
				--  table.insert(args, "--hidden")
				--  -- but no one ever wants to see .git files
				--  table.insert(args, "--exclude")
				--  table.insert(args, ".git")
				--  -- or node_modules
				--  table.insert(args, "--exclude")
				--  table.insert(args, "node_modules")
				--  --here is where it pays to use the function, you can exclude more for
				--  --short search terms, or vary based on the directory
				--  if string.len(search_term) < 4 and path == "/home/cseickel" then
				--    table.insert(args, "--exclude")
				--    table.insert(args, "Library")
				--  end
				--  return args
				--end,
				group_empty_dirs = false, -- when true, empty folders will be grouped together
				search_limit = 50, -- max number of search results when using filters
				follow_current_file = {
					enabled = false, -- This will find and focus the file in the active buffer every time
					--               -- the current file is changed while the tree is open.
					leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
				},
				hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
				-- in whatever position is specified in window.position
				-- "open_current",-- netrw disabled, opening a directory opens within the
				-- window like netrw would, regardless of window.position
				-- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
				use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
				-- instead of relying on nvim autocmd events.
			},
			buffers = {
				bind_to_cwd = true,
				follow_current_file = {
					enabled = true, -- This will find and focus the file in the active buffer every time
					--              -- the current file is changed while the tree is open.
					leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
				},
				group_empty_dirs = true, -- when true, empty directories will be grouped together
				show_unloaded = false, -- When working with sessions, for example, restored but unfocused buffers
				-- are mark as "unloaded". Turn this on to view these unloaded buffer.
				terminals_first = false, -- when true, terminals will be listed before file buffers
				window = {
					mappings = {
						["<bs>"] = "navigate_up",
						["."] = "set_root",
						["bd"] = "buffer_delete",
						["i"] = "show_file_details",
						["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
						["oc"] = { "order_by_created", nowait = false },
						["od"] = { "order_by_diagnostics", nowait = false },
						["om"] = { "order_by_modified", nowait = false },
						["on"] = { "order_by_name", nowait = false },
						["os"] = { "order_by_size", nowait = false },
						["ot"] = { "order_by_type", nowait = false },
					},
				},
			},
			git_status = {
				window = {
					mappings = {
						["A"] = "git_add_all",
						["gu"] = "git_unstage_file",
						["ga"] = "git_add_file",
						["gr"] = "git_revert_file",
						["gc"] = "git_commit",
						["gp"] = "git_push",
						["gg"] = "git_commit_and_push",
						["i"] = "show_file_details",
						["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
						["oc"] = { "order_by_created", nowait = false },
						["od"] = { "order_by_diagnostics", nowait = false },
						["om"] = { "order_by_modified", nowait = false },
						["on"] = { "order_by_name", nowait = false },
						["os"] = { "order_by_size", nowait = false },
						["ot"] = { "order_by_type", nowait = false },
					},
				},
			},
			document_symbols = {
				follow_cursor = false,
				client_filters = "first",
				renderers = {
					root = {
						{ "indent" },
						{ "icon", default = "C" },
						{ "name", zindex = 10 },
					},
					symbol = {
						{ "indent", with_expanders = true },
						{ "kind_icon", default = "?" },
						{
							"container",
							content = {
								{ "name", zindex = 10 },
								{ "kind_name", zindex = 20, align = "right" },
							},
						},
					},
				},
				window = {
					mappings = {
						["<cr>"] = "jump_to_symbol",
						["o"] = "jump_to_symbol",
						["A"] = "noop", -- also accepts the config.show_path and config.insert_as options.
						["d"] = "noop",
						["y"] = "noop",
						["x"] = "noop",
						["p"] = "noop",
						["c"] = "noop",
						["m"] = "noop",
						["a"] = "noop",
						["/"] = "filter",
						["f"] = "filter_on_submit",
					},
				},
				custom_kinds = {
					-- define custom kinds here (also remember to add icon and hl group to kinds)
					-- ccls
					-- [252] = 'TypeAlias',
					-- [253] = 'Parameter',
					-- [254] = 'StaticMethod',
					-- [255] = 'Macro',
				},
				kinds = {
					Unknown = { icon = "?", hl = "" },
					Root = { icon = "", hl = "NeoTreeRootName" },
					File = { icon = "󰈙", hl = "Tag" },
					Module = { icon = "", hl = "Exception" },
					Namespace = { icon = "󰌗", hl = "Include" },
					Package = { icon = "󰏖", hl = "Label" },
					Class = { icon = "󰌗", hl = "Include" },
					Method = { icon = "", hl = "Function" },
					Property = { icon = "󰆧", hl = "@property" },
					Field = { icon = "", hl = "@field" },
					Constructor = { icon = "", hl = "@constructor" },
					Enum = { icon = "󰒻", hl = "@number" },
					Interface = { icon = "", hl = "Type" },
					Function = { icon = "󰊕", hl = "Function" },
					Variable = { icon = "", hl = "@variable" },
					Constant = { icon = "", hl = "Constant" },
					String = { icon = "󰀬", hl = "String" },
					Number = { icon = "󰎠", hl = "Number" },
					Boolean = { icon = "", hl = "Boolean" },
					Array = { icon = "󰅪", hl = "Type" },
					Object = { icon = "󰅩", hl = "Type" },
					Key = { icon = "󰌋", hl = "" },
					Null = { icon = "", hl = "Constant" },
					EnumMember = { icon = "", hl = "Number" },
					Struct = { icon = "󰌗", hl = "Type" },
					Event = { icon = "", hl = "Constant" },
					Operator = { icon = "󰆕", hl = "Operator" },
					TypeParameter = { icon = "󰊄", hl = "Type" },

					-- ccls
					-- TypeAlias = { icon = ' ', hl = 'Type' },
					-- Parameter = { icon = ' ', hl = '@parameter' },
					-- StaticMethod = { icon = '󰠄 ', hl = 'Function' },
					-- Macro = { icon = ' ', hl = 'Macro' },
				},
			},
			example = {
				renderers = {
					custom = {
						{ "indent" },
						{ "icon", default = "C" },
						{ "custom" },
						{ "name" },
					},
				},
				window = {
					mappings = {
						["<cr>"] = "toggle_node",
						["<C-e>"] = "example_command",
						["d"] = "show_debug_info",
					},
				},
			},
		},
		config = function(_, opts)
			require("neo-tree").setup(opts)
			vim.api.nvim_create_autocmd("TermClose", {
				pattern = "*lazygit",
				callback = function()
					if package.loaded["neo-tree.sources.git_status"] then
						require("neo-tree.sources.git_status").refresh()
					end
				end,
			})
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
		init = function()
			-- FIX: use `autocmd` for lazy-loading neo-tree instead of directly requiring it,
			-- because `cwd` is not set up properly.
			vim.api.nvim_create_autocmd("BufEnter", {
				group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
				desc = "Start Neo-tree with directory",
				once = true,
				callback = function()
					if package.loaded["neo-tree"] then
						return
					else
						local stats = vim.uv.fs_stat(vim.fn.argv(0))
						if stats and stats.type == "directory" then
							require("neo-tree")
						end
					end
				end,
			})
		end,
	},
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
