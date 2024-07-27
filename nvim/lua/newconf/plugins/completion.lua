return {
    "hrsh7th/nvim-cmp",
    lazy = false,
    priority = 100,
    dependencies = {
        "onsails/lspkind.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        "saadparwaiz1/cmp_luasnip",
    },
    config = function()

        local lspkind = require("lspkind")
        lspkind.init {}


        local cmp = require "cmp"
        cmp.setup {
            sources = {
                {name = "nvim_lsp"},
                {name = "path"},
                {name = "buffer"},
            },
            mapping = {
                ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
                ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
                ["<C-y>"] = cmp.mapping(
                    cmp.mapping.confirm {
                        behavior = cmp.SelectBehavior.Insert,
                        select = true,
                    },
                    { "i", "c"}
                ),
            },
            -- Enable luasnip to handle snippet expressions for nvim-cmp.
            snippet = {
                expand = function(args)
                    vim.snippet.expand(args.body)
                end,
            },
        }
    end
}
