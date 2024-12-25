local setup = function()
	-- Autoformatting Setup
	local conform = require "conform"
	conform.setup { }

	vim.api.nvim_create_autocmd("BufWritePre", {
		group = vim.api.nvim_create_augroup("custom-conform", { clear = true }),
		callback = function(args)
			require("conform").format {
				bufnr = args.buf,
				lsp_fallback = true,
				quiet = true,
			}
		end,
	})
end

setup()

return { setup = setup }
