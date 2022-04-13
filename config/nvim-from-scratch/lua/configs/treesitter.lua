-- Treesitter config
-- ===================

local ts_configs = require'nvim-treesitter.configs'
ts_configs.setup {
    -- TODO: decide if all needs to be installed
    ensure_installed = 'all',
    highlight = {
        enable = true,
    },
    index = {
        enable = true,
    }
}

vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldmethod = 'expr'
