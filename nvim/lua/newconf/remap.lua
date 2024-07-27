
vim.g.mapleader = " "
-- Now done by Oil
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)


vim.keymap.set("v", "J", ":m '>=1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")


vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !sessionizer<CR>")

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/lua/newconf<CR>")
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)



