return {
	{
		"mbbill/undotree",
		config = function()
			-- Enable persistent undo
			vim.opt.undofile = true
			-- Directory where undo files will be saved
			vim.opt.undodir = vim.fn.expand("~/.undotree")
			-- Create the directory if it doesn't exist
			-- Ensure the correct value is used as a string
			vim.fn.system({ "mkdir", "-p", vim.opt.undodir._value })
			-- Mapping to open Undotree
			vim.api.nvim_set_keymap("n", "<leader>uu", ":UndotreeToggle<CR>", {
				noremap = true,
				silent = true,
			})
		end,
	},
}
