-- Mappings
-- ======================================
local map = require('modules.utils').map
local nmap = require('modules.utils').nmap
local is_available = require('modules.utils').is_available

-- Select All
nmap('n', '<C-a>', 'ggVG')

-- Save file
nmap('n', '<C-s>', ':w!<CR>')
nmap('i', '<C-s>', '<esc>:w!<CR>a')

-- Window Management
nmap('n', '<C-j>', '<C-w>j')
nmap('n', '<C-k>', '<C-w>k')
nmap('n', '<C-l>', '<C-w>l')
nmap('n', '<C-h>', '<C-w>h')
nmap('n', '<leader>q', ':q<CR>')
nmap('n', '<C-q>', ':qa!<CR>')

-- Buffer Management
nmap('n', '<leader>c', ':Bdelete!<CR>')


-- Packer Sync
map('n', '<leader>ps', ':PackerSync<CR>')


-- Plugins

-- File Explorer
if is_available('nvim-tree') then
  nmap('n', '<leader>e', ':NvimTreeToggle<CR>')
else
  nmap('n', '<leader>e', ':Vex<CR>')
end

