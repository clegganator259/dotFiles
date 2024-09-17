require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		python = { "isort", "black" },
	},
	lsp_fallback = true,
	format_on_save = {
		timeout_ms = 2500,
		lsp_fallback = true,
	},
})
