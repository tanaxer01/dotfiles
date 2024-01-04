return {
    "neovim/nvim-lspconfig",
    dependencies = {
        -- Lsp
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',

         "j-hui/fidget.nvim",
         "folke/neodev.nvim",
        -- "stevearc/conform.nvim"

        -- Completion
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lua",
        "saadparwaiz1/cmp_luasnip",
    },

    config = function()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

        require("fidget").setup()
        require("neodev").setup()
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
            },
            handlers = {
                function (server_name)
                    require('lspconfig')[server_name].setup {
                        capabilities = capabilities
                    }
                end,
                ["lua_ls"] = function ()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim" }
                                }
                            }
                        }
                    }
                end,
            }
        })

        local cmp = require("cmp")
        local cmp_select = {behavior = cmp.SelectBehavior.Select}

        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,

            },

            mapping = cmp.mapping.preset.insert({
                ["<C-p"] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-n"] = cmp.mapping.select_next_item(cmp_select),
                ["<C-y"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space"] = cmp.mapping.complete(),
            }),

            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
            }, {
                { name = "buffer" },
            })

        })

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

    end
}

