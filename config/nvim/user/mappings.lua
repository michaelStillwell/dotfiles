local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
map("n", "<C-a>", "ggVG", opts)

-- Set key bindings
map("n", "<C-s>", ":w!<CR>", opts)


-- Window Management
-- ===========================================

