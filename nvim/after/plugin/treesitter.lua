-- [[ Configure Treesitter ]]

vim.defer_fn(function()
    require("nvim-treesitter.configs").setup {
        ensure_installed = { "c", "cpp", "go", "lua", "python", "rust", "javascript", "json" },

        highlight = { enable = true },

        refactor = {
            highlight_definitions = { enable = true },
            highlight_current_scope = { enable = false },

            smart_rename = {
                enable = false,
                keymaps = {
                    -- mapping to rename reference under cursor
                    smart_rename = "grr",
                }
            },

            navigation = {
                enable = false,
                keymaps = {
                    goto_definition = "gnd", -- mapping to go to definition of symbol under cursor
                    list_definitions = "gnD", -- mapping to list all definitions in current file
                }
            }
        }

    }

end, 0)


