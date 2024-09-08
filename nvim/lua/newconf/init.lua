require("newconf.basics")
require("newconf.remap")

require("newconf.lazy")

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local newconfGroup = augroup("newconf", {})

autocmd('LspAttach', {
    group = newconfGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
        local builtin = require "telescope.builtin"

        -- # Language server
        vim.keymap.set("n", "gd", builtin.lsp_definitions, opts)
        -- vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)        -- Go to definition
        vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)       -- Go to declaration
        vim.keymap.set("n", "gy", function() vim.lsp.buf.type_definition() end, opts)   -- Go to type definition
        vim.keymap.set("n", "gI", function() vim.lsp.buf.implementation() end, opts)    -- Go to implementation

        vim.keymap.set("n", "cd", function() vim.lsp.buf.rename() end, opts)            -- Rename (change definition)
        -- vim.keymap.set("n", "gA", function() vim.lsp.buf.references() end, opts)        -- Go to All references to the current word
        vim.keymap.set("n", "gA", builtin.lsp_references, opts)

        -- vim.keymap.set("n", "gs", function() vim.lsp.buf.document_symbol() end, opts)   -- Find symbol in current file
        vim.keymap.set("n", "gs", builtin.lsp_document_symbols, opts)
        vim.keymap.set("n", "gS", function() vim.lsp.buf.workspace_symbol() end, opts)  -- Find symbol in entire project

        vim.keymap.set("n", "g]", function() vim.diagnostic.goto_next() end, opts)      -- Go to next diagnostic
        vim.keymap.set("n", "g[", function() vim.diagnostic.goto_prev() end, opts)      -- Go to previous diagnostic
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)      -- Go to next diagnostic
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)      -- Go to previous diagnostic
        vim.keymap.set("n", "gh", function() vim.diagnostic.open_float() end, opts)     -- Show inline error (hover)
        vim.keymap.set("n", "g.", function() vim.lsp.buf.code_action() end, opts)    -- Open the code actions menu

        -- # Git
        -- vim.keymap.set("n", "]c", function() end, opts) -- Go to next git change
        -- vim.keymap.set("n", "[c", function() end, opts) -- Go to previous git change    

        -- # Treesitter
        -- vim.keymap.set("n", "]x", function() end, opts) -- Select a smaller syntax node
        -- vim.keymap.set("n", "[x", function() end, opts) -- Select a larger syntax node

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
            vim.cmd("split")
            vim.lsp.buf.definition()
        end, opts)
        vim.keymap.set("n", "<lead>gD", function() -- Go to type definition in a split
            vim.cmd("split")
            vim.lsp.buf.type_definition()
        end, opts)

        -- vim.keymap.set("n", "gd",           function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K",            function() vim.lsp.buf.hover() end, opts)
        -- vim.keymap.set("n", "<leader>vws",  function() vim.lsp.buf.workspace_symbol() end, opts)
        -- vim.keymap.set("n", "<leader>vd",   function() vim.diagnostic.open_float() end, opts)
        -- vim.keymap.set("n", "<leader>vca",  function() vim.lsp.buf.code_action() end, opts)
        -- vim.keymap.set("n", "<leader>vrr",  function() vim.lsp.buf.references() end, opts)
        -- vim.keymap.set("n", "<leader>vrn",  function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        -- vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        -- vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
        vim.api.nvim_buf_create_user_command(e.buf, 'Format', function(_)
            vim.lsp.buf.format()
        end, {})
    end
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
