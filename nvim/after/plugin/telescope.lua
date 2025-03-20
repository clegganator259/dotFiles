local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>pp", builtin.resume, { desc = "Open the last telescope search bufer" })
vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Search for all files in CWD" })
vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Search all files in the git index" })
vim.keymap.set("n", "<leader>pd", builtin.diagnostics, { desc = "Search all diagnostics in the CWD" })
vim.keymap.set("n", "<leader>pb", builtin.buffers, { desc = "Search all open buffers" })
vim.keymap.set("n", "<leader>pt", builtin.treesitter, { desc = "Search all treesitter symbols" })
vim.keymap.set("n", "<leader>lr", builtin.lsp_references, { desc = "Search all treesitter symbols" })
vim.keymap.set(
	"n",
	"<leader>li",
	builtin.lsp_implementations,
	{ desc = "Search all implementations of the interface under the cursor" }
)
vim.keymap.set("n", "<leader>PS", function()
	builtin.grep_string({ search = vim.fn.input("Grep > "), use_regex = true })
end, { desc = "Enter a regex and search through all instances of that regex" })
vim.keymap.set("n", "<leader>ps", builtin.live_grep, { desc = "Grep all files" })
vim.keymap.set("v", "<leader>ps", function()
	builtin.grep_string({ search = vim.getVisualSelection() })
end, { desc = "Search all files containing the currently highlighted string" })

vim.keymap.set("n", "<leader>vd", function()
	builtin.diagnostics({ buffer = 0 })
end, { desc = "Search all diagnostics in the current buffer" })
