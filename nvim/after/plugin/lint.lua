local lint = require("lint")
lint.linters_by_ft = {
	python = { "flake8" },
	zsh = { "zsh" },
	-- go = { "golangcilint" },
}

function vim.getVisualSelection()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg("v")
	vim.fn.setreg("v", {})

	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ""
	end
end

local golangcilint = lint.linters.golangcilint
golangcilint.append_fname = true
golangcilint.args = {
	"run",
	"--out-format",
	"json",
	"-c",
	"~/.golangci.yaml",
}

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
	callback = function()
		-- try_lint without arguments runs the linters defined in `linters_by_ft`
		-- for the current filetype
		require("lint").try_lint()
	end,
})
