-- Michael Stillwell Neovim Setup
-- ======================================
-- ======================================

-- TODO: seperate files
-- Files
require('plugins')
require('configs.treesitter')
require('configs.telescope')
require('configs.nvimtree')
require('configs.bufferline')
require('configs.toggleterm')
require('configs.lsp')


-- Settings
-- ======================================
-- ======================================

-- Leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Colorscheme
local status_ok, k = pcall(require, 'gruvbox')
if status_ok then
    vim.cmd [[ colorscheme gruvbox ]]
else
    -- I don't actually like this color scheme, it's just very
    -- bright and noticeable that gruvbox isn't installed.
    vim.cmd [[ colorscheme blue ]]
end

-- Globals - vim.o
vim.o.timeoutlen = 500
vim.o.number = true
vim.o.relativenumber = true
local offset = 8 -- for bracket movement
vim.o.scrolloff = offset

-- Window - vim.wo
vim.wo.colorcolumn = '80,100'

-- Buffer - vim.bo
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.backup = false
vim.opt.cmdheight = 2
vim.opt.completeopt = { 'menuone', 'noselect' } -- TODO: research this
vim.opt.conceallevel = 0
vim.opt.fileencoding = 'utf-8'
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.updatetime = 300 -- TODO: mess with this
vim.opt.writebackup = false
vim.opt.cursorline = true
vim.opt.numberwidth = 4
vim.opt.signcolumn = 'yes'
vim.opt.wrap = false
vim.opt.sidescrolloff = 8


-- Mappings TODO: figure out why this breaks when moved
-- ======================================
local map = require('modules.utils').map
local nmap = require('modules.utils').nmap
local is_available = require('modules.utils').is_available

-- Select All
nmap('n', '<C-a>', 'ggVG')

-- Save file
nmap('n', '<C-s>', ':w!<CR>')
nmap('i', '<C-s>', '<esc>:w!<CR>a')

-- Movement
nmap('n', '{', offset .. 'k')
nmap('n', '}', offset .. 'j')

-- Window Management
nmap('n', '<C-j>', '<C-w>j')
nmap('n', '<C-k>', '<C-w>k')
nmap('n', '<C-l>', '<C-w>l')
nmap('n', '<C-h>', '<C-w>h')
nmap('n', '<leader>q', ':q<CR>')
nmap('n', '<C-q>', ':qa!<CR>')

-- Packer
nmap('n', '<leader>pc', ':PackerCompile<CR>')
nmap('n', '<leader>pi', ':PackerInstall<CR>')
nmap('n', '<leader>ps', ':PackerSync<CR>')
nmap('n', '<leader>pS', ':PackerStatus<CR>')
nmap('n', '<leader>pw', ':PackerUpdate<CR>')


-- Plugins

-- Nvimtree
if is_available 'nvim-tree' then
  nmap('n', '<leader>e', ':NvimTreeToggle<CR>')
else
  nmap('n', '<leader>e', ':Vex<CR>')
end

-- Telescope TODO: fill this out
if is_available 'telescope' then
  nmap('n', '<leader>ff', ':Telescope find_files<CR>')
  nmap('n', '<leader>fw', ':Telescope live_grep<CR>')
end

-- Bufferline
if is_available 'bufferline' then
  nmap('n', '<leader>c', ':Bdelete!<CR>')
end

-- Toggleterm TODO: see about doing the other maps from AV
if is_available 'bufferline' then
  nmap('n', '<C-\\>', ':ToggleTerm direction=float<CR>')
  nmap('n', '<leader>tf', ':ToggleTerm direction=float<CR>')
  nmap('n', '<leader>th', ':ToggleTerm direction=horizontal size=10<CR>')
  nmap('n', '<leader>tv', ':ToggleTerm direction=vertical size=80<CR>')
end
 
