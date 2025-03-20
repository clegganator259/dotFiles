vim.keymap.set("n", "<leader>gs", function()
	vim.cmd("vert Git")
end, { desc = "Open git client" })
