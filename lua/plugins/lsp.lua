return {
	{
		"neovim/nvim-lspconfig",
		cmd = { "Mason", "Neoconf" },
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig",
			"folke/neoconf.nvim",
			{
				"j-hui/fidget.nvim",
				tag = "legacy",
			},
			"nvimdev/lspsaga.nvim",
		},
		-- config = function()
		-- 	require("mason").setup()
		-- 	require("mason-lspconfig").setup()
		-- 	-- if vim.g.ssh then
		-- 	--   require("chinese.rime").setup_rime()
		-- 	-- end
		-- end,
		config = function()
			local servers = {
				lua_ls = {},
				pyright = {},
				jsonls = {},
				marksman = {},
				volar = {},
				dockerls = {},
				docker_compose_language_service = {},
				bashls = {},
				-- ocamllsp = {},
				taplo = {},
				ruff_lsp = {},
				clangd = {},
			}
			local on_attach = function(_, bufnr)
				-- Enable completion triggered by <c-x><c-o>
				local nmap = function(keys, func, desc)
					if desc then
						desc = "LSP: " .. desc
					end

					vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
				end

				nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
				nmap("K", "<cmd>Lspsaga hover_doc<CR>", "Hover Documentation")
				nmap("gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
				-- nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
				nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
				nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
				nmap("<leader>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, "[W]orkspace [L]ist Folders")
				nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
				nmap("<leader>rn", "<cmd>Lspsaga rename ++project<cr>", "[R]e[n]ame")
				nmap("<leader>ca", "<cmd>Lspsaga code_action<CR>", "[C]ode [A]ction")
				nmap("<leader>da", require("telescope.builtin").diagnostics, "[D]i[A]gnostics")
				nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
				-- nmap('gr', vim.lsp.buf.references, '[G]oto [R]eferences')
			end
			require("neoconf").setup()
			require("fidget").setup()
			require("lspsaga").setup()
			require("mason").setup()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			require("mason-lspconfig").setup({
				ensure_installed = vim.tbl_keys(servers),
			})

			require("mason-lspconfig").setup_handlers({
				-- The first entry (without a key) will be the default handler
				-- and will be called for each installed server that doesn't have
				-- a dedicated handler.
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup({ on_attach = on_attach, capabilities = capabilities })
				end,
				-- Next, you can provide a dedicated handler for specific servers.
				-- For example, a handler override for the `rust_analyzer`:
				-- ["latex"] = function()
				--   require("lspconfig").latex.setup({
				--     settings={
				--       texlab={
				--       diagnostics={
				--           ignoredPatterns={
				--             ".*"
				--           },
				--           allowedPatterns={"1"}
				--         }
				--       }
				--     }
				--   })
				-- end,
				["rust_analyzer"] = function()
					require("rust-tools").setup({ on_attach = on_attach, capabilities = capabilities })
				end,
			})
		end,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "~/Documents/.lib/LuaTeX_Lua-API/library/", words = { "tex" } },
			},
			enabled = function(root_dir)
				return vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled
			end,
		},
	},
}
