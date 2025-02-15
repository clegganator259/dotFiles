local lsp = require("lsp-zero")

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

local lsp_attach = function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	lsp.default_keymaps({ buffer = bufnr })

	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set("n", "gi", function()
		vim.lsp.buf.implementation()
	end, opts)
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, opts)
	vim.keymap.set("n", "<leader>vws", function()
		vim.lsp.buf.workspace_symbol()
	end, opts)
	vim.keymap.set("n", "<leader>vd", function()
		vim.diagnostic.open_float()
	end, opts)
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.goto_next()
	end, opts)
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.goto_prev()
	end, opts)
	vim.keymap.set("n", "<leader>vca", function()
		vim.lsp.buf.code_action()
	end, opts)
	vim.keymap.set("n", "<leader>vrr", function()
		vim.lsp.buf.references()
	end, opts)
	vim.keymap.set("n", "<leader>vrn", function()
		vim.lsp.buf.rename()
	end, opts)
	vim.keymap.set("i", "<C-h>", function()
		vim.lsp.buf.signature_help()
	end, opts)
end

lsp.extend_lspconfig({
	suggest_lsp_servers = false,
	sign_icons = {
		error = "E",
		warn = "W",
		hint = "H",
		info = "I",
	},
	lsp_attach = lsp_attach,
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = {
	["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
	["<TAB>"] = cmp.mapping.select_next_item(cmp_select),
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
	["<C-Space>"] = cmp.mapping.complete(),
}

cmp.setup({
	mapping = cmp.mapping.preset.insert(cmp_mappings),
	sources = { { name = "nvim_lsp" } },
})

vim.diagnostic.config({
	undercurl = true,
})

require("mason").setup({ ensure_installed = { "isort", "stylua", "black", "gofumpt", "golangcilint" } })
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "gopls", "rust_analyzer", "pyright", "spectral" },
	handlers = {
		function(server_name)
			require("lspconfig")[server_name].setup({})
		end,
		lua_ls = function()
			local lua_opts = lsp.nvim_lua_ls()
			require("lspconfig").lua_ls.setup(lua_opts)
		end,
		gopls = function()
			local gopls_opts = {
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

vim.diagnostic.config({
	virtual_text = true,
})

-- Ensure that we give enough time before timing out
vim.lsp.buf.format({ timeout_ms = 5000 })
