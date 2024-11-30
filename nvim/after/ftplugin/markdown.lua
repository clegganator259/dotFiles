vim.opt_local.conceallevel = 1
vim.opt.spell = true
vim.api.nvim_buf_set_keymap(0, "n", "j", "gj", { noremap = true })
vim.api.nvim_buf_set_keymap(0, "n", "gj", "j", { noremap = true })
vim.api.nvim_buf_set_keymap(0, "n", "k", "gk", { noremap = true })
vim.api.nvim_buf_set_keymap(0, "n", "gk", "k", { noremap = true })
