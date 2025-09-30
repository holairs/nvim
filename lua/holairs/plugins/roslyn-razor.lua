-- ~/.config/nvim/lua/plugins/roslyn-razor.lua

return {
	"seblyng/roslyn.nvim",
	---@module 'roslyn.config'
	---@type RoslynNvimConfig
	ft = { "cs", "razor" },
	opts = {},
	dependencies = {
		{
			"tris203/rzls.nvim",
			config = true,
		},
	},
	-- lazy = false,
	config = function()
		local rzls_path = vim.fn.expand("$MASON/packages/rzls/libexec")
		local cmd = {
			"roslyn",
			"--stdio",
			"--logLevel=Information",
			"--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
			"--razorSourceGenerator=" .. vim.fs.joinpath(rzls_path, "Microsoft.CodeAnalysis.Razor.Compiler.dll"),
			"--razorDesignTimePath="
				.. vim.fs.joinpath(rzls_path, "Targets", "Microsoft.NET.Sdk.Razor.DesignTime.targets"),
			"--extension",
			vim.fs.joinpath(rzls_path, "RazorExtension", "Microsoft.VisualStudioCode.RazorExtension.dll"),
		}

		vim.lsp.config("roslyn", {
			cmd = cmd,
			handlers = require("rzls.roslyn_handlers"),
		})
		vim.lsp.enable("roslyn")
	end,
	init = function()
		-- We add the Razor file types before the plugin loads.
		vim.filetype.add({
			extension = {
				razor = "razor",
				cshtml = "razor",
			},
		})
	end,
}
