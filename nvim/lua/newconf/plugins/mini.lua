return {
	"echasnovski/mini.nvim",
	config = function()
		require("mini.diff").setup({
			style = 'sign',
			view = {
				signs = {
					add = "┃",
					change = "┃",
					delete = "┃",
				},
			}
		})
	end
}
