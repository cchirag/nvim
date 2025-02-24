return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("gitsigns").setup({
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "▁" },
				topdelete = { text = "▔" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				-- Navigation between hunks
				vim.keymap.set("n", "]h", function()
					if vim.wo.diff then
						return "]h"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { buffer = bufnr, expr = true, desc = "Next hunk" })

				vim.keymap.set("n", "[h", function()
					if vim.wo.diff then
						return "[h"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { buffer = bufnr, expr = true, desc = "Previous hunk" })

				-- Actions
				-- Stage hunk
				vim.keymap.set({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>",
					{ buffer = bufnr, desc = "Stage hunk" })

				-- Reset hunk
				vim.keymap.set({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>",
					{ buffer = bufnr, desc = "Reset hunk" })

				-- Stage buffer
				vim.keymap.set("n", "<leader>hS", gs.stage_buffer,
					{ buffer = bufnr, desc = "Stage buffer" })

				-- Undo stage hunk
				vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk,
					{ buffer = bufnr, desc = "Undo stage hunk" })

				-- Reset buffer
				vim.keymap.set("n", "<leader>hR", gs.reset_buffer,
					{ buffer = bufnr, desc = "Reset buffer" })

				-- Preview hunk
				vim.keymap.set("n", "<leader>hp", gs.preview_hunk,
					{ buffer = bufnr, desc = "Preview hunk" })

				-- Blame line
				vim.keymap.set("n", "<leader>hb", function()
					gs.blame_line({ full = true })
				end, { buffer = bufnr, desc = "Blame line" })

				-- Toggle blame line
				vim.keymap.set("n", "<leader>htb", gs.toggle_current_line_blame,
					{ buffer = bufnr, desc = "Toggle line blame" })

				-- Diff against index
				vim.keymap.set("n", "<leader>hd", gs.diffthis,
					{ buffer = bufnr, desc = "Diff against index" })

				-- Diff against last commit
				vim.keymap.set("n", "<leader>hD", function()
					gs.diffthis("~")
				end, { buffer = bufnr, desc = "Diff against last commit" })

				-- Toggle deleted
				vim.keymap.set("n", "<leader>htd", gs.toggle_deleted,
					{ buffer = bufnr, desc = "Toggle deleted" })
			end,
		})
	end,
}
