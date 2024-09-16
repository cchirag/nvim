-- Telescope Setup

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', "<cmd>Telescope find_files hidden=true<cr>", {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})



-- Split Pane Configs

vim.keymap.set('n', '<C-k>', ":wincmd k<CR>", {})
vim.keymap.set('n', '<C-j>', ":wincmd j<CR>", {})
vim.keymap.set('n', '<C-h>', ":wincmd h<CR>", {})
vim.keymap.set('n', '<C-l>', ":wincmd l<CR>", {})



-- Terminal Configurations
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', {})



-- Undo Tree
vim.keymap.set('n', '<leader>ut', vim.cmd.UndotreeToggle)


-- Netrw
--
vim.keymap.set('n', '_', ':Explore<CR>')


-- Buffer Manager
--
vim.keymap.set('n', '<leader>bf', ':lua require("buffer_manager.ui").toggle_quick_menu()<CR>')


-- Hard Mode
--

local hardmode = true
if hardmode then
	-- Show an error message if a disabled key is pressed
	local msg = [[<cmd>echohl Error | echo "KEY DISABLED" | echohl None<CR>]]

	-- Disable arrow keys in insert mode with a styled message
	vim.api.nvim_set_keymap('i', '<Up>', '<C-o>' .. msg, { noremap = true, silent = false })
	vim.api.nvim_set_keymap('i', '<Down>', '<C-o>' .. msg, { noremap = true, silent = false })
	vim.api.nvim_set_keymap('i', '<Left>', '<C-o>' .. msg, { noremap = true, silent = false })
	vim.api.nvim_set_keymap('i', '<Right>', '<C-o>' .. msg, { noremap = true, silent = false })

	-- Disable arrow keys in normal mode with a styled message
	vim.api.nvim_set_keymap('n', '<Up>', msg, { noremap = true, silent = false })
	vim.api.nvim_set_keymap('n', '<Down>', msg, { noremap = true, silent = false })
	vim.api.nvim_set_keymap('n', '<Left>', msg, { noremap = true, silent = false })
	vim.api.nvim_set_keymap('n', '<Right>', msg, { noremap = true, silent = false })
	vim.api.nvim_set_keymap('n', '<BS>', msg, { noremap = true, silent = false })
end
