-- Michael Stillwell Neovim Setup
-- ======================================
-- ======================================

-- TODO: seperate files
-- Files
require('plugins')


-- Settings
-- ======================================
-- ======================================

-- Leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '


-- Globals - vim.o
vim.o.timeoutlen = 500
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 10

-- Window - vim.wo
vim.wo.colorcolumn = '80,100'

-- Buffer - vim.bo
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
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

-- Bindings
-- ======================================
-- ======================================
local map = require('functions').map
local nmap = require('functions').nmap

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

-- File Explorer TODO: replace with nvim-tree
nmap('n', '<leader>e', ':Lex<CR>')

-- Packer Sync
map('n', '<leader>ps', ':PackerSync<CR>')


