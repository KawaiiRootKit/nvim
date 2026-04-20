if vim.treesitter and vim.treesitter.language then
	if vim.treesitter.language.ft_to_lang == nil and vim.treesitter.language.get_lang ~= nil then
		vim.treesitter.language.ft_to_lang = vim.treesitter.language.get_lang
	end
	if vim.treesitter.language.get_lang == nil and vim.treesitter.language.ft_to_lang ~= nil then
		vim.treesitter.language.get_lang = vim.treesitter.language.ft_to_lang
	end
end

local telescope = require("telescope")
telescope.setup({
	defaults = {
		preview = {
			treesitter = false,
		},
	},
})

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "find file" })
vim.keymap.set("n", "<leader>fm", builtin.builtin, { desc = "Telescope Main Menu" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "help tags" })
vim.keymap.set("n", "<leader>fc", builtin.colorscheme, { desc = "colorschemes" })
vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "File is Git Repo" })
vim.keymap.set("n", "<leader>gh", builtin.git_commits, { desc = "Commit History" })
