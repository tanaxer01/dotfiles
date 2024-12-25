return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{
			-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
			-- used for completion, annotations and signatures of Neovim apis
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = {
					-- Load luvit types when the `vim.uv` word is found
					{ path = "luvit-meta/library", words = { "vim%.uv" } },
				},
			},
		},

		-- Lsp
		'williamboman/mason.nvim',
		'williamboman/mason-lspconfig.nvim',
		'WhoIsSethDaniel/mason-tool-installer.nvim',

		{ "j-hui/fidget.nvim",                           opts = {} },
		{ "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },

		-- Autoformatting
		"stevearc/conform.nvim",
	},

	config = function()
		local capabilities = nil
		if pcall(require, "cmp_nvim_lsp") then
			capabilities = require("cmp_nvim_lsp").default_capabilities()
		end

		require("mason").setup()
		require("mason-tool-installer").setup { ensure_installed = {
			"pyright",
			"stylua",
			"lua_ls",
		}
		}

		local cmp_lsp = require "cmp_nvim_lsp"
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities())

		require("lsp_lines").setup()
		vim.diagnostic.config { virtual_text = true, virtual_lines = false }



		require("fidget").setup({})

		require("mason-lspconfig").setup({
			automatic_installation = true,
			ensure_installed = {
				"lua_ls",
				"rust_analyzer",
			},
			handlers = {
				function(server_name)
					require('lspconfig')[server_name].setup {
						capabilities = capabilities
					}
				end,
			}
		})


		--[[
		vim.diagnostic.config({
			update_in_insert = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})
		--]]


		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local bufnr = args.buf
				local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

				local builtin = require "telescope.builtin"

				-- vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"

				-- # Language server
				vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = 0 })          -- Go to definition
				-- vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, { buffer = 0 })
				vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, { buffer = 0 }) -- Go to declaration
				vim.keymap.set("n", "gy", function() vim.lsp.buf.type_definition() end, { buffer = 0 }) -- Go to type definition
				vim.keymap.set("n", "gI", function() vim.lsp.buf.implementation() end, { buffer = 0 }) -- Go to implementation

				vim.keymap.set("n", "cd", function() vim.lsp.buf.rename() end, { buffer = 0 }) -- Rename (change definition)
				-- vim.keymap.set("n", "gA", function() vim.lsp.buf.references() end, { buffer = 0 })
				vim.keymap.set("n", "gA", builtin.lsp_references, { buffer = 0 })           -- Go to All references to the current word

				-- vim.keymap.set("n", "gs", function() vim.lsp.buf.document_symbol() end, { buffer = 0 })   -- Find symbol in current file
				vim.keymap.set("n", "gs", builtin.lsp_document_symbols, { buffer = 0 })
				vim.keymap.set("n", "gS", function() vim.lsp.buf.workspace_symbol() end, { buffer = 0 }) -- Find symbol in entire project

				vim.keymap.set("n", "g]", function() vim.diagnostic.goto_next() end, { buffer = 0 }) -- Go to next diagnostic
				vim.keymap.set("n", "g[", function() vim.diagnostic.goto_prev() end, { buffer = 0 }) -- Go to previous diagnostic
				vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, { buffer = 0 }) -- Go to next diagnostic
				vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, { buffer = 0 }) -- Go to previous diagnostic
				vim.keymap.set("n", "gh", function() vim.diagnostic.open_float() end, { buffer = 0 }) -- Show inline error (hover)
				vim.keymap.set("n", "g.", function() vim.lsp.buf.code_action() end, { buffer = 0 }) -- Open the code actions menu

				-- # Git (managed by mini.diff)
				-- [H to first git change
				-- [h to prev git change
				-- ]H to last git change
				-- [h Go to next git change

				-- # Treesitter
				-- vim.keymap.set("n", "]x", function() end, { buffer = 0 }) -- Select a smaller syntax node
				-- vim.keymap.set("n", "[x", function() end, { buffer = 0 }) -- Select a larger syntax node

				-- # Multi cursor
				-- g l   Add a visual selection for the next copy of the current word
				-- g L   The same, but backwards
				-- g >   Skip latest word selection, and add next.
				-- g <   The same, but backwards
				-- g a   Add a visual selection for every copy of the current word

				-- # Pane management
				-- g /        Open a project-wide search
				-- g <space>  Open the current search excerpt
				-- <ctrl-w> <space>  Open the current search excerpt in a split
				vim.keymap.set("n", "<lead>gd", function() -- Go to definition in a split
					vim.cmd.new()
					vim.cmd.wncmd("J")
					vim.lsp.buf.definition()
				end, { buffer = 0 })
				vim.keymap.set("n", "<lead>gD", function() -- Go to type definition in a split
					vim.cmd("split")
					-- vim.lsp.buf.type_definition()
				end, { buffer = 0 })


				vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, { buffer = 0 })
				vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, { buffer = 0 })


				require("newconf.autoformat").setup()
			end
		})
	end
}
