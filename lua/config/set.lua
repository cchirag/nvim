vim.wo.number = true
vim.wo.relativenumber = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.clipboard = "unnamedplus"
-- Setting the Color Scheme
vim.opt.termguicolors = true
vim.cmd("colorscheme kanagawa-dragon")

vim.opt.mouse = ""
vim.keymap.set("n", "dn", vim.diagnostic.goto_next)
vim.keymap.set("n", "dp", vim.diagnostic.goto_prev)

vim.api.nvim_create_autocmd('User', {
	pattern = 'GitConflictDetected',
	callback = function()
		vim.notify('Conflict detected in ' .. vim.fn.expand('<afile>'))
		vim.keymap.set('n', 'cww', function()
			engage.conflict_buster()
			create_buffer_local_mappings()
		end)
	end
})
