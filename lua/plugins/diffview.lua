return {
	"sindrets/diffview.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local actions = require("diffview.actions")

		require("diffview").setup({
			keymaps = {
				view = {
					-- Diff view mappings
					["<tab>"]      = actions.select_next_entry,
					["<s-tab>"]    = actions.select_prev_entry,
					["<leader>e"]  = actions.focus_files,
					["<leader>b"]  = actions.toggle_files,
					["q"]          = actions.close,
					["<esc>"]      = actions.close,
					["gf"]         = actions.goto_file,
					["<C-w><C-f>"] = actions.goto_file_split,
					["<C-w>gf"]    = actions.goto_file_tab,
					["<leader>co"] = actions.conflict_choose("ours"),
					["<leader>ct"] = actions.conflict_choose("theirs"),
					["<leader>cb"] = actions.conflict_choose("base"),
					["<leader>ca"] = actions.conflict_choose("all"),
					["<leader>cx"] = actions.conflict_choose("none"),
				},
				file_panel = {
					["j"]       = actions.next_entry,
					["k"]       = actions.prev_entry,
					["<cr>"]    = actions.select_entry,
					["R"]       = actions.refresh_files,
					["<tab>"]   = actions.select_next_entry,
					["<s-tab>"] = actions.select_prev_entry,
					["q"]       = actions.close,
					["<esc>"]   = actions.close,
					["gf"]      = actions.goto_file,
				},
				file_history_panel = {
					["q"]     = actions.close,
					["<esc>"] = actions.close,
				},
			},
		})

		-- General Diffview commands
		vim.keymap.set("n", "<leader>do", ":DiffviewOpen<CR>",
			{ desc = "Open Diffview" })
		vim.keymap.set("n", "<leader>dc", ":DiffviewClose<CR>",
			{ desc = "Close Diffview" })
		vim.keymap.set("n", "<leader>dh", ":DiffviewFileHistory<CR>",
			{ desc = "File history" })
		vim.keymap.set("n", "<leader>df", ":DiffviewFileHistory %<CR>",
			{ desc = "Current file history" })
		vim.keymap.set("n", "<leader>dm", ":DiffviewOpen --merge-base HEAD<CR>",
			{ desc = "Diff with merge-base" })

		-- Merge conflict specific
		vim.keymap.set("n", "<leader>gc", ":DiffviewOpen --merge-base :merge<CR>",
			{ desc = "Open merge conflicts" })
	end,
}
