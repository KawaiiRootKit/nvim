local ok, treesitter_context = pcall(require, "treesitter-context")

if not ok then
	return
end

treesitter_context.setup({
	enable = true,
	max_lines = 4,
	multiline_threshold = 1,
	mode = "cursor",
})

vim.keymap.set("n", "<leader>tc", "<cmd>TSContextToggle<CR>", { desc = "Treesitter Context Toggle" })
