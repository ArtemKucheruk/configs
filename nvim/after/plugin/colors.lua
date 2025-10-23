function ColorMyPencils(color)
    color = color or "onedark"  -- default theme if none specified
    
    -- Set transparent backgrounds
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    
    -- Syntax highlighting groups
    vim.api.nvim_set_hl(0, "Comment", { fg = "#6A9955", italic = true })
    vim.api.nvim_set_hl(0, "String", { fg = "#CE9178" })
    vim.api.nvim_set_hl(0, "Number", { fg = "#B5CEA8" })
    vim.api.nvim_set_hl(0, "Boolean", { fg = "#569CD6" })
    
    -- Keywords and control flow
    vim.api.nvim_set_hl(0, "Keyword", { fg = "#C586C0" })
    vim.api.nvim_set_hl(0, "Function", { fg = "#DCDCAA" })
    vim.api.nvim_set_hl(0, "Identifier", { fg = "#9CDCFE" })
    
    -- Types and classes
    vim.api.nvim_set_hl(0, "Type", { fg = "#4EC9B0" })
    vim.api.nvim_set_hl(0, "StorageClass", { fg = "#C586C0" })
    
    -- Visual aids
    vim.api.nvim_set_hl(0, "CursorLine", { bg = "#2C313C" })
    vim.api.nvim_set_hl(0, "LineNr", { fg = "#858585" })
    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#D4D4D4" })
    
    -- Search and selection
    vim.api.nvim_set_hl(0, "Search", { bg = "#613214" })
    vim.api.nvim_set_hl(0, "IncSearch", { bg = "#613214", fg = "#FFFFFF" })
    
    -- Status line and tabs
    vim.api.nvim_set_hl(0, "StatusLine", { bg = "#2C313C", fg = "#D4D4D4" })
    vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "#1E1E1E", fg = "#858585" })
    
    -- Pmenu (completion menu)
    vim.api.nvim_set_hl(0, "Pmenu", { bg = "#1E1E1E", fg = "#D4D4D4" })
    vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#264F78" })
    
    -- Visual mode
    vim.api.nvim_set_hl(0, "Visual", { bg = "#264F78" })
    
    -- Error and warning
    vim.api.nvim_set_hl(0, "Error", { fg = "#F44747" })
    vim.api.nvim_set_hl(0, "Warning", { fg = "#FF8800" })
    
    -- Diff
    vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#144212" })
    vim.api.nvim_set_hl(0, "DiffChange", { bg = "#2B3B4A" })
    vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#4D1F1F" })
    
    print("Color scheme enhanced!")
end

-- I need to fix the installation of rose-pine theme, cause I don't have it, and have an error here, hope that I will just create a colorschema and will forget about it
ColorMyPencils()
