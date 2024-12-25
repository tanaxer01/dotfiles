return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    config = function ()
        require("telescope").setup {
            defaults = {
                file_ignore_patterns = { "node_modules" },
            },
            extensions = {
				wrap_results = true,
				fzf = {},
                -- ["ui-select"] = { require("telescope.themes").get_dropdown {}, },
            },
            -- pickers = { find_files = { theme = "dropdown", previewer = false, } },
        }

        -- pcall(require("telescope").load_extension, "ui-select")

        local builtin = require("telescope.builtin")

        vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
		vim.keymap.set("n", "<leader>ft", function()
		  return builtin.git_files {}
		end)

        vim.keymap.set("n", "<space>fh", builtin.help_tags)

		vim.keymap.set("n", "<space>fb", builtin.buffers)

        vim.keymap.set("n", "<space>fg", builtin.live_grep)
        vim.keymap.set("n", "<space>/", builtin.current_buffer_fuzzy_find)

        vim.keymap.set("n", "<space>gw", builtin.grep_string)


        vim.keymap.set("n", "<leader>pws", function ()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set("n", "<leader>pWs", function ()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set("n", "<leader>ps", function ()
            builtin.grep_string({ search = vim.fn.input("Grep >") })
        end)
        vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})



    end
}
