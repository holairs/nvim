local M = {}

-- Mostrar historial en una ventana flotante
function M.show_undo_tree()
	local undo_tree = vim.fn.undotree()
	local entries = undo_tree.entries
	if not entries or #entries == 0 then
		vim.notify("No undo history available", vim.log.levels.INFO)
		return
	end

	-- Crear buffer y ventana flotante
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_option(buf, "buftype", "nofile")

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = 50,
		height = math.min(#entries + 2, 20),
		row = 3,
		col = 10,
		border = "rounded",
	})

	-- Contenido del árbol
	local lines = { "Undo Tree:" }
	for _, entry in ipairs(entries) do
		local marker = entry.seq == undo_tree.seq_cur and ">" or " "
		table.insert(lines, string.format("%s %d - %s", marker, entry.seq, os.date("%Y-%m-%d %H:%M:%S", entry.time)))
	end
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

	-- Mapeo para navegar por los estados
	vim.api.nvim_buf_set_keymap(buf, "n", "<CR>", "", {
		noremap = true,
		silent = true,
		callback = function()
			local line = vim.api.nvim_win_get_cursor(win)[1]
			local seq = entries[line - 2].seq -- Ajustar índice para ignorar encabezado
			if seq == undo_tree.seq_cur then
				vim.notify("Already at the selected state", vim.log.levels.INFO)
				return
			end

			-- Aplicar el cambio al buffer actual
			vim.cmd("earlier " .. seq)
			vim.api.nvim_win_close(win, true)
		end,
	})

	-- Cerrar ventana con `q`
	vim.api.nvim_buf_set_keymap(buf, "n", "q", "", {
		noremap = true,
		silent = true,
		callback = function()
			vim.api.nvim_win_close(win, true)
		end,
	})
end

-- Registrar comando
vim.api.nvim_create_user_command("UndoTree", M.show_undo_tree, {})
return M
