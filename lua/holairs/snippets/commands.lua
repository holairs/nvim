-- lua/holairs/core/snippets.lua

-- lua/holairs/core/commands.lua

-- Definimos el contenido con valores genéricos
local razor_page_template = {
	"using Microsoft.AspNetCore.Mvc;",
	"using Microsoft.AspNetCore.Mvc.RazorPages;",
	"",
	"namespace Your.Namespace.Here", -- Valor genérico
	"{",
	"    public class MyPageModel : PageModel", -- Valor genérico
	"    {",
	"        public void OnGet()",
	"        {",
	"            ",
	"        }",
	"    }",
	"}",
}

-- Creamos el comando de usuario :NewPage
vim.api.nvim_create_user_command("Nrp", function()
	-- Inserta el texto en el buffer actual en la línea del cursor
	local current_line = vim.fn.line(".") - 1
	vim.api.nvim_buf_set_lines(0, current_line, current_line, false, razor_page_template)

	-- Mueve el cursor dentro del método OnGet
	-- La línea ahora es relativa a donde se insertó el texto
	vim.api.nvim_win_set_cursor(0, { current_line + 9, 12 })
end, {
	desc = "Inserta una plantilla de PageModel de Razor con valores genéricos",
})
