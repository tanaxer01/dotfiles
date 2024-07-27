return {
    "neovim/nvim-lspconfig",
    dependencies = {
        -- Lsp
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',

         "j-hui/fidget.nvim",
         "folke/neodev.nvim",
        -- "stevearc/conform.nvim"
    },

    config = function()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

        require("fidget").setup({})
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
                    lspconfig.lua_ls.setup({
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim", }
                                }
                            }
                        }
                    })
                end,
            }
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

