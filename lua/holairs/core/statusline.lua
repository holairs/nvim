-------------------------------------------------------------------------------
------------------------------ Statusline Configuration ------------------------
-------------------------------------------------------------------------------
--  This file defines a custom statusline configuration for Neovim. It      --
--  includes dynamic updates for LSP diagnostics, Git integration, file     --
--  percentage, and other useful information, providing an enhanced         --
--  interface for developers. The design ensures clarity and functionality   --
--  while adapting to the active buffer and window states.                   --
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

local statusline_augroup = vim.api.nvim_create_augroup("native_statusline", {
	clear = true,
})

--- @return string
local function filename()
	local fullpath = vim.fn.expand("%:.:h") -- Full relative path
	local fname = vim.fn.expand("%:t") -- Actual file name
	if fname == "" then
		return "" -- If nothig => shows nothing haha
	end

	-- Splits with "/" each part
	local parts = vim.split(fullpath, "/", { plain = true })

	-- Just the last 2 segments of the path
	-- local last_two = table.concat({ parts[#parts - 1] or "", parts[#parts] or "" }, "/")

	-- Just the last segment of the path
	local last_two = parts[#parts] or ""

	return "[ " .. last_two .. "/" .. fname .. " ]"
end

--- @param severity integer
--- @return integer
local function get_lsp_diagnostics_count(severity)
	if not rawget(vim, "lsp") then
		return 0
	end

	local count = vim.diagnostic.count(0, { severity = severity })[severity]
	if count == nil then
		return 0
	end

	return count
end

--- @param type string
--- @return integer
local function get_git_diff(type)
	local gsd = vim.b.gitsigns_status_dict
	if gsd and gsd[type] then
		return gsd[type]
	end

	return 0
end

--- @return string
local function diagnostics_error()
	local count = get_lsp_diagnostics_count(vim.diagnostic.severity.ERROR)
	if count > 0 then
		return string.format("%%#StatusLineLspError# E %s%%*", count)
	end

	return ""
end

--- @return string
local function diagnostics_warns()
	local count = get_lsp_diagnostics_count(vim.diagnostic.severity.WARN)
	if count > 0 then
		return string.format("%%#StatusLineLspWarn# W %s%%*", count)
	end

	return ""
end

--- @return string
local function diagnostics_hint()
	local count = get_lsp_diagnostics_count(vim.diagnostic.severity.HINT)
	if count > 0 then
		return string.format("%%#StatusLineLspHint# H %s%%*", count)
	end

	return ""
end

--- @return string
local function diagnostics_info()
	local count = get_lsp_diagnostics_count(vim.diagnostic.severity.INFO)
	if count > 0 then
		return string.format("%%#StatusLineLspInfo# I %s%%*", count)
	end

	return ""
end

--- @class LspProgress
--- @field client vim.lsp.Client?
--- @field kind string?
--- @field title string?
--- @field percentage integer?
--- @field message string?
local lsp_progress = {
	client = nil,
	kind = nil,
	title = nil,
	percentage = nil,
	message = nil,
}

vim.api.nvim_create_autocmd("LspProgress", {
	group = statusline_augroup,
	desc = "Update LSP progress in statusline",
	pattern = { "begin", "report", "end" },
	callback = function(args)
		if not (args.data and args.data.client_id) then
			return
		end

		lsp_progress = {
			client = vim.lsp.get_client_by_id(args.data.client_id),
			kind = args.data.params.value.kind,
			message = args.data.params.value.message,
			percentage = args.data.params.value.percentage,
			title = args.data.params.value.title,
		}

		if lsp_progress.kind == "end" then
			lsp_progress.title = nil
			vim.defer_fn(function()
				vim.cmd.redrawstatus()
			end, 500)
		else
			vim.cmd.redrawstatus()
		end
	end,
})

--- @return string
local function lsp_status()
	if not rawget(vim, "lsp") then
		return ""
	end

	if vim.o.columns < 120 then
		return ""
	end

	if not lsp_progress.client or not lsp_progress.title then
		return ""
	end

	local title = lsp_progress.title or ""
	local percentage = (lsp_progress.percentage and (lsp_progress.percentage .. "%%")) or ""
	local message = lsp_progress.message or ""

	local lsp_message = string.format("%s", title)

	if message ~= "" then
		lsp_message = string.format("%s %s", lsp_message, message)
	end

	if percentage ~= "" then
		lsp_message = string.format("%s %s", lsp_message, percentage)
	end

	return string.format("%%#StatusLineLspMessages#%s%%* ", lsp_message)
end

--- @return string
local function git_diff_added()
	local added = get_git_diff("added")
	if added > 0 then
		return string.format("%%#StatusLineGitDiffAdded# ‣ %s%%*", added)
	end

	return ""
end

--- @return string
local function git_diff_changed()
	local changed = get_git_diff("changed")
	if changed > 0 then
		return string.format("%%#StatusLineGitDiffChanged# ∾ %s%%*", changed)
	end

	return ""
end

--- @return string
local function git_diff_removed()
	local removed = get_git_diff("removed")
	if removed > 0 then
		return string.format("%%#StatusLineGitDiffRemoved# ‑ %s%%*", removed)
	end

	return ""
end

--- @return string
local function git_branch()
	local branch = vim.b.gitsigns_head

	if branch == "" or branch == nil then
		return ""
	end

	return string.format("%%#StatusLineMedium#%s%%*", branch)
end

--- @return string
local function full_git()
	local full = ""
	local space = "%#StatusLineMedium# %*"

	local branch = git_branch()
	if branch ~= "" then
		full = full .. " branch: " .. branch .. space
	end

	local added = git_diff_added()
	if added ~= "" then
		full = full .. added .. space
	end

	local changed = git_diff_changed()
	if changed ~= "" then
		full = full .. changed .. space
	end

	local removed = git_diff_removed()
	if removed ~= "" then
		full = full .. removed .. space
	end

	return full
end

--- @return string
local function unsaved_changes_indicator()
	if vim.bo.modified then
		-- return " [+] "
		return string.format("%%#Visual#[+]%%*")
	end
	return ""
end

--- @return string
local function file_percentage()
	local current_line = vim.api.nvim_win_get_cursor(0)[1]
	local lines = vim.api.nvim_buf_line_count(0)

	return string.format(" %d%%%% of %d ", math.ceil(current_line / lines * 100), lines)
end

--- @return string
local function total_lines()
	local lines = vim.fn.line("$")
	return string.format("%%#StatusLineMedium#of %s %%*", lines)
end

--- @param hlgroup string
local function formatted_filetype(hlgroup)
	local filetype = vim.bo.filetype or vim.fn.expand("%:e", false)
	return string.format("%%#%s# %s %%*", hlgroup, filetype)
end

local function filetype()
	return string.format("  %s  ", vim.bo.filetype):lower()
end

StatusLine = {}

StatusLine.inactive = function()
	return table.concat({
		formatted_filetype("StatusLineMode"),
	})
end

local redeable_filetypes = {
	["qf"] = true,
	["help"] = true,
	["tsplayground"] = true,
}

local mode_map = {
	n = "N",
	i = "I",
	v = "V",
	V = "V",
	["\22"] = "B",
	c = "C",
	t = "T",
	R = "R",
}

local function get_mode_name()
	local mode = vim.api.nvim_get_mode().mode
	return mode_map[mode] or mode:upper()
end

local function set_mode_highlight()
	local mode = vim.api.nvim_get_mode().mode
	local hl_group = {
		n = "Visual",
		i = "Visual",
		v = "Visual",
		V = "Visual",
		["\22"] = "Visual",
		c = "Visual",
		t = "Visual",
		R = "Visual",
	}
	return hl_group[mode] or "Normal"
end

local function statusline_mode()
	local mode_name = get_mode_name()
	local hl_group = set_mode_highlight()
	return string.format("%%#%s# %s %%*", hl_group, mode_name)
end

StatusLine.active = function()
	local mode_str = vim.api.nvim_get_mode().mode
	if mode_str == "t" or mode_str == "nt" then
		return table.concat({
			"%=",
			"%=",
			file_percentage(),
			total_lines(),
		})
	end

	if redeable_filetypes[vim.bo.filetype] or vim.o.modifiable == false then
		return table.concat({
			formatted_filetype("StatusLineMode"),
			"%=",
			"%=",
			file_percentage(),
			total_lines(),
		})
	end

	local statusline = {
		statusline_mode(),
		" %t ",
		-- filename(),
		full_git(),
		"%=",
		"%=",
		"%S ",
		lsp_status(),
		diagnostics_error(),
		diagnostics_warns(),
		diagnostics_hint(),
		diagnostics_info(),
		unsaved_changes_indicator(),
		filetype(),
		file_percentage(),
	}

	return table.concat(statusline)
end

vim.opt.statusline = "%!v:lua.StatusLine.active()"

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter", "FileType" }, {
	group = statusline_augroup,
	pattern = {
		"NvimTree_1",
		"NvimTree",
		"TelescopePrompt",
		"fzf",
		"lspinfo",
		"lazy",
		"netrw",
		"mason",
		"noice",
		"qf",
		"oil",
	},
	callback = function()
		vim.opt_local.statusline = "%!v:lua.StatusLine.inactive()"
	end,
})
