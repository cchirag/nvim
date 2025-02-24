--
-- LSP configuration
---
local lsp_zero = require('lsp-zero')

local lsp_attach = function(client, bufnr)
	local opts = { buffer = bufnr, noremap = true, silent = true }

	-- Existing keymaps with descriptions for better help display
	vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>',
		vim.tbl_extend('force', opts, { desc = "Show hover documentation" }))
	vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>',
		vim.tbl_extend('force', opts, { desc = "Go to definition" }))
	vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>',
		vim.tbl_extend('force', opts, { desc = "Go to declaration" }))
	vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>',
		vim.tbl_extend('force', opts, { desc = "Go to implementation" }))
	vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>',
		vim.tbl_extend('force', opts, { desc = "Go to type definition" }))
	vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>',
		vim.tbl_extend('force', opts, { desc = "Show references" }))
	vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>',
		vim.tbl_extend('force', opts, { desc = "Show signature help" }))
	vim.keymap.set('n', 'gR', '<cmd>lua vim.lsp.buf.rename()<cr>',
		vim.tbl_extend('force', opts, { desc = "Rename symbol" }))
	vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>',
		vim.tbl_extend('force', opts, { desc = "Format code" }))
	vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>',
		vim.tbl_extend('force', opts, { desc = "Code actions" }))

	-- Additional useful keymaps
	vim.keymap.set('n', '[d', vim.diagnostic.goto_prev,
		vim.tbl_extend('force', opts, { desc = "Previous diagnostic" }))
	vim.keymap.set('n', ']d', vim.diagnostic.goto_next, vim.tbl_extend('force', opts, { desc = "Next diagnostic" }))
	vim.keymap.set('n', '<leader>dl', '<cmd>Telescope diagnostics<cr>',
		vim.tbl_extend('force', opts, { desc = "List diagnostics" }))

	-- Enable inlay hints if supported
	if client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint.enable(true)
	end

	lsp_zero.buffer_autoformat()
end

-- Enhanced LSP configuration
lsp_zero.extend_lspconfig({
	sign_text = true,
	lsp_attach = lsp_attach,
	capabilities = require('cmp_nvim_lsp').default_capabilities(),
	settings = {
		-- LSP-specific settings
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
			gofumpt = true,
		},
		rust_analyzer = {
			checkOnSave = {
				command = "clippy",
			},
		},
		lua_ls = {
			diagnostics = {
				globals = { 'vim' },
			},
		},
	},
})

-- Mason setup with extended server list
require('mason').setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

require('mason-lspconfig').setup({
	ensure_installed = {
		'lua_ls',
		'rust_analyzer',
		'gopls',
		'marksman',
		'tsserver',
		'pyright',
		'cssls',
		'html',
		'tailwindcss',
	},
	handlers = {
		function(server_name)
			require('lspconfig')[server_name].setup({})
		end,

		-- Custom handler for specific servers if needed
		["lua_ls"] = function()
			require('lspconfig').lua_ls.setup({
				settings = {
					Lua = {
						diagnostics = {
							globals = { 'vim' },
						},
					},
				},
			})
		end,
	},
})

---
-- Enhanced autocompletion setup
---
local cmp = require('cmp')

cmp.setup({
	sources = {
		{ name = 'nvim_lsp', priority = 1000 },
		{ name = 'luasnip',  priority = 750 },
		{ name = 'buffer',   priority = 500 },
		{ name = 'path',     priority = 250 },
	},
	snippet = {
		expand = function(args)
			vim.snippet.expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		-- Navigation in completion menu
		['<C-d>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
		['<C-f>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),

		-- Trigger completion with Ctrl-p instead of Alt-/
		['<C-p>'] = cmp.mapping.complete(),

		-- Documentation preview
		['<C-k>'] = cmp.mapping.scroll_docs(-4),
		['<C-j>'] = cmp.mapping.scroll_docs(4),

		-- Show full documentation for current item
		['<C-h>'] = function()
			if cmp.visible_docs() then
				cmp.close_docs()
			else
				cmp.open_docs()
			end
		end,

		-- Cancel and confirm
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),

		-- Tab can also be used to confirm selection
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.confirm({ select = true })
			else
				fallback()
			end
		end, { 'i', 's' }),
	}),
	window = {
		completion = cmp.config.window.bordered({
			border = 'rounded',
			winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
		}),
		documentation = cmp.config.window.bordered({
			border = 'rounded',
			winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
		}),
	},
	formatting = {
		format = function(entry, vim_item)
			-- Add source name to completion menu
			vim_item.menu = ({
				nvim_lsp = "[LSP]",
				luasnip = "[Snippet]",
				buffer = "[Buffer]",
				path = "[Path]",
			})[entry.source.name]
			return vim_item
		end,
	},
})

-- Enhanced diagnostic settings
vim.diagnostic.config({
	virtual_text = {
		prefix = '●',
		source = true,
	},
	float = {
		border = 'rounded',
		source = true,
		header = '',
	},
	signs = true,
	underline = true,
	update_in_insert = true,
	severity_sort = true,
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		update_in_insert = true,
		virtual_text = {
			prefix = '●',
			source = true,
		},
	}
)
