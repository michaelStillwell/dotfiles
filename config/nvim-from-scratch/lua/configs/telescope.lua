-- Telescope config
-- ====================
local nmap = require('modules.functions').nmap


nmap('n', '<leader>ff', ':lua require("telescope.builtin").find_files()<CR>')
nmap('n', '<leader>fg', ':lua require("telescope.builtin").live_grep()<CR>')

local status_ok, telescope = pcall(require, 'telescope')
if not status_ok then
    print ('[ERROR] nvim-telescope not loaded')
    return
end

local actions = require('telescope.actions')
telescope.setup {
    defaults = {
        mappings = {
            i = {
                ['<C-j>'] = actions.move_selection_next,
                ['<C-k>'] = actions.move_selection_previous,

                ['<C-u>'] = false,
                ['<esc>'] = actions.close
            }
        }
    }
}
