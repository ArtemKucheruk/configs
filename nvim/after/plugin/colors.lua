function ColorMyPencils(color)
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end


-- I need to fix the installation of rose-pine theme, cause I don't have it, and have an error here, hope that I will just create a colorschema and will forget about it
ColorMyPencils()
