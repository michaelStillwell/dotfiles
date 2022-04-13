-- Bufferline config
-- ==================
-- TODO: research tabs and finish flushing this out
local nmap = require('functions').nmap

local status_ok, bufferline = pcall(require, 'bufferline')
if not status_ok then
    print ('[ERROR] bufferline failed to load')
    return
end

nmap('n', '<S-l>', ':BufferLineCycleNext<CR>')
nmap('n', '<S-h>', ':BufferLineCyclePrev<CR>')

bufferline.setup {
    options = {
        -- mode = 'tabs',
        offsets = {
            { filetype = 'NvimTree', text = 'File Explorer', padding = 1 }
        }
    },
    diagnostics = 'nvim_lsp'
}
