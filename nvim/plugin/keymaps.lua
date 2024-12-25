local set = vim.keymap.set
local k = vim.keycode

vim.g.mapleader = " "

set("n", "<leader>x", "<cmd>.lua<CR>", { desc = "Execute the current line" })
set("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Execute the current file" })

-- Toggle hlsearch if its on, otherwise just do "enter"
set("n", "<CR>", function()
	if vim.v.hlsearch == 1 then
		vim.cmd.nohl()
		return ""
	else
		return k "<CR>"
	end
end, { expr = true })


set("n", "]d", function() vim.diagnostic.jump { count = 1, float = true } end, { buffer = 0 })  -- Go to next diagnostic
set("n", "[d", function() vim.diagnostic.jump { count = -1, float = true } end, { buffer = 0 }) -- Go to next diagnostic

-- Controls the size of splits
set("n", "<M-,>", "<c-w>5<")
set("n", "<M-.>", "<c-w>5>")
set("n", "<M-t>", "<c-w>+")
set("n", "<M-s>", "<c-w>-")


vim.keymap.set("v", "J", ":m '>=1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")


vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !sessionizer<CR>")

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/lua/newconf<CR>")
