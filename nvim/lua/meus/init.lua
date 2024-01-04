require("meus.basics")
require("meus.remap")

local augroup = vim.api.nvim_create_augroup
local MeusGroup = augroup("MeusGroup", {})

local autocmd = vim.api.nvim_create_autocmd

autocmd('LspAttach', {
    group = MeusGroup,
    callback = function(e)
        local opts = { buffer = e.buf }

        vim.keymap.set("n", "gd", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)

        vim.keymap.set("n", "<leader>ws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.lsp.buf.open_float() end, opts)

        vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)

        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    end
})
