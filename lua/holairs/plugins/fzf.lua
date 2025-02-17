return {
	{
		"junegunn/fzf.vim",
		dependencies = {
			{
				"junegunn/fzf",
				build = "./install --bin",
			},
		},
		cmd = { "Files", "Rg", "Buffers" },
		keys = {
			{
				"<leader>ff",
				function()
					vim.g.fzf_preview_window = {}

					vim.env.FZF_DEFAULT_OPTS = "--height=30% --layout=reverse --border " ..
							"--color=fg:-1,bg:-1,hl:4,fg+:7,bg+:0,hl+:4,info:2," ..
							"prompt:2,pointer:1,marker:5,spinner:4,header:3"

					vim.env.FZF_DEFAULT_COMMAND =
							"rg --files --hidden " ..
							'--glob "!.git/" --glob "!venv/" --glob "!.*" ' ..
							'--glob "!node_modules" --glob "!.DS_Store" ' ..
							'--glob "!cmake-build-debug/" --glob "!lazy-lock.json"'

					vim.cmd("Files")
				end,
				desc = "Search for files",
			},
			{
				"<leader>fh",
				function()
					vim.env.FZF_DEFAULT_COMMAND = ""
					vim.cmd("Files")
				end,
				desc = "Search for files including hidden files",
			},
			{
				"<leader>fg",
				":Rg<CR>",
				desc = "Search within file contents",
			},
			{
				"<leader>fd",
				":Buffers<CR>",
				desc = "List open buffers",
			},
		},
	},
}
