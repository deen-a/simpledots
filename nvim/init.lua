----- DECORATIONS ------
-- Force transparent
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
-- Opaque Visual Highlighting
vim.api.nvim_set_hl(0, "Visual", { bg = "#3d59a1", fg = "none", bold = true })
------------------------


----- FUNCTIONAL -----
vim.opt.clipboard = "unnamedplus"
vim.opt.tabstop = 4 -- Spaces if <Tab> clicked
vim.opt.shiftwidth = 4 -- Auto indent spaces step
vim.opt.softtabstop = 4 -- Spaces to count while editing / visual mode
vim.opt.expandtab = true
