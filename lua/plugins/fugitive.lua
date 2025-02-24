return {
	{
		"tpope/vim-fugitive",
		config = function()
			-- Basic git commands
			vim.keymap.set("n", "<leader>gs", ":Git<CR>",
				{ desc = "Git status" })
			vim.keymap.set("n", "<leader>gc", ":Git commit<CR>",
				{ desc = "Git commit" })
			vim.keymap.set("n", "<leader>gp", ":Git push<CR>",
				{ desc = "Git push" })
			vim.keymap.set("n", "<leader>gl", ":Git pull<CR>",
				{ desc = "Git pull" })
			vim.keymap.set("n", "<leader>gb", ":Git blame<CR>",
				{ desc = "Git blame" })
		end,
	}
}
