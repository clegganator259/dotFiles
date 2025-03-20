vim.g.mapleader = " "
-- Open directory view
vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>", { desc = "Open file browser" })
vim.keymap.set("n", "<leader>sv", function()
	dofile(vim.env.MYVIMRC)
end, { desc = "Source vimrc - unstable" })

-- When in visual mode J and K move highlighted block up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move visual line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move visual line up" })

-- Don't move cursor when joining lines
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join two lines without moving the cursor" })

-- When making large moves (u, d or search) ensure the cursor is in the middle
-- of the screen
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Move the screen down and center the cursor" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Move the screen up and center the cursor" })
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Replaces current selection with whatever is in the paste buffer without
-- overwriting buffer
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Override the selection with the default paste buffer" })

-- Delete without keeping yanked value
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without storing value" })

-- Yank to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank visual selection to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })

-- Format file using lsp
vim.keymap.set("n", "<leader>f", function()
	require("conform").format({ async = true, lsp_fallback = false })
end, { desc = "Format the buffer" })

-- Maps moving between vim panes using standard navigation
vim.keymap.set("n", "<c-j>", "<c-w>j", { desc = "Move down between vim panes" })
vim.keymap.set("n", "<c-k>", "<c-w>k", { desc = "Move up between vim panes" })
vim.keymap.set("n", "<c-h>", "<c-w>h", { desc = "Move left between vim panes" })
vim.keymap.set("n", "<c-l>", "<c-w>l", { desc = "Move right between vim panes" })

--- Split with leader
vim.keymap.set("n", "<leader>vs", ":vs<CR>", { desc = "Split vertically" })

--- View whole diagnostic text
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "View full diagnostic text under cursor" })
