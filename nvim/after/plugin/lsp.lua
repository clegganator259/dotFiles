local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

local function set_python_path(path)
	local clients = vim.lsp.get_active_clients({
		bufnr = vim.api.nvim_get_current_buf(),
		name = "pyright",
	})
	for _, client in ipairs(clients) do
		if client.settings then
			client.settings.python = vim.tbl_deep_extend("force", client.settings.python, { pythonPath = path })
		else
			client.config.settings =
				vim.tbl_deep_extend("force", client.config.settings, { python = { pythonPath = path } })
		end
		client.notify("workspace/didChangeConfiguration", { settings = nil })
	end
end

--- These must be global as LSP is not the only thing that creates diagnostics
vim.keymap.set("n", "<leader>nd", function()
	vim.diagnostic.goto_next()
end, { desc = "Jump to next diagnostic", remap = false })
vim.keymap.set("n", "<leader>ND", function()
	vim.diagnostic.goto_prev()
end, { desc = "Jump to previous diagnostic", remap = false })
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP Attach Actions",
	callback = function(client, bufnr)
		local opts = { buffer = bufnr, remap = false }

		vim.keymap.set("n", "gd", function()
			vim.lsp.buf.definition()
		end, { desc = "Goto definition under cursor", opts.unpack })
		vim.keymap.set("n", "gi", function()
			vim.lsp.buf.implementation()
		end, { desc = "Goto implementation under cursor", buffer = bufnr, remap = false })
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, { desc = "Show type information for symbol under cursor", buffer = bufnr, remap = false })
		vim.keymap.set("n", "<leader>vws", function()
			vim.lsp.buf.workspace_symbol()
		end, { desc = "Search for workspace symbol", buffer = bufnr, remap = false })
		vim.keymap.set("n", "<leader>vrr", function()
			vim.lsp.buf.references()
		end, { desc = "List references to symbol under cursor", buffer = bufnr, remap = false })
		vim.keymap.set("n", "<leader>vrn", function()
			vim.lsp.buf.rename()
		end, { desc = "Rename symbol under cursor", buffer = bufnr, remap = false })
		vim.keymap.set("i", "<C-h>", function()
			vim.lsp.buf.signature_help()
		end, { desc = "Show the type signature of the current symbol being created", buffer = bufnr, remap = false })
	end,
})

require("mason").setup({ ensure_installed = { "isort", "stylua", "black", "gofumpt", "golangcilint" } })
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "gopls", "rust_analyzer", "pyright", "spectral" },
	handlers = {
		function(server_name)
			require("lspconfig")[server_name].setup({
				capabilities = lsp_capabilities,
			})
		end,
		lua_ls = function()
			local lua_opts = {
				on_init = function(client)
					if client.workspace_folders then
						local path = client.workspace_folders[1].name
						if
							path ~= vim.fn.stdpath("config")
							and (vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc"))
						then
							return
						end
					end

					client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
						runtime = {
							-- Tell the language server which version of Lua you're using
							-- (most likely LuaJIT in the case of Neovim)
							version = "LuaJIT",
						},
						-- Make the server aware of Neovim runtime files
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
							},
						},
					})
				end,
				settings = {
					Lua = {},
				},
			}
			require("lspconfig").lua_ls.setup(lua_opts)
		end,
		gopls = function()
			local gopls_opts = {
				capabilities = lsp_capabilities,
				buildFlags = { "-tags=integration acceptance" },
				testFlags = { "-tags=integration acceptance" },
				usePlaceholders = true,
				cmd_env = { GOFLAGS = "-tags=integration" },
			}
			require("lspconfig").gopls.setup(gopls_opts)
		end,
		golangci_lint_ls = function()
			local lspconfig = require("lspconfig")
			local golangci_lint_ls_options = {
				capabilities = lsp_capabilities,
				cmd = { "golangci-lint-langserver" },
				root_dir = lspconfig.util.root_pattern(".git", "go.mod"),
				init_options = {
					buildFlags = { "-tags=integration acceptance" },
					testFlags = { "-tags=integration acceptance" },
					command = {
						"golangci-lint",
						"run",
						"--enable-all",
						"--disable",
						"lll",
						"--out-format",
						"json",
						"--issues-exit-code=1",
					},
				},
			}
			lspconfig.golangci_lint_ls.setup(golangci_lint_ls_options)
		end,
		pyright = function()
			local pyright_opts = {
				capabilities = lsp_capabilities,
				single_file_support = true,
				settings = {
					analysis = {
						autoSearchPaths = true,
						useLibraryCodeForTypes = true,
						diagnosticMode = "openFilesOnly",
					},
				},
				commands = {
					PyrightSetPythonPath = {
						set_python_path,
						description = "Reconfigure pyright with the provided python path",
						nargs = 1,
						complete = "file",
					},
				},
			}
			require("lspconfig").pyright.setup(pyright_opts)
		end,
	},
})

local cmp = require("cmp")
local cmp_select = {
	behavior = cmp.SelectBehavior.Select,
	preselect = "none",
	completion = {
		completeopt = "menu,menuone",
	},
}
local cmp_mappings = {
	["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
	["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
	["<TAB>"] = cmp.mapping.select_next_item(cmp_select),
	["<C-CR>"] = cmp.mapping.confirm({ behavior = cmp.SelectBehavior.Replace, select = false }),
	["<CR>"] = cmp.mapping({
		i = function(fallback)
			if cmp.visible() and cmp.get_active_entry() then
				cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
			else
				fallback()
			end
		end,
		s = cmp.mapping.confirm({ select = true }),
		c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
	}),
	["<C-n>"] = cmp.config.disable,
	["<C-p>"] = cmp.config.disable,
}
cmp.setup({
	mapping = cmp_mappings,
	sources = { { name = "nvim_lsp" } },
	select = cmp_select,
})

vim.diagnostic.config({
	undercurl = true,
})

vim.diagnostic.config({
	virtual_text = true,
})

-- Ensure that we give enough time before timing out
vim.lsp.buf.format({ timeout_ms = 5000 })
